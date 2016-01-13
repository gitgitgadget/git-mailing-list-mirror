From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v4 0/4] Ensure that we can build without libgen.h
Date: Wed, 13 Jan 2016 08:38:28 +0100 (CET)
Message-ID: <alpine.DEB.2.20.1601130836050.2964@virtualbox>
References: <cover.1452536924.git.johannes.schindelin@gmx.de> <cover.1452585382.git.johannes.schindelin@gmx.de> <56959DFA.9000704@ramsayjones.plus.com> <xmqq7fjeqjae.fsf@gitster.mtv.corp.google.com> <5695EB6A.1030402@web.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323329-858872659-1452670711=:2964"
Cc: Junio C Hamano <gitster@pobox.com>,
	Ramsay Jones <ramsay@ramsayjones.plus.com>,
	git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>
To: =?ISO-8859-15?Q?Torsten_B=F6gershausen?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Wed Jan 13 08:38:53 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aJG16-0007wx-3k
	for gcvg-git-2@plane.gmane.org; Wed, 13 Jan 2016 08:38:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754403AbcAMHis (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Jan 2016 02:38:48 -0500
Received: from mout.gmx.net ([212.227.15.19]:49559 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752236AbcAMHir (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Jan 2016 02:38:47 -0500
Received: from virtualbox ([37.24.143.74]) by mail.gmx.com (mrgmx002) with
 ESMTPSA (Nemesis) id 0MDyil-1aOxxo1Sed-00HN2m; Wed, 13 Jan 2016 08:38:31
 +0100
X-X-Sender: virtualbox@virtualbox
In-Reply-To: <5695EB6A.1030402@web.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
X-Provags-ID: V03:K0:XI0lVroZ88bcb6dcWbARwklAmE+WLURWVdjQvZhUSKqgrnpkHNT
 RCgtvdlvtN4KJqwA65y4+9nkn46E+MUXDsiYnndtwnH98flJdbGhzdYH5oZQ4UA5IwjrvVS
 6eP7zi3s4omaUdu1E6RQRiLH2j61SReAFtaswTy1Ag7vp4m6Yy0BrCiwNZakNgXWfgSFexw
 xC1EXjBHgnlSEWX+Pi/Mg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:qsx++g7ljwg=:8txT2zcIv05PZt0YvWh+3f
 d9z2yndI7EADZtUpGWqhUNLM0UGj2NUBYZZd4TrRZf0crAd+Gkk8HOopwn4fd7Sfv6f5opl3l
 o0iab1bRlStBb3saaDx7Ggn6/1kh2FNv7easx0PzkfwTuTjNVWiQAllAZVWO88ZjSVttamsVj
 q3bU4caOS8/83gt79JflTAT2tbnbvK57EGlfX46/F1Tm8clps1Z0fgmTpEU1NWEtEEA+9aYdQ
 cZRdsW2PWJd4xZda0wN24I19mZ3R83s47MykC6UtHRGtbYF1haUulRtMcSUB2XZR3ZaLqNOhE
 Y6gWT8MkreqKyLA/Y7DZJchvbGBOxn+JwNBLCJLrTYJgC0QhLumuiPq7XJglDq0gkEnD0a4Fx
 fMdBfBWuHqJd2e5JRqY8wv73RQQxiOZC3d6zrSv2CKqyCe8yadepZ/Fqq7vDdR9pe3qzR9mcW
 tFdOtLltEe0r7n7HN/PE6XUwWobvVOYODZ/jFjdjuSImJ7NNMo5KxaJMptXYmZFbg/OibFyuB
 b22pYGrBCqJesfmLoSWTWRtg19Ohkhl5k077xv48kWxLjIZgeP8CtmMRBijDQmTTlTK7KN4gO
 3NmBexRmshq41Hdbd1/HMtLx7+OG5LnzIMOru3PWHFriiypjGyEF2XgKGM+IYQUlQ/sj8hu8I
 /V5HdWogvP2bS8m7rxrzHHGiu+IsJnSx3ykTPYMioN70uaiiyOMXe0AeCAPfeOHH0ri8j/RB5
 ErbcQw+x8QIJ95upIAcNYSlCTSE66CWpmn5Bmv8F2HeDVZmU3Zl/aKcvgtCCIarVPSY1Heqd 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283893>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-858872659-1452670711=:2964
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE

Hi Torsten,

On Wed, 13 Jan 2016, Torsten B=F6gershausen wrote:

> On 01/13/2016 03:56 AM, Junio C Hamano wrote:
> > Ramsay Jones <ramsay@ramsayjones.plus.com> writes:
> >
> > > Hi Johannes,
> > > ...
> > > I was somewhat disappointed that you ignored the implementation of
> > > gitbasename() and gitdirname() that was included in the test-libgen.c
> > > file that I sent you. I had hoped they would be (at worst) a good
> > > starting
> > > point if you found them to be lacking for your use case (ie. for the
> > > 64-bit versions of MSVC/MinGW).
> > Sorry to hear that, but the 'next' branch has just been rewound and
> > rebuilt with this series, so it is too late to replace them with
> > another round of reroll.  It however is never too late to improve
> > with incremental updates, though, so please work together and send
> > in a follow-up patch series as/if needed.
> >
> Is there a chance to keep it in next (and not merge to master) until
> we have found a solution for the broken t0060 test under Mac OS X ?

This is actually independent of follow-up patches that might replace the
gitbasename()/gitdirname() functions wholesale, as the problem you
encountered is *differing* behavior: no matter what implementation of
gitdirname() we use, it will either agree with dirname() on Linux or with
dirname() on MacOSX, it cannot do both.

So here is a hot-fix (Junio, would you kindly apply it?):

-- snipsnap --
Subject: [PATCH] t0060: fix dirname test on MacOSX

Contrary to this developer's assumptions, the behavior of dirname("//") is
not consistent between platforms. Let's document this by not removing this
test case, but showing that it behaves differently on MacOSX (unless
NO_LIBGEN_H is defined, that is).

Pointed-out-by: Torsten B=F6gershausen <tboegi@web.de>
Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 test-path-utils.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/test-path-utils.c b/test-path-utils.c
index 4ab68ac..a3a69ce 100644
--- a/test-path-utils.c
+++ b/test-path-utils.c
@@ -142,7 +142,11 @@ static struct test_data dirname_data[] =3D {
 =09{ ".",               "."      },
 =09{ "..",              "."      },
 =09{ "/",               "/"      },
+#if defined(__APPLE__) && !defined(NO_LIBGEN_H)
+=09{ "//",              "/"     },
+#else
 =09{ "//",              "//"     },
+#endif
 #if defined(__CYGWIN__) && !defined(NO_LIBGEN_H)
 =09{ "///",             "//"     },
 =09{ "////",            "//"     },
--=20
2.6.3.windows.1.300.g1c25e49

--8323329-858872659-1452670711=:2964--
