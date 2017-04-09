Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0981F20966
	for <e@80x24.org>; Sun,  9 Apr 2017 07:27:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751814AbdDIH1u (ORCPT <rfc822;e@80x24.org>);
        Sun, 9 Apr 2017 03:27:50 -0400
Received: from mail-vk0-f48.google.com ([209.85.213.48]:35495 "EHLO
        mail-vk0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751539AbdDIH1u (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 9 Apr 2017 03:27:50 -0400
Received: by mail-vk0-f48.google.com with SMTP id r69so96510507vke.2
        for <git@vger.kernel.org>; Sun, 09 Apr 2017 00:27:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=DUQV82fXYsSgejKcyGOiBdJkETWcj3qdLTLdkCVq964=;
        b=qQUWBce4wl3kQBIUltmLyYjU7Qc3ybF75eK8sy2iQ1iUYHWaLvmv07WYwdX9PnbhY6
         HeD6ixi0WBFMOtCatUop48DGIptjX7m3w7EYfSM2jp8Jl61RcaB1WmXd0UceI65n/jtl
         KXIeX6+n4pbzay7nXU/xUM8nYNe73IYiGwqee14l3+CV4cEyakPdUsBi10bITM5e6sc5
         rftEmU8y15+V+iB3gmvF8tIjXIlAoi9FXxQ8vGgKJV9MmjM6Ei2+ZOhqGX3p/rpgpIqR
         fB9YiiyL9o3jYnZglPIpCDfNRy5WAybuhH2VTvqNPj6JxKxRV+4ieubktFSgh/CJrKih
         gtfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=DUQV82fXYsSgejKcyGOiBdJkETWcj3qdLTLdkCVq964=;
        b=pkRJu3lG/oNLawBZ/6s9ZrOvG6t7j6RFjb4ZXQD9YKvlKxQZLHNll+Gw0MrR7gvFKf
         IATqdO7TKzQJbCoaJIXuGTOYONBl2c3jSkmBxLnUcdBu8Ioz3V9Nnc83sK/ALp2mPltP
         1UQZ74jE1Atpn/rURktti1BTSrYU37XHX4RnFA3Y3/foytOweJESuaYR4odQ7SegBgup
         ow080nowpei1DKO0jEiyf704B0kroh8lHK/GoYGukmEDuSYn+oxvoHYuiOAA5QLiJyO9
         q3tVygx0pl8TJGmyY/Nvn+fGS75e1KJjrBHwrhrA2Q7RsflxuKGrTvRjm/TCOEd1YVSu
         c5xQ==
X-Gm-Message-State: AFeK/H2F9wMu3OvjRIot+mIR4YOnWudk62hhDZZm1XyltwMKWXu9oxTEuu2Azc29XEK06yMsEYD5EngWTngyXQ==
X-Received: by 10.31.161.205 with SMTP id k196mr18087382vke.170.1491722869348;
 Sun, 09 Apr 2017 00:27:49 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.176.4.14 with HTTP; Sun, 9 Apr 2017 00:27:28 -0700 (PDT)
In-Reply-To: <20170317165335.GM26789@aiede.mtv.corp.google.com>
References: <e7d6f518-51aa-92fa-e685-7cde019d6e5b@gmail.com> <20170317165335.GM26789@aiede.mtv.corp.google.com>
From:   =?UTF-8?Q?Florian_Sch=C3=BCller?= <florian.schueller@gmail.com>
Date:   Sun, 9 Apr 2017 09:27:28 +0200
Message-ID: <CAHdOBFpGsL7k4Y_=g83zveichoRhe+yLGukBG7ybrO6VrN=iBw@mail.gmail.com>
Subject: Re: why patch to the gitk no replay?
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     yanke131415 <yanke131415@gmail.com>, git@vger.kernel.org,
        Paul Mackerras <paulus@ozlabs.org>,
        Paul Mackerras <paulus@samba.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

My patch submission (already the retry) "[PATCH 0/4] Gitk Inotify
support" is also pending since 8th of March.
I'm also not sure what I did wrong as I'm not used to those mailing
list programming - or if Paul is just very busy

On Fri, Mar 17, 2017 at 5:53 PM, Jonathan Nieder <jrnieder@gmail.com> wrote:
> Hi,
>
> yanke131415 wrote:
>
>>     I send a patch to gitk
>> project(git://ozlabs.org/~paulus/gitk)with the target email address
>> paulus@ozlabs.org. But several days later No replay of this patch i
>> receive, is the  email address i send patch wrong? Anyone who knows?
>
> Sending to this mailing list (and cc-ing Paul) is more likely to work.
>
> Hope that helps,
> Jonathan
