From: Stefan Beller <stefanbeller@googlemail.com>
Subject: Re: What's cooking in git.git (Aug 2013, #03; Tue, 13)
Date: Wed, 14 Aug 2013 08:47:15 +0200
Message-ID: <520B27F3.3010508@googlemail.com>
References: <7vvc39utxi.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig3C3219F498574294560A74AC"
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Aug 14 08:47:38 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V9Urq-0006DI-GV
	for gcvg-git-2@plane.gmane.org; Wed, 14 Aug 2013 08:47:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754363Ab3HNGre (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Aug 2013 02:47:34 -0400
Received: from mail-wg0-f43.google.com ([74.125.82.43]:46302 "EHLO
	mail-wg0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753864Ab3HNGrc (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Aug 2013 02:47:32 -0400
Received: by mail-wg0-f43.google.com with SMTP id z12so7170274wgg.34
        for <git@vger.kernel.org>; Tue, 13 Aug 2013 23:47:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type;
        bh=vXBjiaC/BqFD88V46tWan686qQ8Jk8lUp2ngSuY4SpQ=;
        b=Zv5shN6K1gRnAXoHvaepvdK0Bw3L5WZC5UrHKtMt19dC6rn+6tRqAcw4O82FvGcJaS
         xSsY73ivmvfALgZHS78ba/DhubDlQKOpCVqnPQRsVOqvBThTvpYFcICk3vuJTIY7sLsP
         hfGtOxhUy1m1VIW7iHi3ftp01VKVHybaWAzdAICtFCOqhrszKW/9yjB8+Qsp/8EPvzaT
         gtd23fQGS5Pn2NoRm6ryGBRp/H/vPwUXnL+2McNtxYIg3GIwD/+yudePYSbQo25OtaFS
         A6j8aSfqxiV3Ilx1KcwXnIMYJUiGaBENipx1K2dQW6g+CbIi2so3uX8hkU/ayciLzome
         6aYg==
X-Received: by 10.194.78.78 with SMTP id z14mr243299wjw.32.1376462849176;
        Tue, 13 Aug 2013 23:47:29 -0700 (PDT)
Received: from [192.168.1.3] (ip-109-91-109-128.unitymediagroup.de. [109.91.109.128])
        by mx.google.com with ESMTPSA id v9sm858231wiw.8.1969.12.31.16.00.00
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 13 Aug 2013 23:47:28 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130803 Thunderbird/17.0.8
In-Reply-To: <7vvc39utxi.fsf@alter.siamese.dyndns.org>
X-Enigmail-Version: 1.4.6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232261>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig3C3219F498574294560A74AC
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 08/14/2013 12:06 AM, Junio C Hamano wrote:
> * sb/parseopt-boolean-removal (2013-08-07) 9 commits
>   (merged to 'next' on 2013-08-08 at b138a2d)
>  + revert: use the OPT_CMDMODE for parsing, reducing code
>  + checkout-index: fix negations of even numbers of -n
>  + config parsing options: allow one flag multiple times
>  + hash-object: replace stdin parsing OPT_BOOLEAN by OPT_COUNTUP
>  + branch, commit, name-rev: ease up boolean conditions
>  + checkout: remove superfluous local variable
>  + log, format-patch: parsing uses OPT__QUIET
>  + Replace deprecated OPT_BOOLEAN by OPT_BOOL
>  + Remove deprecated OPTION_BOOLEAN for parsing arguments
>  (this branch uses jc/parseopt-command-modes.)
>=20
>  Convert most uses of OPT_BOOLEAN/OPTION_BOOLEAN that can use
>  OPT_BOOL/OPTION_BOOLEAN which have much saner semantics, and turn
>  remaining ones into OPT_SET_INT, OPT_COUNTUP, etc. as necessary;
>  there seems to be some misconversion that makes many tests fail,
>  though.
>=20
>  Will cook in 'next'.

Locally here all tests succeed, when testing that branch alone.
Which tests fail for you, so I can look into it?

> * sb/fsck-opt-bool (2013-07-29) 1 commit
>  (merged to 'next' on 2013-07-30 at 8a9964c)
> + fsck: Replace deprecated OPT_BOOLEAN by OPT_BOOL
>
> Will cook in 'next'.

This one is completely included in sb/parseopt-boolean-removal,
but doesn't need jc/parseopt-command-modes. So once we're
confident with jc/parseopt-command-modes, we could drop this
branch as well.

Thanks,
Stefan


--------------enig3C3219F498574294560A74AC
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)
Comment: Using GnuPG with undefined - http://www.enigmail.net/

iQIcBAEBAgAGBQJSCygCAAoJEJQCPTzLflhq9FQP/19Yv75faFvEOrCj0aRE1KJj
Qxf8uf/JW28J2sC93zq0gqdRBIaWhuvVkxLqbVTPDQGSjujsm6DjjMf1mbtw/9tY
cjT3fvPZuQve33JEu1b+9ESATEJ0KBHcXFFV2CZRdxl6e/RUTQD/j4wy3jtpx6GZ
GL0Q23okgc4xUjYD42/qrGn/hAN6IdxKLhO130s3Fv6xI/AmCnW1UIVLbxxQ43dH
qYHRQHBaMdz1eoAuSO59QeS7L3VJdA06AFkA1291YXGUJbUcp5guAN3r8QjdGfUj
9Ff+yKPErHfj0ff3qLXTIoA9FkwLgXYPdXxavBnkG2i9OQkUF+3ABvTS8N8wihV8
4JBw3T5QifB6jSz9h3lwfhssAqeUy5R7iVBi0tqx7CfGiAnWNeW9bg0Xn7X99Y78
zWEykfP6ObGgsFS1hmhGxQiInKzFcXJp6ebvGluXKydlASkg2ud49n0OOcRn+wTg
apqq0+7q4s4XH7I4EA0aDudkfDh81vBIJ23d9P5V8vDMo+vdgnwCG3JRUod7JosO
oyuTHOOFrYRTKWsz+px8wF4S8B8R/aiSB9j2Yu3387NPOUX6a2o+IYLAIYPvemIQ
wdhU5oeVS9682piXK2B/ikab8+AD7LbnS+i3Mhs8z6DlGf5CbBpICWvxaFq8UcX+
3deQK6tuc9H+tPMyuJv6
=WMrD
-----END PGP SIGNATURE-----

--------------enig3C3219F498574294560A74AC--
