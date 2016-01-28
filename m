From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v3 00/20] Let Git's tests pass on Windows
Date: Thu, 28 Jan 2016 09:57:58 +0100 (CET)
Message-ID: <alpine.DEB.2.20.1601280957040.2964@virtualbox>
References: <cover.1453818789.git.johannes.schindelin@gmx.de> <cover.1453911367.git.johannes.schindelin@gmx.de> <CAPig+cQR11JtTrcHNAWytTRfdWis4qmzODs-Key-8c+8fgKoUQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Thu Jan 28 09:58:24 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aOiPC-0005AY-Uo
	for gcvg-git-2@plane.gmane.org; Thu, 28 Jan 2016 09:58:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933533AbcA1I6Q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Jan 2016 03:58:16 -0500
Received: from mout.gmx.net ([212.227.15.15]:59876 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752368AbcA1I6O (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Jan 2016 03:58:14 -0500
Received: from virtualbox ([37.24.143.74]) by mail.gmx.com (mrgmx002) with
 ESMTPSA (Nemesis) id 0LmKOI-1Zpvsg3I1K-00ZuLf; Thu, 28 Jan 2016 09:58:00
 +0100
X-X-Sender: virtualbox@virtualbox
In-Reply-To: <CAPig+cQR11JtTrcHNAWytTRfdWis4qmzODs-Key-8c+8fgKoUQ@mail.gmail.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
X-Provags-ID: V03:K0:6fKNySv9LX4meb0O84y3IZBKIfMlYOtk8vfj43V3jKkihtmdjx/
 E/84K4K2w6dSx5UgCgRxycGdeGdwYgM3sARGaBSDzboDpAfQsUKCDuntStQTWWQnaZxaktr
 bcAiT23xYx0mNWWEjEvuB92JiBOLnACcD/6HePuOr0av8LRndGrHQ3/s1+4uAjcinBSF/Fh
 +l4FRQf6cdwyCE3a12JSg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:aHsWojCRVEg=:PIXplK1F0Fw7qpFuzu8q5k
 n6f0gcXDej7KlQY/uUMvppqp05jkRHgAGruHzj636rOVtqmqZStHhCJTCRjDXv11bdFKR8Xdn
 YwYU3XkD4M8CeZI888MEgjaqz9LhVJvORcc84Njp9IZnJaIJrQgVSPjUeieCGgVOePLKwuPbP
 2QQYesN1AHJckoj4Ume25UFp61ljAlTGkltPxm17APG84NFe44ojIQP5qED20nLqYrcWA6lN8
 hZRRM7/4+Sgbg8ocgFvtjeetHf0hWNVdmDVSH0x2rXQvsE0DeWfYBXDnKf8dhFGlhaAgVsjC7
 PwYMKvqbz3hnEbjHzA7mZRCmSR63rwaMLB6knWI4Ml8nRPh8ZpA+jHcelUSl1bQ1BTRPapxAW
 A0uDuFNqvBGgVcTb25plw8sygyFj/mtaAT9e5VQjPdHWXRALviVRt6yi4raoCTE6eXpVN7Gjj
 tijG71D84cng6Fa6dn9bvFMgROTGm2Ayc5yfKGwM5UoK7oFG7ExaTZF73z5o011SP1xMNEfdt
 3RUhdtD8H5uBfAec+e4HmPxYcSYqdXl+sXbGlZGpIUTtUrYzY/h0Z4cE3fPfImBBp+z0AMAaX
 MG02F0CWYordhzKALqBCZo6Gv4lmD/ESAk2wblm7g2aAL4fQc2MPNTY2CwgZ08in4eYtrlkdI
 0wboBsetWH6F42THLQyZ5GA4NSqCrtv5uWCGf1tlh6q5LN7dItfP4B+CjtJJl/FwaBWTgEVWz
 ZUQGIOUrxHSdkfgLRUS+pruysYwNSbDznTVwqyvLCLLSeD2jC744O+/rg/zsnFe/T//ou55i 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284992>

Hi Eric,

On Thu, 28 Jan 2016, Eric Sunshine wrote:

> On Wed, Jan 27, 2016 at 11:19 AM, Johannes Schindelin
> <johannes.schindelin@gmx.de> wrote:
> > Relative to v2, this fixes stupid typos that made the tests fail on
> > Linux, a stupid copy-paste error pointed out by Eric Sunshine,
> > unnecessary 'printf ""' calls pointed out by Junio Hamano, and I now
> > use `test_have_prereq !MINGW` consistently, as pointed out by both Eric
> > and Junio. This time, I also send the patch series with the character
> > set set (sic!) to UTF-8. Oh, and this time, I also made sure that the
> > regression tests pass on Windows & Linux alike.
> 
> For what it's worth, I ran the test suite on Mac OS X and FreeBSD, as
> well, with this series applied and didn't run across any problems. I
> also read through v3 and, other than the micro nit in patch 11/20,
> didn't find anything upon which to comment.

Thank you so much! I really appreciate your feedback, and I have a lot of
respect for reviewers that go through a 19 or 20 strong patch series.

Thanks!
Dscho
