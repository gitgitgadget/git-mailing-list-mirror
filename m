From: "Joachim Schmitz" <jojo@schmitz-digital.de>
Subject: RE: What's cooking in git.git (Sep 2012, #05; Fri, 14)
Date: Mon, 17 Sep 2012 09:19:50 +0200
Message-ID: <003c01cd94a4$d4bc73c0$7e355b40$@schmitz-digital.de>
References: <7vboh82t7p.fsf@alter.siamese.dyndns.org> <k31k35$pc$1@ger.gmane.org> <7v4nmz1aqi.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: <git@vger.kernel.org>
To: "'Junio C Hamano'" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Sep 17 09:21:10 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TDVdj-0004By-17
	for gcvg-git-2@plane.gmane.org; Mon, 17 Sep 2012 09:21:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753971Ab2IQHUS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Sep 2012 03:20:18 -0400
Received: from moutng.kundenserver.de ([212.227.126.187]:57669 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753617Ab2IQHUP (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Sep 2012 03:20:15 -0400
Received: from DualCore (dsdf-4db53772.pool.mediaWays.net [77.181.55.114])
	by mrelayeu.kundenserver.de (node=mreu2) with ESMTP (Nemesis)
	id 0Mhgu7-1SrBHk2ETb-00N0Ym; Mon, 17 Sep 2012 09:20:03 +0200
In-Reply-To: 
X-Mailer: Microsoft Outlook 14.0
Thread-Index: AQFSM/QZ0Uszb/mjAZasqQgOWx1JcQGOwwCVAMV3/MMC6nm6oZha617Q
Content-Language: de
X-Provags-ID: V02:K0:+6la32MyzDpEVipJE5fSkmfxxoKFyKeIi+vgal7LXKr
 /nA1asaYFh42N2QdXVkhTugo60a9+MEvucG8Eu9/Ef0B5wBiCZ
 F1hGj9O2aT1FMbaj/H6wZ9PkZlShbfG1ETtoQeaOVjObGODjE6
 eXCO4js05PCj0AN4zMUwG3yCG2lAYr0KYd1f0HiCtIpf9susux
 VolGqdEZX1YC0Wh4/ogqluaFXNJy53gqd/ofbzJVGoE3lX0J2u
 3fbbh5L/7Pczml5cPCEG4Yt2H/mcyKtukrTpnEDHWbqbFdbOIb
 VjMb9v8Aca6166vo8dvFiQf/EuuYVISnxM0u13uKgtM6RgvvID
 d8odpWVsIddU22ARl3fdHYMtgsRCq8slrWDjr4O9gHv5HKYzwE
 plAb/9VpAgQ4A==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205662>

> From: Joachim Schmitz [mailto:jojo@schmitz-digital.de]
> Sent: Saturday, September 15, 2012 7:15 PM
> To: 'Junio C Hamano'
> Cc: 'git@vger.kernel.org'
> Subject: RE: What's cooking in git.git (Sep 2012, #05; Fri, 14)
> 
> > From: Junio C Hamano [mailto:gitster@pobox.com]
> > Sent: Saturday, September 15, 2012 7:01 PM
> > To: Joachim Schmitz
> > Cc: git@vger.kernel.org
> > Subject: Re: What's cooking in git.git (Sep 2012, #05; Fri, 14)
> >
> > "Joachim Schmitz" <jojo@schmitz-digital.de> writes:
> >
> > > Junio C Hamano wrote:
> > >> I think we can start thinking about feature freeze once the topics
> > >> in 'next' that are scheduled to graduate to 'master' already are
> > >> fully cooked.  For any late-coming topic, there always is the next
> > >> cycle ;-)
> > >
> > > I've not hear anything about my poll patches and I'd really like them
> > > to into 1.8.x.
> >
> > I've seen some patches on "poll" posted, were discussed and had
> > threads titled "Re: [PATCH] ...".  But I didn't see a rerolled
> > "[PATCH v2 n/m] ..." series that states that it is a rerolled
> > "hopefully final version" that addresses all the points that were
> > brought up during the discussion that need to be addressed.
> >
> > I do not necessarily follow all the minute details of all discussion
> > threads.  For this particular series, I not know which ones of your
> > "poll patches" turned out to be unneeded, which ones turned out to
> > be fine as posted originally and which ones needed updating.
> 
> There were several iterations up to [PATCH v4 n/4] and only one foreign comment to it (and to some commented code) and one self-
> comment about the order of patches, but none about technical correctness, none that I remember at least.
> 
> I can post a v5 series which will

Actually v6, seems I got myself confused in what I send already, one part of the series was on v5 already, aother on v4 and yet
another still on v3.

> - move compat/win32/poll.[ch] to compat/poll/ and adjust Makefile
> - #ifdef some WIN32 specific #include (should this be done in one step with the above?)

Decided for 2 patches

> - fix the 2 bugs in poll.c just like they got fixed in gnulib's version (would you want this in one or two steps?)

Likewise
 
Bye, Jojo
