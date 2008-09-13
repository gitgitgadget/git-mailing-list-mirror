From: Jakub Narebski <jnareb@gmail.com>
Subject: Git at Better SCM Initiative comparison of VCS (long)
Date: Sat, 13 Sep 2008 19:06:16 +0200
Message-ID: <200809131906.18746.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Sep 13 19:07:54 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KeYb0-0006cg-83
	for gcvg-git-2@gmane.org; Sat, 13 Sep 2008 19:07:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751989AbYIMRGd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 13 Sep 2008 13:06:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751991AbYIMRGd
	(ORCPT <rfc822;git-outgoing>); Sat, 13 Sep 2008 13:06:33 -0400
Received: from ug-out-1314.google.com ([66.249.92.170]:51421 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751744AbYIMRGa convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 13 Sep 2008 13:06:30 -0400
Received: by ug-out-1314.google.com with SMTP id k3so295976ugf.37
        for <git@vger.kernel.org>; Sat, 13 Sep 2008 10:06:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:mime-version:content-disposition:content-type
         :content-transfer-encoding:message-id;
        bh=rqzQILTqbqshJRd9XtSkxSx8z/Fy6otG9a8US97fTHw=;
        b=cWdiAb7qLbVJn5vVv4A4L5laOvkTCRgnRywbqgJIk3enmv8BHRbrTozDi1UZTSck9R
         dCyTcHrJKLAE6fEqjoK+vdhLT7PHGwTUmPMsV9ODVwpGbwppJ2MtuDFUOdyRwysFLs4C
         URWzWjm5ie+gCyDTb60kyuCN1QdJ7BOP+Wq9k=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:mime-version:content-disposition
         :content-type:content-transfer-encoding:message-id;
        b=HXWtpHM2STJjZ4Cmhr2OWNk3g6EW8v1JW4hmOwUoro7c//gWIShYBP0/v4Wd+7Zhdm
         8T/lhx8tg/ONt5LLjDmJ3RRk8UXevG1WGDzqUB1hGt/U0o57V1I1b9TYAN3C5vGUYNQP
         yLn4LaXk3/UTVTXJFvovGOoay9S1p2FaEbao0=
Received: by 10.86.100.19 with SMTP id x19mr4241107fgb.70.1221325587860;
        Sat, 13 Sep 2008 10:06:27 -0700 (PDT)
Received: from ?192.168.1.11? ( [83.8.227.225])
        by mx.google.com with ESMTPS id 4sm14426778fgg.4.2008.09.13.10.06.22
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 13 Sep 2008 10:06:26 -0700 (PDT)
User-Agent: KMail/1.9.3
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95809>

I have tried a few times to add information about Git to comparison
table of SCMs at 'Better SCM Initiative' (http://better-scm.berlios.de)

  http://thread.gmane.org/gmane.comp.version-control.git/66445
  http://thread.gmane.org/gmane.comp.version-control.git/67708

but somehow I didn't lead it to conclusion, namely adding Git to
the comparison table.  (Sidenote: Data from 'Better SCM : Comparison'
is used also for versioncontrolblog "Version control systems comparison"
at http://versioncontrolblog.com/comparison).

I have thought about trying yet another time... but Git was already
added; see http://better-scm.berlios.de/news/changes-2008-08-07/
Now I have checked information about Git and think that this table
needs a few corrections and, in some places, extra explanation.


Let us here come together with a version we can be happy with, which
I would be then able to send as correction for Better SCM Initiative
comparison (http://better-scm.berlios.de/contribute/).

Below there are excerpts from source of comparison table (from SVN)

  http://opensvn.csie.org/betterscm/better-scm-site/trunk/src/comparison/scm-comparison.xml

marked as quoted text (with 'scm>'), optionally un-indented and
re-wrapped for better readibility. My comments follow as if they
were replies to an email.

---
scm> <?xml version='1.0' encoding='utf-8'?>
scm> <?xml-stylesheet type="text/xml" href="compare-ml.xsl"?>
scm> <!DOCTYPE comparison SYSTEM "comparison.dtd">
scm> <!--
scm> TODO:
scm> 
scm> * Add intelligent merging of renamed paths.

The comparison has a new criterion: "Intelligent Merging after Moves
or Renames" since 2008-08-07, so the first item in this TODO list
should have been removed, I think.

scm> * Add IDE integration.
scm> * Integration with build/testing management.
scm> * Check-In policies.
scm> * Add Speed (?)
scm> -->

The problem of course with adding new criterion is that it should be
added for _all_ (currently 27) version control systems (SCMs) covered.

scm> <comparison>
scm>     <meta>
scm>         <implementations>

scm>             <impl id="git">
scm>                 <name>Git</name>
scm>                 <url>http://git.or.cz/</url>
scm>             </impl>

Hmmm... what to do about the fact that currently Git has _two_ forks of
a homepage: http://git.or.cz (aka http://git-scm.org) by Petr 'Pasky'
Baudis and new http://git-scm.com by Scott Chacon, I do wonder...

But those are just aimless musings... the above is O.K.

scm>         </implementations>
scm>         <timestamp>
scm>             $Id: scm-comparison.xml 322 2008-08-09 05:47:26Z shlomif $
scm>         </timestamp>
scm>     </meta>
scm>     <contents>
scm> <section id="main">
scm>     <title>Version Control System Comparison</title>
scm>     <expl>
scm>         This is a comparison of version-control systems. It is split
scm>         into several categories and sub-categories under which the 
scm>         systems are checked.
scm>     </expl>
scm>     <section id="repos_operations">
scm>         <title>Repository Operations</title>
scm>         <section id="atomic_commits">
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

Here I think the explanation of a criterion (feature) is clear enough.
I might have added that "interruption" include killing of a process
during for example commit, lack of disk space for a full commit, or
a network fail during network operation (fetch or push, or equivalent).

scm>             <compare>
scm>                 <s id="git">Yes. Commits are atomic.</s>
scm>             </compare>

O.K.

scm>         </section>
scm>         <section id="move">
scm>             <title>Files and Directories Moves or Renames</title>
scm>             <expl>
scm>                 Does the system support moving a file or directory to
scm>                 a different location while still retaining the history
scm>                 of the file? <b>Note:</b> also see the next section
scm>                 about intelligent merging of renamed paths.
scm>             </expl>

In my opinion this criterion is next to worthess without more in depth
clarification of what does it mean to "support" moves or renames; as
entries for different systems are written by different people, if it
is not clear how to check if some feature is supported, some might
write 'no' for some system A, and some other person can write 'yes'
for other system B, even if the support is better in system A than in
system B (and would be considered enough, i.e. 'yes' answer, by the
creator of this criterion).

For me the support for renames/moves and copying (see next section)
means that:

 0.) When examining or going to some point in the history (some old
     revision/version of a project) the state you get is _exactly_
     the same as it was at that time, exactly the same as it was
     recorded (comitted) then.

     For example tricks with moving *,v files in the CVS repository
     break this assertion.

 1.) When examining history of a project as a whole version control
     system tells you that file was renamed (moved). I would consider
     having there renaming represented as copy + delete to be only
     a partial support of this feature.

     Note that while tool might correctly notify about file renames
     (I would consider heuristics which give correct answer in 99%
     or so "true life" example to 'correctly notify'), it might notice
     full directory renames only as renames of individual files.
     I guess that at least for some systems this issue was not taken
     into account...

 2.) When examining history of an individual file (or perhaps even of
     an individual directory), either in the form of list of revisions
     which touch given file in the form of "$scm log <file>" output or
     some graphical history viewer output, or in the form of annotations
     of file contents (so called here 'per-line history') in the form
     of "$scm blame <file>" / "$scm annotate <file>", we would want for
     SCM to follow history of contents across file renames (and other
     code movements if possible; but that is outside of scope of this
     criterion).

     Side note: history of two files can be more than sum (union) of
     histories of individual files.
     
From the comments I have heard it looks like at least for some version
control systems contributors used the meaning '0', while most users
(readers) would think of '1+2', good if not forgetting about '0'.

Here (and in other places) it would be nice to have actual *TEST*, which
can be used to determine if given version control system "supports"
'Files and Directories Moves or Renames' criterion/feature. Attention!
because Git does similarity based rename detection (contents + pathname
based similarity score), one should use better some larger test vector,
otherwise Git and other systems using rename detection would be at
disadvantage. An example of such test would be t/t*rename* tests from
git; we could also use 'Lorem ipsum' or 'Dominus regit me' test vectors.

So for example 1.) could be tested as:
 $ scm add A
 $ ...
 $ scm mv A B
 $ ...
 $ scm log [options]   # <- has info about A => B rename

while 2.) could be tested as:
 $ scm add A
 $ ...
 $ scm mv A B
 $ ...
 $ scm log [options] B  # <- goes to initial revision of A


By the way, there is even simpler operation than support for renames
that SCM can screw up (file-history based SCM are specially
susceptible).  Try to delete a file, and then later create _different_
file (separate history) with the same filename.

scm>             <compare>

scm>                 <s id="git">
scm>                     Renames are supported for most practical
scm>                     purposes.  Git even detects renames when a file has been
scm>                     changed afterward the rename.  However, due to a peculiar
scm>                     repository structure, renames are not recorded
scm>                     explicitly, and Git has to deduce them (which works well
scm>                     in practice).
scm>                 </s>

First, a correction to above statement.  It is not due to "a peculiar
repository structure", but due to "a design decision" (perhaps with
link to some explanation why it was implemented this way; I planned
to make a wiki page about 'rename tracking' vs. 'rename detection'
with references to various mailing list messages etc., but to this
day it was not created).


Second, we can think about how the above statement could be improved.

For example Git fullfils '0' even without rename detection, due to
the fact that it is whole-tree snapshot-based VCS.  From descriptions
for other version control systems (see "Version Control System
Comparison" subpage of "Better SCM Initiative : Comparison" at
http://better-scm.berlios.de/comparison/comparison.html) it looks like
at least some contributors thought that having '0' supported is enough
to say 'Yes' to this question.

Git uses rename detection, not rename tracking (usually file-id/inode
based) to be able to notify about renames in the diff / whatchanged /
diffstat or summary output.  So I would say that in practice (with
some unfortunate exceptions) Git fills '1', which means showing renames
in whole project log well.

When talking about rename detection for a single file history, here
the situation gets difficult.  On the one hand "git log --follow <file>"
is a bit of hack and works only for simple histories, failing for
example on subtree merge; other example would be 'gitweb/gitweb.perl'
file in git repository, which '--follow' doesn't follow to initial
'gitweb.cgi' file from what once been gitweb repository.  One has
to use then "git log -- <old name> <new name>"; this is caused by the
fact that git always concentrated more on full repository history, and
by how path limiting works.  On the other hand Git has as far as I know
_unique_ blame tool which is able to follow code movement; this covers
more than only following contents across wholesame file rename.  This
feature IMHO is best examined using "git gui blame <file>" or other
graphical blame/annotate viewers (QGit has one, for example).


To be honest git currently does not have _directory_ rename detection
(which for example leads to some quirks in dealing with renames during
merge, to be more exact dealing with new files in a directory which
got renamed by other side); it currently supports directory renames
by detecting renames of files it contains (path similarity is part of
rename-detection similarity score).  But this is not insurmountable
obstacle, and does not require changing design and tracking renames.


...Now only put the above in a few short sentences to be used in
"Better SCM Initiative" comparison table...


scm>            </compare>
scm>         </section>
scm>         <section id="intelligent_renames">
scm>             <title>Intelligent Merging after Moves or Renames</title>
scm>             <expl>
scm>                 If the system keeps tracks of renames, does it support
scm>                 intelligent merging of the files in the history after
scm>                 the rename? (For example, changing a file in a renamed
scm>                 directory, and trying to merge it).
scm>             </expl>

Here also the criterion is not completly clear.  The example helps
a little, but it should perhaps be expanded a little.  I don't know
also why the example is unnecessary complicated, with renaming
directory; perhaps this version is shorter to describe.

For me "Intelligent Merging after Moves or Renames" consist of the
following items: merging renames, applying change to correct file,
dealing with renamed directories, and new merge conflict types related
to renames and similar things.

Let me explain each concept with a little test case checking if given
SCM support respective feature:
 * merging renames: if one side renamed file you should get rename on
   merge; renaming a file and then merging that rename.
     [on branch b]$ scm mv foo bar
     [on branch a]$ scm commit ... # to not have fast-forward case
     [on branch a]$ scm merge b
     expected result> you have file 'bar', and do not have file 'foo'

 * applying change to correct file: if our side renamed a file (or, as
   in above example rename directory it is in, which does rename full
   pathname of a file indirectly), and possibly change it, and the other
   side changed file, we would want merge to bring changes to file after
   rename.
     [on branch a]$ scm mv foo bar
     [on branch a]$ edit bar && scm commit # optionally
     [on branch b]$ edit foo
     [on branch b]$ scm commit -m 'FOO'
     [on branch a]$ scm merge b
     expected result> you have changes made on branch 'b' to file 'foo'
                      (commit 'FOO') in file 'bar'
   Note that like in example in previous item all operations take place
   _after_ branching point (after creation of branch b off branch a).

   This is I guess what most people think when talking about
   rename-aware (intelligent) merging.

 * renamed directories bring another complication (described for example
   on Mark Shuttleworth blog in articles about DVCS, promoting Bazaar-NG),
   namely how to deal with merging changes where other side creates
   _new files_ in renamed directory.
     [on branch a]$ scm mv subdir-foo/ subdir-bar/
     [on branch b]$ scm add subdir-foo/baz
     [on branch a]$ scm merge b
     expected result> New file subdir-bar/baz
   There is a bit of controversy about this feature, as for example in
   some programming languages (e.g. Java) or in some project build tool
   info it is not posible to simply move a file (or create new file in
   different directory) without changing file contents.  Some say that
   is better to fail than to do wrongly clean merge.

scm>             <compare>
scm>                 <s id="accurev">
scm>                     Unknown. FILL IN.
scm>                 </s>

As you can see it is new criterion :-)

scm>                 <s id="git">
scm>                     No. As detailed in the <a
scm>                         href="http://git.or.cz/gitwiki/GitFaq#rename-tracking">Git
scm>                         FAQ</a>:
scm>                     "Git has a rename command git mv, but that is just a
scm>                     convenience. The effect is indistinguishable from removing
scm>                     the file and adding another with different name and the
scm>                     same content."
scm>                 </s>

This is of course NOT TRUE.  If the author bother checking (which
would be helped if there was available simple shell script, or simple
Perl script, testing 'intelligent_renames' criterion) he/she would
notice that git does apply change to renamed file, both if file
itself is renamed, and if directory it is in gets renamed.

If I understand correctly dealing with file renames and moving files
around (one could say: refactoring directory hierarchy/structure) was
main reason (or one of main reasons) for adding rename detection to
Git.  In practice it works quite well (which for the test mean testing
with large enough contents to be able to use similarity based rename
detection).

What Git _currently_ doesn't support (at least for now, with lack of
detection of directories as a whole) is with adding new files to the
renamed directory, as described a bit above.

scm>         <section id="copy">
scm>             <title>File and Directories Copies</title>
scm>             <expl>
scm>                 Does the version control system support copying
scm>                 files or directories to a different location at the
scm>                 repository level, while retaining the history?
scm>             </expl>

The same complaint as with the "File and Directory Moves or Renames".
What does "support copying" mean for SCM in question, in this context?

scm>             <compare>
scm>                 <s id="git">No.  Copies are not supported.</s>
scm>            </compare>

To a large extent NOT TRUE.  Copies _ARE_ supported in Git using the
same mechanism of similarity based detection as for renames.

There are however some caveats and limitations compared to rename
detection.  

First, you have to enable copies detection.  While it is not uncommon
to have rename detection turned on (I'm not sure if it is not on by
default, for example for git-show; nevertheless you can turn it on for
diffs using diff.renames configuration variable, and for example gitweb
web interface by default detects renames), it is much less common to
have copies detection turned on by default, as it is more expensive
operation.

Second, for performance reasons Git finds copies only if the original
file of the copy was modified in the same changeset.  You can search
for copies in all files, but it is much more expensive operation.

On the other hand git-blame can be asked to deal with code copying,
even across files; as far as I know Git is the _only_ SCM which has
file line provenance annotation tool which supports this.

scm>         <section id="repos_clone">
scm>             <title>Remote Repository Replication</title>
scm>             <expl>
scm>                 Does the system support cloning a remote repository to get
scm>                 a functionally equivalent copy in the local system? That 
scm>                 should be done without any special access to the remote 
scm>                 server except for normal repository access.
scm>             </expl>

This means either that SCM in question is distributed, or that there
exists some replication / morroring tool (for centralized SCMs).

scm>             <compare>
scm>                 <s id="bazaar">Yes.</s>
scm>                 <s id="darcs">Yes.</s>
scm>                 <s id="mercurial">Yes.</s>
scm>                 <s id="monotone">Yes.</s>

scm>                 <s id="git">Yes.  This is very intrinsic feature of Git.</s>

In fact this is 'very intrinsic feature' of each distributed SCM...
well, unless one takes into account difference between single-branch
or workdir-per-branch distributed SCM and multiple-branch-per-repository
distributed SCM.  Then this is a bit more complicated.

In short: I think that simple 'Yes.' answer for Git would be better.

scm>         <section id="push">
scm>             <title>Propagating Changes to Parent Repositories</title>
scm>             <expl>
scm>                 Can the system propagate changes from one repository to 
scm>                 another?
scm>             </expl>

O.K.

scm>             <compare>
scm>                 <s id="mercurial">Yes.</s>
scm>                 <s id="monotone">Yes.</s>
scm>                 <s id="git">Yes.  (The Linux kernel development process uses this extremely often).</s>
scm>             </compare>
scm>         </section>

I'm not sure if this comment is there really necessary.  I would avoid
it, especially that as far as I understand Linux kernel development
uses patch+email based system as extensively or even more extensively,
at least onlietenants level.

scm>         <section id="permissions">
scm>             <title>Repository Permissions</title>
scm>             <expl>
scm>                 Is it possible to define permissions on access to different
scm>                 parts of a remote repository? Or is access open for all? 
scm>             </expl>

Side note: Karl Fogel in his book "Producing Open Source Software. 
How to Run a Successful Free Software Project" (http://producingoss.com)
wrote basing on his work on _Subversion_ (which is centralized SCM),
that there are usually many advantages to use 'honor system' instead
of repository permission, i.e. use social solution than technological
solution, see "Chapter 3. Technical Infrastructure", section "Version
Control", subsection "Authorization"
  http://producingoss.com/en/vc.html#vc-authz

Distributed version control systems like Git, Mercurial or Bazaar-NG
offers even wider selection of ways to implement 'honor system', and
solve "Repository Permissions" problem using social solution.

[Here would be nice to have link to discussion of "Prodicting OSS" book
on git mailing list, and to article discussion it]

scm>             <compare>
scm>                 <s id="bazaar">
scm>                     Basic access control can be implemented through a
scm>                     contributed hook script.  ACL support for the
scm>                     Bazaar server is planned.
scm>                 </s>
scm>                 <s id="mercurial">
scm>                     Yes. It is possible to lock down repositories,
scm>                     subdirectories, or files using hooks.
scm>                 </s>
scm>                 <s id="monotone">
scm>                     Yes. It is possible to restrict incoming changes
scm>                     from certain sources to be performed only in certain
scm>                     parts of the repository.
scm>                 </s>
[...]
scm>                 <s id="git">
scm>                     No, but a single server can serve many repositories.
scm>                     Also, UNIX permissions can be used to some extent.</s>
scm>             </compare>
scm>         </section>

Side note: why Git entry was not word-wrapped like the entries for most
other SCM, but used single long line? I have rewrapped it for better
readibility.

First, there is possible to lock down repositories, using permissions
of underlying protocols (SSH, WebDAV), or using additional tools like
Gitosis, ssh_acl or example hook contrib/hooks/update-paranoid.  It
is possible to lock down (limit access to) branches and tags, which is
not mentioned as scope of this criterion, and I think is more important
feature.

Second, I think it is possible to restrict incoming changes from certain
sources to subdirectories or files using hooks; but as far as I know
there doesn't exist any such example hook.

And third, it is not as important for distributed SCM to have
fine-grained technical solution when there are many social solutions
to this problem; for example in Git when you do a pull from other
repository it would (usually) show you diffstat of changes, so you
can easily see if there were changes made outside some directory limits.

scm>         <section id="changesets">
scm>             <title>Changesets' Support</title>
scm>             <expl>
scm>                 Does the repository support changesets? Changesets are a way
scm>                 to group a number of modifications that are relevant to each
scm>                 other in one atomic package, that can be cancelled or 
scm>                 propagated as needed.
scm>             </expl>

Here it is not entirely clean what creator of "Better SCM Initiative"
comparison table had on mind, what he meant by this.  Not all version
control systems are changeset based; some are snapshot based.  I guess
that for snapshot based SCM the above requirement is equivalent to
"Whole tree commits".

scm>             <compare>
scm>                 <s id="cvs">No. Changes are file-specific.</s>
scm>                 <s id="subversion">Partial support. There are implicit 
scm>                     changeset that are generated on each commit.
scm>                 </s>
scm>                 <s id="bazaar">
scm>                     Yes. Changesets are supported.
scm>                 </s>
scm>                 <s id="darcs">
scm>                     Yes. Changesets are supported.
scm>                 </s>
scm>                 <s id="mercurial">
scm>                     Yes. Changesets are supported.
scm>                 </s>
scm>                 <s id="monotone">
scm>                     Yes. Changesets are supported.
scm>                 </s>
scm>                 <s id="git">
scm>                     Yes, Changesets are supported, 
scm>                     and there's some flexibility in creating them.
scm>                 </s>
scm>            </compare>
scm>         </section>

[Again, Git part was re-wrapped for better readibility]

In my opition, such an _empty_ addition ("there's some flexibility in
creating them") is totally unnecessary; it adds no solid information
(what does it mean "some flexibility") and should be removed.

If it was about Git being at the heart snapshot based rather than delta
(changeset) based, then it should be reworded to make it clear 
(if deemed to be necessary).

scm>         <section id="annotate">
scm>             <title>Tracking Line-wise File History</title>
scm>             <expl>
scm>                 Does the version control system have an option to track the
scm>                 history of the file line-by-line? I.e., can it show for each line
scm>                 at which revision it was most recently changed, and by whom?
scm>             </expl>

Here it would be nice to have example of such output, but I think
everyone knows what this criterion means in the term of SCM features.

scm>             <compare>
scm>                 <s id="git">Yes. (git blame).</s>
scm>            </compare>

Perhaps we could also add that git-blame supports (if requested)
tracking changes across code movement and code copying (crossing
file boundaries if necessary, and can ignore changes in whitespace.
And there is also "pickaxe" search, which can find deleted contents,
which is one of major limitations of usability of line-wise file
history (line provenance) annotations.

On the other hand because Git is based towards whole project history,
and not per file history, git-blame is slow.  To migitate that there
is incremental blame mode used to reduce latency in graphical blame
viewers like "git gui blame", contrib/blameview, or the one in QGit.


scm>     <section id="features">
scm>         <title>Features</title>
scm>         <section id="work_on_dir">
scm>             <title>Ability to Work only on One Directory of the Repository</title>
scm>             <expl>
scm>                 Can the version control system checkout only one directory of
scm>                 the repository? Or restrict the check-ins to only one 
scm>                 directory?
scm>             </expl>

This is combination of "restricted check-ins" and so called "partial
checkout", or "sparse checkout", or "narrow checkout".

scm>             <compare>
scm>                 <s id="bazaar">For checkouts: No. For checkins: Yes.</s>
scm>                 <s id="darcs">
scm>                     It is possible to commit only a certain directory. 
scm>                     However, one must check out the entire repository as a
scm>                     whole.
scm>                 </s>
scm>                 <s id="mercurial">
scm>                     It is possible to commit changes only in a subset of the
scm>                     tree. There are plans for partial checkouts.
scm>                 </s>
scm>                 <s id="monotone">
scm>                     It is possible to commit changes only in a subset of the
scm>                     tree. However, one must extract the entire tree to work
scm>                     on it.
scm>                 </s>

scm>                 <s id="git">
scm>                     No.  However, commits could be restricted somewhat,
scm>                     see the "Repository Permissions".
scm>                 </s>

I think (depending of course on "Repository Permissions" part) that the
part about 'work_on_dir' for checkins should be made more clear.  Note
also that for this criterion, for distributed version control systems,
one should consider difference between comitting changes (pre-commit
hook), and publishing changes (update and post-receive hook).

I would also add that "There are plans for partial checkout" (or rather
"sparse" checkouts), where "plans" for this mean "preliminary work".
Although implementing this idea seems stalled a bit.  I guess that when
Git acquires ability to do sparse checkout, it would have it done
correctly (c.f. git submodules and svn:externals).


scm>         <section id="tracking_uncommited_changes">
scm>             <title>Tracking Uncommited Changes</title>
scm>             <expl>
scm>                 Does the software have an ability to track the changes in the
scm>                 working copy that were not yet committed to the repository?
scm>             </expl>

This also should be made more clean.  Does it mean for example ability
to tell which files have changed, or ability to diff working copy to
either last comitted changes, or to any revision available in repository?

scm>             <compare>
scm>                 <s id="cvs">Yes. Using cvs diff</s>

scm>                 <s id="git">
scm>                     Yes.

"Using git diff"?  The problem is with [possible] difference between
"git diff", "git diff HEAD", "git diff --cached".

scm>
scm>                     Also, branches are very lightweight in Git, and
scm>                     could be considered a kind of storage for "uncommitted"
scm>                     code in some workflows.
scm>                 </s>

I'm not sure if it is worth mentioning here _explicit_ staging area
(index) available in Git.

BTW. it would be nice if "git gui", the Git GUI distributed with Git,
had some graphical diff (and diff3) view tool.


scm>         <section id="per_file_commit_messages">
scm>             <title>Per-File Commit Messages</title>
scm>             <expl>
scm>                 Does the system have a way to assign a per-file commit message
scm>                 to the changeset, as well as a per-changeset message?
scm>             </expl>
scm>             <compare>
scm>                 <s id="git">No. Commit messages are per changeset.</s>
scm>            </compare>
scm>         </section>
scm>     </section>

O.K.

By the way, does anybody know what happened to the 'commit annotations',
aka 'notes' idea?


scm>     <section id="technical_status">
scm>         <title>Technical Status</title>
scm>         <section id="documentation">
scm>             <title>Documentation</title>
scm>             <expl>
scm>                 How well is the system documented? How easy is it to
scm>                 get started using it?
scm>             </expl>
scm>             <compare>
scm>                 <s id="git">
scm>                     Medium. The short help is too terse and obscure.
scm>                     The man pages are extensive, but tend to be confusing.
scm>                     The are many tutorials.
scm>                 </s>
scm>             </compare>
scm>         </section>

That of course depends on your opinion.  I would say "Good", now that
there is "Git User's Manual" distributed with Git, and now that there
started semi-official "Git Community Book" (http://book.git-scm.com).

[Perhaps we could use some survey results do defend that fact.]


scm>         <section id="ease_of_deployment">
scm>             <title>Ease of Deployment</title>
scm>             <expl>
scm>                 How easy is it to deploy the software? What are
scm>                 the dependencies and how can they be satisfied?
scm>             </expl>
scm>             <compare>
scm>                <s id="git">
scm>                    Good.  Binary packages are available
scm>                    for modern platforms.  C compiler and Perl are
scm>                    required. Requires Cygwin on Windows, and has some
scm>                    UNIXisms.
scm>                </s>
scm>            </compare>

On one hand there are are still a few important Git commands like
git-am (for patch+email based workflows), git-bisect, git-pull,
git-rebase[1], git-stash and internal parts of git-merge[2] which do
require POSIX shell, and what is inherent in shell scripting some core
utilities like grep, sed, cat; also for some workflows ssh is needed.
This is gets reduced bit by bit due to builtinification efforts.

On the other hand thanks to msysGit project Git does not require Cygwin
to be installed on MS Windows.

I would also remove "has some UNIXisms" which doesn't bring IMVHO
any information.

[1] This I hope would change thanks to builtin git-sequencer from GSoC
    (or rather post-GSoC work).
[2] This I hope would change thanks to post-GSoC expansion on 
    builtin git-merge


scm>         <section id="command_set">
scm>             <title>Command Set</title>
scm>             <expl>
scm>                 What is the command set? How compatible is it with
scm>                 the commands of CVS (the current open-source defacto
scm>                 standard)?
scm>             </expl>

Sidenote: I'm not sure if CVS is still "defacto standard"; additionally
distributed SCM have enable vastly different workflows, so it is hard
to compare their command set to that of CVS, and such comparison covers
only subset of DSCM commands.

scm>             <compare>
scm>                 <s id="subversion">
scm>                     A CVS-like command set which is easy to get used to
scm>                     for CVS-users.
scm>                 </s>
scm>                 <s id="bitkeeper">
scm>                     A CVS-like command set with some easy-to-get-used-to
scm>                     complications due to its different way of work and 
scm>                     philosophy.
scm>                 </s>
scm>                 <s id="bazaar">
scm>                 <s id="mercurial">
scm>                 <s id="monotone">
scm>                     Tries to follow CVS conventions, but deviates
scm>                     where there is a different design.
scm>                 </s>
scm>                 <s id="perforce">
scm>                     Very extensive but not compatible with CVS.
scm>                 </s>

scm>                 <s id="git">
scm>                     Command set is very feature-rich,
scm>                     and not compatible with CVS.
scm>                 </s>

I wouldn't say that situation with Git is different from situation with
Mercurial, Bazaar-NG and Monotone, especially with respect to subset of
commands which have equivalents in CVS.  Although Git doesn't "try to
follow CVS conventions", it does follow BitKeeper convention, then by
transitive also CVS conventions.  I would agree with "feature-rich"
comment, though ;-)


scm>         <section id="networking">
scm>             <title>Networking Support</title>
scm>             <expl>
scm>                 How good is the networking integration of the system?
scm>                 How compliant is it with existing protocols and infra-structure?
scm>             </expl>
scm>             <compare>
scm>                 <s id="bazaar">
scm>                     Excellent. Works natively over HTTP (read-only),
scm>                     FTP and SFTP without having Bazaar installed at
scm>                     the remote end.  Works over HTTP, SSH and a custom
scm>                     protocol when talking to a remote Bazaar
scm>                     server. Supports RSYNC and WebDAV (experimental)
scm>                     through plugins.
scm>                 </s>
scm>                 <s id="mercurial">
scm>                     Excellent.  Uses HTTP or ssh.  Remote access also
scm>                     works safely without locks over read-only network
scm>                     filesystems.
scm>                 </s>
scm>                 <s id="git">
scm>                     Excellent.  Can use native Git protocol,
scm>                     but works over rsync, ssh, HTTP and HTTPS also.
scm>                 </s>

It could be written differently, but O.K.


scm>         <section id="portability">
scm>             <title>Portability</title>
scm>             <expl>
scm>                 How portable is the version-control system to various 
scm>                 operating systems, computer architectures, and other
scm>                 types of systems?
scm>             </expl>
scm>             <compare>
scm>               <s id="git">
scm>                  The client works on most UNIXes, but not on native
scm>                  MS-Windows. The Cygwin build seems to be workable, though.
scm>               </s>
scm>             </compare>
scm>         </section>
scm>     </section>

"Most UNIXes" (or is it Unices)?  On what modern UNIX Git doesn't work?

Again, the author of of entries for Git doesn't seem to know about
msysGit project, which is native MS Windows implementation (utilizing
MSYS / MinGW).  And what does "Cygwin build _seems_ to be workable"
mean?

The entry for Git lacks also single word descriptions, like "Excellent",
"Very good", "Good", "Medium", that most other SCM have in this part
(and "Windows only" for some).


scm>     <section id="user_interaces">
scm>         <title>User Interfaces</title>
scm>         <section id="web_interface">
scm>             <title>Web Interface</title>
scm>             <expl>
scm>                 Does the system have a WWW-based interface that can be
scm>                 used to browse the tree and the various revisions of the
scm>                 files, perform arbitrary diffs, etc?
scm>             </expl>
scm>             <compare>
scm>                 <s id="git">
scm>                     Yes.  Gitweb is included in distribution.
scm>                 </s>
scm>             </compare>
scm>         </section>

For other SCMs there are listed many different web interfaces.
So I would perhaps put here a list, like in
  http://git.or.cz/gitwiki/InterfacesFrontendsAndTools#head-e5a6762d6aed31c5a2034d52c1733ead46402c31

(There is slight problem with Gitweb, which has neither homepage nor
separate repository; we can use Gitweb page on Git Wiki, or README
from git.git repository via gitweb ;-).


scm>         <section id="availability_of_guis">
scm>             <title>Availability of Graphical User-Interfaces.</title>
scm>             <expl>
scm>                 What is the availability of graphical user-interfaces for
scm>                 the system? How many GUI clients are present for it?
scm>             </expl>
scm>             <compare>
scm>                 <s id="git">
scm>                     Gitk is included in distribution.  
scm>                     QGit and Git-gui tools are also available.
scm>                 </s>
scm>            </compare>
scm>         </section>
scm>     </section>

git-gui is _also_ included in distribution. So I would say:

                 <s id="git">
                     Gitk and git-gui are included in distribution.  
                     <a href="[1]">Other tools</a> are also available.
                 </s>

[1] http://git.or.cz/gitwiki/InterfacesFrontendsAndTools#head-cee25e252efc24b245482fe9fa8d24ff5d5af1d6


scm>     <section id="license">
scm>         <title>License</title>
scm>         <expl>
scm>             What are the licensing terms for the software? 
scm>         </expl>
scm>         <compare>
scm>             <s id="git">GNU GPL v2 (open source).</s>
scm>         </compare>

O.K.

-- 
Jakub Narebski
Poland
