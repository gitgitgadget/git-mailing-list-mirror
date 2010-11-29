From: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
Subject: [PATCH 3/6] web--browse: split valid_tool list
Date: Mon, 29 Nov 2010 15:47:52 +0100
Message-ID: <1291042075-19983-4-git-send-email-giuseppe.bilotta@gmail.com>
References: <1291042075-19983-1-git-send-email-giuseppe.bilotta@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Nov 29 15:55:15 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PN58M-0003kS-Ih
	for gcvg-git-2@lo.gmane.org; Mon, 29 Nov 2010 15:55:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751945Ab0K2OzH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Nov 2010 09:55:07 -0500
Received: from mail-wy0-f174.google.com ([74.125.82.174]:60031 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751069Ab0K2OzF (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Nov 2010 09:55:05 -0500
Received: by wyb28 with SMTP id 28so4505128wyb.19
        for <git@vger.kernel.org>; Mon, 29 Nov 2010 06:55:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=TnIqnmZizjO+L9KbY7P2n5jyVxFcG99EqeSnSgapC0M=;
        b=Klcv8j/+3xNvo/Fn88hU5st53TSI00eR7wDeM15v3X1B8hho7YyfLuZJfKYIA9AxAW
         t/ZlrS7ExXrQFgjG5WWC0TQfcSOLkKgJexZKDaWqj3diS6J9bWp/o4G3Dv6NF4M5Zcrc
         LBTREAJf23n8nW3e0o+vfItkHiO1mNd/Tfadg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=u64+wpuVZMwMLql+AnznL7mGBuerwnikHky6AcjqcdTohG405WFt1jvHXR7eD8i8nO
         B+KAf/SrWaPMtXGa/KB8U0Up6vs6Mhts5WZkB8Xs6hotW3bHnmMt5Oa1lBxLxLpzzfJR
         YvqZWvzOSuCDIRww+UiFqKn+d7RTQaHtbxzzU=
Received: by 10.227.9.79 with SMTP id k15mr6007085wbk.101.1291042096706;
        Mon, 29 Nov 2010 06:48:16 -0800 (PST)
Received: from localhost (nat.ct.ingv.it [193.206.223.100])
        by mx.google.com with ESMTPS id h29sm3543812wbc.3.2010.11.29.06.48.15
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 29 Nov 2010 06:48:15 -0800 (PST)
X-Mailer: git-send-email 1.7.3.2.624.gec6c7.dirty
In-Reply-To: <1291042075-19983-1-git-send-email-giuseppe.bilotta@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162394>

It was getting too long, and we want to add some more.

Signed-off-by: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
---
 git-web--browse.sh |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/git-web--browse.sh b/git-web--browse.sh
index 7c4568f..b20b0e0 100755
--- a/git-web--browse.sh
+++ b/git-web--browse.sh
@@ -31,7 +31,8 @@ valid_custom_tool()
 
 valid_tool() {
 	case "$1" in
-	firefox | iceweasel | chrome | google-chrome | chromium | konqueror | w3m | links | lynx | dillo | open | start)
+	firefox|iceweasel|chrome|google-chrome|chromium\
+	|konqueror|w3m|links|lynx|dillo|open|start)
 		;; # happy
 	*)
 		valid_custom_tool "$1" || return 1
-- 
1.7.3.2.624.gec6c7.dirty
