From: Tay Ray Chuan <rctay89@gmail.com>
Subject: [PATCH 03/14] capitalize key words according to RFC 2119
Date: Wed, 11 Sep 2013 01:07:47 +0800
Message-ID: <1378832878-12811-4-git-send-email-rctay89@gmail.com>
References: <1255065768-10428-2-git-send-email-spearce@spearce.org>
 <1378832878-12811-1-git-send-email-rctay89@gmail.com>
 <1378832878-12811-2-git-send-email-rctay89@gmail.com>
 <1378832878-12811-3-git-send-email-rctay89@gmail.com>
Cc: "Junio C Hamano" <gitster@pobox.com>
To: "Git Mailing List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Sep 10 19:08:35 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VJRQV-00037D-Sd
	for gcvg-git-2@plane.gmane.org; Tue, 10 Sep 2013 19:08:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754023Ab3IJRI0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Sep 2013 13:08:26 -0400
Received: from mail-pd0-f177.google.com ([209.85.192.177]:40225 "EHLO
	mail-pd0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753358Ab3IJRIZ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Sep 2013 13:08:25 -0400
Received: by mail-pd0-f177.google.com with SMTP id y10so7936820pdj.22
        for <git@vger.kernel.org>; Tue, 10 Sep 2013 10:08:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ZKGwqi9Dh4LTBWMrKwcVpOEPP+Wll0Sjh8058ne4f4c=;
        b=olDiCfK6z6FcjoK0t/eQIUE7H/y9+oZoO4zShrTSMcoV7lYzCN9wwEvu9t/u8b+85G
         C+R2M3Lp4Wlbz4IooaKWBQMC2j50UC8ZImRAM2SCc+xCswCLOthMEQdybkgBWbd/OgcA
         kKENImWWnGMmBYBpVRocC6YwezGVHsYhw76QrmISPIsWwXZVhtGdvEVveCL1HIcY2Lq1
         2b1ibRNRdlE1goCX+7Y7i8kPDnR9YdiGb9Pf/DID/vNi4obUIQERmfhnBznvnE5e1LnK
         QNAHcGFU9w8Pi9+vv7WQIj+Mz5er+40Hg/VjS02y29GS2geeDjUnL3VLvG4ccUGXbmmy
         XhSw==
X-Received: by 10.66.121.131 with SMTP id lk3mr27600994pab.61.1378832904589;
        Tue, 10 Sep 2013 10:08:24 -0700 (PDT)
Received: from ubu-01-asus.nus.edu.sg (bb42-60-75-197.singnet.com.sg. [42.60.75.197])
        by mx.google.com with ESMTPSA id tg7sm24173138pbc.36.1969.12.31.16.00.00
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 10 Sep 2013 10:08:23 -0700 (PDT)
X-Mailer: git-send-email 1.8.4.rc4.527.g303b16c
In-Reply-To: <1378832878-12811-3-git-send-email-rctay89@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234448>

Signed-off-by: Tay Ray Chuan <rctay89@gmail.com>
---
 Documentation/technical/http-protocol.txt | 17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

diff --git a/Documentation/technical/http-protocol.txt b/Documentation/technical/http-protocol.txt
index 70a1648..55753bb 100644
--- a/Documentation/technical/http-protocol.txt
+++ b/Documentation/technical/http-protocol.txt
@@ -11,6 +11,10 @@ protocol URLs to smart URLs.  This permits all users to have the
 same published URL, and the peers automatically select the most
 efficient transport available to them.
 
+The key words "MUST", "MUST NOT", "REQUIRED", "SHALL", "SHALL
+NOT", "SHOULD", "SHOULD NOT", "RECOMMENDED",  "MAY", and
+"OPTIONAL" in this document are to be interpreted as described in
+RFC 2119.
 
 URL Format
 ----------
@@ -29,7 +33,7 @@ supplied $GIT_URL string.
 
 Clients MUST strip a trailing '/', if present, from the user supplied
 $GIT_URL string to prevent empty path tokens ('//') from appearing
-in any URL sent to a server.  Compatible clients must expand
+in any URL sent to a server.  Compatible clients MUST expand
 '$GIT_URL/info/refs' as 'foo/info/refs' and not 'foo//info/refs'.
 
 
@@ -66,7 +70,7 @@ Session State
 -------------
 
 The Git over HTTP protocol (much like HTTP itself) is stateless
-from the perspective of the HTTP server side.  All state must be
+from the perspective of the HTTP server side.  All state MUST be
 retained and managed by the client process.  This permits simple
 round-robin load-balancing on the server side, without needing to
 worry about state management.
@@ -158,7 +162,7 @@ references by making a request for the special info/refs file of
 the repository.
 
 Dumb HTTP clients MUST NOT include search/query parameters when
-fetching the info/refs file.  (That is, '?' must not appear in the
+fetching the info/refs file.  (That is, '?' MUST NOT appear in the
 requested URL.)
 
    C: GET $GIT_URL/info/refs HTTP/1.0
@@ -390,7 +394,7 @@ The computation to select the minimal pack proceeds as follows
 
  (c) Start a queue, C_PENDING, ordered by commit time (popping newest
      first).  Add all client refs.  When a commit is popped from
-     the queue its parents should be automatically inserted back.
+     the queue its parents SHOULD be automatically inserted back.
      Commits MUST only enter the queue once.
 
  one compute step:
@@ -431,7 +435,7 @@ The computation to select the minimal pack proceeds as follows
 
      If the client has sent 256 HAVE commits and has not yet
      received one of those back from S_COMMON, or the client has
-     emptied C_PENDING it should include a "done" command to let
+     emptied C_PENDING it SHOULD include a "done" command to let
      the server know it won't proceed:
 
    C: 0009done
@@ -470,7 +474,7 @@ TODO: Document the pack based response
 
      The returned stream is the side-band-64k protocol supported
      by the git-upload-pack service, and the pack is embedded into
-     stream 1.  Progress messages from the server side may appear
+     stream 1.  Progress messages from the server side MAY appear
      in stream 2.
 
      Here a "closed set of objects" is defined to have at least
@@ -538,5 +542,6 @@ References
 ----------
 
 link:http://www.ietf.org/rfc/rfc1738.txt[RFC 1738: Uniform Resource Locators (URL)]
+link:http://www.ietf.org/rfc/rfc2119.txt[RFC 2119: Key words for use in RFCs to Indicate Requirement Levels]
 link:http://www.ietf.org/rfc/rfc2616.txt[RFC 2616: Hypertext Transfer Protocol -- HTTP/1.1]
 
-- 
1.8.4.rc4.527.g303b16c
