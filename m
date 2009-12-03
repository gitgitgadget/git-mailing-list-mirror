From: Todd Zullinger <tmz@pobox.com>
Subject: Re: [ANNOUNCE] Git 1.6.5.4
Date: Thu, 3 Dec 2009 15:27:38 -0500
Message-ID: <20091203202738.GP23717@inocybe.localdomain>
References: <7v638o76ra.fsf@alter.siamese.dyndns.org>
 <m2hbs85koj.fsf@igel.home> <4B17ABE3.6060003@drmicha.warpmail.net>
 <m2d42w5fqq.fsf@igel.home> <4B17D078.6080000@drmicha.warpmail.net>
 <20091203150323.GI23717@inocybe.localdomain>
 <7viqco54xh.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256; protocol="application/pgp-signature"; boundary="VnOTrGv5LmZxna7m"
Cc: Michael J Gruber <git@drmicha.warpmail.net>,
	Andreas Schwab <schwab@linux-m68k.org>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Dec 03 21:27:56 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NGIHL-0006an-UX
	for gcvg-git-2@lo.gmane.org; Thu, 03 Dec 2009 21:27:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754498AbZLCU1m (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 3 Dec 2009 15:27:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753265AbZLCU1m
	(ORCPT <rfc822;git-outgoing>); Thu, 3 Dec 2009 15:27:42 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:52191 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753864AbZLCU1l (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 Dec 2009 15:27:41 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 97D8F858B8;
	Thu,  3 Dec 2009 15:27:47 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=date:from:to
	:cc:subject:message-id:references:mime-version:content-type
	:in-reply-to; s=sasl; bh=npCG6r/SYl+aProWKV9IwGScz3Q=; b=Mxk4gje
	P1Mb+wNoavwbAY7Nhfs5GJP+FYydkt2AVrf+CWs2AJsYZsapuSAjbqhROZhXI+Xt
	HbTyHb/RJONaa7x/hKx47bJq60+FVAMksNa7/jhrYkK1PibIjOOYEr8R4wzifI3c
	+zvUamNGGFQ3KTzXcQjXoNHveZYHgYo9fzR4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=date:from:to:cc
	:subject:message-id:references:mime-version:content-type
	:in-reply-to; q=dns; s=sasl; b=LYj92Umg7mbmMAY1K5vLgfs6uBFxFt98q
	eyYlZEfpsczVBcMqxVC6f38lIGp+qXFQixCSRyjmJOk3/PI7nUJW2tSIT8ALrBls
	8/sz7iVcBI0BHblCwPmT5dSpULicNJH5Dts1G5BjGeXDYfBnUlnTeGw6rebcbSJF
	Jc7JJgwCtU=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id DEE86858B7;
	Thu,  3 Dec 2009 15:27:43 -0500 (EST)
Received: from inocybe.localdomain (unknown [98.117.251.177]) (using TLSv1
 with cipher AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id F16E7858B6; Thu,  3 Dec
 2009 15:27:39 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <7viqco54xh.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.20 (2009-06-14)
X-Pobox-Relay-ID: 4FCEAACC-E04A-11DE-BDFE-9F3FEE7EF46B-09356542!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134474>


--VnOTrGv5LmZxna7m
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Junio C Hamano wrote:
> I did the second one after seeing that both my Debian box and the
> k.org machine that manpages tarballs are made (FC11 IIRC) had that
> option, and my impression has been that it usually is safe to say
> "even Debian has it, and there wouldn't be many things older than
> that distro", but that is apparently not true.

Heh, that surely used to be a very good rule of thumb.  Perhaps these
days a rule of whichever is older Debian stable or current RHEL/CentOS
would suffice?

> Either we require 0.0.20 or we revert the tip one on this topic.  I
> think the latter is a safe thing to do.

That sounds good to me.  I'd like to get the EPEL builds for
RHEL/CentOS updated sometime soon, as they're currently still on
1.5.5.6 and that lacks too many of the great improvements in newer git
releases.  Not having to patch for building the docs is one less thing
to worry about.

--=20
Todd        OpenPGP -> KeyID: 0xBEAF0CE3 | URL: www.pobox.com/~tmz/pgp
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Rowe's Rule: The odds are five to six that the light at the end of the
tunnel is the headlight of an oncoming train.
    -- Paul Dickson


--VnOTrGv5LmZxna7m
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iQFDBAEBCAAtBQJLGB86JhhodHRwOi8vd3d3LnBvYm94LmNvbS9+dG16L3BncC90
bXouYXNjAAoJEEMlk4u+rwzjtuoH/2WWb6FgN4ySvUrJ5t2EUqkL0G9yQf3AkEsH
e7kn7XGebbjYUHwM6Cx6Zs4y+sir7EhjTHg3WqQnBQZeZhHB8lgivb4C9/OlkuNP
mepq/y1PeXutvIoTMDF6RAjpmDmyxQVmRPhHQX9a22TqFCy6O2wuOwQ9pPxtViwn
0yh/SL5z6OApXQZtjTh00gJA+fWQzaliSNI4MIDEcMHyfsCu5hBZZwG7mRAIxq8l
MQzze7epqukzA8ek1zS9Xyejgsy4NHanfzvUpiQ1Vxo+H/cN8JCKJ1/O+Fy3FWKh
hmpxICW3LyZ3GlqvMX9T/TPaSzhRS0pSnQIsjhCEmvewFUlvNDA=
=EdgF
-----END PGP SIGNATURE-----

--VnOTrGv5LmZxna7m--
