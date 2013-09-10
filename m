From: Tay Ray Chuan <rctay89@gmail.com>
Subject: [PATCH 02/14] normalize indentation with protcol-common.txt
Date: Wed, 11 Sep 2013 01:07:46 +0800
Message-ID: <1378832878-12811-3-git-send-email-rctay89@gmail.com>
References: <1255065768-10428-2-git-send-email-spearce@spearce.org>
 <1378832878-12811-1-git-send-email-rctay89@gmail.com>
 <1378832878-12811-2-git-send-email-rctay89@gmail.com>
Cc: "Junio C Hamano" <gitster@pobox.com>
To: "Git Mailing List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Sep 10 19:09:21 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VJRRG-0004Nn-CH
	for gcvg-git-2@plane.gmane.org; Tue, 10 Sep 2013 19:09:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754110Ab3IJRJL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Sep 2013 13:09:11 -0400
Received: from mail-pb0-f47.google.com ([209.85.160.47]:58989 "EHLO
	mail-pb0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754003Ab3IJRIX (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Sep 2013 13:08:23 -0400
Received: by mail-pb0-f47.google.com with SMTP id rr4so7803483pbb.6
        for <git@vger.kernel.org>; Tue, 10 Sep 2013 10:08:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=+gFXM5/ZPd5oH3Wbqv+wGVpBBAER8aqIQVsDzF06XRQ=;
        b=ahe1VULYZCqLKIQ0jWlONNXdDFleqBnWHriL8/rxjjRRUDVO5j5GUNHXkpDczUBP1g
         rOgA6epojawKS+PliE++SM/Sh+IulWs5TQzcF+V6/AVjH3+4hY5EI1zbGvd+XNUkVYvl
         fPCsMWGEMAxk5lV5uPUKs0T88BhdnqsLnmmd7DhZoPikGoTFt7mUNALJlmPU5k28MfMO
         ClyWU2+1BPZdxaWVW2zE0H35oT1OO7XO5b6CY+88Fq24aobrRXZ2Mwcfu76oJy7bChfM
         pL571YOPwhwfs19XAxxMqykHAv5IEPOucTrm7iK8+LcP/zN402iX7SbAJ0X3EGrs84o1
         V11Q==
X-Received: by 10.68.229.2 with SMTP id sm2mr26449560pbc.68.1378832902930;
        Tue, 10 Sep 2013 10:08:22 -0700 (PDT)
Received: from ubu-01-asus.nus.edu.sg (bb42-60-75-197.singnet.com.sg. [42.60.75.197])
        by mx.google.com with ESMTPSA id tg7sm24173138pbc.36.1969.12.31.16.00.00
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 10 Sep 2013 10:08:22 -0700 (PDT)
X-Mailer: git-send-email 1.8.4.rc4.527.g303b16c
In-Reply-To: <1378832878-12811-2-git-send-email-rctay89@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234461>

Indent client/server query examples with 3 spaces.

Indent ABNF rules with 2 spaces.

Signed-off-by: Tay Ray Chuan <rctay89@gmail.com>
--

This is in its own patch to minimize noise in diffs.
---
 Documentation/technical/http-protocol.txt | 226 +++++++++++++++---------------
 1 file changed, 113 insertions(+), 113 deletions(-)

diff --git a/Documentation/technical/http-protocol.txt b/Documentation/technical/http-protocol.txt
index 0a2a53d..70a1648 100644
--- a/Documentation/technical/http-protocol.txt
+++ b/Documentation/technical/http-protocol.txt
@@ -161,14 +161,14 @@ Dumb HTTP clients MUST NOT include search/query parameters when
 fetching the info/refs file.  (That is, '?' must not appear in the
 requested URL.)
 
-	C: GET $GIT_URL/info/refs HTTP/1.0
+   C: GET $GIT_URL/info/refs HTTP/1.0
 
-	S: 200 OK
-	S:
-	S: 95dcfa3633004da0049d3d0fa03f80589cbcaf31	refs/heads/maint
-	S: d049f6c27a2244e12041955e262a404c7faba355	refs/heads/master
-	S: 2cb58b79488a98d2721cea644875a8dd0026b115	refs/tags/v1.0
-	S: a3c2e2402b99163d1d59756e5f207ae21cccba4c	refs/tags/v1.0^{}
+   S: 200 OK
+   S:
+   S: 95dcfa3633004da0049d3d0fa03f80589cbcaf31	refs/heads/maint
+   S: d049f6c27a2244e12041955e262a404c7faba355	refs/heads/master
+   S: 2cb58b79488a98d2721cea644875a8dd0026b115	refs/tags/v1.0
+   S: a3c2e2402b99163d1d59756e5f207ae21cccba4c	refs/tags/v1.0^{}
 
 The Content-Type of the returned info/refs entity SHOULD be
 "text/plain; charset=utf-8", but MAY be any content type.
@@ -187,17 +187,17 @@ each ref and its known value.  The file SHOULD be sorted by name
 according to the C locale ordering.  The file SHOULD NOT include
 the default ref named 'HEAD'.
 
-	info_refs     = *( ref_record )
-	ref_record    = any_ref | peeled_ref
+  info_refs        =  *( ref_record )
+  ref_record       =  any_ref | peeled_ref
 
-	any_ref       = id HT name LF
-	peeled_ref    = id HT name LF
-	                id HT name "^{}" LF
-	id            = 40*HEX
+  any_ref          =  id HT name LF
+  peeled_ref       =  id HT name LF
+		      id HT name "^{}" LF
+  id               =  40*HEX
 
-	HEX           = "0".."9" | "a".."f"
-	LF            = <US-ASCII LF, linefeed (10)>
-	HT            = <US-ASCII HT, horizontal-tab (9)>
+  HEX              =  "0".."9" | "a".."f"
+  LF               =  <US-ASCII LF, linefeed (10)>
+  HT               =  <US-ASCII HT, horizontal-tab (9)>
 
 Smart Clients
 ~~~~~~~~~~~~~
@@ -211,26 +211,26 @@ The request MUST contain exactly one query parameter,
 name the client wishes to contact to complete the operation.
 The request MUST NOT contain additional query parameters.
 
-	C: GET $GIT_URL/info/refs?service=git-upload-pack HTTP/1.0
-
-	dumb server reply:
-	S: 200 OK
-	S:
-	S: 95dcfa3633004da0049d3d0fa03f80589cbcaf31	refs/heads/maint
-	S: d049f6c27a2244e12041955e262a404c7faba355	refs/heads/master
-	S: 2cb58b79488a98d2721cea644875a8dd0026b115	refs/tags/v1.0
-	S: a3c2e2402b99163d1d59756e5f207ae21cccba4c	refs/tags/v1.0^{}
-
-	smart server reply:
-	S: 200 OK
-	S: Content-Type: application/x-git-upload-pack-advertisement
-	S: Cache-Control: no-cache
-	S:
-	S: ....# service=git-upload-pack
-	S: ....95dcfa3633004da0049d3d0fa03f80589cbcaf31 refs/heads/maint\0 multi_ack
-	S: ....d049f6c27a2244e12041955e262a404c7faba355 refs/heads/master
-	S: ....2cb58b79488a98d2721cea644875a8dd0026b115 refs/tags/v1.0
-	S: ....a3c2e2402b99163d1d59756e5f207ae21cccba4c refs/tags/v1.0^{}
+   C: GET $GIT_URL/info/refs?service=git-upload-pack HTTP/1.0
+
+   dumb server reply:
+   S: 200 OK
+   S:
+   S: 95dcfa3633004da0049d3d0fa03f80589cbcaf31	refs/heads/maint
+   S: d049f6c27a2244e12041955e262a404c7faba355	refs/heads/master
+   S: 2cb58b79488a98d2721cea644875a8dd0026b115	refs/tags/v1.0
+   S: a3c2e2402b99163d1d59756e5f207ae21cccba4c	refs/tags/v1.0^{}
+
+   smart server reply:
+   S: 200 OK
+   S: Content-Type: application/x-git-upload-pack-advertisement
+   S: Cache-Control: no-cache
+   S:
+   S: ....# service=git-upload-pack
+   S: ....95dcfa3633004da0049d3d0fa03f80589cbcaf31 refs/heads/maint\0 multi_ack
+   S: ....d049f6c27a2244e12041955e262a404c7faba355 refs/heads/master
+   S: ....2cb58b79488a98d2721cea644875a8dd0026b115 refs/tags/v1.0
+   S: ....a3c2e2402b99163d1d59756e5f207ae21cccba4c refs/tags/v1.0^{}
 
 Dumb Server Response
 ^^^^^^^^^^^^^^^^^^^^
@@ -281,28 +281,28 @@ the C locale ordering.  The stream SHOULD include the default ref
 named 'HEAD' as the first ref.  The stream MUST include capability
 declarations behind a NUL on the first ref.
 
-	smart_reply    = PKT-LINE("# service=$servicename" LF)
-	                 ref_list
-	                 "0000"
-	ref_list       = empty_list | non_empty_list
+  smart_reply      =  PKT-LINE("# service=$servicename" LF)
+		      ref_list
+		      "0000"
+  ref_list         =  empty_list | non_empty_list
 
-	empty_list     = PKT-LINE(id SP "capabilities^{}" NUL cap_list LF)
+  empty_list       =  PKT-LINE(id SP "capabilities^{}" NUL cap_list LF)
 
-	non_empty_list = PKT-LINE(id SP name NUL cap_list LF)
-	                 *ref_record
+  non_empty_list   =  PKT-LINE(id SP name NUL cap_list LF)
+		      *ref_record
 
-	cap_list      = *(SP capability) SP
-	ref_record    = any_ref | peeled_ref
+  cap_list         =  *(SP capability) SP
+  ref_record       =  any_ref | peeled_ref
 
-	any_ref       = PKT-LINE(id SP name LF)
-	peeled_ref    = PKT-LINE(id SP name LF)
-	                PKT-LINE(id SP name "^{}" LF
-	id            = 40*HEX
+  any_ref          =  PKT-LINE(id SP name LF)
+  peeled_ref       =  PKT-LINE(id SP name LF)
+		      PKT-LINE(id SP name "^{}" LF
+  id               =  40*HEX
 
-	HEX           = "0".."9" | "a".."f"
-	NL            = <US-ASCII NUL, null (0)>
-	LF            = <US-ASCII LF,  linefeed (10)>
-	SP            = <US-ASCII SP,  horizontal-tab (9)>
+  HEX              =  "0".."9" | "a".."f"
+  NL               =  <US-ASCII NUL, null (0)>
+  LF               =  <US-ASCII LF,  linefeed (10)>
+  SP               =  <US-ASCII SP,  horizontal-tab (9)>
 
 
 Smart Service git-upload-pack
@@ -312,19 +312,19 @@ This service reads from the remote repository.
 Clients MUST first perform ref discovery with
 '$GIT_URL/info/refs?service=git-upload-pack'.
 
-	C: POST $GIT_URL/git-upload-pack HTTP/1.0
-	C: Content-Type: application/x-git-upload-pack-request
-	C:
-	C: ....want 0a53e9ddeaddad63ad106860237bbf53411d11a7
-	C: ....have 441b40d833fdfa93eb2908e52742248faf0ee993
-	C: 0000
+   C: POST $GIT_URL/git-upload-pack HTTP/1.0
+   C: Content-Type: application/x-git-upload-pack-request
+   C:
+   C: ....want 0a53e9ddeaddad63ad106860237bbf53411d11a7
+   C: ....have 441b40d833fdfa93eb2908e52742248faf0ee993
+   C: 0000
 
-	S: 200 OK
-	S: Content-Type: application/x-git-upload-pack-result
-	S: Cache-Control: no-cache
-	S:
-	S: ....ACK %s, continue
-	S: ....NAK
+   S: 200 OK
+   S: Content-Type: application/x-git-upload-pack-result
+   S: Cache-Control: no-cache
+   S:
+   S: ....ACK %s, continue
+   S: ....NAK
 
 Clients MUST NOT reuse or revalidate a cached reponse.
 Servers MUST include sufficient Cache-Control headers
@@ -336,23 +336,23 @@ Clients MUST send at least one 'want' command in the request body.
 Clients MUST NOT reference an id in a 'want' command which did not
 appear in the response obtained through ref discovery.
 
-	compute_request   = want_list
-	                    have_list
-	                    request_end
-	request_end       = "0000" | "done"
+  compute_request  =  want_list
+		      have_list
+		      request_end
+  request_end      =  "0000" | "done"
 
-	want_list         = PKT-LINE(want NUL cap_list LF)
-	                    *(want_pkt)
-	want_pkt          = PKT-LINE(want LF)
-	want              = "want" SP id
-	cap_list          = *(SP capability) SP
+  want_list        =  PKT-LINE(want NUL cap_list LF)
+		      *(want_pkt)
+  want_pkt         =  PKT-LINE(want LF)
+  want             =  "want" SP id
+  cap_list         =  *(SP capability) SP
 
-	have_list         = *PKT-LINE("have" SP id LF)
+  have_list        =  *PKT-LINE("have" SP id LF)
 
-	command           = create | delete | update
-	create            = 40*"0" SP new_id SP name
-	delete            = old_id SP 40*"0" SP name
-	update            = old_id SP new_id SP name
+  command          =  create | delete | update
+  create           =  40*"0" SP new_id SP name
+  delete           =  old_id SP 40*"0" SP name
+  update           =  old_id SP new_id SP name
 
 TODO: Document this further.
 TODO: Don't use uppercase for variable names below.
@@ -396,16 +396,16 @@ The computation to select the minimal pack proceeds as follows
  one compute step:
  (c) Send one $GIT_URL/git-upload-pack request:
 
-	C: 0032want <WANT #1>...............................
-	C: 0032want <WANT #2>...............................
-	....
-	C: 0032have <COMMON #1>.............................
-	C: 0032have <COMMON #2>.............................
-	....
-	C: 0032have <HAVE #1>...............................
-	C: 0032have <HAVE #2>...............................
-	....
-	C: 0000
+   C: 0032want <WANT #1>...............................
+   C: 0032want <WANT #2>...............................
+   ....
+   C: 0032have <COMMON #1>.............................
+   C: 0032have <COMMON #2>.............................
+   ....
+   C: 0032have <HAVE #1>...............................
+   C: 0032have <HAVE #2>...............................
+   ....
+   C: 0000
 
      The stream is organized into "commands", with each command
      appearing by itself in a pkt-line.  Within a command line
@@ -434,13 +434,13 @@ The computation to select the minimal pack proceeds as follows
      emptied C_PENDING it should include a "done" command to let
      the server know it won't proceed:
 
-	C: 0009done
+   C: 0009done
 
   (s) Parse the git-upload-pack request:
 
       Verify all objects in WANT are directly reachable from refs.
 
-	  The server MAY walk backwards through history or through
+      The server MAY walk backwards through history or through
       the reflog to permit slightly stale requests.
 
       If no WANT objects are received, send an error:
@@ -466,7 +466,7 @@ TODO: Define error if an invalid want is requested.
      request ends with "done", it replies with the pack.
 
 TODO: Document the pack based response
-	S: PACK...
+   S: PACK...
 
      The returned stream is the side-band-64k protocol supported
      by the git-upload-pack service, and the pack is embedded into
@@ -495,18 +495,18 @@ This service modifies the remote repository.
 Clients MUST first perform ref discovery with
 '$GIT_URL/info/refs?service=git-receive-pack'.
 
-	C: POST $GIT_URL/git-receive-pack HTTP/1.0
-	C: Content-Type: application/x-git-receive-pack-request
-	C:
-	C: ....0a53e9ddeaddad63ad106860237bbf53411d11a7 441b40d833fdfa93eb2908e52742248faf0ee993 refs/heads/maint\0 report-status
-	C: 0000
-	C: PACK....
+   C: POST $GIT_URL/git-receive-pack HTTP/1.0
+   C: Content-Type: application/x-git-receive-pack-request
+   C:
+   C: ....0a53e9ddeaddad63ad106860237bbf53411d11a7 441b40d833fdfa93eb2908e52742248faf0ee993 refs/heads/maint\0 report-status
+   C: 0000
+   C: PACK....
 
-	S: 200 OK
-	S: Content-Type: application/x-git-receive-pack-result
-	S: Cache-Control: no-cache
-	S:
-	S: ....
+   S: 200 OK
+   S: Content-Type: application/x-git-receive-pack-result
+   S: Cache-Control: no-cache
+   S:
+   S: ....
 
 Clients MUST NOT reuse or revalidate a cached reponse.
 Servers MUST include sufficient Cache-Control headers
@@ -518,18 +518,18 @@ Clients MUST send at least one command in the request body.
 Within the command portion of the request body clients SHOULD send
 the id obtained through ref discovery as old_id.
 
-	update_request    = command_list
-	                    "PACK" <binary data>
+  update_request   =  command_list
+		      "PACK" <binary data>
 
-	command_list      = PKT-LINE(command NUL cap_list LF)
-	                    *(command_pkt)
-	command_pkt       = PKT-LINE(command LF)
-	cap_list          = *(SP capability) SP
+  command_list     =  PKT-LINE(command NUL cap_list LF)
+		      *(command_pkt)
+  command_pkt      =  PKT-LINE(command LF)
+  cap_list         =  *(SP capability) SP
 
-	command           = create | delete | update
-	create            = 40*"0" SP new_id SP name
-	delete            = old_id SP 40*"0" SP name
-	update            = old_id SP new_id SP name
+  command          =  create | delete | update
+  create           =  40*"0" SP new_id SP name
+  delete           =  old_id SP 40*"0" SP name
+  update           =  old_id SP new_id SP name
 
 TODO: Document this further.
 
-- 
1.8.4.rc4.527.g303b16c
