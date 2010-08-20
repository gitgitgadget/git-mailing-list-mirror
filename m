From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 14/17] Documentation: avoid stray backslashes in core
 tutorial
Date: Fri, 20 Aug 2010 05:37:51 -0500
Message-ID: <20100820103751.GN10407@burratino>
References: <20100820101902.GA10356@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Ramkumar Ramachandra <artagnon@gmail.com>,
	=?utf-8?B?RnLDqWTDqXJpYyBCcmnDqHJl?= <fbriere@fbriere.net>,
	Christian Couder <chriscool@tuxfamily.org>,
	Thomas Rast <trast@student.ethz.ch>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 20 12:39:39 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OmP0c-000659-L7
	for gcvg-git-2@lo.gmane.org; Fri, 20 Aug 2010 12:39:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752649Ab0HTKje convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 20 Aug 2010 06:39:34 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:41011 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751103Ab0HTKjd convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 20 Aug 2010 06:39:33 -0400
Received: by iwn5 with SMTP id 5so691567iwn.19
        for <git@vger.kernel.org>; Fri, 20 Aug 2010 03:39:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=62HO9tq0xu4HB5a8mtvFj5NcslHuO8L8lozPCkoeN3c=;
        b=W/rhgbUx/AClPLNDlqq0g6JemkGZuLx2ILmIpUlKn1/MiMK1I0iXlUqduNT79mecac
         KPEhC5fQaUEvl4Baf9BRQGSrTdddm+L2MSBBbo5jDMaYjMO/NqnfYjMbvxIuJKX+q5AG
         IyNpA/dbYQd1w0LYUdbRh6OZj+nSV2uUFipCQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=cCxRCilpshOSrmV9k7M7VCcTunZjy22VFYzWUL9LP18dDnwCaqqfvNw2G3Lvr3uibk
         ILYRafOjY+5TrqrNjy8PcG0vAVe7q6Q3lwYARu782g4Z+QZ2uyNNfX7T6lJE/Kk2ekVP
         1ti6Jo/OZb9oMzUMQ0x3pbPQSIX6BXi/plX+M=
Received: by 10.231.10.132 with SMTP id p4mr1460298ibp.67.1282300772507;
        Fri, 20 Aug 2010 03:39:32 -0700 (PDT)
Received: from burratino (dhcp-11-17.cs.uchicago.edu [128.135.11.176])
        by mx.google.com with ESMTPS id n20sm2501900ibe.11.2010.08.20.03.39.31
        (version=SSLv3 cipher=RC4-MD5);
        Fri, 20 Aug 2010 03:39:32 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20100820101902.GA10356@burratino>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154009>

While at it:

 - remove some single-quotes that were being rendered as =E2=80=99\n\';

 - do not escape ellipses (...) when they do not represent the
   literal three characters "...".  We may want to ensure the
   manpages render these as three ASCII periods to make the
   manual pages easier to search, but that would be a global
   output generation setting, not a context-specific thing;

Reported-by: Fr=C3=A9d=C3=A9ric Bri=C3=A8re <fbriere@fbriere.net>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 Documentation/gitcore-tutorial.txt |   18 +++++++++---------
 1 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/Documentation/gitcore-tutorial.txt b/Documentation/gitcore=
-tutorial.txt
index ed3ddc9..5e9c5eb 100644
--- a/Documentation/gitcore-tutorial.txt
+++ b/Documentation/gitcore-tutorial.txt
@@ -110,7 +110,7 @@ An 'object' is identified by its 160-bit SHA1 hash,=
 aka 'object name',
 and a reference to an object is always the 40-byte hex
 representation of that SHA1 name. The files in the `refs`
 subdirectory are expected to contain these hex references
-(usually with a final `\'\n\'` at the end), and you should thus
+(usually with a final `\n` at the end), and you should thus
 expect to see a number of 41-byte files containing these
 references in these `refs` subdirectories when you actually start
 populating your tree.
@@ -310,7 +310,7 @@ and this will just output the name of the resulting=
 tree, in this case
 ----------------
=20
 which is another incomprehensible object name. Again, if you want to,
-you can use `git cat-file -t 8988d\...` to see that this time the obje=
ct
+you can use `git cat-file -t 8988d...` to see that this time the objec=
t
 is not a "blob" object, but a "tree" object (you can also use
 `git cat-file` to actually output the raw object contents, but you'll =
see
 mainly a binary mess, so that's less interesting).
@@ -436,8 +436,8 @@ $ git update-index hello
 (note how we didn't need the `\--add` flag this time, since git knew
 about the file already).
=20
-Note what happens to the different 'git diff-\*' versions here. After
-we've updated `hello` in the index, `git diff-files -p` now shows no
+Note what happens to the different 'git diff-{asterisk}' versions here=
=2E
+After we've updated `hello` in the index, `git diff-files -p` now show=
s no
 differences, but `git diff-index -p HEAD` still *does* show that the
 current state is different from the state we committed. In fact, now
 'git diff-index' shows the same difference whether we use the `--cache=
d`
@@ -494,7 +494,7 @@ and it will show what the last commit (in `HEAD`) a=
ctually changed.
 [NOTE]
 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
 Here is an ASCII art by Jon Loeliger that illustrates how
-various diff-\* commands compare things.
+various 'diff-{asterisk}' commands compare things.
=20
                       diff-tree
                        +----+
@@ -958,11 +958,11 @@ $ git show-branch --topo-order --more=3D1 master =
mybranch
 The first two lines indicate that it is showing the two branches
 and the first line of the commit log message from their
 top-of-the-tree commits, you are currently on `master` branch
-(notice the asterisk `\*` character), and the first column for
+(notice the asterisk `{asterisk}` character), and the first column for
 the later output lines is used to show commits contained in the
 `master` branch, and the second column for the `mybranch`
 branch. Three commits are shown along with their log messages.
-All of them have non blank characters in the first column (`*`
+All of them have non blank characters in the first column (`{asterisk}=
`
 shows an ordinary commit on the current branch, `-` is a merge commit)=
, which
 means they are now part of the `master` branch. Only the "Some
 work" commit has the plus `+` character in the second column,
@@ -1092,7 +1092,7 @@ Downloader from http and https URL
 first obtains the topmost commit object name from the remote site
 by looking at the specified refname under `repo.git/refs/` directory,
 and then tries to obtain the
-commit object by downloading from `repo.git/objects/xx/xxx\...`
+commit object by downloading from `repo.git/objects/xx/xxx...`
 using the object name of that commit object.  Then it reads the
 commit object to find out its parent commits and the associate
 tree object; it repeats this process until it gets all the
@@ -1420,7 +1420,7 @@ packed, and stores the packed file in `.git/objec=
ts/pack`
 directory.
=20
 [NOTE]
-You will see two files, `pack-\*.pack` and `pack-\*.idx`,
+You will see two files, `pack-{asterisk}.pack` and `pack-{asterisk}.id=
x`,
 in `.git/objects/pack` directory. They are closely related to
 each other, and if you ever copy them by hand to a different
 repository for whatever reason, you should make sure you copy
--=20
1.7.2.2.536.g42dab.dirty
