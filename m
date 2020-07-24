Return-Path: <SRS0=kKTt=BD=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58B28C433E4
	for <git@archiver.kernel.org>; Fri, 24 Jul 2020 00:43:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0BD202065F
	for <git@archiver.kernel.org>; Fri, 24 Jul 2020 00:43:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=cmpwn.com header.i=@cmpwn.com header.b="ivV74zK9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728324AbgGXAnj (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 23 Jul 2020 20:43:39 -0400
Received: from mail.cmpwn.com ([45.56.77.53]:52916 "EHLO mail.cmpwn.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727783AbgGXAnj (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Jul 2020 20:43:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=cmpwn.com; s=cmpwn;
        t=1595551416; bh=1ZH8JG3VAQVdr4jbRaxprLP9ox5cx0yUG3Isa8rG8es=;
        h=Cc:Subject:From:To:Date:In-Reply-To;
        b=ivV74zK9mXF3FfHMjuVjbGkixRzFm1A93oepewIRtPg7Iz2dDt1kaU4d3wpzItVSd
         xD93NSPPj4tx+A6gV3klzw1gPaN0iqOi/SU2vHZPY8PvHqwVqCGE9Pk9+Q8vnsNIHz
         I/MdkDddMl9/rzht2is2E6lA2yIkMAE5DGzZxEWE=
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Cc:     "Jeff King" <peff@peff.net>, <git@vger.kernel.org>
Subject: Re: [PATCH v2] git-send-email: die if sendmail.* config is set
From:   "Drew DeVault" <sir@cmpwn.com>
To:     "Junio C Hamano" <gitster@pobox.com>
Date:   Thu, 23 Jul 2020 20:43:26 -0400
Message-Id: <C4EFRPCE3DAH.1L6J33UIORQ02@homura>
In-Reply-To: <xmqq365hoi9o.fsf@gitster.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Oh, I'm sorry, I thought I had already sent it out.
