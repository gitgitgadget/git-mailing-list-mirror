X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
From: Quy Tonthat <qtonthat@gmail.com>
Subject: [PATCH] git-clone documentation
Date: Fri, 15 Dec 2006 01:17:53 +1100
Message-ID: <45815D11.4090609@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------030201030004020506060502"
NNTP-Posting-Date: Thu, 14 Dec 2006 18:34:39 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Greylist: delayed 15354 seconds by postgrey-1.27 at vger.kernel.org; Thu, 14 Dec 2006 13:34:29 EST
User-Agent: Thunderbird 1.5.0.8 (X11/20061107)
X-Enigmail-Version: 0.94.1.1
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34383>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GuvPd-0002RF-GE for gcvg-git@gmane.org; Thu, 14 Dec
 2006 19:34:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S932887AbWLNSea (ORCPT <rfc822;gcvg-git@m.gmane.org>); Thu, 14 Dec 2006
 13:34:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932823AbWLNSea
 (ORCPT <rfc822;git-outgoing>); Thu, 14 Dec 2006 13:34:30 -0500
Received: from pecan-mail.exetel.com.au ([220.233.0.8]:38311 "EHLO
 pecan.exetel.com.au" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
 id S932887AbWLNSe3 (ORCPT <rfc822;git@vger.kernel.org>); Thu, 14 Dec 2006
 13:34:29 -0500
Received: from 95.69.233.220.exetel.com.au ([220.233.69.95]
 helo=[192.168.64.35]) by pecan.exetel.com.au with esmtp (Exim 4.63)
 (envelope-from <qtonthat@gmail.com>) id 1GurPs-0004VG-VH for
 git@vger.kernel.org; Fri, 15 Dec 2006 01:18:33 +1100
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

This is a multi-part message in MIME format.
--------------030201030004020506060502
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

When --use-separate-remote is used on git-clone, the remote
heads are saved under $GIT_DIR/refs/remotes/origin/, not
"$GIT_DIR/remotes/origin/"

Quy


--------------030201030004020506060502
Content-Type: text/x-patch;
 name="git.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="git.diff"

diff --git a/Documentation/git-clone.txt b/Documentation/git-clone.txt
index 985043f..bfddb21 100644
--- a/Documentation/git-clone.txt
+++ b/Documentation/git-clone.txt
@@ -100,7 +100,7 @@ OPTIONS
 	defined default, typically `/usr/share/git-core/templates`.
 
 --use-separate-remote::
-	Save remotes heads under `$GIT_DIR/remotes/origin/` instead
+	Save remotes heads under `$GIT_DIR/refs/remotes/origin/` instead
 	of `$GIT_DIR/refs/heads/`.  Only the local master branch is
 	saved in the latter. This is the default.
 

