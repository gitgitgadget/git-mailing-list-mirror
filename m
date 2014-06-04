From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [msysGit] Re: [PATCH] Add a Windows-specific fallback to
 getenv("HOME");
Date: Wed, 4 Jun 2014 19:49:42 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.1406041946510.14982@s15462909.onlinehome-server.info>
References: <20140604114730.GB22250@camelia.ucw.cz> <CACsJy8BDk4gdRzjp_XpQXXMW1sEnS4DoedanFLONODuJXdeeRA@mail.gmail.com> <CABPQNSYXsu1muRTVUg6ybB9_MJP_wJi-4PmSec+8EwrvsCHMRw@mail.gmail.com> <alpine.DEB.1.00.1406041713500.14982@s15462909.onlinehome-server.info>
 <CABPQNSavYCrdUDyNru-HHMFkdgDRvaCp++f8ZgGKv07sS0eXGQ@mail.gmail.com> <alpine.DEB.1.00.1406041725460.14982@s15462909.onlinehome-server.info> <20140604154503.GB22681@camelia.ucw.cz> <alpine.DEB.1.00.1406041749590.14982@s15462909.onlinehome-server.info>
 <20140604161625.GB23226@camelia.ucw.cz>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Erik Faye-Lund <kusmabite@gmail.com>,
	Duy Nguyen <pclouds@gmail.com>,
	GIT Mailing-list <git@vger.kernel.org>,
	Thomas Braun <thomas.braun@virtuell-zuhause.de>,
	msysGit <msysgit@googlegroups.com>
To: Stepan Kasal <kasal@ucw.cz>
X-From: git-owner@vger.kernel.org Wed Jun 04 19:49:56 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WsFJt-0007wW-TE
	for gcvg-git-2@plane.gmane.org; Wed, 04 Jun 2014 19:49:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751387AbaFDRtq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Jun 2014 13:49:46 -0400
Received: from mout.gmx.net ([212.227.17.22]:58664 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750925AbaFDRtp (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Jun 2014 13:49:45 -0400
Received: from s15462909.onlinehome-server.info ([87.106.4.80]) by
 mail.gmx.com (mrgmx001) with ESMTPSA (Nemesis) id 0Lm34j-1WIudL442L-00Zggr;
 Wed, 04 Jun 2014 19:49:43 +0200
X-X-Sender: schindelin@s15462909.onlinehome-server.info
In-Reply-To: <20140604161625.GB23226@camelia.ucw.cz>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Provags-ID: V03:K0:Go2Nqb7dwQNme5fNvjNMez4k5pn4XDNKsUkKm9la7UUgmnD8hfA
 aE6EI9eaIEq0Gf5MLRBh1pfYLVE4s6YNlDX8R4zg3Do7fOKqBapfVuTda6s0OzOM008Zqcl
 zM1bZmz2CRczE7DhQH93UANphfryVo2VYegw4iHq3B/397UkauGxEEEySNd1DSzuETY0jjP
 7k7KUebLKhHhELBuhMaOQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250750>

Hi Stepan,

On Wed, 4 Jun 2014, Stepan Kasal wrote:

> PS (about mingwGitDevEnv):
> > plan is to switch to mingwGitDevEnv for said release. No more msysGit.
> > Like, bu-bye. Thanks for all the fish.
> 
> Interesting.
> 
> With msysgit, there is the "net installer" - first time I installed
> msys/mingw sucessfully, it was as easy as Cygwin, perhaps even
> easier.
> 
> When I go to mingwGitDevEnv home page, I read about chickens, eggs, and
> upgrading Perl (which msysGit simply gives up, hinting that it is almost
> impossible).  So I decided to wait for their Git 2.0.0 release before I
> try to install it (again).

I understand. And now that upstream Git 2.0.0 is out, it will be very hard
to use that as a deadline to push against. So: don't hold your breath.

> PPS: from marketing point of view, mingwGitDevEnv is far from usable
> name.  Dscho, if you support the idea, would you mind franchising
> msysGit 2.0 for a decent amount?

Make me an offer :-P

Seriously again, I am in favor of calling it the Git for Windows SDK. But
really, it is bikeshedding at this point. There is real work to do, still,
before we can switch. Lots of unaddressed questions. Too little time.
Speaking of which... budget's depleted for today ;-)

Ciao,
Dscho
