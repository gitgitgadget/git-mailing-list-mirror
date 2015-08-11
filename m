From: Matthew Thode <mthode@mthode.org>
Subject: config options for automatic signed tags and signed pushes
Date: Tue, 11 Aug 2015 14:06:01 -0500
Message-ID: <55CA4799.7@mthode.org>
Reply-To: mthode@mthode.org
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="8J76Xe0hQPoAAGnXcns85M009c7fcdx1D"
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 11 21:15:53 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZPF1c-0006rA-Iy
	for gcvg-git-2@plane.gmane.org; Tue, 11 Aug 2015 21:15:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753222AbbHKTPs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Aug 2015 15:15:48 -0400
Received: from 216-82-208-22.static.grandenetworks.net ([216.82.208.22]:46356
	"EHLO mx1.mthode.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752615AbbHKTPs (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Aug 2015 15:15:48 -0400
X-Greylist: delayed 418 seconds by postgrey-1.27 at vger.kernel.org; Tue, 11 Aug 2015 15:15:47 EDT
Received: from [10.0.3.3] (unknown [10.0.3.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mx1.mthode.org (Postfix) with ESMTPSA id 302781FE78
	for <git@vger.kernel.org>; Tue, 11 Aug 2015 15:09:13 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mthode.org;
	s=default; t=1439320153;
	bh=ggtWchGj4P8p93cqRnFuxejYoU9a7zdIC2EIPCk8So0=;
	h=Reply-To:To:From:Subject:Date;
	b=roG1IaPEPTXgV2bqG3Fg8u/ufcdpahaQA8knLjZuXGHFaRZ2GVAIX3MI2udux1AHg
	 reqYrmpCpZG1c5oVJ8W51Ag6QLVChEcBDMyWNVX51s/4nxHIx7wq7/D/apOCDqQBBL
	 wGDSJHJgXRiURwP2Ja8p6DkkHSg6rpuhxHe18gIo=
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.1.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275711>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--8J76Xe0hQPoAAGnXcns85M009c7fcdx1D
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

If it doesn't already exist (not that I can find). I'd like to see
config options analogous to commit.gpgsign for both tagging and pushing.

Not sure where else to send this request though, let me know if there's
a better place.

Thanks,
--=20
Matthew Thode


--8J76Xe0hQPoAAGnXcns85M009c7fcdx1D
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBCgAGBQJVykehAAoJEGSje+quGaToj0UQAL2mNtGkuMRhXQjLUtD/5Xes
opjC3S6EcBj9rwVR5R9tpv4fGW5QugmJfZ/K10+NdhO0q8zW+Qmak0aSxgGz2/CF
CaCzxM2rWeBAASvn0mVIUV80y1QbYmkb1vJj8jxNkYVHL9A8bww5PGazn3oTAAhO
x/AS9sLofP38wrWvXUehD/2FFbGTWIJdEJtxnRuKr6rBE5ZGdlXc+A1SIuvHI7qJ
5FJPKF+PoBKKuFJUX6SC7QrldXUuMV+M7Xr4fF1XHx4GHBqFT2aoVVVfcYLPO+qs
11bGJ+IAEnEaqisHxKFf23WbHFkM/f4A5wG1N46Wl7+ZTRCMppotxDFRCosnmzXh
i3o9GEPUVgyTTrpJRXNO3bE4ZEWWgs6lMtkc49owcH1QsOE0nyqO93knMqrJHq0q
G1dZj3aWf7rUe6e57B2xUK1uaVrCj1um0etUrAKkrkbH6joCyFVJJNCB3kOsFaqe
9C2unxuDvRj04U4DMspeVp9iACzC99xk7ZncIfTJkYIs6CNEza+pQQEgL9P4wfFT
7PO0fSTWA6VuFtVn67EV/nBap9rosiFTodsHs9IaqOBS7h5iNF/sKFn2AJF3bnby
x3TFc6azSRgBAW7Rm3Us+rPLjJiAivfoQKdi1LWTvGrBDpINO8bqIXVSo9HlmntV
UCVOcABYdOJu2dZBAhEW
=NOS0
-----END PGP SIGNATURE-----

--8J76Xe0hQPoAAGnXcns85M009c7fcdx1D--
