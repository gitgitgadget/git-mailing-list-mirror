Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BC5E221006
	for <e@80x24.org>; Mon,  4 Jul 2016 06:05:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752568AbcGDGFe (ORCPT <rfc822;e@80x24.org>);
	Mon, 4 Jul 2016 02:05:34 -0400
Received: from sub3.mail.dreamhost.com ([69.163.253.7]:57488 "EHLO
	homiemail-a18.g.dreamhost.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752123AbcGDGFc convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>); Mon, 4 Jul 2016 02:05:32 -0400
Received: from homiemail-a18.g.dreamhost.com (localhost [127.0.0.1])
	by homiemail-a18.g.dreamhost.com (Postfix) with ESMTP id 8A11B258065;
	Sun,  3 Jul 2016 23:05:31 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=novalis.org; h=from:to:cc
	:subject:date:message-id:in-reply-to:references:mime-version
	:content-type:content-transfer-encoding; s=novalis.org; bh=1KqqL
	PIxL2XDqYKgoTt+9A52+yY=; b=SWIMfsaRAEkGvKRArSXuerbvWK2QopytsTYHn
	1klbA8dS8Qp1QOTXuYnkpws++/otXgp9qmoV4oC1gaHDPAq7+3JzyyktUOAyjyRr
	GEzABflrEH/EllJyemuJA9jtsig7AyG0snVxDfmq9CgUqGrztx3zDs2/2munlA9c
	6URblk=
Received: from frank.cable.rcn.com (207-38-164-98.c3-0.43d-ubr2.qens-43d.ny.cable.rcn.com [207.38.164.98])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	(Authenticated sender: novalis@novalis.org)
	by homiemail-a18.g.dreamhost.com (Postfix) with ESMTPSA id E4725258062;
	Sun,  3 Jul 2016 23:05:30 -0700 (PDT)
From:	David Turner <novalis@novalis.org>
To:	git@vger.kernel.org, pclouds@gmail.com, kmaggg@gmail.com
Cc:	David Turner <novalis@novalis.org>
Subject: [PATCH v14 21/21] mailmap: use main email address for dturner
Date:	Mon,  4 Jul 2016 02:05:24 -0400
Message-Id: <1467612324-23556-2-git-send-email-novalis@novalis.org>
X-Mailer: git-send-email 2.8.0.rc4.11.g9232872.dirty
In-Reply-To: <1467612324-23556-1-git-send-email-novalis@novalis.org>
References: <1467612324-23556-1-git-send-email-novalis@novalis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Signed-off-by: David Turner <novalis@novalis.org>
---
 .mailmap | 1 +
 1 file changed, 1 insertion(+)

diff --git a/.mailmap b/.mailmap
index e5b4126..edcae89 100644
--- a/.mailmap
+++ b/.mailmap
@@ -46,6 +46,7 @@ David D. Kilzer <ddkilzer@kilzer.net>
 David Kågedal <davidk@lysator.liu.se>
 David Reiss <dreiss@facebook.com> <dreiss@dreiss-vmware.(none)>
 David S. Miller <davem@davemloft.net>
+David Turner <novalis@novalis.org> <dturner@twopensource.com>
 Deskin Miller <deskinm@umich.edu>
 Dirk Süsserott <newsletter@dirk.my1.cc>
 Eric Blake <eblake@redhat.com> <ebb9@byu.net>
-- 
1.9.1

