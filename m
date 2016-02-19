From: Thomas Gummerer <t.gummerer@gmail.com>
Subject: Re: GSoC 2016: applications open, deadline = Fri, 19/2
Date: Fri, 19 Feb 2016 12:46:57 +0100
Message-ID: <20160219114657.GG1831@hank>
References: <vpqoabox66p.fsf@anie.imag.fr>
 <20160217172407.GD1831@hank>
 <448280D1-3EEB-40DF-9886-C9B620E32E3C@gmail.com>
 <vpqh9h7f9kz.fsf@anie.imag.fr>
 <1CE3F5E2-DDCC-4F1B-93CF-1A4A194650BF@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	git <git@vger.kernel.org>, Jeff King <peff@peff.net>,
	Christian Couder <christian.couder@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Stefan Beller <sbeller@google.com>
To: Lars Schneider <larsxschneider@gmail.com>
X-From: git-owner@vger.kernel.org Fri Feb 19 12:46:43 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aWjWC-0004q6-Pk
	for gcvg-git-2@plane.gmane.org; Fri, 19 Feb 2016 12:46:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946888AbcBSLqh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Feb 2016 06:46:37 -0500
Received: from mail-wm0-f51.google.com ([74.125.82.51]:35597 "EHLO
	mail-wm0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1946065AbcBSLqf (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Feb 2016 06:46:35 -0500
Received: by mail-wm0-f51.google.com with SMTP id c200so71620929wme.0
        for <git@vger.kernel.org>; Fri, 19 Feb 2016 03:46:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=yQ2Z2i+I6MPIn2/ou5KJ6xGN98y666WfVsTvsLWaEhw=;
        b=xHjHPUJgtn8DcT2Sw6jrGEhjHPHTpnwdgOSA/i4jQ05xrzBKFTTe5rWym6VFs23Cwh
         PpQ418iJYV1un9nO1ET/KHnAsh+5lsuPwSnDJAMcHj0COhCEPDnnikFLUR3D1EjNHb22
         dw7s4KCrq4/LMv42PGuTKPPt1sCNdv/gs+VQ4XJtayoAo+W0P63BCaf0Q9UNkAfE76wy
         x6SONScbyfspzdH32QALUU9VxG1BUiROWlhdWjsKRt6ucN0W0v+KN8V5jxtQfOW0udEm
         NM/24ysVMXvnQdKt/K0f6Tx7GeJCM+0xT5WVuCmN/s3QFvYSB7Xh593wcaGqW0bSwd7x
         CfmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=yQ2Z2i+I6MPIn2/ou5KJ6xGN98y666WfVsTvsLWaEhw=;
        b=PdNdHegrPp8ZDRvb/bJeSkmTEn0taEzgRiKAt2p2Pc8F0YXJFgZ/ZSXbN3EmCeerna
         YTt6pUXHN+RoFf2DXZvBveEzxDR2fgBxcK9eS74o7OgRG/Iat3lUGQlPPioI4GR9hOdI
         sCjNmeTiDkSRpvw8ZCNDpz1kNeYXuyZY6da12CEHdbhxCHEjrCcjSPv8bAmehdnDHMBZ
         IfRUiNgN7OonqebFF5HuUZKnwiXY4fmCT1HEv49jdlZNpLAoTl1RynjYxmONM87/KNk/
         EPvXTymzdb05El5kwgCNO0a0XMKBKb+Mmdu8xmRw8Y4JcFoNQlNXvDal1k3bu1DrvPoZ
         nRrw==
X-Gm-Message-State: AG10YOTDKAGZ0HTWsvvyUPKO8ac3yAlBm8ACbL7u6PY1q2mEZ9QEjVWtRfaZ4d74y7VPFQ==
X-Received: by 10.28.224.87 with SMTP id x84mr9160819wmg.32.1455882394092;
        Fri, 19 Feb 2016 03:46:34 -0800 (PST)
Received: from localhost (host57-106-dynamic.25-79-r.retail.telecomitalia.it. [79.25.106.57])
        by smtp.gmail.com with ESMTPSA id gt7sm10926335wjc.1.2016.02.19.03.46.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 19 Feb 2016 03:46:32 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1CE3F5E2-DDCC-4F1B-93CF-1A4A194650BF@gmail.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286708>

On 02/18, Lars Schneider wrote:
>
> On 17 Feb 2016, at 19:58, Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> wrote:
>
> > Lars Schneider <larsxschneider@gmail.com> writes:
> >
> >> Coincidentally I started working on similar thing already (1) and I have
> >> lots of ideas around it.
> >
> > I guess it's time to start sharing these ideas then ;-).
> >
> > I think there's a lot to do. If we want to push this idea as a GSoC
> > project, we need:
> >
> > * A rough plan. We can't expect students to read a vague text like
> >  "let's make Git safer" and write a real proposal out of it.
> >
> > * A way to start this rough plan incrementally (i.e. first step should
> >  be easy and mergeable without waiting for next steps).
> >
> > Feel free to start writting an idea for
> > http://git.github.io/SoC-2016-Ideas/. It'd be nice to have a few more
> > ideas before Friday. We can polish them later if needed.
>
> I published my ideas here:
> https://github.com/git/git.github.io/pull/125/files

Sorry for posting my idea so late, but it took me a while to write
this all up, and life has a habit of getting in the way.  My idea goes
into a different direction than yours.

I do like the remote whitelist/blacklist project.

Junio pointed out to me off list that this is to complicated for a
GSoC project.  I kind of agree with that, but I wanted to see how this
could be split up, to completely convince myself as well.  And indeed,
the more I think about it the more risky it seems.

Below there are some thoughts on a potential design, in case someone
is interested, no code to back any of this up, sorry.

Everything proposed below should be hidden behind some configuration
variable, potentially one per command (?)

- start with git-clean.  It's well defined which files are cleaned
  from a repository when running the command.  Add them to a commit on
  the tip of the current branch.

  Start a new branch (or use the existing one if applicable) in
  refs/restore/history, and add a commit including a notes file.  The
  commit message contains the operation that was executed (clean in
  this case), and the hash of the commit we created which includes the
  cleaned files.

  Add a note to the commit, detailing from which command we come from,
  which files we added (not strictly necessary, as we can infer it
  from the parent commit).

  Useful in itself as the user can recover the files manually if
  needed, and can be sent as separate patch series.

  Potential problems:  Git has no way to track directories.  This can
  be mitigated by keeping the list of directories in the attached
  note.

- add a git recover command.  The command looks at This would look like `git recover
  <commit>`, where commit is the hash of the commit we saved before.

  This works by reading the note attached to the commit, figuring out
  which command was run before, and restoring the state we were in
  before.

  Potential problems: conflicts, but I think this can be solved by
  simply erroring out, at least in the first iteration.

- the next command could be git mv -f, git reset -f and friends.  It
  gets more tricky here, as we'll have to deal with the state of the
  files in the index.

  Analogous to git clean, the changes in the working tree are all
  staged and added to a new commit on the tip of the current branch.

  The note on this commit needs to contain the necessary data to
  rebuild the state in the index.  The format is more closely
  specified below.  We also need the corresponding changes in the
  git restore command.

  Restored files will be written to disk as racily smudged, so the
  contents are checked by git, as we lost the meta-data anyway.  This
  comes at a slight performance impact, but I think that's okay as we
  potentially saved the user a lot of time re-doing all the changes.

- git branch/tag --force.  Store the name and the old location of the
  branch in refs/restore/history.  There are no files lost with this
  operation, so no additional commits as for git clean or git reset
  etc. are needed.  The format of the commit depends on the exact
  operation that was forced, for exact format see below.

This treatment can't make all operations safe.  Any operation that
touches the remote is hard to undo as some users already might have
fetched the new state of the remote (e.g. git push -f).  Others such
as git-gc will inevitably delete information from the disk, but
changing that

There's more, but I don't think just writing up all commands without
any code would make any sense.

Formats:
- commits in refs/restore/history:
empty commits with the following commit message format for git-clean
and git-reset and friends:
$versionnumber\n
$command\n
$branchname\n
$sha1ofreferencedcommit\n

empty commits with the following commit message format for git branch
and friends
$versionnumber\n
$command\n (this includes the exact operation that was forced
(e.g. move, delete etc.)
$branchname\n
$sha1ThatWasReferencedByTheBranch\n
$overwrittenbranchname\n (this and the sha1 below are only used for
--move)
$sha1ReferencedByOverwrittenBranch\n

- notes file: The format can be different for different commands, as
  they all have different needs

  - git clean:
    list of affected files and directories separated by '\0'.
    I think we could get away with only the directories, but adding
    the filenames as well might make the recovery part simpler.

  - git reset, etc.:
    the following info is stored for each file that is modified by the
    original command.

    32-bit signature
    32-bit number of index entries
    32-bit mode (object type + unix permissions)
    160-bit SHA-1
    16-bit flags (extra careful here what we want to do with the
                  assume valid flag)
    path name (variable length)

    resolve-undo extension (same format as in the index)

Alternatives:
- Have a history for each branch in refs/restore/$branchname.
  * Advantages:
    Each branch has its own history, which can lead to fewer conflicts
    when restoring (e.g. user uses `git reset --hard` on one branch,
    switches to another branch works (potentially adds more stuff to
    this branch), later goes back to the old branch and discovers `git
    reset --hard` was actually the wrong thing to do and would like
    the data back.
  * Disadvantages:
    It is harder for the user to intuitively know what git restore
    will do exactly.
    It's much more limited when we want to extend it to branch
    removals, etc.

- Storing additional information in the refs/restore/history ref
  * Advantages:
    No need for extra notes
  * Disadvantages:
    Data doesn't get garbage collected without user interaction,
    potentially blowing up the repository size.  Especially using `git
    clean`, where binary files might be involved.

- Store the whole index in the note
  * Advantages:
    Simpler way of restoring the index (including all of the
    extensions)
  * Disadvantages:
    Need to take care of both the index and the split index.
    Will consume a lot more disk space in the normal case (only a few
    of the files in the repository are changed, while the majority
    remains unchanged).

- Store the changed files in refs/restore/history instead of a new
  commit on the tip of the current branch.
  * Advantages:
    All the information is in one place.
    Data will not be garbage collected.
  * Disadvantages:
    Data will not be garbage collected. (Repository size is probably
    going to blow up after a while)
    It takes more effort to find the parent and diff against it.
