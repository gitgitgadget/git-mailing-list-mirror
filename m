From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Documentation/SubmittingPatches: Clarify Gmail section
Date: Wed, 07 Apr 2010 15:59:17 -0700
Message-ID: <7v4ojmc1iy.fsf@alter.siamese.dyndns.org>
References: <1270668793-2187-1-git-send-email-artagnon@gmail.com>
 <1270668793-2187-2-git-send-email-artagnon@gmail.com>
 <7vwrwjav4h.fsf@alter.siamese.dyndns.org>
 <y2gf3271551004071318zb4ed7ef6o93a6c98c6009d8df@mail.gmail.com>
 <k2m2cfc40321004071523z8c036cccs12302a70f25bb413@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ramkumar Ramachandra <artagnon@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>,
	John Tapsell <johnflux@gmail.com>,
	Aaron Crane <git@aaroncrane.co.uk>,
	A Large Angry SCM <gitzilla@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Jacob Helwig <jacob.helwig@gmail.com>
To: Jon Seymour <jon.seymour@gmail.com>
X-From: git-owner@vger.kernel.org Thu Apr 08 01:00:10 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NzeEC-00069t-5Q
	for gcvg-git-2@lo.gmane.org; Thu, 08 Apr 2010 01:00:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754448Ab0DGXAA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 Apr 2010 19:00:00 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:50746 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753619Ab0DGXAA (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Apr 2010 19:00:00 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 92ABDA856E;
	Wed,  7 Apr 2010 18:59:40 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=5S83WWzndj2aPi2qqOXmJvlp78I=; b=rpBSMD
	399hS7BKKJF0iqcricZUrUID6VU0IGP/Cu8wCOX/Kvgsj5N1UWTfGk4NsCYvCmP6
	+GRgszZrPo2BVRGaymZwfgIFg72VfOEw5JZr5S7k36Wiqw4nRKuWXnoZa7uQ/z6G
	TNDXdpewEx97o8fyvqqX19UCNA+XXcaeBpF/8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=iQ8i8ZO72rr6zrHKIMkYXQnirXpUCmAJ
	dPPL7Ii1UwqLez5N7ZtmSqzG4poQ5U6NBafQ2D19smiOXBxqv7WyEgCKVkRfjLw6
	Kq80+W1Pmea0YIqdKoye1G4XEJZbwR3Usu/wNS1cinAEqLjbNQA3HPWITyXVHkly
	PVQd5XKuA8E=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 5B9E6A8544;
	Wed,  7 Apr 2010 18:59:30 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 13FFBA8531; Wed,  7 Apr
 2010 18:59:18 -0400 (EDT)
In-Reply-To: <k2m2cfc40321004071523z8c036cccs12302a70f25bb413@mail.gmail.com>
 (Jon Seymour's message of "Thu\, 8 Apr 2010 08\:23\:22 +1000")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 39461662-4299-11DF-B334-D033EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144295>

Jon Seymour <jon.seymour@gmail.com> writes:

> Perhaps the words could be changed to something like:
>
> If you do want to use the imap-send option with Gmail you MUST use an
> IMAP client that does not line wrap to do any final polishing of the
> patch e-mails prior to submitting them to the list. If you use the
> gmail web interface to edit the draft  messages in any way, line
> wrapping WILL occur.

Much better, but my understanding is that "in any way" includes not
touching anything but just specifying the addressee.  So perhaps something
like this is needed:

-- >8 --
Subject: SubmittingPatches: update GMail section

Even if you use imap-send to throw your drafts in the outbox, using their
web interface will mangle your patches.  Clarify that the imap-send is
meant to be used together with a real MUA that can use IMAP drafts, and
remove instructions related to the web interface, which is irrelevant.

Add description of send-email as an alternative.

Use --cover-letter, and do not use -C nor --no-color, on the example
command line for format-patch.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Documentation/SubmittingPatches |   35 ++++++++++++++++++++++++-----------
 1 files changed, 24 insertions(+), 11 deletions(-)

diff --git a/Documentation/SubmittingPatches b/Documentation/SubmittingPatches
index c686f86..abc65de 100644
--- a/Documentation/SubmittingPatches
+++ b/Documentation/SubmittingPatches
@@ -520,11 +520,9 @@ Gmail
 GMail does not appear to have any way to turn off line wrapping in the web
 interface, so this will mangle any emails that you send.  You can however
 use any IMAP email client to connect to the google imap server, and forward
-the emails through that.  Just make sure to disable line wrapping in that
-email client.  Alternatively, use "git send-email" instead.
+the emails through that.
 
-Submitting properly formatted patches via Gmail is simple now that
-IMAP support is available. First, edit your ~/.gitconfig to specify your
+To submit using the IMAP interface, first, edit your ~/.gitconfig to specify your
 account settings:
 
 [imap]
@@ -538,14 +536,29 @@ account settings:
 You might need to instead use: folder = "[Google Mail]/Drafts" if you get an error
 that the "Folder doesn't exist".
 
-Next, ensure that your Gmail settings are correct. In "Settings" the
-"Use Unicode (UTF-8) encoding for outgoing messages" should be checked.
+Once your commits are ready to be sent to the mailing list, run the
+following command to send the patch emails to your Gmail Drafts
+folder.
 
-Once your commits are ready to send to the mailing list, run the following
-command to send the patch emails to your Gmail Drafts folder.
+  $ git format-patch --cover-letter -M --stdout origin/master | git imap-send
 
-	$ git format-patch -M --stdout origin/master | git imap-send
+Just make sure to disable line wrapping in the email client (GMail web
+interface will line wrap no matter what, so you need to use a real
+IMAP client).
 
-Go to your Gmail account, open the Drafts folder, find the patch email, fill
-in the To: and CC: fields and send away!
+Alternatively, you can use "git send-email" and send your patches
+through the GMail SMTP server.  edit ~/.gitconfig to specify your
+account settings:
+
+[sendemail]
+	smtpencryption = tls
+	smtpserver = smtp.gmail.com
+	smtpuser = user@gmail.com
+	smtppass = p4ssw0rd
+	smtpserverport = 587
+
+Once your commits are ready to be sent to the mailing list, run the
+following commands:
 
+  $ git format-patch --cover-letter -M origin/master -o outgoing/
+  $ git send-email outgoing/*
