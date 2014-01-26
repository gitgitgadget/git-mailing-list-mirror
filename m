From: Thomas Ackermann <th.acker@arcor.de>
Subject: [PATCH 2/2] http-protocol.txt: don't use uppercase for variable
 names in "The Negotiation Algorithm"
Date: Sun, 26 Jan 2014 13:56:17 +0100 (CET)
Message-ID: <1554188039.1102690.1390740977023.JavaMail.ngmail@webmail18.arcor-online.net>
References: <735028458.1102653.1390740723616.JavaMail.ngmail@webmail18.arcor-online.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: gitster@pobox.com, spearce@spearce.org, th.acker@arcor.de
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jan 26 13:56:30 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W7PGB-0003TA-8g
	for gcvg-git-2@plane.gmane.org; Sun, 26 Jan 2014 13:56:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752117AbaAZM4T (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 26 Jan 2014 07:56:19 -0500
Received: from mail-in-03.arcor-online.net ([151.189.21.43]:60994 "EHLO
	mail-in-03.arcor-online.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751456AbaAZM4S (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 26 Jan 2014 07:56:18 -0500
Received: from mail-in-14-z2.arcor-online.net (mail-in-14-z2.arcor-online.net [151.189.8.31])
	by mx.arcor.de (Postfix) with ESMTP id 143E8D880E;
	Sun, 26 Jan 2014 13:56:17 +0100 (CET)
Received: from mail-in-04.arcor-online.net (mail-in-04.arcor-online.net [151.189.21.44])
	by mail-in-14-z2.arcor-online.net (Postfix) with ESMTP id 0DDCF18575;
	Sun, 26 Jan 2014 13:56:17 +0100 (CET)
Received: from webmail18.arcor-online.net (webmail18.arcor-online.net [151.189.8.76])
	by mail-in-04.arcor-online.net (Postfix) with ESMTP id 07690AA84C;
	Sun, 26 Jan 2014 13:56:17 +0100 (CET)
X-DKIM: Sendmail DKIM Filter v2.8.2 mail-in-04.arcor-online.net 07690AA84C
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arcor.de; s=mail-in;
	t=1390740977; bh=qEqDNR/nYedvexwZLfIN9jgRp8Gu87ufSCciynkaexA=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	b=Xf4PrUUkgwAIXiEF4xzNGqir6dtKQhWxQQqC1E1XjXuYEhu5uKT7Ttqr0cBHpk9Ol
	 ldcPQhVPcj7LGCiYwzIEZ9uQxpA5lEar/Su0dNkSbX3pWEmCMJCZacAji3BW4lcSnI
	 FYBZiZsNcb8GSLN3z6W6gnD2GGNmkCcXd5oXkbMQ=
Received: from [94.217.129.144] by webmail18.arcor-online.net (151.189.8.76) with HTTP (Arcor Webmail); Sun, 26 Jan 2014 13:56:16 +0100 (CET)
In-Reply-To: <735028458.1102653.1390740723616.JavaMail.ngmail@webmail18.arcor-online.net>
X-ngMessageSubType: MessageSubType_MAIL
X-WebmailclientIP: 94.217.129.144
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241084>


Signed-off-by: Thomas Ackermann <th.acker@arcor.de>
---
 Documentation/technical/http-protocol.txt | 45 +++++++++++++++----------------
 1 file changed, 22 insertions(+), 23 deletions(-)

diff --git a/Documentation/technical/http-protocol.txt b/Documentation/technical/http-protocol.txt
index 7f0cf0b..90beb32 100644
--- a/Documentation/technical/http-protocol.txt
+++ b/Documentation/technical/http-protocol.txt
@@ -335,7 +335,6 @@ server advertises capability `allow-tip-sha1-in-want`.
   have_list         =  *PKT-LINE("have" SP id LF)
 
 TODO: Document this further.
-TODO: Don't use uppercase for variable names below.
 
 The Negotiation Algorithm
 ~~~~~~~~~~~~~~~~~~~~~~~~~
@@ -346,15 +345,15 @@ The computation to select the minimal pack proceeds as follows
 
 C: Use ref discovery to obtain the advertised refs.
 
-C: Place any object seen into set ADVERTISED.
+C: Place any object seen into set `advertised`.
 
-C: Build an empty set, COMMON, to hold the objects that are later
+C: Build an empty set, `common`, to hold the objects that are later
    determined to be on both ends.
 
-C: Build a set, WANT, of the objects from ADVERTISED the client
+C: Build a set, `want`, of the objects from `advertised` the client
    wants to fetch, based on what it saw during ref discovery.
 
-C: Start a queue, C_PENDING, ordered by commit time (popping newest
+C: Start a queue, `c_pending`, ordered by commit time (popping newest
    first).  Add all client refs.  When a commit is popped from
    the queue its parents SHOULD be automatically inserted back.
    Commits MUST only enter the queue once.
@@ -363,14 +362,14 @@ C: Start a queue, C_PENDING, ordered by commit time (popping newest
 
 C: Send one `$GIT_URL/git-upload-pack` request:
 
-   C: 0032want <WANT #1>...............................
-   C: 0032want <WANT #2>...............................
+   C: 0032want <want #1>...............................
+   C: 0032want <want #2>...............................
    ....
-   C: 0032have <COMMON #1>.............................
-   C: 0032have <COMMON #2>.............................
+   C: 0032have <common #1>.............................
+   C: 0032have <common #2>.............................
    ....
-   C: 0032have <HAVE #1>...............................
-   C: 0032have <HAVE #2>...............................
+   C: 0032have <have #1>...............................
+   C: 0032have <have #2>...............................
    ....
    C: 0000
 
@@ -393,38 +392,38 @@ A single "want" or "have" command MUST have one hex formatted
 SHA-1 as its value.  Multiple SHA-1s MUST be sent by sending
 multiple commands.
 
-The HAVE list is created by popping the first 32 commits
-from C_PENDING.  Less can be supplied if C_PENDING empties.
+The `have` list is created by popping the first 32 commits
+from `c_pending`.  Less can be supplied if `c_pending` empties.
 
-If the client has sent 256 HAVE commits and has not yet
-received one of those back from S_COMMON, or the client has
-emptied C_PENDING it SHOULD include a "done" command to let
+If the client has sent 256 "have" commits and has not yet
+received one of those back from `s_common`, or the client has
+emptied `c_pending` it SHOULD include a "done" command to let
 the server know it won't proceed:
 
    C: 0009done
 
 S: Parse the git-upload-pack request:
 
-Verify all objects in WANT are directly reachable from refs.
+Verify all objects in `want` are directly reachable from refs.
 
 The server MAY walk backwards through history or through
 the reflog to permit slightly stale requests.
 
-If no WANT objects are received, send an error:
+If no "want" objects are received, send an error:
 TODO: Define error if no "want" lines are requested.
 
-If any WANT object is not reachable, send an error:
+If any "want" object is not reachable, send an error:
 TODO: Define error if an invalid "want" is requested.
 
-Create an empty list, S_COMMON.
+Create an empty list, `s_common`.
 
 If "have" was sent:
 
 Loop through the objects in the order supplied by the client.
 
 For each object, if the server has the object reachable from
-a ref, add it to S_COMMON.  If a commit is added to S_COMMON,
-do not add any ancestors, even if they also appear in HAVE.
+a ref, add it to `s_common`.  If a commit is added to `s_common`,
+do not add any ancestors, even if they also appear in `have`.
 
 S: Send the git-upload-pack response:
 
@@ -440,7 +439,7 @@ stream 1.  Progress messages from the server side MAY appear
 in stream 2.
 
 Here a "closed set of objects" is defined to have at least
-one path from every WANT to at least one COMMON object.
+one path from every "want" to at least one "common" object.
 
 If the server needs more information, it replies with a
 status continue response:
-- 
1.8.5.2.msysgit.0


---
Thomas
