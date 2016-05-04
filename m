From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] t5510: run auto-gc in the foreground
Date: Wed, 4 May 2016 07:48:25 +0200 (CEST)
Message-ID: <alpine.DEB.2.20.1605040741500.9313@virtualbox>
References: <20160501153743.323-1-szeder@ira.uka.de> <alpine.DEB.2.20.1605020859131.9313@virtualbox> <20160503015526.Horde.e0uZ0P4BqpNnwx_zmhu3WfE@webmail.informatik.kit.edu> <20160503135028.Horde.jeJdKT1kb2NTVAS1HpcsQh2@webmail.informatik.kit.edu>
Mime-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323329-196050737-1462340906=:9313"
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder@ira.uka.de>
X-From: git-owner@vger.kernel.org Wed May 04 07:48:51 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1axpg2-00064f-T8
	for gcvg-git-2@plane.gmane.org; Wed, 04 May 2016 07:48:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756908AbcEDFsn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 May 2016 01:48:43 -0400
Received: from mout.gmx.net ([212.227.15.18]:59749 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751574AbcEDFsl (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 May 2016 01:48:41 -0400
Received: from virtualbox ([37.24.143.84]) by mail.gmx.com (mrgmx003) with
 ESMTPSA (Nemesis) id 0LxPNC-1biYYy1w0Q-01707i; Wed, 04 May 2016 07:48:26
 +0200
X-X-Sender: virtualbox@virtualbox
In-Reply-To: <20160503135028.Horde.jeJdKT1kb2NTVAS1HpcsQh2@webmail.informatik.kit.edu>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
X-Provags-ID: V03:K0:DcBhEn8weTLtuC49klVnXWagFmUco8YF1ZsGrk0qIUmCJoBg2qA
 MZNGjcdpR6kDoTIxxkRVMf8sQwAQm0wHUVzkaiv/2iEH1BJmcmlkPfen3ui4UCUQ3lLyarf
 +YJJPi91LEVtKpYVCnCOpSeiNQtK6Anm1vfhUO/r0Prncx82TT4gBIjdoSr6um9Dq/ME1Fn
 YmFc7xs4iizaJLU1XNXtQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:OPDGZJNs/wQ=:j8jXJCVI+mADb8O/3ogSaa
 zTM4HEpXNsUZMlzldvlyI6JLKCYVrfRrxbgz/udqikR+I/P3CFQUAxmQxHu6pCFlkw/VSqbi8
 aaKjhUgy967WJq0su31JwlRsmBFUxl1lLKcYbcet7HA92Z4YcIw7M9pa/yMFCRp3mJbEYxoHX
 TjqKywtnqsC5QKAld/b1XgRT98SJnRTZHhs7e8XGlJDqdrJHIVDbw6NWA+6pZhPSsPEqEv5XS
 OwHb9xq+PksRr0TUUvqyRyAAf5TKjRiuez+tI2LCJ7sfkpzcbCXzz+s0iny07v7UeHE8xnY3z
 USshdGraKuZ9rtjOo9fgUpB1/zsuahv+2MJCQNau3RM2Q8tyEfUCOWCz0hvQxasHWJ6/CdOme
 njsL8cp91f/j9u2bfK2umO0LmdpM5ybjituJNbBr7mHD2ajV2ktKsspil0/yEYp3tiC6xsdI7
 ZJKJqNLBc2Ap1GsWUPfXDJI+J56gbX1AxbG5xM4Ha9/XDWJl7KjARnnvu8xMd9aHiT7c/yvtU
 jNwcL/zDMKSZuep4i8STC48VbOrFh/8oXC1N/EaMyfPOzDmhlfmiBmJG9Ce8+fssVlgeoUXWt
 eqxjh2XfcJJcND+ZMVjk5aQThGIcdS/5qEAHvCASzUtZjuqnh0A9Afw8UHuWEib3RZf66/ZjB
 PAoVr6V2qntVCUsTenGQkfnN32fsTdHvcH717YkCIT2thXWAnSQ5nNhr4+Ar2qvirT+Hsb9ab
 Yg5Vu497Qt8O2v++gIv/Nua3PUH1WZ01cIYRCKDE5xbhaVk5PSmJJ98whWbAqZ+cGBMC3t0c 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293493>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-196050737-1462340906=:9313
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

Hi G=C3=A1bor,

On Tue, 3 May 2016, SZEDER G=C3=A1bor wrote:

> Quoting SZEDER G=C3=A1bor <szeder@ira.uka.de>:
>=20
> >Quoting Johannes Schindelin <Johannes.Schindelin@gmx.de>:
> >
> > >Hi G=C3=A1bor,
> > >
> > >On Sun, 1 May 2016, SZEDER G=C3=A1bor wrote:
> > >
> > > >diff --git a/t/t5510-fetch.sh b/t/t5510-fetch.sh
> > > >index 38321d19efbe..454d896390c0 100755
> > > >--- a/t/t5510-fetch.sh
> > > >+++ b/t/t5510-fetch.sh
> > > >@@ -682,6 +682,7 @@ test_expect_success 'fetching with auto-gc does
> > > >not lock up' '
> > > > (
> > > >  cd auto-gc &&
> > > >  git config gc.autoPackLimit 1 &&
> > > >+=09=09git config gc.autoDetach false &&
> > > >  GIT_ASK_YESNO=3D"$D/askyesno" git fetch >fetch.out 2>&1 &&
> > > >  ! grep "Should I try again" fetch.out
> > > > )
> > >
> > >Sounds good to me.
> >
> >There is something still bothering me, though.
> >
> >I take this was a Windows-specific issue; deleting open files on Linux i=
s
> >no brainer.  According to a comment on the original Git for Windows issu=
e
> >at github[1], 'git gc' runs in the background by default on Windows as w=
ell.
>=20
> Ok, having slept on it, it was a false alarm.
>=20
> Though 'git gc --auto' claims "Auto packing the repository in background =
for
> optimum performance." on Windows, it does in fact runs in the foreground.

Thanks for checking. I ran out of time yesterday.

> 'git gc --auto' first prints that message, unless gc.autoDetach is disabl=
ed,
> and then calls daemonize() to go to the background.  However, daemonize()=
 is
> basically a no-op on Windows, thus 'git gc' will remain in the foreground=
 and
> the sequence I described below is impossible.  Good.

Oh, right. I think this will take a lot of energy to fix: daemonize()'s
functionality is not really available, indeed. What *is* available is a
spawn() that detaches the new process.

> Perhaps it would be worth updating 'git gc' to not lie about going to the
> background when we can already know in advance that it won't.

Hmm.  https://github.com/git/git/blob/master/builtin/gc.c#L372-L373
already looks correct (should it really know that we cannot daemonize()?
What about other code paths using that function?):

=09=09=09if (detach_auto)
=09=09=09=09fprintf(stderr, _("Auto packing the repository in background fo=
r optimum performance.\n"));
=09=09=09else
=09=09=09=09fprintf(stderr, _("Auto packing the repository for optimum perf=
ormance.\n"));

Ciao,
Dscho
--8323329-196050737-1462340906=:9313--
