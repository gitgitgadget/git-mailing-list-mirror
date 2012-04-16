From: SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder@ira.uka.de>
Subject: Re: [PATCH] tests: add tests for the bash prompt functions in the
	completion script
Date: Mon, 16 Apr 2012 12:20:14 +0200
Message-ID: <20120416102014.GF2900@goldbirke>
References: <1334521909-32581-1-git-send-email-szeder@ira.uka.de>
	<CAMP44s3LJO_Ryc-ONjF+rEHCb1hB8+4Muar6pzjD3zrazYqK+A@mail.gmail.com>
	<20120416094938.GE2900@goldbirke>
	<CAMP44s0vkH9iE4MoV7HgGwOXna40pAL=h6be13qdreexp5_14w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Jonathan Nieder <jrnieder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Thomas Rast <trast@student.ethz.ch>, Jeff King <peff@peff.net>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Mon Apr 16 12:20:29 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SJj2q-0006wb-Ho
	for gcvg-git-2@plane.gmane.org; Mon, 16 Apr 2012 12:20:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752662Ab2DPKUT convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 16 Apr 2012 06:20:19 -0400
Received: from moutng.kundenserver.de ([212.227.17.10]:59393 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752415Ab2DPKUS (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Apr 2012 06:20:18 -0400
Received: from localhost6.localdomain6 (p5B130635.dip0.t-ipconnect.de [91.19.6.53])
	by mrelayeu.kundenserver.de (node=mreu1) with ESMTP (Nemesis)
	id 0LehOU-1RvtoX0kGc-00prXa; Mon, 16 Apr 2012 12:20:15 +0200
Content-Disposition: inline
In-Reply-To: <CAMP44s0vkH9iE4MoV7HgGwOXna40pAL=h6be13qdreexp5_14w@mail.gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
X-Provags-ID: V02:K0:3+gAPi+SEtIOdUP9fy+uhqjGDENHQhWfoongqyGVear
 ZoXIu7rhWgYAHEOCRCQhsUsKhqzp0eEjk1fZechw2YY9z+aI+R
 Pggm1+AeKjg+lv4Rrj4mQM2i397zf5cYyo/QY0pbj8aMiWGbZp
 HO3bkBl6seU9pzqny93dLL78Lle9V9xmGYC723ovQ4TvmdQxAH
 QucmqB1bE/6zm8Q+vuM4jZtZ2lV5R1o64t0a/yV6AZrCpafQKv
 iVp+I7uH5/5JxAq1FQh1b6LEaW5EbnQDWpfETfcZTXHJ7iQIi9
 r32pyPdIgRH1JntaY1g0O9qxr/m1g8wNrRjjTtwApzVepPlivz
 YK8m/dhVySkrG4rz8e30=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195608>

On Mon, Apr 16, 2012 at 01:04:41PM +0300, Felipe Contreras wrote:
> >> specially since there's the plan of splitting the prompt stuff to =
a
> >> separate file.
> >
> > Oh, I was not aware of such a plan. =A0What would be the benefits o=
f
> > such a move, why is it necessary? =A0Where would you split it up? =A0=
In
> > particular, what would happen with __gitdir(), which is used in man=
y
> > completion functions and in __git_ps1() as well?
>=20
> I guess __gitdir() would be duplicated, I don't think that has been d=
iscussed.
>=20
> http://thread.gmane.org/gmane.comp.version-control.git/194188
>=20
> Basically splitting helps for systems that use bash-completion, and
> also helps for zsh users who don't want the bash completion, but stil=
l
> want __git_ps1(). I split the file myself for this reason.

Thanks for the pointer, those are valid reasons.  I'll wait a day or
two for feedback, then resubmit as a different test script.


G=E1bor
