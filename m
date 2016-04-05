From: Jacek Wielemborek <d33tah@gmail.com>
Subject: Re: Feature request: config option for default git commit -v
Date: Tue, 5 Apr 2016 18:41:26 +0200
Message-ID: <5703EAB6.2060006@gmail.com>
References: <5703CDE0.7010007@gmail.com>
 <CAFZEwPMq3hwM91URzoJ7WQV1QcY++KqRENNtChb8z+s4YAi4vA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="HVS0jBDP7GJ9dUVmTjUTE24SsQw10Ou7N"
Cc: Git List <git@vger.kernel.org>
To: Pranit Bauva <pranit.bauva@gmail.com>
X-From: git-owner@vger.kernel.org Tue Apr 05 18:42:05 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1anU3G-0001um-A1
	for gcvg-git-2@plane.gmane.org; Tue, 05 Apr 2016 18:42:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758493AbcDEQlm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 5 Apr 2016 12:41:42 -0400
Received: from mail-lf0-f42.google.com ([209.85.215.42]:36696 "EHLO
	mail-lf0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757763AbcDEQlj (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Apr 2016 12:41:39 -0400
Received: by mail-lf0-f42.google.com with SMTP id g184so14837636lfb.3
        for <git@vger.kernel.org>; Tue, 05 Apr 2016 09:41:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=subject:to:references:cc:from:message-id:date:mime-version
         :in-reply-to;
        bh=lLnpYT18qj8cKSN/LfE5xCzaAu/K7cMbh2YUdDQomas=;
        b=oAjCXZTlE4IimfroMxnfSTRd2qipvXRScUa23gln/nW/ecg8E2/s4eys/S05ca6b+a
         UGMcTMD8GvVcFWbvFSabOQFhtWlU8BQbDhG4hL6ijkEfNi473SLXXM0xY3HcSfRi6RnF
         nOqEMLmI85teN/pU8CmxJocxXheTGawTAyBraVBjnDZ3owOPRiZwTsRtgdOp0muzNfTT
         fezS8RpBIuBLejNYmMpSaw5kkCf8yr6KYKtSaF0pGvtzw1ncP9zKgSy8BQ7W1b/FEdAX
         H/LH9ePjoGE/S6cyOzMZJKz4KVnvCd9d9J0LzAQjbCW3EePHAU9q6uHXYjlEOYkrH4Xx
         fzFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :mime-version:in-reply-to;
        bh=lLnpYT18qj8cKSN/LfE5xCzaAu/K7cMbh2YUdDQomas=;
        b=VAj2PEeGz++4erQj6PmebmqeDxwByiRJUt6Qs/gRxsCtxlmAgkFo1hvSFEJYFwN3OY
         q8WC860V4D4gIoNbUzwZr4g/R7mO7rjoMe+tBL/W78UWlwt3lnHeAZ5CBER89ctkg/nF
         vY+mBAoc54KXKZ92fc6bhgYKx9qfv8Qq92RDB7RX6f4khiFxo/jO6mB8lzMHpsiISBvK
         vfyvWZ3CbeqBQv7SE/GJmTFd3bh5U/+8r3WVALLc/Bz8TEjFroqqdmOt7jsQcRaKZAUP
         ZbQ3VpLoFw47V9ffapMUHsuj3c97Nd+vJ8Xi49VjbrY/03E0nnLfALrnAjIrudVkq8fK
         RUZA==
X-Gm-Message-State: AD7BkJJWADiAOJq5S+M9WGbGp+ysz968JkXWbcXY+eRE5lVv14If43eB1pdT9lCwDbW8ew==
X-Received: by 10.25.208.144 with SMTP id h138mr5550210lfg.48.1459874498046;
        Tue, 05 Apr 2016 09:41:38 -0700 (PDT)
Received: from [192.168.0.139] (94-229-220-66.static.espol.com.pl. [94.229.220.66])
        by smtp.googlemail.com with ESMTPSA id m65sm5775979lfm.13.2016.04.05.09.41.36
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 05 Apr 2016 09:41:36 -0700 (PDT)
In-Reply-To: <CAFZEwPMq3hwM91URzoJ7WQV1QcY++KqRENNtChb8z+s4YAi4vA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290797>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--HVS0jBDP7GJ9dUVmTjUTE24SsQw10Ou7N
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

W dniu 05.04.2016 o 16:47, Pranit Bauva pisze:
> On Tue, Apr 5, 2016 at 8:08 PM, Jacek Wielemborek <d33tah@gmail.com> wr=
ote:
>> Hello,
>>
>> I'm asking for this one because there's quite a lot of interest
>> (including me) in this feature and there is no convenient walkaround:
>>
>> https://stackoverflow.com/questions/5875275/git-commit-v-by-default
>>
>> Cheers,
>> d33tah
>=20
> This is currently under progress. I am the one who is working on it.
> One of the patches is currently on the pu branch. I am still polishing
> it to include some more stuff. You can track its status by reading the
> git.git messages by the git maintainer. The latest revision of the
> patch is at http://thread.gmane.org/gmane.comp.version-control.git/2888=
20
>=20
> Thanks,
> Pranit Bauva

Awesome, thanks for the quick answer! I let the StackOverflow folks know.=



--HVS0jBDP7GJ9dUVmTjUTE24SsQw10Ou7N
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJXA+q2AAoJEGlViymZXJRv84kP/3xmck+uon46Dnwy7uskrXCW
Gejgqwbmb9QpD4G32E1CjSkxB0rl9sccHJwGBoZKLjlkg5DLpQ0dQKraovfyZ81T
Ao5sHP7fehU/F/iUACXeFKMR1wIS9fKb4O8J+zoZ08ROugQS9cNfOzpAED6B4QiP
eveZiQI8au0UsiYJ0zwPPAcaWEY7KkULz2XMYbAfIqb/OKz8LAToFXPPXuVUnEBq
MT3HVdMOuq5tQGAFUhwVg50BBkMHeCFmSP/YsjxVnHDPCvHRbGTt7IkIRsxsVllx
NkNDEZ8/o0fsnlacubXgfsUJDxxFnZ/fTmxybvU0Zf2aW79M2hj50LsF3kNmufup
cxNS3qd2AIlVBSnuATpwibVoec4GgaO/qG9qSdhxkyoRoKwGDbeFzFhr0mnKjsZO
gFhWXh8UpBAst0/BsJYtORP2J0O4gAkDv2HncNp8nQkCt8/y0dWBGKIjzCbO4YEe
qXL2hkbtu1mu4CeXyLydsHSWIRD5BuC0A74/FJAqJE3p14U/UTAfYQV+S0Fxvf/R
06Pbn0lILTr9lYOYNAnfcObXNGeGjGkXXiqbT/QeqRnbVXoM8Iwkv+snPF+jwGPm
jla2+D1QFzxH/wtpKvqjWUX4KBhL55P6M+Ro9i5CgGF7BxJbZG79JosUHe54ThMg
oyjsSppxGeS9bX4zKbW9
=7iGm
-----END PGP SIGNATURE-----

--HVS0jBDP7GJ9dUVmTjUTE24SsQw10Ou7N--
