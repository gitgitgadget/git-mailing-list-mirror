From: Jan Hudec <bulb@ucw.cz>
Subject: Re: [PATCH] git-branch --with=commit
Date: Thu, 15 Nov 2007 18:27:26 +0100
Message-ID: <20071115172726.GA4525@efreet.light.src>
References: <7vpryl8x5t.fsf@gitster.siamese.dyndns.org> <4732BC6F.7070005@viscovery.net> <7vejf140jd.fsf@gitster.siamese.dyndns.org> <4732D440.2020504@op5.se>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="+QahgC5+KEYLbs62"
Cc: Junio C Hamano <gitster@pobox.com>,
	Johannes Sixt <j.sixt@viscovery.net>, git@vger.kernel.org
To: Andreas Ericsson <ae@op5.se>
X-From: git-owner@vger.kernel.org Thu Nov 15 18:36:31 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Isidg-00030a-UI
	for gcvg-git-2@gmane.org; Thu, 15 Nov 2007 18:36:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757461AbXKORgM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Nov 2007 12:36:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757154AbXKORgL
	(ORCPT <rfc822;git-outgoing>); Thu, 15 Nov 2007 12:36:11 -0500
Received: from ns1.bluetone.cz ([212.158.128.13]:44516 "EHLO ns1.bluetone.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756187AbXKORgK (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Nov 2007 12:36:10 -0500
Received: from localhost (spamhole.bluetone.cz [192.168.13.2])
	by ns1.bluetone.cz (Postfix) with ESMTP id E256357445;
	Thu, 15 Nov 2007 18:36:08 +0100 (CET)
Received: from ns1.bluetone.cz ([192.168.13.1])
	by localhost (spamhole.bluetone.cz [192.168.13.2]) (amavisd-new, port 10026)
	with ESMTP id x4Uy6nI+3R1A; Thu, 15 Nov 2007 18:36:06 +0100 (CET)
Received: from efreet.light.src (145-119-207-85.strcechy.adsl-llu.static.bluetone.cz [85.207.119.145])
	by ns1.bluetone.cz (Postfix) with ESMTP id 797A857443;
	Thu, 15 Nov 2007 18:36:03 +0100 (CET)
Received: from bulb by efreet.light.src with local (Exim 4.68)
	(envelope-from <bulb@ucw.cz>)
	id 1IsiUw-0001RI-6F; Thu, 15 Nov 2007 18:27:26 +0100
Content-Disposition: inline
In-Reply-To: <4732D440.2020504@op5.se>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65143>


--+QahgC5+KEYLbs62
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 08, 2007 at 10:17:52 +0100, Andreas Ericsson wrote:
> Junio C Hamano wrote:
>> Johannes Sixt <j.sixt@viscovery.net> writes:
>>
>>> Junio C Hamano schrieb:
>>
>>>> With this patch, I could do this to find out which topic
>>>> branches already contain the faulty commit:
>>>>
>>>>     $ git branch --with=3Dmaint^ | grep /
>>>>       xx/maint-fix-foo
>>> It'd be helpful if you could construct the example in this commit
>>> message such that you don't need the "grep /" here; otherwise, the
>>> reader doesn't know which part of the effect is hidden by the grep.
>>
>> Yeah, in the example sequence, I think only maint itself and
>> xx/maint-fix-foo are shown, so there is no need for grep.
>
> And "maint" could certainly be stripped by the code itself, since the
> user can reasonably be expected to know that plain maint will have
> everything maint^ has.

DWIDNS (Do what I did not say).

Normally one would expect 'git branch --with=3Dmaint^' and
'git branch --with=3D$(git ref-parse maint^)' to be exactly the same. Alas,
with your suggestion, they would not.

--=20
						 Jan 'Bulb' Hudec <bulb@ucw.cz>

--+QahgC5+KEYLbs62
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFHPIF+Rel1vVwhjGURAidFAJsERfZVheW1TR/sFbEHOEMA/0AWUQCgrkl6
lqJxMmOOyjJB0XspCWYEZ1c=
=SdgI
-----END PGP SIGNATURE-----

--+QahgC5+KEYLbs62--
