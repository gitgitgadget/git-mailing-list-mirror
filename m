From: "R. Tyler Ballance" <tyler@slide.com>
Subject: Re: Big project, slow access!
Date: Fri, 18 Sep 2009 14:32:16 -0700
Message-ID: <20090918213216.GJ18785@starfruit.corp.slide.com>
References: <ffb2c0280909181138r7fde8722n80be4bdf95864c37@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="72k7VsmfIboquFwl"
Cc: git@vger.kernel.org
To: Toan Pham <tpham3783@gmail.com>
X-From: git-owner@vger.kernel.org Fri Sep 18 23:56:15 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MolR7-0006fI-2g
	for gcvg-git-2@lo.gmane.org; Fri, 18 Sep 2009 23:56:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751515AbZIRVzt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 Sep 2009 17:55:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751372AbZIRVzs
	(ORCPT <rfc822;git-outgoing>); Fri, 18 Sep 2009 17:55:48 -0400
Received: from mx0.slide.com ([208.76.69.78]:57935 "EHLO mx0.slide.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750964AbZIRVzs (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Sep 2009 17:55:48 -0400
X-Greylist: delayed 1416 seconds by postgrey-1.27 at vger.kernel.org; Fri, 18 Sep 2009 17:55:48 EDT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=slide.com; s=slideinc; h=Date:From:To:Subject:Message-ID; bh=y
	ggU0gjGZOAnkeDKttrT9is0yAA1ARZDWjt/QV5tm9E=; b=q2eZjoOIQPN278r4m
	+Wo8b5MAIkoTktSyk7p+ubK+sRpmduc0iM++sqzocQK4w4ipyVm9IyTTmdBvqkfv
	WvjVlxtXhGV/jbtpRzwgeh7CSKA7fNCLGzPPO5JwzkUF4mKb3REAGHNNPnXpfGa3
	hjnovWzpWDWe5Cj0WBmHf4zvzo=
Received: from nat3.slide.com ([208.76.69.126]:51142 helo=calculon.corp.slide.com)
	by mx0.slide.com with esmtp (Exim 4.69 #1)
	id 1Mol3u-0001UR-Vu; Fri, 18 Sep 2009 14:32:15 -0700
Received: from localhost (localhost.localdomain [127.0.0.1])
	by calculon.corp.slide.com (Postfix) with ESMTP id ED2223898187;
	Fri, 18 Sep 2009 14:32:14 -0700 (PDT)
X-Virus-Scanned: amavisd-new at calculon.corp.slide.com
Received: from calculon.corp.slide.com ([127.0.0.1])
	by localhost (calculon.corp.slide.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id HhsWooDSZPm7; Fri, 18 Sep 2009 14:32:07 -0700 (PDT)
Received: from starfruit.corp.slide.com (starfruit.corp.slide.com [10.10.10.45])
	by calculon.corp.slide.com (Postfix) with ESMTP id 71B5138980B5;
	Fri, 18 Sep 2009 14:32:07 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <ffb2c0280909181138r7fde8722n80be4bdf95864c37@mail.gmail.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
X-Content-Bypass: Bypassed by sending host IP
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128814>


--72k7VsmfIboquFwl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


On Fri, 18 Sep 2009, Toan Pham wrote:

> Hi,
>=20
> I use git to maintain a project that is at least 8 gigs in size.
> The project is a Linux from Scratch repository that includes source
> codes to approximately 2000 open source projects,
> gcc tool-chain, 1000+ configurations for different software packages,
> source code for different kernel versions,
> and many linux distributions/flavors resulted from this LFS build environ=
ment.
>=20
> The git's object repository is now 4.6 gigs and consists of approx.
> 610,000 files and folders.
> The speed of git is now terribly slow.  Each time I use basic commands
> like 'git status' or 'git diff',
> it would take at least 5 minutes for git to give me back a result.
> Again, the machine that i run git on is a P4 3.2 gig-hertz with HT.

Howdy Toan, we have a similarly large repository ~405k files, the .git
folder fully packed is ~6GB.=20

The advise to fully-pack your repository is likely going to have the
greatest impact on your performance in the short term, in the long term
however you might want to consider using git-filter-branch(1) or other
tools available to separate our the components of your current Git
reposotory into a series of repos.

The performance hit you're seeing likely has nothing to do with your
processor speed either, but rather your disk search speed (i'm waiting
for a new fancy SSD to help alleviate my issues ;))

> would  someone please recommend on how i can optimize git's performance?
> Git is so slow, are there better ways to manage a project like this?

Rethink how your project is laid out, and whether certain binaries files
need to sit in the tree, or can be build on a need-by-need basis.



Cheers
-R. Tyler Ballance
Slide, Inc.

--72k7VsmfIboquFwl
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)

iEYEARECAAYFAkqz/GAACgkQFCbH3D9R4W+xEQCfWTIUFpwc1dyOIzE0UxFpRC7c
W6AAoK4hqFe6tNSu5Ktd+U167V3OdG3E
=7lqI
-----END PGP SIGNATURE-----

--72k7VsmfIboquFwl--
