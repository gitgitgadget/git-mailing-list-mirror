Return-Path: <SRS0=jwDG=D4=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2659FC4363A
	for <git@archiver.kernel.org>; Wed, 21 Oct 2020 22:22:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 93BB3241A6
	for <git@archiver.kernel.org>; Wed, 21 Oct 2020 22:22:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=protonmail.com header.i=@protonmail.com header.b="RiV+4vIn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2506636AbgJUWWN (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 21 Oct 2020 18:22:13 -0400
Received: from mail-03.mail-europe.com ([91.134.188.129]:38864 "EHLO
        mail-03.mail-europe.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2506629AbgJUWWN (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Oct 2020 18:22:13 -0400
Date:   Wed, 21 Oct 2020 22:21:59 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=protonmail; t=1603318929;
        bh=tXTp1lyzz3whaxVJBQG1cioau88e/4YZzpbTv0Wq2as=;
        h=Date:To:From:Cc:Reply-To:Subject:In-Reply-To:References:From;
        b=RiV+4vIn2Rbs6vQk13i594PWJk9kU/2pVASHCkRq69vWEkU9e6CMl1IEJ7r6+AgQJ
         dj6ZINHTmSA/1Zy7xDhZJtmx1bgNb7XWNqTyQ/rdWLjLwHNZltSQXAIf6OFtSL2Ov4
         gSvvBXTcaGiSfgIjikRE8Xwe3CcD7H17JwgYt4oI=
To:     Junio C Hamano <gitster@pobox.com>
From:   Joey Salazar <jgsal@protonmail.com>
Cc:     Phillip Wood <phillip.wood123@gmail.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Reply-To: Joey Salazar <jgsal@protonmail.com>
Subject: Re: [OUTREACHY][PATCH v2] t7006: Use test_path_is_* functions in test script
Message-ID: <-fqjNpjuA1NlG29AeRtBDgTHlHbtljRImPvtORqdjK7QXE7fOn8GyzCWlgYj-eZvfj_sNPuCjHoh70xUyfusx1myQYR9HzfiM14M-96cBL0=@protonmail.com>
In-Reply-To: <xmqqft675jjv.fsf@gitster.c.googlers.com>
References: <KHJW7elqEfVsIp1V0WKPRVAB5xqCDJjjqLv8flthlDiSsSWjND-VVGG2zL-xOYMstk-q0JR3OiSggcMlFgzkIKm2podjzAyamb0pW-wx1ZY=@protonmail.com> <fc5fecec-1a77-871d-d1f9-dad1bae8920c@gmail.com> <xmqq4kmn8lpp.fsf@gitster.c.googlers.com> <CEI_CVj6T-VEnw0cl0U6E5BSJ3Z6ZdYXAwnV96r8u0qbLK3EgS3b0Sqan1D_AgNqPm22FGPSL_easRZyLukEAIbbVCvxsiC9QVawVJBiTbI=@protonmail.com> <xmqqft675jjv.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Will do, thank you.



=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90 Original Me=
ssage =E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90
On Wednesday, October 21, 2020 3:57 PM, Junio C Hamano <gitster@pobox.com> =
wrote:

> Joey Salazar jgsal@protonmail.com writes:
>
> > Hi Phillip, Junio,
> > Thank you for your reviews and support, they're much appreciated and I'=
m happy the patch looks ok.
> >
> > > I'll probably have to hand-edit the authorship before applying
> > > (check the From: of the e-mail) so that the identity on the
> > > signed-off-by trailer matches the author, but other than that the
> > > patch looks quite good to me, too.
> >
> > My big apologies Junio, I mistook "authorship" to mean my `git config -=
-global user.name` and `git config --global user.email` settings.
> > Should I resend the patch email?
>
> No need to apologize and no need to resend. You may want to send a
> patch to yourself to prepare your procedure, but that is something
> you can do without sending patches to the list.
>
> Thanks.


