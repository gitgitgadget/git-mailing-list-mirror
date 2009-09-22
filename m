From: "R. Tyler Ballance" <tyler@slide.com>
Subject: Re: Big project, slow access!
Date: Tue, 22 Sep 2009 08:22:09 -0700
Message-ID: <20090922152209.GA31806@starfruit.corp.slide.com>
References: <ffb2c0280909181138r7fde8722n80be4bdf95864c37@mail.gmail.com> <20090918213216.GJ18785@starfruit.corp.slide.com> <ffb2c0280909220751r79946d76x3b23b146077781f5@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="YZ5djTAD1cGYuMQK"
Cc: git@vger.kernel.org
To: Toan Pham <tpham3783@gmail.com>
X-From: git-owner@vger.kernel.org Tue Sep 22 17:22:13 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mq7Bz-0006mn-1u
	for gcvg-git-2@lo.gmane.org; Tue, 22 Sep 2009 17:22:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756847AbZIVPWB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Sep 2009 11:22:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756838AbZIVPWA
	(ORCPT <rfc822;git-outgoing>); Tue, 22 Sep 2009 11:22:00 -0400
Received: from mx0.slide.com ([208.76.69.78]:60881 "EHLO mx0.slide.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756779AbZIVPV7 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Sep 2009 11:21:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=slide.com; s=slideinc; h=Date:From:To:Subject:Message-ID; bh=r
	xRppYTqFOa3fzN4YaWj0Q6CUdqgUFrSpjirGQ2K/IA=; b=y0hN81rqTsZ/zSFAR
	mbWjDJzZH53+sawRSC8NLB8qojM6u9zwBxF7/S9Jmz7cDWo6OS8VDUGrTF/5yUrf
	vT0EadOTkeQvCavIICSQ/w/2ht/rbt0lLrsCiOtrfr6bMcqb/xFqHsIjwDVw22Kg
	lhOY4vtcxWamAnpmNMprESL2WM=
Received: from nat3.slide.com ([208.76.69.126]:45450 helo=calculon.corp.slide.com)
	by mx0.slide.com with esmtp (Exim 4.69 #1)
	id 1Mq7Br-0002Gb-K8; Tue, 22 Sep 2009 08:22:03 -0700
Received: from localhost (localhost.localdomain [127.0.0.1])
	by calculon.corp.slide.com (Postfix) with ESMTP id 952E4A6F0002;
	Tue, 22 Sep 2009 08:22:03 -0700 (PDT)
X-Virus-Scanned: amavisd-new at calculon.corp.slide.com
Received: from calculon.corp.slide.com ([127.0.0.1])
	by localhost (calculon.corp.slide.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id JZcTCnZ0ufLr; Tue, 22 Sep 2009 08:22:03 -0700 (PDT)
Received: from starfruit.corp.slide.com (starfruit.corp.slide.com [10.10.10.45])
	by calculon.corp.slide.com (Postfix) with ESMTP id 1DF06A6F0001;
	Tue, 22 Sep 2009 08:22:03 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <ffb2c0280909220751r79946d76x3b23b146077781f5@mail.gmail.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
X-Content-Bypass: Bypassed by sending host IP
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128940>


--YZ5djTAD1cGYuMQK
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


On Tue, 22 Sep 2009, Toan Pham wrote:

> Dear Tyler
>=20
>=20
> Thank you for your valuable feedback.
>=20
> I'll research into git-filter-branch and also dividing a big project
> into several sub-repositories.
> This seems to increase the performance very much; however, there is a
> draw-back that I am a little bit
> concern with.  When we use several sub-repos option, we would probably
> do manual book-keeping as to
> which repo commits are compatible/built-able with other repo. commits.
>  How did you manage to track
> dependencies and their versions between different depos?

This wholly depends on how your project laid out, for example, if your
sub-repositories are on different project timelines (shared components
come to mind) where you would want to update that submodule's HEAD in
the super-project. It's worth making sure you're aware of what you're
getting yourself into with git-submodule(1) before you dive in and start
splitting your project into submodules:

	http://www.kernel.org/pub/software/scm/git/docs/user-manual.html#submodules
	http://github.com/guides/developing-with-submodules

You could also look at using submodules and Android's repo command:
	http://source.android.com/download/using-repo



> >>i'm waiting for a new fancy SSD to help alleviate my issues.
>=20
> Please report the performance increase after you tested on your SS Drive.

This was tongue-in-cheek, I can't afford an SSD in my laptop just yet ;)



Cheers

> On Fri, Sep 18, 2009 at 5:32 PM, R. Tyler Ballance <tyler@slide.com> wrot=
e:
> >
> > On Fri, 18 Sep 2009, Toan Pham wrote:
> >
> >> Hi,
> >>
> >> I use git to maintain a project that is at least 8 gigs in size.
> >> The project is a Linux from Scratch repository that includes source
> >> codes to approximately 2000 open source projects,
> >> gcc tool-chain, 1000+ configurations for different software packages,
> >> source code for different kernel versions,
> >> and many linux distributions/flavors resulted from this LFS build envi=
ronment.
> >>
> >> The git's object repository is now 4.6 gigs and consists of approx.
> >> 610,000 files and folders.
> >> The speed of git is now terribly slow. =A0Each time I use basic comman=
ds
> >> like 'git status' or 'git diff',
> >> it would take at least 5 minutes for git to give me back a result.
> >> Again, the machine that i run git on is a P4 3.2 gig-hertz with HT.
> >
> > Howdy Toan, we have a similarly large repository ~405k files, the .git
> > folder fully packed is ~6GB.
> >
> > The advise to fully-pack your repository is likely going to have the
> > greatest impact on your performance in the short term, in the long term
> > however you might want to consider using git-filter-branch(1) or other
> > tools available to separate our the components of your current Git
> > reposotory into a series of repos.
> >
> > The performance hit you're seeing likely has nothing to do with your
> > processor speed either, but rather your disk search speed (i'm waiting
> > for a new fancy SSD to help alleviate my issues ;))
> >
> >> would =A0someone please recommend on how i can optimize git's performa=
nce?
> >> Git is so slow, are there better ways to manage a project like this?
> >
> > Rethink how your project is laid out, and whether certain binaries files
> > need to sit in the tree, or can be build on a need-by-need basis.
> >
> >
> >
> > Cheers
> > -R. Tyler Ballance
> > Slide, Inc.
> >
-R. Tyler Ballance
Slide, Inc.

--YZ5djTAD1cGYuMQK
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)

iEYEARECAAYFAkq466EACgkQFCbH3D9R4W8giACeIrcswFOv6FHHOmsgwHoBg7hg
JGYAn02HtZ6PCpMvb5Ae91Yn4EKTYkGc
=/YMB
-----END PGP SIGNATURE-----

--YZ5djTAD1cGYuMQK--
