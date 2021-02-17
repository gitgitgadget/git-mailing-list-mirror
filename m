Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E730C433DB
	for <git@archiver.kernel.org>; Thu, 18 Feb 2021 00:01:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 627BF64E68
	for <git@archiver.kernel.org>; Thu, 18 Feb 2021 00:01:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229862AbhBRABS (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 17 Feb 2021 19:01:18 -0500
Received: from mail-02.mail-europe.com ([51.89.119.103]:49948 "EHLO
        mail-02.mail-europe.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229707AbhBRABQ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 Feb 2021 19:01:16 -0500
Date:   Wed, 17 Feb 2021 23:59:47 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=protonmail; t=1613606388;
        bh=PeMHVkro/hFb+1JDYIxS9yy848qlG0tVzsVoiM4XwYg=;
        h=Date:To:From:Cc:Reply-To:Subject:In-Reply-To:References:From;
        b=bARjyNtOSJFep6fWVNkGPIZE/+/y/FUbpUnXHj5fDtiQ12Q7aKOMHsdoT3tt9IEEa
         HD84e0PfkVh/JGlK+EaXnrmz4txqjPIhkvKcNlHAhImudw2gU/uHmH0yIbhlttfx0+
         DYgr8L9x17u54ARNEV3IInljGluuWkfzleAuQrco=
To:     Denton Liu <liu.denton@gmail.com>
From:   Joey Salazar <jgsal@protonmail.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>
Reply-To: Joey Salazar <jgsal@protonmail.com>
Subject: Re: [OUTREACHY][PATCH v1] doc: fix naming of response-end-pkt
Message-ID: <mFXIveS58B7aSefQQEpY87ZyWBBrDhKPgOyEdriyZiD3Dn61_bhvLaJbjzGFRnX0rX7Zjvvxqobf684akMJYjd6qpFBVVMjwtKoFA2hSO_k=@protonmail.com>
In-Reply-To: <YCz4+xPVyL+hTZzR@generichostname>
References: <5qGT6uzPLUGN2DXCMTzhixEhKHwaT6hODaOHQ485sfCROycrTDPx6P2Nd5dOy4J-gnhb_lKpxW4jJqhut-4gmoeIyuhpqbA5fXCeHoKHrK8=@protonmail.com> <YCz4+xPVyL+hTZzR@generichostname>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Denton,

On Wednesday, February 17, 2021 5:07 AM, Denton Liu wrote:

> Hi Joey,
>
> A couple of aesthetic details: I see that these changes are based on MR
> !1922 so if you decide to take these suggestions, you'll probably need
> to apply them there too.
>
> 1. It'd probably read better as "Response End Packet" (with the
> "e" capitalised)
>
> 2. The mix of underscore and hyphen in response_end-pkt is a
> little odd, although I see that you've done it to make it
> match the surrounding code[3].

Well noted, I'll follow up shortly with PATCH v2 to incorporate both change=
s.

Thank you,
Joey
