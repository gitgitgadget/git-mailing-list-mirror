From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Adding Git to Better SCM Initiative : Comparison
Date: Thu, 29 Nov 2007 03:26:12 +0100
Message-ID: <200711290326.13822.jnareb@gmail.com>
References: <200711282339.59938.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Nov 29 03:26:40 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IxZ6s-00037L-8F
	for gcvg-git-2@gmane.org; Thu, 29 Nov 2007 03:26:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758816AbXK2C0S convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 28 Nov 2007 21:26:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758440AbXK2C0S
	(ORCPT <rfc822;git-outgoing>); Wed, 28 Nov 2007 21:26:18 -0500
Received: from nf-out-0910.google.com ([64.233.182.189]:10194 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758057AbXK2C0R (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Nov 2007 21:26:17 -0500
Received: by nf-out-0910.google.com with SMTP id g13so1653444nfb
        for <git@vger.kernel.org>; Wed, 28 Nov 2007 18:26:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        bh=yEe6WXaJR/xUcFmZk6BSf1NWL5VxsBLpW0oKyPQELNc=;
        b=rOJiP+PEGirJTwPGSW6nJJgdCX50KZvZt7Qs0UgtlIUWTe+z9sjYE3bWyaBvU1UQ2/hrReY+SjfZK6nsbVztDT66cdcvO9z3qUs2kHpH6uBn4Wtb/8aB1d00cOB7//4aoXAYzkvvaDeK0D80/Qb54+H6Ijw6L4CSsAvvZYnVH0w=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=QS40unJLkrGG8rXWre8OOgpYplvelAW44qbLtfNaTxT7RQnaStxxq0W27fg2jOjs4ia9TELehzSOOwbiCPvYQzGigPzF85BXSOqqmB+V/cfuDZw33LhtEaWUB/Qg3RZUnTgVtlEUTtLwvhbN/mPXujrL7mONPlqFyzMhxWav5yg=
Received: by 10.86.51.2 with SMTP id y2mr705110fgy.1196303175265;
        Wed, 28 Nov 2007 18:26:15 -0800 (PST)
Received: from ?192.168.1.11? ( [83.8.215.156])
        by mx.google.com with ESMTPS id i5sm11859403mue.2007.11.28.18.26.12
        (version=SSLv3 cipher=OTHER);
        Wed, 28 Nov 2007 18:26:13 -0800 (PST)
User-Agent: KMail/1.9.3
In-Reply-To: <200711282339.59938.jnareb@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66493>

Jakub Narebski wrote:

> To do that, I need to fill in information about Git. =A0Most
> of questions / items didn't give much problem, but there
> are a few on which I would like your input.

By the way, below is patch with the information I have filled.
Check out the TO DO items.

diff --git a/src/comparison/scm-comparison.xml b/src/comparison/scm-com=
parison.xml
index b459747..6f84190 100644
--- a/src/comparison/scm-comparison.xml=09
+++ b/src/comparison/scm-comparison.xml=09
@@ -38,6 +38,9 @@ TODO:
             <impl id=3D"darcs">
                 <name>Darcs</name>
             </impl>
+            <impl id=3D"git">
+                <name>Git</name>
+            </impl>
             <impl id=3D"mercurial">
                 <name>Mercurial</name>
             </impl>
@@ -106,6 +109,7 @@ TODO:
                 <s id=3D"svk">Commits are atomic.</s>
                 <s id=3D"aegis">Commits are atomic.</s>
                 <s id=3D"bitkeeper">Yes (but need to verify)</s>
+                <s id=3D"git">Yes.</s>
                 <s id=3D"mercurial">Yes.</s>
                 <s id=3D"monotone">Yes.</s>
                 <s id=3D"opencm">Yes. Commits are atomic.</s>
@@ -142,6 +146,11 @@ TODO:
                 <s id=3D"darcs">Yes. Renames are supported.</s>
                 <s id=3D"bitkeeper">Yes. Renames are supported.</s>
                 <s id=3D"aegis">Yes. Renames are supported.</s>
+                <s id=3D"git">
+                    N/A. Git does not track renames, but detects renam=
es
+                    and copies.  You can follow history of file using
+                    'git log --follow'.
+                </s>
                 <s id=3D"mercurial">Yes. Renames are supported.</s>
                 <s id=3D"monotone">Yes. Renames are supported.</s>
                 <s id=3D"opencm">Yes. Renames are supported</s>
@@ -214,6 +223,11 @@ TODO:
                     Yes. Copies are supported.
                 </s>
                 <s id=3D"aegis">No. Copies are not supported.</s>
+                <s id=3D"git">
+                    N/A. Git does not track copies, but detects rename=
s
+                    and copies.  You can follow history of file using
+                    'git log -C --follow'.
+                </s>
                 <s id=3D"mercurial">Yes. Copies are supported</s>
                 <s id=3D"monotone">Yes. Copies are supported</s>
                 <s id=3D"opencm">No. Copies are not supported.</s>
@@ -267,6 +281,7 @@ TODO:
                 <s id=3D"darcs">Yes.</s>
                 <s id=3D"bitkeeper">Yes.</s>
                 <s id=3D"aegis">Yes.</s>
+                <s id=3D"git">Yes.</s>
                 <s id=3D"mercurial">Yes.</s>
                 <s id=3D"monotone">Yes.</s>
                 <s id=3D"opencm">No.</s>
@@ -313,6 +328,7 @@ TODO:
                 <s id=3D"darcs">Yes.</s>
                 <s id=3D"bitkeeper">Yes.</s>
                 <s id=3D"aegis">Yes.</s>
+                <s id=3D"git">Yes.</s>
                 <s id=3D"mercurial">Yes.</s>
                 <s id=3D"monotone">Yes.</s>
                 <s id=3D"opencm">No.</s>
@@ -373,6 +389,10 @@ TODO:
                 <s id=3D"svk">
                     Same as subversion.
                 </s>
+                <s id=3D"git">
+                    Partial (?). It is possible to lock down repositor=
y
+                    (access to branches and tags) using hooks.
+                </s>
                 <s id=3D"mercurial">
                     Yes. It is possible to lock down repositories,
                     subdirectories, or files using hooks.
@@ -455,6 +475,9 @@ TODO:
                 <s id=3D"darcs">
                     Yes. Changesets are supported.
                 </s>
+                <s id=3D"git">
+                    Yes. Changesets are supported.
+                </s>
                 <s id=3D"mercurial">
                     Yes. Changesets are supported.
                 </s>
@@ -509,6 +532,7 @@ TODO:
                 <s id=3D"arch">Not in the command line client, but Vie=
wARCH,
                 a web-interface for Arch, has it.</s>
                 <s id=3D"darcs">Yes. (darcs annotate)</s>
+                <s id=3D"git">Yes. (git blame, git gui blame)</s>
                 <s id=3D"mercurial">Yes. (hg annotate)</s>
                 <s id=3D"monotone">Yes, as of version 0.19.</s>
                 <s id=3D"aegis">Yes. aeannotate</s>
@@ -570,6 +594,9 @@ TODO:
                     whole.
                 </s>
                 <s id=3D"aegis">No. All changes are made repository-wi=
de.</s>
+                <s id=3D"git">
+                    No. All changes are made repository-wide.
+                    But you can use submodules / subrpoject support fo=
r that.</s>
                 <s id=3D"mercurial">
                     It is possible to commit changes only in a subset =
of the
                     tree. There are plans for partial checkouts.
@@ -636,6 +663,10 @@ TODO:
                     Yes, using "darcs whatsnew".
                 </s>
                 <s id=3D"aegis">Yes. Using aediff</s>
+                <s id=3D"git">
+                    Yes. Using git diff.
+                    Note that git uses staging area for commits (index=
).
+                </s>
                 <s id=3D"mercurial">Yes. Using hg diff.</s>
                 <s id=3D"monotone">Yes. In a similar fashion to CVS.</=
s>
                 <s id=3D"opencm">Yes. Using cm diff</s>
@@ -681,6 +712,10 @@ TODO:
                 <s id=3D"darcs">
                     No.
                 </s>
+                <s id=3D"git">
+                    No.  But you can tag (with description) given cont=
ents
+                    of a file (blob).
+                </s>
                 <s id=3D"mercurial">
                     No.
                 </s>
@@ -782,6 +817,15 @@ TODO:
                     and the client contains a help tool that offers
                     an integrated help system.
                 </s>
+                <s id=3D"git">
+                    Medium. There's Git User's Manual, manpages, some
+                    technical documentation and some howtos.  All
+                    documentation is also available online in HTML for=
mat;
+                    there is additional information (including beginni=
ngs
+                    of FAQ) on git wiki.
+                    Nevertheles one of complaints in surveys is insuff=
icient
+                    or fragmented documentation.
+                </s>
                 <s id=3D"mercurial">
                     Very good. There's an overview and tutorial on the
                     web site, and integrated help for every command.
@@ -894,6 +938,14 @@ TODO:
                     to install the subversion perl bindings and a few =
modules
                     from CPAN.
                 </s>
+                <s id=3D"git">
+                    TO DO. RPMs and deb packages for Linux. msysGit an=
d
+                    Cygwin for Win32 - Git requires POSIX shell, Perl,
+                    and POSIX utilities for some commands (builtin).
+                    Autoconf to generate Makefile configuration; ready
+                    generic configuration for many OS. Compiling docs
+                    requires asciidoc and xmlto toolchain, but prebuil=
d.
+                </s>
                 <s id=3D"mercurial">
                     Excellent.  Binary packages are available for all
                     popular platforms.  Building from source requires
@@ -1006,6 +1058,13 @@ TODO:
                     but since the model is different most commands are
                     unique.
                 </s>
+                <s id=3D"git">
+                    TO DO.
+                    Tries to follow CVS conventions, but deviates wher=
e there
+                    is a different design.
+                    Large command set divided into plumbing (low lewel=
, to be
+                    used in scripts) and porcelain (high level).
+                </s>
                 <s id=3D"mercurial">
                     Tries to follow CVS conventions, but deviates wher=
e there
                     is a different design.
@@ -1106,6 +1165,10 @@ TODO:
                     There exists some HTTP-functionality, but it is qu=
ite
                     limited.
                 </s>
+                <s id=3D"git">
+                    Good.  Uses HTTPS (with WebDAV) or ssh for push,
+                    HTTP, FTP, ssh or custom protocol for fetch.
+                </s>
                 <s id=3D"mercurial">
                     Excellent.  Uses HTTP or ssh.  Remote access also
                     works safely without locks over read-only network
@@ -1203,6 +1266,10 @@ TODO:
                     Very good. Supports many UNIXes, Mac OS X, and Win=
dows,
                     and is written in a portable language.
                 </s>
+                <s id=3D"git">TO DO.
+                    Good.  Portable across all POSIX systems.
+                    There exists Win32 binary using MinGW.
+                </s>
                 <s id=3D"mercurial">
                     Excellent. Runs on all platforms supported by
                     Python.  Repositories are portable across CPU
@@ -1300,6 +1367,9 @@ TODO:
                     is included in the distribution.
                 </s>
                 <s id=3D"aegis">Yes.</s>
+                <s id=3D"git">
+                    Yes.  The web interface is a bundled component.
+                    Other web interfaces: cgit, wit, git-php</s>
                 <s id=3D"mercurial">Yes.  The web interface is a bundl=
ed component.</s>
                 <s id=3D"monotone">No.</s>
                 <s id=3D"opencm">No.</s>
@@ -1373,6 +1443,11 @@ TODO:
                 <s id=3D"aegis">
                     There is tkaegis.
                 </s>
+                <s id=3D"git">RO DO
+                    Bundled history viewer gitk and commit tool git-gu=
i,
+                    both use Tcl/Tk.  There is also qgit (Qt) and Gigg=
le
+                    (GTK+).
+                </s>
                 <s id=3D"mercurial">
                     History viewing available with hgit extension;
                     check-in extension (hgct) makes committing easier.
@@ -1453,6 +1528,7 @@ TODO:
                 GNU GPL (open-source)
             </s>
             <s id=3D"svk">Perl License. (open source)</s>
+            <s id=3D"git">GNU GPL (open source)</s>
             <s id=3D"mercurial">GNU GPL (open source)</s>
             <s id=3D"monotone">GNU GPL (open source)</s>
             <s id=3D"opencm">


--=20
Jakub Narebski
Poland
