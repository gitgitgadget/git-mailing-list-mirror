From: martin f krafft <madduck-8fiUuRrzOP0dnm+yROfE0A@public.gmane.org>
Subject: Fwd: [RFC][StGit PATCH] Add support for merge-friendly branches
Date: Thu, 28 May 2009 14:12:22 +0200
Organization: The Debian project
Message-ID: <20090528121222.GA28495@piper.oerlikon.madduck.net>
References: <20090528111212.21925.45527.stgit@pc1117.cambridge.arm.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1419091108263137260=="
Cc: Catalin Marinas <catalin.marinas-5wv7dgnIgG8@public.gmane.org>,
	Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha-bX70CJONkLNBDgjK7y7TUQ@public.gmane.org>, git-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: vcs distro packaging discussion list
	<vcs-pkg-discuss-XbBxUvOt3X2LieD7tvxI8l/i77bcL1HB@public.gmane.org>
X-From: vcs-pkg-discuss-bounces+gcvp-vcs-pkg=m.gmane.org-XbBxUvOt3X2LieD7tvxI8l/i77bcL1HB@public.gmane.org Thu May 28 14:12:50 2009
Return-path: <vcs-pkg-discuss-bounces+gcvp-vcs-pkg=m.gmane.org-XbBxUvOt3X2LieD7tvxI8l/i77bcL1HB@public.gmane.org>
Envelope-to: gcvp-vcs-pkg@m.gmane.org
Received: from alioth.debian.org ([217.196.43.134])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M9eTZ-0004Bj-IW
	for gcvp-vcs-pkg@m.gmane.org; Thu, 28 May 2009 14:12:49 +0200
Received: from localhost ([127.0.0.1] helo=alioth.debian.org)
	by alioth.debian.org with esmtp (Exim 4.69)
	(envelope-from <vcs-pkg-discuss-bounces+gcvp-vcs-pkg=m.gmane.org-XbBxUvOt3X2LieD7tvxI8l/i77bcL1HB@public.gmane.org>)
	id 1M9eTZ-0004a3-CT
	for gcvp-vcs-pkg@m.gmane.org; Thu, 28 May 2009 12:12:49 +0000
Received: from clegg.madduck.net ([193.242.105.96])
	by alioth.debian.org with esmtp (Exim 4.69)
	(envelope-from <madduck-UL6Ldu8NfJ2CXxyDhj93/2TWArNKQ494rE5yTffgRl4@public.gmane.org>)
	id 1M9eTP-0004Yb-Rn for vcs-pkg-discuss-XbBxUvOt3X2LieD7tvxI8l/i77bcL1HB@public.gmane.org;
	Thu, 28 May 2009 12:12:46 +0000
Received: from piper.oerlikon.madduck.net (piper.oerlikon.madduck.net
	[IPv6:2001:41e0:ff12:0:211:2fff:fe6b:c869])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "piper.oerlikon.madduck.net",
	Issuer "CAcert Class 3 Root" (verified OK))
	by clegg.madduck.net (postfix) with ESMTPS id EB1DB1D40A1;
	Thu, 28 May 2009 14:12:22 +0200 (CEST)
Received: by piper.oerlikon.madduck.net (Postfix, from userid 1000)
	id 1FD1144D9; Thu, 28 May 2009 14:12:22 +0200 (CEST)
Mail-Followup-To: vcs distro packaging discussion list
	<vcs-pkg-discuss-XbBxUvOt3X2LieD7tvxI8l/i77bcL1HB@public.gmane.org>, 
	git-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Catalin Marinas <catalin.marinas-5wv7dgnIgG8@public.gmane.org>,
	Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha-bX70CJONkLNBDgjK7y7TUQ@public.gmane.org>
In-Reply-To: <20090528111212.21925.45527.stgit-hhZApKj8DF/YkXV2EHHjLW3o5bpOHsLO@public.gmane.org>
X-Motto: Keep the good times rollin'
X-OS: Debian GNU/Linux squeeze/sid kernel 2.6.30-rc5-amd64 x86_64
X-Spamtrap: madduck.bogus-JX/+c5DPh7vR7s880joybQ@public.gmane.org
X-Subliminal-Message: debian/rules!
User-Agent: Mutt/1.5.19 (2009-01-05)
X-Virus-Scanned: clamav-milter 0.95.1 at clegg
X-Virus-Status: Clean
X-policyd-weight: using cached result; rate: -7.6
X-Spam-Checker-Version: SpamAssassin 3.2.5 (2008-06-10) on alioth.debian.org
X-Spam-Level: 
X-Spam-Status: No, score=0.0 required=5.0 tests=none autolearn=failed
	version=3.2.5
X-BeenThere: vcs-pkg-discuss-XbBxUvOt3X2LieD7tvxI8l/i77bcL1HB@public.gmane.org
X-Mailman-Version: 2.1.11
Precedence: list
List-Id: Discussions on using VCS for distro packaging
	<vcs-pkg-discuss.lists.alioth.debian.org>
List-Unsubscribe: <http://lists.alioth.debian.org/mailman/options/vcs-pkg-discuss>,
	<mailto:vcs-pkg-discuss-request-XbBxUvOt3X2LieD7tvxI8l/i77bcL1HB@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.alioth.debian.org/pipermail/vcs-pkg-discuss>
List-Post: <mailto:vcs-pkg-discuss-XbBxUvOt3X2LieD7tvxI8l/i77bcL1HB@public.gmane.org>
List-Help: <mailto:vcs-pkg-discuss-request-XbBxUvOt3X2LieD7tvxI8l/i77bcL1HB@public.gmane.org?subject=help>
List-Subscribe: <http://lists.alioth.debian.org/mailman/listinfo/vcs-pkg-discuss>,
	<mailto:vcs-pkg-discuss-request-XbBxUvOt3X2LieD7tvxI8l/i77bcL1HB@public.gmane.org?subject=subscribe>
Mime-version: 1.0
Sender: vcs-pkg-discuss-bounces+gcvp-vcs-pkg=m.gmane.org-XbBxUvOt3X2LieD7tvxI8l/i77bcL1HB@public.gmane.org
Errors-To: vcs-pkg-discuss-bounces+gcvp-vcs-pkg=m.gmane.org-XbBxUvOt3X2LieD7tvxI8l/i77bcL1HB@public.gmane.org
X-SA-Exim-Connect-IP: 127.0.0.1
X-SA-Exim-Mail-From: vcs-pkg-discuss-bounces+gcvp-vcs-pkg=m.gmane.org-XbBxUvOt3X2LieD7tvxI8l/i77bcL1HB@public.gmane.org
X-SA-Exim-Scanned: No (on alioth.debian.org); SAEximRunCond expanded to false
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120186>


--===============1419091108263137260==
Content-Type: multipart/signed; micalg=pgp-ripemd160;
	protocol="application/pgp-signature"; boundary="envbJBWh7q8WU6mo"
Content-Disposition: inline


--envbJBWh7q8WU6mo
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

[Forwarded to vcs-pkg-discuss]

Hey vcs-pkg people,

This may be of interest, I don't have any time right now to check
this out and don't remember StGit too well either.

I suggest that comments be fed back to the git mailing list, which
has a Cc policy, so just reply to all.

I have put the list and Catalin and Karl on Cc so that they know
that http://vcs-pkg.org has sighted this stuff. ;)

----- Forwarded message from Catalin Marinas <catalin.marinas-5wv7dgnIgG8@public.gmane.org> -----

Date: Thu, 28 May 2009 12:12:42 +0100
=46rom: Catalin Marinas <catalin.marinas-5wv7dgnIgG8@public.gmane.org>
To: git-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Karl Hasselstr=F6m <kha-bX70CJONkLNBDgjK7y7TUQ@public.gmane.org>
Subject: [RFC][StGit PATCH] Add support for merge-friendly branches
Message-ID: <20090528111212.21925.45527.stgit-hhZApKj8DF/YkXV2EHHjLW3o5bpOHsLO@public.gmane.org>

The main issue with publishing StGit branches is that the Git history
represented by patches is volatile, making it difficult for people
wanting to merge such branch. One solution is for all the downstream
developers to always rebase but that's not always desirable. Another
solution is provided by tools like TopGit but the visible Git history
becomes complicated, especially with repeated reordering.

The patch proposes a new StGit command called "publish". This command
allows one to develop patches normally on a StGit branch but publish the
stack changes to a separate, merge-friendly branch whose history is not
re-writable.

More about its behaviour can be found in the command description in this
patch.

Signed-off-by: Catalin Marinas <catalin.marinas-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
---
 stgit/commands/common.py  |   26 ++++++++
 stgit/commands/new.py     |   22 -------
 stgit/commands/publish.py |  139 +++++++++++++++++++++++++++++++++++++++++=
++++
 stgit/lib/git.py          |    5 ++
 t/t4100-publish.sh        |  129 ++++++++++++++++++++++++++++++++++++++++++
 5 files changed, 300 insertions(+), 21 deletions(-)
 create mode 100644 stgit/commands/publish.py
 create mode 100755 t/t4100-publish.sh

diff --git a/stgit/commands/common.py b/stgit/commands/common.py
index e46412e..04314f3 100644
--- a/stgit/commands/common.py
+++ b/stgit/commands/common.py
@@ -447,6 +447,32 @@ def readonly_constant_property(f):
         return getattr(self, n)
     return property(new_f)
=20
+def update_commit_data(cd, options, allow_edit =3D False):
+    """Return a new CommitData object updated according to the command line
+    options."""
+    # Set the commit message from commandline.
+    if options.message !=3D None:
+        cd =3D cd.set_message(options.message)
+
+    # Modify author data.
+    cd =3D cd.set_author(options.author(cd.author))
+
+    # Add Signed-off-by: or similar.
+    if options.sign_str !=3D None:
+        sign_str =3D options.sign_str
+    else:
+        sign_str =3D config.get("stgit.autosign")
+    if sign_str !=3D None:
+        cd =3D cd.set_message(
+            add_sign_line(cd.message, sign_str,
+                          cd.committer.name, cd.committer.email))
+
+    # Let user edit the commit message manually.
+    if allow_edit and not options.message:
+        cd =3D cd.set_message(edit_string(cd.message, '.stgit-new.txt'))
+
+    return cd
+
 class DirectoryException(StgException):
     pass
=20
diff --git a/stgit/commands/new.py b/stgit/commands/new.py
index 2c98431..9fd51c3 100644
--- a/stgit/commands/new.py
+++ b/stgit/commands/new.py
@@ -67,32 +67,12 @@ def func(parser, options, args):
     cd =3D gitlib.CommitData(
         tree =3D stack.head.data.tree, parents =3D [stack.head], message =
=3D '',
         author =3D gitlib.Person.author(), committer =3D gitlib.Person.com=
mitter())
-
-    # Set patch commit message from commandline.
-    if options.message !=3D None:
-        cd =3D cd.set_message(options.message)
-
-    # Modify author data.
-    cd =3D cd.set_author(options.author(cd.author))
-
-    # Add Signed-off-by: or similar.
-    if options.sign_str !=3D None:
-        sign_str =3D options.sign_str
-    else:
-        sign_str =3D config.get("stgit.autosign")
-
-    if sign_str !=3D None:
-        cd =3D cd.set_message(
-            utils.add_sign_line(cd.message, sign_str,
-                                cd.committer.name, cd.committer.email))
+    cd =3D common.update_commit_data(cd, options, allow_edit =3D True)
=20
     if options.save_template:
         options.save_template(cd.message)
         return utils.STGIT_SUCCESS
=20
-    # Let user edit the commit message manually.
-    if not options.message:
-        cd =3D cd.set_message(utils.edit_string(cd.message, '.stgit-new.tx=
t'))
     if name =3D=3D None:
         name =3D utils.make_patch_name(cd.message,
                                      lambda name: stack.patches.exists(nam=
e))
diff --git a/stgit/commands/publish.py b/stgit/commands/publish.py
new file mode 100644
index 0000000..06c32d0
--- /dev/null
+++ b/stgit/commands/publish.py
@@ -0,0 +1,139 @@
+__copyright__ =3D """
+Copyright (C) 2009, Catalin Marinas <catalin.marinas-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
+
+This program is free software; you can redistribute it and/or modify
+it under the terms of the GNU General Public License version 2 as
+published by the Free Software Foundation.
+
+This program is distributed in the hope that it will be useful,
+but WITHOUT ANY WARRANTY; without even the implied warranty of
+MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+GNU General Public License for more details.
+
+You should have received a copy of the GNU General Public License
+along with this program; if not, write to the Free Software
+Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA
+"""
+
+from stgit import argparse
+from stgit.argparse import opt
+from stgit.commands import common
+from stgit.config import config
+from stgit.lib import git, stack
+from stgit.out import out
+
+help =3D 'Publish the stack changes to a merge-friendly head'
+kind =3D 'stack'
+usage =3D ['[options] [branch]']
+description =3D """
+This command commits a set of changes on a separate (called public) branch
+based on the modifications of the given or current stack. The history of t=
he
+public branch is not re-written, making it merge-friendly and feasible for
+publishing. The heads of the stack and public branch may be different but =
the
+corresponding tree objects are always the same.
+
+If the trees of the stack and public branch are different (otherwise the
+command has no effect), StGit first checks for a rebase of the stack since=
 the
+last publishing. If a rebase is detected, StGit creates a commit on the pu=
blic
+branch corresponding to a merge between the new stack base and the latest
+public head.
+
+If no rebasing was detected, StGit checks for new patches that may have be=
en
+created on top of the stack since the last publishing. If new patches are
+found and are not empty, they are checked into the public branch keeping t=
he
+same commit information (e.g. log message, author, committer, date).
+
+If the above tests fail (e.g. patches modified or removed), StGit creates a
+new commit on the public branch having the same tree as the stack but the
+public head as its parent. The editor will be invoked if no "--message" op=
tion
+is given.
+
+It is recommended that stack modifications falling in different categories=
 as
+described above are separated by a publish command in order to keep the pu=
blic
+branch history cleaner (otherwise StGit would generate a big commit includ=
ing
+several stack modifications).
+
+The public branch name can be set via the branch.<branch>.public configura=
tion
+variable (defaulting to "<branch>.public").
+"""
+
+args =3D [argparse.all_branches]
+options =3D [
+    opt('-b', '--branch', args =3D [argparse.stg_branches],
+        short =3D 'Use BRANCH instead of the default branch')
+] + (argparse.author_options()
+     + argparse.message_options(save_template =3D False)
+     + argparse.sign_options())
+
+directory =3D common.DirectoryHasRepositoryLib()
+
+def __create_commit(repository, tree, parents, options):
+    """Return a new Commit object."""
+    cd =3D git.CommitData(
+        tree =3D tree, parents =3D parents, message =3D '',
+        author =3D git.Person.author(), committer =3D git.Person.committer=
())
+    cd =3D common.update_commit_data(cd, options, allow_edit =3D True)
+
+    return repository.commit(cd)
+
+def func(parser, options, args):
+    """Publish the stack changes."""
+    repository =3D directory.repository
+    stack =3D repository.get_stack(options.branch)
+
+    if not args:
+        public_ref =3D config.get('branch.%s.public' % stack.name)
+        if not public_ref:
+            public_ref =3D 'refs/heads/%s.public' % stack.name
+    elif len(args) =3D=3D 1:
+        public_ref =3D args[0]
+    else:
+        parser.error('incorrect number of arguments')
+
+    # just clone the stack if the public ref does not exist
+    if not repository.refs.exists(public_ref):
+        repository.refs.set(public_ref, stack.head, 'publish')
+        out.info('Created "%s"' % public_ref)
+        return
+
+    public_head =3D repository.refs.get(public_ref)
+    public_tree =3D public_head.data.tree
+
+    # check for same tree (already up to date)
+    if public_tree.sha1 =3D=3D stack.head.data.tree.sha1:
+        out.info('"%s" already up to date' % public_ref)
+        return
+
+    # check for rebased stack. In this case we emulate a merge with the st=
ack
+    # base by setting two parents.
+    merge_base =3D repository.get_merge_base(public_head, stack.base)
+    if merge_base.sha1 !=3D stack.base.sha1:
+        public_head =3D __create_commit(repository, stack.head.data.tree,
+                                      [public_head, stack.base], options)
+        repository.refs.set(public_ref, public_head, 'publish')
+        out.info('Merged the stack base into "%s"' % public_ref)
+        return
+
+    # check for new patches from the last publishing. This is done by chec=
king
+    # whether the public tree is the same as the bottom of the checked pat=
ch.
+    # If older patches were modified, new patches cannot be detected. The =
new
+    # patches and their metadata are pushed directly to the published head.
+    for p in stack.patchorder.applied:
+        pc =3D stack.patches.get(p).commit
+        if public_tree.sha1 =3D=3D pc.data.parent.data.tree.sha1:
+            if pc.data.is_nochange():
+                out.info('Ignored new empty patch "%s"' % p)
+                continue
+            cd =3D pc.data.set_parent(public_head)
+            public_head =3D repository.commit(cd)
+            public_tree =3D public_head.data.tree
+            out.start('Published new patch "%s"' % p)
+
+    # create a new commit (only happens if no new patches are detected)
+    if public_tree.sha1 !=3D stack.head.data.tree.sha1:
+        public_head =3D __create_commit(repository, stack.head.data.tree,
+                                      [public_head], options)
+
+    # update the public head
+    repository.refs.set(public_ref, public_head, 'publish')
+    out.info('Updated "%s"' % public_ref)
diff --git a/stgit/lib/git.py b/stgit/lib/git.py
index 6f2c977..4a17c8a 100644
--- a/stgit/lib/git.py
+++ b/stgit/lib/git.py
@@ -609,6 +609,11 @@ class Repository(RunWithEnv):
             raise DetachedHeadException()
     def set_head_ref(self, ref, msg):
         self.run(['git', 'symbolic-ref', '-m', msg, 'HEAD', ref]).no_outpu=
t()
+    def get_merge_base(self, commit1, commit2):
+        """Return the merge base of two commits."""
+        sha1 =3D self.run(['git', 'merge-base',
+                         commit1.sha1, commit2.sha1]).output_one_line()
+        return self.get_commit(sha1)
     def simple_merge(self, base, ours, theirs):
         index =3D self.temp_index()
         try:
diff --git a/t/t4100-publish.sh b/t/t4100-publish.sh
new file mode 100755
index 0000000..17e07bc
--- /dev/null
+++ b/t/t4100-publish.sh
@@ -0,0 +1,129 @@
+#!/bin/sh
+#
+# Copyright (c) 2009 Catalin Marinas
+#
+
+test_description=3D'Exercise the publish command.
+
+Create/modify patches on the stack and publish them to a separate branch.'
+
+. ./test-lib.sh
+
+test_same_tree () {
+	stack_tree=3D$(git rev-parse master^{tree})
+	public_tree=3D$(git rev-parse master.public^{tree})
+	test "$stack_tree" =3D "$public_tree"
+}
+
+test_expect_success \
+	'Initialize the StGit repository' \
+	'
+	stg init
+	'
+
+test_expect_success \
+	'Create some patches' \
+	'
+	stg new p1 -m p1 &&
+	echo foo1 > foo1.txt &&
+	git add foo1.txt &&
+	stg refresh &&
+	stg new p2 -m p2 &&
+	echo foo2 > foo2.txt &&
+	git add foo2.txt &&
+	stg refresh &&
+	stg new p3 -m p3 &&
+	echo foo3 > foo3.txt &&
+	git add foo3.txt &&
+	stg refresh
+	'
+
+test_expect_success \
+	'Publish the stack for the first time' \
+	'
+	stg publish &&
+	test "$(stg id)" =3D "$(stg id master.public)"
+	'
+
+test_expect_success \
+	'Modify a patch and publish the changes' \
+	'
+	stg pop &&
+	echo foo2 >> foo2.txt &&
+	stg refresh &&
+	stg push &&
+	old_public=3D$(stg id master.public) &&
+	stg publish -m "p2 updated" &&
+	test_same_tree &&
+	new_public=3D$(stg id master.public) &&
+	test "$(git rev-list $old_public..$new_public | wc -l)" =3D "1"
+	'
+
+test_expect_success \
+	'Create new patches and publish them' \
+	'
+	stg new p4 -m p4 &&
+	echo foo4 > foo4.txt &&
+	git add foo4.txt &&
+	stg refresh &&
+	stg new p5 -m p5 &&
+	echo foo5 > foo5.txt &&
+	git add foo5.txt &&
+	stg refresh &&
+	stg new empty -m empty &&
+	old_public=3D$(stg id master.public) &&
+	stg publish -m "Ignored message" &&
+	test_same_tree &&
+	new_public=3D$(stg id master.public) &&
+	test "$(git rev-list $old_public..$new_public | wc -l)" =3D "2"
+	'
+
+test_expect_success \
+	'Rebase the current stack and publish a merge' \
+	'
+	stg pop -a &&
+	echo foo0 > foo0.txt &&
+	git add foo0.txt &&
+	git commit -m "foo0.txt added" &&
+	stg push -a &&
+	old_public=3D$(stg id master.public) &&
+	stg publish -m "Merge with base" &&
+	test_same_tree &&
+	new_public=3D$(stg id master.public) &&
+	test "$(git rev-list $old_public..$new_public | wc -l)" =3D "2" &&
+	test "$(git merge-base master.public master)" =3D "$(stg id {base})"
+	'
+
+test_expect_success \
+	'Re-publish without any changes' \
+	'
+	old_public=3D$(stg id master.public) &&
+	stg publish -m "Ignored message" &&
+	test_same_tree &&
+	new_public=3D$(stg id master.public) &&
+	test "$old_public" =3D "$new_public"
+	'
+
+test_expect_success \
+	'Reorder patches and publish the changes' \
+	'
+	stg float p5 p4 p3 p2 p1 &&
+	old_public=3D$(stg id master.public) &&
+	stg publish -m "Ignored message" &&
+	test_same_tree &&
+	new_public=3D$(stg id master.public) &&
+	test "$old_public" =3D "$new_public"
+	'
+
+test_expect_success \
+	'Pop a patch and publish the changes' \
+	'
+	stg pop p3 &&
+	old_public=3D$(stg id master.public) &&
+	stg publish -m "p3 removed" &&
+	test_same_tree &&
+	new_public=3D$(stg id master.public) &&
+	test "$(git rev-list $old_public..$new_public | wc -l)" =3D "1"
+	'
+
+test_done

--=20
 .''`.   martin f. krafft <madduck@d.o>      Related projects:
: :'  :  proud Debian developer               http://debiansystem.info
`. `'`   http://people.debian.org/~madduck    http://vcs-pkg.org
  `-  Debian - when you have better things to do than fixing systems
=20
a farmer is a man outstanding in his field.

--envbJBWh7q8WU6mo
Content-Type: application/pgp-signature; name="digital_signature_gpg.asc"
Content-Description: Digital signature (see http://martin-krafft.net/gpg/)
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEAREDAAYFAkoef6UACgkQIgvIgzMMSnWLHQCfdCKJEGkZ9+Mine5OLzCw3rZF
owAAoLXPh0m3sG4R7ue+qaPK8S+iRr/F
=S9PD
-----END PGP SIGNATURE-----

--envbJBWh7q8WU6mo--


--===============1419091108263137260==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
vcs-pkg-discuss mailing list
vcs-pkg-discuss-XbBxUvOt3X2LieD7tvxI8l/i77bcL1HB@public.gmane.org
http://lists.alioth.debian.org/mailman/listinfo/vcs-pkg-discuss

--===============1419091108263137260==--
