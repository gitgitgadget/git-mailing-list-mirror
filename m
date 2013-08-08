From: Stefan Beller <stefanbeller@googlemail.com>
Subject: Re: [PATCH] diff: remove another ternary expression always evaluating
 to true
Date: Fri, 09 Aug 2013 00:17:49 +0200
Message-ID: <5204190D.9040604@googlemail.com>
References: <1375988103-29947-1-git-send-email-stefanbeller@googlemail.com> <87241414EE67485DAC10602B3BB85F2D@PhilipOakley>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig1C31750A23DA5E324645E739"
Cc: git@vger.kernel.org, Jens.Lehmann@web.de,
	johannes.schindelin@gmx.de, gitster@pobox.com
To: Philip Oakley <philipoakley@iee.org>
X-From: git-owner@vger.kernel.org Fri Aug 09 00:17:53 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V7YWn-0001zq-7G
	for gcvg-git-2@plane.gmane.org; Fri, 09 Aug 2013 00:17:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758238Ab3HHWRt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Aug 2013 18:17:49 -0400
Received: from mail-ee0-f44.google.com ([74.125.83.44]:62240 "EHLO
	mail-ee0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758182Ab3HHWRs (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Aug 2013 18:17:48 -0400
Received: by mail-ee0-f44.google.com with SMTP id b47so1811791eek.3
        for <git@vger.kernel.org>; Thu, 08 Aug 2013 15:17:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type;
        bh=Qk4IOvCXaQFvxr5pgdzNbh3J0sbqNdX/MZPfcikFQCY=;
        b=agtwcwnLuGaLNQImSQI0Svnwtj7fL0UkvGkQwtvEcVSL6qRq/nKz3kNPmKGqKS61m1
         +L0vyb02Zc/UuHJf0pxyZJuKzn2+vrSo+D0bShCMXTdHOhaa9UScxBgUX6gay+xJ/J2e
         AdedMo6r8QI2qFGyd+fGacWyVOmUNoAkxExXvqtSG+Deeqy1ngEOeuMDcHVjxk+TEhfn
         GQ1MBt3DvMqe81ZzTwsgV8R4lOVvndpVWPg+6QI3XOgsVc58wY9ZSGhcuqgVzFQyzw+o
         ylqHrK6GHznF4xjjtKr40LwgeX6mo23r0NM7wCm3kBinw8pS26vuq+NszmXAiKN2pvf5
         ByrQ==
X-Received: by 10.14.111.198 with SMTP id w46mr10172995eeg.66.1376000267305;
        Thu, 08 Aug 2013 15:17:47 -0700 (PDT)
Received: from [192.168.1.3] (ip-109-91-109-128.unitymediagroup.de. [109.91.109.128])
        by mx.google.com with ESMTPSA id j2sm23120258eep.6.2013.08.08.15.17.45
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Thu, 08 Aug 2013 15:17:46 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130623 Thunderbird/17.0.7
In-Reply-To: <87241414EE67485DAC10602B3BB85F2D@PhilipOakley>
X-Enigmail-Version: 1.4.6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231945>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig1C31750A23DA5E324645E739
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 08/08/2013 11:36 PM, Philip Oakley wrote:
> From: "Stefan Beller" <stefanbeller@googlemail.com>
> Sent: Thursday, August 08, 2013 7:55 PM
> Subject: [PATCH] diff: remove another ternary expression always
> evaluating to true
>=20
> Have these issues (and the earlier expression simplifications patches
> $gmane/231916, $gmane/231912 ) been discovered with the "STACK" tool I'=
d
> noted in $gmane/230542 which you were also interested in (I've not had
> chance to run the tool).
>=20
> If so, it's probably worth referencing the tool and the paper which
> explains the broader issues.
>=20
> Philip
>=20

Yes, those 3 issues have been discovered using the STACK tool
The paper regarding that tool can be found at
http://pdos.csail.mit.edu/~xi/papers/stack-sosp13.pdf

It's definitely an interesting read! (At least for me it was ;)
The authors intend to make that tool available to broader public
as open source in August this year, iirc.

However I do not know if their repository address was
already announced publicly, so I did not announce to have used it.
(Last time I announced using static code analysis tools for
my patches the review-process was much harder as well :D)

Stefan


--------------enig1C31750A23DA5E324645E739
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)
Comment: Using GnuPG with undefined - http://www.enigmail.net/

iQIcBAEBAgAGBQJSBBkNAAoJEJQCPTzLflhqdW8P/RJDXvtk3mIQde3DhHj/vGjm
LjIx54eWTRhcWNVoym9Uoozjz46Di9aJu9JmwBzRaMeuu42Ra5l0bX2TAhERxrfU
KH7KgtHt1f4hbm8HczOcB9bRMtYhoAramfDl0Io6W0/uWuyHgUaaeIuxmX8inQyl
zvb8ca5GJL0TNbHVPqf6S32O9BW4tzFTDM/8Ck+W3sQyzZ+siWYFllsFzUKQrGpN
Jl9rQhzmYsE7bm3cebHd+9jysT13FFq24HJIaAtJ+sBl8M+IQwvfFYEq13Be0jSt
4f94Y6AA69tpgj2o3fOo5GhetqFyzdh+6wiBnnS7TdFnZLCqKvdDn02SQt2CbTbO
qQur9NRVR3Oqyv9cicwvPJB+KNEiv+RyIUNotFikgi2ZN5o84VCU4LovwGBRxsKe
Vkz1LQSqmkqg8SzS6lKZyMbT0z8Xjs/9l14lVisnr5yVfYMl5iEdtLX12l8E72QP
nE3Jvvd0r/uV/UDqQobh5wJuw6j65q176vrtbwmlFaACsMloKFsM0dnV8d/NJW1o
jl9n7Z8kTRJXMnQrXr9oBzM/AJlqeiw1qt+kpGPU9DyN67x7xqiodZK9/70G/yRx
Dx2lU08Ro3ZsxUC54R73mAAHmBdHRKaCMM4Z9Ud+5eDPToE3FttX80NpIr1QCE5B
G3MB32ikEypjGTlYQ5PL
=3QNF
-----END PGP SIGNATURE-----

--------------enig1C31750A23DA5E324645E739--
