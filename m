From: Jakub Narebski <jnareb@gmail.com>
Subject: Git at Better SCM Initiative comparison of VCS (long)
Date: Wed, 1 Oct 2008 20:45:13 +0200
Message-ID: <200810012045.14276.jnareb@gmail.com>
References: <200809131906.18746.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "Dmitry Potapov" <dpotapov@gmail.com>,
	"Shawn O. Pearce" <spearce@spearce.org>
To: git@vger.kernel.org, "Alexey Mahotkin" <squadette@gmail.com>
X-From: git-owner@vger.kernel.org Wed Oct 01 20:46:42 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kl6if-0005Ss-HL
	for gcvg-git-2@gmane.org; Wed, 01 Oct 2008 20:46:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753802AbYJASp1 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 1 Oct 2008 14:45:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753409AbYJASp1
	(ORCPT <rfc822;git-outgoing>); Wed, 1 Oct 2008 14:45:27 -0400
Received: from ey-out-2122.google.com ([74.125.78.24]:27582 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753392AbYJASpY (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Oct 2008 14:45:24 -0400
Received: by ey-out-2122.google.com with SMTP id 6so246254eyi.37
        for <git@vger.kernel.org>; Wed, 01 Oct 2008 11:45:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version
         :content-disposition:content-type:content-transfer-encoding
         :message-id;
        bh=y55yNyShvYwZy29H2tdwXReqrgfoC5MFOGm36taZaGA=;
        b=e3Z7p4ctUK57rgDTHrG18V/hR/LMa3Uz8zG+GN2uwrzBz/xWZGVnn7r5hs0xSAKInf
         oe9RfxTUUjCiZvk7SybiSoXPMKlgpRYlJ7A25eHfRf49QGRbY06+1CwiuHX825OJN/md
         QHtvyK1xA8UHsYPYZTw2m09Q7F8bMfvwPnixI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-disposition:content-type
         :content-transfer-encoding:message-id;
        b=kBtmXpXKQexyYnZPMTtXkHJu0sDHcEgTXkvso2Zr3hbhFeIawsAeCZLTWlI+bpKFXn
         NtYUiFvdDiGYE+tnxZYCUL0n3smHBs7iUgC7j7SkcDF0HAZOQRDujwERm5QxCXXtLBT2
         E2h6J5sg04c9p2/xkuaAz/KL1HiB7/lyCD8SQ=
Received: by 10.103.137.19 with SMTP id p19mr6149721mun.108.1222886720874;
        Wed, 01 Oct 2008 11:45:20 -0700 (PDT)
Received: from ?192.168.1.11? (abwk221.neoplus.adsl.tpnet.pl [83.8.234.221])
        by mx.google.com with ESMTPS id j10sm544638mue.17.2008.10.01.11.45.15
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 01 Oct 2008 11:45:18 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <200809131906.18746.jnareb@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97253>

I think that the information about Git at Better SCM Initiative
comparison of various version control systems

  http://better-scm.berlios.de/comparison/comparison.html

used also for versioncontrolblog "Version control systems comparison"

  http://versioncontrolblog.com/comparison

needs a few corrections.


Therefore below you can find proposed changes, as discussed here on
this mailing list (this time CC-ing author of Git entry, Alexey
Mahotkin of versioncontrolblog).  For each section (each compared
feature) I have put description, entry for one or more open source
distributed version control systems (for reference) and current entry
for Git, in email-quote like format (prefixed with "scm> "), then
proposed corrected entry (if it needs correction) and some comments
about it.

Contrary to previous post in this thread I did not comment this time
on the comparison itself, for example not well defined criteria, and
lack of tests or functional/use case description which would help to
check if SCM supports given feature.

I think this could be basis for Alexey to send corrections to
Better SCM comparison table.

Please comment

scm>         <timestamp>
scm>             $Id: scm-comparison.xml 322 2008-08-09 05:47:26Z shlom=
if $
scm>         </timestamp>

Here just so you know on which version it is based on.

scm>     <section id=3D"repos_operations">
scm>         <title>Repository Operations</title>
scm>         <section id=3D"atomic_commits">
scm>             <title>Atomic Commits</title>
scm>             <expl>
scm>                 Support for atomic commits means that if an
scm>                 operation on the repository is interrupted
scm>                 in the middle, the repository will not be
scm>                 left in an inconsistent state. Are the
scm>                 check-in operations atomic, or can
scm>                 interrupting an operation leave the
scm>                 repository in an intermediate state?
scm>             </expl>
scm>             <compare>
scm>                 <s id=3D"cvs">No. CVS commits are not atomic.</s>
scm>                 <s id=3D"bazaar">Yes. Commits are atomic.</s>
scm>                 <s id=3D"mercurial">Yes.</s>
scm>                 <s id=3D"git">Yes. Commits are atomic.</s>
scm>             </compare>
scm>         </section>

No comment here (beside the fact that table neds some unification, but
this is hardly the case for Better SCM comparison Git entry maintainer)=
=2E

scm>         <section id=3D"move">
scm>             <title>Files and Directories Moves or Renames</title>
scm>             <expl>
scm>                 Does the system support moving a file or directory=
 to
scm>                 a different location while still retaining the his=
tory
scm>                 of the file? <b>Note:</b> also see the next sectio=
n
scm>                 about intelligent merging of renamed paths.
scm>             </expl>
scm>             <compare>
scm>                 <s id=3D"bazaar">Yes. Renames are supported for fi=
les and directories.</s>
scm>                 <s id=3D"mercurial">Yes. Renames are supported.</s=
>
scm>                 <s id=3D"git">
scm>                     Renames are supported for most practical
scm>                     purposes.  Git even detects renames when a fil=
e has been
scm>                     changed afterward the rename.  However, due to=
 a peculiar
scm>                     repository structure, renames are not recorded
scm>                     explicitly, and Git has to deduce them (which =
works well
scm>                     in practice).
scm>                 </s>
scm>            </compare>
scm>         </section>

I would propose to change it to something like the followig:

  Renames are supported for most practical purposes[1]. By design Git
  does heuristic <i>rename detection</i> (based on similarity score of
  pathnames and file contents), instead of doing rename tracking.  This
  approach allows for more generic content tracking of code movement
  (which usually happens much often than wholesame file renaming),
  e.g. in "git blame -C -C".

  Footnotes:
  [1] "git log --follow <i>filename</i>" works only for very simple
      history currently; rename detection can get confused by empty fil=
es
      and files consisting mainly of boilerplate (e.g. license text).

Comments:

I am a bit unsure about need for footnote.  Perhaps it should be simply
removed.  Also, perhaps instead of "Renames are supported..." it should
be "File renames are supported...", although it looks like it would
improve soon: see thread on git mailing list about detecting wholesale
firectory renames (with ability to track directory splitting, like now
git is able to track contents movement across files).

scm>         <section id=3D"intelligent_renames">
scm>             <title>Intelligent Merging after Moves or Renames</tit=
le>
scm>             <expl>
scm>                 If the system keeps tracks of renames, does it sup=
port
scm>                 intelligent merging of the files in the history af=
ter
scm>                 the rename? (For example, changing a file in a ren=
amed
scm>                 directory, and trying to merge it).
scm>             </expl>
scm>             <compare>
scm>                 <s id=3D"bazaar">Yes. Renames are intelligent.</s>
scm>                 <s id=3D"mercurial">
scm>                     No. <a=20
scm>                         href=3D"http://hgbook.red-bean.com/hgbookc=
h5.html#x9-1030005.4">the
scm>                         Mercurial book says:</a>
scm>                     "When you use the 'hg rename' command, Mercuri=
al makes a=20
scm>                     copy of each source file, then deletes it and =
marks the
scm>                     file as removed. "
scm>                 </s>
scm>                 <s id=3D"git">
scm>                     No. As detailed in the <a
scm>                         href=3D"http://git.or.cz/gitwiki/GitFaq#re=
name-tracking">Git
scm>                         FAQ</a>:
scm>                     "Git has a rename command git mv, but that is =
just a
scm>                     convenience. The effect is indistinguishable f=
rom removing
scm>                     the file and adding another with different nam=
e and the
scm>                     same content."
scm>                 </s>
scm>            </compare>
scm>         </section>

This entry is incorrect[1]; it has to be changed to something like the
following proposal:

  Yes, Git can deal with renamed files during merging, thanks to rename
  detection.

Comments:

Git does apply change to renamed file, both if file itself is renamed,
and if directory it is in gets renamed (like in example in feature
description).  What Git _currently_ doesn't support (at least for now,
with lack of detection of directories as a whole; this might change
soon) is with adding new files to the renamed directory: if one side
renamed directory and second side added new files in the old directory,
those new files would show at old name, not at new name.

There also might be two kinds of problems: first, if you are merging
old and/or much diverged branch rename detection can use much of CPU
power even if there are no renames present (this happened once or
twice).  Second, if similarity based rename detection fail you would
not get conflict and will be left with two versions of a file in
working directory; this might happen for example if you renamed some
'sensitive' binary file (so small change results in large change in
representation) or change is too large compared to whole contents of=20
a file.  In second case it is expected that requested from time to time
advisory rename tracking would help.

Hmmm... I wonder if the above problems with rename detection happen
more often than problems with, usually file-id based, rename tracking
used by other SCM.

=46ootnote:
=3D=3D=3D=3D=3D=3D=3D=3D=3D
[1] It looks like we really need http://git.or.cz/gitwiki/FileRenames


BTW. I wonder if Mercurial entry isn't incorrect either...

scm>         <section id=3D"copy">
scm>             <title>File and Directories Copies</title>
scm>             <expl>
scm>                 Does the version control system support copying
scm>                 files or directories to a different location at th=
e
scm>                 repository level, while retaining the history?
scm>             </expl>
scm>             <compare>
scm>                 <s id=3D"bazaar">No. Copies are not supported.</s>
scm>                 <s id=3D"mercurial">Yes. Copies are supported</s>
scm>                 <s id=3D"git">No.  Copies are not supported.</s>
scm>            </compare>
scm>         </section>

I would write that:

  Copies detection is supported, but for performance reasons it is not
  enabled by default.

Comments:

Perhaps we could mention here that there are two thresholds of copying
detection: checking only changed files and --detect-copies-harder. Also
worth of note might be the fact that git-blame has support for
detecting code copying, also across filenames.

scm>         <section id=3D"repos_clone">
scm>             <title>Remote Repository Replication</title>
scm>             <expl>
scm>                 Does the system support cloning a remote repositor=
y to get
scm>                 a functionally equivalent copy in the local system=
? That=20
scm>                 should be done without any special access to the r=
emote=20
scm>                 server except for normal repository access.
scm>             </expl>
scm>             <compare>
scm>                 <s id=3D"mercurial">Yes.</s>
scm>                 <s id=3D"git">Yes.  This is very intrinsic feature=
 of Git.</s>
scm>             </compare>
scm>         </section>

In fact this is 'very intrinsic feature' of each distributed SCM...
In short: I think that simple 'Yes.' answer for Git would be better.

scm>         <section id=3D"push">
scm>             <title>Propagating Changes to Parent Repositories</tit=
le>
scm>             <expl>
scm>                 Can the system propagate changes from one reposito=
ry to=20
scm>                 another?
scm>             </expl>
scm>             <compare>
scm>                 <s id=3D"mercurial">Yes.</s>
scm>                 <s id=3D"git">Yes.  (The Linux kernel development =
process uses this extremely often).</s>
scm>             </compare>
scm>         </section>

Again I think that simple "Yes" would be sufficient.  The sentence in
parentheses doesn't bring any new information, so IMHO should be
removed.  Especially that Linux kernel uses also patch based wokflow=20
very extensively.

scm>         <section id=3D"permissions">
scm>             <title>Repository Permissions</title>
scm>             <expl>
scm>                 Is it possible to define permissions on access to =
different
scm>                 parts of a remote repository? Or is access open fo=
r all?=20
scm>             </expl>
scm>             <compare>
scm>                 <s id=3D"bazaar">
scm>                     Basic access control can be implemented throug=
h a
scm>                     contributed hook script.  ACL support for the
scm>                     Bazaar server is planned.
scm>                 </s>
scm>                 <s id=3D"mercurial">
scm>                     Yes. It is possible to lock down repositories,
scm>                     subdirectories, or files using hooks.
scm>                 </s>
scm>                 <s id=3D"git">
scm>                     No, but a single server can serve many reposit=
ories.
scm>                     Also, UNIX permissions can be used to some ext=
ent.
scm>                 </s>

Line-wrapped for better readibility.

scm>             </compare>
scm>         </section>

I think the answer should be here:

  Yes. It is possible to lock down repositories, branches,=20
  subdirectories, or files using hooks (see for example
  <a href=3D"">contrib/hooks/paranoid</a> example hook).

Comments:

Shawn, could you _please_ make documentation of 'paranoid' contrib hook
complete by documenting how to configure it to lock down directories
or files?

As the feature seems to be more about fine-grained access control=20
(by the way something that Karl Fogel in his "Prodicting OSS..." book
is against, as better solved by socual and not technological means)
I have not mentioned here things like web server permissions for WebDAV
access, UNIX file permissions, or tools like Gitosis or ssh_acl, which
are about access to repository as a whole.

scm>         <section id=3D"changesets">
scm>             <title>Changesets' Support</title>
scm>             <expl>
scm>                 Does the repository support changesets? Changesets=
 are a way
scm>                 to group a number of modifications that are releva=
nt to each
scm>                 other in one atomic package, that can be cancelled=
 or=20
scm>                 propagated as needed.
scm>             </expl>
scm>             <compare>
scm>                 <s id=3D"darcs">
scm>                     Yes. Changesets are supported.
scm>                 </s>
scm>                 <s id=3D"mercurial">
scm>                     Yes. Changesets are supported.
scm>                 </s>
scm>                 <s id=3D"git">
scm>                     Yes, Changesets are supported,
scm>                     and there's some flexibility in creating them.
scm>                 </s>

Line wrapped for better eradibility.

scm>            </compare>
scm>         </section>

In my opition, such an _empty_ addition ("there's some flexibility in
creating them") is totally unnecessary; it adds no solid information
(what does it mean "some flexibility") and should be removed.

I think the entry should simply state "Yes. Changesets are supported.";
see for example entry for Darcs (from which Iu the idea of having
"git add --interactive" was taken from).

Comments:

Description of this feature is not entirely clean, but I think
everybody knows what it meant to mean.

scm>         <section id=3D"annotate">
scm>             <title>Tracking Line-wise File History</title>
scm>             <expl>
scm>                 Does the version control system have an option to =
track the
scm>                 history of the file line-by-line? I.e., can it sho=
w for each line
scm>                 at which revision it was most recently changed, an=
d by whom?
scm>             </expl>
scm>             <compare>
scm>                 <s id=3D"mercurial">Yes. (hg annotate)</s>
scm>                 <s id=3D"git">Yes. (git blame).</s>
scm>            </compare>
scm>         </section>
scm>     </section>

This is O.K, but I wonder if it wouldn't be worth to add information
about unique (as far as I know) git-blame abilities, something like:

  Yes.  (git blame).

  <a href=3D"">git-blame</a> can be asked to detect moving lines in fil=
e
  and between files; there exist GUI for blame ("git gui blame <file>")=
=2E

Comments:

One would suspect that because Git is based towards whole project
history, and not per file history, git-blame is slow.  To migitate
that there is incremental blame mode used to reduce latency in graphica=
l
blame viewers like "git gui blame", contrib/blameview, or the one
in QGit.

But anegdotical evidence (meaning in this case discussion with Pieter
de Bie of vcscompare blog on #git IRC channel) shows that git-blame
is of similar performance that its equivalent in Mercurial and Bazaar.
(It is hard to compare with "cvs annotate" as for centralized SCM there
is matter of network speed; I don't know how it compares for local
access, i.e. repository and file/client on the same filesystem).

scm>     <section id=3D"features">
scm>         <title>Features</title>
scm>         <section id=3D"work_on_dir">
scm>             <title>Ability to Work only on One Directory of the Re=
pository</title>
scm>             <expl>
scm>                 Can the version control system checkout only one d=
irectory of
scm>                 the repository? Or restrict the check-ins to only =
one=20
scm>                 directory?
scm>             </expl>
scm>             <compare>
scm>                 <s id=3D"bazaar">For checkouts: No. For checkins: =
Yes.</s>
scm>                 <s id=3D"mercurial">
scm>                     It is possible to commit changes only in a sub=
set of the
scm>                     tree. There are plans for partial checkouts.
scm>                 </s>
scm>                 <s id=3D"git">
scm>                     No.  However, commits could be restricted some=
what,
scm>                     see the "Repository Permissions".
scm>                 </s>

Again, re-wrapped for better readibility.

scm>            </compare>
scm>         </section>

I'm not sure if the entry for Git shouldn't read as:

  No. All changes are made repository-wide.

as in for Aegis.  On the other hand it is possible to restrict commits
and remote access to only some subset of the tree using hooks; also
there is work done on implementing partial/sparse checkout for Git by
Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy (pclouds).  So perhaps it sho=
uld read instead,
similarly to what we have for Mercurial:

  It is possible to restrict commit via hooks to changes only in
  a subset of the tree. Implementing partial/sparse checkouts is
  work in progress.

Comments:

Again, as said in "Producting OSS..." it is better to implement such
restrictions using social rather that technical means; at least for
checkins; there are some reasons (disk space, protecting against
accidental changes, <insert your reason here>) for partial checkouts.

scm>         <section id=3D"tracking_uncommited_changes">
scm>             <title>Tracking Uncommited Changes</title>
scm>             <expl>
scm>                 Does the software have an ability to track the cha=
nges in the
scm>                 working copy that were not yet committed to the re=
pository?
scm>             </expl>
scm>             <compare>
scm>                 <s id=3D"mercurial">Yes. Using hg diff.</s>
scm>                 <s id=3D"git">Yes.
scm>                     Also, branches are very lightweight in Git, an=
d
scm>                     could be considered a kind of storage for "unc=
ommitted" code
scm>                     in some workflows.
scm>                 </s>

A bit rewrapped, and indented.

scm>             </compare>
scm>         </section>

Perhaps we should add "Using git diff" here; the problem is with
[possible] difference between "git diff", "git diff HEAD", and
"git diff --cached".

I also think that the comment is not on subject; it is not closely
related to described feature, so it should be IMHO abandoned. The entry
should then read:

  Yes. Using git diff.=20

Comments:

I don't think it is worth mentioning the fact that staging area in Git
(the index) is explicit and visible, and can be directly accessed. In
usual [newbie] workflows "git diff" works just fine...

scm>         <section id=3D"per_file_commit_messages">
scm>             <title>Per-File Commit Messages</title>
scm>             <expl>
scm>                 Does the system have a way to assign a per-file co=
mmit message
scm>                 to the changeset, as well as a per-changeset messa=
ge?
scm>             </expl>
scm>             <compare>
scm>                 <s id=3D"bitkeeper">Yes. It is possible to have a =
per-file
scm>                     commit message</s>
scm>                 <s id=3D"mercurial">
scm>                     No.
scm>                 </s>
scm>                 <s id=3D"git">
scm>                     No. Commit messages are per changeset.
scm>                 </s>

Re-wrapped.

scm>            </compare>
scm>         </section>
scm>     </section>

Perhaps simple "No." as in case of Mercurial entry would be enough here=
?

Comments:

What is the reason somebody would want per-file commit message?  They
cannot be terribly useful, as BitKeeper which taught Linus about
distributed version control has it, but Git doesn't.

scm>     <section id=3D"technical_status">
scm>         <title>Technical Status</title>
scm>         <section id=3D"documentation">
scm>             <title>Documentation</title>
scm>             <expl>
scm>                 How well is the system documented? How easy is it =
to
scm>                 get started using it?
scm>             </expl>
scm>             <compare>
scm>                 <s id=3D"darcs">
scm>                     Good. The manual contains a brief tutorial and=
 a solid
scm>                     reference.  Every sub-command can print its us=
age.
scm>                     Because the command-set is small and the model=
 is
scm>                     simple, many users find it easy to get started=
=2E
scm>                 </s>
scm>                 <s id=3D"git">
scm>                     Medium. The short help is too terse and obscur=
e.
scm>                     The man pages are extensive, but tend to be co=
nfusing.
scm>                     The are many tutorials.
scm>                 </s>

Re-wrapped and re-indented for better readibilit.

scm>             </compare>
scm>         </section>

That of course depends on ones opinion.  I would say "Good", now that
there is "Git User's Manual" distributed with Git, and now that there
started semi-official "Git Community Book" (http://book.git-scm.com).

So I would say:

  Good. There is extensive <a href=3D"">"Git User's Manual"<a/> distrib=
uted
  with Git. There started semi-official <a href=3D"http://book.git-scm.=
com">"Git
  Community Book". There is manpage for each sub-command, and most comm=
ands
  can print short usage.

Comments:

Backward compatibility^W^W Old impressions die hard,... And the meme
that git documentation is not user friendly is difficult to kill.

scm>         <section id=3D"ease_of_deployment">
scm>             <title>Ease of Deployment</title>
scm>             <expl>
scm>                 How easy is it to deploy the software? What are
scm>                 the dependencies and how can they be satisfied?
scm>             </expl>
scm>             <compare>
scm>                 <s id=3D"mercurial">
scm>                     Excellent.  Binary packages are available for =
all
scm>                     popular platforms.  Building from source requi=
res
scm>                     only Python 2.3 (or later) and a C compiler.
scm>                 </s>
scm>                <s id=3D"git">
scm>                    Good.  Binary packages are available
scm>                    for modern platforms.  C compiler and Perl are
scm>                    required. Requires cygwin on Windows, and has s=
ome
scm>                    UNIXisms.
scm>                </s>
scm>            </compare>
scm>         </section>

Thanks to msysGit project it is not required to install Cygwin to have
Git on Windows. Also some commands are still written as shell scripts.
So I would say:

  Good. Binary packages are available for modern platforms. On Windows
  one can use either Cygwin, or native msysGit version. Requires Perl
  and POSIX shell (and assorted shell tools) for some commands.

Comments:

I don't know what to do with "has some UNIXisms"; I think it is not
very relevant for this entry, and it shouldn't be here.

As I use Git only on Linux (and at one time used msysGit on MS Windows =
XP
and FAT filesystem on USB drive to fetch git.git only), I cannot say mu=
ch
on ease of deployment on other operating systems, like Free/Open/NetBSD=
,
MacOS X, different Unices, and MS Windows.  Perhaps it should be even
"Very good" here?

scm>         <section id=3D"command_set">
scm>             <title>Command Set</title>
scm>             <expl>
scm>                 What is the command set? How compatible is it with
scm>                 the commands of CVS (the current open-source defac=
to
scm>                 standard)?
scm>             </expl>
scm>             <compare>
scm>                 <s id=3D"bitkeeper">
scm>                     A CVS-like command set with some easy-to-get-u=
sed-to
scm>                     complications due to its different way of work=
 and=20
scm>                     philosophy.
scm>                 </s>
scm>                 <s id=3D"bazaar">
scm>                     Tries to follow CVS conventions, but deviates
scm>                     where there is a different design.
scm>                 </s>

The same for Mercurial.

scm>                 <s id=3D"git">
scm>                     Command set is very feature-rich, and not comp=
atible
scm>                     with CVS.
scm>                 </s>
scm>            </compare>
scm>         </section>

I don't think the situation is that different than with Mercurial, so
perhaps it should simply read:

  Tries to follow CVS conventions, but deviates where there is
  a different design.

Although Git doesn't "try to follow CVS conventions", it does follow
BitKeeper convention, then transitively also CVS conventions.  I would
agree with "feature-rich" comment, though ;-)

So perhaps something like

  Command set is very feature-rich; compatibility with CVS conventions
  are limited by differences in design.

scm>         <section id=3D"networking">
scm>             <title>Networking Support</title>
scm>             <expl>
scm>                 How good is the networking integration of the syst=
em?
scm>                 How compliant is it with existing protocols and in=
fra-structure?
scm>             </expl>
scm>             <compare>
scm>                 <s id=3D"bazaar">
scm>                     Excellent. Works natively over HTTP (read-only=
),
scm>                     FTP and SFTP without having Bazaar installed a=
t
scm>                     the remote end.  Works over HTTP, SSH and a cu=
stom
scm>                     protocol when talking to a remote Bazaar
scm>                     server. Supports RSYNC and WebDAV (experimenta=
l)
scm>                     through plugins.
scm>                 </s>
scm>                 <s id=3D"mercurial">
scm>                     Excellent.  Uses HTTP or ssh.  Remote access a=
lso
scm>                     works safely without locks over read-only netw=
ork
scm>                     filesystems.
scm>                 </s>
scm>                 <s id=3D"git">
scm>                     Excellent.  Can use native Git protocol, but w=
orks
scm>                     over rsync, ssh, HTTP and HTTPS also.
scm>                 </s>

Line-wrapped for better readibility.

scm>             </compare>
scm>         </section>

It could be written differently, but basically is O.K. Perhaps we
should state explicitely which protocols are read-only, and which allow
to push (publish) changes to server; which protocols require Git
installed on server and which can do without; perhaps also git-bundle
for off-line transport could be mentioned here.

scm>         <section id=3D"portability">
scm>             <title>Portability</title>
scm>             <expl>
scm>                 How portable is the version-control system to vari=
ous=20
scm>                 operating systems, computer architectures, and oth=
er
scm>                 types of systems?
scm>             </expl>
scm>             <compare>
scm>                 <s id=3D"mercurial">
scm>                     Excellent. Runs on all platforms supported by
scm>                     Python.  Repositories are portable across CPU
scm>                     architectures and endian conventions.
scm>                 </s>
scm>                 <s id=3D"perforce">
scm>                     Excellent. Runs on UNIX, Mac OS, BeOS and Wind=
ows.
scm>                 </s>
scm>                 <s id=3D"git">
scm>                     The client works on most UNIXes, but not on na=
tive
scm>                     MS-Windows. The Cygwin build seems to be worka=
ble, though.
scm>                 </s>

Re-wrapped for better readibility.

scm>             </compare>
scm>         </section>
scm>     </section>

There is native MS Windows implementation named msysGit. We can also
mention that Git runs on Linux, Free/Open/NetBSD, various Unices,=20
MacOX X.

The entry for Git lacks also single word descriptions, like "Excellent"=
,
"Very good", "Good", "Medium", that most other SCM have in this part
(and "Windows only" for some).

So I would say something like the following:

  Very good. Works on Linux, FreeBSD, MacOS X and various Unices. Works
  on MS Windows either via Cygwin, or natively via msysGit.

Perhaps I would also add the following cautionary note:

  There are some issues with case-insensitive (e.g. FAT) or filename-ma=
ngling
  (MacOS HFS+) filesystems, but they can be worked around.

Comments:

I'm not sure if it should be "Very good" or "Excellent" here. I think
that this section is about number of systems SCM was ported to, not
how hard is to make it work (port Git) on some additional OS. I'm not
sure how complete msysGit is (git-svn and other Perl scripts), so I put
"Very good"; but it is improving, buth thanks to builtinification and
to efforts of msysGit maintainers and developers.

scm>     <section id=3D"user_interaces">
scm>         <title>User Interfaces</title>
scm>         <section id=3D"web_interface">
scm>             <title>Web Interface</title>
scm>             <expl>
scm>                 Does the system have a WWW-based interface that ca=
n be
scm>                 used to browse the tree and the various revisions =
of the
scm>                 files, perform arbitrary diffs, etc?
scm>             </expl>
scm>             <compare>
scm>                 <s id=3D"cvs">Yes.=20
scm>                     <a href=3D"http://www.freebsd.org/projects/cvs=
web.html">CVSweb</a>,
scm>                     <a href=3D"http://www.viewvc.org/">ViewVC</a>,
scm>                     <a href=3D"http://www.horde.org/chora/">Chora<=
/a>,
scm>                     and <a href=3D"http://wwcvs.republika.pl/">wwC=
VS</a>.
scm>                 </s>
scm>                 <s id=3D"bazaar">
scm>                     Yes, several:
scm>                     <a href=3D"http://www.lag.net/loggerhead/">Log=
gerhead</a>,
scm>                     <a href=3D"http://goffredo-baroncelli.homelinu=
x.net/bazaar/">Webserve</a>,
scm>                     <a href=3D"http://mccormick.cx/dev/bzrweb/inde=
x.py/log/bzrweb/head">Bzrweb</a>,
scm>                     and
scm>                     <a href=3D"http://bazaar-vcs.org/TracBzr">Trac=
</a>.
scm>                 </s>
scm>                 <s id=3D"mercurial">Yes.  The web interface is a b=
undled component.</s>
scm>                 <s id=3D"git">
scm>                     Yes.  Gitweb is included in distribution.
scm>                 </s>
scm>             </compare>
scm>         </section>

=46or other SCMs there are listed many different web interfaces.
So I would perhaps put here a list:

  Yes.  Gitweb (in Perl) is included in distribution, but there are
  many other web interfaces:
  <a href=3D"http://hjemli.net/git/cgit/">cgit</a> (in C),
  <a href=3D"http://code.google.com/p/git-php/">git-php</a> and
  <a href=3D"http://people.proekspert.ee/peeter/blog/index.php?category=
=3D5">its fork<a> (in PHP),
  <a href=3D"http://viewgit.sourceforge.net/">ViewGit</a> (in PHP),
  <a href=3D"http://www.flameeyes.eu/projects#gitarella">Gitarella</a> =
(in Ruby)

Perhaps we should leave programming language used, as there is no such
information provided for other SCM listed in comparison.

Comments:

I have not put Wit by Daniel Chokola in Ruby/eRuby, as the site seems
to be down. I also didn't add GitStat which is not web interface but
offers instead web-based statistics about repository, and hosting
solutions such as Gitorious (in Ruby), InDefero (in PHP) and GitHub
(not open, in Ruby).

I'm also not sure which one of git-php implementations to list; perhaps
simply the first one, the one that has kind of homepage on Google Code.

scm>         <section id=3D"availability_of_guis">
scm>             <title>Availability of Graphical User-Interfaces.</tit=
le>
scm>             <expl>
scm>                 What is the availability of graphical user-interfa=
ces for
scm>                 the system? How many GUI clients are present for i=
t?
scm>             </expl>
scm>             <compare>
scm>                 <s id=3D"bazaar">
scm>                     There are several graphical frontends in
scm>                     development,
scm>                     see <a href=3D"http://bazaar-vcs.org/BzrPlugin=
s">the Bazaar Plugins page</a>
scm>                     and <a href=3D"http://bazaar-vcs.org/3rdPartyT=
ools">the Third-party Tools page</a>.
scm>                     Notable
scm>                     are <a href=3D"http://bazaar-vcs.org/QBzr">QBz=
r
scm>                     (Qt)</a> and=20
scm>                     <a href=3D"http://bazaar-vcs.org/bzr-gtk">bzr-=
gtk (GTK+)</a>, which
scm>                     can be considered beta quality.  Work is also
scm>                     being done on integrating Bazaar with Windows
scm>                     Explorer, Eclipse, Nautilus, and Meld.
scm>                 </s>
scm>                 <s id=3D"mercurial">
scm>                     History viewing available with hgit extension;
scm>                     check-in extension (hgct) makes committing eas=
ier.
scm>                     Some third-party IDEs and GUI tools (e.g. eric=
3,
scm>                     meld) have integrated Mercurial support.
scm>                 </s>
scm>                 <s id=3D"git">
scm>                     Gitk is included in distribution. =20
scm>                     Qgit and Git-gui tools are also available.
scm>                 </s>

Re-wrapped.

scm>            </compare>
scm>         </section>
scm>     </section>

There is a question whether to list all (or at least more popular) GUI
tools, or list only built-in and perhaps one or two more, and direct
to Git Wiki for details, like below:

  Gitk history viewer and Git-gui commit tool are included in distribut=
ion.
  There are also other tools available, like
  <a href=3D"http://digilander.libero.it/mcostalba/">QGit</a> (Qt) nad
  <a href=3D"http://github.com/Caged/gitnub/wikis">GitNub</a> (MacOS);
  see <a href=3D"http://git.or.cz/gitwiki/InterfacesFrontendsAndTools#g=
ui">Interfaces,
  Frontends And Tools</a> page on Git Wiki for a list.

I have listed two most popular GUI according to currently open survey
  http://www.survs.com/shareResults?survey=3DM3PIVU72&rndm=3DOKJQ45LAG8

Comments:

Should there be mentioned integration and beginning of integration with
IDE, editors and other tools in the form of EGit (Eclipse Git plugin),
similar work for NetBeans and IntelliJ/JetBeans, Git TextMate bundle,
Emacs modes (git.el, vc-git.el, DVC, magit), and support from other
tools like PIDA and Meld?  It is mentioned for other SCM, but it is
not GUI in exact meaning of this word.

scm>     <section id=3D"license">
scm>         <title>License</title>
scm>         <expl>
scm>             What are the licensing terms for the software?=20
scm>         </expl>
scm>         <compare>
scm>             <s id=3D"mercurial">GNU GPL (open source)</s>
scm>             <s id=3D"git">GNU GPL v2 (open source).</s>
scm>         </compare>
scm>     </section>
scm> </section>

No comments here.

--=20
Jakub Narebski
Poland
