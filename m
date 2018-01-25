Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 96F431F404
	for <e@80x24.org>; Thu, 25 Jan 2018 00:36:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932840AbeAYAgj (ORCPT <rfc822;e@80x24.org>);
        Wed, 24 Jan 2018 19:36:39 -0500
Received: from mail-qt0-f178.google.com ([209.85.216.178]:33682 "EHLO
        mail-qt0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932250AbeAYAgi (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Jan 2018 19:36:38 -0500
Received: by mail-qt0-f178.google.com with SMTP id d8so15245471qtm.0
        for <git@vger.kernel.org>; Wed, 24 Jan 2018 16:36:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudbees.com; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=D5io3OJ0I7/hSC2hh4uLXsA5XVWj5U9AOJz1AjMd/Tk=;
        b=DB6hcflq4VlTNfikdnd5Q+sX0dGV4p625vL94/kxrwJTnNc3e0V1nQGYZEHmQzvkQG
         eVQYGV42RWcUzKxMFc/3USF3rCV+UlckpxfPm0e6A1bu1acMQMW8vfPqB6zzrTOzs2a7
         pYULiuVtmOaR7TjvY7/xzdY9OGl0MdZqozC5o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=D5io3OJ0I7/hSC2hh4uLXsA5XVWj5U9AOJz1AjMd/Tk=;
        b=FknrURn6mff+Fp+SSaOpxO/KBhY0/0dyP+wM/qVTjiaet/yk6ffSaMfpSzbUEaw+Bu
         CGhamXYxGqRIhsNGKD2AkYaMwe4u/54T3jn4FXfnXBVq4S94rgdSXL8t4pLFNVkrn80G
         BlRB6D6N7bD43QRjcPZKwmaTIKW0xY1Kt0GrIWxuVh6QOTqWkhs6vq2oHPSN3xozsYPX
         2snm4HU3uNsTCxj+t0+eqdnQHrS0xb/+mCxLz+I3BcyB1Rnw+N9mf2W2BKLy9flGMdUn
         OB6IW9MvyAjx5TVaRq+3PI+dZ4UWj6bsrIUlJJpm02kmiJWiMdRLnzKTEfK4n6/dpRKR
         AlHQ==
X-Gm-Message-State: AKwxytfBdXiHUaaezpR7JRpkcfOaKQ7IHwOF4IwjvrGmjcfigjtCMNbR
        ENPvry3UANt5Edk/F0YPpwVilG7yurBTkv2jvOB4/Q==
X-Google-Smtp-Source: AH8x224vkQCaaAmCbXgZHeWlvwH/eUPPJ65iIIFDPqLJhOsEqYfQONW22qScBEiesQu49qOhAtxDK1uNmq1oViNO3HM=
X-Received: by 10.237.50.197 with SMTP id z63mr13234885qtd.212.1516840597718;
 Wed, 24 Jan 2018 16:36:37 -0800 (PST)
MIME-Version: 1.0
Received: by 10.140.81.84 with HTTP; Wed, 24 Jan 2018 16:36:37 -0800 (PST)
In-Reply-To: <CAGyf7-Hb+w23sbW8rZxmLXBDO-+kBDFwirN3siSNwveYdX4qPg@mail.gmail.com>
References: <CAM2y_jWnpDSA8kE+9z1jKW0dCzjOz053HrD479qc0ZjL13Gabw@mail.gmail.com>
 <CAGyf7-Hb+w23sbW8rZxmLXBDO-+kBDFwirN3siSNwveYdX4qPg@mail.gmail.com>
From:   Mark Waite <mwaite@cloudbees.com>
Date:   Wed, 24 Jan 2018 17:36:37 -0700
Message-ID: <CAM2y_jUOOJhf6Cy3e5GosB7ZJXRh1b8XBH8H5xCw-d7uXd=9-w@mail.gmail.com>
Subject: Re: git 2.16, Jenkins git client plugin, and ""
To:     Bryan Turner <bturner@atlassian.com>
Cc:     Git Users <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jan 24, 2018 at 5:31 PM, Bryan Turner <bturner@atlassian.com> wrote:
> On Wed, Jan 24, 2018 at 3:55 PM, Mark Waite <mwaite@cloudbees.com> wrote:
>> It appears that git 2.16.0 and 2.16.1 have introduced a change which
>> surprises the Jenkins git client plugin.
>>
>> Git 2.16.0 and 2.16.1 on Linux both report "fatal: ssh variant
>> 'simple' does not support setting port" when used in the context of
>> the Jenkins git client plugin.
>
> We noticed a similar issue in Bitbucket Server's tests, related to us
> using a wrapper script with the GIT_SSH variable. Some further
> discussion is available in [1].

Thanks for the confirmation!

>> Is the GIT_SSH_VARIANT solution expected to be used by git consumers
>> like the Jenkins git client plugin when passing credential information
>> through environment variables like SSH_ASKPASS?
>
> The expectation seems to be that if you use GIT_SSH or
> GIT_SSH_COMMAND, you'll also use GIT_SSH_VARIANT to tell Git what to
> expect, because it doesn't (shouldn't?) make assumptions, starting in
> 2.16, that your custom SSH uses OpenSSH syntax.

That seems sensible.  There are other areas in the plugin which assume
OpenSSH syntax, so it is fair to make it explicit in the plugin.

We'll proceed with GIT_SSH_VARIANT=ssh.

>> Is this a bug, or is this the new, intentional behavior of git?
>
> It's intentional. There was some discussion (again, see [1]) about
> whether the change needed further changes, but it doesn't appear any
> further changes were made.

Thanks very much!

>>
>> Thanks,
>> Mark Waite
>
> [1]: https://public-inbox.org/git/CAGyf7-FQp4q2vvH1ponQvmVDTu0hiMSK1JKytQZ4O1i0MCnz7g@mail.gmail.com/
>
> Hope this helps!
> Bryan

-- 
Mark Waite
