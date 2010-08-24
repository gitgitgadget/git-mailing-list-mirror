From: Clemens Buchacher <drizzd@aon.at>
Subject: Re: [PATCH] optionally disable overwriting of ignored files
Date: Tue, 24 Aug 2010 09:28:54 +0200
Message-ID: <20100824072854.GA22951@localhost>
References: <4C6A1C5B.4030304@workspacewhiz.com>
 <7viq39avay.fsf@alter.siamese.dyndns.org>
 <20100818233900.GA27531@localhost>
 <vpqd3t9656k.fsf@bauges.imag.fr>
 <4C727E17.5070707@ira.uka.de>
 <20100823151146.GA15379@localhost>
 <7veidp2ufh.fsf@alter.siamese.dyndns.org>
Reply-To: Clemens Buchacher <drizzd@aon.at>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="6c2NcOVqGQ03X4Wi"
Cc: Holger Hellmuth <hellmuth@ira.uka.de>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Joshua Jensen <jjensen@workspacewhiz.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Aug 24 09:28:52 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OnnwA-00056G-KF
	for gcvg-git-2@lo.gmane.org; Tue, 24 Aug 2010 09:28:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751470Ab0HXH2q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Aug 2010 03:28:46 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:43376 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751128Ab0HXH2p (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Aug 2010 03:28:45 -0400
Received: by fxm13 with SMTP id 13so3588377fxm.19
        for <git@vger.kernel.org>; Tue, 24 Aug 2010 00:28:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:received:sender:received:date:from:to
         :cc:subject:message-id:reply-to:references:mime-version:content-type
         :content-disposition:in-reply-to:user-agent;
        bh=3BOtvEXXjjwEfZPhoYXb3Qq4BinKv8Tkds+GcjCOUTc=;
        b=YBdtLG2pxRDyc2lMAHABTdv5QgTHn+dqcSBlsvGrA/ZBct/xNIJGYtyn+CfwLU/T57
         ojmEfRHL7OEXIgkB/WhPGloIiRV/gQsjR8jjlpqp34lIpfeIr8TmjFMBiO/fI2BxscND
         9djOHNwRz1Azs+y4I+N6V2Qu538aE1YNtwAfs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=sender:date:from:to:cc:subject:message-id:reply-to:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        b=B0fuZg67y6/moVo3MO/di+N9V8r1Eltpm71ErPD+sXbb33aduWtE8ANK9Ax66o+/Lh
         XsA1ksBKCnE4hxMAo8icGuUv/zdWKd2rsr3ivD1oAdPCklBnltUof025UzMFKLVsgWx2
         c65166amsnvMFP14xZveGLiJWtkT4JdZ2b3kM=
Received: by 10.223.126.68 with SMTP id b4mr5437534fas.96.1282634924173;
        Tue, 24 Aug 2010 00:28:44 -0700 (PDT)
Received: from darc.lan (p549A7EA0.dip.t-dialin.net [84.154.126.160])
        by mx.google.com with ESMTPS id b11sm2953669faq.30.2010.08.24.00.28.42
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 24 Aug 2010 00:28:43 -0700 (PDT)
Received: from drizzd by darc.lan with local (Exim 4.71)
	(envelope-from <drizzd@localhost>)
	id 1OnnwE-0005ys-5Q; Tue, 24 Aug 2010 09:28:54 +0200
Content-Disposition: inline
In-Reply-To: <7veidp2ufh.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154304>


--6c2NcOVqGQ03X4Wi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 23, 2010 at 08:57:38AM -0700, Junio C Hamano wrote:
> Clemens Buchacher <drizzd@aon.at> writes:
>=20
> > On Mon, Aug 23, 2010 at 03:56:39PM +0200, Holger Hellmuth wrote:
> >>=20
> >> You've got my vote. This is the only option that combines safety with
> >> minimal configuration hassle.
> >>=20
> >> I didn't know about this subtle difference between .gitignore and
> >> .git/info/exclude. And while this makes sense I expect a sizable
> >> percentage of users will never even know that .git/info/exclude exists.
> >
> > I don't know if this subtle difference was even intentional.
>=20
> I am sorry, what difference are you talking about?

The fact that files in .gitignore are considered trashable, and the
ones in .git/info/exclude are not.

--6c2NcOVqGQ03X4Wi
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iQEcBAEBAgAGBQJMc3S2AAoJELKdZexG8uqMqeUIAKyxs02qc/twiVYWTO0YrAGn
gxPweKJAuHdBmr0afraGqbr+9NIkG/KUdmwDt7syvos6Qc/s7bN3GJjg/zhsNF8c
OY9ltFolM8P7vE+w2MuZmVMCwm1bDNxToG7z2UgW4zxi9I2j1IK/p8PqZA+/bIyE
r7vLkBhdZKdpJZamwGFeiHG7rV2ph1oWHKRQSjB0kp0bILZDT17KLgsJxqOI+DTB
7w9rAvPjTqRuB7I0L9E6g2Ny6UDHmes/aGRvLEWB8D3D8FdixNZY02CyfvoRDknt
8To9wGx71ih84RbHpkZDqs65y6UfefOIeaaP+pzH83/SPm3LfoteY2gJ4wNwW4k=
=gclC
-----END PGP SIGNATURE-----

--6c2NcOVqGQ03X4Wi--
