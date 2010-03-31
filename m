From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH v4] Documentation/remote-helpers: Add invocation section
Date: Thu, 1 Apr 2010 01:10:04 +0530
Message-ID: <x2zf3271551003311240i53ecb2fck173c8f34bdb3257@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Ilari Liusvaara <ilari.liusvaara@elisanet.fi>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Gabriel Filion <lelutin@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Mar 31 21:40:36 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nx3mD-0005O0-7q
	for gcvg-git-2@lo.gmane.org; Wed, 31 Mar 2010 21:40:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757257Ab0CaTk1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 31 Mar 2010 15:40:27 -0400
Received: from mail-gy0-f174.google.com ([209.85.160.174]:56183 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756585Ab0CaTk0 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 31 Mar 2010 15:40:26 -0400
Received: by gyg13 with SMTP id 13so225793gyg.19
        for <git@vger.kernel.org>; Wed, 31 Mar 2010 12:40:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:from:date:received
         :message-id:subject:to:cc:content-type;
        bh=eM1XYTDahUG39X5YL5Bu+XEN1/GHMc3/mHRrj0W20RU=;
        b=hzVUL+T2YCkjXmKHs6qmDiSiV6oXFT/nXSRNKys4kcAy7bDYVimQ+D7kQ37C1Q1JA/
         E42RcO3NV+CgGg5/4qGvPiI9fGJvbOPQbTjCaCe4IiPibMvitJsAtqRLxMLa2hSXORKu
         S/yCD6VduTCHlRB/fegFDozk7CxOQ6vp69biI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:from:date:message-id:subject:to:cc:content-type;
        b=Um6yll14bqJn6wBvVoy67jybxhjJxjHEUUEomSX2aMofJJkHLVqZtgunww5jzNYn/l
         tEs8s/pItwFBHMmF6PPZsNeSPj0gIIZ2Li9c/szl5NINIkCRRx29gE8ay/akZsw7x6k6
         6m1L0O9PE0MGGSr3eshMU5z2KVmcUNYPk1gwc=
Received: by 10.90.69.14 with HTTP; Wed, 31 Mar 2010 12:40:04 -0700 (PDT)
Received: by 10.90.24.32 with SMTP id 32mr447195agx.76.1270064425868; Wed, 31 
	Mar 2010 12:40:25 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143692>

Add an invocation section to specify what the command line arguments
mean. Also include a link to git-remote in the see also section.

Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
---
 What changed since v3: Clarification on what URLs can be, and
 possibility of second argument making the first redundant.

 Documentation/git-remote-helpers.txt |   18 ++++++++++++++++++
 1 files changed, 18 insertions(+), 0 deletions(-)

diff --git a/Documentation/git-remote-helpers.txt
b/Documentation/git-remote-helpers.txt
index 2382fb4..f2b2738 100644
--- a/Documentation/git-remote-helpers.txt
+++ b/Documentation/git-remote-helpers.txt
@@ -38,6 +38,20 @@ Git comes with a "curl" family of remote helpers,
specifically
 'git-remote-ftps'. They implement the capabilities 'fetch', 'option',
 and 'push'.

+INVOCATION
+----------
+
+Remote helper programs are invoked with one or (optionally) two
+command line arguments. The first argument specifies a remote
+repository as in git; typically, it is either the name of a configured
+remote or just a URL. The second argument, if present, is a URL. When
+the remote specified in the first argument has more than one
+configured URL, it serves to resolve the ambiguity and pick one of the
+URLs. Depending on the remote helper, supplying the second argument
+can make the first argument redundant. URLs may be those normally
+recognized by git, or arbitrary URL-like strings recognized by the
+specific remote helper being invoked.
+
 COMMANDS
 --------

@@ -206,6 +220,10 @@ OPTIONS
 	must not rely on this option being set before
 	connect request occurs.

+SEE ALSO
+--------
+linkgit:git-remote[1]
+
 Documentation
 -------------
 Documentation by Daniel Barkalow and Ilari Liusvaara
-- 
1.7.0.3
