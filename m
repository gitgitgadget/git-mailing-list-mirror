Return-Path: <SRS0=R9sp=CF=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28DB4C433DF
	for <git@archiver.kernel.org>; Thu, 27 Aug 2020 19:35:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EAC6722BEA
	for <git@archiver.kernel.org>; Thu, 27 Aug 2020 19:35:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=cmpwn.com header.i=@cmpwn.com header.b="KtFEYeRF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727116AbgH0TfO (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 27 Aug 2020 15:35:14 -0400
Received: from mail.cmpwn.com ([45.56.77.53]:47670 "EHLO mail.cmpwn.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726839AbgH0TfL (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Aug 2020 15:35:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=cmpwn.com; s=cmpwn;
        t=1598556910; bh=muv9dGwe32jYeFVMiggT0oEEzVaehsAvhdGDo6wh4+A=;
        h=Cc:Subject:From:To:Date:In-Reply-To;
        b=KtFEYeRFePVvxl+JwFDXLvT+LySv9AzCRZFjTEd2g+ha8L/BnNiiYx0VcPz76m2y4
         Dn8jwOs9EQPx15P4i8ReWQTdJOxb9KH7WAJZ5ajDm4D+Vjww6PXc9DCgMJndkwecGC
         txUtXfZmULJFU+Fhndi5B+AWCayxgwzvxrOFQZ94=
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Cc:     "Drew DeVault" <sir@cmpwn.com>, <git@vger.kernel.org>
Subject: Re: [PATCH] send-email: do not prompt for In-Reply-To
From:   "Drew DeVault" <sir@cmpwn.com>
To:     "Junio C Hamano" <gitster@pobox.com>,
        =?utf-8?q?Carlo_Marcelo_Arenas_Bel=C3=B3n?= <carenas@gmail.com>
Date:   Thu, 27 Aug 2020 15:34:38 -0400
Message-Id: <C5814BWVXMP3.1GJ83FMKYSFTY@homura>
In-Reply-To: <xmqqtuwnq3x1.fsf@gitster.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Do you think this whole workstream could be averted by dropping the
$prompting check in the in-reply-to branch?

Or would that still constitute a breaking change to user workflows?
