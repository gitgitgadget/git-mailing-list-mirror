Return-Path: <SRS0=bfGv=CG=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33AEEC433E2
	for <git@archiver.kernel.org>; Fri, 28 Aug 2020 01:57:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0584A2080C
	for <git@archiver.kernel.org>; Fri, 28 Aug 2020 01:57:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=cmpwn.com header.i=@cmpwn.com header.b="shvvmmP1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728015AbgH1B5J (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 27 Aug 2020 21:57:09 -0400
Received: from mail.cmpwn.com ([45.56.77.53]:48296 "EHLO mail.cmpwn.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726147AbgH1B5J (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Aug 2020 21:57:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=cmpwn.com; s=cmpwn;
        t=1598579828; bh=JHW43QfJ/EowQzj9SWL1ZUzmF1DVesLCWUS0fd7IdpQ=;
        h=Subject:From:To:Cc:Date:In-Reply-To;
        b=shvvmmP13QqOL8K2ckR9ftXVc/7mixwfCc0KFiCOPvBwtyqzcIIajSV4F03LoRRRD
         S9MN6+5Lig4MbSkpwJtVFAhdlB2GKif0Swp6XvywLAVfRsg+6TElWCC5Wn1DnU4gwn
         Msi3e0ckCL2K5m2nxcRM0xYG9/xQOlfgX/GsoWmo=
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Subject: Re: [PATCH] send-email: do not prompt for In-Reply-To
From:   "Drew DeVault" <sir@cmpwn.com>
To:     "Raymond E. Pasco" <ray@ameretat.dev>,
        "Junio C Hamano" <gitster@pobox.com>
Cc:     =?utf-8?q?Carlo_Marcelo_Arenas_Bel=C3=B3n?= <carenas@gmail.com>,
        <git@vger.kernel.org>
Date:   Thu, 27 Aug 2020 21:56:15 -0400
Message-Id: <C5898IRIGV23.CBS4D6546Y9K@homura>
In-Reply-To: <C588ZA2QAFBS.23DYVMBK3E0X6@ziyou.local>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu Aug 27, 2020 at 9:44 PM EDT, Raymond E. Pasco wrote:
> Anyway, it's worth noting that, because the prompts *do* exist,
> half-baked as they are, it's not really safe to assume that nobody sees
> them. There might be a sizable population out there never specifying
> "--to" because they know they'll be prompted for it.

I hardly ever use --to for one-off patches or repositories which I'm not
regularly contributing to, and I expect that prompt. In-Reply-To has a
much less compelling argument, though, as Junio pointed out, given that
it's often not necessary or desirable, whereas for "to", every email has
to have at least one recipient to make sense.
