Return-Path: <SRS0=ys1m=5K=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABA5AC10DCE
	for <git@archiver.kernel.org>; Wed, 25 Mar 2020 01:35:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E6B72072E
	for <git@archiver.kernel.org>; Wed, 25 Mar 2020 01:35:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="Bu93GEig"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727239AbgCYBfD (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 24 Mar 2020 21:35:03 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:32982 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727212AbgCYBfC (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 24 Mar 2020 21:35:02 -0400
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 12A7A6077C;
        Wed, 25 Mar 2020 01:35:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1585100101;
        bh=10kTI9FG09xHqa0fPfUa5QNVzja/3CgYr6ukRWEcujk=;
        h=From:To:Cc:Subject:Date:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=Bu93GEigELjzMQx5TL9gjft3QDy3wzAvZKQJRT7Ms8mfDlR2bPSIU6W8Jel99hnoA
         Vh7II2R8Aok3in9tJrYgVxWhH2b2ekW2mYHBCx6tUxtwnuZr1BIdHye4n8jskV6II0
         mdnN7NMgVpopw8Pp/q3uun1kDKZAlmmmyEYfdUkPoxnB7mKl+blFodCMlxA2+hVDNt
         lGtiXD7/+FOpaF6HVAQBKcRoSI+TOjHoYss3TLPlMey4xVdUiT8f9xfw16MqQoOxjb
         m43gykWU1pziVGdq2faD9A9lq0xqbFmUVGfXCMmaoY4lfGRDEf637m+3VfbURnQZey
         2ZmqfueE5Ubdz4kxEMw0lCm3+kO4Xz0U6vz/ydZiSMNshpSh0+ek2PFCBjQrZVnfYX
         Xsmx6DtGuTlD7oFXN+V3MNGlOrtwMKXNXfcPlFBavR2+BZxjMvvOM47frgIZvCVk7C
         yClL/Vfqs/MNbiLRU8xaIVz91B0N3+J45wJABO51flGGG/yATRy
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     <git@vger.kernel.org>
Cc:     Emily Shaffer <emilyshaffer@google.com>,
        Junio C Hamano <gitster@pobox.com>,
        Shourya Shukla <shouryashukla.oo@gmail.com>
Subject: [PATCH v2 0/1] FAQ for common user questions
Date:   Wed, 25 Mar 2020 01:34:33 +0000
Message-Id: <20200325013434.219775-1-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.26.0.277.gb8618d28a92
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Git is an enormously flexible and powerful piece of software, but many
people find it confusing and hard to use.  This patch introduces a FAQ
to address some common user questions and hopefully make it easier.

I know there are some plans to add additional entries to this.  I
propose we tack them on as additional patches, and if I need to reroll
this again, I can pick them up as part of the series, unless someone
has strong opinions about doing things differently.

Changes from v1:
* Fix various indentation issues.
* Avoid using "some people", except to state that "some people find `vi`
  difficult to use", preferring to use language addressing
  misconceptions more directly.
* Add "erroneously" to "This is often suggested" to avoid users
  accidentally doing what we recommend against.
* Attempt to come up with a better way to describe a personal name,
  using Junio as an example.

brian m. carlson (1):
  docs: add a FAQ

 Documentation/Makefile   |   1 +
 Documentation/gitfaq.txt | 337 +++++++++++++++++++++++++++++++++++++++
 2 files changed, 338 insertions(+)
 create mode 100644 Documentation/gitfaq.txt

