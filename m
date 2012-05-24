From: SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder@ira.uka.de>
Subject: Re: [PATCH 2/2] completion: split __git_ps1 into a separate script
Date: Thu, 24 May 2012 22:35:49 +0200
Message-ID: <20120524203549.GA2052@goldbirke>
References: <1337719600-7361-1-git-send-email-felipe.contreras@gmail.com>
	<1337719600-7361-3-git-send-email-felipe.contreras@gmail.com>
	<4FBC0019.6030702@in.waw.pl>
	<7v4nr72bim.fsf@alter.siamese.dyndns.org>
	<CAMP44s0aKi+8WHPXYLQ+iSMkj9iV88JGTabrpBRNBWb7upAMiQ@mail.gmail.com>
	<CAOnadRF8XyZKi+d=y1fFy2Xvs-3ETVyCbJBj83mK3Q8yuK7oQw@mail.gmail.com>
	<CAMP44s3uW75O_jt2F7POxTAhX+qPyRSjOX9-DuEkg7a7WtnLsA@mail.gmail.com>
	<4FBD5CC1.3060701@tedpavlic.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Felipe Contreras <felipe.contreras@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Zbigniew =?utf-8?Q?J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>,
	git@vger.kernel.org, Thomas Rast <trast@student.ethz.ch>,
	Kerrick Staley <mail@kerrickstaley.com>,
	Marius Storm-Olsen <mstormo@gmail.com>,
	Ville =?iso-8859-1?Q?Skytt=E4?= <ville.skytta@iki.fi>,
	Dan McGee <dan@archlinux.org>
To: Ted Pavlic <ted@tedpavlic.com>
X-From: git-owner@vger.kernel.org Thu May 24 22:36:18 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SXelY-0004QS-5v
	for gcvg-git-2@plane.gmane.org; Thu, 24 May 2012 22:36:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751933Ab2EXUgH convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 24 May 2012 16:36:07 -0400
Received: from moutng.kundenserver.de ([212.227.17.9]:61096 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751181Ab2EXUgF (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 May 2012 16:36:05 -0400
Received: from localhost6.localdomain6 (p5B13046B.dip0.t-ipconnect.de [91.19.4.107])
	by mrelayeu.kundenserver.de (node=mreu0) with ESMTP (Nemesis)
	id 0Lxbn5-1S0JtU16OR-016u0G; Thu, 24 May 2012 22:35:51 +0200
Content-Disposition: inline
In-Reply-To: <4FBD5CC1.3060701@tedpavlic.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
X-Provags-ID: V02:K0:WeYbNo8WKyjZhrTU4Lf777pYCaDeRQHHihIeEpsAhat
 sGoR4TWhdRB0PGXFVQQKBlno5kMTvnGlatu41y/14d08g2Rv02
 XlMUxpzIktdZ6T3zGzeWfgoL4B7+oL6agDFxtH8ZXiHjhYZDrA
 SwTO/ogC+PO0+ul09XifNpFmaeHnyZk/40dVRKT3dl0ZwEjBHG
 /vhMfkP3T78wn3A55N22jOwFW8ymPJoWDI7reAWkBeCxOTHovU
 70oE1Ots9rVVETSbj9z2nbcQccbth2EXmRucYPXuY2eQW3PTWc
 p1t+qZJgy/PFZzk4EWc7XcXEV19zWhVtidxKMmF+a0AsWDyojy
 UXl1d0S5IJae4voBEN1s=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198420>

Hi,


On Wed, May 23, 2012 at 05:55:13PM -0400, Ted Pavlic wrote:
> > There's no way git-prompt.sh can be sourced without modifications t=
o
> > the script, unless you expect it would always be named
> > '.git-prompt.sh' and would be on the same directory, which many
> > distributions would frown upon.
>=20
> So, again, seems like a good argument for building a git-gitdir into =
git
> proper. Maybe there are other utilities that could make use of it as
> well...

You mean a real git command, which does the same as __gitdir()?  I
don't like that, because it will always require 2 fork()s and an
exec() and would be slow on Windows.


Best,
G=E1bor
