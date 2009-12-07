From: Todd Zullinger <tmz@pobox.com>
Subject: Re: [ANNOUNCE] Git 1.6.5.4
Date: Mon, 7 Dec 2009 10:18:01 -0500
Message-ID: <20091207151800.GI4629@inocybe.localdomain>
References: <20091203150323.GI23717@inocybe.localdomain>
 <7viqco54xh.fsf@alter.siamese.dyndns.org>
 <20091203202738.GP23717@inocybe.localdomain>
 <7vfx7r4we7.fsf@alter.siamese.dyndns.org>
 <20091203220020.GS23717@inocybe.localdomain>
 <7vbpif4rn2.fsf@alter.siamese.dyndns.org> <m2r5rb9hes.fsf@igel.home>
 <7vzl5ysm11.fsf@alter.siamese.dyndns.org>
 <20091204193355.GC4629@inocybe.localdomain>
 <7vzl5vbp7y.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256; protocol="application/pgp-signature"; boundary="a1QUDc0q7S3U7/Jg"
Cc: Andreas Schwab <schwab@linux-m68k.org>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Dec 07 16:18:29 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NHfM3-0001GI-6f
	for gcvg-git-2@lo.gmane.org; Mon, 07 Dec 2009 16:18:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935255AbZLGPSP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Dec 2009 10:18:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932683AbZLGPSP
	(ORCPT <rfc822;git-outgoing>); Mon, 7 Dec 2009 10:18:15 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:43154 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932705AbZLGPSO (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Dec 2009 10:18:14 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id ECEAC86C90;
	Mon,  7 Dec 2009 10:18:18 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=date:from:to
	:cc:subject:message-id:references:mime-version:content-type
	:in-reply-to; s=sasl; bh=7JZPAf7AGUvg2X71i+ZTsiMfOyQ=; b=dEOT3XT
	ZZ/AhC9xThLpsQOB5Qh+DeleHiZbI9fjK7eqGRURzfzFxM9IGU4KPI7konnmjQph
	vh1/Dypj2pthFqapVw1/Pp5xuC9VJLpyeyOl8gkynjhJOPsireLaCugpLaGB1ARf
	KDnyD5YpGCdWECl8zs1qAyGv/6BpUMRmXSQE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=date:from:to:cc
	:subject:message-id:references:mime-version:content-type
	:in-reply-to; q=dns; s=sasl; b=eukmfWZE8Op7g1VI+Lm/Y6WD0w4+un29X
	E5Z8X44XXJqCTQkduLRfbOiBas2aOKbkZD6bkSZRT802tJccRwBJ7SSZoWleyBY9
	bkUfOTOeVTnhlWVMgpPqsInREHpoMAlZ6yXeF5dKZ3GlJdK7loxodk+T6uGaeRgn
	xi/ujadTPM=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 5056786C8F;
	Mon,  7 Dec 2009 10:18:13 -0500 (EST)
Received: from inocybe.localdomain (unknown [98.117.251.177]) (using TLSv1
 with cipher AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id E88E186C8D; Mon,  7 Dec
 2009 10:18:02 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <7vzl5vbp7y.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.20 (2009-06-14)
X-Pobox-Relay-ID: BC878CBE-E343-11DE-92A6-9F3FEE7EF46B-09356542!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134759>


--a1QUDc0q7S3U7/Jg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Junio C Hamano wrote:
>> This does set MAN_BASE_URL unconditionally, pointing to kernel.org.
>
> I'd change this to point at "file://$(htmldir)/", though.

Thanks.  I can delete the mail with an updated patch that I started
over the weekend and didn't finish, which did that as well. ;)

Many thanks for all your hard work Junio.

--=20
Todd        OpenPGP -> KeyID: 0xBEAF0CE3 | URL: www.pobox.com/~tmz/pgp
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Aim Low, Reach Your Goals, Avoid Disappointment.


--a1QUDc0q7S3U7/Jg
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iQFCBAEBCAAtBQJLHRyjJhhodHRwOi8vd3d3LnBvYm94LmNvbS9+dG16L3BncC90
bXouYXNjAAoJEEMlk4u+rwzjnPcH90M8LvidSr/WDTXESol8fsE/RG+aOI461XAe
LHuUc5FVTX7nCMinLs4Bv7qkR8FlXYIa3vBx3oXtSaQ/tk/uLpKoWMuEAp1O6Kjd
Alp3bhAtJ4VpDdbqCSpzrORvRQ5DvCEz+NwEkMdUqG8zqycR4FPmoHZKErJjoX9b
7bW6PwPWxRvcWZ4Wjmt4r8L37Dw/y912UjQDDizoALMKikY5lJYR2wuYiQx3JS9A
xnGl+dx/TTOpcNMDxDU4cvil67g//43netmeu1DojbIn8AW0oY646NPsdw4QA5ib
eEavmVl54ILQsTljJ7WHDBfIq5C704FHMi64440UokFZUWDJDA==
=rtq8
-----END PGP SIGNATURE-----

--a1QUDc0q7S3U7/Jg--
