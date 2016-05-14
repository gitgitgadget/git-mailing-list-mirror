From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v2 00/94] libify apply and use lib in am
Date: Sat, 14 May 2016 08:26:40 +0200 (CEST)
Message-ID: <alpine.DEB.2.20.1605140807310.4092@virtualbox>
References: <20160511131745.2914-1-chriscool@tuxfamily.org> <alpine.DEB.2.20.1605130820160.4092@virtualbox> <CAP8UFD2fSW0nds7myfb_09c+EaCdn6+1OqsNEzfY2rVTeA5TAw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
	<avarab@gmail.com>, Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Stefan Beller <sbeller@google.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Ramsay Jones <ramsay@ramsayjones.plus.com>,
	Jeff King <peff@peff.net>,
	Karsten Blees <karsten.blees@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Christian Couder <chriscool@tuxfamily.org>
To: Christian Couder <christian.couder@gmail.com>
X-From: git-owner@vger.kernel.org Sat May 14 08:27:27 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b1T2n-0000dI-Lf
	for gcvg-git-2@plane.gmane.org; Sat, 14 May 2016 08:27:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751516AbcENG1H (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 14 May 2016 02:27:07 -0400
Received: from mout.gmx.net ([212.227.17.22]:54250 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751195AbcENG1G (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 14 May 2016 02:27:06 -0400
Received: from virtualbox ([37.24.143.84]) by mail.gmx.com (mrgmx102) with
 ESMTPSA (Nemesis) id 0MaV3V-1bLTpJ38cD-00KCCV; Sat, 14 May 2016 08:26:40
 +0200
X-X-Sender: virtualbox@virtualbox
In-Reply-To: <CAP8UFD2fSW0nds7myfb_09c+EaCdn6+1OqsNEzfY2rVTeA5TAw@mail.gmail.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
X-Provags-ID: V03:K0:wnDNA9nSvJt4hunGEop9r3WKLO4LwV1hod9HIQic2QrXUenC+N/
 y6hu1ycvPYngt8FhMaY3La9AfRbE4K9P/AvpyXwJtU6kdpWXucnvSiiMTkHpMvhYNWyGiQ+
 Lul2iHRi9h3C9M1hZ9Fc6iBd59wEdTsF6s/LKUR45sccmaYroGMie7EXLCoIF/yp/VFstyH
 vPWmLPloH54WTUTgvwdFg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:61yv/bTVlQE=:tMsG90FXtzrEKQELhdYikH
 quKMH6DGGpusULj53A5joXbUvSXzl9Jo4cu5fvOizHEeV640b3QHVc5ooNDyj5qCnDLf3LGMv
 CeukZAMdf6U1KAEHUmnven+kDYqbahDq56o35RvfXfhBHWnT2FUEr1kvLK4Qkb4WJKsPFZAb7
 z2phxKRIOpQAUprg2vxVphgGtRYlGdmYCDSe3FsG+ZgwR5iUjynv8FqYqS6nWqpxdSLFwEbcw
 6drnKq6OXY66vO3nY2sU5/mMQChww+Uf76leJ/O7DMMisniRxVZwhOJsmBDOwbkFV8WZtumNx
 ycTWocLfqO0MRiHcvYFClORGVEup3ETc/GcC6k7nWSkqxf9dtf1EA9dDtwqM+e31NdJq9+7vJ
 GQI12gptLcWUkJsFGy4y+bxdDCIDeJDNLda0/0z+e2FK1IDbbqEIQ10rph2BYqJQ6qh1a2zOz
 LUBU7H0ZjJIMDI/BsNqEjAeiVmHsvNO4VzfWd08vvdbH2QYIcpIOxOQQiIT5D1Lv+ircu38YD
 IGCBA9YDly4uBdEs2BL8MO4Qdz2PEvFZr/Zy4Tey1E+faLMngROw1aFon3JOEPpJfWWVpNTXK
 Nzmi2x4E++V/AqHV1Hlzj7/Fw0tPCgkP+udTyGeOUg9doirN8Rh9T82cm4AVAl7dYfGWo4k7Z
 r9F1RuvVYnUfrtP2WOm68p9x6yC0V227aioPerYnaQrq5g/sf7fzI2fsDohV6+2YUet60BZfH
 IxDKyO1dgTqT1Wa9BN7/hsttN0XwIbvXLFFfudhWORaZYdt4tDcY/t2Jce9ZvWDQgfiLnxN8 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294603>

Hi Chris,

On Fri, 13 May 2016, Christian Couder wrote:

> On Fri, May 13, 2016 at 8:32 AM, Johannes Schindelin
> <Johannes.Schindelin@gmx.de> wrote:
> >
> > On Wed, 11 May 2016, Christian Couder wrote:
> >
> >> I consider that the apply functionality is properly libified before
> >> these patches, and that they should be in a separate series, but
> >> unfortunately using the libified apply in "git am" unmasks the fact
> >> that "git am", since it was a shell script, has been silencing the
> >> apply functionality by "futzing with file descriptors". And
> >> unfortunately this makes some reviewers unhappy.
> >
> > It is a misrepresentation to claim that this makes some reviewers
> > unhappy.  Speaking for myself, I am very happy. Despite having had to
> > point out that the previous iteration of this patch series had a
> > serious flaw.
> >
> > It is also incorrect to say that the shell script had been "futzing
> > with the file descriptors". You see, the shell script's *own* file
> > descriptors had been left completely unaffected by the redirection of
> > the spawned process' output. That was perfectly fine a thing to do,
> > even if it possibly hid fatal errors. Shell scripts are simply very
> > limiting. The problem was introduced by v1 of this patch series, which
> > changed *the caller's file descriptors* back and forth simply because
> > the called code no longer runs in a separate process. And *that* was,
> > and is, improper.
> 
> I think we should just agree that we disagree on what we think the v1
> was doing and move on to v2.

It is obvious that you want to disagree. But that is counterproductive.

It is important to keep in mind, and needs to be remembered in future
libification efforts, that extra care is required when we no longer spawn
a separate process: you no longer have the option to change global state
*just* for the called process.

This is very true when redirecting (global) file descriptors. I struggle
with this myself in the rebase--helper branch, so it is not only you who
has to face, and address, this issue.

The same goes for die(), too, of course. And for statically allocated
memory. And even worse: when all of a sudden reusing static lockfile
structs. And, and, and. The list goes on.

It really comes back at us that we originally simple did not care about
cleaning up after us "because it is a short-lived process, anyway".

The thing is: this is not at all the philosophical discussion as which
your comment tries to color it. We *have* to address these issues when
libifying code. Yes, it's hard. Yes, it's tedious. Yes, I also want to
bitch about it.

And yes, it must be done.

> >> By the way there are no tests yet for this new feature, and I am not
> >> sure at all that "--silent" and "be_silent" are good names.
> >
> > If you want to follow existing code's example, we typically call this
> > option "quiet".
> 
> In the documentation there is: [... snip ...]
> ...
> 
> So it looks to me that --quiet means something like "don't tell the
> story of your life, but in case of problem you are allowed to
> complain". In other word --quiet generally doesn't suppress error
> messages from error() or die().

Right.

And if you care to take a step back, this is most likely what we want in
libified code.

Modulo die(), of course!

> On the contrary the new feature I tentatively called --silent does
> suppress all output including error messages from error().

And what would be the point of that? Now that we are libifying code, in
contrast to the spawned-process approach, we *can* discern between "prints
to stderr" and "displays an error". I'd wager that you won't find any
error() call in the code path that we want to silence.

> Now if people think that it is not worth making a difference between the
> different behaviors, then I am ok to rename it --quiet, though I wonder
> what will happen if people later want a --quiet that does only what
> --quiet usually does to the other commands.

You know, I get the distinct impression that you do not want my feedback
because you always want "people" to agree with my assessment. I hoped that
my arguments would make sense, but I guess I should spend my time
differently.

> >> Sorry if this patch series is long. I can split it into two or more
> >> series if it is prefered.
> >
> > It is preferred. Much.
> 
> Ok, I will split it then.

Thank you. Maybe you take me off of the Cc: list, too?

Thanks,
Dscho
