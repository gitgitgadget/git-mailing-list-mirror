From: "Joshua T. Corbin" <jcorbin@wunjo.org>
Subject: [PATCH] git-pasky debian dir
Date: Fri, 22 Apr 2005 09:18:06 -0400
Message-ID: <200504220918.06977.jcorbin@wunjo.org>
Mime-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_OmPaC2BWp81bIoZ"
X-From: git-owner@vger.kernel.org Fri Apr 22 15:17:18 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DOy0r-0003Fp-Lo
	for gcvg-git@gmane.org; Fri, 22 Apr 2005 15:16:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261270AbVDVNUX (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 22 Apr 2005 09:20:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261434AbVDVNUX
	(ORCPT <rfc822;git-outgoing>); Fri, 22 Apr 2005 09:20:23 -0400
Received: from node1.wunjo.org ([64.62.190.230]:24493 "EHLO node1.wunjo.org")
	by vger.kernel.org with ESMTP id S261270AbVDVNTL (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 22 Apr 2005 09:19:11 -0400
Received: by node1.wunjo.org (Postfix, from userid 65534)
	id 6659A42EE3; Fri, 22 Apr 2005 09:19:10 -0400 (EDT)
Received: from thor.circle (24.229.157.212.cmts.dan.ptd.net [24.229.157.212])
	(using TLSv1 with cipher RC4-MD5 (128/128 bits))
	(No client certificate requested)
	by node1.wunjo.org (Postfix) with ESMTP id 3131942B73
	for <git@vger.kernel.org>; Fri, 22 Apr 2005 09:18:57 -0400 (EDT)
To: git@vger.kernel.org
User-Agent: KMail/1.8
X-Spam-Checker-Version: SpamAssassin 3.0.2 (2004-11-16) on node1
X-Spam-Level: 
X-Spam-Status: No, score=0.1 required=5.0 tests=FORGED_RCVD_HELO 
	autolearn=ham version=3.0.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

--Boundary-00=_OmPaC2BWp81bIoZ
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

After seeing the spec file, I had to do this:

You can get the binary here:
=A0 http://node1.wunjo.org/~jcorbin/git-pasky_0.6.3-1_i386.deb

alternatively you can pull from here:
=A0 rsync://node1.wunjo.org/git/git

It's against b31d16fad0013b3f106b227232559e24daf36962. It installs=20
to /usr/bin, but I hacked things about so that *.sh goes=20
in /usr/share/git-pasky/scripts. Haven't had many people try it yet, but it=
=20
works for me; this isn't exactly my first debian package, but if anyone see=
s=20
any glaring issues with it, I'd love to hear about it.

Signed-off-by: Joshua T. Corbin <jcorbin@wunjo.org>

--Boundary-00=_OmPaC2BWp81bIoZ
Content-Type: text/x-diff;
  charset="us-ascii";
  name="debian.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="debian.diff"

--- /dev/null
+++ 2f556bba4a059b3aaefb0bbacac64d60a14e127a/debian/changelog
@@ -0,0 +1,6 @@
+git-pasky (0.6.3-1) unstable; urgency=low
+
+  * Saw the spec file, felt obliged ;)
+
+ -- Joshua T. Corbin <jcorbin@wunjo.org>  Fri, 22 Apr 2005 00:17:03 -0400
+
--- /dev/null
+++ 2f556bba4a059b3aaefb0bbacac64d60a14e127a/debian/compat
@@ -0,0 +1 @@
+4
--- /dev/null
+++ 2f556bba4a059b3aaefb0bbacac64d60a14e127a/debian/control
@@ -0,0 +1,16 @@
+Source: git-pasky
+Section: admin
+Priority: optional
+Maintainer: Joshua T. Corbin <jcorbin@wunjo.org>
+Build-Depends: debhelper (>= 4.0.0)
+Standards-Version: 3.6.1
+
+Package: git-pasky
+Architecture: any
+Depends: ${shlibs:Depends}
+Description: GIT - the stupid content tracker
+ GIT comes in two layers. The bottom layer is merely an extremely fast and
+ flexible filesystem-based database designed to store directory trees with
+ regard to their history. The top layer is a SCM-like tool which enables human
+ beings to work with the database in a manner to a degree similar to other SCM
+ tools (like CVS, BitKeeper or Monotone).
--- /dev/null
+++ 2f556bba4a059b3aaefb0bbacac64d60a14e127a/debian/copyright
@@ -0,0 +1,367 @@
+This package was debianized by Joshua T. Corbin <jcorbin@wunjo.org> on
+Fri, 22 Apr 2005 00:17:03 -0400.
+
+It was downloaded from rsync://pasky.or.cz/git
+
+License:
+
+ Note that the only valid version of the GPL as far as this project
+ is concerned is _this_ particular version of the license (ie v2, not
+ v2.2 or v3.x or whatever), unless explicitly otherwise stated.
+
+ HOWEVER, in order to allow a migration to GPLv3 if that seems like
+ a good idea, I also ask that people involved with the project make
+ their preferences known. In particular, if you trust me to make that
+ decision, you might note so in your copyright message, ie something
+ like
+
+	This file is licensed under the GPL v2, or a later version
+	at the discretion of Linus.
+
+  might avoid issues. But we can also just decide to synchronize and
+  contact all copyright holders on record if/when the occasion arises.
+
+			Linus Torvalds
+
+----------------------------------------
+
+		    GNU GENERAL PUBLIC LICENSE
+		       Version 2, June 1991
+
+ Copyright (C) 1989, 1991 Free Software Foundation, Inc.
+                       59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+ Everyone is permitted to copy and distribute verbatim copies
+ of this license document, but changing it is not allowed.
+
+			    Preamble
+
+  The licenses for most software are designed to take away your
+freedom to share and change it.  By contrast, the GNU General Public
+License is intended to guarantee your freedom to share and change free
+software--to make sure the software is free for all its users.  This
+General Public License applies to most of the Free Software
+Foundation's software and to any other program whose authors commit to
+using it.  (Some other Free Software Foundation software is covered by
+the GNU Library General Public License instead.)  You can apply it to
+your programs, too.
+
+  When we speak of free software, we are referring to freedom, not
+price.  Our General Public Licenses are designed to make sure that you
+have the freedom to distribute copies of free software (and charge for
+this service if you wish), that you receive source code or can get it
+if you want it, that you can change the software or use pieces of it
+in new free programs; and that you know you can do these things.
+
+  To protect your rights, we need to make restrictions that forbid
+anyone to deny you these rights or to ask you to surrender the rights.
+These restrictions translate to certain responsibilities for you if you
+distribute copies of the software, or if you modify it.
+
+  For example, if you distribute copies of such a program, whether
+gratis or for a fee, you must give the recipients all the rights that
+you have.  You must make sure that they, too, receive or can get the
+source code.  And you must show them these terms so they know their
+rights.
+
+  We protect your rights with two steps: (1) copyright the software, and
+(2) offer you this license which gives you legal permission to copy,
+distribute and/or modify the software.
+
+  Also, for each author's protection and ours, we want to make certain
+that everyone understands that there is no warranty for this free
+software.  If the software is modified by someone else and passed on, we
+want its recipients to know that what they have is not the original, so
+that any problems introduced by others will not reflect on the original
+authors' reputations.
+
+  Finally, any free program is threatened constantly by software
+patents.  We wish to avoid the danger that redistributors of a free
+program will individually obtain patent licenses, in effect making the
+program proprietary.  To prevent this, we have made it clear that any
+patent must be licensed for everyone's free use or not licensed at all.
+
+  The precise terms and conditions for copying, distribution and
+modification follow.
+
+		    GNU GENERAL PUBLIC LICENSE
+   TERMS AND CONDITIONS FOR COPYING, DISTRIBUTION AND MODIFICATION
+
+  0. This License applies to any program or other work which contains
+a notice placed by the copyright holder saying it may be distributed
+under the terms of this General Public License.  The "Program", below,
+refers to any such program or work, and a "work based on the Program"
+means either the Program or any derivative work under copyright law:
+that is to say, a work containing the Program or a portion of it,
+either verbatim or with modifications and/or translated into another
+language.  (Hereinafter, translation is included without limitation in
+the term "modification".)  Each licensee is addressed as "you".
+
+Activities other than copying, distribution and modification are not
+covered by this License; they are outside its scope.  The act of
+running the Program is not restricted, and the output from the Program
+is covered only if its contents constitute a work based on the
+Program (independent of having been made by running the Program).
+Whether that is true depends on what the Program does.
+
+  1. You may copy and distribute verbatim copies of the Program's
+source code as you receive it, in any medium, provided that you
+conspicuously and appropriately publish on each copy an appropriate
+copyright notice and disclaimer of warranty; keep intact all the
+notices that refer to this License and to the absence of any warranty;
+and give any other recipients of the Program a copy of this License
+along with the Program.
+
+You may charge a fee for the physical act of transferring a copy, and
+you may at your option offer warranty protection in exchange for a fee.
+
+  2. You may modify your copy or copies of the Program or any portion
+of it, thus forming a work based on the Program, and copy and
+distribute such modifications or work under the terms of Section 1
+above, provided that you also meet all of these conditions:
+
+    a) You must cause the modified files to carry prominent notices
+    stating that you changed the files and the date of any change.
+
+    b) You must cause any work that you distribute or publish, that in
+    whole or in part contains or is derived from the Program or any
+    part thereof, to be licensed as a whole at no charge to all third
+    parties under the terms of this License.
+
+    c) If the modified program normally reads commands interactively
+    when run, you must cause it, when started running for such
+    interactive use in the most ordinary way, to print or display an
+    announcement including an appropriate copyright notice and a
+    notice that there is no warranty (or else, saying that you provide
+    a warranty) and that users may redistribute the program under
+    these conditions, and telling the user how to view a copy of this
+    License.  (Exception: if the Program itself is interactive but
+    does not normally print such an announcement, your work based on
+    the Program is not required to print an announcement.)
+
+These requirements apply to the modified work as a whole.  If
+identifiable sections of that work are not derived from the Program,
+and can be reasonably considered independent and separate works in
+themselves, then this License, and its terms, do not apply to those
+sections when you distribute them as separate works.  But when you
+distribute the same sections as part of a whole which is a work based
+on the Program, the distribution of the whole must be on the terms of
+this License, whose permissions for other licensees extend to the
+entire whole, and thus to each and every part regardless of who wrote it.
+
+Thus, it is not the intent of this section to claim rights or contest
+your rights to work written entirely by you; rather, the intent is to
+exercise the right to control the distribution of derivative or
+collective works based on the Program.
+
+In addition, mere aggregation of another work not based on the Program
+with the Program (or with a work based on the Program) on a volume of
+a storage or distribution medium does not bring the other work under
+the scope of this License.
+
+  3. You may copy and distribute the Program (or a work based on it,
+under Section 2) in object code or executable form under the terms of
+Sections 1 and 2 above provided that you also do one of the following:
+
+    a) Accompany it with the complete corresponding machine-readable
+    source code, which must be distributed under the terms of Sections
+    1 and 2 above on a medium customarily used for software interchange; or,
+
+    b) Accompany it with a written offer, valid for at least three
+    years, to give any third party, for a charge no more than your
+    cost of physically performing source distribution, a complete
+    machine-readable copy of the corresponding source code, to be
+    distributed under the terms of Sections 1 and 2 above on a medium
+    customarily used for software interchange; or,
+
+    c) Accompany it with the information you received as to the offer
+    to distribute corresponding source code.  (This alternative is
+    allowed only for noncommercial distribution and only if you
+    received the program in object code or executable form with such
+    an offer, in accord with Subsection b above.)
+
+The source code for a work means the preferred form of the work for
+making modifications to it.  For an executable work, complete source
+code means all the source code for all modules it contains, plus any
+associated interface definition files, plus the scripts used to
+control compilation and installation of the executable.  However, as a
+special exception, the source code distributed need not include
+anything that is normally distributed (in either source or binary
+form) with the major components (compiler, kernel, and so on) of the
+operating system on which the executable runs, unless that component
+itself accompanies the executable.
+
+If distribution of executable or object code is made by offering
+access to copy from a designated place, then offering equivalent
+access to copy the source code from the same place counts as
+distribution of the source code, even though third parties are not
+compelled to copy the source along with the object code.
+
+  4. You may not copy, modify, sublicense, or distribute the Program
+except as expressly provided under this License.  Any attempt
+otherwise to copy, modify, sublicense or distribute the Program is
+void, and will automatically terminate your rights under this License.
+However, parties who have received copies, or rights, from you under
+this License will not have their licenses terminated so long as such
+parties remain in full compliance.
+
+  5. You are not required to accept this License, since you have not
+signed it.  However, nothing else grants you permission to modify or
+distribute the Program or its derivative works.  These actions are
+prohibited by law if you do not accept this License.  Therefore, by
+modifying or distributing the Program (or any work based on the
+Program), you indicate your acceptance of this License to do so, and
+all its terms and conditions for copying, distributing or modifying
+the Program or works based on it.
+
+  6. Each time you redistribute the Program (or any work based on the
+Program), the recipient automatically receives a license from the
+original licensor to copy, distribute or modify the Program subject to
+these terms and conditions.  You may not impose any further
+restrictions on the recipients' exercise of the rights granted herein.
+You are not responsible for enforcing compliance by third parties to
+this License.
+
+  7. If, as a consequence of a court judgment or allegation of patent
+infringement or for any other reason (not limited to patent issues),
+conditions are imposed on you (whether by court order, agreement or
+otherwise) that contradict the conditions of this License, they do not
+excuse you from the conditions of this License.  If you cannot
+distribute so as to satisfy simultaneously your obligations under this
+License and any other pertinent obligations, then as a consequence you
+may not distribute the Program at all.  For example, if a patent
+license would not permit royalty-free redistribution of the Program by
+all those who receive copies directly or indirectly through you, then
+the only way you could satisfy both it and this License would be to
+refrain entirely from distribution of the Program.
+
+If any portion of this section is held invalid or unenforceable under
+any particular circumstance, the balance of the section is intended to
+apply and the section as a whole is intended to apply in other
+circumstances.
+
+It is not the purpose of this section to induce you to infringe any
+patents or other property right claims or to contest validity of any
+such claims; this section has the sole purpose of protecting the
+integrity of the free software distribution system, which is
+implemented by public license practices.  Many people have made
+generous contributions to the wide range of software distributed
+through that system in reliance on consistent application of that
+system; it is up to the author/donor to decide if he or she is willing
+to distribute software through any other system and a licensee cannot
+impose that choice.
+
+This section is intended to make thoroughly clear what is believed to
+be a consequence of the rest of this License.
+
+  8. If the distribution and/or use of the Program is restricted in
+certain countries either by patents or by copyrighted interfaces, the
+original copyright holder who places the Program under this License
+may add an explicit geographical distribution limitation excluding
+those countries, so that distribution is permitted only in or among
+countries not thus excluded.  In such case, this License incorporates
+the limitation as if written in the body of this License.
+
+  9. The Free Software Foundation may publish revised and/or new versions
+of the General Public License from time to time.  Such new versions will
+be similar in spirit to the present version, but may differ in detail to
+address new problems or concerns.
+
+Each version is given a distinguishing version number.  If the Program
+specifies a version number of this License which applies to it and "any
+later version", you have the option of following the terms and conditions
+either of that version or of any later version published by the Free
+Software Foundation.  If the Program does not specify a version number of
+this License, you may choose any version ever published by the Free Software
+Foundation.
+
+  10. If you wish to incorporate parts of the Program into other free
+programs whose distribution conditions are different, write to the author
+to ask for permission.  For software which is copyrighted by the Free
+Software Foundation, write to the Free Software Foundation; we sometimes
+make exceptions for this.  Our decision will be guided by the two goals
+of preserving the free status of all derivatives of our free software and
+of promoting the sharing and reuse of software generally.
+
+			    NO WARRANTY
+
+  11. BECAUSE THE PROGRAM IS LICENSED FREE OF CHARGE, THERE IS NO WARRANTY
+FOR THE PROGRAM, TO THE EXTENT PERMITTED BY APPLICABLE LAW.  EXCEPT WHEN
+OTHERWISE STATED IN WRITING THE COPYRIGHT HOLDERS AND/OR OTHER PARTIES
+PROVIDE THE PROGRAM "AS IS" WITHOUT WARRANTY OF ANY KIND, EITHER EXPRESSED
+OR IMPLIED, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF
+MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE.  THE ENTIRE RISK AS
+TO THE QUALITY AND PERFORMANCE OF THE PROGRAM IS WITH YOU.  SHOULD THE
+PROGRAM PROVE DEFECTIVE, YOU ASSUME THE COST OF ALL NECESSARY SERVICING,
+REPAIR OR CORRECTION.
+
+  12. IN NO EVENT UNLESS REQUIRED BY APPLICABLE LAW OR AGREED TO IN WRITING
+WILL ANY COPYRIGHT HOLDER, OR ANY OTHER PARTY WHO MAY MODIFY AND/OR
+REDISTRIBUTE THE PROGRAM AS PERMITTED ABOVE, BE LIABLE TO YOU FOR DAMAGES,
+INCLUDING ANY GENERAL, SPECIAL, INCIDENTAL OR CONSEQUENTIAL DAMAGES ARISING
+OUT OF THE USE OR INABILITY TO USE THE PROGRAM (INCLUDING BUT NOT LIMITED
+TO LOSS OF DATA OR DATA BEING RENDERED INACCURATE OR LOSSES SUSTAINED BY
+YOU OR THIRD PARTIES OR A FAILURE OF THE PROGRAM TO OPERATE WITH ANY OTHER
+PROGRAMS), EVEN IF SUCH HOLDER OR OTHER PARTY HAS BEEN ADVISED OF THE
+POSSIBILITY OF SUCH DAMAGES.
+
+		     END OF TERMS AND CONDITIONS
+
+	    How to Apply These Terms to Your New Programs
+
+  If you develop a new program, and you want it to be of the greatest
+possible use to the public, the best way to achieve this is to make it
+free software which everyone can redistribute and change under these terms.
+
+  To do so, attach the following notices to the program.  It is safest
+to attach them to the start of each source file to most effectively
+convey the exclusion of warranty; and each file should have at least
+the "copyright" line and a pointer to where the full notice is found.
+
+    <one line to give the program's name and a brief idea of what it does.>
+    Copyright (C) <year>  <name of author>
+
+    This program is free software; you can redistribute it and/or modify
+    it under the terms of the GNU General Public License as published by
+    the Free Software Foundation; either version 2 of the License, or
+    (at your option) any later version.
+
+    This program is distributed in the hope that it will be useful,
+    but WITHOUT ANY WARRANTY; without even the implied warranty of
+    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+    GNU General Public License for more details.
+
+    You should have received a copy of the GNU General Public License
+    along with this program; if not, write to the Free Software
+    Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+
+
+Also add information on how to contact you by electronic and paper mail.
+
+If the program is interactive, make it output a short notice like this
+when it starts in an interactive mode:
+
+    Gnomovision version 69, Copyright (C) year name of author
+    Gnomovision comes with ABSOLUTELY NO WARRANTY; for details type `show w'.
+    This is free software, and you are welcome to redistribute it
+    under certain conditions; type `show c' for details.
+
+The hypothetical commands `show w' and `show c' should show the appropriate
+parts of the General Public License.  Of course, the commands you use may
+be called something other than `show w' and `show c'; they could even be
+mouse-clicks or menu items--whatever suits your program.
+
+You should also get your employer (if you work as a programmer) or your
+school, if any, to sign a "copyright disclaimer" for the program, if
+necessary.  Here is a sample; alter the names:
+
+  Yoyodyne, Inc., hereby disclaims all copyright interest in the program
+  `Gnomovision' (which makes passes at compilers) written by James Hacker.
+
+  <signature of Ty Coon>, 1 April 1989
+  Ty Coon, President of Vice
+
+This General Public License does not permit incorporating your program into
+proprietary programs.  If your program is a subroutine library, you may
+consider it more useful to permit linking proprietary applications with the
+library.  If this is what you want to do, use the GNU Library General
+Public License instead of this License.
--- /dev/null
+++ 2f556bba4a059b3aaefb0bbacac64d60a14e127a/debian/dirs
@@ -0,0 +1,2 @@
+usr/bin
+usr/sbin
--- /dev/null
+++ 2f556bba4a059b3aaefb0bbacac64d60a14e127a/debian/docs
@@ -0,0 +1,3 @@
+README
+README.reference
+COPYING
--- /dev/null
+++ 2f556bba4a059b3aaefb0bbacac64d60a14e127a/debian/rules
@@ -0,0 +1,66 @@
+#!/usr/bin/make -f
+
+#export DH_VERBOSE=1
+
+CFLAGS = -Wall -g
+
+ifneq (,$(findstring noopt,$(DEB_BUILD_OPTIONS)))
+	CFLAGS += -O0
+else
+	CFLAGS += -O2
+endif
+
+configure:
+
+build: build-stamp
+
+build-stamp:
+	dh_testdir
+
+	patch -p1 < $(CURDIR)/debian/scriptdir.diff
+	$(MAKE)
+
+	touch build-stamp
+
+clean:
+	dh_testdir
+	dh_testroot
+	rm -f build-stamp
+
+	-$(MAKE) clean
+	patch -Rp1 < $(CURDIR)/debian/scriptdir.diff
+
+	dh_clean 
+
+install: build
+	dh_testdir
+	dh_testroot
+	dh_clean -k 
+	dh_installdirs
+
+	$(MAKE) install DESTDIR=$(CURDIR)/debian/git-pasky prefix='/usr'
+	install -m755 -d $(CURDIR)/debian/git-pasky/usr/share/doc/git-pasky/contrib
+	install $(CURDIR)/contrib/* $(CURDIR)/debian/git-pasky/usr/share/doc/git-pasky/contrib
+
+binary-arch: build install
+	dh_testdir
+	dh_testroot
+	dh_installchangelogs 
+	dh_installdocs
+	dh_installexamples
+#	dh_install
+#	dh_installmenu
+#	dh_installinfo
+	dh_installman
+	dh_link
+	dh_strip
+	dh_compress
+	dh_fixperms
+	dh_installdeb
+	dh_shlibdeps
+	dh_gencontrol
+	dh_md5sums
+	dh_builddeb
+
+binary: binary-arch
+.PHONY: build clean binary-arch binary install
--- /dev/null
+++ 2f556bba4a059b3aaefb0bbacac64d60a14e127a/debian/scriptdir.diff
@@ -0,0 +1,82 @@
+diff -u a/Makefile b/Makefile
+--- a/Makefile	2005-04-22 00:59:22.000000000 -0400
++++ b/Makefile	2005-04-22 00:59:43.000000000 -0400
+@@ -18,6 +18,7 @@
+ prefix=$(HOME)
+ 
+ bindir=$(prefix)/bin
++scriptdir=$(prefix)/share/git-pasky/scripts
+ 
+ CC=gcc
+ AR=ar
+@@ -28,11 +29,11 @@
+ 	check-files ls-tree merge-base merge-cache unpack-file git-export \
+ 	diff-cache convert-cache
+ 
+-SCRIPT=	parent-id tree-id git gitXnormid.sh gitadd.sh gitaddremote.sh \
+-	gitcommit.sh gitdiff-do gitdiff.sh gitlog.sh gitls.sh gitlsobj.sh \
+-	gitmerge.sh gitpull.sh gitrm.sh gittag.sh gittrack.sh gitexport.sh \
+-	gitapply.sh gitcancel.sh gitXlntree.sh commit-id gitlsremote.sh \
+-	gitfork.sh gitinit.sh gitseek.sh gitstatus.sh gitpatch.sh \
++BINSCRIPTS= parent-id tree-id git gitdiff-do commit-id
++SCRIPT=	gitXnormid.sh gitadd.sh gitaddremote.sh gitcommit.sh gitdiff.sh \
++  gitlog.sh gitls.sh gitlsobj.sh gitmerge.sh gitpull.sh gitrm.sh gittag.sh \
++	gittrack.sh gitexport.sh gitapply.sh gitcancel.sh gitXlntree.sh \
++	gitlsremote.sh gitfork.sh gitinit.sh gitseek.sh gitstatus.sh gitpatch.sh \
+ 	gitmerge-file.sh
+ 
+ COMMON=	read-cache.o
+@@ -80,7 +81,9 @@
+ 
+ install: $(PROG) $(GEN_SCRIPT)
+ 	install -m755 -d $(DESTDIR)$(bindir)
+-	install $(PROG) $(SCRIPT) $(GEN_SCRIPT) $(DESTDIR)$(bindir)
++	install -m755 -d $(DESTDIR)$(scriptdir)
++	install $(PROG) $(BINSCRIPTS) $(DESTDIR)$(bindir)
++	install $(SCRIPT) $(GEN_SCRIPT) $(DESTDIR)$(scriptdir)
+ 
+ clean:
+ 	rm -f *.o mozilla-sha1/*.o $(PROG) $(GEN_SCRIPT) $(LIB_FILE)
+diff -u a/commit-id b/commit-id
+--- a/commit-id	2005-04-22 00:59:22.000000000 -0400
++++ b/commit-id	2005-04-22 01:02:40.000000000 -0400
+@@ -5,4 +5,4 @@
+ #
+ # Takes the appropriate ID, defaults to HEAD.
+ 
+-gitXnormid.sh -c $1
++/usr/share/git-pasky/scripts/gitXnormid.sh -c $1
+Common subdirectories: a/contrib and b/contrib
+Only in b: debian
+diff -u a/git b/git
+--- a/git	2005-04-22 00:59:22.000000000 -0400
++++ b/git	2005-04-22 01:01:43.000000000 -0400
+@@ -17,6 +17,7 @@
+ 	exit 1
+ }
+ 
++export PATH=/usr/share/git-pasky/scripts:$PATH
+ 
+ help () {
+ 	cat <<__END__
+Common subdirectories: a/mozilla-sha1 and b/mozilla-sha1
+diff -u a/parent-id b/parent-id
+--- a/parent-id	2005-04-22 00:59:22.000000000 -0400
++++ b/parent-id	2005-04-22 01:02:01.000000000 -0400
+@@ -7,6 +7,6 @@
+ 
+ PARENT="^parent [A-Za-z0-9]{40}$"
+ 
+-id=$(gitXnormid.sh -c $1) || exit 1
++id=$(/usr/share/git-pasky/scripts/gitXnormid.sh -c $1) || exit 1
+ 
+ cat-file commit $id | egrep "$PARENT" | cut -d ' ' -f 2
+diff -u a/tree-id b/tree-id
+--- a/tree-id	2005-04-22 00:59:22.000000000 -0400
++++ b/tree-id	2005-04-22 01:00:40.000000000 -0400
+@@ -5,4 +5,4 @@
+ #
+ # Takes ID of the appropriate commit, defaults to HEAD.
+ 
+-gitXnormid.sh $1
++/usr/share/git-pasky/scripts/gitXnormid.sh $1

--Boundary-00=_OmPaC2BWp81bIoZ--
