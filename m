From: Jim Garrison <jim.garrison@nwea.org>
Subject: RE: Documentation for fetch, url, branches, tags keywords in git
 config?
Date: Tue, 29 Oct 2013 19:42:19 +0000
Message-ID: <0C723FEB5B4E5642B25B451BA57E273041FD3FF7@S1P5DAG3C.EXCHPROD.USA.NET>
References: <0C723FEB5B4E5642B25B451BA57E273041FD3F9C@S1P5DAG3C.EXCHPROD.USA.NET>
 <20131029193716.GA9691@paksenarrion.iveqy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Fredrik Gustafsson <iveqy@iveqy.com>
X-From: git-owner@vger.kernel.org Tue Oct 29 20:42:43 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VbFBW-0003GU-Bv
	for gcvg-git-2@plane.gmane.org; Tue, 29 Oct 2013 20:42:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752639Ab3J2Tmd convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 29 Oct 2013 15:42:33 -0400
Received: from gwo4.mbox.net ([165.212.64.24]:45019 "EHLO gwo4.mbox.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752627Ab3J2Tmc convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 29 Oct 2013 15:42:32 -0400
Received: from gwo4.mbox.net (localhost [127.0.0.1])
	by gwo4.mbox.net (Postfix) with ESMTP id 3d8NVb53X1zfj64p;
	Tue, 29 Oct 2013 19:42:31 +0000 (UTC)
X-USANET-Received: from gwo4.mbox.net [127.0.0.1] by gwo4.mbox.net via mtad (C8.MAIN.3.82G) 
	with ESMTP id 908RJCTQZ9456Mo4; Tue, 29 Oct 2013 19:42:25 -0000
X-USANET-Routed: 5 gwsout-gwsd Q:gwsd
X-USANET-Routed: 3 gwsout-vs Q:bmvirus
X-USANET-GWS2-Tenant: nwea.org
X-USANET-GWS2-Tagid: NWEA
Received: from S1P5HUB5.EXCHPROD.USA.NET [165.212.120.254] by gwo4.mbox.net via smtad (C8.MAIN.3.93K) 
	with ESMTPS id XID067RJCTQZ7526Xo4; Tue, 29 Oct 2013 19:42:25 -0000
X-USANET-Source: 165.212.120.254 OUT  jim.garrison@nwea.org S1P5HUB5.EXCHPROD.USA.NET
X-USANET-MsgId: XID067RJCTQZ7526Xo4
Received: from S1P5DAG3C.EXCHPROD.USA.NET ([169.254.3.33]) by
 S1P5HUB5.EXCHPROD.USA.NET ([10.120.223.35]) with mapi id 14.03.0158.001; Tue,
 29 Oct 2013 07:42:20 -1200
Thread-Topic: Documentation for fetch, url, branches, tags keywords in git
 config?
Thread-Index: AQHO1N6eW8SxeXpvrUG0/iYsT4iQepoME+VQ
In-Reply-To: <20131029193716.GA9691@paksenarrion.iveqy.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [70.98.171.2]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236945>

I've already read that manpage.  It does not describe the meaning of "f=
etch", "branches" and "tags", and the significance of the ":refs/remote=
s/branches/*" syntax.

> -----Original Message-----
> From: Fredrik Gustafsson [mailto:iveqy.mailbox@gmail.com] On Behalf O=
f
> Fredrik Gustafsson
> Sent: Tuesday, October 29, 2013 12:37 PM
> To: Jim Garrison
> Cc: git@vger.kernel.org
> Subject: Re: Documentation for fetch, url, branches, tags keywords in=
 git
> config?
>=20
> On Tue, Oct 29, 2013 at 07:23:20PM +0000, Jim Garrison wrote:
> > A typical config
> >
> > [svn-remote "svn"]
> >         noMetadata =3D 1
> >         url =3D http://repository.url/svn
> >         fetch =3D trunk/etl_app:refs/remotes/etl_app/trunk
> >         branches =3D branches/etl_app/*:refs/remotes/branches/*
> >         tags =3D tags/etl_app/*:refs/remotes/tags/*
> >
> >
> > However, the manpage for git-config(1) does not include anything ex=
licit on
> "url", "fetch", "branches", 'tags", and the meaning of the syntax fol=
lowing
> the colon.
> >
> > Where can I find this info?
>=20
> Is the info in here what you're looking for?
> http://jk.gs/git-svn.html
>=20
> --
> Med v=E4nliga h=E4lsningar
> Fredrik Gustafsson
>=20
> tel: 0733-608274
> e-post: iveqy@iveqy.com
