From: Mark Struberg <struberg@yahoo.de>
Subject: Re: [JGIT PATCH 1/9] mavenizing step 1: moved over the initial poms  from Jasons branch Signed-off-by: Mark Struberg <struberg@yahoo.de>
Date: Thu, 1 Oct 2009 11:15:29 +0000 (GMT)
Message-ID: <138076.57408.qm@web27806.mail.ukl.yahoo.com>
References: <7BE83B1E-200A-4E19-979D-7A53CE582468@sonatype.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	Jonas Fonseca <jonas.fonseca@gmail.com>,
	Robin Rosenberg <robin.rosenberg.lists@dewire.com>,
	git@vger.kernel.org
To: Jason van Zyl <jason@sonatype.com>
X-From: git-owner@vger.kernel.org Thu Oct 01 13:15:40 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MtJdL-0005Mn-B5
	for gcvg-git-2@lo.gmane.org; Thu, 01 Oct 2009 13:15:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756376AbZJALP2 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 1 Oct 2009 07:15:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756370AbZJALP2
	(ORCPT <rfc822;git-outgoing>); Thu, 1 Oct 2009 07:15:28 -0400
Received: from web27806.mail.ukl.yahoo.com ([217.146.182.11]:41352 "HELO
	web27806.mail.ukl.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1756360AbZJALP1 convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>); Thu, 1 Oct 2009 07:15:27 -0400
Received: (qmail 85761 invoked by uid 60001); 1 Oct 2009 11:15:30 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.de; s=s1024; t=1254395730; bh=r7qBAAyuAIkxbsxJLfsZIvyPUcxLtYzZxe0k7SI7SpM=; h=Message-ID:X-YMail-OSG:Received:X-Mailer:Date:From:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding; b=WuW/UPexfsTKlxA+ebEApH/xtk7Uhe40CTWFGumMK6naPrQi1dOvTCvqYx+3pl4oQ48h9oIW4PNMvXhuI/oi8xLiqzLKv6YJXxs+hX4D/kw9iJlGBWh4Oz/iEVa+fF3UveTeqFrP745s8R61F+seprX48H5GcL3z5qT95HUs47Q=
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.de;
  h=Message-ID:X-YMail-OSG:Received:X-Mailer:Date:From:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=UMrRd8g6PtRExv7EqIGjFW4ZBfAKUlTRngZoJJ70tFYbrBEO8MCMSQiOjXm0G/2graLBmTbViK49c6VQ04OAGHJukitJQOpgu+5x60iW93WfZFzUgOyUfFRjWTVJwmL1GqcLbx55LuotYp93G7PI3GGWFJXf5rCEYo+I90PVAcM=;
X-YMail-OSG: XD.XBdIVM1mkRf3ppGKnhTQTZJzVai6jAKzs6NopDuegn0yZrs0EU5OL82XB9B2eq_h7yX61PhxaWzJkUd2L.m2itBqQY28WrAAzcgbSmlFIdnjBSM9yM6hm8FpPnRl34kOG22B889eStef.twoK4Dn_A2DxWrJXb0_SwyB3rmQrNziZwbHDlrQ6S13yjkqX9LUr_Q4RbUrmHefXE_iAz3t0phK1QL80i_sEjVOKD3BKiL7ngC2m7Q1TrGTRXFHVFrum464Ju1AN2oQwZD.lDw9TS5NH4zM2Kw0WibLufJSAEm3GSU6Pp4txEl2EsOOp6w8AH5P8b.NaWYIoMzk2aWz0VYIweYUirNeoKHrm8Sk-
Received: from [81.16.153.112] by web27806.mail.ukl.yahoo.com via HTTP; Thu, 01 Oct 2009 11:15:29 GMT
X-Mailer: YahooMailClassic/7.0.14 YahooMailWebService/0.7.347.3
In-Reply-To: <7BE83B1E-200A-4E19-979D-7A53CE582468@sonatype.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129385>

Can you please create an EGit repo on github.com/sonatype and push the =
JGit changes to a fresh branch in sonatype/JGit ?

txs,
strub

--- On Thu, 10/1/09, Jason van Zyl <jason@sonatype.com> wrote:

> From: Jason van Zyl <jason@sonatype.com>
> Subject: Re: [JGIT PATCH 1/9] mavenizing step 1: moved over the initi=
al poms  from Jasons branch Signed-off-by: Mark Struberg <struberg@yaho=
o.de>
> To: "Mark Struberg" <struberg@yahoo.de>
> Cc: "Shawn O. Pearce" <spearce@spearce.org>, "Jonas Fonseca" <jonas.f=
onseca@gmail.com>, "Robin Rosenberg" <robin.rosenberg.lists@dewire.com>=
, git@vger.kernel.org
> Date: Thursday, October 1, 2009, 1:16 AM
>=20
> On 2009-09-30, at 4:13 PM, Mark Struberg wrote:
>=20
> > Hi!
> >=20
> > I now squashed all my changes into 2 commits and
> omitted the eclipse parts. They are available at
> >=20
> > http://github.com/sonatype/JGit/commits/mavenize2
> >=20
> > As Shawn pointed out on IRC, the next step would be to
> migrate this patch over to the eclipe.org-post branch which
> I will do tomorrow evening.
> >=20
>=20
> I also have a Tycho build for the EGIT part, and I have
> bundle creation working for the JGIT part. I've already
> integrated these two builds into our product so it all
> works. I can put it somewhere as you're ready to absorb it
> if you want it.
>=20
> > LieGrue,
> > strub
> >=20
> > --- On Wed, 9/30/09, Shawn O. Pearce <spearce@spearce.org>
> wrote:
> >=20
> >> From: Shawn O. Pearce <spearce@spearce.org>
> >> Subject: Re: [JGIT PATCH 1/9] mavenizing step 1:
> moved over the initial poms=A0 from Jasons branch
> Signed-off-by: Mark Struberg <struberg@yahoo..de>
> >> To: "Mark Struberg" <struberg@yahoo.de>
> >> Cc: "Jonas Fonseca" <jonas.fonseca@gmail.com>,
> "Robin Rosenberg" <robin.rosenberg.lists@dewire.com>,
> git@vger.kernel.org,
> "Jason van Zyl" <jvanzyl@sonatype.com>
> >> Date: Wednesday, September 30, 2009, 11:16 PM
> >> Mark Struberg <struberg@yahoo.de>
> >> wrote:
> >>>> From: Jonas Fonseca <jonas.fonseca@gmail.com>
> >>>> actually
> >>>> removes features (by not keeping the JGit
> >> specific
> >>>> settings), which
> >>>> you then try to amend later in the patch
> series.
> >>>=20
> >>> I'm not sure what JGit specific settings you
> speak
> >> about?
> >>=20
> >> I think he's talking about the Eclipse settings
> >> files?=A0 Or is it
> >> something else?
> >>=20
> >>>> In terms of making the patch series more
> >> manageable for
> >>>> you, I think
> >>>> the best approach is to start with the
> patches
> >> not relevant
> >>>> to the
> >>>> mavenizing (renaming PathSuffixTestCase).
> >>>=20
> >>> In fact the fix of the PathSuffixTestCase came
> a few
> >> days later
> >>> after I found the reason why I miss a few
> tests. This
> >> should be
> >>> fixed in the current master anyway and has not
> so much
> >> todo with
> >>> the mavenization itself.
> >>=20
> >> But it should be earlier in the series because its
> easier
> >> to apply.
> >> Use rebase -i to swap the order of the patches.
> >>=20
> >>> I had the following in mind: every single
> commit
> >> should be
> >>>=A0=A0=A0compileable and working. So
> it's not easily
> >> manageable to move the
> >>> directory structure in one patch and apply all
> the
> >> changes into
> >>> the poms in another commit.
> >>=20
> >> Well, you need to edit the pom to change the
> source
> >> directory and do
> >> the move in one commit, and then edit the pom
> further in
> >> another,
> >> possibly removing the source directory directories
> once it
> >> is the
> >> standard maven layout.
> >>=20
> >>> We could for sure squash the later few
> commits, but I
> >> didn't
> >>> liked to rebase and push since there have been
> a few
> >> forks of the
> >>> mavenize branch and I hoped I could pull back
> a few
> >> commits from
> >>> others and later do a rebase -i.
> >>=20
> >> True.
> >>=20
> >> At this point we need to rebase the patches on the
> new
> >> history in
> >> the eclipse.org-post branch, which contains a
> massive
> >> rename of
> >> org.spearce to org.eclipse.=A0 That may make
> the tree
> >> reorg patch in
> >> your Maven series harder to bring over to the new
> history,
> >> sorry.
> >>=20
> >> Worse, we now have to start following the Eclipse
> IP
> >> process[1]
> >> for submissions to JGit...
> >>=20
> >> [1] http://www.eclipse.org/projects/dev_process/ip-process-in-cart=
oons.php
> >>=20
> >> --Shawn.
> >> --
> >> To unsubscribe from this list: send the line
> "unsubscribe
> >> git" in
> >> the body of a message to majordomo@vger.kernel.org
> >> More majordomo info at=A0 http://vger.kernel.org/majordomo-info.ht=
ml
> >>=20
> >=20
> >=20
> >=20
> >=20
>=20
> Thanks,
>=20
> Jason
>=20
> ----------------------------------------------------------
> Jason van Zyl
> Founder,=A0 Apache Maven
> http://twitter.com/jvanzyl
> ----------------------------------------------------------
>=20
> --
> To unsubscribe from this list: send the line "unsubscribe
> git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at=A0 http://vger.kernel.org/majordomo-info.html
>=20


     =20
