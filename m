From: Stephen Boyd <bebarino@gmail.com>
Subject: [PATCHv2 2/3] git-am.txt: Use date or value instead of time or timestamp
Date: Mon, 04 May 2009 22:19:00 -0700
Message-ID: <49FFCC44.60209@gmail.com>
Reply-To: 7vprep49h3.fsf@alter.siamese.dyndns.org
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue May 05 07:19:23 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M1D3p-0000nT-Ku
	for gcvg-git-2@gmane.org; Tue, 05 May 2009 07:19:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752240AbZEEFTK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 5 May 2009 01:19:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750969AbZEEFTH
	(ORCPT <rfc822;git-outgoing>); Tue, 5 May 2009 01:19:07 -0400
Received: from wa-out-1112.google.com ([209.85.146.181]:1594 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752033AbZEEFTE (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 May 2009 01:19:04 -0400
Received: by wa-out-1112.google.com with SMTP id j5so2385825wah.21
        for <git@vger.kernel.org>; Mon, 04 May 2009 22:19:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:reply-to
         :user-agent:mime-version:to:cc:subject:content-type
         :content-transfer-encoding;
        bh=GyIFZvrd9M5c5tdglYXo0BGHTWzbuh7BBKV/MeU8Jnc=;
        b=uvyj2BKxvKbI8i39TKtg27UGIqn7Qt/Bse5AqT1TVxQlIj1BH6mUcB0Lj+gmK852N0
         l9c26zdyhk+PJ0srB7HswSOguCjND1WEFfNYxMGzBPgmkMiauUAhlyYc+pYbiGOwbIu2
         Q06OpZs5rLES9zGzSJ4Pn/37wCdlDumdmHwkc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:reply-to:user-agent:mime-version:to:cc:subject
         :content-type:content-transfer-encoding;
        b=BjhwtTmmCSYQrySn8nz8Azhm8xj8e9xoa+m3PfVkfwIUXa3UJsgbJvFuGLIUKOdDH+
         GLPYK0qlBos35P7s4PBEp8bBzkjxHnm5/jb0O2hUSVR8ALK6Bj2jKqfdFplWo5gk1sGY
         Zi2Z9To+Y71ZkJak0UWlyefW8HUS1oU1KQ4hQ=
Received: by 10.114.159.17 with SMTP id h17mr4831428wae.197.1241500743962;
        Mon, 04 May 2009 22:19:03 -0700 (PDT)
Received: from ?192.168.1.2? ([76.89.212.195])
        by mx.google.com with ESMTPS id v9sm10923526wah.36.2009.05.04.22.19.01
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 04 May 2009 22:19:03 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.21 (X11/20090429)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118279>

Signed-off-by: Stephen Boyd <bebarino@gmail.com>
---
 Documentation/git-am.txt |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/Documentation/git-am.txt b/Documentation/git-am.txt
index a497010..ea84cbb 100644
--- a/Documentation/git-am.txt
+++ b/Documentation/git-am.txt
@@ -79,14 +79,14 @@ default.   You can use `--no-utf8` to override this.
 	message as the commit author date, and uses the time of
 	commit creation as the committer date. This allows the
 	user to lie about the committer date by using the same
-	timestamp as the author date.
+	value as the author date.
 
 --ignore-date::
 	By default the command records the date from the e-mail
 	message as the commit author date, and uses the time of
 	commit creation as the committer date. This allows the
-	user to lie about author timestamp by using the same
-	timestamp as the committer date.
+	user to lie about the author date by using the same
+	value as the committer date.
 
 --skip::
 	Skip the current patch.  This is only meaningful when
@@ -115,7 +115,7 @@ DISCUSSION
 ----------
 
 The commit author name is taken from the "From: " line of the
-message, and commit author time is taken from the "Date: " line
+message, and commit author date is taken from the "Date: " line
 of the message.  The "Subject: " line is used as the title of
 the commit, after stripping common prefix "[PATCH <anything>]".
 The "Subject: " line is supposed to concisely describe what the
-- 
1.6.2.3
