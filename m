From: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
Subject: [PATCHv2 1/7] CodingGuidelines: mention whitespace preferences for shell scripts
Date: Fri,  3 Dec 2010 17:47:35 +0100
Message-ID: <1291394861-11989-2-git-send-email-giuseppe.bilotta@gmail.com>
References: <1291394861-11989-1-git-send-email-giuseppe.bilotta@gmail.com>
Cc: Christian Couder <christian.couder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Dec 03 17:48:37 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1POYoG-0007II-Ue
	for gcvg-git-2@lo.gmane.org; Fri, 03 Dec 2010 17:48:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753362Ab0LCQsG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 3 Dec 2010 11:48:06 -0500
Received: from mail-gx0-f174.google.com ([209.85.161.174]:42077 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751740Ab0LCQsD (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 Dec 2010 11:48:03 -0500
Received: by gxk1 with SMTP id 1so1942208gxk.19
        for <git@vger.kernel.org>; Fri, 03 Dec 2010 08:48:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=wLM6xXLYuP4al2uX2QCklqLfLCTQf5b8UpIWNX66lWM=;
        b=r2L7JXuRzxok9EUFGFD/l/Thb905+XMZoRpXW9nm3s4fRCpMDuqdl0XPz7XszD1c9o
         6cJ7DiRSeifpSClpyWEEFDAYubH0MFYzUuwJKhQDG8eP1p3wgGudTuF0W+VKSntTjUeQ
         w3529QC/ZMxeiGrc0A+gGHCBtYc02oow72UxI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=OBj62PK90dW7gp4S8wIgsXbXdKiezcjPNDyVFYqSrma/lg3qolwJhd5kQWNvbYI/gl
         5VQqXSYHt5LPS0TZr6qiCnkPkYzc28AN8F9T5+1vd2x7QLpSflN+1HK51+WtsfaJLQSq
         D2l/fU6hoza5B/vAJzuzIfxClO5Nd1xwBePe4=
Received: by 10.216.179.193 with SMTP id h43mr819208wem.49.1291394882248;
        Fri, 03 Dec 2010 08:48:02 -0800 (PST)
Received: from localhost (nat.ct.ingv.it [193.206.223.100])
        by mx.google.com with ESMTPS id p4sm974976wer.29.2010.12.03.08.48.00
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 03 Dec 2010 08:48:01 -0800 (PST)
X-Mailer: git-send-email 1.7.3.2.664.g294b8.dirty
In-Reply-To: <1291394861-11989-1-git-send-email-giuseppe.bilotta@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162807>

Signed-off-by: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
---
 Documentation/CodingGuidelines |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/Documentation/CodingGuidelines b/Documentation/CodingGuidelines
index 5aa2d34..a9191d0 100644
--- a/Documentation/CodingGuidelines
+++ b/Documentation/CodingGuidelines
@@ -31,6 +31,10 @@ But if you must have a list of rules, here they are.
 
 For shell scripts specifically (not exhaustive):
 
+ - We use tabs for indentation.
+
+ - Case arms are not indented with respect to the case and esac lines.
+
  - We prefer $( ... ) for command substitution; unlike ``, it
    properly nests.  It should have been the way Bourne spelled
    it from day one, but unfortunately isn't.
-- 
1.7.3.2.664.g294b8.dirty
