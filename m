From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 5/5] Documentation: publicize hints for sending patches with
 GMail
Date: Thu, 14 Apr 2011 21:33:57 -0500
Message-ID: <20110415023357.GF19829@elie>
References: <87d3kq6tz7.fsf@rho.meyering.net>
 <1302719749.21047.6.camel@drew-northup.unet.maine.edu>
 <87mxjtn8x7.fsf@rho.meyering.net>
 <20110413221736.GA773@elie>
 <7vzkntkc9d.fsf@alter.siamese.dyndns.org>
 <20110414211125.GA15277@elie>
 <7vlizcfpz8.fsf@alter.siamese.dyndns.org>
 <20110415021100.GA19829@elie>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jim Meyering <jim@meyering.net>,
	Drew Northup <drew.northup@maine.edu>,
	git list <git@vger.kernel.org>,
	Yann Dirson <ydirson@altern.org>,
	Stephen Boyd <bebarino@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Apr 15 04:34:16 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QAYrL-00084O-CA
	for gcvg-git-2@lo.gmane.org; Fri, 15 Apr 2011 04:34:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755197Ab1DOCeF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 Apr 2011 22:34:05 -0400
Received: from mail-iy0-f174.google.com ([209.85.210.174]:35327 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755029Ab1DOCeD (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Apr 2011 22:34:03 -0400
Received: by iyb14 with SMTP id 14so1883867iyb.19
        for <git@vger.kernel.org>; Thu, 14 Apr 2011 19:34:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=U4xb6yq4egfpevhwkFbatOE3MIqvP1+VGPtvCgjy2SM=;
        b=wg7gPvF1T0SpOpHt9VWzhY/G8Q4HyYMqf3JdeJ14bcEcZfMiNPFQzAnmUM60o3BQy8
         czqrHw3ITelS4HJJ5hQg7X3mHe4WO5OxPuxHzj9b9VL72nQ38d2O8HWv6WwsSTWCaeDh
         fd0l5paSbUBnMSqDDqtwUNrsNh3F3MjhpNB7Y=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=CpxC4CcEXfSz8ye2v/iNXkFF7s1ej+5BHV/cu9mHfPXTX3ULkEUiABdkt4UZLtl9KB
         yQnF9ZMHIVVpXyOjhUkmIDTSMZ7KoC+8MqMpE3uhsGVgbb5LeUM5FVS/t/EpKVbM7yZj
         riABnU7tAa6sFUkdgPbWmCUfvESjSvC6je1cc=
Received: by 10.231.150.205 with SMTP id z13mr1251271ibv.177.1302834841925;
        Thu, 14 Apr 2011 19:34:01 -0700 (PDT)
Received: from elie (adsl-69-209-64-230.dsl.chcgil.ameritech.net [69.209.64.230])
        by mx.google.com with ESMTPS id gy41sm1537851ibb.5.2011.04.14.19.34.00
        (version=SSLv3 cipher=OTHER);
        Thu, 14 Apr 2011 19:34:01 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20110415021100.GA19829@elie>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171581>

The hints in SubmittingPatches about stopping GMail from clobbering
patches are widely useful both as examples of "git send-email" and
"git imap-send" usage.

Move the documentation to the appropriate places.

While at it, don't encourage storing passwords in config files.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
That's the end of the series.  Thoughts welcome as always.

 Documentation/SubmittingPatches    |   54 +----------------------------------
 Documentation/git-format-patch.txt |   14 +++++++++
 Documentation/git-imap-send.txt    |   29 +++++++++++++++++++
 Documentation/git-send-email.txt   |   19 ++++++++++--
 4 files changed, 61 insertions(+), 55 deletions(-)

diff --git a/Documentation/SubmittingPatches b/Documentation/SubmittingPatches
index e9d8c3f..938eccf 100644
--- a/Documentation/SubmittingPatches
+++ b/Documentation/SubmittingPatches
@@ -413,8 +413,8 @@ that or Gentoo did it.) So you need to set the
 it.
 
 
-Thunderbird, KMail
-------------------
+Thunderbird, KMail, GMail
+-------------------------
 
 See the MUA-SPECIFIC HINTS section of git-format-patch(1).
 
@@ -431,53 +431,3 @@ characters (most notably in people's names), and also
 whitespaces (fatal in patches).  Running 'C-u g' to display the
 message in raw form before using '|' to run the pipe can work
 this problem around.
-
-
-Gmail
------
-
-GMail does not appear to have any way to turn off line wrapping in the web
-interface, so this will mangle any emails that you send.  You can however
-use "git send-email" and send your patches through the GMail SMTP server, or
-use any IMAP email client to connect to the google IMAP server and forward
-the emails through that.
-
-To use "git send-email" and send your patches through the GMail SMTP server,
-edit ~/.gitconfig to specify your account settings:
-
-[sendemail]
-	smtpencryption = tls
-	smtpserver = smtp.gmail.com
-	smtpuser = user@gmail.com
-	smtppass = p4ssw0rd
-	smtpserverport = 587
-
-Once your commits are ready to be sent to the mailing list, run the
-following commands:
-
-  $ git format-patch --cover-letter -M origin/master -o outgoing/
-  $ edit outgoing/0000-*
-  $ git send-email outgoing/*
-
-To submit using the IMAP interface, first, edit your ~/.gitconfig to specify your
-account settings:
-
-[imap]
-	folder = "[Gmail]/Drafts"
-	host = imaps://imap.gmail.com
-	user = user@gmail.com
-	pass = p4ssw0rd
-	port = 993
-	sslverify = false
-
-You might need to instead use: folder = "[Google Mail]/Drafts" if you get an error
-that the "Folder doesn't exist".
-
-Once your commits are ready to be sent to the mailing list, run the
-following commands:
-
-  $ git format-patch --cover-letter -M --stdout origin/master | git imap-send
-
-Just make sure to disable line wrapping in the email client (GMail web
-interface will line wrap no matter what, so you need to use a real
-IMAP client).
diff --git a/Documentation/git-format-patch.txt b/Documentation/git-format-patch.txt
index 8887375..c44e248 100644
--- a/Documentation/git-format-patch.txt
+++ b/Documentation/git-format-patch.txt
@@ -337,6 +337,20 @@ MUA-SPECIFIC HINTS
 Here are some hints on how to successfully submit patches inline using
 various mailers.
 
+GMail
+~~~~~
+GMail does not have any way to turn off line wrapping in the web
+interface, so it will mangle any emails that you send.  You can however
+use "git send-email" and send your patches through the GMail SMTP server, or
+use any IMAP email client to connect to the google IMAP server and forward
+the emails through that.
+
+For hints on using 'git send-email' to send your patches through the
+GMail SMTP server, see the EXAMPLE section of linkgit:git-send-email[1].
+
+For hints on submission using the IMAP interface, see the EXAMPLE
+section of linkgit:git-imap-send[1].
+
 Thunderbird
 ~~~~~~~~~~~
 By default, Thunderbird will both wrap emails as well as flag
diff --git a/Documentation/git-imap-send.txt b/Documentation/git-imap-send.txt
index d3013d6..4e09708 100644
--- a/Documentation/git-imap-send.txt
+++ b/Documentation/git-imap-send.txt
@@ -111,6 +111,31 @@ Using direct mode with SSL:
 ..........................
 
 
+EXAMPLE
+-------
+To submit patches using GMail's IMAP interface, first, edit your ~/.gitconfig
+to specify your account settings:
+
+---------
+[imap]
+	folder = "[Gmail]/Drafts"
+	host = imaps://imap.gmail.com
+	user = user@gmail.com
+	port = 993
+	sslverify = false
+---------
+
+You might need to instead use: folder = "[Google Mail]/Drafts" if you get an error
+that the "Folder doesn't exist".
+
+Once the commits are ready to be sent, run the following command:
+
+  $ git format-patch --cover-letter -M --stdout origin/master | git imap-send
+
+Just make sure to disable line wrapping in the email client (GMail's web
+interface will wrap lines no matter what, so you need to use a real
+IMAP client).
+
 CAUTION
 -------
 It is still your responsibility to make sure that the email message
@@ -124,6 +149,10 @@ Thunderbird in particular is known to be problematic.  Thunderbird
 users may wish to visit this web page for more information:
   http://kb.mozillazine.org/Plain_text_e-mail_-_Thunderbird#Completely_plain_email
 
+SEE ALSO
+--------
+linkgit:git-format-patch[1], linkgit:git-send-email[1], mbox(5)
+
 GIT
 ---
 Part of the linkgit:git[1] suite
diff --git a/Documentation/git-send-email.txt b/Documentation/git-send-email.txt
index ee14f74..5a168cf 100644
--- a/Documentation/git-send-email.txt
+++ b/Documentation/git-send-email.txt
@@ -348,10 +348,12 @@ sendemail.confirm::
 	one of 'always', 'never', 'cc', 'compose', or 'auto'. See '--confirm'
 	in the previous section for the meaning of these values.
 
+EXAMPLE
+-------
 Use gmail as the smtp server
-----------------------------
-
-Add the following section to the config file:
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+To use 'git send-email' to send your patches through the GMail SMTP server,
+edit ~/.gitconfig to specify your account settings:
 
 	[sendemail]
 		smtpencryption = tls
@@ -359,9 +361,20 @@ Add the following section to the config file:
 		smtpuser = yourname@gmail.com
 		smtpserverport = 587
 
+Once your commits are ready to be sent to the mailing list, run the
+following commands:
+
+	$ git format-patch --cover-letter -M origin/master -o outgoing/
+	$ edit outgoing/0000-*
+	$ git send-email outgoing/*
+
 Note: the following perl modules are required
       Net::SMTP::SSL, MIME::Base64 and Authen::SASL
 
+SEE ALSO
+--------
+linkgit:git-format-patch[1], linkgit:git-imap-send[1], mbox(5)
+
 GIT
 ---
 Part of the linkgit:git[1] suite
-- 
1.7.5.rc0
