From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v2 12/19] mingw: skip test in t1508 that fails due to
 path conversion
Date: Thu, 28 Jan 2016 08:58:35 +0100 (CET)
Message-ID: <alpine.DEB.2.20.1601280856130.2964@virtualbox>
References: <cover.1453650173.git.johannes.schindelin@gmx.de> <cover.1453818789.git.johannes.schindelin@gmx.de> <5aea04c3f348e3891a01b6908bf6562a26f9dd1e.1453818790.git.johannes.schindelin@gmx.de> <xmqqk2mwatjd.fsf@gitster.mtv.corp.google.com>
 <alpine.DEB.2.20.1601270943390.2964@virtualbox> <xmqqzivq7ovu.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jan 28 08:58:51 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aOhTe-000249-Kf
	for gcvg-git-2@plane.gmane.org; Thu, 28 Jan 2016 08:58:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933682AbcA1H6r (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Jan 2016 02:58:47 -0500
Received: from mout.gmx.net ([212.227.17.20]:63351 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932214AbcA1H6q (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Jan 2016 02:58:46 -0500
Received: from virtualbox ([37.24.143.74]) by mail.gmx.com (mrgmx103) with
 ESMTPSA (Nemesis) id 0Lrw2c-1ZxZfG0DRm-013iZ9; Thu, 28 Jan 2016 08:58:36
 +0100
X-X-Sender: virtualbox@virtualbox
In-Reply-To: <xmqqzivq7ovu.fsf@gitster.mtv.corp.google.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
X-Provags-ID: V03:K0:21xct8cLmeLjFgGjvxFsF0JmEvGHQswQwqp9o1s30g7+of5XXfD
 mUXiePvF5eqzgvb5jV0NOAxapuHW01iVGZDPaGBB5Pcl57a8DtC/pKn28BdoiokI2a7WqWp
 exSUcCn9SaxVnlCdKF0IlWHc6uX32qniGnhYqMunbFSnTZsK0FXiNFmFx+jzZHGapRZUyKJ
 Ghj0zkap6/tosVi6e8hpg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:V1Hu2jmw70w=:0WzdiyKMHZsT72FTUesvaS
 pINDXMBJZcABEQRuEl6tWaVpckW0J6to1tN+jHOyokLGXjrMKLB8lE8x7srxACxr9v7yqZZAa
 CbNmmjRIsK3rm7XCx+5dbCHZwZ7m5KdBTmXL/PUa1hbeo5KafDBNw8ZPynovZiNJn75lA1P0V
 092qtktp9MZ6Og8krS+YxhNjcI7OL7HM3zkhLj5fC1eBeLxXho9UNeVwblsvfnmvGS90F8XKc
 EqP1zefQcumcGo25YrFdu4kA/osyA5WkSBjhR/BPolSAkwGws4i97Ov5ih7OAuCrIDcS3ML28
 7rv17RfCHScV8bzqi2Zs86BpqTxPYW+gKHC4vNV4onfyHTvmBcLschrVbjosMoT+F2H0rfi3F
 sp2JYD/ffz2JiloS1JEDBoHThs2fWjP2007JFvbFUZI2sZ3iMnncOa8zNm0DiZHTzNRr9wmyJ
 t8traCER8wxNLcGZAvNuUF7ASnIf2pHmuL0iJ+MjC4pn356IA1dsET/YUHIOqfuKzGKNgbpgY
 JHnXRmyp0aljsU5PAw36mR7a+ozakeQiHMZtcZtMppDcckRofJcQXHDEUOH0mipr6f21rsCVv
 5NLlnTe8UEka2h1luQ2hld3k8UYOiDhwjvq8yLZ295hUwA2bF+lqDitV8ut1gigPSld39pGdb
 KSyP193QPRsHDKs2HaKmQVGkdreH9b4RW1OPgobe89TkeerkkVkXuDkHBcbBUYAbpkk2wePmY
 FOir/No9+tlBLHlUyp/gDZDujXtL0PtESt08GXoeKgK+m9ObJu0zkcaxic12Ioqv2XqGY4Vt 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284983>

Hi Junio,

On Wed, 27 Jan 2016, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> > On Tue, 26 Jan 2016, Junio C Hamano wrote:
> >
> >> Johannes Schindelin <johannes.schindelin@gmx.de> writes:
> >> 
> >> > -	git checkout -b @/at-test &&
> >> > +	if ! test_have_prereq MINGW
> >> > +	then
> >> > +		git checkout -b @/at-slash
> >> 
> >> I presume that this is meant to be "@/at-test", not "@/at-slash".
> >
> > Oh my. That's what you get for redoing patches from scratch. Sorry about
> > that!
> 
> Heh.  That is why it makes me feel uneasy, after asking you to fetch
> from me and fix it up, to hear that you will send in a new reroll.

I should have mentioned that I did rebase what your pu carries onto my
changes locally and found that the only differences were the consistency
tweaks (such as not adding the empty line pointed out by Eric, and such as
using !MINGW through-out).

Ciao,
Dscho
