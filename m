From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: What's cooking in git.git (Dec 2015, #05; Tue, 15)
Date: Wed, 16 Dec 2015 16:58:51 +0100 (CET)
Message-ID: <alpine.DEB.2.20.1512161657250.6483@virtualbox>
References: <xmqq8u4ve3at.fsf@gitster.mtv.corp.google.com> <20151215233207.GA30294@sigill.intra.peff.net> <xmqqbn9rffo0.fsf@gitster.mtv.corp.google.com> <xmqq4mfjff9x.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Dec 16 16:59:15 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a9ETx-0001jm-VJ
	for gcvg-git-2@plane.gmane.org; Wed, 16 Dec 2015 16:59:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965545AbbLPP7J (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Dec 2015 10:59:09 -0500
Received: from mout.gmx.net ([212.227.17.21]:60736 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752442AbbLPP7H (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Dec 2015 10:59:07 -0500
Received: from virtualbox ([37.24.143.114]) by mail.gmx.com (mrgmx102) with
 ESMTPSA (Nemesis) id 0Lpxdr-1afHy51vFP-00ffO7; Wed, 16 Dec 2015 16:58:54
 +0100
X-X-Sender: virtualbox@virtualbox
In-Reply-To: <xmqq4mfjff9x.fsf@gitster.mtv.corp.google.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
X-Provags-ID: V03:K0:uLt8AB8e5BgEM8YjZzCY8CTynTmkD3a+8DVpldGIqxKBtXSG5Ru
 3OICwEHMEORHgucsfGfBTSCd+4RYOgt7yDRArS+hS2G+kf6S+Pr1xOPds6RG7j+lU3m1Bts
 f42RS+LJA8vz2fUnQTl2sXrep2FlLG3dqM3FenasAryxQva9fCyP4OL6L66RgZHwrZY78yQ
 xMp4+nOKR8puFpYu0m/uw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:3xkRUv/WUvA=:RybcCYVqsPGykXkxfVzTTW
 K2ico0IxdGfRmY+RDPcXuKoHsKOvdiEEdWP50TzxOoNlPFDJgAPFSfc1ICK6tknoyrzp9xHZ3
 ZvlNx2BYkTDbjKH9ASmt8uBm8alG8uSEPY8QjS/m3SzPNqA4y+kzOFKVqdZEkrS/rwVUDbxYp
 jI3WvmxkL93osrzWrQGz9HJQxW6nuX6WqWYiZ9Evtgp016OhuSqrKkRL1xb2ANFqsKjNM7Yvs
 zITtmTz+v6LDsAYnX7Zmookj7QeER1JfOL7saY1mt7CtGFtJnfKa1oeurrmgyPda6TDIZ6Hwt
 jT323+ZaIUKqrdattg21HqREfZX+To5gnmK76mt+V2TRhH3bHfc6ptfR+DN8qma5KpPRlXC/o
 7g4RhqJMnPteXYafRcXb/HGM6E3z+LbzIP7473EP97n6hakQieabBmCCLsTa803p9tA0shETr
 FVYCcKz3Fy5GG7kl1cEPSUAFSL4D1sA1t3iAdQ73X+pwGhLyaUJGQ3PMhBVKLDYv9Oaz+hKye
 cnH56UJaJewh72LDfqil8/SnoX0gkk8SOEI8XhjFDiEHYPvjnds/2G1uGKYpqBfvHF1jRIiBd
 FHpNmDrsFolVuM0f1as33YV5I/aksFmiEexE7quew1RPY4wDNiaE9YYDQv0e/64CPcuz6kTgE
 K7qDa9/yB5CeqwpecZ19VHb+SDpTHwnmVjMedDRYh4S58ygpzEagpW36e1k1T1X0Cd5Vi3l2u
 KiToSOgMFpbzjEUg6WfH5jJDxRQDrm83XTQ1z6VBrOckXZazX7MdAD0yKkJ7UA7dGwTtTroF 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282575>

Hi Junio,

On Tue, 15 Dec 2015, Junio C Hamano wrote:

> Junio C Hamano <gitster@pobox.com> writes:
> 
> > There already was strbuf_getline_crlf(), and I wanted a new name to
> > be conservative.
> 
> When I re-read the series, I realize that the existing one had
> exactly the same semantics as strbuf_gets(), so I think no risk
> would come from reusing that name.  Let me try redoing the series
> when I find time ;-)

v1 is still in my inbox, and I promise it has not been malice that I did
not review it yet. Hopefully I will have enough brain cycles available
when you post v2.

Very interested,
Dscho
