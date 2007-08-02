From: Robert Schiele <rschiele@gmail.com>
Subject: Re: Shell script cleanups/style changes?
Date: Thu, 2 Aug 2007 16:00:11 +0200
Message-ID: <20070802140011.GN29424@schiele.dyndns.org>
References: <86bqdqkygp.fsf@lola.quinscape.zz>
Reply-To: Robert Schiele <rschiele@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Qgof7w7UksPF5inF"
Cc: git@vger.kernel.org
To: David Kastrup <dak@gnu.org>
X-From: git-owner@vger.kernel.org Thu Aug 02 16:00:24 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IGbDz-00024x-BH
	for gcvg-git@gmane.org; Thu, 02 Aug 2007 16:00:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752111AbXHBOAS (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 2 Aug 2007 10:00:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752183AbXHBOAS
	(ORCPT <rfc822;git-outgoing>); Thu, 2 Aug 2007 10:00:18 -0400
Received: from nf-out-0910.google.com ([64.233.182.191]:45328 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751576AbXHBOAQ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Aug 2007 10:00:16 -0400
Received: by nf-out-0910.google.com with SMTP id g13so142216nfb
        for <git@vger.kernel.org>; Thu, 02 Aug 2007 07:00:15 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:received:date:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent:from:reply-to;
        b=Yq0Nv8CN1I/8C7gPCBP9YkAz1aGqZgr3mBAROUa6dGClYGOAWZy1Qoc1OKRS/bBRKlc/AYieDtixEaSHRnI1UFT4PlnfYgoOGAesDjP+Xo0kJLFQ1SAVUCBTWg06EPmt5zlMgO5usfmddeXU4ZEoLyEBXSfeMxWkja2eWc0eeTE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:date:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent:from:reply-to;
        b=GxJNmqePA5P9tmHX4pcGe87biu+EfV25HM7Juzhc9U3e6xM8KhSY3uxX0rq3UyDgsFFARngMkYaN8xJsX4TxVpYS7e5EbnLaLooaEDFjSkMo3GIi5w57zvgjydqX8E6nwnjnE+eZ09941uK9Uc2otztezOqtG4m/iUPEaCITkl8=
Received: by 10.86.57.9 with SMTP id f9mr1421055fga.1186063214909;
        Thu, 02 Aug 2007 07:00:14 -0700 (PDT)
Received: from sigkill.schiele.dyndns.org ( [87.178.91.135])
        by mx.google.com with ESMTPS id a37sm4081069fkc.2007.08.02.07.00.13
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 02 Aug 2007 07:00:13 -0700 (PDT)
Received: by sigkill.schiele.dyndns.org (Postfix, from userid 1000)
	id 9AF6FC11240; Thu,  2 Aug 2007 16:00:12 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <86bqdqkygp.fsf@lola.quinscape.zz>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54550>


--Qgof7w7UksPF5inF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 02, 2007 at 12:44:22PM +0200, David Kastrup wrote:
> ! 		logfile=3D"${1#-?}"

You can't do something like that on /bin/sh on many systems (for instance
Solaris).

Robert

--=20
Robert Schiele
Dipl.-Wirtsch.informatiker	mailto:rschiele@gmail.com

"Quidquid latine dictum sit, altum sonatur."

--Qgof7w7UksPF5inF
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)

iD8DBQFGseNrxcDFxyGNGNcRAgNJAKDRtLCW+ScvmB6ePGeeY49KfkqeTgCgwXLe
H/3nxMyA28MAv4R2xqnIh+4=
=WlhE
-----END PGP SIGNATURE-----

--Qgof7w7UksPF5inF--
