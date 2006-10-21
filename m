From: "Matthew D. Fuller" <fullermd@over-yonder.net>
Subject: Re: VCS comparison table
Date: Sat, 21 Oct 2006 13:11:49 -0500
Message-ID: <20061021181149.GM75501@over-yonder.net>
References: <45357CC3.4040507@utoronto.ca> <87irie1wvv.wl%cworth@cworth.org> <20061021130111.GL75501@over-yonder.net> <200610211608.18895.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: bazaar-ng@lists.canonical.com, Linus Torvalds <torvalds@osdl.org>,
	Carl Worth <cworth@cworth.org>, Andreas Ericsson <ae@op5.se>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Oct 21 20:11:55 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GbLK7-0001mt-Gj
	for gcvg-git@gmane.org; Sat, 21 Oct 2006 20:11:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422691AbWJUSLw convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Sat, 21 Oct 2006 14:11:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423355AbWJUSLw
	(ORCPT <rfc822;git-outgoing>); Sat, 21 Oct 2006 14:11:52 -0400
Received: from ns.centralmiss.com ([206.156.254.79]:58071 "EHLO
	optimus.centralmiss.com") by vger.kernel.org with ESMTP
	id S1422691AbWJUSLv (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 21 Oct 2006 14:11:51 -0400
Received: from draco.over-yonder.net (adsl-072-148-013-213.sip.jan.bellsouth.net [72.148.13.213])
	(using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by optimus.centralmiss.com (Postfix) with ESMTP id 35CB42842A;
	Sat, 21 Oct 2006 13:11:50 -0500 (CDT)
Received: by draco.over-yonder.net (Postfix, from userid 100)
	id A4D7961C52; Sat, 21 Oct 2006 13:11:49 -0500 (CDT)
To: Jakub Narebski <jnareb@gmail.com>
Content-Disposition: inline
In-Reply-To: <200610211608.18895.jnareb@gmail.com>
X-Editor: vi
X-OS: FreeBSD <http://www.freebsd.org/>
User-Agent: Mutt/1.5.11-fullermd.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29649>

On Sat, Oct 21, 2006 at 04:08:18PM +0200 I heard the voice of
Jakub Narebski, and lo! it spake thus:
> Dnia sobota 21. pa=C5=BAdziernika 2006 15:01, Matthew D. Fuller napis=
a=C5=82:
> >=20
> > I think we're getting into scratched-record-mode on this.
>
>  [....]

Thank you for demonstrating my point   8-}


> When two clones of the same repository (in git terminology), or two
> "branches" (in bzr terminology), used by different people, cannot be
> totally equivalent that is centralization bias.

This is obviously some new meaning of "centralization" bearing no
resemblance whatsoever to how I understand the word.

In git, apparently, you don't give a crap about a branch's identity
(alternately expressible as "it has none"), and so you throw it away
all the time.  Given that, revnos even if git had them would never be
of ANY use to you, so it's no wonder you have no use for the notion.

I DO give a crap about my branchs' identities.  I WANT them to retain
them.  If I have 8 branches, they have 8 identities.  When I merge one
into another, I don't WANT it to lose its identity.  When I merge a
branch that's a strict superset of second into that second, I don't
WANT the second branch to turn into a copy of the first.  If I wanted
that, I'd just use the second branch, or make another copy of it.  I
don't WANT to copy it.  I just want to merge the changes in, and keep
on with my branch's current identity.

Maybe that's what you mean by 'centralization'; each branch is central
to itself.  That seems a pretty useless definition, though.  In my
mind, actually, it's MORE distributed; my branch remains my branch,
and your branch remains your branch, and the difference doesn't keep
us from working together and moving changes back and forth.  Forcing
my branch to become your branch sounds a lot more "centralized" to me.


Now, we can discuss THAT distinction.  I'm not _opposed_ to git's
model per se, and I can think of a lot of cases where it's be really
handy.  But those aren't most of my cases.  And as long as we don't
agree on branch identity, it's completely pointless to keep yakking
about revnos, because they're a direct CONSEQUENCE of that difference
in mental model.  See?  They're an EFFECT, not a CAUSE.  If bzr didn't
have revnos, I'd STILL want my branch to keep its identity.  You could
name the mainline revisions after COLORS if you wanted, and I'd still
want my branch to keep its identity.  Aren't we through rehashing the
same discussion about the EFFECTS?


> > It refers both to the conceptual entity ("a line of development"
> > roughly, much like what 'branch' means in git and VCS in general),
> > and to the physical location (directory, URL)
>=20
> I'd rather use other name then. Perhaps "forks" for physical
> "branch", i.e. branch metadata (like revno to revid mapping) +
> object repository or pointer to it + optionally working area/working
> files.=20

It's the same name in bzr because branches are their location, not
their 'name'.  Every branch always has a location, and every location
refers to a branch (well, as long as it's a location that's meaningful
to bzr; "/etc/passwd" is a location, but it's nothing to do with bzr,
so it's not a branch.  Don't dawdle in irrelevancies).


> And you say that bzr is not biased towards centralization? In git
> you can just pull (fetch) to check if there were any changes, and if
> there were not you don't get useless marker-merges.

If I don't tell you my branch has something in it ready to grab, you
shouldn't merge it.  It probably won't work, and is quite likely to
set your computer on fire, slaughter and fillet your pet goldfish, and
make demons fly out of your nose.  If you wanna get stuck with all my
incomplete WIP, let's just use a CVS module and be done with it.


> 2. But the preferred git workflow is to have two branches in each of
> two clones. The 'origin' branch where you fetch changes from other
> repository (so called "tracking branch") and you don't commit your
> changes to [...]

=46unny, since this reads to me EXACTLY like the bzr flow of "upstream
branch I pull" and "my branch I merge from upstream" that's getting
kvetched around...



--=20
Matthew Fuller     (MF4839)   |  fullermd@over-yonder.net
Systems/Network Administrator |  http://www.over-yonder.net/~fullermd/
           On the Internet, nobody can hear you scream.
