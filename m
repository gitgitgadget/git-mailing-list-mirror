From: Clemens Buchacher <drizzd@aon.at>
Subject: Re: [PATCH] disallow branch names that start with a hyphen
Date: Wed, 15 Sep 2010 09:34:14 +0200
Message-ID: <20100915073414.GA28927@localhost>
References: <20100822140801.GA6574@localhost>
 <7vsk262vla.fsf@alter.siamese.dyndns.org>
 <20100823043701.GA11822@localhost>
 <7vtyls6qa7.fsf@alter.siamese.dyndns.org>
Reply-To: Clemens Buchacher <drizzd@aon.at>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="jRHKVT23PllUwdXP"
Cc: git@vger.kernel.org, Thomas Rast <trast@student.ethz.ch>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Sep 15 09:34:00 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OvmVD-0004pC-Vh
	for gcvg-git-2@lo.gmane.org; Wed, 15 Sep 2010 09:34:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751647Ab0IOHdy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 15 Sep 2010 03:33:54 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:49762 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751240Ab0IOHdx (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 Sep 2010 03:33:53 -0400
Received: by bwz11 with SMTP id 11so250252bwz.19
        for <git@vger.kernel.org>; Wed, 15 Sep 2010 00:33:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:received:sender:received:date:from:to
         :cc:subject:message-id:reply-to:references:mime-version:content-type
         :content-disposition:in-reply-to:user-agent;
        bh=O4WHCH/c1jZRwZ0CIQOSh4vnFAl4Lo2a9jdHqpkSJ8g=;
        b=eWM2D4p5TDgFhNRCqPckJ1Dj+oSJPtnh29ZLM1gxfqsPcImKmCaZLW5SciJbtlLCMl
         Kz9dhEmexHveoOKZrbuD4oaTiGDCbePCkSfPQXCjLaTiYTbgPY4G8iWmbagTM9dmJp6r
         7kuw2tviggmpFGoom0efjUQg+Au/rqYp5ltYE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=sender:date:from:to:cc:subject:message-id:reply-to:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        b=MufwZKrmxsTFGxn/Xg08LSyiUeSxFxJQgxylNsQQF/lscWPdiVTeHhRY3zoi78B5A6
         KvyB2rAX0DcuUvl9KTnwzkS/iTe2PfRGm7pOtGR3f3+YBoxELXgfsjxynZs+frF/G9kV
         zD+Fic028ACwIb5IVG5083NsmaN3OOng0Y4ms=
Received: by 10.204.126.223 with SMTP id d31mr851228bks.146.1284536031818;
        Wed, 15 Sep 2010 00:33:51 -0700 (PDT)
Received: from darc.lan (p549A56EF.dip.t-dialin.net [84.154.86.239])
        by mx.google.com with ESMTPS id 11sm1050944bkj.23.2010.09.15.00.33.49
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 15 Sep 2010 00:33:50 -0700 (PDT)
Received: from drizzd by darc.lan with local (Exim 4.71)
	(envelope-from <drizzd@localhost>)
	id 1OvmVS-0007XI-Lx; Wed, 15 Sep 2010 09:34:14 +0200
Content-Disposition: inline
In-Reply-To: <7vtyls6qa7.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156225>


--jRHKVT23PllUwdXP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 14, 2010 at 01:09:20PM -0700, Junio C Hamano wrote:
> >
> > Sounds good to me. I will have limited access to email this week.
> > I'll revisit this when I am back.
>=20
> Heh, it turns out that we have a perfect place to hook this into.

Thank you for taking care of this! Unfortunately, I haven't had the
time to do any work at all.

Clemens

--jRHKVT23PllUwdXP
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iQEcBAEBAgAGBQJMkHb2AAoJELKdZexG8uqMWEUIAJqx+BwZomDE+UPRe38dSGjO
Tt9uKwpfQKfaD6rJybVGCCSVykEJWLhVTlRlnDJPLbxIzTGKywDNdE7l393KTYJ3
nBh2vWORYRGYkNBTXpF6c1PyzNAxxnBV8C1m9DuXWspaeWEXNevpCCeVpqIfKXVB
wkJ1py71qFu1L4ZpPsXsGtm0wo193VF/ThdDGsiDloJKagK+kVJhOTuPw5PMR+jQ
VzGPpuBBbrzbactqDzjJDU5hk7Av1ffwenuWPqP7MlbAFXS5O9GF2oGJczy+3xn8
wQn51Qr6iW9MoHr87eZmCsqJ1L5ld8Sy1yluymgp5Yb0ElVOtui9cqzt0Ghl6FM=
=rELm
-----END PGP SIGNATURE-----

--jRHKVT23PllUwdXP--
