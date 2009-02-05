From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Comments on "Understanding Version Control" by Eric S. Raymond
Date: Thu, 5 Feb 2009 12:23:37 +0100
Message-ID: <200902051223.38992.jnareb@gmail.com>
References: <200902021948.54700.jnareb@gmail.com> <200902040304.05028.jnareb@gmail.com> <20090204235436.GA8945@mit.edu>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, "Eric S. Raymond" <esr@thyrsus.com>
To: Theodore Tso <tytso@mit.edu>
X-From: git-owner@vger.kernel.org Thu Feb 05 12:25:45 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LV2Ma-0001Oe-4w
	for gcvg-git-2@gmane.org; Thu, 05 Feb 2009 12:25:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752221AbZBELXu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Feb 2009 06:23:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751870AbZBELXt
	(ORCPT <rfc822;git-outgoing>); Thu, 5 Feb 2009 06:23:49 -0500
Received: from fg-out-1718.google.com ([72.14.220.152]:6680 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752330AbZBELXr (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Feb 2009 06:23:47 -0500
Received: by fg-out-1718.google.com with SMTP id 16so131366fgg.17
        for <git@vger.kernel.org>; Thu, 05 Feb 2009 03:23:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=D6z57x//ifCF96mvkpDTrZTcOTI/1iOchcX8eZBgFgw=;
        b=NNkcvjSk4Oh26vvVEg0gYdWtpA/anij2k6M85yVoo4EiZ5pdF/SblzjoQPmXJvW23O
         TXDYVftpex5y4aziNW61W8o+aYSOe6FSNKa5wo6pW8NMUMr1ngG+a94YYsOoYtdhqJno
         5IIv83hxi4CjisQdbNwxxNeXHy/pylDOzKGNI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=stMSvVj8QKMx9J3v6akMY12Kau7eHdpN0QIZcQL1p/IY8Vhk4cmx0S3+zc71A5imJb
         3I+5hG0lO8AGx8LnnIZmhoCZf19ZzxEYFHy5YRefVRuCKEEi/Bfk7mKVXSTmZxZ2/Cns
         A/VeL0cye81okMgwtaJ8KYMVDXCzoTHMKtxfs=
Received: by 10.86.99.9 with SMTP id w9mr266937fgb.12.1233833024297;
        Thu, 05 Feb 2009 03:23:44 -0800 (PST)
Received: from ?192.168.1.13? (abwq247.neoplus.adsl.tpnet.pl [83.8.240.247])
        by mx.google.com with ESMTPS id 3sm352675fge.32.2009.02.05.03.23.41
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 05 Feb 2009 03:23:42 -0800 (PST)
User-Agent: KMail/1.9.3
In-Reply-To: <20090204235436.GA8945@mit.edu>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108552>

On Tue, Feb 05, 2009, Theodore Tso wrote:
> On Wed, Feb 04, 2009 at 03:04:02AM +0100, Jakub Narebski wrote:

> My comments date from the very end of January 2008, when Eric stopped
> updating his paper, and before he could start doing an extensive
> description and evaluation of bzr, Mercurial and Git,

Which evaluation is very important, as Git, Mercurial (hg) and Bazaar
(bzr) in addition to Subversion (svn) dominate the field of open-source
version control systems, with Darcs and Monotone having its own niches.

> so it's not 
> surprising that they are still relevant today.  I suspect that when he
> picks up this draft again, and starts writing these sections covering
> modern distributed SCM's, the sections for Mercurial, Git, Bzr,
> et. al, will cause a huge amount of controversy, because even though
> he is claiming to be unbiased, there is very clear in the draft to
> date that he would very much like to draw a grand sweeping picture of
> progress and evolution starting from "first generation systems" (RCS,
> SCCS, et. al), to "second generation systems" (CVS, SVN, et. al), to
> "third generation systems" (Arch, Monotone, git, Mercurial, etc.)

There is progress and evolution... 
 * locking -> update-then-commit (or merge-then-commit) -> 
   -> commit-then-merge (and alternate/additional workflow of rebase
   aka. commit-merge-recommit-push)
 * local -> client / server -> distributed

Perhaps also
 ? per-file history -> whole tree commits

But there are still controversial issues, like discussed here issue
on _how_ to deal with renames.

> 
> There are hints in the draft that he views "container identity" has
> the next "evolutionary idea" which "more primitive" systems do not
> have, and "more evolved" systems do have.  This can be seen from this
> excerpt from his draft:
> 
> 	First wrong assumption: Conflict resolution by merging is
> 	intractably difficult, so we'll have to settle for locking. It
> 	took at least fifteen and arguably twenty years for VCS
> 	designers to get shut of that one. But it's historical now.

There I think everybody would agree.  Modern VCS rare, if even, have
support for locking model.

> 
> 	Second wrong assumption: Change history representation as a
> 	snapshot sequence is perfectly dual to the representation as
> 	change/add/delete/rename sequences.. This folk theorem is well
> 	expressed in the 2004 essay On Arch and Subversion. It is
> 	appealing, widely held, and dead wrong.
> 
> 	File renames break the apparent symmetry. The failure of
> 	snapshot-based models to correctly address this has caused
> 	endless design failures, subtle bugs, and user misery.

First, I have stressed already, the issue of 'container identities'
for dealing with renames is totally ORTHOGONAL to the issue whether
SCM is snapshot based or changeset based.  Case in point: Bazaar (bzr).
Bazaar uses file-ids and directory-ids to deal with renames (here it
is spiritual child of Arch), but on Bazaar wiki (http://bazaar-vcs.org)
it is mentioned in the passing that it is _snapshot based_. I think
that it had those file-ids even when it used 'weave' in repository
format (not deltas / changesets).

Second, what I also wrote about already, the article cited as argument
for changeset based SCM (which you don't have in above excerpt) is not
to the point, and moreover is totally, utterly _wrong_. The troubles
with merging in CVS and Subversion are not caused by the fact that they
are snapshot based (CVS isn't, by the way), but by the fact that they
don't (or in the case of Subversion didn't) track merges.

> 
> So you can see that Eric seems to believe quite strongly that the
> failure to track file renames is as fundamental an error as what he
> terms the "First Wrong Assumption".  He later admits that the idea is
> controversial, and that people are still "grapling" with it, but I
> think he's tipped his hand about what he believes the ultimate correct
> answer is with respect to this issue.

What I'd like to see in the next version of "Understanding Version
Control Systems" is to concentrate more on the _issue_ of managing
renames, than on specific solution of this problem.  And I very much
would like to see 'rename detection' mentioned...

But I think that the issue of renames is not the main point. The main
point is that in modern VCS _merging_ has to be easy[1], from which
naturally follows that VCS needs intelligent merge which can deal well
with file renames.  Managing renames is needed for easy merging; all
else is glitter.

Or, from the other point of view the important thing that _branching_
is important. Both creating branches, and merging branches (and having
large amount of branches, and being able to delete branches, and having
local (unpublished) and global (published) branches, etc.).


BTW. there is excerpt from Junio C. Hamano blog post "FLOSS weekly #19
follow-up (3)" http://gitster.livejournal.com/9970.html

  By the time the basic structure as we currently know has stabilized,
  we had help from literally dozens of contributors to add many things
  on top of the very original version:

  [...]
  * We did not envision that multiple branches in a single repository
    would turn out to be such a useful way to work, and did not have
    support for switching branches.

> 
[...]
> I suspect Eric will disagree with me, but regardless of how he
> completes his paper, it will almost certainly end up taking sides one
> way or another on this controversy, at which point one side or the
> other of this particular disagreement will argue that Eric is really
> writing an advocacy paper pushing Bzr, Mercurial, or Git (depending on
> how he comes out on this issue).

I think, and I hope, that Eric would manage to keep proper scientific
decorum[2], balancing or at least mentioning all problems and all
possible solutions, even if he is biased, and even if this bias shows
(hopefully a little).

[2] The thing that distinguish true science from cargo-cult science
    (pseudo-science), which shows only arguments "for".

> 
> 
> Your suggestion that the proof is going to be in the code makes a lot
> of sense.  

I though more about the fact that having 'use cases' examples would
be more clean. And also would make possible to test against...

> The examples I would suggest that we create, and then 
> demonstrate (or make enhancements to git) so that it can handle these
> real world examples are:
> 
> 1) In branch A, the directory src/plugin/innodb-experimental is
>    renamed to src/plugin/innodb, and in branch B, a commit (i)
>    modifies a file src/plugin/innodb-experimental/table.c, and (ii)
>    creates a file src/plugin/innodb-experimental/mod-schema.c.  This
>    commit in branch B is then pulled into branch A, where the
>    directory rename has taken place.  The user may not know that a
>    directory rename had taken place under the covers, so they don't
>    give any magic options when they run the "git cherry-pick" or "git
>    merge" command.  Does the right thing happen such that the right
>    file in src/plugin/innodb is modified, and the new file is created
>    in src/plugin/innodb, even though in the original commit, the
>    changes were made to files in src/plugin/innodb-experimental?

This (or similar, at least) example you can find in 'Tests for
"Understanding Version Control" by Eric S. Raymond' subthread...

> 
> 2) And does the right thing happen if the situation is as described
>    above, but in, branch C, which is descended from branch B, a new
>    directory, src/plugin/innodb-experimental is created, such that
>    src/plugin/innodb and src/plugin/innodb-experimental both exist.
>    Now the same commit from branch A is pulled into branch C.  Will
>    the correct thing happen in that the correct files in
>    src/plugin/innodb are modified and created, even though there is a
>    new directory containing a completely unrelated plugin that happens
>    to have the name, "innodb-experimental"?

Errr... I think that you confused branch 'B' (with innodb-experimental)
with branch 'A' (with innodb only) here.

> 
>    BTW, it has been asserted that there exists at least one major open
>    source project where this sort of thing happens quite often, and
>    the fact that git did not do the right thing in these conditions
>    was a factor their choosing another DSCM.

I think that they should change their filesystem hierarchy naming
conventions and/or use branches more. But that is not terribly 
relevant...

> 
> > Or "Detecting [Wholesame] Directory Renames"... which can be done
> > using 'rename detection' paradigm, and we have patches to prove it![4]
> > but unfortunately code didn't made it (yet!) into git.  And it can,
> > I think, deal with splitting files into two directories, something
> > which I guess in 'container identity' (directory-id) based solution
> > is simply impossible
> 
> It may be that Yann Dirson's patches will handle case (1) above.
> Handling case (2) is much harder, especially without slowing
> everything down massively, since it would effectively mean needing to
> looking for directory renames along every single commit on the branch.
> (This would obviously have to be cached in some cache file.)

Well, I think it would be a bit simpler: for each _new_ file in merge
you have to see where other files in the directory it was created are.
But I agree that it would be costly; perhaps it should be triggered by
separate option / config, like diff.renames = copies?

> 
> It can be done, I'm sure, but it would require a lot of code to get
> right.  Whether or not it's worth it is a question which is open to
> debate, but I believe the bzr folks have asserted that bzr can handle
> both cases (1) and (2) above, and there are some folks who apparently
> care.  

On the other hand I think that fundamentally 'container identity'
solutions cannot deal with the case of splitting contents (or reverse,
joining contents), e.g. splitting file into smaller files, or splitting
directory into few directories (grouping files).  And from what
I understand at least current implementations of 'file-id' solution
have problems with repeated merging in the case of independently added
file.

> 
> Whether or not a particular open source project will really and truly
> run into this problem is a different question, and one can argue that
> renaming plugins, and then creating new plugins with the same name as
> older plugins that have since been renamed will lead to programmer
> confusion, and so that's a good enough reason to avoid doing such
> crazy things.  Unfortunately, you know how some programmers
> are.... telling someone they shouldn't do something is often an
> invitation to do exactly what you tell them is a bad idea, and then
> they complain when your filesystem or your DSCM doesn't handle that
> case particularly gracefully.
> 
> 						- Ted

Final words: there is no race. We aren't here to achieve world
domination. Sometimes one SCM, with its different choices, might
be better solution than the other.  For example if you have large
media files then centralized SCM with partial checkout support might
be a best choice.  Another example is how we pointed on #git (sic!)
people from IPsec, who wanted each commit to be signed or equivalent,
towards Monotone.

-- 
Jakub Narebski
Poland
