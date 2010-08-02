From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH] Documentation: flesh =?utf-8?Q?out?=
	=?utf-8?B?IOKAnGdpdCBwdWxs4oCd?= description
Date: Mon, 2 Aug 2010 16:39:30 -0500
Message-ID: <20100802213930.GA3506@burratino>
References: <20100801025439.GA9592@burratino>
 <7vbp9lprcs.fsf@alter.siamese.dyndns.org>
 <201008021434.13748.trast@student.ethz.ch>
 <7v7hk9p2f4.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Thomas Rast <trast@student.ethz.ch>, git@vger.kernel.org,
	=?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
	Geoff Russell <geoffrey.russell@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Aug 02 23:40:57 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Og2kh-0003XM-4m
	for gcvg-git-2@lo.gmane.org; Mon, 02 Aug 2010 23:40:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754140Ab0HBVku convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 2 Aug 2010 17:40:50 -0400
Received: from mail-qw0-f46.google.com ([209.85.216.46]:42337 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752969Ab0HBVkt (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Aug 2010 17:40:49 -0400
Received: by qwh6 with SMTP id 6so1881421qwh.19
        for <git@vger.kernel.org>; Mon, 02 Aug 2010 14:40:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=Y+K5M/E3QmjCV89amcBUqd0DRElwAKP8q791t/zxs2U=;
        b=r/7v5i9J6Zf4yqAVxk7tUUQGXV0sbB8MjceqGSNFLzTk66r5zScPOFWovrUe4hQzOB
         JPkVBSagT+oIf7GXXilZ36TL5HX43rPba7yXxU4hhWKXm5C6Ba5FM+Mr4qDS4LHC91Ut
         u5c/dfdJ/RD6JiRV+8ZZSWw/xnM/2Sn/uDdrk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=AlKJLQ7owTfUffydN/wyVxRDvoaz0CUZPiJ5z2IZOaJwUxd4hOOg3cd7FJvl9ixsjy
         ZNkvsSpcQKh5A25ZhIUKHUMlC2rOzHmF7SaRwMwFz8rD4W0ghsRwCUlN3bH3HspqtKUb
         fqVuaGwXRtE0FAdmxZrI1OYM95wfZzCXIJYh0=
Received: by 10.224.5.199 with SMTP id 7mr2167183qaw.241.1280785248235;
        Mon, 02 Aug 2010 14:40:48 -0700 (PDT)
Received: from burratino ([66.99.2.25])
        by mx.google.com with ESMTPS id w2sm602369qcq.24.2010.08.02.14.40.46
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 02 Aug 2010 14:40:47 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <7v7hk9p2f4.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152465>

The current description in the pull man page does not say much more
than that =E2=80=9Cgit pull=E2=80=9D is fetch + merge.  Though that is =
all a person
needs to know in the end, it would be useful to summarize a bit about
what those commands do for new readers.

Most of this description is taken from the =E2=80=9Cgit merge=E2=80=9D =
docs.

Now that we explain how to back out of a failed merge (reset --merge),
we can tone down the warning against that a bit.

Except, as Thomas noticed, there=E2=80=99s a risk with that because peo=
ple
might read this version of the manpage online and then conclude that
it is safe to try a merge with uncommitted changes, only to find that
their =E2=80=9Cgit reset=E2=80=9D doesn't support --merge yet.  Or wors=
e, verify that
their git-reset has --merge by a quick test (1b5b465 is in 1.6.2) but
then find that it does not help with backing out of a merge (e11d7b5
is only in 1.7.0!).  So keep the warning.

With clarifications from =C3=86var, Thomas, and Junio.

Noticed-by: Geoff Russell <geoffrey.russell@gmail.com>
Cc: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
Cc: Thomas Rast <trast@student.ethz.ch>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
Junio C Hamano wrote:

> I think the longer "In git 1.7.0 or later" with "Warning: in olden da=
ys"
> can appear in everybody's version without causing any harm.  That way=
, it
> is shown even to somebody who came to docs/v1.7.3/git-pull.html at k.=
org
> from sideways.

Ok.  Here=E2=80=99s what it looks like with that change.

 Documentation/git-pull.txt |   65 ++++++++++++++++++++++++++++++++++++=
-------
 1 files changed, 54 insertions(+), 11 deletions(-)

diff --git a/Documentation/git-pull.txt b/Documentation/git-pull.txt
index ab4de10..7e72961 100644
--- a/Documentation/git-pull.txt
+++ b/Documentation/git-pull.txt
@@ -8,29 +8,72 @@ git-pull - Fetch from and merge with another reposito=
ry or a local branch
=20
 SYNOPSIS
 --------
-'git pull' <options> <repository> <refspec>...
+'git pull' [options] [<repository> [<refspec>...]]
=20
=20
 DESCRIPTION
 -----------
-Runs 'git fetch' with the given parameters, and calls 'git merge'
-to merge the retrieved head(s) into the current branch.
-With `--rebase`, calls 'git rebase' instead of 'git merge'.
=20
-Note that you can use `.` (current directory) as the
-<repository> to pull from the local repository -- this is useful
-when merging local branches into the current branch.
+Incorporates changes from a remote repository into the current
+branch.  In its default mode, `git pull` is shorthand for
+`git fetch` followed by `git merge FETCH_HEAD`.
=20
-Also note that options meant for 'git pull' itself and underlying
-'git merge' must be given before the options meant for 'git fetch'.
+More precisely, 'git pull' runs 'git fetch' with the given
+parameters and calls 'git merge' to merge the retrieved branch
+heads into the current branch.
+With `--rebase`, it runs 'git rebase' instead of 'git merge'.
=20
-*Warning*: Running 'git pull' (actually, the underlying 'git merge')
+<repository> should be the name of a remote repository as
+passed to linkgit:git-fetch[1].  <refspec> can name an
+arbitrary remote ref (for example, the name of a tag) or even
+a collection of refs with corresponding remote tracking branches
+(e.g., refs/heads/*:refs/remotes/origin/*), but usually it is
+the name of a branch in the remote repository.
+
+Default values for <repository> and <branch> are read from the
+"remote" and "merge" configuration for the current branch
+as set by linkgit:git-branch[1] `--track`.
+
+Assume the following history exists and the current branch is
+"`master`":
+
+------------
+          A---B---C master on origin
+         /
+    D---E---F---G master
+------------
+
+Then "`git pull`" will fetch and replay the changes from the remote
+`master` branch since it diverged from the local `master` (i.e., `E`)
+until its current commit (`C`) on top of `master` and record the
+result in a new commit along with the names of the two parent commits
+and a log message from the user describing the changes.
+
+------------
+          A---B---C remotes/origin/master
+         /         \
+    D---E---F---G---H master
+------------
+
+See linkgit:git-merge[1] for details, including how conflicts
+are presented and handled.
+
+In git 1.7.0 or later, to cancel a conflicting merge, use
+`git reset --merge`.  *Warning*: In older versions of git, running 'gi=
t pull'
 with uncommitted changes is discouraged: while possible, it leaves you
-in a state that is hard to back out of in the case of a conflict.
+in a state that may be hard to back out of in the case of a conflict.
+
+If any of the remote changes overlap with local uncommitted changes,
+the merge will be automatically cancelled and the work tree untouched.
+It is generally best to get any local changes in working order before
+pulling or stash them away with linkgit:git-stash[1].
=20
 OPTIONS
 -------
=20
+Options meant for 'git pull' itself and the underlying 'git merge'
+must be given before the options meant for 'git fetch'.
+
 -q::
 --quiet::
 	This is passed to both underlying git-fetch to squelch reporting of
--=20
1.7.2.1.544.ga752d.dirty
