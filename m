From: Stefan Beller <stefanbeller@googlemail.com>
Subject: Re: [PATCH 2/4] log, format-patch: accept short parameter 'q' for
 quiet
Date: Wed, 31 Jul 2013 12:35:08 +0200
Message-ID: <51F8E85C.9050904@googlemail.com>
References: <1375127398-31904-1-git-send-email-stefanbeller@googlemail.com> <1375127398-31904-3-git-send-email-stefanbeller@googlemail.com> <51F6E71A.8050109@web.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig9EB70F519EBD72531E853189"
Cc: git@vger.kernel.org
To: =?ISO-8859-15?Q?Ren=E9_Scharfe?= <l.s.r@web.de>
X-From: git-owner@vger.kernel.org Wed Jul 31 12:34:58 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V4Tk9-0007l0-Fi
	for gcvg-git-2@plane.gmane.org; Wed, 31 Jul 2013 12:34:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755581Ab3GaKex (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 31 Jul 2013 06:34:53 -0400
Received: from mail-bk0-f48.google.com ([209.85.214.48]:62369 "EHLO
	mail-bk0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754615Ab3GaKex (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 31 Jul 2013 06:34:53 -0400
Received: by mail-bk0-f48.google.com with SMTP id jf20so180922bkc.35
        for <git@vger.kernel.org>; Wed, 31 Jul 2013 03:34:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:x-enigmail-version:content-type;
        bh=gjQGrake+QfY0FuNeYmr6PunP9Y/dFSR2VRov+8BHro=;
        b=WMbXWvkHoxHPnBBfIeNq0vzKdafLgcQbwiVz32qmtCvhvPtFla4PvMxEjW0fLP4O4v
         Hsp5i1Hdtgao9Pr13ss4FVai2p8nI2aY43VAh3uW8Qo6yvAiIJPpVCBLPlmC+fp10bBC
         eClQGl4YCbzZKBXRrJeevTiLW/SzD8jPamMB7DLxLyJ1v5woZxdJFbEbz2FkDgqAQiIW
         BWJIsJW3V22226BPt61oc2J6GQDhMhhOcrngUXH8XiZGIW+sqmIg4QKDiaVHJLT9MN9w
         S2W4PjlK1s8ibFj2trZR6JnGGYUmGBwKKUSYn7V8YqzlwNtnVuhl8zo0YmCTMS/92Cuu
         vebA==
X-Received: by 10.204.189.4 with SMTP id dc4mr9321446bkb.2.1375266891442;
        Wed, 31 Jul 2013 03:34:51 -0700 (PDT)
Received: from [192.168.1.3] (ip-109-91-109-128.unitymediagroup.de. [109.91.109.128])
        by mx.google.com with ESMTPSA id m6sm297619bki.7.2013.07.31.03.34.50
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Wed, 31 Jul 2013 03:34:50 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130623 Thunderbird/17.0.7
In-Reply-To: <51F6E71A.8050109@web.de>
X-Enigmail-Version: 1.4.6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231416>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig9EB70F519EBD72531E853189
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

On 07/30/13 00:05, Ren=E9 Scharfe wrote:
> Am 29.07.2013 21:49, schrieb Stefan Beller:
>>       const struct option builtin_log_options[] =3D {
>> -        OPT_BOOL(0, "quiet", &quiet, N_("suppress diff output")),
>> +        OPT_BOOL('q', "quiet", &quiet, N_("suppress diff output")),
>=20
> You can shorten it using OPT__QUIET.  But that macro should be converte=
d
> to OPT_BOOL first, in turn.  Unless --verbose, for which it sometimes
> makes sense to print ever more output the more often it is specified, I=

> wouldn't expect there to be a command with different levels of
> quietness, but didn't check.
>=20

Thanks for the hint.
I'll look into that as well.


--------------enig9EB70F519EBD72531E853189
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)
Comment: Using GnuPG with undefined - http://www.enigmail.net/

iQIcBAEBAgAGBQJR+OhcAAoJEJQCPTzLflhqFboP/iy1+V5S3QyPIs7S074jDnSb
h47kGTFO6aFv8UrZ8iNx2EsUj4jgdMiYeoAb6Tnr6fj6G7AuYWmtWI3MHf63pyVS
+DFGzl6AQODWmWVzOemBeuoX+IBjxxSm1D2IxCQ27jWTNeGIf1j/jZ/FxdPRrKQp
trk2GnfygoLagIWrsqmq77TRDfD5A73E4Tyffs2YQFrhItq/H85tglwn17ux6yFv
nG8DFrOq2E4Nq33d5j0D5ajhth86vdtJWPTajcHbWB6KguayqBzhIJpxhZS+2QcQ
y6hcxGIdsLSSDaEcjbIf6a+c0hNUjz0hjfomyPVTWueI107pe6Ukva5KEI7KRz9P
WJrQQ9wc00+jgD44qnnFGp7ClzVpVxpYa8RxEcWNJq8S0h5ha/OF+kfvi97VpOvF
vAX+T8ogGrq+4PnQct+IQ/OskFj9UhNLiCegZ8RDbagNty6Bl7JeArlnZbdePv5e
VhzDVvGP4LVKI6cGILBopuBnVkpR0trKFbKHGbu1nVc17m+uPlrpChUu6F+QrdN+
B42meXBVPpfk0rLD8+U+4fXLEQWitpRywfoMFFb7QPIaLd7ymNrcOw9XttP+4+b5
Ex4w1KcdKsOQFa/DD1KwmjraLb9yPB6KP8FyRuv6Q/zuxZCsp12xiMA1f81699zX
6oX5uclY/ifnLrd3HLfE
=j2Se
-----END PGP SIGNATURE-----

--------------enig9EB70F519EBD72531E853189--
