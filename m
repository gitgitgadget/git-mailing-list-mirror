From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH v3] Documentation/remote-helpers: Add invocation section
Date: Wed, 31 Mar 2010 00:48:44 +0530
Message-ID: <f3271551003301218k4828c44id700b4865001baf9@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Daniel Barkalow <barkalow@iabervon.org>,
	Gabriel Filion <lelutin@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	Git Mailing List <git@vger.kernel.org>,
	Ilari Liusvaara <ilari.liusvaara@elisanet.fi>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Tue Mar 30 21:26:14 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nwh4n-0002ff-Me
	for gcvg-git-2@lo.gmane.org; Tue, 30 Mar 2010 21:26:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755984Ab0C3T0I (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Mar 2010 15:26:08 -0400
Received: from mail-yw0-f172.google.com ([209.85.211.172]:47064 "EHLO
	mail-yw0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754502Ab0C3T0G (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Mar 2010 15:26:06 -0400
Received: by ywh2 with SMTP id 2so5863312ywh.33
        for <git@vger.kernel.org>; Tue, 30 Mar 2010 12:26:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:from:date:received
         :message-id:subject:to:cc:content-type;
        bh=eHgy3VT92G0pAhPEFjthZqJH60DYemAprocpav1pP8w=;
        b=ZIublQqr2+A4a2nbZaf/7l2ZIs9gRs63kPWK/TSieQODMyt+cbpgtVC/OSRlu7N9LK
         PE3DmslmtbqAJXVwReM6Ps91O6zEGo0/7sbs41af09bRIkuH9U4rhwc1W52swbGfAeYh
         q+PAhX4zWFGcd5rl2/DuaMwCQj3KANtRer1K8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:from:date:message-id:subject:to:cc:content-type;
        b=Fz8V9RGdrbFP2kcvANmlrb4Slkriv0AGiPE9jjb2GKsTpvXjqdWtDUxZu8bP0H10K/
         LJsq6Q+b1XQwnuBupXnyVKjob0qSsMA3I7KDxMQWu89qzRxRt2P2OZ9zOWlPC7SjG//L
         qAkX3GjX4b/Arnyw6E7/Ik1lM6Oujbjq20Y5Y=
Received: by 10.90.69.14 with HTTP; Tue, 30 Mar 2010 12:18:44 -0700 (PDT)
Received: by 10.91.161.39 with SMTP id n39mr1213394ago.98.1269976745161; Tue, 
	30 Mar 2010 12:19:05 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143592>

Add an invocation section to specify what the command line arguments
mean. Also include a link to git-remote in the see also section.
---
 What changed since v2: Explained the meaning of ambiguity, and
 improved overall clarity.

 Documentation/git-remote-helpers.txt |   17 +++++++++++++++++
 1 files changed, 17 insertions(+), 0 deletions(-)

diff --git a/Documentation/git-remote-helpers.txt
b/Documentation/git-remote-helpers.txt
index 2382fb4..4375678 100644
--- a/Documentation/git-remote-helpers.txt
+++ b/Documentation/git-remote-helpers.txt
@@ -38,6 +38,17 @@ Git comes with a "curl" family of remote helpers,
specifically
 'git-remote-ftps'. They implement the capabilities 'fetch', 'option',
 and 'push'.

+INVOCATION
+----------
+
+Remote helper programs are invoked with one or (optionally) two
+command line arguments. The first argument specifies a remote
+repository as it would be in git; typically, it is either the name of
+a configured remote or just a URL. The second argument, if present, is
+a URL, and serves to resolve ambiguities that may arise when only the
+first argument is specified (i.e. when a remote has more than one
+configured URL).
+
 COMMANDS
 --------

@@ -206,6 +217,12 @@ OPTIONS
 	must not rely on this option being set before
 	connect request occurs.

+
+SEE ALSO
+--------
+linkgit:git-remote[1]
+
+
 Documentation
 -------------
 Documentation by Daniel Barkalow and Ilari Liusvaara
-- 
1.7.0.3
