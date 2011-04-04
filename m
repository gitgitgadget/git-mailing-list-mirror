From: Robert David <robert.david.public@gmail.com>
Subject: Re: GSOC idea: build in scripts and cleanups
Date: Mon, 4 Apr 2011 09:43:09 +0200
Organization: DDM Praha
Message-ID: <201104040943.10030.robert.david.public@gmail.com>
References: <201103260141.20798.robert.david.public@gmail.com> <20110328142121.GB14763@sigill.intra.peff.net> <201103301739.12691.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart3147494.zfHXMaNGPz";
  protocol="application/pgp-signature";
  micalg=pgp-sha256
Content-Transfer-Encoding: 7bit
Cc: Jeff King <peff@peff.net>, Jonathan Nieder <jrnieder@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Matthieu Moy <Matthieu.Moy@imag.fr>
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Mon Apr 04 09:43:21 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q6eRU-000228-1j
	for gcvg-git-2@lo.gmane.org; Mon, 04 Apr 2011 09:43:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753570Ab1DDHnP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Apr 2011 03:43:15 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:61750 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751378Ab1DDHnO (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Apr 2011 03:43:14 -0400
Received: by fxm17 with SMTP id 17so3703567fxm.19
        for <git@vger.kernel.org>; Mon, 04 Apr 2011 00:43:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:organization:to:subject:date:user-agent:cc
         :references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:message-id;
        bh=ooKveGS7mjuAhrOtUM9UWV7XVczMcQEZzL5vMNbGSzU=;
        b=i11d615q1E6fyNJ9pLhV1W3fPrEMEwhd3966rm52Q3wO7r3xxxBe8E/okB0CtVUTXK
         Z9IV059+gFoZ0dD6PQVnvlt9MzqP+rBpG55ngUXDMtvrp1aa0Cz2RQieZJkokWYLQ1l1
         RQDWXsEJZHMlqE4fEGqdicoji0LoCAKO6Vu7w=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:organization:to:subject:date:user-agent:cc:references
         :in-reply-to:mime-version:content-type:content-transfer-encoding
         :message-id;
        b=wwKE5Q5vPatQGNaF3tb0RnSYYPpKEZsrOL2JTl89npeT4NygCaiwqF1UCXI+JiwoVF
         ibogDwdibGBKUXKDgg/xnm4PYKTYTCLbyllxcTHJjacvPnulpuOXVRrrUyHShBuBeoSF
         9hCLEdsZbuLzI8WjaZZ820VxWs1ImuMVZkM5s=
Received: by 10.223.27.14 with SMTP id g14mr529930fac.129.1301902992945;
        Mon, 04 Apr 2011 00:43:12 -0700 (PDT)
Received: from robert-eee.localnet (gate.chabry.cz [80.92.246.13])
        by mx.google.com with ESMTPS id n15sm1586461fam.12.2011.04.04.00.43.10
        (version=SSLv3 cipher=OTHER);
        Mon, 04 Apr 2011 00:43:11 -0700 (PDT)
User-Agent: KMail/1.13.5 (Linux/2.6.32-5-686; KDE/4.4.5; i686; ; )
In-Reply-To: <201103301739.12691.trast@student.ethz.ch>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170795>

--nextPart3147494.zfHXMaNGPz
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

As a advice from Jonathan Nieder. I'm sending copy of my proposal to ml.

Robert.

####################################################
Abstract
Today git code consists of the base written in C and many helper shell or P=
ERL=20
scripts. While at a first time it is easier to write the script, final code=
 is=20
supposed to be in C. One of these scripts is git-add--interactive.=20

Git-add--interactive is a helper script for git-add, which servers its opti=
ons=20
=2Di and -p. It definitely need to be integrated in git-add.
Which means, dividing the script in two parts: git-add -p and git-add -i. T=
his=20
involves usage of some code being written already in git.
Than writing some new functions common for both --patch and --interactive. =
And=20
at last, fully integrating these options in git-add.

But before that, it is need to clean and extend the current git-add--
interactive, to serve user needs at the best.=20
This means for example rewrite the main part of the way the patches are cho=
sen=20
by user, to let the user more flexibility.


Project goals
Main and final project goal is integrating fully git-add--interactive into=
=20
current git-add code.
This task also include cleaning the functionality of this code, to make the=
se=20
functions more "standardized".=20
This means consolidate the differences in these functions and make them mor=
e=20
consistent in the user point of view.

How to consider this project has success? That is pretty easy, the already=
=20
done functionality will be integrated in git-add and the user usage would b=
e=20
consistent.


Interfaces
As this is mainly part of git-add, that means that it will need to be chang=
ed=20
at the most.
There are also another commands using this functionality now: git-am, git-
checkout, git-rebase.=20
So there is possibility that there would be some changes needs to be done t=
o=20
adopt new interface.

I want to use as much code as possible from current git code-base, but this=
=20
means further analysis to decide what exactly use and what not.


Time-line=20
The official time-line consists of 12 coding week, starting 24th May. The m=
id-
evaluation is in the 8th week.
So the plan is written in week order beginning on the first coding week.=20

1) Pre-coding time
I will read the documentation, analyze the git-add--interactive code and=20
possibly change some small amount of code there.=20
To clean thinks up for upcoming work. I will also seek the git code to find=
 out=20
where is what, for further rewriting analyze.

2) 1-3 week
Get the code of git-add--interactive cleaned and possibly written some of t=
he=20
consistency stuff.
Analyze the code with the focus on code already written in C.

3) 4-5 week
Get the cleaning and consistency stuff done.=20
Collect the community feedback to the code, to get things improve where it =
is=20
needed.

4) 6-7 week
Start the rewriting period, this will provide some architectonic basis to b=
e=20
included in git-add.

5) 8-11 week
Extend the C code to the state it should be.
Adopt other git commands to work with the new interface correctly.
Test extensively.
Update documentation where needed.

6) 12 week
Write more documentation, to document what was done and how.
Correct bugs and test.


About me
I'm a student of second year of bachelors study on Faculty of Information=20
Technology, Czech Technical University in Prague, Czech Republic.=20
I have some experience with C and script languages, because I did worked fo=
r=20
company making client software for two years.

I have never contribute to open source projects, in the means of submitting=
=20
patches (I did some bug-reporting in projects like midnight-commander, arch=
=20
linux, debian linux).=20
But as I love open source and use that for a long time, I realized I have t=
o=20
begin participating in development. Thus I see GSOC as a good startup for m=
e.
My prior experience is doing shell and PERL scripts, because I do that as=20
"every-week" work. I work also for Prague children free-time organization,=
=20
learning children open source stuff and little bit programming, mainly some=
=20
small scripts (www.ddmpraha.cz).

My git experience is purely user based. I use git for everyday work,=20
administrating my computers and servers, keeping track of my school works, =
and=20
my personal projects. In the past I wrote some scripts helping develop debi=
an=20
packages using purely git (as the software was not released yet I can't=20
explain it further and I also don't work for that company any more.=20
www.zonio.net).=20
Because of GSOC start I wanted to find out more information about this prop=
osal=20
on git mailing list (http://article.gmane.org/gmane.comp.version-
control.git/170036)
####################################################

--nextPart3147494.zfHXMaNGPz
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iF0EABEIAAYFAk2Zdo0ACgkQLSNWchw0XGwnzwD+MGcWDS+rDlf3wlo8xdDSPpQl
CEs54tCPbxlBQT1ZQqYA+IrKba36cZla+HU6yVeOuRUWBjjAhtqUkQIl6ArsaA8=
=urBd
-----END PGP SIGNATURE-----

--nextPart3147494.zfHXMaNGPz--
