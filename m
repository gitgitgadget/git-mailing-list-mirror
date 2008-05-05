From: imyousuf@gmail.com
Subject: [PATCH] Documentation/git-submodule.txt: Add documentation for the recurse subcommand
Date: Mon,  5 May 2008 14:44:11 +0600
Message-ID: <1209977051-25896-5-git-send-email-imyousuf@gmail.com>
References: <1209977051-25896-1-git-send-email-imyousuf@gmail.com>
 <1209977051-25896-2-git-send-email-imyousuf@gmail.com>
 <1209977051-25896-3-git-send-email-imyousuf@gmail.com>
 <1209977051-25896-4-git-send-email-imyousuf@gmail.com>
Cc: gitster@pobox.com, Imran M Yousuf <imyousuf@smartitengineering.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 05 10:46:35 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JswL3-0006NM-Fe
	for gcvg-git-2@gmane.org; Mon, 05 May 2008 10:46:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758189AbYEEIpd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 5 May 2008 04:45:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758140AbYEEIpc
	(ORCPT <rfc822;git-outgoing>); Mon, 5 May 2008 04:45:32 -0400
Received: from nf-out-0910.google.com ([64.233.182.188]:44279 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758036AbYEEIpb (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 May 2008 04:45:31 -0400
Received: by nf-out-0910.google.com with SMTP id d3so1024831nfc.21
        for <git@vger.kernel.org>; Mon, 05 May 2008 01:45:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=o4ezIo05T/Vbra8M2ahwqTxN3gRwlWa/9y1dbInpQjg=;
        b=wBthFPCcRQ9rglVtnk7enaL8JnrDMuTNQZYL49Ax8d0X4R0X6H4c5ITMsjPL6osN83RsNzp9Y7q0iKELQ4wi6AsyZBArwt2YJ998QGHx16d5GBMKuietm4rCX6iyDqoM4O6jB3/vTSz3qdx+hbXUIdvv6/UyeHnKA8cv0jJFPNo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=RyimMuPKZIZSV0rjff5tvF+/VYC68cPasnsL9vYcBZwyJbuhTF1SRII5xS1Z/Dh3nfPcx8Yjx2kXxdjErxdbPlNmIPR45wM06nmvSm5KGx91xvUUMyKBLWvGpEI/dh3Sw3x7SafJCsl379c+APQ/KI/jHZJFZgx2Xk+N+GLhi6A=
Received: by 10.210.58.13 with SMTP id g13mr5342226eba.144.1209977131012;
        Mon, 05 May 2008 01:45:31 -0700 (PDT)
Received: from localhost ( [62.101.198.35])
        by mx.google.com with ESMTPS id k10sm11152425nfh.25.2008.05.05.01.45.26
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 05 May 2008 01:45:30 -0700 (PDT)
X-Mailer: git-send-email 1.5.4.2
In-Reply-To: <1209977051-25896-4-git-send-email-imyousuf@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81249>

From: Imran M Yousuf <imyousuf@smartitengineering.com>

Documentation with brief description is added for the recurse
sucommand along with its arguments and their nature.

Signed-off-by: Imran M Yousuf <imyousuf@smartitengineering.com>
---
 Documentation/git-submodule.txt |   35 +++++++++++++++++++++++++++++++++++
 1 files changed, 35 insertions(+), 0 deletions(-)

diff --git a/Documentation/git-submodule.txt b/Documentation/git-submodule.txt
index 6ffd896..9a95522 100644
--- a/Documentation/git-submodule.txt
+++ b/Documentation/git-submodule.txt
@@ -13,6 +13,10 @@ SYNOPSIS
 'git-submodule' [--quiet] status [--cached] [--] [<path>...]
 'git-submodule' [--quiet] [init|update] [--] [<path>...]
 'git-submodule' [--quiet] summary [--summary-limit <n>] [commit] [--] [<path>...]
+'git-submodule' recurse [-q|--quiet] [-e|--exit-after-error]
+		[-d|--depth <recursion depth>] [-b|--breadth-first]
+		[-a|--customized-argument] [-p|--pre-command]
+		<git command> [<arg> ...]"
 
 
 COMMANDS
@@ -54,6 +58,10 @@ summary::
 	in the submodule between the given super project commit and the
 	index or working tree (switched by --cached) are shown.
 
+recurse::
+	Recurse, IOW propagate, command to its submodules if they are
+	initialized.
+
 OPTIONS
 -------
 -q, --quiet::
@@ -78,6 +86,33 @@ OPTIONS
 	Path to submodule(s). When specified this will restrict the command
 	to only operate on the submodules found at the specified paths.
 
+-e, --exit-after-error::
+	This option is only valid for the recurse command. If its provided then
+	then command will not be recursed into any other module once a command
+	has failed
+-d, --depth <recursion depth>::
+	This option is only valid for the recurse command. If its provided then
+	then the command will be recursed upto <recursion depth> only.
+-b, --breadth-first::
+	This option is only valid for the recurse command. If its provided then
+	the command will execute in the current node before traversing to its
+	child, else it will first traverse the children before executing in the
+	current node.
+-a, --customized-argument::
+	This option is only valid for the recurse command. If its provided then
+	user will be prompted for an argument for the <git command> specified.
+	Its particularly useful when one wants to supply different arguments
+	for the same <git command> for different submodules; for example,
+	checking out a branch, one might want branch to differ from submodule
+	to submodule
+-p, --pre-command::
+	This option is only valid for the recurse command. If its provided then
+	user will be prompted for a shell command, e.g. 'ls -al', 'pwd' etc.
+<git command> [<arg>...]::
+	Any git command and their argument. For example, to get the status use
+	'status' as <git command> and '-s' or '-o' or any other 'git status'
+	arguments as <arg>
+
 FILES
 -----
 When initializing submodules, a .gitmodules file in the top-level directory
-- 
1.5.4.2
