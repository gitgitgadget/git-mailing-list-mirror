From: Thomas Ackermann <th.acker66@arcor.de>
Subject: [Patch v2 4/8] Prerequisites for creating nice html for all files
 in Documentation/technical
Date: Thu, 11 Oct 2012 19:21:13 +0200 (CEST)
Message-ID: <1691703722.46948.1349976073685.JavaMail.ngmail@webmail22.arcor-online.net>
References: <1412437370.46782.1349975589890.JavaMail.ngmail@webmail22.arcor-online.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: philipoakley@iee.org, peff@peff.net, gitster@pobox.com,
	th.acker66@arcor.de
To: th.acker66@arcor.de, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Oct 11 19:21:27 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TMMRq-0000aV-EH
	for gcvg-git-2@plane.gmane.org; Thu, 11 Oct 2012 19:21:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759063Ab2JKRVP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Oct 2012 13:21:15 -0400
Received: from mail-in-04.arcor-online.net ([151.189.21.44]:57490 "EHLO
	mail-in-04.arcor-online.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1759058Ab2JKRVO (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 11 Oct 2012 13:21:14 -0400
Received: from mail-in-13-z2.arcor-online.net (mail-in-13-z2.arcor-online.net [151.189.8.30])
	by mx.arcor.de (Postfix) with ESMTP id C4D73AAB19;
	Thu, 11 Oct 2012 19:21:13 +0200 (CEST)
Received: from mail-in-09.arcor-online.net (mail-in-09.arcor-online.net [151.189.21.49])
	by mail-in-13-z2.arcor-online.net (Postfix) with ESMTP id B56403C4143;
	Thu, 11 Oct 2012 19:21:13 +0200 (CEST)
Received: from webmail22.arcor-online.net (webmail22.arcor-online.net [151.189.8.137])
	by mail-in-09.arcor-online.net (Postfix) with ESMTP id AEA15198541;
	Thu, 11 Oct 2012 19:21:13 +0200 (CEST)
X-DKIM: Sendmail DKIM Filter v2.8.2 mail-in-09.arcor-online.net AEA15198541
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arcor.de; s=mail-in;
	t=1349976073; bh=hKYqlpfCvxJ/M78KN86diHv0uRdrxgtF/MiJc1WqrDk=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	b=Ou1EmBloFpts+BgXOSrQb8EMWAAgVihTaR/2svBHYjwwxUBeF2GH9IZasSaJTCa+p
	 0EtXlxMMbz6D2u0cXsb014CDPoiM7aXZ9gppKwlEMKD+C4QLydVfBeZb+dP5aBl/Jz
	 ye5qG8V+2NZ9vPOzxJzce+Z6sOyZjsCTrOuJBLvo=
Received: from [188.105.106.236] by webmail22.arcor-online.net (151.189.8.137) with HTTP (Arcor Webmail); Thu, 11 Oct 2012 19:21:13 +0200 (CEST)
In-Reply-To: <1412437370.46782.1349975589890.JavaMail.ngmail@webmail22.arcor-online.net>
X-ngMessageSubType: MessageSubType_MAIL
X-WebmailclientIP: 188.105.106.236
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207494>

>From 23b5272cbb27dca7e292f33c79cf3d8e21298b78 Mon Sep 17 00:00:00 2001
From: Thomas Ackermann <th.acker@arcor.de>
Date: Sat, 29 Sep 2012 10:00:00 +0200
Subject: [PATCH] Prerequisites for creating nice html for all files in
 Documentation/technical

- fix wrong asciidoc sectioning markup in index-format.txt, pack-format.txt and pack-protocol.txt
- split an over-long line in pack-protocol.txt into several lines
- add a markup box for definition part in shallow.txt
- fix table markup in trivial-merge.txt

Signed-off-by: Thomas Ackermann <th.acker@arcor.de>
---
 Documentation/technical/index-format.txt  |  2 +-
 Documentation/technical/pack-format.txt   |  8 +++----
 Documentation/technical/pack-protocol.txt |  7 +++---
 Documentation/technical/shallow.txt       |  8 ++++++-
 Documentation/technical/trivial-merge.txt | 36 +++++++++++++++----------------
 5 files changed, 34 insertions(+), 27 deletions(-)

diff --git a/Documentation/technical/index-format.txt b/Documentation/technical/index-format.txt
index 9d25b30..57d6f91 100644
--- a/Documentation/technical/index-format.txt
+++ b/Documentation/technical/index-format.txt
@@ -1,7 +1,7 @@
 GIT index format
 ================
 
-= The git index file has the following format
+== The git index file has the following format
 
   All binary numbers are in network byte order. Version 2 is described
   here unless stated otherwise.
diff --git a/Documentation/technical/pack-format.txt b/Documentation/technical/pack-format.txt
index 1803e64..a7871fb 100644
--- a/Documentation/technical/pack-format.txt
+++ b/Documentation/technical/pack-format.txt
@@ -1,7 +1,7 @@
 GIT pack format
 ===============
 
-= pack-*.pack files have the following format:
+== pack-*.pack files have the following format:
 
    - A header appears at the beginning and consists of the following:
 
@@ -34,7 +34,7 @@ GIT pack format
 
   - The trailer records 20-byte SHA1 checksum of all of the above.
 
-= Original (version 1) pack-*.idx files have the following format:
+== Original (version 1) pack-*.idx files have the following format:
 
   - The header consists of 256 4-byte network byte order
     integers.  N-th entry of this table records the number of
@@ -123,8 +123,8 @@ Pack file entry: <+
 
 
 
-= Version 2 pack-*.idx files support packs larger than 4 GiB, and
-  have some other reorganizations.  They have the format:
+== Version 2 pack-*.idx files support packs larger than 4 GiB, and
+   have some other reorganizations.  They have the format:
 
   - A 4-byte magic number '\377tOc' which is an unreasonable
     fanout[0] value.
diff --git a/Documentation/technical/pack-protocol.txt b/Documentation/technical/pack-protocol.txt
index d51e20f..25e1fbe 100644
--- a/Documentation/technical/pack-protocol.txt
+++ b/Documentation/technical/pack-protocol.txt
@@ -117,7 +117,7 @@ A few things to remember here:
 - The repository path is always quoted with single quotes.
 
 Fetching Data From a Server
-===========================
+---------------------------
 
 When one Git repository wants to get data that a second repository
 has, the first can 'fetch' from the second.  This operation determines
@@ -134,7 +134,8 @@ with the object name that each reference currently points to.
 
    $ echo -e -n "0039git-upload-pack /schacon/gitbook.git\0host=example.com\0" |
       nc -v example.com 9418
-   00887217a7c7e582c46cec22a130adf4b9d7d950fba0 HEAD\0multi_ack thin-pack side-band side-band-64k ofs-delta shallow no-progress include-tag
+   00887217a7c7e582c46cec22a130adf4b9d7d950fba0 HEAD\0multi_ack thin-pack 
+                side-band side-band-64k ofs-delta shallow no-progress include-tag
    00441d3fcd5ced445d1abc402225c0b8a1299641f497 refs/heads/integration
    003f7217a7c7e582c46cec22a130adf4b9d7d950fba0 refs/heads/master
    003cb88d2441cac0977faf98efc80305012112238d9d refs/tags/v0.9
@@ -421,7 +422,7 @@ entire packfile without multiplexing.
 
 
 Pushing Data To a Server
-========================
+------------------------
 
 Pushing data to a server will invoke the 'receive-pack' process on the
 server, which will allow the client to tell it which references it should
diff --git a/Documentation/technical/shallow.txt b/Documentation/technical/shallow.txt
index 559263a..0502a54 100644
--- a/Documentation/technical/shallow.txt
+++ b/Documentation/technical/shallow.txt
@@ -1,6 +1,12 @@
-Def.: Shallow commits do have parents, but not in the shallow
+Shallow commits
+===============
+
+.Definition
+*********************************************************
+Shallow commits do have parents, but not in the shallow
 repo, and therefore grafts are introduced pretending that
 these commits have no parents.
+*********************************************************
 
 The basic idea is to write the SHA1s of shallow commits into
 $GIT_DIR/shallow, and handle its contents like the contents
diff --git a/Documentation/technical/trivial-merge.txt b/Documentation/technical/trivial-merge.txt
index 24c8410..c79d4a7 100644
--- a/Documentation/technical/trivial-merge.txt
+++ b/Documentation/technical/trivial-merge.txt
@@ -74,24 +74,24 @@ For multiple ancestors, a '+' means that this case applies even if
 only one ancestor or remote fits; a '^' means all of the ancestors
 must be the same.
 
-case  ancest    head    remote    result
-----------------------------------------
-1     (empty)+  (empty) (empty)   (empty)
-2ALT  (empty)+  *empty* remote    remote
-2     (empty)^  (empty) remote    no merge
-3ALT  (empty)+  head    *empty*   head
-3     (empty)^  head    (empty)   no merge
-4     (empty)^  head    remote    no merge
-5ALT  *         head    head      head
-6     ancest+   (empty) (empty)   no merge
-8     ancest^   (empty) ancest    no merge
-7     ancest+   (empty) remote    no merge
-10    ancest^   ancest  (empty)   no merge
-9     ancest+   head    (empty)   no merge
-16    anc1/anc2 anc1    anc2      no merge
-13    ancest+   head    ancest    head
-14    ancest+   ancest  remote    remote
-11    ancest+   head    remote    no merge
+ case  ancest    head    remote    result
+ ----------------------------------------
+ 1     (empty)+  (empty) (empty)   (empty)
+ 2ALT  (empty)+  *empty* remote    remote
+ 2     (empty)^  (empty) remote    no merge
+ 3ALT  (empty)+  head    *empty*   head
+ 3     (empty)^  head    (empty)   no merge
+ 4     (empty)^  head    remote    no merge
+ 5ALT  *         head    head      head
+ 6     ancest+   (empty) (empty)   no merge
+ 8     ancest^   (empty) ancest    no merge
+ 7     ancest+   (empty) remote    no merge
+ 10    ancest^   ancest  (empty)   no merge
+ 9     ancest+   head    (empty)   no merge
+ 16    anc1/anc2 anc1    anc2      no merge
+ 13    ancest+   head    ancest    head
+ 14    ancest+   ancest  remote    remote
+ 11    ancest+   head    remote    no merge
 
 Only #2ALT and #3ALT use *empty*, because these are the only cases
 where there can be conflicts that didn't exist before. Note that we
-- 
1.7.11.msysgit.1


---
Thomas
