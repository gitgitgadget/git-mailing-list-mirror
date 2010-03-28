From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH 2/2] Documentation/remote-helpers: Fix some typos
Date: Sun, 28 Mar 2010 23:34:55 +0530
Message-ID: <f3271551003281104h9b672abk1a8ecccd7a4f8964@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Sverre Rabbelier <srabbelier@gmail.com>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Mar 28 20:11:24 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NvwxE-00075J-Tz
	for gcvg-git-2@lo.gmane.org; Sun, 28 Mar 2010 20:11:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754914Ab0C1SLG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 28 Mar 2010 14:11:06 -0400
Received: from mail-yw0-f198.google.com ([209.85.211.198]:60401 "EHLO
	mail-yw0-f198.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754842Ab0C1SLD (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 28 Mar 2010 14:11:03 -0400
Received: by ywh36 with SMTP id 36so2914039ywh.4
        for <git@vger.kernel.org>; Sun, 28 Mar 2010 11:11:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:from:date:received
         :message-id:subject:to:cc:content-type;
        bh=6xA/yQNWJawUxhoCTOZu79Dz3lSB/GNJwsb+5yBa61M=;
        b=UGnsbBzYSsgmKnO/+LZiSSeCmaLs1lz/1s3S2HCg8FgzXY+TWBFg1pcdudCmCz/4Jv
         1TiHyDbnGwodilZq0DP9dfMpo3q4eM5xvzTE6qu0DDiDuq7GnyathaBKUA8Z4v8sgP6t
         +U7/yYEbfoESNCz8qTBne1nh2yIy85qv0sg30=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:from:date:message-id:subject:to:cc:content-type;
        b=DJdorm/w86kT+Fgen9zyWktqwXMQBbR+lz+Zb2GKv5aHuzehWaajZRCj/9iHq4PM9r
         13ZS0XIlPH9b/IOszt6UaJkOVvPypM9yIc55tojupoo++2yHluhSP7+blWwYrhG+hf6s
         PZkcSU4LJ7itjzXAc529CQgcnGWVhCbnkpXME=
Received: by 10.90.69.14 with HTTP; Sun, 28 Mar 2010 11:04:55 -0700 (PDT)
Received: by 10.91.63.3 with SMTP id q3mr2580622agk.74.1269799519913; Sun, 28 
	Mar 2010 11:05:19 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143414>

Fix some typos.

---
 Documentation/git-remote-helpers.txt |   57 +++++++++++++++------------------
 1 files changed, 26 insertions(+), 31 deletions(-)

diff --git a/Documentation/git-remote-helpers.txt
b/Documentation/git-remote-helpers.txt
index 1304813..2382fb4 100644
--- a/Documentation/git-remote-helpers.txt
+++ b/Documentation/git-remote-helpers.txt
@@ -45,8 +45,8 @@ Commands are given by the caller on the helper's
standard input, one per line.

 'capabilities'::
 	Lists the capabilities of the helper, one per line, ending
-	with a blank line. Each capability may be preceded with '*'.
-	This marks them mandatory for git version using the remote
+	with a blank line. Each capability may be preceded with '*',
+	which marks them mandatory for git version using the remote
 	helper to understand (unknown mandatory capability is fatal
 	error).

@@ -55,27 +55,27 @@ Commands are given by the caller on the helper's
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
@@ -87,7 +87,7 @@ suitably updated.
 Supported if the helper has the "fetch" capability.

 'push' +<src>:<dst>::
-	Pushes the given <src> commit or branch locally to the
+	Pushes the given local <src> commit or branch to the
 	remote branch described by <dst>.  A batch sequence of
 	one or more push commands is terminated with a blank line.
 +
@@ -111,6 +111,9 @@ Supported if the helper has the "push" capability.
 	by applying the refspecs from the "refspec" capability to the
 	name of the ref.
 +
+Especially useful for interoperability with a foreign versioning
+system.
++
 Supported if the helper has the "import" capability.

 'connect' <service>::
@@ -128,9 +131,9 @@ Supported if the helper has the "import" capability.
 Supported if the helper has the "connect" capability.

 If a fatal error occurs, the program writes the error message to
-stderr and exits. The caller should expect that a suitable error
-message has been printed if the child closes the connection without
-completing a valid response for the current command.
+stderr and exits. The caller should expect a suitable error
+if the child closes the connection without
+giving a valid response for the current command.

 Additional commands may be supported, as may be determined from
 capabilities reported by the helper.
@@ -139,16 +142,11 @@ CAPABILITIES
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
@@ -160,9 +158,6 @@ CAPABILITIES
 	all, it must cover all refs reported by the list command; if
 	it is not used, it is effectively "*:*"

-'connect'::
-	This helper supports the 'connect' command.
-
 REF LIST ATTRIBUTES
 -------------------

@@ -178,19 +173,19 @@ REF LIST ATTRIBUTES
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
@@ -206,9 +201,9 @@ OPTIONS
 	helpers this only applies to the 'push', if supported.

 'option servpath <c-style-quoted-path>'::
-	Set service path (--upload-pack, --receive-pack etc.) for
-	next connect. Remote helper MAY support this option. Remote
-	helper MUST NOT rely on this option being set before
+	Sets service path (--upload-pack, --receive-pack etc.) for
+	next connect. Remote helper may support this option, but
+	must not rely on this option being set before
 	connect request occurs.

 Documentation
-- 
1.7.0.3
