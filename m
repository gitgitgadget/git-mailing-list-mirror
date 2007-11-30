From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH (homepage)] Make git homepage (main page) use valid HTML
Date: Fri, 30 Nov 2007 11:59:10 +0100
Message-ID: <200711301159.11290.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: Petr Baudis <pasky@suse.cz>
X-From: git-owner@vger.kernel.org Fri Nov 30 12:00:00 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Iy3at-0000KG-GV
	for gcvg-git-2@gmane.org; Fri, 30 Nov 2007 11:59:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759648AbXK3K7T (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 Nov 2007 05:59:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758979AbXK3K7T
	(ORCPT <rfc822;git-outgoing>); Fri, 30 Nov 2007 05:59:19 -0500
Received: from nf-out-0910.google.com ([64.233.182.187]:47857 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759646AbXK3K7S (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Nov 2007 05:59:18 -0500
Received: by nf-out-0910.google.com with SMTP id g13so2205223nfb
        for <git@vger.kernel.org>; Fri, 30 Nov 2007 02:59:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date:user-agent:cc:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        bh=jQYgXuK1Dp7ymVEUon/PRKufK7YPZtxRzhlia1W1iEQ=;
        b=uffsrD2gDiamDhMFXbUCF8Xus2E4UijNREs7MQPcvP3oYFJrKQcDUFs1KDrJws44XexTITNLG6+MZnyOtHE0fKToEVzsYj42xPvPjwrMyddwRWqC5uEVV8fQx/VS0LohabADOiTQCQlUmCk+u9NpXyw1yTLSUcDkUbeH8HR9XD0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=received:from:to:subject:date:user-agent:cc:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=ka5vmInkVN+cH+tBL6mQW0oinv4FeXfs4LbaY/jpSX0PFn11yEaahJwGnC/2vM9pnZwy5WkD2i7z5OfvJ3Nf+9mrvBjAuF0WA/VehmJOry6fRz40qvAYHZLtZKOZoZJBWIA1KdKD0WQEDFR0LWBJGjHvWN6JHk5V1hXUfk7wCBI=
Received: by 10.86.25.17 with SMTP id 17mr7138077fgy.1196420355658;
        Fri, 30 Nov 2007 02:59:15 -0800 (PST)
Received: from ?192.168.1.11? ( [83.8.252.40])
        by mx.google.com with ESMTPS id 3sm7611332fge.2007.11.30.02.59.13
        (version=SSLv3 cipher=OTHER);
        Fri, 30 Nov 2007 02:59:14 -0800 (PST)
User-Agent: KMail/1.9.3
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66628>

Checked by W3C Markup Validation Service:
  http://validator.w3.org

Most of those changes makes git homepage use valid XML / SGML;
the errors were incorrect ordering of closing tags, wrong closing
tags, spurious closing tags.

HTML declares that <p> element cannot contain other block elements
(at least not interspersed with text); correcting this also fixed
layout (in Mozilla), where part of paragraph after <pre> element
was not indented.

Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
Resent.

I hope that it would make through anti-SPAM filters...

 index.html |   23 +++++++++++------------
 1 files changed, 11 insertions(+), 12 deletions(-)

diff --git a/index.html b/index.html
index 01726f6..29fa0b1 100644
--- a/index.html
+++ b/index.html
@@ -88,7 +88,8 @@ Junio C Hamano.</p>
 
 <h2 id="about">About Git</h2>
 
-<div style="float: right"><table class="releases">
+<div style="float: right">
+<table class="releases">
 	<tr><th><a href="course/index.html">Git Crash Courses</a></th></tr>
 	<tr><td align="center">
 	<a 
href="http://www.kernel.org/pub/software/scm/git/docs/tutorial.html">Git 
for everyone</a>
@@ -98,8 +99,9 @@ Junio C Hamano.</p>
 	<br /><a href="course/stgit.html">Maintaining external patches</a>
 	<br /><a href="course/svn.html">Git for SVN users</a>
 	<br /><em>More to come soon...</em>
-	</tr></td>
-</table></div>
+	</td></tr>
+</table>
+</div>
 
 <p>Git is distributed version control system focused on
 speed, effectivity and real-world usability on large projects.
@@ -173,7 +175,7 @@ and are either porting an existing toolset to use 
the Git tools,
 or reimplementing the concepts internally,
 to benefit from the performance improvements.
 This includes e.g.
-<a href="http://wiki.darcs.net/DarcsWiki/DarcsGit">Darcs-git</a>.</li>
+<a href="http://wiki.darcs.net/DarcsWiki/DarcsGit">Darcs-git</a>.</p>
 
 
 <hr />
@@ -223,7 +225,7 @@ You can also use one of many <a 
href="http://www.kernel.org/mirrors/">kernel.org
 <tr class="odd">
 <td rowspan="3">Debs</td>
 <td>Stable</td>
-<td><a 
href="http://www.backports.org/debian/pool/main/g/git-core/">http://www.backports.org/debian/pool/main/g/git-core/</a></dd></td>
+<td><a 
href="http://www.backports.org/debian/pool/main/g/git-core/">http://www.backports.org/debian/pool/main/g/git-core/</a></td>
 </tr>
 <tr>
 <td>Testing</td>
@@ -233,7 +235,6 @@ You can also use one of many <a 
href="http://www.kernel.org/mirrors/">kernel.org
 <td>Unstable</td>
 <td><a 
href="http://packages.debian.org/unstable/devel/git-core">http://packages.debian.org/unstable/devel/git-core</a></td>
 </tr>
-</td>
 
 </table>
 
@@ -247,16 +248,14 @@ You can also use one of many <a 
href="http://www.kernel.org/mirrors/">kernel.org
 <h3>Git by git</h3>
 
 <p>If you already have Git installed, you can get the latest
-development version via Git itself:
+development version via Git itself:</p>
 <pre>git clone git://git.kernel.org/pub/scm/git/git.git</pre>
-</p>
 
 <p>If you have problems connecting (Git uses port 9418),
-you can try to access the repository over the HTTP protocol:
+you can try to access the repository over the HTTP protocol:</p>
 <pre>git clone http://www.kernel.org/pub/scm/git/git.git</pre>
-(this method is considerably slower but works even behind
-firewalls and such).
-</p>
+<p>(this method is considerably slower but works even behind
+firewalls and such).</p>
 
 <p>You can also always browse the current contents
 of the git repository on web using the kernel.org
-- 
1.5.3.6
