From: Stefan Beller <stefanbeller@googlemail.com>
Subject: Re: Reproducible, corrupt packfile after fresh git-svn checkout message
Date: Fri, 09 Aug 2013 14:54:21 +0200
Message-ID: <5204E67D.9090106@googlemail.com>
References: <52037F47.5010302@exxcellent.de> <52037F84.9060006@exxcellent.de> <f1d8f80d6fa3678ac043bfdb19bebf6bf4261273@localhost> <877gfw4byx.fsf@linux-k42r.v.cablecom.net> <262a9f8309a3812970f47ac9f4e4b49bb972ca49@localhost> <87fvuk2wl0.fsf@linux-k42r.v.cablecom.net> <9aa1672d5c04994f416dccd84b5983c960c0fdf9@localhost> <vpqli4cfhhe.fsf@anie.imag.fr> <813506281f7a4d3a8af650c5f8ee33dd7224f193@localhost> <vpqfvukfgr5.fsf@anie.imag.fr> <edc9f41b4ffca9ce36dc50e749de7a86e4618a0e@localhost> <87fvuk1cyl.fsf@linux-k42r.v.cablecom.net> <5203B100.30008@gmail.com> <87txj0i4mc.fsf@inf.ethz.ch> <7vsiyk9j6a.fsf@alter.siamese.dyndns.org> <5204E018.4000808@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigAC458C79C16F990F8E2C9286"
Cc: Junio C Hamano <gitster@pobox.com>,
	Thomas Rast <trast@inf.ethz.ch>, git@vger.kernel.org,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To: Ben Tebulin <tebulin@googlemail.com>
X-From: git-owner@vger.kernel.org Fri Aug 09 14:54:24 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V7mD1-0004sk-D7
	for gcvg-git-2@plane.gmane.org; Fri, 09 Aug 2013 14:54:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966841Ab3HIMyT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Aug 2013 08:54:19 -0400
Received: from mail-ea0-f181.google.com ([209.85.215.181]:46843 "EHLO
	mail-ea0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S966704Ab3HIMyT (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Aug 2013 08:54:19 -0400
Received: by mail-ea0-f181.google.com with SMTP id d10so2052507eaj.40
        for <git@vger.kernel.org>; Fri, 09 Aug 2013 05:54:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type;
        bh=h2sDNDSMF0dmELpjzu8u/gYBQiv/5dH0YnaxH4bptBo=;
        b=sflD3OMyrnMwHRj+FoRec0+rkTJZVTd4YaMKA9SFVsqvt3K77/blxYK13SrS30Zbz9
         QPpOOBVkgKsdTQmXWArVi1ZHlCKZnGTfL0lvWCO0HA8mZGMIyK1/ATjSQ0vphAinlhAD
         y/12VdQH0Ztg89DcAUprxkbjPncQLeKkKjPpk91M4x6itXpZH1N0atfg0rB3WJis/Wsa
         fZu9Tx2FzJ1y6Nq5DT4tfYUdX3uIsdG5VY3g/6XXWbiTBB8IDGxjMWMB/+0DhmqjB5z0
         MvzV2oHUW8SZUvGxg4BXstrW2yWoEedRMo1KovufXsthtIqpqwT3+TS2ciD7SrewNkns
         xskA==
X-Received: by 10.14.8.199 with SMTP id 47mr538637eer.101.1376052857332;
        Fri, 09 Aug 2013 05:54:17 -0700 (PDT)
Received: from [192.168.1.3] (ip-109-91-109-128.unitymediagroup.de. [109.91.109.128])
        by mx.google.com with ESMTPSA id f49sm22802932eec.7.2013.08.09.05.54.15
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Fri, 09 Aug 2013 05:54:16 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130623 Thunderbird/17.0.7
In-Reply-To: <5204E018.4000808@gmail.com>
X-Enigmail-Version: 1.4.6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231977>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigAC458C79C16F990F8E2C9286
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 08/09/2013 02:27 PM, Ben Tebulin wrote:
> Hello everybody!
>=20
> I have some _very interesting_ news regarding this issue!
> Here is the deal:
>=20
>   1. I was able to *reproduce the error on a machine of a coworker!*
>=20
>   2. I was able to rule out
>       - HDD: It's reproducible from /dev/shm
>       - Memory: Memory tests works fine
>=20
> now the interesting part:
>=20
>   3. Occurs on Linux kernels 3.7.10, 3.8.x, 3.9.11, 3.10.5
>      _but not on:_ 3.6.11, 3.5.7 and 2.6.32
>=20
> Both machines showing this problem are =BBDell Latitude E6330=AB with a=
n
> =BBi5-3340M @ 2.70GHz=AB CPU. Mine running stock kernels, coworker usin=
g
> plain Ubuntu 13.04.
>=20
> Furthermore I need to stress, that we never had any issues with our
> devices during daily _at all_.
>=20
> So what to do best now?

Maybe include the kernel mailing list, they know what's up ;)
Linking to the start of the discussion $gmane/33602
Maybe you could also run git through strace and diff the output of a
faulty machine with a correct machine?

Stefan



--------------enigAC458C79C16F990F8E2C9286
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)
Comment: Using GnuPG with undefined - http://www.enigmail.net/

iQIcBAEBAgAGBQJSBOZ9AAoJEJQCPTzLflhqb7EP/13cbFXJcghl6v8LLpg7f9Ts
/b4qGctdvAG04Be4lNFvVK4AC/BM/uHHmyKY35lRfpLV+TiSlcONfhhwvUJmCWCv
mOrlRmnHH9JsixWdOsyISHcjIHnTg772HdotVscETe9A1xluwZzFcMT34OVzRFft
lFDDse/56sEGaoMGVnREArnZEfZAj4wqri/BgW7UuQL4ujC/MfN6tXu/Id7fyOP5
tc4v0EVCRr4k81gR5bgy1R/4TxucZ+73Dhs7lesBrkOARSbdygoE3UKHadZBCjPH
OMr4bcmedmGW2Wb3n7sRit09w7VOYAKFA7G/tbjdZJqdrfa6x09Dok3PFvbwcVc7
1fpX/9qLV9Fqm3APSMp6hfnGxrvOf2cc3CBVtS03qjjJmlORofUUI1h90AoLCQfN
9YcBMD74+Gb/iNXOiFigA3oK2vRBepNCrRFwFRgPM+IzzKsLAW0dZg/PvRA1p+Ki
K+BMVjfRCoyW2wZabZLciIoPFT/RLNVLq7xjqQcwYBpS2R2WfL1aEjF3flvTwKol
ryGA40a8juKLggT6OD2/EqylTcBC0revBA3tg6KMb6NhsUrrDyrcJGl2rKtblQCQ
iVthZ6VQzZpJKMMsef4AlsXYJx2G1HAc56/DjXk6ly9PZ5m3SKuLseTdXbMV18IT
Lz59gK38kro+ERIBk66F
=xNjJ
-----END PGP SIGNATURE-----

--------------enigAC458C79C16F990F8E2C9286--
