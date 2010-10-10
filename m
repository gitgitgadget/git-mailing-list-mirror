From: Clemens Buchacher <drizzd@aon.at>
Subject: Re: [PATCH] t/t5560: use `X=Y && export X' not `export X=Y'
Date: Sun, 10 Oct 2010 19:20:11 +0200
Message-ID: <20101010172011.GB15495@localhost>
References: <1286437634-12593-1-git-send-email-avarab@gmail.com>
 <vpqhbgy8mjj.fsf@bauges.imag.fr>
 <AANLkTi=cMYoLVipaiFajcssrRBVPX5NXFNwj21Ji3Lru@mail.gmail.com>
Reply-To: Clemens Buchacher <drizzd@aon.at>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="f2QGlHpHGjS2mn6Y"
Cc: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>,
	Pat Thoyts <patthoyts@users.sourceforge.net>,
	Tarmigan Casebolt <tarmigan+git@gmail.com>
To: =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Sun Oct 10 19:20:17 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P4zZF-00063m-DG
	for gcvg-git-2@lo.gmane.org; Sun, 10 Oct 2010 19:20:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753360Ab0JJRUG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 10 Oct 2010 13:20:06 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:58147 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751716Ab0JJRUE (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Oct 2010 13:20:04 -0400
Received: by bwz15 with SMTP id 15so1266327bwz.19
        for <git@vger.kernel.org>; Sun, 10 Oct 2010 10:20:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:received:sender:received:date:from:to
         :cc:subject:message-id:reply-to:references:mime-version:content-type
         :content-disposition:in-reply-to:user-agent;
        bh=cXHwqAzoyHOh4HPeAUU/Va/qx335cfOXOJD3aJ/aPlc=;
        b=uAy+ISbuOC/uzcqh/6lTxUjhkeRvF3PKoTFd7E3kcUeSjHlaeWudtJGNHfnCxiH3Ol
         iJYE4QTLhUDowPRzICknJ1Ee8DzqR0HAhdbfZcSM1eBMj2VAUBPoj50yZgHAIq51te1y
         MBT9QGLeyXjgDekYpkEsmCbPw8R+6f7s0p2FU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=sender:date:from:to:cc:subject:message-id:reply-to:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        b=GcjQtocLWyT97/7DIXQOSGijMK84AAW9LQw7/VTRVyoK6BS4oSLh7htiZ2AzjEwbYk
         3Fmn6pv7MpnPK4cwZd3Fi3Yg24xvA7jBNCXZY93ig7kkiQHglUbKbm4Rin+6QBirnZXR
         Uk3EmRJ4+ZEpAZFVtXzCky6wBR+1gd67DVcI0=
Received: by 10.204.83.164 with SMTP id f36mr273402bkl.172.1286731201848;
        Sun, 10 Oct 2010 10:20:01 -0700 (PDT)
Received: from darc.lan (p549A35A6.dip.t-dialin.net [84.154.53.166])
        by mx.google.com with ESMTPS id q19sm1731007bkb.4.2010.10.10.10.20.00
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 10 Oct 2010 10:20:01 -0700 (PDT)
Received: from drizzd by darc.lan with local (Exim 4.71)
	(envelope-from <drizzd@localhost>)
	id 1P4zZD-00047m-Us; Sun, 10 Oct 2010 19:20:11 +0200
Content-Disposition: inline
In-Reply-To: <AANLkTi=cMYoLVipaiFajcssrRBVPX5NXFNwj21Ji3Lru@mail.gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158678>


--f2QGlHpHGjS2mn6Y
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 07, 2010 at 08:09:34AM +0000, =C6var Arnfj=F6r=F0 Bjarmason wro=
te:
> >
> > According to
> >
> > git grep '\<export [A-Za-z_]*=3D'
> >
> > there seem to be a couple of other instances of this.

What about t556x_common?

 export GIT_HTTP_EXPORT_ALL=3D1

Clemens

--f2QGlHpHGjS2mn6Y
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iQEcBAEBAgAGBQJMsfXLAAoJELKdZexG8uqM+woH/0G9dojvdx8z9nKnt6VH1Cs3
hc65VvychPFKIWaC/B7gBCIT1zQxrpEe1kgA0gXXvc/2ZR9jzqFirI3wDW+2VjqQ
peHkebYjxSKrm2vkD6ownsyIYL/xQ8NWsYnkuCsX0Xr2l2me5dD4jnZ5XbVRUtWk
x9IDeVdhcGSsc2lxiO0qyzScmTBYe0w8xqQfaLEUElrf/RlGlqJqPGx44V6m9WhK
iC1aVj8Al+i4/cTwr9DM7+anPAXLkYBjKIm0gyXuCfipiOOcUZzP3VD1PqKk6X7n
orSzsdZEgSN76BXzITaSEbL/QUs/Dj6yMklho2c5+5yE39YFZ6qxFwqdJlTNWFY=
=NLy9
-----END PGP SIGNATURE-----

--f2QGlHpHGjS2mn6Y--
