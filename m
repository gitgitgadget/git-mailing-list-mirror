From: Romain Vimont =?ISO-8859-1?Q?=28=AEom=29?= <rom@rom1v.com>
Subject: Re: [BugReport] git tag -a / git show
Date: Fri, 24 Feb 2012 22:42:43 +0100
Message-ID: <1330119763.2727.10.camel@rom-laptop>
References: <b05f03b381140ca57a7d03a934f605bd@rom1v.com>
	 <4F47E48D.4080501@in.waw.pl> <1330113345.2727.3.camel@rom-laptop>
	 <20120224205203.GA21780@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Zbigniew =?UTF-8?Q?J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>,
	git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Feb 24 22:43:39 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S12vT-0005Qp-1Q
	for gcvg-git-2@plane.gmane.org; Fri, 24 Feb 2012 22:43:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758114Ab2BXVne convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 24 Feb 2012 16:43:34 -0500
Received: from rom1v.com ([78.236.177.60]:37203 "EHLO rom1v.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754766Ab2BXVnd (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Feb 2012 16:43:33 -0500
Received: from [192.168.0.101] (unknown [192.168.0.127])
	by rom1v.com (Postfix) with ESMTPSA id 1A21910DA;
	Fri, 24 Feb 2012 22:33:03 +0100 (CET)
In-Reply-To: <20120224205203.GA21780@sigill.intra.peff.net>
X-Mailer: Evolution 3.2.2-1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191488>

Thank you, I didn't know this '^' thing ;-)

Le vendredi 24 f=C3=A9vrier 2012 =C3=A0 15:52 -0500, Jeff King a =C3=A9=
crit :
> On Fri, Feb 24, 2012 at 08:55:45PM +0100, Romain Vimont (=C2=AEom) wr=
ote:
>=20
> > Tonight, I just tried something which do exactly what I wanted to d=
o
> > this morning:
> >=20
> > $ git checkout -b temp
> > $ git commit -a -m 'My config file with mock_data=3Dtrue'
> > $ git tag -a v0.1 -m v0.1
> > $ git checkout master
> > $ git branch -D temp
>=20
> There is nothing at all wrong with the commands above, but you might =
be
> interested to know that you can do it without the temporary branch:
>=20
>   $ git commit -a -m 'My config...'
>   $ git tag -m v0.1 v0.1
>   $ git reset HEAD^
>=20
> The final reset will rewind your branch tip and the index state to wh=
at
> it was before the commit, but will leave the files in the working tre=
e
> untouched.
>=20
> -Peff
>=20
