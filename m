From: Robert Schiele <rschiele@gmail.com>
Subject: Re: [PATCH] change Perl syntax to support Perl 5.6
Date: Sat, 30 Aug 2008 20:34:13 +0200
Message-ID: <20080830183413.GG7185@schiele.dyndns.org>
References: <20080830173947.GF7185@schiele.dyndns.org> <20080830180022.GA14552@coredump.intra.peff.net> <7vwshygyy9.fsf@gitster.siamese.dyndns.org>
Reply-To: Robert Schiele <rschiele@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="gDGSpKKIBgtShtf+"
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org,
	Lea Wiemann <lewiemann@gmail.com>,
	Jakub Narebski <jnareb@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Aug 30 20:35:26 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KZVIC-0001aJ-KC
	for gcvg-git-2@gmane.org; Sat, 30 Aug 2008 20:35:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753317AbYH3SeS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 30 Aug 2008 14:34:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753180AbYH3SeS
	(ORCPT <rfc822;git-outgoing>); Sat, 30 Aug 2008 14:34:18 -0400
Received: from fg-out-1718.google.com ([72.14.220.154]:16040 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752769AbYH3SeR (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 30 Aug 2008 14:34:17 -0400
Received: by fg-out-1718.google.com with SMTP id 19so837733fgg.17
        for <git@vger.kernel.org>; Sat, 30 Aug 2008 11:34:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:date:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent:from:reply-to;
        bh=c4lu54+YI7IrSXVVFC+M5vaxZ/gGxo7TJ29Wb+7gHwc=;
        b=T6o2RI3pnXXoE2DEjro8acnURYyIyki7Z+8IXkP5HWDIOfaL+6oHHkXhGedTa5VV9R
         GgZ6Xwm7vL6UxwR+hGGTg1dNeLzAb+x32zt3ayGihu04oA5d+v1ny/jqrCbrOQbHHV5C
         LHn9T8fkNjh8mNqwvADB+PLE2vhU8Fqo6Hu/4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:to:cc:subject:message-id:references:mime-version:content-type
         :content-disposition:in-reply-to:user-agent:from:reply-to;
        b=yCFCB7USTvDjtdlA7tfbGBRkV12WhAQcrSXCz51z6dig2EgWZZCF7PvnyKJIbzGmW/
         3Mby2/evPvcyQbXXhfyVWBrwiuepE+DGr8VB+ZCHy17kMnvUxErVM8zXxM+GVVLjsYCz
         IIKTcqfamZxV4miMPmv1uErmBG40+4iiz53R4=
Received: by 10.86.97.7 with SMTP id u7mr3166818fgb.29.1220121256074;
        Sat, 30 Aug 2008 11:34:16 -0700 (PDT)
Received: from sigkill.schiele.dyndns.org ( [91.18.78.90])
        by mx.google.com with ESMTPS id 4sm4357160fge.8.2008.08.30.11.34.14
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 30 Aug 2008 11:34:15 -0700 (PDT)
Received: by sigkill.schiele.dyndns.org (Postfix, from userid 1000)
	id 5347C18F2B; Sat, 30 Aug 2008 20:34:13 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <7vwshygyy9.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94401>


--gDGSpKKIBgtShtf+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Aug 30, 2008 at 11:06:06AM -0700, Junio C Hamano wrote:
> I didn't try either but I think you are right.  And I agree we should say
> we rely on 5.6 or newer.

If we don't change it we need to rely on 5.8 or newer as my initial patch
suggested.

If there are problems with that change I recommend just using my initial pa=
tch
changing the documentation to require Perl 5.8 since my interest in Perl 5.6
support is not big enough to mess around with quoting all that stuff.  If
someone really needs this he or she can still do it --- it should be not too
difficult.

Robert

--=20
Robert Schiele
Dipl.-Wirtsch.informatiker	mailto:rschiele@gmail.com

"Quidquid latine dictum sit, altum sonatur."

--gDGSpKKIBgtShtf+
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.4-svn0 (GNU/Linux)

iD8DBQFIuZKlxcDFxyGNGNcRAn3RAJ4w3AmlfyjHseT1cg/JPlSr0ZKTfACg7AGM
PZhxClT20dKzOM+4qePkVVM=
=JflV
-----END PGP SIGNATURE-----

--gDGSpKKIBgtShtf+--
