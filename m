From: Robert Schiele <rschiele@gmail.com>
Subject: Re: Shell script cleanups/style changes?
Date: Fri, 3 Aug 2007 04:28:28 +0200
Message-ID: <20070803022828.GY29424@schiele.dyndns.org>
References: <7vsl71tyyq.fsf@assigned-by-dhcp.cox.net> <86bqdqkygp.fsf@lola.quinscape.zz> <7vlkctvfk9.fsf@assigned-by-dhcp.cox.net> <85odhpzmbo.fsf@lola.goethe.zz> <20070802214103.GT29424@schiele.dyndns.org> <85vebxy47e.fsf@lola.goethe.zz> <7vwswdsfjp.fsf@assigned-by-dhcp.cox.net> <85ps25y1ac.fsf@lola.goethe.zz> <7vk5sdscfr.fsf@assigned-by-dhcp.cox.net> <85wswdwjll.fsf@lola.goethe.zz>
Reply-To: Robert Schiele <rschiele@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="1Wg5Vd7si6EhrIHA"
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: David Kastrup <dak@gnu.org>
X-From: git-owner@vger.kernel.org Fri Aug 03 04:29:06 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IGmuW-000385-T0
	for gcvg-git@gmane.org; Fri, 03 Aug 2007 04:29:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758315AbXHCC2h (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 2 Aug 2007 22:28:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759043AbXHCC2h
	(ORCPT <rfc822;git-outgoing>); Thu, 2 Aug 2007 22:28:37 -0400
Received: from mu-out-0910.google.com ([209.85.134.188]:59341 "EHLO
	mu-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758315AbXHCC2g (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Aug 2007 22:28:36 -0400
Received: by mu-out-0910.google.com with SMTP id i10so864431mue
        for <git@vger.kernel.org>; Thu, 02 Aug 2007 19:28:34 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:received:date:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent:from:reply-to;
        b=gZupAnO4CcarNoOxaX3kMBPlWItQ0sK2h2AhD8gnm6oxcqkjm3MVFohobWPuzXuDV+EWmwNOK+2d2+QQ9Ci+UMvCg5TBLJCMpQkxVf8CuGMPjtwFpHKpIoRXQTpgAXvyFCBcehbFzruA2+rw78Go5osCB3/4SdH4JJ03XaLPLU4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:date:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent:from:reply-to;
        b=dIS63PHNLHRgX9d0VCo+QBNE1luvyIV1l21ONn3T9CeOwNhetJf3f8xb5fnmuQlH0w63wanzGl0evUql4A22oB/Dv/EJhtj5qfmKkz0wlzwLNvf4nwol5ncykXqeflAUb72HD5pBqVP+/V//g6p05zWBGhRwAK9umvIsCpYENSE=
Received: by 10.86.74.15 with SMTP id w15mr1878165fga.1186108113758;
        Thu, 02 Aug 2007 19:28:33 -0700 (PDT)
Received: from sigkill.schiele.dyndns.org ( [87.178.91.135])
        by mx.google.com with ESMTPS id b17sm5267029fka.2007.08.02.19.28.30
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 02 Aug 2007 19:28:30 -0700 (PDT)
Received: by sigkill.schiele.dyndns.org (Postfix, from userid 1000)
	id 999CFC112CF; Fri,  3 Aug 2007 04:28:28 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <85wswdwjll.fsf@lola.goethe.zz>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54661>


--1Wg5Vd7si6EhrIHA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 03, 2007 at 02:24:38AM +0200, David Kastrup wrote:
> The situation is that we currently don't avoid the former.  Robert
> said that he had prepared a patch that would do so.
>=20
> It would make sense to either encourage him to present his patch

Well, if you want to see it, just tell me.  Do you want to have it with or
without the arithmetic replacements I did as well?

Robert

--=20
Robert Schiele
Dipl.-Wirtsch.informatiker	mailto:rschiele@gmail.com

"Quidquid latine dictum sit, altum sonatur."

--1Wg5Vd7si6EhrIHA
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)

iD8DBQFGspLMxcDFxyGNGNcRAhlXAJ4ujApG2VJ34MLW/LXu+irMS3p7bACfbUCK
QxziJssnYBLSSdNBVvSIMkA=
=7ohy
-----END PGP SIGNATURE-----

--1Wg5Vd7si6EhrIHA--
