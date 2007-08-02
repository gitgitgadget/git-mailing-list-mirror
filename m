From: Robert Schiele <rschiele@gmail.com>
Subject: Re: Shell script cleanups/style changes?
Date: Thu, 2 Aug 2007 18:19:02 +0200
Message-ID: <20070802161902.GP29424@schiele.dyndns.org>
References: <86bqdqkygp.fsf@lola.quinscape.zz> <20070802140011.GN29424@schiele.dyndns.org> <86sl72j9vn.fsf@lola.quinscape.zz>
Reply-To: Robert Schiele <rschiele@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="o+ZCuNqY+dEAKBWl"
Cc: git@vger.kernel.org
To: David Kastrup <dak@gnu.org>
X-From: git-owner@vger.kernel.org Thu Aug 02 18:19:58 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IGdP4-0008Nz-B0
	for gcvg-git@gmane.org; Thu, 02 Aug 2007 18:19:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758190AbXHBQTN (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 2 Aug 2007 12:19:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757406AbXHBQTJ
	(ORCPT <rfc822;git-outgoing>); Thu, 2 Aug 2007 12:19:09 -0400
Received: from nf-out-0910.google.com ([64.233.182.189]:33419 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757091AbXHBQTH (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Aug 2007 12:19:07 -0400
Received: by nf-out-0910.google.com with SMTP id g13so150826nfb
        for <git@vger.kernel.org>; Thu, 02 Aug 2007 09:19:06 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:received:date:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent:from:reply-to;
        b=j5Bel7cCGRZ7bLr3pKnfmsBeoDMMLkQq7/gN0nr/b90Af6lJkaXpzWxsUQ/1x13tN0pgX3HXdfuq9LuQLqEosjFgxUWLUiF0pOf3zaeNhe5glej/C3GnDc2FMui4qzX7YY5RcI8SiWDsVi3GsO8UMpOipPNIh1OuCSbnkbuRazM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:date:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent:from:reply-to;
        b=QoONL50JUmYVPjPepqp5TV2DIiU3R2FqU3raHu5/kyvbUApeHKsdqmy17zH0tnfR1wwuLqHoUocZNm8FR8D5AyoRK1+73wRe31u60iE5yHBheOVrkzhVHieSZfbGriN2dRNii+hqMvPHKvFwIFI3+95C9P7YhA5cbwvN4dc9+hI=
Received: by 10.86.100.7 with SMTP id x7mr1504800fgb.1186071546697;
        Thu, 02 Aug 2007 09:19:06 -0700 (PDT)
Received: from sigkill.schiele.dyndns.org ( [87.178.91.135])
        by mx.google.com with ESMTPS id g1sm6687808muf.2007.08.02.09.19.04
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 02 Aug 2007 09:19:04 -0700 (PDT)
Received: by sigkill.schiele.dyndns.org (Postfix, from userid 1000)
	id 4C109C112C0; Thu,  2 Aug 2007 18:19:03 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <86sl72j9vn.fsf@lola.quinscape.zz>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54569>


--o+ZCuNqY+dEAKBWl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 02, 2007 at 04:20:44PM +0200, David Kastrup wrote:
> Sigh.  It's in Posix.

It is in latest POSIX but latest POSIX is not in Solaris.

> I've seen a lot of "modern" constructs in the Shell scripts of git
> (not least of all the eval hackery that is currently used instead of
> this), so do you actually have positive knowledge that the existing
> git stuff runs fine on such systems, and this wouldn't?

I can't say for sure for every corner case but for the most important stuff
the answer is "yes".  If you have specific doubts about some construct you =
may
ask me for that.  Then I would check.

> I don't have access to Solaris systems, so I have to take your word on
> it, but I find it somewhat surprising that they would not follow Posix
> here.

Nowadays you can download it for free if you like to test with it.

Robert

--=20
Robert Schiele
Dipl.-Wirtsch.informatiker	mailto:rschiele@gmail.com

"Quidquid latine dictum sit, altum sonatur."

--o+ZCuNqY+dEAKBWl
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)

iD8DBQFGsgP2xcDFxyGNGNcRAptZAJ4uhQwSSuhXB1jQHJRkcgRNTG9h+ACfRkcD
G5Ap7Etx7sybtrNVCggxMoU=
=PEXM
-----END PGP SIGNATURE-----

--o+ZCuNqY+dEAKBWl--
