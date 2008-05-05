From: imyousuf@gmail.com
Subject: [PATCH v2 5/5] Documentation/git-submodule.txt: Add documentation for the recurse subcommand
Date: Mon,  5 May 2008 15:09:42 +0600
Message-ID: <1209978582-5785-5-git-send-email-imyousuf@gmail.com>
References: <1209978582-5785-1-git-send-email-imyousuf@gmail.com>
 <1209978582-5785-2-git-send-email-imyousuf@gmail.com>
 <1209978582-5785-3-git-send-email-imyousuf@gmail.com>
 <1209978582-5785-4-git-send-email-imyousuf@gmail.com>
Cc: gitster@pobox.com, Imran M Yousuf <imyousuf@smartitengineering.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 05 11:11:59 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jswjg-000545-20
	for gcvg-git-2@gmane.org; Mon, 05 May 2008 11:11:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755860AbYEEJLE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 5 May 2008 05:11:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755862AbYEEJLD
	(ORCPT <rfc822;git-outgoing>); Mon, 5 May 2008 05:11:03 -0400
Received: from nf-out-0910.google.com ([64.233.182.187]:64628 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755845AbYEEJLB (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 May 2008 05:11:01 -0400
Received: by nf-out-0910.google.com with SMTP id d3so1027289nfc.21
        for <git@vger.kernel.org>; Mon, 05 May 2008 02:11:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=o4ezIo05T/Vbra8M2ahwqTxN3gRwlWa/9y1dbInpQjg=;
        b=mSzT3WErUMxVboc6upOQcyKCpAb8SOFgc76ed1ROs5f3ioJwbOHVS4SxgnvkS7b3wElFrdpiiRzI6GHNDpZZcrkRDMlMmXp3hyQfWZQH3tclKS8un0rDqH4pe5+I5rOcf9lHHauXpo4w+Kii3kSJ1UvFG2l5G+7iIInZ4MRG+t0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=nW02FiHrGkrzIGMdSPxn9su71OWgQmzpzAKQFtoiT7JbnxFRfJT5gkesacoA2sKsqgZpRTNxBxiVe/HjPLHfboQ2WASOcYKWqai+9847Prl4+ATtKfIWRfv5yOtF1TWKqOUcZd/kHzRiHJc2oMMbvMS5ag+NNY6t98o/3Lqa/K0=
Received: by 10.210.41.14 with SMTP id o14mr5365058ebo.137.1209978660306;
        Mon, 05 May 2008 02:11:00 -0700 (PDT)
Received: from localhost ( [62.101.198.35])
        by mx.google.com with ESMTPS id f4sm48140276nfh.0.2008.05.05.02.10.56
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 05 May 2008 02:10:59 -0700 (PDT)
X-Mailer: git-send-email 1.5.4.2
In-Reply-To: <1209978582-5785-4-git-send-email-imyousuf@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81260>

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
