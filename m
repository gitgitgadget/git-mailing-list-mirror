From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH 5/5] Documentation/remote-helpers: Fix typos and improve language
Date: Sun, 18 Apr 2010 06:27:37 +0530
Message-ID: <1271552246-sup-817@kytes>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: Ilari Liusvaara <ilari.liusvaara@elisanet.fi>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Gabriel Filion <lelutin@gmail.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Apr 18 02:59:50 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O3IrV-0005QT-5E
	for gcvg-git-2@lo.gmane.org; Sun, 18 Apr 2010 02:59:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756260Ab0DRA7o (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 17 Apr 2010 20:59:44 -0400
Received: from mail-yx0-f191.google.com ([209.85.210.191]:36402 "EHLO
	mail-yx0-f191.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754451Ab0DRA7n (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 17 Apr 2010 20:59:43 -0400
Received: by yxe29 with SMTP id 29so1859814yxe.4
        for <git@vger.kernel.org>; Sat, 17 Apr 2010 17:59:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:content-type:cc:subject:from
         :to:date:message-id:user-agent:content-transfer-encoding;
        bh=96XTou35qRU5BHO7wCbzcLQ444dEAdel/FGIElPBk4U=;
        b=pR7lLhXrdgwPiNYln4NhHQZ5GcfWzGoGVnuyycgprDxIjcpvczW/CaNqnA3thC1DUM
         wtWDxkLUk9fPsypMH7qdDHydV839apE8wcDsDQp5/ZycYHMMV4OswIJ5ad25AgfSOmsq
         L4dDow/xMopza7YP/0JTRY9XTGqcEOf9PylM0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=content-type:cc:subject:from:to:date:message-id:user-agent
         :content-transfer-encoding;
        b=unczrlF7o5lB2vYKPIfo1DdM9mhO82b/WGzLUBQNaBi8GN4qwotjolJnJYauuh6Iks
         jAzSX0jI31v88n0MdgOcU4dlQsQjOHJFMu1vV5gBUmNYt5WYJnICfT+YSgbP14kllJjx
         DieMzNMGJ2sehrQvq1/GS2LwodWtguZbkFOl8=
Received: by 10.150.14.2 with SMTP id 2mr3954233ybn.12.1271552382478;
        Sat, 17 Apr 2010 17:59:42 -0700 (PDT)
Received: from localhost ([203.110.240.41])
        by mx.google.com with ESMTPS id 21sm3333695iwn.11.2010.04.17.17.59.40
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 17 Apr 2010 17:59:41 -0700 (PDT)
User-Agent: Sup/git
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145200>

Fix some typos and errors in grammar and tense.

Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
---
 Documentation/git-remote-helpers.txt |   51 +++++++++++++++------------------
 1 files changed, 23 insertions(+), 28 deletions(-)

diff --git a/Documentation/git-remote-helpers.txt b/Documentation/git-remote-helpers.txt
index 1d0de7f..6ffc0da 100644
--- a/Documentation/git-remote-helpers.txt
+++ b/Documentation/git-remote-helpers.txt
@@ -73,8 +73,8 @@ Commands are given by the caller on the helper's standard input, one per line.
 
 'capabilities'::
 	Lists the capabilities of the helper, one per line, ending
-	with a blank line. Each capability may be preceded with '*'.
-	This marks them mandatory for git version using the remote
+	with a blank line. Each capability may be preceded with '*',
+	which marks them mandatory for git version using the remote
 	helper to understand (unknown mandatory capability is fatal
 	error).
 
@@ -83,27 +83,27 @@ Commands are given by the caller on the helper's standard input, one per line.
 	[<attr> ...]". The value may be a hex sha1 hash, "@<dest>" for
 	a symref, or "?" to indicate that the helper could not get the
 	value of the ref. A space-separated list of attributes follows
-	the name; unrecognized attributes are ignored. After the
-	complete list, outputs a blank line.
+	the name; unrecognized attributes are ignored. The list ends
+	with a blank line.
 +
 If 'push' is supported this may be called as 'list for-push'
 to obtain the current refs prior to sending one or more 'push'
 commands to the helper.
 
 'option' <name> <value>::
-	Set the transport helper option <name> to <value>.  Outputs a
+	Sets the transport helper option <name> to <value>.  Outputs a
 	single line containing one of 'ok' (option successfully set),
 	'unsupported' (option not recognized) or 'error <msg>'
-	(option <name> is supported but <value> is not correct
+	(option <name> is supported but <value> is not valid
 	for it).  Options should be set before other commands,
-	and may how those commands behave.
+	and may influence the behavior of those commands.
 +
 Supported if the helper has the "option" capability.
 
 'fetch' <sha1> <name>::
 	Fetches the given object, writing the necessary objects
 	to the database.  Fetch commands are sent in a batch, one
-	per line, and the batch is terminated with a blank line.
+	per line, terminated with a blank line.
 	Outputs a single blank line when all fetch commands in the
 	same batch are complete. Only objects which were reported
 	in the ref list with a sha1 may be fetched this way.
@@ -115,7 +115,7 @@ suitably updated.
 Supported if the helper has the "fetch" capability.
 
 'push' +<src>:<dst>::
-	Pushes the given <src> commit or branch locally to the
+	Pushes the given local <src> commit or branch to the
 	remote branch described by <dst>.  A batch sequence of
 	one or more push commands is terminated with a blank line.
 +
@@ -139,6 +139,9 @@ Supported if the helper has the "push" capability.
 	by applying the refspecs from the "refspec" capability to the
 	name of the ref.
 +
+Especially useful for interoperability with a foreign versioning
+system.
++
 Supported if the helper has the "import" capability.
 
 'connect' <service>::
@@ -167,16 +170,11 @@ CAPABILITIES
 ------------
 
 'fetch'::
-	This helper supports the 'fetch' command.
-
 'option'::
-	This helper supports the option command.
-
 'push'::
-	This helper supports the 'push' command.
-
 'import'::
-	This helper supports the 'import' command.
+'connect'::
+	This helper supports the corresponding command with the same name.
 
 'refspec' 'spec'::
 	When using the import command, expect the source ref to have
@@ -188,9 +186,6 @@ CAPABILITIES
 	all, it must cover all refs reported by the list command; if
 	it is not used, it is effectively "*:*"
 
-'connect'::
-	This helper supports the 'connect' command.
-
 REF LIST ATTRIBUTES
 -------------------
 
@@ -206,19 +201,19 @@ REF LIST ATTRIBUTES
 OPTIONS
 -------
 'option verbosity' <N>::
-	Change the level of messages displayed by the helper.
-	When N is 0 the end-user has asked the process to be
-	quiet, and the helper should produce only error output.
-	N of 1 is the default level of verbosity, higher values
+	Changes the verbosity of messages displayed by the helper.
+	A value of 0 for N means that processes operate
+	quietly, and the helper produces only error output.
+	1 is the default level of verbosity, and higher values
 	of N correspond to the number of -v flags passed on the
 	command line.
 
 'option progress' \{'true'|'false'\}::
-	Enable (or disable) progress messages displayed by the
+	Enables (or disables) progress messages displayed by the
 	transport helper during a command.
 
 'option depth' <depth>::
-	Deepen the history of a shallow repository.
+	Deepens the history of a shallow repository.
 
 'option followtags' \{'true'|'false'\}::
 	If enabled the helper should automatically fetch annotated
@@ -234,9 +229,9 @@ OPTIONS
 	helpers this only applies to the 'push', if supported.
 
 'option servpath <c-style-quoted-path>'::
-	Set service path (--upload-pack, --receive-pack etc.) for
-	next connect. Remote helper MAY support this option. Remote
-	helper MUST NOT rely on this option being set before
+	Sets service path (--upload-pack, --receive-pack etc.) for
+	next connect. Remote helper may support this option, but
+	must not rely on this option being set before
 	connect request occurs.
 
 SEE ALSO
-- 
1.7.0.4
