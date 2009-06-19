From: Mark Struberg <struberg@yahoo.de>
Subject: Re: [egit-dev] Re: [EGIT PATCH] Rename org.spearce.egit -> org.eclipse.egit
Date: Fri, 19 Jun 2009 09:24:06 +0000 (GMT)
Message-ID: <486798.37022.qm@web27802.mail.ukl.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Robin Rosenberg <robin.rosenberg@dewire.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>,
	"egit-dev@eclipse.org" <egit-dev@eclipse.org>
To: EGit developer discussion <egit-dev@eclipse.org>,
	Alex Blewitt <alex.blewitt@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jun 19 11:24:30 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MHaKi-0004QC-SG
	for gcvg-git-2@gmane.org; Fri, 19 Jun 2009 11:24:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754237AbZFSJYJ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 19 Jun 2009 05:24:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754136AbZFSJYG
	(ORCPT <rfc822;git-outgoing>); Fri, 19 Jun 2009 05:24:06 -0400
Received: from web27802.mail.ukl.yahoo.com ([217.146.182.7]:48730 "HELO
	web27802.mail.ukl.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1753712AbZFSJYF convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Jun 2009 05:24:05 -0400
Received: (qmail 38084 invoked by uid 60001); 19 Jun 2009 09:24:06 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.de; s=s1024; t=1245403446; bh=yTtEoygTVldFrVVw+dpw/BYRDQQJRj+CwQdRjdLXYnU=; h=Message-ID:X-YMail-OSG:Received:X-Mailer:Date:From:Subject:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding; b=tYyOKsN3wOiNJ0jDeSxzKef1MhxbFW7DTqu0eAj9gS+z8fUw1huaDqF9/lHqPfL87XrT3uYAz8ET9YzwBBlkibjHxrzL6EhQgTddAz/UCv7b2O5Kdm3WJcpqyf5FtM5OJr3s+j9GRlhTbcTWTE1ItxuVFtlxiicmTKwwmi9citk=
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.de;
  h=Message-ID:X-YMail-OSG:Received:X-Mailer:Date:From:Subject:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=gYjm0qff1fT1Vbw4+5htORkGN3+1frdb/W1KyySaPmZQpp3eFP4BUywM10wItdvUvXqHTFiQjIKddInbZAb4GsLhL8uSbnj0neQ7GSPKWhUmPan3Aj/llqLHItrp6h/USg2+U989dn8XsZP3aWW6lpGKL02COeLlpemSVJk/ka8=;
X-YMail-OSG: 8.AzNTIVM1lA1KMwEaQHxSb93B3hpjGsFmTS1q.Z_1tYGcfx4vi2x2zCG_78GTq53gMDDa7dBWxMO1bPRCc3Bih6rsWkozcJsiILmKxW7WY.fLiNq1JinokXgzmXAFHPp7xhibZShN5sH3VQj8YPjK8HjF8.M731mpqtriuj90KNRsCcjL1h5iDCdLb5Fm0fZGVgwg4_jC77iVFxQ0XOtoZgNIIT9U_WM0sXFyhl_MAqOtBoyzKL.yyZzi8bp3jxLZuOEaFwP8VRqnQ6jmRpDvNrvkQoKj5gvFTyQDAJRgPRoJvesQQSOjPV47jHRe7_m6EiJd86gFerL7SFgvr5b7aQpm5_
Received: from [213.235.230.200] by web27802.mail.ukl.yahoo.com via HTTP; Fri, 19 Jun 2009 09:24:06 GMT
X-Mailer: YahooMailClassic/5.4.17 YahooMailWebService/0.7.289.15
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121890>


Hmm, as an eclipse-plugin-prog dummy, I can't see so much problems arou=
nd.

The old binaries are still there.
The new binaries are essentially a new scm plugin. Where do they interf=
ere? They will have new names, config sections, etc isn't? We could als=
o ship an update to the old plugin introducing a clear name 'SpearceGit=
' or something. So it can easily be distinguished for those who need ol=
d projects in parallel.

In a few months time from now, almost all people will only have the new=
 org.eclipse plugin installed. And thus who have both old and new plugi=
ns installed should know how to select the proper one that way.

LieGrue,
strub

--- Alex Blewitt <alex.blewitt@gmail.com> schrieb am Fr, 19.6.2009:

> Von: Alex Blewitt <alex.blewitt@gmail.com>
> Betreff: Re: [egit-dev] Re: [EGIT PATCH] Rename org.spearce.egit -> o=
rg.eclipse.egit
> An: "EGit developer discussion" <egit-dev@eclipse.org>
> CC: "Robin Rosenberg" <robin.rosenberg@dewire.com>, "git@vger.kernel.=
org" <git@vger.kernel.org>, "egit-dev@eclipse.org" <egit-dev@eclipse.or=
g>
> Datum: Freitag, 19. Juni 2009, 10:47
> One possibility is to provide a
> compatibility bundle such that the old API subclasses the
> refactored classses. That way, existing projects will
> continue to work.
>=20
> However, it is quite likely to be difficult to do it with
> 100% success so another option might be to provide an
> upgrade option, only visible to the older projects , which
> will do the change in place.
>=20
> But since it's a fairly major change, and that people will
> have to go somewhere else to get the plugins etc, it is
> probably a more efficient use of time to just make a note in
> the release notes about the change and let people upgrade
> themselves.
>=20
> Alex
>=20
> Sent from my (new) iPhone
>=20
> On 19 Jun 2009, at 00:24, "Shawn O. Pearce" <spearce@spearce.org>
> wrote:
>=20
> > Robin Rosenberg <robin.rosenberg@dewire.com>
> wrote:
> >>=20
> >> Need an idea on how to proceed here. There is a
> problem related to updating
> >> plugins here. We have renamed feature with one
> unrenamed plugin. How
> >> to we avoid problem when switching from
> org.spearce to org.eclipse
> >>=20
> >> One option is to release a v0.4.1 (which we should
> do anyway), which is the last
> >> version from master before the split. For
> technical reasons this will be
> >> a branch since the split occurred already.
> >>=20
> >> That 0.4.1 feature should require jgit < 0.5.
> Then we jgit to v0.5 and
> >> make org.eclipse.egit require jgit >=3D 0.5
> >>=20
> >> Having two EGit features will be confusing. You
> get two of everything. E.g.
> >> Team>Share will have two Git's to choose from,
> but you cannot tell which
> >> is which.
> >>=20
> >> That said, having both could be a feature, since
> it (didn't really try it), would
> >> be possible to switch between new and old
> workspaces and get the plugin
> >> configured for that workspace. The wierdness make
> me suggest we do
> >> not do this. If we really want it we could choose
> to create a proxy plugin
> >> for attaching old workspaces to the new plugins.
> >=20
> > Yikes.=A0 I didn't even consider this.=A0 My own
> workspaces freaked out
> > at the change, but I just deleted the projects from
> the workspace,
> > re-imported them, and re-attached them to the new team
> provider.
> > I never even gave it a second thought.
> >=20
> > You're right, we should have a better plan for
> existing deployments.
> >=20
> > Its a good thing I didn't just shove this into the
> tree, even though
> > it seemed simple on the surface.=A0 Too
> simple.=A0 :-)
> >=20
> > I like the 0.5 cut to define jgit versions pre/post
> split.=A0 But I'm
> > really not sure what to do about the rename on the
> EGit team provider
> > for existing workspaces.
> >=20
> > --Shawn.
> > _______________________________________________
> > egit-dev mailing list
> > egit-dev@eclipse.org
> > https://dev.eclipse.org/mailman/listinfo/egit-dev
> --
> To unsubscribe from this list: send the line "unsubscribe
> git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at=A0 http://vger.kernel.org/majordomo-info.html
>=20


     =20
