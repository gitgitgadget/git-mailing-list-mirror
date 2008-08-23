From: Robert Schiele <rschiele@gmail.com>
Subject: Re: [PATCH] Makefile: improve customization for supporting HP-UX
Date: Sat, 23 Aug 2008 22:09:28 +0200
Message-ID: <20080823200928.GA7185@schiele.dyndns.org>
References: <1219520484-7712-1-git-send-email-vmiklos@frugalware.org>
Reply-To: Robert Schiele <rschiele@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="EVF5PPMfhYS0aIcm"
Cc: git@vger.kernel.org
To: Miklos Vajna <vmiklos@frugalware.org>
X-From: git-owner@vger.kernel.org Sat Aug 23 22:10:39 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KWzRV-0002d5-35
	for gcvg-git-2@gmane.org; Sat, 23 Aug 2008 22:10:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754444AbYHWUJd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 23 Aug 2008 16:09:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754350AbYHWUJd
	(ORCPT <rfc822;git-outgoing>); Sat, 23 Aug 2008 16:09:33 -0400
Received: from fg-out-1718.google.com ([72.14.220.159]:14551 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754320AbYHWUJc (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 23 Aug 2008 16:09:32 -0400
Received: by fg-out-1718.google.com with SMTP id 19so568783fgg.17
        for <git@vger.kernel.org>; Sat, 23 Aug 2008 13:09:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:date:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent:from:reply-to;
        bh=P/K4uL5W2O6JTTH9RkQvnUlsqzsFjb2s/A6kbFAiTdQ=;
        b=CsUGxQSK/ojzmdglZA8KHHo3Iz/JuAIBoEpXC/0Z9qG/Fc1n/9PGoZdY5z5yrCm3dW
         J/lQDnU9/ysssimWjPvCz6EZOEiYFFi80Ilvi+HdNd4gP7H4PnBl9zwkOnWMZ5PwTM6D
         QPxsl2EMdKsDxPvapFaWmcGWyv0Eb2SZBasm4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:to:cc:subject:message-id:references:mime-version:content-type
         :content-disposition:in-reply-to:user-agent:from:reply-to;
        b=EG+RM3gWdnBO7mdjWcpl9KwMtRytm8eoQibFbmwL+OkqjdCp0Pk0SH/JhzKZqqaSZW
         Q+Tgx4ZQdKX31r2mP4kyLZL/5MbLDvGXSkV25kzJcrXZSw5/ukenYD5g33MMWcPBC9XD
         ev5EP3vWROFRqpP0cNGXfOgpVscIrmlIGDoos=
Received: by 10.86.52.6 with SMTP id z6mr1970364fgz.18.1219522170103;
        Sat, 23 Aug 2008 13:09:30 -0700 (PDT)
Received: from sigkill.schiele.dyndns.org ( [91.18.121.169])
        by mx.google.com with ESMTPS id l19sm2839311fgb.7.2008.08.23.13.09.29
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 23 Aug 2008 13:09:29 -0700 (PDT)
Received: by sigkill.schiele.dyndns.org (Postfix, from userid 1000)
	id 748B416052; Sat, 23 Aug 2008 22:09:28 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1219520484-7712-1-git-send-email-vmiklos@frugalware.org>
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93486>


--EVF5PPMfhYS0aIcm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Aug 23, 2008 at 09:41:24PM +0200, Miklos Vajna wrote:
> Cc'ing Robert, it would be interesting to know how did he succeed to
> build without this patch.

Well, it just worked though I cannot give a guarantee that there is not a f=
law
somewhere in the binaries since these machines are not our main development
machines and most developers use git itself on another system that shares t=
he
same network directory.

The systems I build on are:

1x HP-UX B.11.11 U 9000/785
2x HP-UX B.11.23 U ia64

If you tell us how your specific problem looks like I might have an idea why
it does not occur to me.

Robert

--=20
Robert Schiele
Dipl.-Wirtsch.informatiker	mailto:rschiele@gmail.com

"Quidquid latine dictum sit, altum sonatur."

--EVF5PPMfhYS0aIcm
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.4-svn0 (GNU/Linux)

iD8DBQFIsG54xcDFxyGNGNcRAglaAKCwHYtW0YQvpBcrQsvqbLC7B6WwOACeK1jq
G5aFAgPuPtcGTfsR4sboDwk=
=4rbt
-----END PGP SIGNATURE-----

--EVF5PPMfhYS0aIcm--
