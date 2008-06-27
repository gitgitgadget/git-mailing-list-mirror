From: Marek Zawirski <marek.zawirski@gmail.com>
Subject: [EGIT PATCH 19/23] Repository search for command line tools
Date: Sat, 28 Jun 2008 00:06:43 +0200
Message-ID: <1214604407-30572-20-git-send-email-marek.zawirski@gmail.com>
References: <1214604407-30572-1-git-send-email-marek.zawirski@gmail.com>
 <1214604407-30572-2-git-send-email-marek.zawirski@gmail.com>
 <1214604407-30572-3-git-send-email-marek.zawirski@gmail.com>
 <1214604407-30572-4-git-send-email-marek.zawirski@gmail.com>
 <1214604407-30572-5-git-send-email-marek.zawirski@gmail.com>
 <1214604407-30572-6-git-send-email-marek.zawirski@gmail.com>
 <1214604407-30572-7-git-send-email-marek.zawirski@gmail.com>
 <1214604407-30572-8-git-send-email-marek.zawirski@gmail.com>
 <1214604407-30572-9-git-send-email-marek.zawirski@gmail.com>
 <1214604407-30572-10-git-send-email-marek.zawirski@gmail.com>
 <1214604407-30572-11-git-send-email-marek.zawirski@gmail.com>
 <1214604407-30572-12-git-send-email-marek.zawirski@gmail.com>
 <1214604407-30572-13-git-send-email-marek.zawirski@gmail.com>
 <1214604407-30572-14-git-send-email-marek.zawirski@gmail.com>
 <1214604407-30572-15-git-send-email-marek.zawirski@gmail.com>
 <1214604407-30572-16-git-send-email-marek.zawirski@gmail.com>
 <1214604407-30572-17-git-send-email-marek.zawirski@gmail.com>
 <1214604407-30572-18-git-send-email-marek.zawirski@gmail.com>
 <1214604407-30572-19-git-send-email-marek.zawirski@gmail.com>
Cc: git@vger.kernel.org, Marek Zawirski <marek.zawirski@gmail.com>
To: robin.rosenberg@dewire.com, spearce@spearce.org
X-From: git-owner@vger.kernel.org Sat Jun 28 00:10:30 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KCM97-0001Lw-JE
	for gcvg-git-2@gmane.org; Sat, 28 Jun 2008 00:10:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758793AbYF0WIc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 Jun 2008 18:08:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762970AbYF0WIa
	(ORCPT <rfc822;git-outgoing>); Fri, 27 Jun 2008 18:08:30 -0400
Received: from nf-out-0910.google.com ([64.233.182.187]:38733 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757976AbYF0WIW (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Jun 2008 18:08:22 -0400
Received: by nf-out-0910.google.com with SMTP id d3so182445nfc.21
        for <git@vger.kernel.org>; Fri, 27 Jun 2008 15:08:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=jaNapEFeGkLBxju6T3NQmw4zD6zmB6zo2HAbEHQFAvU=;
        b=omUR84EnRey3lXv2SiRMObkw27JOsDHzi8EmaGr1Pw48IaT9ZXoMRaRVa0Vnkw7rIg
         mJIowQpWIfZruqr5wICPXsJ7wjDqMz11xsrQUjEpaoJp9S60M/mUUoskLWtzf9Dvex6P
         /NijTBoav4VDUhlelVfefDitv5rCUhVwLT+8g=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=ZNXlAT8MCyIVbFeYHYZWZ5Vpv3cHQKjZnT3VH3LyaCPuz9iyb5tZ/SghAGnKiBSRo0
         ceQq71vivUu2fSn+30byeDf2Ml/bYZsTuZ9iGUXEibwbaOr33/SKwg8oexiJxJa8+5qI
         Gq+dCKaKtW7teWffByehdFzmUM3e/5lCrvv94=
Received: by 10.210.102.12 with SMTP id z12mr1617298ebb.52.1214604501358;
        Fri, 27 Jun 2008 15:08:21 -0700 (PDT)
Received: from localhost ( [62.21.19.93])
        by mx.google.com with ESMTPS id b33sm2446692ika.2.2008.06.27.15.08.19
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 27 Jun 2008 15:08:20 -0700 (PDT)
X-Mailer: git-send-email 1.5.5.4
In-Reply-To: <1214604407-30572-19-git-send-email-marek.zawirski@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86662>

Introducing some simple search for git repository in parent directories
of current directory.

Previous version was annoying: we had to be in directory that contains
.git/ or specify it explicitly by --git-dir.

Signed-off-by: Marek Zawirski <marek.zawirski@gmail.com>
---
 .../src/org/spearce/jgit/pgm/Main.java             |   24 +++++++++++++++++--
 1 files changed, 21 insertions(+), 3 deletions(-)

diff --git a/org.spearce.jgit/src/org/spearce/jgit/pgm/Main.java b/org.spearce.jgit/src/org/spearce/jgit/pgm/Main.java
index 44f8a42..8afd0d7 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/pgm/Main.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/pgm/Main.java
@@ -85,12 +85,12 @@ public class Main {
 
 	private static void execute(final String[] argv) throws Exception {
 		int argi = 0;
-		String gitdir = ".git";
 
+		File gitdir = null;
 		for (; argi < argv.length; argi++) {
 			final String arg = argv[argi];
 			if (arg.startsWith("--git-dir="))
-				gitdir = arg.substring("--git-dir=".length());
+				gitdir = new File(arg.substring("--git-dir=".length()));
 			else if (arg.equals("--show-stack-trace"))
 				showStackTrace = true;
 			else if (arg.startsWith("--"))
@@ -101,8 +101,15 @@ public class Main {
 
 		if (argi == argv.length)
 			usage();
+		if (gitdir == null)
+			gitdir = findGitDir();
+		if (gitdir == null || !gitdir.isDirectory()) {
+			System.err.println("error: can't find git directory");
+			System.exit(1);
+		}
+
 		final TextBuiltin cmd = createCommand(argv[argi++]);
-		cmd.db = new Repository(new File(gitdir));
+		cmd.db = new Repository(gitdir);
 		try {
 			cmd.execute(subarray(argv, argi));
 		} finally {
@@ -111,6 +118,17 @@ public class Main {
 		}
 	}
 
+	private static File findGitDir() {
+		File current = new File(".").getAbsoluteFile();
+		while (current != null) {
+			final File gitDir = new File(current, ".git");
+			if (gitDir.isDirectory())
+				return gitDir;
+			current = current.getParentFile();
+		}
+		return null;
+	}
+
 	private static String[] subarray(final String[] argv, final int i) {
 		return Arrays.asList(argv).subList(i, argv.length).toArray(
 				new String[0]);
-- 
1.5.5.3
