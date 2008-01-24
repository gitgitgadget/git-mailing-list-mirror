From: Robert Schiele <rschiele@gmail.com>
Subject: Re: [PATCH] HP-UX traditionally has no sys/select.h
Date: Thu, 24 Jan 2008 20:39:42 +0100
Message-ID: <20080124193942.GM30676@schiele.dyndns.org>
References: <20080124175300.GI30676@schiele.dyndns.org> <7vd4rravin.fsf@gitster.siamese.dyndns.org>
Reply-To: Robert Schiele <rschiele@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="TOmSpbqtysumMR8M"
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jan 24 20:41:30 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JI7ws-0006IS-4i
	for gcvg-git-2@gmane.org; Thu, 24 Jan 2008 20:41:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758059AbYAXTj4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Jan 2008 14:39:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758049AbYAXTjz
	(ORCPT <rfc822;git-outgoing>); Thu, 24 Jan 2008 14:39:55 -0500
Received: from ug-out-1314.google.com ([66.249.92.169]:16802 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758046AbYAXTjy (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Jan 2008 14:39:54 -0500
Received: by ug-out-1314.google.com with SMTP id z38so371112ugc.16
        for <git@vger.kernel.org>; Thu, 24 Jan 2008 11:39:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:date:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent:from:reply-to;
        bh=/W7ZAZUdqqEeKZ3hi9aZo2AWuMe5EW4bjvmCXh8GUSc=;
        b=WZwKrwEJmltflkQD7Mug8q/n9wGD4ToN6Mi7Llgsrox5jylYo/IF8BAqZ8Nkf/9xaQPMn1Dgf0TdgUIM5ZgHzc7w9JlGR0vol78USMBfb068rwTesn/6PZPdPmlo/salipThIf6/5gfOqtGtZ98b1+2iAjX+KQRsF1AgT433Yw4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent:from:reply-to;
        b=Aax9xCG+lz+w4u9iKsuyxkURlcrvr8+Qks4Cu86387/ygwY6/Tv+YysVF85qUjWbJvzoQNqxEA4M92mcgZ3tAErSIWqa3Q3f7anj9tkGcb9UkhZLAmB0/p+q+yIcrPKS3XxTvn/wRpMtG9H59GMlMRSZ0dNDvIX5MjNz+iKF5Yc=
Received: by 10.67.101.17 with SMTP id d17mr2620245ugm.53.1201203584999;
        Thu, 24 Jan 2008 11:39:44 -0800 (PST)
Received: from sigkill.schiele.dyndns.org ( [91.18.121.55])
        by mx.google.com with ESMTPS id g28sm2454923fkg.2.2008.01.24.11.39.43
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 24 Jan 2008 11:39:43 -0800 (PST)
Received: by sigkill.schiele.dyndns.org (Postfix, from userid 1000)
	id 9F6874BFF1; Thu, 24 Jan 2008 20:39:42 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <7vd4rravin.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71655>


--TOmSpbqtysumMR8M
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 24, 2008 at 11:11:44AM -0800, Junio C Hamano wrote:
> We had a thread on this issue mid December.
> Does this help?

Yes, checking for the _POSIX_VERSION is also a working approach.

Robert

--=20
Robert Schiele
Dipl.-Wirtsch.informatiker	mailto:rschiele@gmail.com

"Quidquid latine dictum sit, altum sonatur."

--TOmSpbqtysumMR8M
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.4-svn0 (GNU/Linux)

iD8DBQFHmOl+xcDFxyGNGNcRAqXAAKDK5HYWn4SUyh0eD86tHhhUD2Eb+QCZAa1T
7MTyhGYIJmV7mAbQjpb1jrA=
=E9sC
-----END PGP SIGNATURE-----

--TOmSpbqtysumMR8M--
