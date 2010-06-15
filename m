From: Stephen Boyd <bebarino@gmail.com>
Subject: [PATCH 2/2] completion: Add --signoff and format.signoff
Date: Mon, 14 Jun 2010 22:00:39 -0700
Message-ID: <1276578039-25023-2-git-send-email-bebarino@gmail.com>
References: <1276578039-25023-1-git-send-email-bebarino@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	"Shawn O. Pearce" <spearce@spearce.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 15 07:01:04 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OOOGm-00023j-3B
	for gcvg-git-2@lo.gmane.org; Tue, 15 Jun 2010 07:01:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751594Ab0FOFAs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Jun 2010 01:00:48 -0400
Received: from mail-vw0-f46.google.com ([209.85.212.46]:59474 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751097Ab0FOFAq (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Jun 2010 01:00:46 -0400
Received: by mail-vw0-f46.google.com with SMTP id 13so735784vws.19
        for <git@vger.kernel.org>; Mon, 14 Jun 2010 22:00:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=pjTct5FwzZSarSRs2WMTH0UtdVvljBSvM/Zk71U5GV0=;
        b=Kexxx4RzSDtlP5kmqY4IWeOL/IP53tu7gRFgiVcE8Kj2tWktgBm8UYi0Ktyebj+I1M
         g+3eZ/FUyyTRDB+8PiAiqgia6IU9ozbjDO2+CLF4znfHaJW4CwoviHwpUhZC0wQGdPwy
         DgAzwlRO6uxgEsb2aq4UGfrXnwv7msKTCPnQM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=BXLlJ3QLalZbQ4wFKpEdeCco6g9l7FKxne1FdFBCvcW+7MtCU25IiRv0lJyeZ3F+tT
         66Xsebn0K7mq69kmaVV7wim/QDtGc54HDdrepNi8W4MheYH7/4MQBCNFM8AZDdGUqTn7
         4aMBxfIH08RSBqQq/WlUdEY4Zsh6mRIfRNC4E=
Received: by 10.224.35.149 with SMTP id p21mr2693494qad.374.1276578045425;
        Mon, 14 Jun 2010 22:00:45 -0700 (PDT)
Received: from localhost ([24.152.169.138])
        by mx.google.com with ESMTPS id x34sm25961310qce.15.2010.06.14.22.00.44
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 14 Jun 2010 22:00:44 -0700 (PDT)
X-Mailer: git-send-email 1.7.1.257.g678728
In-Reply-To: <1276578039-25023-1-git-send-email-bebarino@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149159>

Cc: Shawn O. Pearce <spearce@spearce.org>
Signed-off-by: Stephen Boyd <bebarino@gmail.com>
---

Feel free to squash.

 contrib/completion/git-completion.bash |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 57245a8..9ca54e0 100755
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -1052,7 +1052,7 @@ _git_format_patch ()
 			--numbered --start-number
 			--numbered-files
 			--keep-subject
-			--signoff
+			--signoff --signature
 			--in-reply-to= --cc=
 			--full-index --binary
 			--not --all
@@ -1726,6 +1726,7 @@ _git_config ()
 		format.headers
 		format.numbered
 		format.pretty
+		format.signature
 		format.signoff
 		format.subjectprefix
 		format.suffix
-- 
1.7.1.257.g678728
