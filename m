From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: VCS comparison table
Date: Sat, 21 Oct 2006 21:41:50 +0200
Message-ID: <200610212141.51829.jnareb@gmail.com>
References: <45357CC3.4040507@utoronto.ca> <200610211608.18895.jnareb@gmail.com> <20061021181149.GM75501@over-yonder.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: bazaar-ng@lists.canonical.com, Linus Torvalds <torvalds@osdl.org>,
	Carl Worth <cworth@cworth.org>, Andreas Ericsson <ae@op5.se>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Oct 21 21:41:53 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GbMjB-0007NS-6l
	for gcvg-git@gmane.org; Sat, 21 Oct 2006 21:41:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423383AbWJUTlo convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Sat, 21 Oct 2006 15:41:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423382AbWJUTlo
	(ORCPT <rfc822;git-outgoing>); Sat, 21 Oct 2006 15:41:44 -0400
Received: from hu-out-0506.google.com ([72.14.214.224]:53099 "EHLO
	hu-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1423381AbWJUTln (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 21 Oct 2006 15:41:43 -0400
Received: by hu-out-0506.google.com with SMTP id 28so617675hub
        for <git@vger.kernel.org>; Sat, 21 Oct 2006 12:41:41 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=monUbUVEDj/Mz6MGe4veACuvlBLO0Ow44gplqOhZSAABcsqPuxNnlcO4lHSEmqLDmlxW89/N0ewPB5SAdfeLCF/IY0OxnPzI6GgB6+l1XPD09+xcEkj82g64a5AhwDE9Zm2b7U1wFKoL+jrIEZHpJrvBaTpDA1yad8b11RQ/zgA=
Received: by 10.67.101.10 with SMTP id d10mr4269908ugm;
        Sat, 21 Oct 2006 12:41:41 -0700 (PDT)
Received: from host-81-190-23-110.torun.mm.pl ( [81.190.23.110])
        by mx.google.com with ESMTP id 30sm2982739ugf.2006.10.21.12.41.40;
        Sat, 21 Oct 2006 12:41:40 -0700 (PDT)
To: "Matthew D. Fuller" <fullermd@over-yonder.net>
User-Agent: KMail/1.9.3
In-Reply-To: <20061021181149.GM75501@over-yonder.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29666>

Matthew D. Fuller wrote:
> On Sat, Oct 21, 2006 at 04:08:18PM +0200 I heard the voice of
> Jakub Narebski, and lo! it spake thus:
>> Dnia sobota 21. pa=C5=BAdziernika 2006 15:01, Matthew D. Fuller napi=
sa=C5=82:

>> When two clones of the same repository (in git terminology), or two
>> "branches" (in bzr terminology), used by different people, cannot be
>> totally equivalent that is centralization bias.
>=20
> This is obviously some new meaning of "centralization" bearing no
> resemblance whatsoever to how I understand the word.

Perhaps I'd better use "star topology bias" instead of "centralization
bias".
=C2=A0
> In git, apparently, you don't give a crap about a branch's identity
> (alternately expressible as "it has none"), and so you throw it away
> all the time. =C2=A0Given that, revnos even if git had them would nev=
er be
> of ANY use to you, so it's no wonder you have no use for the notion.

In git branches are lightweight. Branch names are local to repository.
Repositories have identity. Bzr "branch" is strange mix of one-branch
git repository and git branch.

Git main workflow is fully decentralized workflow. All clones of the
same repository are created equal. In bzr the suggested workflow
(with revnos) forces one (or more) branches to be mainline (use "merge"=
,
get empty-merges, revnos don't change) and leaf (use "pull", revnos
change).
=C2=A0
> I DO give a crap about my branchs' identities. =C2=A0I WANT them to r=
etain
> them. =C2=A0If I have 8 branches, they have 8 identities. =C2=A0When =
I merge one
> into another, I don't WANT it to lose its identity. =C2=A0When I merg=
e a
> branch that's a strict superset of second into that second, I don't
> WANT the second branch to turn into a copy of the first. =C2=A0If I w=
anted
> that, I'd just use the second branch, or make another copy of it. =C2=
=A0I
> don't WANT to copy it. =C2=A0I just want to merge the changes in, and=
 keep
> on with my branch's current identity.

I don't understand. If I merge 'next' branch into 'master' in git, I=20
still have two branches: 'master' and 'next'.

And I don't understand why you are so hung on branch identities. Yes, i=
f
somebody clones your 'repo' repository, he can have your 'master' branc=
h
(refs/heads/master) named 'repo' (refs/heads/repo) or 'repo/master'
(refs/remotes/repo/master), but why that matters to you. It is _his_
(or her ;-) clone.=20

> Now, we can discuss THAT distinction. =C2=A0I'm not _opposed_ to git'=
s
> model per se, and I can think of a lot of cases where it's be really
> handy. =C2=A0But those aren't most of my cases. =C2=A0And as long as =
we don't
> agree on branch identity, it's completely pointless to keep yakking
> about revnos, because they're a direct CONSEQUENCE of that difference
> in mental model. =C2=A0See? =C2=A0They're an EFFECT, not a CAUSE. =C2=
=A0If bzr didn't
> have revnos, I'd STILL want my branch to keep its identity. =C2=A0You=
 could
> name the mainline revisions after COLORS if you wanted, and I'd still
> want my branch to keep its identity. =C2=A0Aren't we through rehashin=
g the
> same discussion about the EFFECTS?

=46or revnos to work you MUST have one "branch" to be considered
special, the hub in star topology. This very much precludes fully
distributed development.=20

BTW. I get that you can use revids in revnos in bzr for fully
distributed and not star-topology geared development. But
Bazaar-NG revids are uglier that Git commit-ids.

[...]
>> And you say that bzr is not biased towards centralization? In git
>> you can just pull (fetch) to check if there were any changes, and if
>> there were not you don't get useless marker-merges.
>=20
> If I don't tell you my branch has something in it ready to grab, you
> shouldn't merge it. =C2=A0It probably won't work, and is quite likely=
 to
> set your computer on fire, slaughter and fillet your pet goldfish, an=
d
> make demons fly out of your nose. =C2=A0If you wanna get stuck with a=
ll my
> incomplete WIP, let's just use a CVS module and be done with it.

In git I can fetch your changes but I don't need to merge them. Take
for example Junio 'pu' (proposed updates) branch: this is the branch
you shouldn't merge as it's history is constantly being rewritten.

If you don't want for your WIP to be publicly available, you don't
publish it. For example as far as I understand Junio works on Git
in his private repository, with many, many feature branches, but
he does push to public [bare] repository only some subset of branches,
and we can fetch/pull only those.

But still, if I am impatient I can pull from Junio every hour, and
I don't get 24 totally useless empty merge messages if he took day
off and didn't publish any changes till day later.

>> 2. But the preferred git workflow is to have two branches in each of
>> two clones. The 'origin' branch where you fetch changes from other
>> repository (so called "tracking branch") and you don't commit your
>> changes to [...]
>=20
> Funny, since this reads to me EXACTLY like the bzr flow of "upstream
> branch I pull" and "my branch I merge from upstream" that's getting
> kvetched around...

But please, have you realized that in this workflow the two clones
of the same repository are totally symmetrical? One's 'master' is
another 'origin' and vice versa. After pull on one side, and pull
on the other side (without any changes in between) we have the same
contents, and the same revision names (commit-ids in git), even if
the changes (revisions) got to those clones in different order.
In bzr those two "branches" would get different revnos. No symmetry.
=46ull distributed vs star topology (one branch "central", hence
"centralized" - I don't mean need to access to one central repository,
although...)

--=20
Jakub Narebski
ShadeHawk on #git
Poland
