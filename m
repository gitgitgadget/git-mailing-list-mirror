Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 44B2020A10
	for <e@80x24.org>; Sun,  1 Oct 2017 15:44:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751118AbdJAPof (ORCPT <rfc822;e@80x24.org>);
        Sun, 1 Oct 2017 11:44:35 -0400
Received: from mout.gmx.net ([212.227.17.21]:63821 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750965AbdJAPoe (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 1 Oct 2017 11:44:34 -0400
Received: from fermat.fritz.box ([92.76.241.219]) by mail.gmx.com (mrgmx102
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MW9TR-1dnWFu3Wnp-00XJJD; Sun, 01
 Oct 2017 17:44:28 +0200
From:   Stephan Beyer <s-beyer@gmx.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Stephan Beyer <s-beyer@gmx.net>,
        Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [PATCH v2] Add a comment to .clang-format about the meaning of the file
Date:   Sun,  1 Oct 2017 17:44:25 +0200
Message-Id: <20171001154425.5568-1-s-beyer@gmx.net>
X-Mailer: git-send-email 2.14.2.677.g5a59ab275
In-Reply-To: <20170929224505.GN19555@aiede.mtv.corp.google.com>
References: <20170929224505.GN19555@aiede.mtv.corp.google.com>
X-Provags-ID: V03:K0:DtTJ7Vr7E2Tuh7ROpzXB63YjJt2BW0f6TLc3cWUCRCo5CEpx2t0
 BJMkY6M+3y0NPK2spEycCPv6+azHc5T46zXW/PkvOjIdNwUkyl1cqlglCBAVYhlTF/vvBSQ
 ptDqNWYE1j1rxOOab0rVcJda5lTp2k1IkCEoJQVzE6qLhSByUe9qG35oSk7Z2K4b73sv0qw
 yWoWfYt21pngGpsPml5aw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:wbAUyakwcMM=:kO5veBWzpr6HZJj925DrG6
 bf78tvrCTgezUEfKq5CqEkaDfzlJKDuEbsFltTddew3DSYA+lxHp726PDzj15HV40zL/GAwmu
 okD4dXCpjMmoHcFCJ9ouagWDo6fyVNRoapfHty+ZX3wPnOX4SZe3mq+3EACOKWAecJ8t6BjHN
 VQ1Z9r3HXNeAsbrRydZPiUpvqJA5JuoPmo26vVEsOCaI7FS71nDDCR8yq/wIxhbB5jQwl1/5Y
 trAeH9Z38Uai/FMb2v5EvRMU9l3QLoPUWPi+sxmkk7zbDUYOik2Q978DUb8PHeSpJQ5TBbyik
 id/T/RzDjm93zWnC4ubm+5WQ2dzcVf9wQRn+ExLsDpfbxbsDYTLZfTXs0eWRu43eaEquuWNdL
 L83i71WqlxeiuPKdIUxFdnS4MqkZGUyOatLRz2kawjDxY5HcGXFg7sG3MZ2rnZ8dZHsiAqIh2
 eXtp3RynzrYTx9jt37Gcke5tPNEzj2qJztYN9S6mh/1dEHJkeOJWzk5q0d9cDnGoHdpThg9xl
 UpC/roFAYQIhMmh0+EH/7EQRZPuWswIECGkrcMDqsGeyQJBrP26CAcd3XK3e23pmOLdFqlUaH
 9AAZ2n/QNPMWWa0CeBj1fMITdHndR5s2ruy2Cee4Z5w0hNJ8gkrOsvJ8b4RJRsYDm25EFNBx7
 3ckBphLX8NRlc5p3BVvHkH4kL42tgTOTgFVoE0tlkU3TYtUChGMD8Sf2okrExKz+mc9hIoWdq
 Bzv5bSJn9P/DzQPo0zmUhuacEAnzfNU6dMQC9RawX8LoIvgm66/B3mW9WYlQ14D7136FxGxsn
 qgO2EJpEFVdgYVk/jGiEOQLfsnvkg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Having a .clang-format file in a project can be understood in a way that code
has to be in the style defined by the .clang-format file, i.e., you just have
to run clang-format over all code and you are set. This is not the case in the
Git project, which is now reflected by a comment in the beginning of the file.

Additionally, the working clang-format version is mentioned because the config
directives change from time to time (in a compatibility-breaking way).

Signed-off-by: Stephan Beyer <s-beyer@gmx.net>
---

Notes:
    On 10/01/2017 04:45 AM, Junio C Hamano wrote:
    > it makes as if a random patch to "make it
    > conform" without thinking if the rules make sense were a welcome
    > addition, which is absolutely the last signal we would want to send
    > to the readers.
    
    Right. I dropped that last sentence and replaced it by a sentence about human
    aesthetics judgement overruling mechanical rules -- I think that's somehow quoted
    from a comment of yours on the list.

 .clang-format | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/.clang-format b/.clang-format
index 3ede2628d..041b7be03 100644
--- a/.clang-format
+++ b/.clang-format
@@ -1,4 +1,8 @@
-# Defaults
+# This file is an example configuration for clang-format 5.0.
+#
+# Note that this style definition should only be understood as a hint
+# for writing new code. In the end, human aesthetics judgement overrules
+# mechanical rules.
 
 # Use tabs whenever we need to fill whitespace that spans at least from one tab
 # stop to the next one.
-- 
2.14.2.677.g5a59ab275

