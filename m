From: Stephen Boyd <bebarino@gmail.com>
Subject: [PATCH] git-send-email.txt: describe --compose better
Date: Mon, 16 Mar 2009 00:44:57 -0700
Message-ID: <780e0a6b0903160044u301e65c7sc75e3f5b8230273c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Mar 16 08:46:44 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lj7Wy-0005ew-Qe
	for gcvg-git-2@gmane.org; Mon, 16 Mar 2009 08:46:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755876AbZCPHpB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Mar 2009 03:45:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752512AbZCPHpA
	(ORCPT <rfc822;git-outgoing>); Mon, 16 Mar 2009 03:45:00 -0400
Received: from wf-out-1314.google.com ([209.85.200.172]:6657 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755625AbZCPHo7 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Mar 2009 03:44:59 -0400
Received: by wf-out-1314.google.com with SMTP id 28so1775018wfa.4
        for <git@vger.kernel.org>; Mon, 16 Mar 2009 00:44:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:date:message-id:subject
         :from:to:content-type:content-transfer-encoding;
        bh=P17ldNF8OOdxB+fCGsDYPYs6hAzlAqM5g2jmjiuUkX4=;
        b=JS6SIfj7AeFoCq5u8vb3Qq7u3UMR4KsZthalDdR8Huleu9u3gIzubozGZ6SUYHb0LJ
         7n24Wlrl3kLfWd9WIx3pffp/60EffySRT6q/CAzm+sKFA8EP/Cz/o7Upo+RQOitePqMp
         UHdeBbaiGj+ibEqLC2W3GAVJXDDLM0K6FrIwQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type
         :content-transfer-encoding;
        b=nWAicKiCYPHKCS+IB2uwG2Xa49SMEWY+n+H0wiER18Rvgl5l211yXsE8bpVRDmz6bG
         ErFPpgH5BkrAMAhuSw9IA+sv3aLs3zmP02PvcNUO//NhS6IHbtD33BcFGKgQi7fSUZrm
         Q8cdUfn9k9w5ePZRfPPEyR/K3khwCRWCkPdL0=
Received: by 10.143.4.16 with SMTP id g16mr2007089wfi.307.1237189497412; Mon, 
	16 Mar 2009 00:44:57 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113313>

Signed-off-by: Stephen Boyd <bebarino@gmail.com>
---
 Documentation/git-send-email.txt |   13 ++++++-------
 1 files changed, 6 insertions(+), 7 deletions(-)

diff --git a/Documentation/git-send-email.txt b/Documentation/git-send-email.txt
index 14dfb50..10dfd66 100644
--- a/Documentation/git-send-email.txt
+++ b/Documentation/git-send-email.txt
@@ -60,14 +60,13 @@ The --cc option must be repeated for each user you
want on the cc list.
 	Use $GIT_EDITOR, core.editor, $VISUAL, or $EDITOR to edit an
 	introductory message for the patch series.
 +
-When '--compose' is used, git send-email gets less interactive will use the
-values of the headers you set there. If the body of the email (what you type
-after the headers and a blank line) only contains blank (or GIT: prefixed)
-lines, the summary won't be sent, but git-send-email will still use the
-Headers values if you don't removed them.
+When '--compose' is used, git send-email will use the From, Subject, and
+In-Reply-To headers specified in the message. If the body of the message
+(what you type after the headers and a blank line) only contains blank
+(or GIT: prefixed) lines the summary won't be sent, but From, Subject,
+and In-Reply-To headers will be used unless they are removed.
 +
-If it wasn't able to see a header in the summary it will ask you about it
-interactively after quitting your editor.
+Missing From or In-Reply-To headers will be prompted for.

 --from::
 	Specify the sender of the emails.  This will default to
-- 
1.6.2
