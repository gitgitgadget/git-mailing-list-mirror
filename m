Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB2ABC433EF
	for <git@archiver.kernel.org>; Wed,  5 Jan 2022 08:19:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238454AbiAEITE (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 5 Jan 2022 03:19:04 -0500
Received: from 82-64-198-250.subs.proxad.net ([82.64.198.250]:60002 "EHLO
        mail.lhuard.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238429AbiAEIS7 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Jan 2022 03:18:59 -0500
Received: from coruscant.lhuard.fr (unknown [IPv6:2a01:e0a:465:5440:d7a9:f807:da56:3cee])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.lhuard.fr (Postfix) with ESMTPSA id 0ED1358F30A;
        Wed,  5 Jan 2022 09:18:51 +0100 (CET)
Authentication-Results: mail.lhuard.fr; dmarc=fail (p=quarantine dis=none) header.from=lhuard.fr
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lhuard.fr; s=rpi3;
        t=1641370732; bh=PlX6sHtioHe8DN4b8JUEeheb/7OY5Qnq2flJWIr3HnM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=MPpK5aJKz4h2Nd9d/tUytt7WOTVJBYkwQY4Gci5FVIHSdzIlj1lPi33FYHqH9fevV
         jVIRCSKVlHvkCGCP4XmEPqKv/Ocqfb2pq8ycuGbKIBfFXYB3ChdJJF9+eSPpwHeC++
         3/yj9Aqu0TN3vharJRezf+El4KWUEwhbn8CkY3HY=
From:   =?UTF-8?q?L=C3=A9na=C3=AFc=20Huard?= <lenaic@lhuard.fr>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Philippe Blain <levraiphilippeblain@gmail.com>,
        =?UTF-8?q?L=C3=A9na=C3=AFc=20Huard?= <lenaic@lhuard.fr>
Subject: [PATCH v2 0/1] grep: align default colors with GNU grep ones
Date:   Wed,  5 Jan 2022 09:18:34 +0100
Message-Id: <20220105081835.4949-1-lenaic@lhuard.fr>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20211216115622.85506-1-lenaic@lhuard.fr>
References: <20211216115622.85506-1-lenaic@lhuard.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I’ve re-rolled this patch only to move the change description from the
cover letter to the commit message.
Except from that, there is no change in the code at all.

Lénaïc Huard (1):
  grep: align default colors with GNU grep ones

 grep.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

-- 
2.34.1

