Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 269DB6FA5
	for <git@vger.kernel.org>; Sat, 11 Nov 2023 05:47:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Yy8IFXQg"
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38059D55
	for <git@vger.kernel.org>; Fri, 10 Nov 2023 21:47:43 -0800 (PST)
Received: by mail-lj1-x22e.google.com with SMTP id 38308e7fff4ca-2c51682fddeso41622061fa.1
        for <git@vger.kernel.org>; Fri, 10 Nov 2023 21:47:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699681661; x=1700286461; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R7kW+SHjFHMdIKQTCQCWH0v+OycMUdB0EEEMEGQOIPY=;
        b=Yy8IFXQgM+x5iONCcr5TqLsIaJppjGGLaYKYOYiowrchHaRr9RrrzBM3jdpZomCxbY
         3lS0dKLUwHkBg76sT6Lz4h1UsCRAF01Ep6WiRujZmdQa1pCyoJOkpHKvUUUlmXI5LQWd
         sfGKvYYgSqMsbscZr0n6n78ZWsqotqt5SxPMiXYUoZlG1hkq6rU+PfnwPxVJozatG+jo
         jQGV2QUcppKkTBeUKNxm/7jSuugFJcB6CUF3fs7iUyAf5MMOjWH/tX9Y7kcVJ8ck64xQ
         NGJHGcv2rE2Nn7iLFll4/LJWPTUO4zPBOT51TLQHzWwPWoJlhQUr9vBBVD4ELzeD1Vjm
         y1Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699681661; x=1700286461;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=R7kW+SHjFHMdIKQTCQCWH0v+OycMUdB0EEEMEGQOIPY=;
        b=itQXRVBoFyyoixgkpL9nqebZ4SBcrAD/9o9KF9meJnxvfVqrP9q8PPSOkHyIsNObp+
         qdH8exxVRatJ0iHwyY8kOzBo6PCTdSuihlR4dv2IVMrZJflXJaxHAnbaU0Hj6y6Xxin2
         NiDp3GsKZzyxVuChFYwm6hulB9Jxhf3uzANYuNXrfwU2eI7ymbb/sbCaIUiFnJSt8K7m
         AIAZQCzVdZKXHjZQVyyd0jB9G4TpvTz8ZTXTOS6DQ3znTodpbX8lLj78yVWRnW8UAkmz
         m4KL9JCi+Yc9AaYr4WdbRmfZ7XgnElLajBMr08j+W6PjDIYLV0eMeIYCVQ4vzrocD+JN
         P1uA==
X-Gm-Message-State: AOJu0YwmjnacWIbWtj8+zuRIAhgUj8QXdA7owAvL9Pwj/jWn+YjLEbu5
	mjo7jWkgqcG32Cco/IYaa0ushRGuxlTjkDjCQ/od2z0ZcxI=
X-Google-Smtp-Source: AGHT+IHmAql5B15KuZ3MZm1WymZLWGasAvR0BKRksD3pmyqiaYR1GzUjWB12MY2CcWbw7MbswqcRcZ5tyT/pvGazdp0=
X-Received: by 2002:ac2:490a:0:b0:509:39fa:90d5 with SMTP id
 n10-20020ac2490a000000b0050939fa90d5mr1413088lfi.26.1699681661021; Fri, 10
 Nov 2023 21:47:41 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <LO6P265MB6736043BE8FB607DB671D21EFAAAA@LO6P265MB6736.GBRP265.PROD.OUTLOOK.COM>
 <CABPp-BHYaxa7QoXabM=7hW-93hQLK-=KayGtDHtWxxdAnJCcJw@mail.gmail.com> <LO6P265MB6736F5F9E8368A9DE95D294FFAA9A@LO6P265MB6736.GBRP265.PROD.OUTLOOK.COM>
In-Reply-To: <LO6P265MB6736F5F9E8368A9DE95D294FFAA9A@LO6P265MB6736.GBRP265.PROD.OUTLOOK.COM>
From: Elijah Newren <newren@gmail.com>
Date: Fri, 10 Nov 2023 21:46:00 -0800
Message-ID: <CABPp-BHEX+SyophEfgRqDbNdrAS3=bptt_cKzHLBSutnBAxexw@mail.gmail.com>
Subject: Re: Git Rename Detection Bug
To: Jeremy Pridmore <jpridmore@rdt.co.uk>
Cc: "git@vger.kernel.org" <git@vger.kernel.org>, Paul Baumgartner <pbaumgartner@rdt.co.uk>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Jeremy,

On Fri, Nov 10, 2023 at 3:28=E2=80=AFAM Jeremy Pridmore <jpridmore@rdt.co.u=
k> wrote:
>
> Hi Elijah,
>
> Many thanks for your reply, the detail is much appreciated.  I was aware,=
 from recently read articles, that git doesn't record renames as such, henc=
e my investigations into the rename detection, but I also found some intere=
sting points in your email, such as the "git status --no-renames" flag.

The fact that you were trying to "undo" renames and "redo the correct
ones" suggested there's something you still didn't understand about
rename detection, though.  The fact that you were worried that "git
status" showing the "wrong renames" and the implication that it needed
to show the right ones before you committed also suggested there's
something that was still not being understood.  Likewise, the fact
that the renames reported by "git status" change even when you haven't
renamed files further but have simply made additional changes to the
contents of some files suggests there is something that was still not
being understood about the phrase that "renames are detected rather
than recorded".

While renames are used in the merge algorithm in order to know what
files to match up for three-way content merges (so that changes from
both sides to the "same" file can be incorporated into the end
result), once the merge stops to ask you to resolve conflicts, the
detection of renames doesn't matter beyond that point.  The fact that
renames aren't recorded means whatever renames are shown is only there
as a guide to help you understand.  All that matters to Git is that
all files have the intended content.  If some of the files have the
wrong content, then by all means go and correct it.  If "git mv"
commands help you do that, great.  If simply editing all files of
interest (including adding and deleting files) until they match the
expected contents works, that's fine too.  Once all files have the
correct content, commit it.  Git will have no way whatsoever of
knowing which of those two routes you picked, and won't behave any
differently in the future based on which way you ended up with the
right contents in each file.  You could have even done the extreme of
"git merge -s ours --no-commit ${OTHER_BRANCH}" (merge the other
branch but completely ignore *every* change the other side made and
then stop for user to make further changes), followed by opening and
editing every relevant file to include changes made by the other side,
deleting and adding files as relevant, to end up with the right
contents in all files and then committed, and Git wouldn't know the
difference and no one who pulled your merge commit would be able to
tell the difference either.

> I think the issue I'm encountering is described by what you say here:
> "Exact renames are detected first, before any other method of rename
> detection is employed, and other than giving a preference to files
> with the same basename, if there are multiple choices it just picks
> one (what I'd call at random, though technically based on what the
> internal processing order happens to be)"
>
> That is close to the behaviour I'm seeing.  As I mentioned, git seems to =
think a file has been deleted and then as it continues to detect renames, i=
t's as if it is going through lists of "Local-Base" and "Base-Remote" chang=
es trying to match them up, but the directories of the files being matched =
are "offset", as highlighted by this list of mismatches:
>
> (I'd put the paths in a table for easier analysis, but for some reason th=
e emails need to be plain text)
> > Incorrect path match: Landscape/Deployment/PowershellScripts/pre-req/Rd=
t.BatchProcessingService.Setup/pre-req.ps1 -> Landscape/src/Deployment/Powe=
rshellScripts/pre-req/Landscape.Net/pre-req.ps1
> > Incorrect path match: Landscape/Deployment/PowershellScripts/pre-req/Wo=
rkflow/pre-req.ps1 -> Landscape/src/Deployment/PowershellScripts/pre-req/Rd=
t.BatchProcessingService.Setup/pre-req.ps1
> > Incorrect name match: Landscape/Documentation/Rdt.Documentation.UI/Prop=
erties/licenses.licx -> Landscape/src/Deployment/PowershellScripts/pre-req/=
Workflow/pre-req.ps1
> > Incorrect path match: Landscape/Documentation/uiDocumentation/licenses.=
licx -> Landscape/src/Documentation/Rdt.Documentation.UI/Properties/license=
s.licx
> > Incorrect path match: Landscape/Import/uiImport/My Project/licenses.lic=
x -> Landscape/src/Documentation/uiDocumentation/licenses.licx
> > Incorrect path match: Landscape/Main/uiMain.Workflow/My Project/license=
s.licx -> Landscape/src/Import/uiImport/My Project/licenses.licx
> > Incorrect path match: Landscape/Main/uiMain/My Project/licenses.licx ->=
 Landscape/src/Main/uiMain.Workflow/My Project/licenses.licx
>
> Given git compares both the content and the directory\filenames,

For exact renames, it only will look at filenames if there are
multiple 100% matches.  If one match is 100%, and the other 99.9999%
match, the 100% match is taken.

(Since we think that exact renames seem to be describing your problem,
there's no point discussing the inexact rename handling.)

> and as the repositories have unrelated histories,

What do you mean by this?  If there's no common point in history (i.e.
no merge base), rename detection doesn't even get invoked, so you must
mean something different by this phrase than what I would normally
take it to mean.

Any chance, if you're still in the middle of the merge, that you could run
   git merge-base --all HEAD MERGE_HEAD
and report the output?  It'll be commit hashes that don't mean a lot
to anyone who doesn't have your repository, but I'm interested in how
many commit hashes it responds with (0, 1, or more than 1).

> the "Base" file is going to be empty, therefore, even if Local and Remote=
 are identical, they are both 100% different to Base.

I assume by "Base" you are referring to the commit in history common
to both branches being merged (i.e. what we call the "merge base"), or
to the relevant file from that commit.  Is that right?

Even if I'm right about that, this comment has me lost.  Could you
clarify it, with one particular example?  For example (I'm making
stuff up since I'm not familiar with your repo, but showing how to
clarify for a given set of path(s)):

   * In this repository, with the renames detected above,
Landscape/Main/somefile.licx is an empty file in the merge base.
   * On my local side, I renamed Landscape/Main/somefile.licx to
Landscape/src/Main/somefile.licx and populated it with some content
(with hash A).  There is also another new file on the local side (at
least new relative to the merge base) named
Landscape/src/Other/somefile.licx that happens to have hash A.
   * On the remote side, Landscape/Main/somefile.licx was left in
place but populated with some content (with hash A).
   * Git is detecting the rename as Landscape/Main/somefile.licx ->
Landscape/src/Other/somefile.licx, when I wanted it to detect a rename
to Landscape/src/Main/somefile.licx.

I'm pretty sure this example is not what you're seeing, even if
components of it are, because the empty file thing is impossible with
the rest of the story.

>  That given, I'm not sure why git would state that Landscape/Documentatio=
n/Rdt.Documentation.UI/Properties/licenses.licx and Landscape/src/Deploymen=
t/PowershellScripts/pre-req/Workflow/pre-req.ps1 are a "both added" conflic=
t given their file names and paths are completely different.  Any ideas?

The fact that Landscape/Documentation/Rdt.Documentation.UI/Properties/licen=
ses.licx
is marked as "both added" means that this file
   * did not exist in the merge base
   * did exist on your local side
   * did exist on the remote side
   * the version of this file on the local and remote sides do not match
Basically, both sides added a new file and they are not the same, so
you have a conflict.

The answer for Landscape/src/Deployment/PowershellScripts/pre-req/Workflow/=
pre-req.ps1,
is an identical set of bullet points; it was a file added by both
sides of history that did not exist in the merge base, and the sides
are different so you have a conflict in this file too.

> I wrote a script to resolve the conflicts best I can which categorises th=
e files into sets according to the file status (i.e. "added by them", "adde=
d by us" etc), and then either does a "git checkout head --
<file>" or a "git rm <file>" based upon which set the file is in and
whether it is in another set or not.  This has worked really well and
helped me through the large changeset with 3k conflicts.

So, you're simply throwing away the changes made by the remote side?
I mean, that's one way to merge, and it might be right in your case,
but to someone unfamiliar with your repo it smells like a hack to just
ignore conflicts and throw away other people's changes in order to
complete the merge.

> As git only needs to try and match files in the "deleted by us" and "dele=
ted by them" sets (although including the "deleted in both" set would allow=
 matching renames/moves on both sides),

"deleted by us" and "deleted by them" means no rename was detected for
the file (at least on the side that the delete is reported for).  So,
a "deleted in both" only happens when neither side detects a rename,
and if the file isn't renamed on either side and both removed it, then
there's no conflict -- just delete the file.

>  an idea for a potential improvement to the matching algorithm (where you=
 say there's a comment "too many alternatives, pick one") could be to compu=
te a "difference value" for the path\filename of those files in one of the =
other sets (i.e. "added by us", "added by them" or "added in both"), and ch=
ose a potential rename based upon the smallest calculated difference.  The =
difference value would be the number of differences in folder names, e.g.
>
> deleted in both: Landscape/Deployment/PowershellScripts/pre-req/Rdt.Batch=
ProcessingService.Setup/pre-req.ps1
>
> added in both: Landscape/src/Deployment/PowershellScripts/pre-req/Landsca=
pe.Net/pre-req.ps1
> (path\name difference =3D 2)
> added in both: Landscape/src/Deployment/PowershellScripts/pre-req/Rdt.Bat=
chProcessingService.Setup/pre-req.ps1
> (path\name difference =3D 1)
> added in both: Landscape/src/Deployment/PowershellScripts/pre-req/Workflo=
w/pre-req.ps1
> (path\name difference =3D 2)
>
> So, given the above, git would chose the second "added in both" entry.

Three problems here:

* If git were to report "deleted in both" for one path and "added in
both" in another as you suggest, that would only be because the files
are dissimilar.  Not only would they not be an exact match, their
contents would have less than 50% similarity.  Thus augmenting exact
matching like this just wouldn't work, because the files aren't
matches at all.  The only correct thing to do would be to not report
the "deleted in both" because that file is not a rename of anything
else and has simply been deleted by both sides.

* filename similarity is extraordinarily expensive compared to exact
renames, and if not carefully handled, can sometimes rival the cost of
file content similarity computations given our spanhash
representations.  Exact renames are tasked with finding renames even
if they are known to not be relevant, simply because exact renames can
do so very quickly.  If we change that, we throw a monkey wrench in
our performance handling elsewhere and have to rethink a number of
other things.

* While I was optimizing rename detection while investigating the new
merge backend, I actually attempted a few versions of filename
similarity looking for something that was predictive and useful.
While I think the idea was potentially helpful for some repositories,
it has a significant risk of hurting merges in other repositories.
While what I tried was far from an exhaustive checking of all filename
similarity ideas, I came away doubting there was a useful heuristic
other than exact matches of basenames (i.e. exact matches of
everything in the filename after the final slash).  If someone else
wants to try more ideas, and do a study on various existing
repositories, they can go ahead, but I suspect most work here is going
to end up at a dead end and I'm unwilling to put further time of my
own into it.

> Food for thought?  Happy to discuss the idea further.

So, I've occasionally seen repositories that have something like the follow=
ing:

  * base version: directory named library-x-1.7/
  * stable branch: many changes to files under library-x-1.7/
  * development branch: library-x-1.7/ no longer exists.  However,
library-x-1.8/ and library-x-1.9/ both do.  Both are obviously
"similar" to library-x-1.7/ but both have many changes.

What happens when someone tries to merge the stable branch into the
development branch?  There are two obvious guesses:

  * Changes from library-x-1.7/ on the stable branch are applied to
library-x-1.8/
  * Changes from library-x-1.7/ on the stable branch are applied to
library-x-1.9/

Either answer can be suboptimal depending on your viewpoint.
(Applying the changes to both directories would also have other
suboptimal effects even if it might sound right based for this exact
problem as I've worded it.  But git doesn't do copy detection as part
of merges so Git won't choose this third choice ever.)  So, which of
those two happens?  Well, since renames are detected based upon file
similarity, the changes will go to whatever file is most similar.
What does that mean?  It means that both answers above are wrong.
Instead:

  * Some of the changes from library-x-1.7/ on the stable branch are
applied to files from library-x-1.8/, while others are applied to
files from library-x-1.9/, and to determine which files from which
directory are matched up is an individual file choice based on which
file in library-x-1.8/ or library-x-1.9/ is most similar to the file
from the base version in library-x-1.7/.

This answer is clearly worse than either of the two above, and is
virtually never what people would want.  But it's also fundamental to
the idea of matching up files and detecting renames individually based
upon file similarity.  It's part of both the old and new merge
backends in Git, because both were based upon this fundamental idea.

So, if you have this kind of situation, or even something like it
where files from one old directory could match files from multiple
other directories, it's just something you have to be aware of.

All that said, here's something that might help:

*** Hack to workaround rename detection in special cases where there
are directories of multiple possible matches ***

1. Get back to a clean slate from before the merge.

$ git merge --abort
OR
$ cd ${OTHER_DIRECTORY} && git clone ${url} && cd ${REPONAME} && git
checkout ${relevant_branch}

2. Temporarily undo your local renames and make a temporary commit

$ git mv Landscape/src/* Landscape/
$ git commit -m "TEMPORARY COMMIT"

3. Perform the merge (files will be in Landscape/ instead of
Landscape/src/ for now).  Don't worry, we'll fix the merge commit
later.

$ git merge ${REMOTE_BRANCH}
[...fix up any conflicts and commit, if needed...]

4. Rename Landscape/ back to Landscape/src/ and make another (temporary) co=
mmit.

5. Create a corrected merge commit with the current tree, the commit
message from your merge commit, and the correct parents:
$ git commit-tree -p HEAD~3 -p HEAD~1^2 -F $(git log -1 --format=3D%B
HEAD~1) HEAD^{tree}
[...the above command will print out a new commit id for a corrected
merge commit.  You can inspect it first, but we just need to pass this
to reset --hard...]

6. Reset your branch to this corrected merge commit (which will orphan
the temporary commits from steps 2, 3, and 4 so they can later be
garbage collected)
$ git reset --hard [...output of commit-tree command...]


Hope that helps,
Elijah
