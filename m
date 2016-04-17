From: Christoph Paulik <cpaulik@gmail.com>
Subject: git merge branch --no-commit does commit fast forward merges
Date: Sun, 17 Apr 2016 23:10:51 +0200
Message-ID: <874mb0kkkk.fsf@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha256; protocol="application/pgp-signature"
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Apr 17 23:12:00 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1artz2-0004oL-CE
	for gcvg-git-2@plane.gmane.org; Sun, 17 Apr 2016 23:11:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750901AbcDQVLB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 17 Apr 2016 17:11:01 -0400
Received: from mail-wm0-f51.google.com ([74.125.82.51]:37566 "EHLO
	mail-wm0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750803AbcDQVLA (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 17 Apr 2016 17:11:00 -0400
Received: by mail-wm0-f51.google.com with SMTP id n3so98830881wmn.0
        for <git@vger.kernel.org>; Sun, 17 Apr 2016 14:10:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=user-agent:from:to:subject:date:message-id:mime-version;
        bh=lCOn1lxL8sjGDCIwjv8lZuQBYkLZ+OTdJHyT/RDG1Gg=;
        b=FKFHyZYvaNPI0LWVZrwi6ZCe0Cd1dF/Fs9afUaSIMBEJCbtOWplCmQFqe5yD6toOhX
         lRO1XiuhQZcrwFn/orwFkfCruPB8I9jcTMXmS8d0lHRbr0arSRe95HIJSZFGOZrWbA7l
         01D9kSwzR5pzt8JzH5w/VymRvCmKhopgDmgzybEe0QvpHreIDz3adypo0brwyqHvZ8CA
         Ui0vXY2Z6w2LOyKOGfXgg0IsYbYtInhIj2QwyL05N2YfznoduL+6t0VRFsn0Wuvde1jD
         Oo1H1VLpB2Amo5RPvf1Nr7nsftIri14I/x0xZcS2rmhFppyPBOacC9LwxVjp1JWeutx8
         1kBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:user-agent:from:to:subject:date:message-id
         :mime-version;
        bh=lCOn1lxL8sjGDCIwjv8lZuQBYkLZ+OTdJHyT/RDG1Gg=;
        b=GofZ2xv45VJansvTVAqnqUuZkBP9W0k+fjhF2QSKbSSzKLF/DXgTIoHBTkOknmHZAD
         fnrr9JvDdTGaHMqmGjMFPzuMBq7FQcgpMWzix66Oy9Q+RDOoH+nKFhjNB/q+/NwI5DK3
         lVEzUgQbYpSlJTsFetJRvEaqfeMfOTEa0nSlvCPt4eNZ8ANB4z87N9RgEIUIN6Ucg+2I
         kHzkF4qsLjdeTRlAhk4G+MiSLP7u89E/52PB/hwjv0uWYMa/N91kLliDubUvPdd8w9ts
         CMpNsA/dtSP5X3HJiIio9wnIaLO3LpISt/7oCOV8a48AedKczpZIdXpphZM8B00o2jMS
         mcBw==
X-Gm-Message-State: AOPr4FUlUmJxk9nJ7C5DDBSoMl1pTlkL7wF+CKnSIqjlQZ80FxFy7OT4hffT19H12nN+ZA==
X-Received: by 10.194.59.138 with SMTP id z10mr31631274wjq.74.1460927458463;
        Sun, 17 Apr 2016 14:10:58 -0700 (PDT)
Received: from cp-laptop (62-178-79-172.cable.dynamic.surfer.at. [62.178.79.172])
        by smtp.gmail.com with ESMTPSA id ux5sm60615611wjc.17.2016.04.17.14.10.57
        for <git@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 17 Apr 2016 14:10:57 -0700 (PDT)
User-agent: mu4e 0.9.16; emacs 24.5.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291776>

--=-=-=
Content-Type: text/plain; format=flowed
Content-Transfer-Encoding: quoted-printable


Hi Git Mailinglist,=20

git merge branch --no-commit does commit fast forward merges=20
leaving users no way to change the merge results. The command only=20
works as expected when also adding the --no-ff flag. Looking at=20
the help text of the --no-commit flag I think that this might be a=20
unintended.=20

I've tested this on git 2.8.0.

This bug was first reported to magit=20
(https://github.com/magit/magit/issues/2620) whose maintainer then=20
suggested that it might be a git bug.

Best regards,
Christoph


=2D-=20

=2D------------------------------------------------------
Christoph Paulik
Twitter, Github: @cpaulik
PGP: 8CFC D7DF 2867 B2DC 749B  1B0A 6E3B A262 5186 A0AC

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJXE/vbAAoJEG47omJRhqCs2zkQAN8HoXHa4mpeCgQSkaDlc5hE
38jwGXk4IkFr4TzNAGNLafs2aOFAaJhxiRvJtwA4O/WLNlS+ubpYFb0zQe94yNGz
HEub1msuxhpYMGnw+a5O+95fTHxL04ryz//yZIQW3X6ZZ0RpLEN2Kf5+cC9WZoOl
Yh+lk9m6iXDQxpItbSravmWIBrc2kdeMdYuLC2B0o8OXGLmNN4V1dO3dIjqeVWwd
j+adFT+PgN5d+Qwf0StbDjIvzRi3g1ara1IM+nfanDRDQHsUJ9QSpxa/dFxrPLfW
pw23Aeqbn7vL+V2A2vM9WM+/p40GnAZWzOobcVkrh7awNmfWDf4RCztX/XdqcMpq
0+CqOtFVW69e+EViFiYSWQdKuGQJiZKmNZzjiqZF5jFkjQiGNCfHir9RO8cZTs9L
dzNWGXCMwbudk1xYjpzaPhfff/DsNRVN6cgh2j7tjeCjV2NVN2z+UMyae+699kdm
Sle53OpCVt7oOYMMstr9LW6rvp9tjJNCkNz6DhLuINkkfIMOEpHJbZnVstFiGr5W
XAKR2e+UumkQFKhTdNLXP/Se5aDH3DjvQwBj5Xnu3aB8+QwCXmkLiWTsFQ3z+LP7
fOTwUDaFE11lRay+9QXd2qqJHPG8dh3QNasH+YuXsLGTyDnG0EqTGQ3QqeUrNFfD
g7TI4OI/KkhkmHJoG5m9
=Gshz
-----END PGP SIGNATURE-----
--=-=-=--
