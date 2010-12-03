From: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
Subject: [PATCHv2 3/7] web--browse: split valid_tool list
Date: Fri,  3 Dec 2010 17:47:37 +0100
Message-ID: <1291394861-11989-4-git-send-email-giuseppe.bilotta@gmail.com>
References: <1291394861-11989-1-git-send-email-giuseppe.bilotta@gmail.com>
Cc: Christian Couder <christian.couder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Dec 03 17:48:39 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1POYoI-0007II-Ca
	for gcvg-git-2@lo.gmane.org; Fri, 03 Dec 2010 17:48:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753403Ab0LCQsL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 3 Dec 2010 11:48:11 -0500
Received: from mail-ww0-f44.google.com ([74.125.82.44]:47167 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753098Ab0LCQsJ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 Dec 2010 11:48:09 -0500
Received: by mail-ww0-f44.google.com with SMTP id 36so10251895wwa.1
        for <git@vger.kernel.org>; Fri, 03 Dec 2010 08:48:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=md0lMHPOP/l+dl2kCGXDrUFgYZXC54EJHr7MDe30NCY=;
        b=hEdYSAa3QGJ1IseQ428/dA4sn0ZMK2vxK3OWAv2z0KuopBIRTEPo0gTYQ8T/OR3k+5
         sRvZpabhjwasttfzhHHoDHBgJZHBhLnvF+H3p8uXAMEl7rsBCxVw9iVen7cpmUgPewO+
         D2rj2vEBzyGtxJPHj8oNF5WVt8aoKdcDseIaM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=kEhNn8+tArqgRUk1ofLhX2l8CjAEq5RGC+Tz1NbCv6aTE3iCyNVpoGOVjwX15nOoPF
         /KUSBWFrSRbfddiTYSkIxEQDAPVMN1IXuTSSntLdOmGykFWoeviaxWnwhsizPFhhTMyW
         g/VRZ5R3BA7ympvmKJUVDjjdml3I3eEtHXOEQ=
Received: by 10.227.136.148 with SMTP id r20mr461743wbt.99.1291394888630;
        Fri, 03 Dec 2010 08:48:08 -0800 (PST)
Received: from localhost (nat.ct.ingv.it [193.206.223.100])
        by mx.google.com with ESMTPS id h29sm1396624wbc.3.2010.12.03.08.48.06
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 03 Dec 2010 08:48:07 -0800 (PST)
X-Mailer: git-send-email 1.7.3.2.664.g294b8.dirty
In-Reply-To: <1291394861-11989-1-git-send-email-giuseppe.bilotta@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162809>

It was getting too long, and we want to add some more.

Signed-off-by: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
---
 git-web--browse.sh |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/git-web--browse.sh b/git-web--browse.sh
index 7c4568f..e48e30d 100755
--- a/git-web--browse.sh
+++ b/git-web--browse.sh
@@ -31,7 +31,8 @@ valid_custom_tool()
 
 valid_tool() {
 	case "$1" in
-	firefox | iceweasel | chrome | google-chrome | chromium | konqueror | w3m | links | lynx | dillo | open | start)
+	firefox | iceweasel | chrome | google-chrome | chromium |\
+	konqueror | w3m | links | lynx | dillo | open | start)
 		;; # happy
 	*)
 		valid_custom_tool "$1" || return 1
-- 
1.7.3.2.664.g294b8.dirty
