From: Robert David <robert.david.public@gmail.com>
Subject: Re: GSOC idea: build in scripts and cleanups
Date: Thu, 7 Apr 2011 15:30:18 +0200
Organization: DDM Praha
Message-ID: <201104071530.19566.robert.david.public@gmail.com>
References: <201103260141.20798.robert.david.public@gmail.com> <201104040943.10030.robert.david.public@gmail.com> <20110405165212.GB9965@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart5089457.IQ0NarRyqK";
  protocol="application/pgp-signature";
  micalg=pgp-sha256
Content-Transfer-Encoding: 7bit
Cc: Thomas Rast <trast@student.ethz.ch>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Matthieu Moy <Matthieu.Moy@imag.fr>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Apr 07 15:31:52 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q7pJO-0003Ms-MQ
	for gcvg-git-2@lo.gmane.org; Thu, 07 Apr 2011 15:31:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755986Ab1DGNb1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 Apr 2011 09:31:27 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:39214 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754633Ab1DGNa1 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Apr 2011 09:30:27 -0400
Received: by bwz15 with SMTP id 15so1999849bwz.19
        for <git@vger.kernel.org>; Thu, 07 Apr 2011 06:30:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:organization:to:subject:date:user-agent:cc
         :references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:message-id;
        bh=7jQU8FEgVGJMW83FcG6/9bTjNk9uBm0ruPFAAggNdLw=;
        b=kS68fMndZfsqgMpbYPj/cm8QD0K/t1VDrH7GsQe0UydcsU1djOMbyGwtv1efGBphgv
         wD/vFLkAw8XlSd6C+0saNr7McxzI3b5MbW8522O8UDC2jNWAa8S/9XUUAhrIk9XBtRGb
         1RLCX2UjWSx5xa7SLysA07gpur+pZ9SkE1KkE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:organization:to:subject:date:user-agent:cc:references
         :in-reply-to:mime-version:content-type:content-transfer-encoding
         :message-id;
        b=xoC1fSIJ1KCOae/CuT0F9WQXHaW9TEUeLVysJ1bcSsYEHoyzyBGcTrVK2izsqxeE+j
         QMWk3XilPij/FJ89slvfoVR2c79qphocQEx6u5o+kXrqaY6FGCQrfCf/F+JmOBDXNbUZ
         +4PCoB5voS/3xg1zzDngSXIvx1ls8Q1LEdhJ0=
Received: by 10.204.16.209 with SMTP id p17mr200431bka.17.1302183026394;
        Thu, 07 Apr 2011 06:30:26 -0700 (PDT)
Received: from robert-eee.localnet ([217.169.177.82])
        by mx.google.com with ESMTPS id x6sm1078816bkv.0.2011.04.07.06.30.23
        (version=SSLv3 cipher=OTHER);
        Thu, 07 Apr 2011 06:30:24 -0700 (PDT)
User-Agent: KMail/1.13.5 (Linux/2.6.32-5-686; KDE/4.4.5; i686; ; )
In-Reply-To: <20110405165212.GB9965@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171059>

--nextPart5089457.IQ0NarRyqK
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable

I'm sending the updated proposal.=20

I was thinking about that and realized to do the cleaning and update of git-
add--interactive during GSoC and try to get that upstream (master,next).=20
And as second part, start rewriting it into the C as longer term project.=20
Which will lead in reviews past the GSoC during the year.


Robert.

########################################################
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
by use, to let the user more flexibility.


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
As this project is a bit longer term for GSoC period,=20
the final from GSoC point of view will be doing the first part of the work=
=20
completely (the script part)=20
and prepare the C part as architectonic preview for ongoing review.

How to consider this project has success?
That is pretty easy, the cleaned and extended git-add--interactive script w=
ill=20
be merged into the master branch.

Interfaces

As this is mainly part of git-add, that means that it will need to be chang=
ed=20
at the most.
There are also another commands using this functionality now: git-stash.=20
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

4) 6-8 week
Work on the extensions to the script. Test and repair bugs, that will occur=
=2E=20
Start the rewriting period, this will provide some architectonic basis to b=
e=20
included in git-add.

5) 9-11 week
Collect reviews and solve bugs.
Continue with the rewriting work.=20
Test extensively.
Update documentation where needed.

6) 12 week
Write more documentation, to document what was done and how.
Correct remaining bugs and test.


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
packages using purely git (as the software was not released yet I cant expl=
ain=20
it further and I also don't work for that company any more. www.zonio.net).=
=20
Because of GSOC start I wanted to find out more information about this prop=
osal=20
on git mailing list (http://article.gmane.org/gmane.comp.version-
control.git/170036)
########################################################

--nextPart5089457.IQ0NarRyqK
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iF4EABEIAAYFAk2dvGsACgkQLSNWchw0XGxUDQD/bFzCKbsSYS/oVHzHa0+5L0zq
IINj9JBkbfM6T8HdGJAA/jq3nF8wX9O2hl7YlWy/USZWDui2T7RpFQnqvcnSYN56
=HlYx
-----END PGP SIGNATURE-----

--nextPart5089457.IQ0NarRyqK--
