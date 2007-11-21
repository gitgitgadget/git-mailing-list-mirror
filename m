From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Wishlist for a bundle-only transport mode
Date: Wed, 21 Nov 2007 16:04:57 +0100
Organization: At home
Message-ID: <fi1heo$u4i$1@ger.gmane.org>
References: <8aa486160711210654p357ccd87i4809e0cda9471303@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Nov 21 16:10:27 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IurDI-0005Rf-2e
	for gcvg-git-2@gmane.org; Wed, 21 Nov 2007 16:10:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755724AbXKUPJg convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 21 Nov 2007 10:09:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755699AbXKUPJg
	(ORCPT <rfc822;git-outgoing>); Wed, 21 Nov 2007 10:09:36 -0500
Received: from main.gmane.org ([80.91.229.2]:33794 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755659AbXKUPJf (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Nov 2007 10:09:35 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1IurBF-0007pj-EQ
	for git@vger.kernel.org; Wed, 21 Nov 2007 15:07:57 +0000
Received: from abxf19.neoplus.adsl.tpnet.pl ([83.8.255.19])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 21 Nov 2007 15:07:57 +0000
Received: from jnareb by abxf19.neoplus.adsl.tpnet.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 21 Nov 2007 15:07:57 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: abxf19.neoplus.adsl.tpnet.pl
Mail-Copies-To: Jakub Narebski <jnareb@gmail.com>
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65661>

Santi B=E9jar wrote:

> 3) I can "git fetch" a bundle but I cannot "git push" a bundle, so if=
 I have:
>=20
> [remote "bundle"]
> =A0 url =3D /file/to/bundle
> =A0 fetch =3D "+refs/heads/*:refs/remotes/bundle/*"
>=20
> $ git push bundle
>=20
> would create a bundle in /file/to/bundle with the same branches as a
> normal git push, but considering the remote branches as the local
> remotes/bundle/*

And how you would differentiate between path meaning bundle, and
path meaning "local" protocol, i.e. git repository on the same
filesystem? "bundle =3D /file/to/bundle" perhaps...

--=20
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
