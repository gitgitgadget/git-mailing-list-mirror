Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 61D2A1F404
	for <e@80x24.org>; Thu, 25 Jan 2018 00:31:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932507AbeAYAbr (ORCPT <rfc822;e@80x24.org>);
        Wed, 24 Jan 2018 19:31:47 -0500
Received: from mail-vk0-f41.google.com ([209.85.213.41]:42629 "EHLO
        mail-vk0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932250AbeAYAbq (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Jan 2018 19:31:46 -0500
Received: by mail-vk0-f41.google.com with SMTP id t4so3765305vkb.9
        for <git@vger.kernel.org>; Wed, 24 Jan 2018 16:31:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=atlassian-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=mtYSBGA5PJ+FzP5usbTqntABbADEjGDzD6HSTUl30YQ=;
        b=MtuGD4MCsyRpMI/6Ie7dR97bih664vl/wT/CAtzD6tNpXOl8suZkfYs5o7U6p/QKD0
         M8NbtcsYN4YRiR8/K7gQnUhUEwLtabeTvW3ruWRlNteEWETMmy9vYdGM2z2I3oPpPfws
         dSxFbuTYIpWLa4tAnS9GWO+1IoM59D6XOQxmoYGJkFyTg8Qjhwx3Rs6FXd22J/2Cl4LY
         tNHgyVUrDAyxhCDAAu78mpAv5tP5E7y2w3JeMly47KzYNeI1K9LSDTsfuYCUt++pcNM1
         Wtc53tud7t0GJPcME7GSJDZ45vtP8rnGrntID6ZqZt0cC3v2L48eAoi/q4Z1AzApO8QX
         3RUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=mtYSBGA5PJ+FzP5usbTqntABbADEjGDzD6HSTUl30YQ=;
        b=PqG4vgSYpYNgPAi+R+Z8wJrHjAt6EM97v5TmKul5ENYzSx6VUqzE39875mH08FGiaJ
         LbVMFmTNvSOYLS0jX0I0gFz+3sWsPXBEqQHzP0rwbJdYZQA5hTVdlkQYQo0CosAooVwF
         VL4xx/XgFwh0D6CSL5vIlPTCgIK/R16fzdocVFY5NUhZP5TruOhY7GGJTWS+JDNPeXfa
         szdD0tja2QD2ciPvxPdGVQ6KT6yZ8IdyxaH0u1s9254OcxL6/s2Mh+xerM07YAemuejn
         7YltUaBAEFwqQOuXiexDht/xz1gt/BSdm4XnZDpiRpttYk6+VY07SJJOvZldldVgQLRv
         48zQ==
X-Gm-Message-State: AKwxytdL18pxG/J9HFinzEAh/5EfDGs+rfuj23RHXFZWerbvO1UDIhvx
        YXRBm3zmID4/MLr2eOu59pA0Yno6zLwj5pnRcE6CoA==
X-Google-Smtp-Source: AH8x225ylxspMrIswFo0fztvY2I4+hRd/B4m2Yi1tmQp19YLCtc58OB7WjLXhODiQ5xnOIak1znYS0UwuImjwEeNtoo=
X-Received: by 10.31.94.207 with SMTP id s198mr6001598vkb.23.1516840305772;
 Wed, 24 Jan 2018 16:31:45 -0800 (PST)
MIME-Version: 1.0
Received: by 10.176.2.237 with HTTP; Wed, 24 Jan 2018 16:31:45 -0800 (PST)
In-Reply-To: <CAM2y_jWnpDSA8kE+9z1jKW0dCzjOz053HrD479qc0ZjL13Gabw@mail.gmail.com>
References: <CAM2y_jWnpDSA8kE+9z1jKW0dCzjOz053HrD479qc0ZjL13Gabw@mail.gmail.com>
From:   Bryan Turner <bturner@atlassian.com>
Date:   Wed, 24 Jan 2018 16:31:45 -0800
Message-ID: <CAGyf7-Hb+w23sbW8rZxmLXBDO-+kBDFwirN3siSNwveYdX4qPg@mail.gmail.com>
Subject: Re: git 2.16, Jenkins git client plugin, and ""
To:     Mark Waite <mwaite@cloudbees.com>
Cc:     Git Users <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jan 24, 2018 at 3:55 PM, Mark Waite <mwaite@cloudbees.com> wrote:
> It appears that git 2.16.0 and 2.16.1 have introduced a change which
> surprises the Jenkins git client plugin.
>
> Git 2.16.0 and 2.16.1 on Linux both report "fatal: ssh variant
> 'simple' does not support setting port" when used in the context of
> the Jenkins git client plugin.

We noticed a similar issue in Bitbucket Server's tests, related to us
using a wrapper script with the GIT_SSH variable. Some further
discussion is available in [1].

>
> The solution we've accepted into the git client plugin source code is
> to set the environment variable "GIT_SSH_VARIANT=3Dssh".  That allows
> the failing case to pass, and does not seem to harm older versions of
> git.
>
> The documentation at https://git-scm.com/docs/git says that
> GIT_SSH_VARIANT "overrides Git=E2=80=99s autodetection whether
> GIT_SSH/GIT_SSH_COMMAND/core.sshCommand refer to OpenSSH, plink or
> tortoiseplink."
>
> I haven't seen the same message from Git 2.16.1 for Windows.

Our Windows builds didn't seem to fail for this either, which was interesti=
ng.

>
> The Jenkins bug report
> (https://issues.jenkins-ci.org/browse/JENKINS-49111) describes the
> user experience.
>
> Is the GIT_SSH_VARIANT solution expected to be used by git consumers
> like the Jenkins git client plugin when passing credential information
> through environment variables like SSH_ASKPASS?

The expectation seems to be that if you use GIT_SSH or
GIT_SSH_COMMAND, you'll also use GIT_SSH_VARIANT to tell Git what to
expect, because it doesn't (shouldn't?) make assumptions, starting in
2.16, that your custom SSH uses OpenSSH syntax.

>
> I see "ssh", "plink", and "tortoiseplink" as values of GIT_SSH_VARIANT
> used in tests, and "auto", "putty", and "simple" used in the source
> code in addition to "ssh", "plink", and "tortoiseplink".  What are the
> allowed values for GIT_SSH_VARIANT?
>
> What is the recommended value so that the Jenkins git client plugin
> can remain most compatible with previous behavior?

"ssh" is probably the most compatible, because I'm pretty sure prior
to 2.16 that behavior was the assumed behavior.

>
> No value was assigned previously to GIT_SSH_VARIANT in the Jenkins git
> client plugin.  I was expecting that git would choose "ssh" as the
> default value for GIT_SSH_VARIANT, rather than apparently choosing
> "simple".
>
> Is this a bug, or is this the new, intentional behavior of git?

It's intentional. There was some discussion (again, see [1]) about
whether the change needed further changes, but it doesn't appear any
further changes were made.

>
> Thanks,
> Mark Waite

[1]: https://public-inbox.org/git/CAGyf7-FQp4q2vvH1ponQvmVDTu0hiMSK1JKytQZ4=
O1i0MCnz7g@mail.gmail.com/

Hope this helps!
Bryan
