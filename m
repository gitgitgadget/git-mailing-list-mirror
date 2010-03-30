From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH v2] Documentation/remote-helpers: Add invocation section
Date: Tue, 30 Mar 2010 22:17:10 +0530
Message-ID: <f3271551003300947u4c7c2a83q13aaf786140bfa37@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Gabriel Filion <lelutin@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Ilari Liusvaara <ilari.liusvaara@elisanet.fi>
To: Daniel Barkalow <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Tue Mar 30 18:47:42 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NwebM-0005Hy-5M
	for gcvg-git-2@lo.gmane.org; Tue, 30 Mar 2010 18:47:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753673Ab0C3Qre (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Mar 2010 12:47:34 -0400
Received: from mail-gw0-f46.google.com ([74.125.83.46]:46331 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752795Ab0C3Qrd (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Mar 2010 12:47:33 -0400
Received: by gwaa18 with SMTP id a18so4818370gwa.19
        for <git@vger.kernel.org>; Tue, 30 Mar 2010 09:47:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:from:date:received
         :message-id:subject:to:cc:content-type;
        bh=1IRKq2YCXB3le7x+1iJzuW36GVbPY0Nt0sN8NSfTKww=;
        b=sCc+OHZS2vqUYu1UprBOOwjIJCQ6JLFqwtq96W70XRcIKDQlIbY7HXC+PbJZcZgugQ
         aHmopwHRmVZuWbpI0k54syNKKGWharcpKxdShmWm7CXbSLNfU6Fn2izqH9gakiHQY5Hr
         bl5RYsivfSU2ZXWQsxErSJoYe5QmaxuukRDos=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:from:date:message-id:subject:to:cc:content-type;
        b=Nr6wwWI1rUsQNaBDw2nGs6uKSrbiNQM+4GxzlDEXs26uqr5K+8GNWjkcMUxQQteUI+
         HVAdpTnXCsr5YMS5kEzV5VHJCQe56s+nVqCZ3ROt7xEhf84GFkoF69usyrFNTpT+1KZz
         Szv1lbnClP9G83J+h8z6wcSs+kyjULYAm7WTA=
Received: by 10.90.69.14 with HTTP; Tue, 30 Mar 2010 09:47:10 -0700 (PDT)
Received: by 10.91.163.11 with SMTP id q11mr2035299ago.90.1269967652658; Tue, 
	30 Mar 2010 09:47:32 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143578>

Add an invocation section to specify what the command line arguments
mean. Also include a link to git-remote in the see also section.
---
 The first version contained too much information.
 Followed Daniel Barkalow's suggestion to strip it of caller information.

 Documentation/git-remote-helpers.txt |   16 ++++++++++++++++
 1 files changed, 16 insertions(+), 0 deletions(-)

diff --git a/Documentation/git-remote-helpers.txt
b/Documentation/git-remote-helpers.txt
index 2382fb4..e9c9d77 100644
--- a/Documentation/git-remote-helpers.txt
+++ b/Documentation/git-remote-helpers.txt
@@ -38,6 +38,16 @@ Git comes with a "curl" family of remote helpers,
specifically
 'git-remote-ftps'. They implement the capabilities 'fetch', 'option',
 and 'push'.

+INVOCATION
+----------
+
+Remote helper programs are invoked with one or optionally two
+arguments on the command line. The first argument specifies a remote
+to use; typically, it is either the name of a remote in the
+configuration or just a URL. The second argument is a URL, and serves
+to resolve ambiguities that may arise when only the first argument is
+specified.
+
 COMMANDS
 --------

@@ -206,6 +216,12 @@ OPTIONS
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
