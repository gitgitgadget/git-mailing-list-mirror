From: Felipe Micaroni Lalli <micaroni@walltime.info>
Subject: Git feature request: mark a commit as minor
Date: Fri, 2 Oct 2015 18:38:46 -0300
Organization: Walltime
Message-ID: <560EF966.3000501@walltime.info>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="fLRHqCuSBg43u4MF7h7SSSh1fWxuXMetQ"
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Oct 02 23:39:00 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zi82a-000805-Dn
	for gcvg-git-2@plane.gmane.org; Fri, 02 Oct 2015 23:38:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751550AbbJBViw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 2 Oct 2015 17:38:52 -0400
Received: from mail-qg0-f51.google.com ([209.85.192.51]:35005 "EHLO
	mail-qg0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751076AbbJBViv (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Oct 2015 17:38:51 -0400
Received: by qgt47 with SMTP id 47so106321886qgt.2
        for <git@vger.kernel.org>; Fri, 02 Oct 2015 14:38:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:to:from:subject:organization:message-id:date
         :user-agent:mime-version:content-type;
        bh=+V/cnjYZJzEyr7KbHoWCYKtRZJ4zpnwYALC4fwiv+wM=;
        b=iTxzWiG9OySlEmhbAvD4lLvIQfbTuVo6KvsPifntQKyw/kZiSwvcNdyfn8EX5TBR22
         M+RDR4yWI15/R7itHTt/iOKK9ekQXtFpODvd2sO9PSQiIJQnE2+siZlBJ/c4k5kj+UAk
         2ddC4ylCzRQCzUwKgp0N7T1zJv7PuddePUYXECzsHaLAEwQcwA2/5eHZfpvRucDsxnMl
         /XfXXnKRahdHH5ntPisoV0OmmIc5p9ciKIJ21H6V6O1uJCtn9Pm8/2Jop1+Z+wtjTKZF
         PToafuiQp23EevmJTqsP8jNs7h6+nf5PveSg283rzSiL2e7JX0Jw3lJj0I/cLcnhDA1a
         4/WA==
X-Gm-Message-State: ALoCoQlEEVzsIe4cSz80+elbCH3FqdRFthzHHqlaVMqU1leb2qVkdcvEko/Ct9nShm/OFP2cTvx2
X-Received: by 10.140.218.138 with SMTP id o132mr24674076qhb.101.1443821930918;
        Fri, 02 Oct 2015 14:38:50 -0700 (PDT)
Received: from [192.168.1.56] ([179.110.8.33])
        by smtp.googlemail.com with ESMTPSA id 19sm5470559qgo.41.2015.10.02.14.38.48
        for <git@vger.kernel.org>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 02 Oct 2015 14:38:49 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.2.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278952>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--fLRHqCuSBg43u4MF7h7SSSh1fWxuXMetQ
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

A minor change (also called "cosmetic") usually is a typo fix, doc
improvement, a little code refactoring that don't change the behavior etc=
=2E

In Wikipedia we can mark an edition as "minor".

It would be nice to have an argument like "--minor" in git-commit to
mark the commit as minor. Also, filter in git-log (like --hide-minor) to
hide the minor changes. The git-log could be optimized to show minor
commits more discreetly.



Thank you.


--fLRHqCuSBg43u4MF7h7SSSh1fWxuXMetQ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJWDvlmAAoJEEwK/M/tXN4UQdoQAJM9OWrttnMBgyyrT4H96qKH
5/HExOgmYHfPldzFrFF2UKR4QWsV//sStikIO1tEIzJkOnatep5TpbsKE2RRtQLt
XI9wnFkLwmRCqgIX+SVmWcF5888BArxGjN//jRjVSvynfPNxmFyvST4TpyOWZTNS
YjmFiqVSFk7n/Qi0jWYm62imbAYpJoNDYC8Oujem3ewfvJnkVYNIB0iRHK4Hofb4
AO+V+UynBHdjAZllsrACssT/A8ImoMp7T5J/5cvV6ZSGLrQFQl6XWjhV/cXQ+4tX
ect96pNCkLi1YVKPJbTxF0p/E/N4cjW8Il0IU60qf2puMVNxpif+Xc60eGhN910g
+Wih8sL//D+OvPxaVb5kZEiBgTw7d/vxyonvLFzHhe4tBUkqHin/XdfoSXtllztb
FfnVE0A/mwtJ8Y575R39TFq7wRLL0sJv1j0mp6+zxjMulwqfbj7hlktLJNLP1Vrh
CKs4cn9PX+c+rNpCSFVDOVAi0dP9GqF3mINoi/H9ggYp/oBNxcR8GVt/x7cPJ8kC
2jqe2cFUOIUBIX7eiWFY3HFbKtoeSaamKsyUl5iXVaxJCnVSvaDZCIUZS7KV1Mku
WBGbxqvw4JF5D2QzkvR63gQLF8cb+G+HgqNiw/FkK01IzLwkzVNQzen+uREi/UaW
EnJlh2zrTS5Ed8x9Vdv5
=0K/o
-----END PGP SIGNATURE-----

--fLRHqCuSBg43u4MF7h7SSSh1fWxuXMetQ--
