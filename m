From: pclouds@gmail.com
Subject: [PATCH] Add revspec documentation for ':path', ':[0-3]:path' and git-describe
Date: Thu, 19 Oct 2006 10:04:55 +0700
Message-ID: <20061019030455.GA10554@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
X-From: git-owner@vger.kernel.org Thu Oct 19 05:07:29 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GaOFl-0000cr-0R
	for gcvg-git@gmane.org; Thu, 19 Oct 2006 05:07:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030296AbWJSDHN convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Wed, 18 Oct 2006 23:07:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423230AbWJSDHM
	(ORCPT <rfc822;git-outgoing>); Wed, 18 Oct 2006 23:07:12 -0400
Received: from py-out-1112.google.com ([64.233.166.181]:34572 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S1030294AbWJSDHK (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Oct 2006 23:07:10 -0400
Received: by py-out-1112.google.com with SMTP id n25so617583pyg
        for <git@vger.kernel.org>; Wed, 18 Oct 2006 20:06:36 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:to:subject:message-id:mime-version:content-type:content-disposition:content-transfer-encoding:user-agent:from;
        b=hAw9iQpvwFrUoJaoy4mnXlqww4MvOnIBXr1eqoMK2+f848tTgPLY+dE/s+YS7nCtqrCowfoc8w0wB/33BJXBccppLceIGkRQeoRD3QpD+PSEx35mgzY5EqAZgnU5LQhp2OtR/Jpij8nw5J73fx1coLU1ZiAeMRX5HCTluteI8so=
Received: by 10.35.9.15 with SMTP id m15mr19051957pyi;
        Wed, 18 Oct 2006 20:06:35 -0700 (PDT)
Received: from localhost ( [125.234.255.91])
        by mx.google.com with ESMTP id 36sm1652432nzk.2006.10.18.20.06.31;
        Wed, 18 Oct 2006 20:06:35 -0700 (PDT)
Received: by localhost (sSMTP sendmail emulation); Thu, 19 Oct 2006 10:04:55 +0700
To: git@vger.kernel.org, Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29315>


Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 Documentation/git-rev-parse.txt |    9 +++++++++
 1 files changed, 9 insertions(+), 0 deletions(-)

As I'm not very good at English, please correct any mistake I made

diff --git a/Documentation/git-rev-parse.txt b/Documentation/git-rev-pa=
rse.txt
index 2f1306c..f8f4920 100644
--- a/Documentation/git-rev-parse.txt
+++ b/Documentation/git-rev-parse.txt
@@ -119,11 +119,17 @@ syntax.
   name the same commit object if there are no other object in
   your repository whose object name starts with dae86e.
=20
+* The result of `git-describe`
+
 * A symbolic ref name.  E.g. 'master' typically means the commit
   object referenced by $GIT_DIR/refs/heads/master.  If you
   happen to have both heads/master and tags/master, you can
   explicitly say 'heads/master' to tell git which one you mean.
=20
+* A colon at the beginning, followed by path name to specify
+  a file in index. If you want to specify a file in a stage,
+  use expression ':[0-3]:<path>' instead.
+
 * A suffix '@' followed by a date specification enclosed in a brace
   pair (e.g. '\{yesterday\}', '\{1 month 2 weeks 3 days 1 hour 1
   second ago\}' or '\{1979-02-26 18:30:00\}') to specify the value
@@ -156,6 +162,9 @@ syntax.
   and dereference the tag recursively until a non-tag object is
   found.
=20
+* A suffix ':' followed by path name to specify a specific file
+  in that commit/tag/tree.
+
 Here is an illustration, by Jon Loeliger.  Both node B and C are
 a commit parents of commit node A.  Parent commits are ordered
 left-to-right.
--=20
1.4.3.rc2.g0503-dirty
