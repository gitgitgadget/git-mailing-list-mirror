Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-7.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 23D152018A
	for <e@80x24.org>; Mon, 27 Jun 2016 13:23:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751767AbcF0NXa (ORCPT <rfc822;e@80x24.org>);
	Mon, 27 Jun 2016 09:23:30 -0400
Received: from mout.kundenserver.de ([212.227.126.134]:52379 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751714AbcF0NX3 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 27 Jun 2016 09:23:29 -0400
Received: from pflsmail.localdomain ([37.123.123.67]) by
 mrelayeu.kundenserver.de (mreue003) with ESMTPSA (Nemesis) id
 0LkknQ-1brxiV1gWa-00aV9m; Mon, 27 Jun 2016 15:23:11 +0200
Received: from localhost (localhost [127.0.0.1])
	by pflsmail.localdomain (Postfix) with ESMTP id 0714EB00E5D;
	Mon, 27 Jun 2016 15:23:11 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at pflsmail.corp.cetitec.com
Received: from pflsmail.localdomain ([127.0.0.1])
	by localhost (pflsmail.corp.cetitec.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 2CB5C0g2LHPX; Mon, 27 Jun 2016 15:23:09 +0200 (CEST)
Received: from pfwsexchange.corp.cetitec.com (unknown [10.10.1.99])
	by pflsmail.localdomain (Postfix) with ESMTPS id 04989B00E58;
	Mon, 27 Jun 2016 15:23:09 +0200 (CEST)
Received: from pflmari.corp.cetitec.com (10.10.11.230) by
 PFWSEXCHANGE.corp.cetitec.com (10.10.1.99) with Microsoft SMTP Server (TLS)
 id 15.0.847.32; Mon, 27 Jun 2016 15:23:08 +0200
Received: by pflmari.corp.cetitec.com (Postfix, from userid 1000)	id
 9098A804B0; Mon, 27 Jun 2016 15:23:08 +0200 (CEST)
Date:	Mon, 27 Jun 2016 15:23:08 +0200
From:	Alex Riesen <alexander.riesen@cetitec.com>
To:	<git@vger.kernel.org>
CC:	Pat Thoyts <patthoyts@users.sourceforge.net>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 2/2] Ensure the file in the diff pane is always in the list
 of selected files
Message-ID: <20160627132308.GD4194@pflmari>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
In-Reply-To: <20160627132137.GC4194@pflmari>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Originating-IP: [10.10.11.230]
X-ClientProxiedBy: PFWSEXCHANGE.corp.cetitec.com (10.10.1.99) To
 PFWSEXCHANGE.corp.cetitec.com (10.10.1.99)
Content-Transfer-Encoding: 8BIT
X-Antivirus: avast! (VPS 160627-0, 27.06.2016), Outbound message
X-Antivirus-Status: Clean
X-Provags-ID: V03:K0:t7doCeW4ni3sL7gwoJMxhK4fuhAuC97a7xjt4zYR6EUHSOCJxN2
 m11hIyt4FiGCv2EZjyAHd/pXmwq0vFMcPodsYYQHvlkJtEJQc+BPynCvJllPJOjR9W4iAMI
 2TlbG7BJNs3bw1uHBD8OgP+3v5uCn4n15vQ2BSUZ73TAeq3c11NyuzqR+tJGOULl12JnnjS
 JjmIeQCqG/hB2VospigIg==
X-UI-Out-Filterresults:	notjunk:1;V01:K0:KJXLf9FKjV4=:9YwFHtc4JpvluJlTBYLqFR
 1LSp4PpUPO+7KNGw7YjaWEJKmmLjTOm9Yr+8eog3/t7Io/C0rTjrC8pyMEpeQrEJZMOye9M1M
 4o69/bt/FejVW80CEu0Q2ZAo6Mghu6iE2FkIDeYJvoFRkwiXhfYzFfZOh/9awpa4wXZ7Imtir
 VYDUoYPL23MFDazD9SsWVdxkSlr9ylNymJ6wLeMV5dIyp933OS45wSbzCW/Ql9IJGqjoV/qZg
 5vT/laBBm8t1dEAAcP3d80jTIqvPYOdm7pSLFE9EbQ3Fq5EAV5rDrLEftYxFpPiJAZsecclcE
 iPBbme/QkCWEh68ZCL1rk2um3ERkJPPfWUK/tPeJkNXUxkg7DNmQ9DGbu12ytKVZVGf5H20Q2
 5amE8axSk/A28+BKzrdWZR5kMXChBPIajxbQF+j4BE7fFWHny/ndEY7WFgvpcCrETVV3N0Ssf
 AH/8+qWeCyuGBHAAGXOPiCJk+v0V7tyAu64dc6Awdq02m9xdcUXtxQugWdTxhv8jbK4mNHrxn
 d3ZIOR83mULQEk615wvqwS0JsKfZ5JR//DPtRmBsqYnWF2Ta88g5wD7fZWBh/keZ4dFNbAesD
 qZyebgc3xLplxp4BhKHO6u0Xfd4iCue5c3ql/+uRe5iyVT4UTON6SnsRpc31PN8sVhdHhS85A
 AzJL2+vYKBOmp7LA4QjOJIOH+j+4SgrrEK9h1SmjMvOY8xNgbUCGiKudO2AoCfTou+dw=
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

It is very confusing that the file, diff of which is displayed and which is
marked as selected in the file list, is not, in fact, selected. I.e. the array
of selected files does not contain an entry for it.

Fixing this also improves the use of $FILENAMES in custom defined tools: one
does not have to click the file in the list to make it selected.
---
 lib/diff.tcl | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/lib/diff.tcl b/lib/diff.tcl
index 0d56986..30bdd69 100644
--- a/lib/diff.tcl
+++ b/lib/diff.tcl
@@ -127,6 +127,9 @@ proc show_diff {path w {lno {}} {scroll_pos {}} {callback {}}} {
 	} else {
 		start_show_diff $cont_info
 	}
+
+	global current_diff_path selected_paths
+	set selected_paths($current_diff_path) 1
 }
 
 proc show_unmerged_diff {cont_info} {
-- 
2.9.0.45.g28c608e.dirty

To: 
Cc: 
Bcc: 
Subject: 
Reply-To: Alex Riesen <alexander.riesen@cetitec.com>


---
Diese E-Mail wurde von Avast Antivirus-Software auf Viren geprüft.
https://www.avast.com/antivirus

