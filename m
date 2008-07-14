From: Junio C Hamano <gitster@pobox.com>
Subject: Closing the merge window for 1.6.0
Date: Mon, 14 Jul 2008 00:50:48 -0700
Message-ID: <7vzlokhpk7.fsf@gitster.siamese.dyndns.org>
References: <7vlk4snpj3.fsf@gitster.siamese.dyndns.org>
 <7vabjm1a0q.fsf@gitster.siamese.dyndns.org>
 <7vr6crj0jk.fsf@gitster.siamese.dyndns.org>
 <7vmyn4hr8f.fsf@gitster.siamese.dyndns.org>
 <7vmymsjz6x.fsf@gitster.siamese.dyndns.org>
 <7vabijxhk4.fsf@gitster.siamese.dyndns.org>
 <7vwslhg8qe.fsf@gitster.siamese.dyndns.org>
 <7vhccfiksy.fsf@gitster.siamese.dyndns.org>
 <7vod6k6zg4.fsf@gitster.siamese.dyndns.org>
 <7v4p7xwsfp.fsf@gitster.siamese.dyndns.org>
 <7v3anb19n7.fsf@gitster.siamese.dyndns.org>
 <7vwskjazql.fsf@gitster.siamese.dyndns.org>
 <7vk5ggipuw.fsf@gitster.siamese.dyndns.org>
 <7vej6l3lp7.fsf@gitster.siamese.dyndns.org>
 <7vod5kd3im.fsf@gitster.siamese.dyndns.org>
 <7v3amv1e8n.fsf@gitster.siamese.dyndns.org>
 <7vprpwhp7t.fsf@gitster.siamese.dyndns.org>
 <7vlk0ffhw3.fsf@gitster.siamese.dyndns.org>
 <7vtzf1w0rj.fsf@gitster.siamese.dyndns.org>
 <7vabgqsc37.fsf@gitster.siamese.dyndns.org>
 <7vtzetjbif.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jul 14 09:52:23 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KIIqx-0003AK-Vy
	for gcvg-git-2@gmane.org; Mon, 14 Jul 2008 09:52:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757360AbYGNHu4 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 14 Jul 2008 03:50:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756850AbYGNHu4
	(ORCPT <rfc822;git-outgoing>); Mon, 14 Jul 2008 03:50:56 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:41302 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757337AbYGNHuy convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 14 Jul 2008 03:50:54 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id DB149295E8;
	Mon, 14 Jul 2008 03:50:52 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 83053295E6; Mon, 14 Jul 2008 03:50:50 -0400 (EDT)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 954ED434-5179-11DD-8CA1-CE28B26B55AE-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88393>

Junio C Hamano <gitster@pobox.com> writes:

> I think most of the important stuff is already in 'next'.  Let's star=
t
> talking about closing the merge window for 1.6.0.

I think by the time we declare -rc0, we will have merged everything we
have in "Actively Cooking" list from tonight, perhaps except for the
"merge -Xtheirs", as there do not seem to be wide support for this
feature.  All the Windows bits and myriad of s/git-foo/git foo/ patches
submitted over the weekend and queued in next/pu, and various smallish
topics in "New Topics" list will hopefully all appear in 1.6.0.

In essence, I am saying that the merge window is more-or-less closed, f=
rom
the point of view of "what will be in, and what won't be"; of course so=
me
of the topics may not be merged in their current shape without further
fixes.

The reason I say more-or-less is because I am aware of a handful of
patches that are not even in 'pu' yet:

 * A few patches from Mark Levedahl on git-submodule are still held in =
my
   inbox; I haven't decided what to do with them.

    Date: Wed,  9 Jul 2008 21:05:40 -0400
    Subject: [PATCH] git-submodule - make "submodule add" more strict, =
and document it
    Message-Id: <1215651941-3460-1-git-send-email-mlevedahl@gmail.com>

    Date: Wed,  9 Jul 2008 21:05:41 -0400
    Subject: [PATCH] git-submodule - register submodule URL if adding i=
n place
    Message-ID: <1215651941-3460-2-git-send-email-mlevedahl@gmail.com>

   These two appeared at the end of a discussion, and as far as I can s=
ee,
   there wasn't any objection to them.  Unless somebody makes a convinc=
ing
   argument against them, I am inclined to include them in 1.6.0

 * Starting bisect with a forked good and bad pair, from Christian Coud=
er,
   is not queued yet.  I think it is just the matter of Christian
   resending the two patches squashed (or me applying them while squash=
ing
   them myself) --- I was busy cutting 1.5.6.3 release and tending othe=
r
   topics, and haven't got around to do so.

    Date: Thu, 10 Jul 2008 05:41:52 +0200
    Subject: [PATCH] bisect: test merge base if good rev is not an ance=
stor of bad rev
    Message-Id: <20080710054152.b051989c.chriscool@tuxfamily.org>

 * Alice and Bob prompt in tutorial, from Ian Katz, is not queued; they
   should be safe to directly apply to 'master'.  The only reason why I
   haven't is because it takes a lot of time to generate and concentrat=
ion
   to eyeball the documentation markups to catch mistakes.

    Date: Thu, 10 Jul 2008 14:27:30 -0400
    Subject: Re: [PATCH] tutorial: prefix the prompts with names alice =
or bob,
	to make it clear who is doing what
    Message-ID: <dc5b80bf0807101127q63e3132fw207baf0d88db3d9d@mail.gmai=
l.com>

    Subject: [PATCH] tutorial: clarify "pull" is "fetch + merge"
    Date: Thu, 10 Jul 2008 14:01:57 -0700
    Message-ID: <7vskuho3lm.fsf_-_@gitster.siamese.dyndns.org>

 * A git-svn patch from Jo=C3=A3o Abecasis; I am waiting for Eric to ac=
t on it.

    Subject: [PATCH] git-svn: find-rev and rebase for SVN::Mirror repos=
itories
    Date: Wed, 9 Jul 2008 03:08:27 +0100
    Message-ID: <7bf6f1d20807081908kdf9f615taa532ae579b457d7@mail.gmail=
=2Ecom>


Here is the draft release notes as of tonight.

----------------------------------------------------------------

GIT v1.6.0 Release Notes (draft)
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D

User visible changes
--------------------

With the default Makefile settings, most of the programs are now
installed outside your $PATH, except for "git", "gitk", "git-gui" and
some server side programs that need to be accessible for technical
reasons.  Invoking a git subcommand as "git-xyzzy" from the command
line has been deprecated since early 2006 (and officially announced in
1.5.4 release notes); use of them from your scripts after adding
output from "git --exec-path" to the $PATH is still supported in this
release, but users are again strongly encouraged to adjust their
scripts to use "git xyzzy" form, as we will stop installing
"git-xyzzy" hardlinks for built-in commands in later releases.

Source changes needed for porting to MinGW environment are now all in t=
he
main git.git codebase.

By default, packfiles created with this version uses delta-base-offset
encoding introduced in v1.4.4.  Pack idx files are using version 2 that
allows larger packs and added robustness thanks to its CRC checking,
introduced in v1.5.2.

GIT_CONFIG, which was only documented as affecting "git config", but
actually affected all git commands, now only affects "git config".
GIT_LOCAL_CONFIG, also only documented as affecting "git config" and
not different from GIT_CONFIG in a useful way, is removed.

An ancient merge strategy "stupid" has been removed.


Updates since v1.5.6
--------------------

(subsystems)

* git-p4 in contrib learned "allowSubmit" configuration to control on
  which branch to allow "submit" subcommand.

* git-gui learned to stage changes per-line.

(portability)

* Changes for MinGW port have been merged, thanks to Johannes Sixt and
  gangs.

* Sample hook scripts shipped in templates/ are now suffixed with
  *.sample.  We used to prevent them from triggering by default by
  relying on the fact that we install them as unexecutable, but on
  some filesystems this approach does not work.  Instead of running
  "chmod +x" on them, the users who want to activate these samples
  as-is can now rename them dropping *.sample suffix.

* perl's in-place edit (-i) does not work well without backup files on =
Windows;
  some tests are rewritten to cope with this.

(documentation)

* Updated howto/update-hook-example

* Got rid of usage of "git-foo" from the tutorial and made typography
  more consistent.

* Disambiguating "--" between revs and paths is finally documented.

(performance, robustness, sanity etc.)

* even more documentation pages are now accessible via "man" and "git h=
elp".

* reduced excessive inlining to shrink size of the "git" binary.

* verify-pack checks the object CRC when using version 2 idx files.

* When an object is corrupt in a pack, the object became unusable even
  when the same object is available in a loose form,  We now try harder=
 to
  fall back to these redundant objects when able.  In particular, "git
  repack -a -f" can be used to fix such a corruption as long as necessa=
ry
  objects are available.

* git-clone does not create refs in loose form anymore (it behaves as
  if you immediately ran git-pack-refs after cloning).  This will help
  repositories with insanely large number of refs.

* core.fsyncobjectfiles configuration can be used to ensure that the lo=
ose
  objects created will be fsync'ed (this is only useful on filesystems
  that does not order data writes properly).

* "git commit-tree" plumbing can make Octopus with more than 16 parents=
=2E
  "git commit" has been capable of this for quite some time.

(usability, bells and whistles)

* A new environment variable GIT_CEILING_DIRECTORIES can be used to sto=
p
  the discovery process of the toplevel of working tree; this may be us=
eful
  when you are working in a slow network disk and are outside any worki=
ng tree,
  as bash-completion and "git help" may still need to run in these plac=
es.

* By default, stash entries never expire.  Set reflogexpire in [gc
  "refs/stash"] to a reasonable value to get traditional auto-expiratio=
n
  behaviour back

* Longstanding latency issue with bash completion script has been
  addressed.  This will need to be backmerged to 'maint' later.

* pager.<cmd> configuration variable can be used to enable/disable the
  default paging behaviour per command.

* "git-add -i" has a new action 'e/dit' to allow you edit the patch hun=
k
  manually.

* git-apply can handle a patch that touches the same path more than onc=
e
  much better than before.

* git-apply can be told not to trust the line counts recorded in the in=
put
  patch but recount, with the new --recount option.

* git-apply can be told to apply a patch to a path deeper than what the
  patch records with --directory option.

* git-archive can be told to omit certain paths from its output using
  export-ignore attributes.

* With -v option, git-branch describes the remote tracking statistics
  similar to the way git-checkout reports by how many commits your bran=
ch
  is ahead/behind.

* git-bundle can read the revision arguments from the standard input.

* git-cherry-pick can replay a root commit now.

* git-clone can clone from a remote whose URL would be rewritten by
  configuration stored in $HOME/.gitconfig now.

* git-diff --check now checks leftover merge conflict markers.

* When remote side used to have branch 'foo' and git-fetch finds that n=
ow
  it has branch 'foo/bar', it refuses to lose the existing remote track=
ing
  branch and its reflog.  The error message has been improved to sugges=
t
  pruning the remote if the user wants to proceed and get the latest se=
t
  of branches from the remote, including such 'foo/bar'.

* fast-export learned to export and import marks file; this can be used=
 to
  interface with fast-import incrementally.

* "git rerere" can be told to update the index with auto-reused resolut=
ion
  with rerere.autoupdate configuration variable.

* git-rev-list learned --children option to show child commits it
  encountered during the traversal, instead of shoing parent commits.

* git-send-mail can talk not just over SSL but over TLS now.

* "git-stash save" learned --keep-index option.  This lets you stash aw=
ay the
  local changes and bring the changes staged in the index to your worki=
ng
  tree for examination and testing.

* git-stash also learned branch subcommand to create a new branch out o=
f
  stashed changes.

* git-status gives the remote tracking statistics similar to the way
  git-checkout reports by how many commits your branch is ahead/behind.

* You can tell "git status -u" to even more aggressively omit checking
  untracked files with --untracked-files=3Dno.

* Original SHA-1 value for "update-ref -d" is optional now.

* Error codes from gitweb are made more descriptive where possible, rat=
her
  than "403 forbidden" as we used to issue everywhere.

(internal)


=46ixes since v1.5.6
------------------

All of the fixes in v1.5.6 maintenance series are included in
this release, unless otherwise noted.

 * "git fetch" into an empty repository used to remind the fetch will
   be huge by saying "no common commits", but it is already known by
   the user anyway (need to backport 8cb560f to 'maint').

---
exec >/var/tmp/1
O=3Dv1.5.6.3-315-g10ce020
echo O=3D$(git describe refs/heads/master)
git shortlog --no-merges $O..refs/heads/master ^refs/heads/maint
