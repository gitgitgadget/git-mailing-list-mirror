From: Robert Schiele <rschiele@gmail.com>
Subject: Re: Shell script cleanups/style changes?
Date: Thu, 2 Aug 2007 23:41:03 +0200
Message-ID: <20070802214103.GT29424@schiele.dyndns.org>
References: <86bqdqkygp.fsf@lola.quinscape.zz> <7vlkctvfk9.fsf@assigned-by-dhcp.cox.net> <85odhpzmbo.fsf@lola.goethe.zz> <7vsl71tyyq.fsf@assigned-by-dhcp.cox.net> <86bqdqkygp.fsf@lola.quinscape.zz> <7vlkctvfk9.fsf@assigned-by-dhcp.cox.net> <85odhpzmbo.fsf@lola.goethe.zz>
Reply-To: Robert Schiele <rschiele@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="IUSVF+LtaR4kWxuH"
Cc: git@vger.kernel.org
To: David Kastrup <dak@gnu.org>, Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Aug 02 23:41:19 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IGiPy-0001RX-Sa
	for gcvg-git@gmane.org; Thu, 02 Aug 2007 23:41:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760680AbXHBVlL (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 2 Aug 2007 17:41:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760640AbXHBVlL
	(ORCPT <rfc822;git-outgoing>); Thu, 2 Aug 2007 17:41:11 -0400
Received: from nf-out-0910.google.com ([64.233.182.187]:31969 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760299AbXHBVlI (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Aug 2007 17:41:08 -0400
Received: by nf-out-0910.google.com with SMTP id g13so169518nfb
        for <git@vger.kernel.org>; Thu, 02 Aug 2007 14:41:06 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:received:date:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent:from:reply-to;
        b=PXUz/51HICbemK5bqlcBSq1jfrtYqhRbaNy4KgsnJCK6Z4OS/uAJ2Unje6r6QulCHoQ8/2q+x+Lb7ev+VYRbZv+k0qQly71RhcKbNL6IKkJ/3W3x/rYzsWlsrqB2I1TBd/MaC/7cZ+J2ItWoe0o6h/c5Q4M9bvv+l2J2j998lDA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:date:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent:from:reply-to;
        b=r4vx+V1KRCsE6M7qk73FKn0MwWcEG90z6azmB2unlRX2a9niX2MxAZtrXjl2m3pZ2k9sB09DNOQdlwdZgcFw9k+xlkMdjZjIFvY14JL1ksoqyjHmF0ySIN3GhMIzvEU+nrh9NVhqe+DIwTr478BhglzsH4mE20blEC7L/t2Ktz4=
Received: by 10.86.57.9 with SMTP id f9mr1712910fga.1186090866637;
        Thu, 02 Aug 2007 14:41:06 -0700 (PDT)
Received: from sigkill.schiele.dyndns.org ( [87.178.91.135])
        by mx.google.com with ESMTPS id w7sm7530164mue.2007.08.02.14.41.05
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 02 Aug 2007 14:41:05 -0700 (PDT)
Received: by sigkill.schiele.dyndns.org (Postfix, from userid 1000)
	id D8E072A6E11; Thu,  2 Aug 2007 23:41:03 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <7vsl71tyyq.fsf@assigned-by-dhcp.cox.net> <85odhpzmbo.fsf@lola.goethe.zz>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54618>


--IUSVF+LtaR4kWxuH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 02, 2007 at 10:57:31PM +0200, David Kastrup wrote:
> Most of the "new tricks" I try on bash, dash and ash.

Well, those are not really the most challenging one.  Thus you should either
test on more or just believe those people that have other shells that it do=
es
not work.

> I am confused now: a different poster adamantly stated that /bin/sh on
> Solaris did not support those constructs, and that every functionality
> of git was working fine for him.

No, you should read the mails you are refering to.  I said that the most
important stuff does work.  Apparently this did not yet hurt me on the
platform.  Thus we have to decide whether we want some textbook example code
and thus break this platform completely or whether we want to fix the issues
you have listed and thus have a more portable application.

> Sure.  What about the git-rebase line using $(($end - $msgnum)) ?

Bad on Solaris:

$ uname -a
SunOS solaris10-x64 5.10 Generic i86pc i386 i86pc
$ end=3D1
$ msgnum=3D5
$ echo $(($end - $msgnum))
syntax error: `(' unexpected
$=20

> Too bad: this should mean that $EDITOR can get called from C...  I've
> been glad to see that so far this could be avoided.

Why is it bad to call the editor from C?

On Thu, Aug 02, 2007 at 02:21:01PM -0700, Junio C Hamano wrote:
> David Kastrup <dak@gnu.org> writes:
>=20
> > Sure.  What about the git-rebase line using $(($end - $msgnum)) ?
> > That's even more risque than ##.
>=20
> Is it really risque?  I do not think we have heard trouble with
> the arith expansion from anybody.  A few mistakes in the past

See above.

> I do not think we have trouble with ${parameter#word}.  Much

$ uname -a
SunOS solaris10-x64 5.10 Generic i86pc i386 i86pc
$ parameter=3Dbla
$ echo ${parameter#word}
bad substitution
$=20

> less with ${parameter+word}; it has been in /bin/sh forever.

That one is ok for Solaris.

Robert

--=20
Robert Schiele
Dipl.-Wirtsch.informatiker	mailto:rschiele@gmail.com

"Quidquid latine dictum sit, altum sonatur."

--IUSVF+LtaR4kWxuH
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)

iD8DBQFGsk9vxcDFxyGNGNcRAnu/AKDugudLPONpzTKsJbzRDvrasIzQKgCfc/Z1
pzfUAy+uFUhVqgRWd3Mh8cM=
=0JCq
-----END PGP SIGNATURE-----

--IUSVF+LtaR4kWxuH--
