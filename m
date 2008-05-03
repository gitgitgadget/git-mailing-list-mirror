From: imyousuf@gmail.com
Subject: [PATCH 5/5] Add documentation for the recurse subcommand
Date: Sat,  3 May 2008 19:53:33 +0600
Message-ID: <1209822813-12237-5-git-send-email-imyousuf@gmail.com>
References: <1209822813-12237-1-git-send-email-imyousuf@gmail.com>
 <1209822813-12237-2-git-send-email-imyousuf@gmail.com>
 <1209822813-12237-3-git-send-email-imyousuf@gmail.com>
 <1209822813-12237-4-git-send-email-imyousuf@gmail.com>
Cc: gitster@pobox.com, Imran M Yousuf <imyousuf@smartitengineering.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 03 15:55:38 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JsICx-0005Uk-RJ
	for gcvg-git-2@gmane.org; Sat, 03 May 2008 15:55:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755427AbYECNyY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 3 May 2008 09:54:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755325AbYECNyX
	(ORCPT <rfc822;git-outgoing>); Sat, 3 May 2008 09:54:23 -0400
Received: from ug-out-1314.google.com ([66.249.92.169]:60977 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755387AbYECNyW (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 3 May 2008 09:54:22 -0400
Received: by ug-out-1314.google.com with SMTP id h3so301813ugf.16
        for <git@vger.kernel.org>; Sat, 03 May 2008 06:54:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=c1pYxQxYBW1rtwHeBlMlmbAq/rQiQSwGiYZBR75Ay7I=;
        b=XyY1DY/9TO4jaVbKV5SmWEk9Y8twZGaR+3SDKDfFDUPsxKRfu2wV4u1haMFkVmREGjfKLavybSM6RmfFU3vk2x/Itcy6EyP+VHACYPEfEO9HwTvfNWGQKV3ySO0YqUY3qfwogObBzL25Au8NLyGspJRESCews2VOelvWG8BjuhM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=xoPPgPRZXU1WF2U48oYc00N8+GfJ0MyjsQznIesiPpiZOZNgidHNSijgjHB2H7CFEdF+sHNdKfAXht+V43KhcylFEgIC17ApDVp4Dlr18Ix3cNnPHZ2kU2klyBAfOabRaMBfCcbo1Ll0hIG8KmArAawoGji8vFH/hUW+Mi/NztY=
Received: by 10.67.87.18 with SMTP id p18mr530747ugl.43.1209822861887;
        Sat, 03 May 2008 06:54:21 -0700 (PDT)
Received: from localhost ( [122.248.32.83])
        by mx.google.com with ESMTPS id x33sm652600ugc.68.2008.05.03.06.54.19
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 03 May 2008 06:54:21 -0700 (PDT)
X-Mailer: git-send-email 1.5.4.2
In-Reply-To: <1209822813-12237-4-git-send-email-imyousuf@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81085>

From: Imran M Yousuf <imyousuf@smartitengineering.com>

Documentation with brief description is added for the recurse
sucommand along with its arguments and their nature.

Signed-off-by: Imran M Yousuf <imyousuf@smartitengineering.com>
---
 Documentation/git-submodule.txt |   35 +++++++++++++++++++++++++++++++++++
 1 files changed, 35 insertions(+), 0 deletions(-)

diff --git a/Documentation/git-submodule.txt b/Documentation/git-submodule.txt
index 6ffd896..613d5b4 100644
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
