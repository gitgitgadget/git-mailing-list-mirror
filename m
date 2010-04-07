From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH v2] Documentation/remote-helpers: Fix typos and improve 
	language
Date: Wed, 7 Apr 2010 14:21:32 +0530
Message-ID: <t2zf3271551004070151had4ef656xe8ef9d04884c6a46@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Sverre Rabbelier <srabbelier@gmail.com>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Apr 07 10:52:09 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NzQzX-0003sg-E2
	for gcvg-git-2@lo.gmane.org; Wed, 07 Apr 2010 10:52:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932373Ab0DGIv4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 Apr 2010 04:51:56 -0400
Received: from mail-gw0-f46.google.com ([74.125.83.46]:51732 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932260Ab0DGIvx (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Apr 2010 04:51:53 -0400
Received: by gwb19 with SMTP id 19so488616gwb.19
        for <git@vger.kernel.org>; Wed, 07 Apr 2010 01:51:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:from:date:received
         :message-id:subject:to:cc:content-type;
        bh=LPKpOpht/tMpswP1ICg2/im4Va6s2MErTeaGYYozm6w=;
        b=HvKtcliPfZdPo+S4+LWhczD4j5FbOE1GNT9r32eb4KbQFZtseAHQDQ8s3jlMU0nLpF
         Q/uddgIi2yjNMDr6OLFJwJvPePhmjm4N+wR6UQG2JALuQ3z2K9yqPpVvNSqAViJrgeqi
         TT5BBEVx0CE/hxgRKtdn5vLah08ADyGc73mqk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:from:date:message-id:subject:to:cc:content-type;
        b=QlDkg9oJuK4B3tLsPiguCjWdLDxoURuA8KX/w0sgYMQvB//X2Mv31KNmIOKMbAk84Z
         hxyfA+VzqlXinSedu6Lb2aQR/CNDsS798RBiRwe67hDcNhhxz4hx7OPibpi2YMAasb+D
         FbDV6FpeZ+ydTFn+brVo4LIlSUCMOmBnoTvYI=
Received: by 10.90.69.14 with HTTP; Wed, 7 Apr 2010 01:51:32 -0700 (PDT)
Received: by 10.90.24.32 with SMTP id 32mr3026740agx.76.1270630312162; Wed, 07 
	Apr 2010 01:51:52 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144205>

Fix some typos and grammar/ tense errors.

Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
---
 Changes since v1: Reverted one bad hunk pointed out by Junio.
 Now rebased to apply cleanly to pu.

 Documentation/git-remote-helpers.txt |   51 +++++++++++++++------------------
 1 files changed, 23 insertions(+), 28 deletions(-)

diff --git a/Documentation/git-remote-helpers.txt
b/Documentation/git-remote-helpers.txt
index 25a0a16..8838388 100644
--- a/Documentation/git-remote-helpers.txt
+++ b/Documentation/git-remote-helpers.txt
@@ -74,8 +74,8 @@ Commands are given by the caller on the helper's
standard input, one per line.

 'capabilities'::
 	Lists the capabilities of the helper, one per line, ending
-	with a blank line. Each capability may be preceded with '*'.
-	This marks them mandatory for git version using the remote
+	with a blank line. Each capability may be preceded with '*',
+	which marks them mandatory for git version using the remote
 	helper to understand (unknown mandatory capability is fatal
 	error).

@@ -84,27 +84,27 @@ Commands are given by the caller on the helper's
standard input, one per line.
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
@@ -116,7 +116,7 @@ suitably updated.
 Supported if the helper has the "fetch" capability.

 'push' +<src>:<dst>::
-	Pushes the given <src> commit or branch locally to the
+	Pushes the given local <src> commit or branch to the
 	remote branch described by <dst>.  A batch sequence of
 	one or more push commands is terminated with a blank line.
 +
@@ -140,6 +140,9 @@ Supported if the helper has the "push" capability.
 	by applying the refspecs from the "refspec" capability to the
 	name of the ref.
 +
+Especially useful for interoperability with a foreign versioning
+system.
++
 Supported if the helper has the "import" capability.

 'connect' <service>::
@@ -168,16 +171,11 @@ CAPABILITIES
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
@@ -189,9 +187,6 @@ CAPABILITIES
 	all, it must cover all refs reported by the list command; if
 	it is not used, it is effectively "*:*"

-'connect'::
-	This helper supports the 'connect' command.
-
 REF LIST ATTRIBUTES
 -------------------

@@ -207,19 +202,19 @@ REF LIST ATTRIBUTES
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
@@ -235,9 +230,9 @@ OPTIONS
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
1.7.0.3
