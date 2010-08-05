From: Enrico Weigelt <weigelt@metux.de>
Subject: Re: Massive repository corruptions
Date: Thu, 5 Aug 2010 19:31:56 +0200
Message-ID: <20100805173156.GB2630@nibiru.local>
References: <20100713015600.GA29392@nibiru.local> <AANLkTilXQ3VgPjihf0pjt4QPN-nCjwAWyHwoosLMeRpH@mail.gmail.com> <20100713050350.GB29392@nibiru.local> <AANLkTimQPv5MhLo4wwVTt2LiaWxqWwoYykEbz3wBS-OY@mail.gmail.com> <20100713102245.GE29392@nibiru.local> <AANLkTimYeKr0asVE9mo8VcQEp5kdC18Wk5ykY9OFwixN@mail.gmail.com> <20100714132224.GF29392@nibiru.local>
Reply-To: weigelt@metux.de
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 05 19:41:46 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Oh4Rq-0002uM-FQ
	for gcvg-git-2@lo.gmane.org; Thu, 05 Aug 2010 19:41:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757978Ab0HERli (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Aug 2010 13:41:38 -0400
Received: from caprica.metux.de ([82.165.128.25]:44909 "EHLO
	mailgate.caprica.metux.de" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1756150Ab0HERlg (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 5 Aug 2010 13:41:36 -0400
Received: from mailgate.caprica.metux.de (localhost.localdomain [127.0.0.1])
	by mailgate.caprica.metux.de (8.14.4/8.14.4) with ESMTP id o75Hf1cn011389
	for <git@vger.kernel.org>; Thu, 5 Aug 2010 19:41:02 +0200
Received: (from uucp@localhost)
	by mailgate.caprica.metux.de (8.14.4/8.14.4/Submit) with UUCP id o75HeArH011370
	for git@vger.kernel.org; Thu, 5 Aug 2010 19:40:10 +0200
Received: (from weigelt@localhost)
	by nibiru.metux.de (8.12.10/8.12.10) id o75HVuIx025229
	for git@vger.kernel.org; Thu, 5 Aug 2010 19:31:56 +0200
Content-Disposition: inline
In-Reply-To: <20100714132224.GF29392@nibiru.local>
User-Agent: Mutt/1.4.1i
X-Terror: bin laden, kill bush, Briefbombe, Massenvernichtung, KZ, 
X-Nazi: Weisse Rasse, Hitlers Wiederauferstehung, 42, 
X-Antichrist: weg mit schaeuble, ausrotten, heiliger krieg, al quaida, 
X-Killer: 23, endloesung, Weltuntergang, 
X-Doof: wer das liest ist doof
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152696>

* Enrico Weigelt <weigelt@metux.de> wrote:

> hmm, I have no signs of any hw corruption, but I had a patched
> version of zlib installed. Maybe some of my patches broke it, 
> so some strange overflow or sth like that caused that trouble.
> 
> Meanwhile, after reinstalling (unpatched) zlib and recloning the
> broken repos, everything seems fine again. Maybe some of you would
> like to have a look at my zlib patches ;-o

This only seemed to help for a while. Again have trouble w/ broken 
repos. But the strange thing: seems to affect only large ones. For 
example, could got clone and repeatedly gc --aggressive the git
source w/ trouble.

If it *is* any hw problem (which isnt that unplausible since that
machine is the only one making trouble now), how can I detect it ?
Shouldnt broken memory or disk raise some kernel log message ?


cu
-- 
----------------------------------------------------------------------
 Enrico Weigelt, metux IT service -- http://www.metux.de/

 phone:  +49 36207 519931  email: weigelt@metux.de
 mobile: +49 151 27565287  icq:   210169427         skype: nekrad666
----------------------------------------------------------------------
 Embedded-Linux / Portierung / Opensource-QM / Verteilte Systeme
----------------------------------------------------------------------
