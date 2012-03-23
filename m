From: Nelson Benitez Leon <nelsonjesus.benitez@seap.minhap.es>
Subject: [PATCH] documentation: fix alphabetic ordered list for git-rebase
 man page
Date: Fri, 23 Mar 2012 12:31:39 +0100
Message-ID: <4F6C5F1B.6010603@seap.minhap.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Mar 23 11:36:20 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SB1r1-0005sq-0t
	for gcvg-git-2@plane.gmane.org; Fri, 23 Mar 2012 11:36:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756045Ab2CWKgN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 23 Mar 2012 06:36:13 -0400
Received: from luthien2.mpt.es ([82.150.0.102]:2184 "EHLO luthien2.map.es"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754920Ab2CWKgM (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Mar 2012 06:36:12 -0400
Received: from correo.map.es (unknown [10.1.24.76])
	by luthien2.map.es (Postfix) with ESMTP id 3A435B7190
	for <git@vger.kernel.org>; Fri, 23 Mar 2012 11:33:47 +0100 (CET)
Received: from [10.47.128.147] (unknown [10.1.29.55])
	by correo.map.es (Postfix) with ESMTP id 12EC12C4FA
	for <git@vger.kernel.org>; Fri, 23 Mar 2012 11:33:38 +0100 (CET)
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:10.0.1) Gecko/20120216 Thunderbird/10.0.1
X-map-MapScanner: Libre de virus, Libre de virus
X-Spam-Status: No, No
X-map-MapScanner-Information: 
X-map-MapScanner-ID: 3A435B7190.B4805
X-map-MapScanner-From: nelsonjesus.benitez@seap.minhap.es
X-map-MailScanner-Watermark: 1333103634.21024@WrKH0UyHYm3OIP8N5JWF8Q
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193753>

An alphabetic ordered list (a.) is converted to numerical in
the man page (1.) so context comments naming 'a' were confusing,
fix that by not using ordered list notation for 'a' anb 'b' items.
---
Hi, "Interactive mode" section of git-rebase man page has an error,
where the source says:
        a. regular use

            1. finish something worthy of a commit

            2. commit
            
the converted man page says: 

        1. regular use

            1. finish something worthy of a commit

            2. commit

so the comments in following paragraph talking about "b.2." and "plenty of
a's and b's" don't have any meaning. I've fixed it by not using ordered
list notation for the alphabetical list.

Here you can see images of the man page before and after the patch:

Before patch: http://static.inky.ws/image/1567/image.jpg

After patch: http://static.inky.ws/image/1568/image.jpg

Regards,

 Documentation/git-rebase.txt |    7 +++++--
 1 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-rebase.txt b/Documentation/git-rebase.txt
index 504945c..520aaa9 100644
--- a/Documentation/git-rebase.txt
+++ b/Documentation/git-rebase.txt
@@ -409,10 +409,13 @@ The interactive mode is meant for this type of workflow:
 
 where point 2. consists of several instances of
 
-a. regular use
+a) regular use
+
  1. finish something worthy of a commit
  2. commit
-b. independent fixup
+
+b) independent fixup
+
  1. realize that something does not work
  2. fix that
  3. commit it
-- 
1.7.7.6
