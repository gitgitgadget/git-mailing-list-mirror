From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH 1/3] fetch: add --allow-local option
Date: Sun, 19 May 2013 01:10:55 -0500
Message-ID: <51986cef178dc_7301727e1442892@nysa.mail>
References: <1368689474-28911-1-git-send-email-felipe.contreras@gmail.com>
 <1368689474-28911-2-git-send-email-felipe.contreras@gmail.com>
 <7v61yi9arl.fsf@alter.siamese.dyndns.org>
 <CAMP44s14TSGtQ7kvWUgrOQvT1uKciSV5fd5pQvy1ven8Z=qVcg@mail.gmail.com>
 <7v8v3e7udi.fsf@alter.siamese.dyndns.org>
 <CAMP44s0Szu8oHBKMapZ6dQ1K67MXDcACuUF-+Y-jC+EgHs2QEA@mail.gmail.com>
 <7vk3my6bu1.fsf@alter.siamese.dyndns.org>
 <CAMP44s2W5MUneTwcSnr=Ey715paKgSL6MqXmYKdSmw4NqdL4qQ@mail.gmail.com>
 <7vk3my33vb.fsf@alter.siamese.dyndns.org>
 <CAMP44s0J7vcxno=v9_ewUE6FcuRVuYQhCNVS8D+AvP6cG2XNfQ@mail.gmail.com>
 <7vtxm1xxvd.fsf@alter.siamese.dyndns.org>
 <CAMP44s3xdWzVviPvrN7D1fTG6Lwgg-dEzju--VuiwZA-8bV+MQ@mail.gmail.com>
 <7vtxlz1pr1.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Jens Lehmann <Jens.Lehmann@web.de>
To: Junio C Hamano <gitster@pobox.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Sun May 19 09:57:22 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UdyUb-0006zr-Dq
	for gcvg-git-2@plane.gmane.org; Sun, 19 May 2013 09:57:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753556Ab3ESH5Q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 19 May 2013 03:57:16 -0400
Received: from mail-oa0-f44.google.com ([209.85.219.44]:44393 "EHLO
	mail-oa0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753426Ab3ESH5P (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 19 May 2013 03:57:15 -0400
Received: by mail-oa0-f44.google.com with SMTP id n12so6652161oag.17
        for <git@vger.kernel.org>; Sun, 19 May 2013 00:57:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:date:from:to:cc:message-id:in-reply-to:references
         :subject:mime-version:content-type:content-transfer-encoding;
        bh=lmwby3rc3jJdhyeiuU27dwP0ngxiyYFzKZ97/BAx2Bo=;
        b=QiJ98vLtvvETVSf/JO7fzCef2gPIdF9jvJ4KHFJ4h+FS6hjhtTrNWFB/8mzJ41I4V7
         +een8KF3UWClOaHXWjtX9KSZ7rhd47yYyd5jxFt3U/GJFo7o7Yeao6NEBmXz23umY+Bj
         uaPkO2sYx4JhIKazGvzr3h+3o7nxslQtHmHd5mgCfk6pbQeHLYbZ0htGmpJo1MIOmiE2
         Dm0k/xkJZllJEGmASjTFGkXN8wu/IJPNe2Fd71SsoTofggoSLar5Xi7RT9U2jUwnn0+o
         ZPnvNDKyTBVTcignCKaS5NW7T8PwjPa5C7669K7ztxKy9AYbyC88Uk+UCMiy9Oj+0wtn
         1RSg==
X-Received: by 10.60.55.74 with SMTP id q10mr20432480oep.80.1368950234869;
        Sun, 19 May 2013 00:57:14 -0700 (PDT)
Received: from localhost (187-163-100-70.static.axtel.net. [187.163.100.70])
        by mx.google.com with ESMTPSA id c20sm15606302oez.4.2013.05.19.00.57.12
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Sun, 19 May 2013 00:57:13 -0700 (PDT)
In-Reply-To: <7vtxlz1pr1.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224828>

Junio C Hamano wrote:
> Felipe Contreras <felipe.contreras@gmail.com> writes:
> 
> > On Fri, May 17, 2013 at 1:30 PM, Junio C Hamano <gitster@pobox.com> wrote:
> >> Felipe Contreras <felipe.contreras@gmail.com> writes:
> >>
> >>> This is irrelevant, it's an implementation detail of 'git pull'. *THE
> >>> USER* is not running 'git fetch .'
> >>
> >> To those who fear running "git pull", the following has worked as a
> >> quick way to "preview" what they would be getting.
> >>
> >>         git fetch
> >>         git log ..FETCH_HEAD
> >>
> >> and then they can "git merge FETCH_HEAD" to conclude it, or run a
> >> "git pull" for real.  We teach the more explicit form to end users
> >> in our tutorial,
> >
> > That "tutorial" is mostly irrelevant; it has not been properly updated
> > in years, and it doesn't do it's job properly.
> >
> > Nowadays most people use the Pro Git book, which doesn't mention
> > FETCH_HEAD even once. And why would it?
> 
> Because the book was written by those who did not know about its
> use, and I do not necessarily think it is their fault.

That's an _assumption_, and I don't think it's correct; the authors might very
well know about FETCH_HEAD, but made a conscious decision to avoid explaining
such low-level concepts to people trying to learn Git; they are irrelevant to
them. I'm sure they skipped pack formats, remote-helper interfaces, and a lot
of other implementation details users don't need to know about.

FETCH_HEAD is simply another implementation detail users don't need to
know, so it doesn't belong in Pro Git, a book designed for people trying
to learn Git.

> Our own documentation can use updates.

Yeah, sure. I've tried to fix the tutorial, it's not an experience I would
wish to anybody, especially not people unfamiliar with Git, who are the
people better suited to understand what is confusing about Git.

IOW, the documentation is destined to oblivion, because the only people
that could point out the inconsistencies and irrelevancies, are
precisely the people that don't contribute to Git. And the people who do
contribute to Git, and have enough empathy to put themselves in the
shoes of users, are shun for 'rocking the boat'.

Yes, the documentation *can* use updates, but won't.

> IIUC, ProGit is maintained in public and you can send patches to it,
> too.

Yes, and I will send patches, but about issues that *matter*. Why would
I send a patch to add text about a feature *nobody* needs to know?

> Users of stackoverflow seem to know about and how to use FETCH_HEAD:
> 
>     http://stackoverflow.com/questions/9237348/what-does-fetch-head-in-git-mean
>     http://stackoverflow.com/questions/11478558/fetch-head-not-updating-after-git-fetch

This is a cheeky use of rhetoric, it implies that *all* users of
stackoverflow know about this, and it's not true.

Counting the amount of votes, the best we can say is at most 20 people
'know' about this. A more specific description of the situation would be
that at most 20 people _knew_ about this, at the time they read it; they
might have forgotten already. But more importantly, only 14 people voted
for this question, and only 7 people starred it.

The top question 'How do I edit an incorrect commit message in Git?'
about Git has 2871 votes and 822 stars, which is more than 200 times.
Can we say that stackoverflows "know" how to amend a commit? Well, if
they knew why it continues to receive votes?

So if one question has 2871 votes, and the other one has 14 votes, does
it mean they 'know' one question, and not the other one? At which point
do the users stop 'knowing' the answer to the question? If a question is
posted, does it mean that automatically stackoverflow users 'know' about
it?

No, we don't known what stackoverflow users seem to "know", we can only
know what *some* of them consider a good question, and a good answer.
That's all.

> and they expect exactly what I described in the earlier message.

Wrong. From those links only one person expected this to happen, and he
received zero votes, which can be translated to; nobody cares.

> If you ask your search engine about "FETCH_HEAD", you would find other
> real-world use of it as well (one of them I found was about somebody
> requesting to teach TortoiseGit to offer FETCH_HEAD as a candate to be
> merged, IIRC).

I'm sure there are people out there that would find uses for FETCH_HEAD,
you can probably count them with the fingers in your hand, even if half
of them were missing.

This patch would do *nothing* to harm those suers, because they can
still do 'git fetch .', or even 'git fetch --allow-local'. The two
persons in the world that do expect 'git fetch' without arguments to
update FETCH_HEAD, will have to specify another single character
argument. Big whooping do.

The rest of the results in Google show basically only bugs, and patches.

Even if all those results were about interesting things people do with
FETCH_HEAD, that has absolutely nothing to do with the issue at hand,
which is 'git fetch' without arguments.

This is just a red herring.

> Incidentally, this discussion on our own list
> 
>     http://thread.gmane.org/gmane.comp.version-control.git/42788/focus=42798

This explicitly says 'git fetch <URL>', it has nothing to do with 'git
fetch' without arguments.

Moreover, it explicitly says:

> I often like to fetch some code from others, review and then merge.

'git fetch .' does not help one iota to this use-case.

> shows that I was originally not very keen to defend "fetch, then
> inspect with log FETCH_HEAD, and then finally merge" workflow to
> keep working myself [*1*], which is somewhat funny.
> 
> So, no, it is not my whim, but people do depend on "git fetch" that
> updates FETCH_HEAD to what is to be merged with "git pull".

They depend on that when they merge a *REMOTE*; a remote remote, not a
local remote ('.').

There's *absolutely* no reason why anybody would ever rely on 'git fetch
.' followed by 'git merge FETCH_HEAD'.

> >> So when "the user" is running "git fetch" on "mywork" branch that
> >> happens to be forked from a local "master",...
> >> we still need to have FETCH_HEAD updated to point at what we would
> >> be merging if she did a "git pull".
> >
> > No, we don't need that. That is only needed by 'git pull', and in
> > fact, it should be possible to reimplement 'git pull' so that it skips
> > FETCH_HEAD when the remote is local.
> >
> > These are mere implementation details.
> 
> You seem to be incapable to understand what backward compatibility
> is.

I'll explain why that is wrong in so many levels in a separate mail.

> It is not about "keep only what I use myself, I think others
> should use, and/or I understand, working, and destroy everything
> else".

This is just bullshit. Nobody is destroying anything. The users can just
do 'git fetch .' and be done with it, but of course they won't, because
that doesn't do anything useful.

> Also your "special-case local repository and fetch from 'origin'"
> breaks down once your users need to work on a project with subsystem
> maintainers.

If 'git fetch' -> 'git fetch origin' is broken, then we are already
broken, because that's what happens by default.

> Imagine one clones from me (i.e. git.git is her upstream), and forks
> her fh-octopus branch out of her master branch ("git clone" arranges
> the latter to be a fork of origin/master taken from me).  She helps
> git-svn and has Eric's repository as her "git-svn" remote (because
> my tree lags behind Eric's tree with respect to git-svn).  Her local
> git-svn branch is a fork of Eric's master, and she has her svn-ext
> branch that is a fork of it [*2*].
> 
>     git clone git://git.kernel.org/pub/scm/git/git.git git
>     cd git
> 
>     git checkout -t -b fh-octopus master
>     git remote add git-svn git://git.bogomips.org/git-svn.git/
>     git checkout -t -b git-svn git-svn/master
>     git checkout -t -b svn-ext git-svn
> 
> She has four local branches, master, fh-octopus, git-svn, and
> svn-ext.  Is this a too-contrived example?  I do not think so.
> 
> On any of these branches, she can say
> 
>     git pull [--rebase]
> 
> without having to be constantly aware of what branch (either remote
> or local) the work on her current branch builds on.  Like some
> people in the thread $gmane/42788 discussion, she may prefer to do
> the same integration with "first fetch, inspect and then integrate"
> workflow, relying on the equivalence "git pull" == "git fetch" +
> "git merge/rebase":
> 
>     git fetch
>     git log ..FETCH_HEAD
>     git merge FETCH_HEAD
> 
> But when she does this:
> 
>     git checkout fh-octopus
>     git fetch
> 
> the "git fetch" does not fetch from me (i.e. her 'origin').
> 
> Would she be unhappy?
> 
> I agree that it could be argued so.
> 
> After all, she is working on a topic that is eventually based on my
> 'master' and the only reason she forked from her 'master' is because
> she may have other changes of her own on her 'master' that are not
> necessarily related to her fh-octopus topic.  She wants her "git log
> @{u}.."  not to show those unrelated changes on her 'master', but
> wants to rebase against her 'master'.
> 
> Because her @{u} does not refer to 'origin/master' taken from me (it
> refers to her local 'master'), however, even if we change "git
> fetch" to fetch from 'origin', what "git log ..@{u}" shows does not
> change, so the only "improvement" is that it does not trigger "I
> said 'git fetch' but it did not fetch anything?  Did I make some
> mistake?" confusion.

That's correct, but the issue is there no matter what, the only question
is which of the two options we want:

a)

	% git checkout svn-ext
	% git fetch
	From .
	 * branch            master     -> FETCH_HEAD
	# oops
	% git fetch git-svn
	% git log ..FETCH_HEAD
	% git merge FETCH_HEAD

b)

	% git checkout svn-ext
	% git fetch
	From git://git.kernel.org/pub/scm/git/git
	   680ed3e..de3a5c6  master     -> origin/master
	# oops
	% git fetch svn-ext
	% git log ..FETCH_HEAD
	% git merge FETCH_HEAD

For me a) is totally confusing, maybe this particular user is familiar
with FETCH_HEAD, but for the vast majority of other users it's totally
confusing. b) is also wrong, but at least it's doing something useful
and familiar; fetching from a remote remote.

Why do you ignore b)? Why do you automatically assume a) is best?

You are jumping to conclusions here.

> As I already said, I am OK with an enhancement that does (an
> equivalent of) the following:
> 
>  - Teach "git fetch --no-fetch-head <any args>" an option that
>    causes it to do everything "git fetch <any args>" would do,
>    except that in that mode, it does not touch FETCH_HEAD at all
>    (the "--append" option that changes the behaviour of "git fetch"
>    to only change what happens to FETCH_HEAD can be thought of a
>    precedent).
> 
>  - Only when 'git fetch' (with no parameters, i.e. relies on
>    configured defaults) is to fetch from '.':
> 
>    - First internally fork and run "git fetch --no-fetch-head
>      <remote>" from the <remote> found by the following loop:
> 
>     - Set a variable B to the name of the current branch 
>     - while branch.B.remote is the local repository:
>       - assign the branch the branch B forked from,
>         i.e. branch.B.merge, to variable B
>     - branch.B.remote is the first remote repository in the fork
>       ancestry chain.  That is the <remote> we are looking for.

Why do we need to fork? All we need is go through the 'branch.X.*'
configurations until we find a non-local remote.

>    - Then do the usual 'git fetch' against the local repository,
>      leaving what is to be merged in FETCH_HEAD as usual.
> 
>  - (optional) make the second "special case" opt-in, as people who
>    have known Git may be upset when their "git pull" that they know
>    would go to local repository touches network.  I do not think it
>    is a huge deal, though, and that is why I marked it as optional.
> 
> I think that would alleviate the puzzlement some people may feel
> when they run 'git fetch' on a branch that integrates with their
> local branch, and sees no objects are transferred.  It would do so
> without breaking anything.
> 
> Anything that breaks the "pull=fetch+merge" equivalence is not
> acceptable and no loud repeating from you will change that, with or
> without patches.

You are jumping ahead; you go from "Jane uses FETCH_HEAD", to "Jane
expects 'git fetch' to do 'git fetch .'", which is demonstrably false.

You merely explained why some user might want to use FETCH_HEAD in some
situations, which is totally orthogonal to the issue at hand.

The issue at hand is that 'git fetch' -> 'git fetch .' is useless.

You are using verbose rhetoric to deflect the issue at hand, and go to
great lengths to explain something that is totally irrelevant, and at no
point in time do you touch the issue of a) vs. b).

> We owe at least that much to the people who asked us to keep it
> working over time and those who responded to them by working on
> maintaining it over time.

Geezus! This patch doesn't break anything for them. Period.

Show me *one* real use-case this patch breaks. Go on.

-- 
Felipe Contreras
