From: Robert Schiele <rschiele@gmail.com>
Subject: Re: Shell script cleanups/style changes?
Date: Fri, 3 Aug 2007 01:21:27 +0200
Message-ID: <20070802232126.GU29424@schiele.dyndns.org>
References: <86bqdqkygp.fsf@lola.quinscape.zz> <7vlkctvfk9.fsf@assigned-by-dhcp.cox.net> <85odhpzmbo.fsf@lola.goethe.zz> <7vsl71tyyq.fsf@assigned-by-dhcp.cox.net> <86bqdqkygp.fsf@lola.quinscape.zz> <7vlkctvfk9.fsf@assigned-by-dhcp.cox.net> <85odhpzmbo.fsf@lola.goethe.zz> <20070802214103.GT29424@schiele.dyndns.org> <85vebxy47e.fsf@lola.goethe.zz> <7vwswdsfjp.fsf@assigned-by-dhcp.cox.net>
Reply-To: Robert Schiele <rschiele@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="QHhm1I6mwQR20oIa"
Cc: David Kastrup <dak@gnu.org>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Aug 03 01:21:35 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IGjz4-00066d-Ne
	for gcvg-git@gmane.org; Fri, 03 Aug 2007 01:21:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759053AbXHBXVb (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 2 Aug 2007 19:21:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759038AbXHBXVb
	(ORCPT <rfc822;git-outgoing>); Thu, 2 Aug 2007 19:21:31 -0400
Received: from nf-out-0910.google.com ([64.233.182.185]:41558 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757035AbXHBXVb (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Aug 2007 19:21:31 -0400
Received: by nf-out-0910.google.com with SMTP id g13so174523nfb
        for <git@vger.kernel.org>; Thu, 02 Aug 2007 16:21:29 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:received:date:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent:from:reply-to;
        b=gJMJOFE6KSGBQB7yvNtjff8m2aeQo2qAnDUeDK0GllERsRhozD3vdUwX8Un1ebneVq22SrqayMRZ19fTo+jnFxny4dY7XZmnhVeTFF5TAJ3UtWYfFRWyY/ry5lzp3ZbRcprbQgsDpvl2Zp2S8MholBIBxoMotqFMpq+tP5I0nJA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:date:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent:from:reply-to;
        b=NFwwMaipab0auh8l6JxomWmwhE8ysi/Pu/TQZBhlNf3ouucDdNjBm2iK8sqxUIxkblaqVK2r9obwxVC06VOyNLAkeAhh/XAlcJQC2XMpZlapIIUHvzfvMQnrTAsfGj+pzdC7BnDfEZygimb9rkJiN643tIBbqRAqKcCw6vcVKaE=
Received: by 10.86.80.5 with SMTP id d5mr1756909fgb.1186096889694;
        Thu, 02 Aug 2007 16:21:29 -0700 (PDT)
Received: from sigkill.schiele.dyndns.org ( [87.178.91.135])
        by mx.google.com with ESMTPS id g1sm7783631muf.2007.08.02.16.21.28
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 02 Aug 2007 16:21:28 -0700 (PDT)
Received: by sigkill.schiele.dyndns.org (Postfix, from userid 1000)
	id 5D57BC112CF; Fri,  3 Aug 2007 01:21:27 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <7vwswdsfjp.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54641>


--QHhm1I6mwQR20oIa
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 02, 2007 at 04:05:46PM -0700, Junio C Hamano wrote:
> However, there is a line we need to draw when bending bacwards
> for compatibility, and I think a system that does not have a
> working command substitution $( ... )  is on the other side of
> that line.

Well, I have now a patch ready for submission that would replace all
occurences of ${PARAMETER#WORD}, ${PARAMETER%WORD}, and $(( EXPRESSION )).
But if you say that you won't accept replacement of $( ... ) then this is n=
ot
worth the effort since this one isn't accepted as well.

Robert

--=20
Robert Schiele
Dipl.-Wirtsch.informatiker	mailto:rschiele@gmail.com

"Quidquid latine dictum sit, altum sonatur."

--QHhm1I6mwQR20oIa
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)

iD8DBQFGsmb2xcDFxyGNGNcRAgiRAKDn0tP5+cLpgo93pum8r/LwHPMrbQCg4Biq
1JdqPLGBg0v3Nh67l7SMWgc=
=HOaV
-----END PGP SIGNATURE-----

--QHhm1I6mwQR20oIa--
