From: Robert Schiele <rschiele@gmail.com>
Subject: Re: [PATCH] change Perl syntax to support Perl 5.6
Date: Sat, 30 Aug 2008 23:21:17 +0200
Message-ID: <20080830212117.GH7185@schiele.dyndns.org>
References: <20080830173947.GF7185@schiele.dyndns.org> <20080830183413.GG7185@schiele.dyndns.org> <20080830183949.GA16415@coredump.intra.peff.net> <200808302237.17017.jnareb@gmail.com>
Reply-To: Robert Schiele <rschiele@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="E7i4zwmWs5DOuDSH"
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	git@vger.kernel.org, Lea Wiemann <lewiemann@gmail.com>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Sat Aug 30 23:22:34 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KZXts-00016s-8A
	for gcvg-git-2@gmane.org; Sat, 30 Aug 2008 23:22:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754798AbYH3VVX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 30 Aug 2008 17:21:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754603AbYH3VVX
	(ORCPT <rfc822;git-outgoing>); Sat, 30 Aug 2008 17:21:23 -0400
Received: from fg-out-1718.google.com ([72.14.220.152]:1134 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754519AbYH3VVW (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 30 Aug 2008 17:21:22 -0400
Received: by fg-out-1718.google.com with SMTP id 19so863763fgg.17
        for <git@vger.kernel.org>; Sat, 30 Aug 2008 14:21:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:date:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent:from:reply-to;
        bh=bqUQ2PnyxTrryj4fTxBZJnyH11W65rKiC+z8dPlszM8=;
        b=d/xgfo0rfKTAjRH1jLvR9hTCZKd08qPlEo2TOT9GJG8R56XNEmcWCotM3GlNhl/jsJ
         KI81EQjKh/3pL8ac13ipQFWugXbMZ76IM3N/Zyn9R4nKKpzcsDAeTSFjsXPHLy7PXzL0
         /kPFic7EY2Kxzx9/SgW2K3M9cZb3io4cACIRU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:to:cc:subject:message-id:references:mime-version:content-type
         :content-disposition:in-reply-to:user-agent:from:reply-to;
        b=QV332bfITv+1hRA4ZNImhHD9J7MoGyU8oOHDAF6YCqK65BZhv+2CwpUSSnNBCiV4Kn
         +FteO+wBYqbgXY1EPaiJ8oG1vieYaQq+u0ViwY6TrmA8A6YXY6Qhz+Va3c46tZ8V9xlm
         IFChul7Qw3GgcVshZ/1kUFiMkiGNST8gtz8mU=
Received: by 10.86.77.5 with SMTP id z5mr3271538fga.10.1220131280559;
        Sat, 30 Aug 2008 14:21:20 -0700 (PDT)
Received: from sigkill.schiele.dyndns.org ( [91.18.78.90])
        by mx.google.com with ESMTPS id d6sm3861117fga.2.2008.08.30.14.21.19
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 30 Aug 2008 14:21:19 -0700 (PDT)
Received: by sigkill.schiele.dyndns.org (Postfix, from userid 1000)
	id 0818116081; Sat, 30 Aug 2008 23:21:17 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <200808302237.17017.jnareb@gmail.com>
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94435>


--E7i4zwmWs5DOuDSH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Aug 30, 2008 at 10:37:15PM +0200, Jakub Narebski wrote:
>  # quote the given arguments for passing them to the shell
>  # quote_command("command", "arg 1", "arg with ' and ! characters")
>  # =3D> "'command' 'arg 1' 'arg with '\'' and '\!' characters'"
>  # Try to avoid using this function wherever possible.
>  sub quote_command {
>  	return join(' ',
>  		    map( { my $a =3D $_; $a =3D~ s/(['!])/'\\$1'/g; "'$a'" } @_ ));
>  }

Well, I guess you know why I did not consider it worth from my side to go i=
nto
that business.  ;-)

If someone has a concrete implementation and a list of (concrete) tests I
should do I can do so.

Otherwise I just consider Perl 5.6 as unsupported since our main development
systems have Perl 5.8 or later anyway.

Robert

--=20
Robert Schiele
Dipl.-Wirtsch.informatiker	mailto:rschiele@gmail.com

"Quidquid latine dictum sit, altum sonatur."

--E7i4zwmWs5DOuDSH
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.4-svn0 (GNU/Linux)

iD8DBQFIubnNxcDFxyGNGNcRAqdGAJsFghdYtTgsWlzlqLArt2+kEnXKgQCgp/Tq
PskmF/yRhjLMqxMAtUtLXwQ=
=cis5
-----END PGP SIGNATURE-----

--E7i4zwmWs5DOuDSH--
