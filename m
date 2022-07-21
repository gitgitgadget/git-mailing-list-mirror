Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56DF9C433EF
	for <git@archiver.kernel.org>; Thu, 21 Jul 2022 18:06:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232441AbiGUSGy (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 21 Jul 2022 14:06:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229992AbiGUSGx (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Jul 2022 14:06:53 -0400
Received: from mail-oa1-x33.google.com (mail-oa1-x33.google.com [IPv6:2001:4860:4864:20::33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1E7F89A41
        for <git@vger.kernel.org>; Thu, 21 Jul 2022 11:06:52 -0700 (PDT)
Received: by mail-oa1-x33.google.com with SMTP id 586e51a60fabf-10cf9f5b500so3468868fac.2
        for <git@vger.kernel.org>; Thu, 21 Jul 2022 11:06:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ostif-org.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qntWBDMsdMRKWc+w5F1/OTZDQm9GZx1PwC3PqysOI34=;
        b=TUOpEbj8K8w+CsDBY7efV27LVmHceS4fp6ueAGu6/OGpsGHkGINn8U9inqeWZ7Oc2H
         gJgSjQbINGsXklSvn0SjIz+J3TQYS1AHoGG7TryX44tRUg4fcyJH03ZX0exFyQ95xkID
         2CijJ+qJua0Wxe2srfVSx5OGogDMTjhtQ9nJCyTbxG3db8pExeWVEmLGvZblVsqbTPKU
         6pi3R3rBQoeM/FJgCDNHQZEX8X02qsyhOs+CBRnjJj4A9q8/PwVvatm2zfQZNErLxMtg
         bz+Wn4BKg0+rzFlPv5Wkv3g0eyGA7PlGKPP8/pywR+EXnfIDFvw60K0Zxw1vnoL5Qn/n
         F0Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qntWBDMsdMRKWc+w5F1/OTZDQm9GZx1PwC3PqysOI34=;
        b=fV+a9DIjJjsH4UCL/o25qgCabS7diPnpBrj4qCl8WF77P0Vk+NQtZxY8yZWZxBX6Fz
         AevG2Wz7Ef3a+EOxOHYNjwPN9AkMgkAtqkO40+xYGulFxPDiQV//H6Sj601g/itVoapr
         SrHuwx7nqLwnRhnWSZeIQKe/DagZy4uNWS4vX2fzfntONMrCQUxVBG6Fqg98XbAmPege
         F3BmJ9xp2ucptYXQCVCfTtq+BAcb0wlGCXjPbeg3i6v0fwJY9SvA+NfUSgbZ4Wyu7rix
         xdz4daIqV7I6sNj9+aMQDTpRQRlqOEAvRh+y6DhiS+KCdp35DlgK7RVkmd7MZRWBpfxM
         sPPA==
X-Gm-Message-State: AJIora//C4j9mGlO7NhPSJPxafD52S/dHPB7o/PqhPP3LgiEWX2zD5ZS
        fwhx+VuS+R3D3St0+VTu21vFCY22Bmxt9X+3FDpDJz61vGRXXA==
X-Google-Smtp-Source: AGRyM1v08pTF5raK/52r4o3d2rdB+YTV+WunFOCaNSeNN7wZCgtyd4qXBI1a0csQA1tjrgKKYkOy3wNjDe7hYI+RI18=
X-Received: by 2002:a05:6870:c1cd:b0:fe:1295:6e34 with SMTP id
 i13-20020a056870c1cd00b000fe12956e34mr5871925oad.137.1658426812158; Thu, 21
 Jul 2022 11:06:52 -0700 (PDT)
MIME-Version: 1.0
References: <CADKuG0uzh3syzgfiPLepiTLXNzkoYhLFX1h-DE3C7c8j6HXALQ@mail.gmail.com>
 <xmqq8romicil.fsf@gitster.g>
In-Reply-To: <xmqq8romicil.fsf@gitster.g>
From:   Amir Montazery <amir@ostif.org>
Date:   Thu, 21 Jul 2022 13:06:41 -0500
Message-ID: <CADKuG0vVGsC9tFr8bUrC48yhhkyg0Rrafyf39TYhPNXE1ak6mA@mail.gmail.com>
Subject: Re: Coordinated Security Audit for git. Contacts needed
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thank you for the reply and information Junio.

Apologies for the mixup. I thank the community members for your time
and consideration. If anyone is interested in providing some direction
or help with the source code review, supply chain security, or
customizing a new setup of CodeQL for git, please let me know. I
understand you're all likely very busy so we will keep it as brief as
possible. I can be reached at amir@ostif.org.

Thank you again. Hope everyone's summer is going well!


On Thu, Jul 21, 2022 at 12:47 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> Amir Montazery <amir@ostif.org> writes:
>
> > We would love to collaborate to establish communication channels with
> > key maintainers. Would it be possible for one of us to join one of
>
> We do not call people "maintainers", but "developers" and/or
> "contributors".
>
> > your community meetings for 5 minutes? Or is there a key person we
> > should be engaging?
>
> There is no "community meetings" other than the informal "stand-up"
> irc discussion that is biweekly.  The log of the latest is at
> https://colabti.org/irclogger/irclogger_log/git-devel?date=2022-07-18
> but generally speaking we are not into "synchronous" communication.
>
> You come to this mailing list and start talking, and that is how you
> are heard by community members, which you're already doing fine ;-).
>
> In case you are not familiar with Git, you can see output from
>
>         git shortlog --no-merges -s -n --since=2.years | head
>
> to see who have been the active contributors.
>
> Thanks.
>


-- 
Amir Montazery
Managing Director
Open Source Technology Improvement Fund
https://ostif.org/
https://calendly.com/ostif
