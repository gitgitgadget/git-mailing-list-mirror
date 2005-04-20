From: Jan-Benedict Glaw <jbglaw@lug-owl.de>
Subject: Re: [GIT PATCH] I2C and W1 bugfixes for 2.6.12-rc2
Date: Wed, 20 Apr 2005 02:01:58 +0200
Message-ID: <20050420000158.GO8765@lug-owl.de>
References: <20050419043938.GA23724@kroah.com> <20050419185807.GA1191@kroah.com> <Pine.LNX.4.58.0504191204480.19286@ppc970.osdl.org> <20050419194728.GA24367@kroah.com> <Pine.LNX.4.58.0504191316180.19286@ppc970.osdl.org> <20050419214009.GA25681@kroah.com> <Pine.LNX.4.58.0504191449270.2274@ppc970.osdl.org> <1113949783.2129.4.camel@nosferatu.lan> <Pine.LNX.4.58.0504191539000.2274@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Martin Schlemmer <azarah@nosferatu.za.org>,
	Greg KH <greg@kroah.com>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Apr 20 01:57:56 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DO2bJ-0006Tu-SL
	for gcvg-git@gmane.org; Wed, 20 Apr 2005 01:57:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261288AbVDTACC convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Tue, 19 Apr 2005 20:02:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261290AbVDTACC
	(ORCPT <rfc822;git-outgoing>); Tue, 19 Apr 2005 20:02:02 -0400
Received: from lug-owl.de ([195.71.106.12]:38053 "EHLO lug-owl.de")
	by vger.kernel.org with ESMTP id S261288AbVDTAB7 convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Apr 2005 20:01:59 -0400
Received: by lug-owl.de (Postfix, from userid 1001)
	id 89B6919023E; Wed, 20 Apr 2005 02:01:58 +0200 (CEST)
To: Linus Torvalds <torvalds@osdl.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0504191539000.2274@ppc970.osdl.org>
X-Operating-System: Linux mail 2.6.10-rc2-bk5lug-owl 
X-gpg-fingerprint: 250D 3BCF 7127 0D8C A444  A961 1DBD 5E75 8399 E1BB
X-gpg-key: wwwkeys.de.pgp.net
User-Agent: Mutt/1.5.6+20040907i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Tue, 2005-04-19 15:43:54 -0700, Linus Torvalds <torvalds@osdl.org> w=
rote:
> On Wed, 20 Apr 2005, Martin Schlemmer wrote:
> >=20
> > Correct me if I am wrong, but the right way to do this is to set th=
e
> > hostname to just that - the hostname, and add 'domain foo.com'
> > to /etc/resolv.conf.=20
>=20
> I'll correct you.
>=20
> The fact is, that's not what people do. Not me, not kernel.org, not _=
any_
> of the machines I've got access to. They put the fully qualified name=
 in=20
> the hostname, and just do "search foo.com" in /etc/resolv.conf.

That's not entirely correct. Actually, basically all machines
(administered by a number of people) only have the real hostname in
/etc/hostname and a domain entry in /etc/resolv.conf .

> So clearly, expecting that people work the way you claim is being
> extremely optimistic. I'm sure some people do that too, but I suspect=
 I'm
> in the majority. Both Fedora Core and YellowDog act the way I describ=
ed,=20
> not the way you do..

Maybe these two do it that way. I just checked a recently installed
Debian box--they to it the way I'm used to^W^W^WMartin describes it.

MfG, JBG

--=20
Jan-Benedict Glaw       jbglaw@lug-owl.de    . +49-172-7608481         =
    _ O _
"Eine Freie Meinung in  einem Freien Kopf    | Gegen Zensur | Gegen Kri=
eg  _ _ O
 fuer einen Freien Staat voll Freier B=C3=BCrger" | im Internet! |   im=
 Irak!   O O O
ret =3D do_actions((curr | FREE_SPEECH) & ~(NEW_COPYRIGHT_LAW | DRM | T=
CPA));
