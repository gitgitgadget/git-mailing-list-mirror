From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Git terminology: remote, add, track, stage, etc.
Date: Tue, 19 Oct 2010 13:57:14 -0700 (PDT)
Message-ID: <m3k4ldlx56.fsf@localhost.localdomain>
References: <8835ADF9-45E5-4A26-9F7F-A72ECC065BB2@gmail.com>
	<m3ocar5fmo.fsf@localhost.localdomain>
	<20101019080523.GB22067@login.drsnuggles.stderr.nl>
	<201010191027.44859.jnareb@gmail.com>
	<202EB46D-10D0-4090-A9DA-5796769F61A2@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Jonathan Nieder <jrnieder@gmail.com>,
	Scott Chacon <schacon@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Junio C Hamano <gitster@pobox.com>,
	Jakub Narebski <jnareb@gmail.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Sverre Rabbelier <srabbelier@gmail.com>
To: Thore Husfeldt <thore.husfeldt@gmail.com>
X-From: git-owner@vger.kernel.org Tue Oct 19 22:57:26 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P8JFN-0002sn-7y
	for gcvg-git-2@lo.gmane.org; Tue, 19 Oct 2010 22:57:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757646Ab0JSU5U convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 19 Oct 2010 16:57:20 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:57358 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757620Ab0JSU5T convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 19 Oct 2010 16:57:19 -0400
Received: by bwz10 with SMTP id 10so763104bwz.19
        for <git@vger.kernel.org>; Tue, 19 Oct 2010 13:57:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type
         :content-transfer-encoding;
        bh=Q6YhTqxf/36Tvpyym0l8hM2xRjnThg2qik4gRfhx9Hs=;
        b=nd6dq7Ovr0mdCIY71tAzmYauWvebYNutujARghR4qKYO/s6jrHz89+pcMflM/tGKgi
         xo2MSmU+CtTMpm0Nh3GZumX58/AgawTxz8KL7L+nRhCDyz8OIOSdMNV7VOKWtwaef/Op
         VpFdp4l+qdVbs5kTLjh3MK1VqCQVna4bVunFg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type
         :content-transfer-encoding;
        b=YSUZpo7Gx+k18EA5Xj2IEMicSFoIebYDYgvCftWWZ8suLyhZQvwSPy2uMzl0FMbmK2
         ZKcW4WsQctOzsu5R6XpsWrun91u5d4s8snm9wUUaZwho3SSlg2fpqq4k9C6Ab8Q+wYhQ
         vScTvyZZis3/W+ZKA4sTubMai2oh9FGcVkd/U=
Received: by 10.204.53.4 with SMTP id k4mr6071037bkg.145.1287521837665;
        Tue, 19 Oct 2010 13:57:17 -0700 (PDT)
Received: from localhost.localdomain (abvs158.neoplus.adsl.tpnet.pl [83.8.216.158])
        by mx.google.com with ESMTPS id d12sm6747518bkw.7.2010.10.19.13.57.13
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 19 Oct 2010 13:57:14 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id o9JKuhZ0018346;
	Tue, 19 Oct 2010 22:56:54 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id o9JKuMvV018341;
	Tue, 19 Oct 2010 22:56:22 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <202EB46D-10D0-4090-A9DA-5796769F61A2@gmail.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159364>

Re-added (some of) CC list; at least all quoted authors are there.

Thore Husfeldt <thore.husfeldt@gmail.com> writes:

> Thank you all for your many and well-thought out replies. I learned
> a lot.
>=20
> Jonathan Nieder:
>=20
> JNi> So what would be a better term [for tracking]?
>=20
> Trailing is better than tracking, since it hints at some degree of
> sloth, but I have not thought this through. (I also think that it
> may be a strategic mistake to advocate looking for a new name; as
> long as tracking is used consistently the problem with a misleading
> metaphor is not so big, and the name change alienates a large group
> of people whose consent is important.)

It is harder to use as adjective though, compare "remote-tracking
[branch]" with "remote-trailing [branch]"... or is it just "trailing
branch"?

Besides I don't think that 'remote-tracking' has to mean
_automatically_ tracking; it is *used* to track.

> Matthiey Moy:
>=20
> MM> Git's huge sin, after all (judging from most complaints I see
> MM> about it), is that It Doesn't Use Exactly The Same Model (and
> MM> thus Terminology) That CVS Did...
>=20
>=20
> My analysis of Git=92s wickedness is interestingly different. Git has
> a clean and simple model that should be very easy to
> understand.

The unfortunate consequence of this is that many git command and much
of git documentation is based on this understanding.  It would be
better to have documentation centered around 'user stories', not
techicalities.

=46or example instead of `git unstage <file>`, one has to use=20
`git reset -- <file>`; one has to understand how contents is moved
between repository (commits), staging area (index / cache) and
worktree to arrive at this command.  Fortunately `git status`
and the comments in commit message template help users there,
but it would be nice not to have to rely on this.

> Git=92s rhetorical traditions prevent that understanding. Git is
> really, really hard to learn, no matter where you come from, but
> there is no inherent reason for that.

Well, there is a matter of debate how much of git complexity is
accidental complexity which should be eliminated, and how much is
essential complexity.

=46or example user-visible staging area[1], or git branching model[2]
can be confusing, at least to users coming from other version control
systems.  Those concepts though are necessary to allow much of power
of git.  In the case of visible staging area dealing with conflicts
during merge and choosing piece-by-piece what is to be in next commit.
In the case of git branching model, it allows for interacting with
multiple multi-branch repositories without worrying about single
global namespace for branch names.


[1] Other version control systems have at least a shadow of it,
    because they need to know which files are to be versioned
    (tracked).

[2] I mean here the difference between refs/heads/* and
    refs/remotes/<remote>/* refs, and mapping between tracked branches
    in remote repository and remote-tracking branches in given
    repository.
=20
> The steepness of the learning curve (rather than the divergence from
> other systems=92s terminology) is the single biggest complaint agains=
t
> git, evidenced by my own anecdotal evidence from web surfing, and by
> the Git user survey. It should be viewed as Git=92s biggest current
> problem by an order of magnitude. It makes me think twice and thrice
> before asking my colleagues to collaborate with me using Git; I will
> probably learn Mercurial and advocate using that instead; it=92s
> almost as nice, and I don=92t feel embarrassed advocating it. Using
> git for myself is great (now I understand it) but it is unclear if I
> should invest social capital to convince others to use it as well.

I guess that some of _perceived_ ease of use of Mercurial was
generated by the fast that (at least in the past) it had superior
documentation in the form of "Mercurial: The Definitive Guide" aka
hgbook.  Though nowadays there is "Git User's Manual" and "Pro Git",
it is hard to fight prejudice.

> Sverre Rabbelier:
>=20
> SR> What do you mean with the last part (about `git branch -r`)? The
> SR> fact that 'refs/remotes' is not immutable?
>=20
> Well, consider for example the simple obfuscatory mastery of the
> following line in the user manual:
>=20
> > $ git branch -r			# list all remote branches

So you say that it should be instead the following, isn't it?

>   $ git branch -r		# list all remote-tracking branches


>=20
>=20
> Yes, I get it *now*. And I begin to feel the corruption spreading in
> my own brain already: I myself start to think of origin/master as a
> ``remote branch''. Give me a few more weeks and I will be
> completely assimilated in the mindset.
>=20
> (Note to self: submit a patch about this before my assimilation is
> complete. I already fixed it and committed to my local branch.)

That would be very nice.

>=20
> Matthieu again:
>=20
> MM> We already came up with a better wording, namely "upstream", and
> MM> used in in "git push --set-upstream".
>=20
> Oh, I didn=92t know that. I was convinced that "upstream" was
> cruft from when git was chiefly a tool to help Linus maintain the
> Linux kernel. Let's see if I get this right:
>=20
> The remote-tracking branch "origin/master" is *upstream* (the
> upstream?) of the local branch "master",

Right.

> and [local branch "master"] *tracks* the remote origin=92s branch
> "master"? (local) "master" is downstream of "origin/master"?

With above clarification: right.  Though using "track" here was
mistake ("follows" or "is downstream").

>=20
> This would be useful. And @{u} is good. (Does it have an inverse?)

One branch can have only one "upstream" (in old terminology: it can
track only one branch).  But the reverse doesn't hold: single
remote-tracking branch can be upstream for many branches (e.g. many
feature branches based on the same long-lived branch).  The mapping is
one-to-many, so there is no inverse.

>=20
> I=92m not sure I like the particular word, but that=92s a minor compl=
aint.=20
>=20
> ( For completeness: A small terminological quibble is that upstream
> doesn=92t verb well.

That's why git has `--set-upstream` ;-)

> A bigger conceptual quibble is that this decision is not
> workflow-neutral. It enforces git=92s hierarchical linux-kernel
> development tradition, rather than embracing a truly distributed
> model where everybody is the same. When I think of distributed
> version control I like to think of Alice having a remote-tracking
> bob/master and Bob having a remote-tracking alice/master. Of course,
> it is still meaningful for Alice to say "the upstream of
> bobs_latest_crazy_ideas is bob/master", and for Bob to say "the
> upstream of alices_inane_ramblings is alice/master". But it
> introduces a notion of hierarchy that is inimical to the concept of
> distribution, and not workflow-neutral. )

Actually it is inimical to pull-based workflow, not to hierarchical
development.  "Upstream" is where you pull from.

Sidenote: having 'canonical' repository that (almost) everybody pulls
from is I think quite common in DVCS-based development, isn't it?

>=20
> Of course, upstream could be called supercalifragilistic and I would
> still like it. Consistency is more important than having good
> metaphors. (But good metaphors would be better, all other things
> being equal.)
>=20
> Jakub Narebski:
>=20
> JNa> Note that it is not as easy as it seems at first glance.  There
> JNa> are *two* such options, which (as you can read in gitcli(7)
> JNa> manpage) have slightly different meaning:
>=20
> Wow. Thanks for pointing this out, I did not know that, and it
> explains a lot. I must say that to everybody else than a git
> developer, this state of affairs is a proof that something is wrong,
> rather than an obstruction for improvement.

What I wanted to say that any proposal for replacing 'cache'/'cached'
and 'index' terms has to take into account that you might want to
operate on staging area *instead of* default target (`--cached`),
or *in addition to* default target (`--index`).

Though it is not widespread issue: only git-apply uses both --cached
and --index, git-stash uses only --index, and all other commands use
only --cached (if any).

Well, there is also outlier of `git diff --no-index`, but it is more
lack of good name for an option :-P

>=20
> ??> I do not think debating on changing the terminology is a
> ??> particularly productive use of our time.
>=20
> I agree in the sense that *how* the words are used is more important
> than *which* words are used, and I realise that I should not have
> put "terminology" in the headline, because that makes it about
> words, not *explanations* or terminological *discipline*.

What should you put in headline / subject, then?

--=20
Jakub Narebski
Poland
ShadeHawk on #git
