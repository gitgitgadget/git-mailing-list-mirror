Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B957820357
	for <e@80x24.org>; Fri, 14 Jul 2017 14:34:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754424AbdGNOeK (ORCPT <rfc822;e@80x24.org>);
        Fri, 14 Jul 2017 10:34:10 -0400
Received: from mail-it0-f47.google.com ([209.85.214.47]:35237 "EHLO
        mail-it0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754381AbdGNOeI (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Jul 2017 10:34:08 -0400
Received: by mail-it0-f47.google.com with SMTP id v202so22679044itb.0
        for <git@vger.kernel.org>; Fri, 14 Jul 2017 07:34:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=illinois-edu.20150623.gappssmtp.com; s=20150623;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=zPc/3SlsFV06FhhOgW+WkBqt0EW+wVu6I7y8UfePMNY=;
        b=C3hiY9t/Q+lzA5a+ifE2JIN6MkVQUju8xNClTfmQ6BrpwlJe9nf3jKJt9fBoNpnwud
         wKbidjgOI0mPj7lt0KLOU3IqnDf8ext3LnNyOtkfrlSUhhulnlUkp32LDm6Cs8Bz0aL+
         Jmo6OKq7S2ebVP8Ua5tZxYp3AxwS0lLzeshqPPAmYdIBHf3Zvlq91tOWWHrWWwN5Yavp
         iRRI32MYU1ajC3JlaNZJKWylNeyXgKrsxNn4qa2stTvyeH25h4VXrZPWNlt/YpU1jygv
         rd1CXjSKtbeLej3EbMdcO85+2VIR27Kid9tweuZcP6YSrN9OfOmoU39FmnzFgTsxC400
         nJig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=zPc/3SlsFV06FhhOgW+WkBqt0EW+wVu6I7y8UfePMNY=;
        b=OOSab7JJcT97MhCRjmWcuyEplO7BFC3+9i+NmcLGCuDKEZWAGrLBV1ChIAnaLRRAfO
         2aNW1GpJFK1ONUkNQ5ZqQrjJVuKMJtzcM6a64dK9+JeSilcBmPs9QdJzR1rotxetgqes
         NPCqfYqRPEd4x0/Brr9r74Aq4h08EWzjCKRdOkmRrEhZsPxREboIVSA+x2dIHUqcQEI+
         B7xngRwhbgDVAcAWhTGWn5UQJGqKOD5m8E1j9D/mK4sBY5kbeEICsQIhn08D4RZO+eQL
         HEvLYMIj34o6tryRWPzSOXLk4BrpRWnUuy8HMSuvsozNT054mC1dhQ76oODI9U7ETRWw
         RMQw==
X-Gm-Message-State: AIVw113csho+8sxC8PCts1xDEhVRQRRFWSlNBuvfLEv9W7N+pITcdvwe
        sNsygx0Eg3VLxbn19TvloXUgkCcy2Nu+
X-Received: by 10.36.107.214 with SMTP id v205mr3966522itc.33.1500042842905;
 Fri, 14 Jul 2017 07:34:02 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.34.16 with HTTP; Fri, 14 Jul 2017 07:34:02 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.21.1.1707141625150.4193@virtualbox>
References: <CAAu0pLedy5xqUgF7drMf=tQgMJD4rXq+JvKaiE54EdRFZWuTkQ@mail.gmail.com>
 <alpine.DEB.2.21.1.1707141625150.4193@virtualbox>
From:   Kavita Desai <kvdesai2@illinois.edu>
Date:   Fri, 14 Jul 2017 09:34:02 -0500
Message-ID: <CAAu0pLdmGc_kq_w0Fm6W4XDqOe=iKSyAyLct+yH6y+7FPUHtnA@mail.gmail.com>
Subject: Re: Git Bash Bug
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Sorry for not being specific. What I meant by not working was that the
bash commands are not found.
Here is an example

$ ls
bash: ls: command not found

Kavita

On Fri, Jul 14, 2017 at 9:28 AM, Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
> Hi Kavita,
>
> On Fri, 14 Jul 2017, Kavita Desai wrote:
>
>> Originally, when I first had Git Bash everything was working
>> perfectly. Randomly one day, my bash commands were not working.
>
> There are a gazillion ways how commands can "not work". You *need* to be
> more specific here. In the least, a precise pasted output of a failed
> command is necessary.
>
> In addition, a couple of other points of interest would be good to know,
> the issue reporting template at
> https://github.com/git-for-windows/git/issues/new tries to help you
> provide as much important information as you can. Maybe give it a try?
>
> Ciao,
> Johannes



-- 
Kavita Desai
UIUC Engineering Physics 2018
Engineering Outreach Society Engineering Open House Chair
UIUC Housing Ike. South Front Desk Clerk
