From: Ismael Luceno <ismael.luceno@gmail.com>
Subject: Re: git am and CRLF files
Date: Mon, 30 Nov 2009 10:50:51 -0200
Message-ID: <4B13BFAB.3050002@gmail.com>
References: <4AFD2A8F.7000806@atlas-elektronik.com>	 <4B01004A.8060600@atlas-elektronik.com>	 <20091116195036.6117@nanako3.lavabit.com>	 <40aa078e0911160343k41393197s56d26576bcbfbe90@mail.gmail.com> <9accb4400911300406l592306c8t889c28ba7b48674b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig839DE06E9CF7AB45004C2A7E"
Cc: git@vger.kernel.org
To: Daniele Segato <daniele.bilug@gmail.com>
X-From: git-owner@vger.kernel.org Mon Nov 30 13:50:54 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NF5iP-0004dL-BU
	for gcvg-git-2@lo.gmane.org; Mon, 30 Nov 2009 13:50:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752854AbZK3Mum (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 Nov 2009 07:50:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752812AbZK3Mul
	(ORCPT <rfc822;git-outgoing>); Mon, 30 Nov 2009 07:50:41 -0500
Received: from mail-qy0-f194.google.com ([209.85.221.194]:58240 "EHLO
	mail-qy0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752276AbZK3Mul (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Nov 2009 07:50:41 -0500
Received: by qyk32 with SMTP id 32so1505652qyk.4
        for <git@vger.kernel.org>; Mon, 30 Nov 2009 04:50:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :x-enigmail-version:openpgp:content-type;
        bh=TcmYuamIn4T3+L3pFPgroK9r63tx9buKDnHIvr5Mux8=;
        b=bV/gyMoI1FQ5fil267QHJ3PdRZ9EbZAprXd1vUAeYWUlH/d5oKUo13uAwfdirKb3D9
         jLnEWO0pPrqMCR1O4jUdUH4IrBFrIlOlEnL9Zkqy8/T+EyrB0cu8En5rOcMbgU9EYYoR
         8ezr4LkY7F3pHWM4bALrB5lkgjtanejfKmURY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:x-enigmail-version:openpgp:content-type;
        b=jgEp1FJ5XEB6xjlTdy9qng4ozZPIxQ/wtBe0fKTGCfSXzO6Dh7dlkp9vKboGLGZu2y
         77jI+HmR66dTqI6ea+8KhHdUHyX+gta1MXQr3fnmAtUB2qb0AzMi6FJr7WXwClZE+6dZ
         T5VGWjpFIFeze/XNrq+q44bYps4PtabLGh+KM=
Received: by 10.224.7.202 with SMTP id e10mr2100465qae.67.1259585446978;
        Mon, 30 Nov 2009 04:50:46 -0800 (PST)
Received: from ?10.90.0.100? (r190-134-21-210.dialup.adsl.anteldata.net.uy [190.134.21.210])
        by mx.google.com with ESMTPS id 26sm2738738qwa.30.2009.11.30.04.50.44
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 30 Nov 2009 04:50:46 -0800 (PST)
User-Agent: Mozilla-Thunderbird 2.0.0.22 (X11/20091109)
In-Reply-To: <9accb4400911300406l592306c8t889c28ba7b48674b@mail.gmail.com>
X-Enigmail-Version: 0.95.0
OpenPGP: id=EC8E5C9A;
	url=http://ismael.initng.org/ismael.gpg
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134095>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig839DE06E9CF7AB45004C2A7E
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Daniele Segato escribi=C3=B3:
> On Mon, Nov 16, 2009 at 12:43 PM, Erik Faye-Lund
> <kusmabite@googlemail.com> wrote:
>> According to RFC 5322, email messages use CRLF as the
>> newline-sequence. In order to be able to distinguish between CRLF and
>> LF in an e-mail patch, the message needs to be use some
>> transfer-encoding that preserves newline style (like base64).
>>
>> Perhaps this would be better fixed by having format-patch (or prehaps
>> the MUA ?) base64-encode the message body if the file contains
>> non-LF-newlines, and normalizing CRLF to LF before transport-decoding?=

>> Or does some MUAs transport-decode before storing the message to disk?=

>>
>> I realize this might make it a bit tricky to review patches that
>> contains CRLF-newlines before mailing them out, but perhaps inspecting=

>> the format-patch output is the wrong place to do this?
>=20
>=20
> why don't adding that information in the mail header?
> or may be made format-patch create a "comment line" with that informati=
on?
>=20
> if that line is missing it could keep the default behavior (what it
> did until now)
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

It would make more sense to simply use MIME attachments...

--=20
Ismael Luceno


--------------enig839DE06E9CF7AB45004C2A7E
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEARECAAYFAksTv6sACgkQ/mxY0+yOXJo3dwCg049w5jd0ybPfR+k45wQ/+pZP
gcEAnjyUlbuVdHe2sugSKdkPSUcGOExa
=5R9l
-----END PGP SIGNATURE-----

--------------enig839DE06E9CF7AB45004C2A7E--
