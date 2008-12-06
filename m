From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH] Documentation: Remove duplicated info from RelNotes-1.6.1
Date: Sat,  6 Dec 2008 23:36:41 +0100
Message-ID: <1228603001-23095-1-git-send-email-jnareb@gmail.com>
Cc: Jakub Narebski <jnareb@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Dec 06 23:38:06 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L95mm-0003oz-No
	for gcvg-git-2@gmane.org; Sat, 06 Dec 2008 23:38:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753005AbYLFWgs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 6 Dec 2008 17:36:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752964AbYLFWgr
	(ORCPT <rfc822;git-outgoing>); Sat, 6 Dec 2008 17:36:47 -0500
Received: from nf-out-0910.google.com ([64.233.182.190]:30801 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752800AbYLFWgr (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 6 Dec 2008 17:36:47 -0500
Received: by nf-out-0910.google.com with SMTP id d3so280660nfc.21
        for <git@vger.kernel.org>; Sat, 06 Dec 2008 14:36:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received:from:to:cc
         :subject:date:message-id:x-mailer;
        bh=ycXlC6okhQa8Mrma6oR6RmLr0D73blQwvAKuH6+Lg78=;
        b=ueG2GAsjiwC7evkhFkXfrreo1/U52FZQA9v2z8cGvnloAMpNxuZ3QSFxs9IRh9HICe
         vJ67PiIht1zuIURxp8g9RypOMkFoepZ7vtbyaRI89QZqNU+I/RFl2eppyu6rRDN5NTgs
         nidIXFPZ8Z85ah7i33wHt64ECVu64mtRNIUdU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=JSTfec8PXJNw7MwwS1yGnzTcfYFpBYYbTYLpTQbczrzsWfBNyEjXCIQrvD+t9aupHp
         GyXoarVUe46Tc9uWuNpO5hSwboIydfIkCHpUyf358g3XAFT8hv5YhtT1f/6LvdkMbtdF
         8Le+q81xhW2eCabcuewJYiJvOyd6DE9/ewIhY=
Received: by 10.210.34.19 with SMTP id h19mr1726179ebh.160.1228603005173;
        Sat, 06 Dec 2008 14:36:45 -0800 (PST)
Received: from localhost.localdomain (abvc175.neoplus.adsl.tpnet.pl [83.8.200.175])
        by mx.google.com with ESMTPS id 5sm1260966eyh.56.2008.12.06.14.36.43
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 06 Dec 2008 14:36:44 -0800 (PST)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id mB6MahqW023121;
	Sat, 6 Dec 2008 23:36:44 +0100
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id mB6MagwZ023119;
	Sat, 6 Dec 2008 23:36:42 +0100
X-Mailer: git-send-email 1.6.0.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102480>

Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
I feel a bit silly signing off such simple patch.

The duplicated contents is:
* "git diff" learned to put more sensible hunk headers for Python,
  HTML and ObjC contents.


There are two entries which talk about nearly the same things, but
I am not sure there if it is duplication or not:

* "git diff" learned "textconv" filters --- a binary or hard-to-read
  contents can be munged into human readable form and the difference
  between the results of the conversion can be viewed (obviously this
  cannot produce a patch that can be applied, so this is disabled in
  format-patch among other things).

* a "textconv" filter that makes binary files textual form for human
   consumption can be specified as an attribute for paths; "git diff"
   learnt to make use of it.


 Documentation/RelNotes-1.6.1.txt |    2 --
 1 files changed, 0 insertions(+), 2 deletions(-)

diff --git a/Documentation/RelNotes-1.6.1.txt b/Documentation/RelNotes-1.6.1.txt
index 9f5c0b5..a82e2ae 100644
--- a/Documentation/RelNotes-1.6.1.txt
+++ b/Documentation/RelNotes-1.6.1.txt
@@ -135,8 +135,6 @@ on.
   cannot produce a patch that can be applied, so this is disabled in
   format-patch among other things).
 
-* "git diff" hunk header pattern for ObjC has been added.
-
 * "--cached" option to "git diff has an easier to remember synonym "--staged",
   to ask "what is the difference between the given commit and the
   contents staged in the index?"
-- 
1.6.0.4
