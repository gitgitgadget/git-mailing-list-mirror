From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 2/3] Teach 'git remote' that the config var branch.*.rebase
 can be 'interactive'
Date: Wed, 13 Jan 2016 14:26:26 +0100 (CET)
Message-ID: <alpine.DEB.2.20.1601131422260.2964@virtualbox>
References: <cover.1452612112.git.johannes.schindelin@gmx.de> <8c98523f8a3f2c6f2f3db1e4572e05c28f94688d.1452612112.git.johannes.schindelin@gmx.de> <vpq7fjdyfvu.fsf@anie.imag.fr> <alpine.DEB.2.20.1601131302340.2964@virtualbox> <vpqziw9oefy.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Paul Tan <pyokagan@gmail.com>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Wed Jan 13 14:27:17 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aJLSG-00009o-Ee
	for gcvg-git-2@plane.gmane.org; Wed, 13 Jan 2016 14:27:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933677AbcAMN1J (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Jan 2016 08:27:09 -0500
Received: from mout.gmx.net ([212.227.17.21]:62065 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754543AbcAMN1H (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Jan 2016 08:27:07 -0500
Received: from virtualbox ([37.24.143.74]) by mail.gmx.com (mrgmx102) with
 ESMTPSA (Nemesis) id 0MSHax-1ale6i3N0d-00TYTh; Wed, 13 Jan 2016 14:26:27
 +0100
X-X-Sender: virtualbox@virtualbox
In-Reply-To: <vpqziw9oefy.fsf@anie.imag.fr>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
X-Provags-ID: V03:K0:EiwQ3965VolANrn32+f/4Izf1i+DB+O+BGcgErts4JKk/AVydz+
 ZmkI7+8bVCT1PBax4JgNPuYhCUkLkxBM+i/woA8SpqMhzF1HEcIs/5wu2gyLJgQOln9v//g
 3jHWFhbV1Yv/haHPe1gD5CFFgAgLTxZGYUyVIYyw8KX6N2JRtglP5dnb6codL4hE/ver2Mh
 ornN3gnNNfrfEfcqcNhZA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:2WeZoj5dSc4=:ymQ0lbPWsU08eOkxtdjjnV
 QbLRn3MpBFay9oFZ678Gbt2V/Epg+XL1L8fEfbaUgHCGBMew+gSYH9WDrhZdjc0EmcIomJUjr
 00Ov1YGxsTgbRMSU5RF6eXFdVXGS1hFJ705Tgezhbs72RpAEC7kjwjRrj0oklZPfglddkPKlr
 ZwlVOu5V9MHQK5EkpnQjHfxbQmtG0rG/dm0jadN9Dc+8oWZwkVgAZ3s4LKRVUivgB5+l2CnNy
 D8V3AmV7ElypOw5tl7gBcN9LrIfZcRDby4Ro38qluSWuuxXfGekTp/YPOjccesmm5/wNkecZb
 X9WDbTc9yeHc5LZuPysYSfFbpdwq2w9B8JbaeuIux5HsuQs3WWcZddD9AL7FEvxEHHVkptGJg
 1QYgE0+to5Pbxqp8e1nkda2xNPBi2v//rzf4PLAjwpl6fXIuLS6f2UNJlR1rlb4aFb5IdjF2G
 Zq5R0NlfjwwbxfzTOeL1sKdJDIN7fRTqjQFFEDbJ0FSBQFb+GRwuto10++1VAcYCtTuVj2cIS
 /+5oSsAQciSekX68+jcpvKdG0tfwX9cuZQJBbSFkDowh/SIK5ZqMpFTZ/voH3LVuEFH0arOGz
 MRZqrkfnQlUpTE/V4RVxHfowIz98YFIGqzBFp7M/e4eyPWAjEUT9p4UusladbXaE68lrgbrnn
 ijR/s5kc9rqmdQfRXqiw7NlldwZauZy5Aptg7Br/qwfpHdpsDXglHQ5rIqrcTBP17p6tHn/bH
 MbH69YhF4HxWszbmzuTihO1cidt8pOI3OCSuorUpRjii21SHFhzTn2zRRHaj2LTvtETtyWkH 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283914>

Hi Matthieu,

On Wed, 13 Jan 2016, Matthieu Moy wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> > On Wed, 13 Jan 2016, Matthieu Moy wrote:
> >
> >> Johannes Schindelin <johannes.schindelin@gmx.de> writes:
> >>
> >> What happens if one has branch.*.rebase=interactive, and wants to
> >> make an exception? Does
> >> 
> >>   git pull --rebase=true
> >> 
> >> cancel the 'interactive' part?
> >
> > It is the same situation as before (just substitute a
> > branch.*.rebase=preserve setting): yes, the config is parsed first,
> > then the command line, so the command line wins.
> >
> >> I guess it is, but if so I think it should be tested and documented.
> >
> > Is this really necessary, given that the behavior has not changed from
> > before?
> 
> Well, before your patch, branch.*.rebase=interactive was not possible.

But branch.*.rebase=preserve was. And it is still different from
branch.*.rebase=true. And as per v2.7.0, those config settings can be
overridden via the command line.

Seeing as I did not change that behavior, I would find it a bit odd to
document that the command line can override the config setting.

> It is not immediately clear to me that --rebase=true can mean "do the
> pull with rebasing, but without going interactive", as "do pull with
> rebase" and "rebase interactively" could be two independant things.
> Reading the current doc does not help much: "When true, rebase the
> current branch on top of the upstream branch after fetching" => it does
> not say that "true" also specifies which kind of rebase is performed.

Again, I did not change that behavior, and the same confusion could arise
with the "preserve" setting.

But I do not really see the confusion, as `git rebase` (without -p and
without -i) means: "perform a rebase", and everybody assumes that it is a
non-interactive, non-merge-preserving rebase. Hence I would assume that
users know that a rebase without any further adjective refers to the
plain, non-interactive, non-merge-preserving one.

Ciao,
Dscho
