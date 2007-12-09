From: =?iso-8859-1?Q?Bj=F6rn?= Steinbrink <B.Steinbrink@gmx.de>
Subject: Re: git-svn branch naming question
Date: Sun, 9 Dec 2007 03:13:36 +0100
Message-ID: <20071209021336.GA8327@atjola.homenet>
References: <20071208010438.GE3199@genesis.frugalware.org> <20071208105901.GA2844@xp.machine.xx> <20071208141449.GH3199@genesis.frugalware.org> <20071208165657.GC2844@xp.machine.xx> <20071208235248.GK3199@genesis.frugalware.org> <20071209020510.GM3199@genesis.frugalware.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Peter Baumann <waste.manager@gmx.de>, git@vger.kernel.org
To: Miklos Vajna <vmiklos@frugalware.org>
X-From: git-owner@vger.kernel.org Sun Dec 09 03:14:19 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J1BgP-0002l3-4h
	for gcvg-git-2@gmane.org; Sun, 09 Dec 2007 03:14:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753225AbXLICNk convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 8 Dec 2007 21:13:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751659AbXLICNk
	(ORCPT <rfc822;git-outgoing>); Sat, 8 Dec 2007 21:13:40 -0500
Received: from mail.gmx.net ([213.165.64.20]:38951 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752743AbXLICNj (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 8 Dec 2007 21:13:39 -0500
Received: (qmail invoked by alias); 09 Dec 2007 02:13:37 -0000
Received: from i577AC58C.versanet.de (EHLO localhost) [87.122.197.140]
  by mail.gmx.net (mp027) with SMTP; 09 Dec 2007 03:13:37 +0100
X-Authenticated: #5039886
X-Provags-ID: V01U2FsdGVkX19fIxVbJLhfY9cBu5drP+udeEmSnchdps9cvpLhMD
	Xkdfnpnwow7tFU
Content-Disposition: inline
In-Reply-To: <20071209020510.GM3199@genesis.frugalware.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67584>

On 2007.12.09 03:05:10 +0100, Miklos Vajna wrote:
> On Sun, Dec 09, 2007 at 12:52:48AM +0100, Miklos Vajna <vmiklos@fruga=
lware.org> wrote:
> > >   [svn-remote "svn"]
> > >         url =3D https://url/to/your/svn/repo
> > >         fetch =3D trunk:refs/heads/trunk
                                 ^^^^^
> > >         branches =3D branches/*:refs/heads/*
                                         ^^^^^
> > >         tags =3D tags/*:refs/heads/tags/*
                                 ^^^^^

>         url =3D svn+ssh://vmiklos@svn.gnome.org/svn/ooo-build
>         fetch =3D trunk:refs/master
>         branches =3D branches/*:refs/*
>         tags =3D tags/*:refs/tags/*

Just a guess, but this seems pretty headless ;-)

Bj=F6rn

> and wanted to fetch the revisions, but actually
>=20
> $ git svn fetch
>=20
> does not fetch any revisions. (yes, it does once i put back the
> "remotes" prefix). is this a bug? :)
>=20
> thanks,
> - VMiklos
