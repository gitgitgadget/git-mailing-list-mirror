Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,URIBL_BLACK
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A3FE220986
	for <e@80x24.org>; Mon,  3 Oct 2016 10:30:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752016AbcJCKaM (ORCPT <rfc822;e@80x24.org>);
        Mon, 3 Oct 2016 06:30:12 -0400
Received: from know-smtprelay-omc-2.server.virginmedia.net ([80.0.253.66]:49465
        "EHLO know-smtprelay-omc-2.server.virginmedia.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751140AbcJCKaL (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 Oct 2016 06:30:11 -0400
Received: from red.patthoyts.tk ([82.37.62.216])
        by know-smtprelay-2-imp with bizsmtp
        id qyW91t0054fw4HN01yW9KS; Mon, 03 Oct 2016 11:30:09 +0100
X-Originating-IP: [82.37.62.216]
X-Spam: 0
X-Authority: v=2.1 cv=XKnNMlVE c=1 sm=1 tr=0 a=y+L2qvWGb0b1Khfuzk0aNQ==:117
 a=y+L2qvWGb0b1Khfuzk0aNQ==:17 a=L9H7d07YOLsA:10 a=9cW_t1CCXrUA:10
 a=s5jvgZ67dGcA:10 a=xqWC_Br6kY4A:10 a=1oJP67jkp3AA:10 a=ZZnuYtJkoWoA:10
 a=CH0kA5CcgfcA:10 a=Rf460ibiAAAA:8 a=3PW0oCZOFPbtrssW1b8A:9
 a=7Zwj6sZBwVKJAoWSPKxL6X1jA+E=:19 a=-FEs8UIgK8oA:10 a=NWVoK91CQyQA:10
 a=-X4ai1wA6IXBCEr1GZS2:22
Received: from red.patthoyts.tk (red.patthoyts.tk [IPv6:2001:470:1f1d:26c::2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by red.patthoyts.tk (Postfix) with ESMTPS id D8EC519602E4;
        Mon,  3 Oct 2016 11:30:08 +0100 (BST)
From:   Pat Thoyts <patthoyts@users.sourceforge.net>
To:     Vasco Almeida <vascomalmeida@sapo.pt>
Cc:     git@vger.kernel.org, "Shawn O . Pearce" <spearce@spearce.org>
Subject: Re: [PATCH 1/5] git-gui i18n: mark strings for translation
References: <1462704778-4722-1-git-send-email-vascomalmeida@sapo.pt>
X-Face:  .`d#euqz@6H{";Ysmx2IVe_7M3vA+2w1X[QLk?ZO&QRauXQL{*L'$3getx}9+zK.-KWDx3.
 qrlR)76MFb`6bgoGvLpLtcQKB=X~;*<JKLtwLBM(IA'?rVjs1*tq\VHn?WMNsB,3XXWF@5.)4SRFa+
 '?a?.s#@hl7CiTo'F"O!fvbL0
Reply-to: patthoyts@users.sourceforge.net
X-Url:  http://www.patthoyts.tk/
Date:   Mon, 03 Oct 2016 11:30:08 +0100
In-Reply-To: <1462704778-4722-1-git-send-email-vascomalmeida@sapo.pt> (Vasco
        Almeida's message of "Sun, 8 May 2016 10:52:54 +0000")
Message-ID: <8760p9wwr3.fsf@red.patthoyts.tk>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Vasco Almeida <vascomalmeida@sapo.pt> writes:

>Mark strings for translation in lib/index.tcl that were seemingly
>left behind by 700e560 ("git-gui: Mark forgotten strings for
>translation.", 2008-09-04) which marks string in do_revert_selection
>procedure.
>These strings are passed to unstage_help and add_helper procedures.
>
>Signed-off-by: Vasco Almeida <vascomalmeida@sapo.pt>
>---
> lib/index.tcl | 6 +++---
> 1 file changed, 3 insertions(+), 3 deletions(-)
>
>diff --git a/lib/index.tcl b/lib/index.tcl
>index 74a81a7..3a3e534 100644
>--- a/lib/index.tcl
>+++ b/lib/index.tcl
>@@ -291,7 +291,7 @@ proc do_unstage_selection {} {
> 
> 	if {[array size selected_paths] > 0} {
> 		unstage_helper \
>-			{Unstaging selected files from commit} \
>+			[mc "Unstaging selected files from commit"] \
> 			[array names selected_paths]
> 	} elseif {$current_diff_path ne {}} {
> 		unstage_helper \
>@@ -343,7 +343,7 @@ proc do_add_selection {} {
> 
> 	if {[array size selected_paths] > 0} {
> 		add_helper \
>-			{Adding selected files} \
>+			[mc "Adding selected files"] \
> 			[array names selected_paths]
> 	} elseif {$current_diff_path ne {}} {
> 		add_helper \
>@@ -385,7 +385,7 @@ proc do_add_all {} {
> 			set paths [concat $paths $untracked_paths]
> 		}
> 	}
>-	add_helper {Adding all changed files} $paths
>+	add_helper [mc "Adding all changed files"] $paths
> }
> 
> proc revert_helper {txt paths} {

This series looks good. Especially noticing the misuse of the append
command. Applied to my pu for now.
Thank you,

-- 
Pat Thoyts                            http://www.patthoyts.tk/
PGP fingerprint 2C 6E 98 07 2C 59 C8 97  10 CE 11 E6 04 E0 B9 DD
