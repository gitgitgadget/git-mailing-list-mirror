From: Enrico Weigelt <weigelt@metux.de>
Subject: Re: Massive repository corruptions
Date: Thu, 5 Aug 2010 22:42:07 +0200
Message-ID: <20100805204206.GD2630@nibiru.local>
References: <AANLkTilXQ3VgPjihf0pjt4QPN-nCjwAWyHwoosLMeRpH@mail.gmail.com> <20100713050350.GB29392@nibiru.local> <AANLkTimQPv5MhLo4wwVTt2LiaWxqWwoYykEbz3wBS-OY@mail.gmail.com> <20100713102245.GE29392@nibiru.local> <AANLkTimYeKr0asVE9mo8VcQEp5kdC18Wk5ykY9OFwixN@mail.gmail.com> <20100714132224.GF29392@nibiru.local> <20100805173156.GB2630@nibiru.local> <AANLkTikFypx3e-=+8J2925A++_jY-aJCDYHHw6dry5s6@mail.gmail.com> <20100805201026.GC2630@nibiru.local> <AANLkTi=5HVQ2kSEt7O+OXdMRtvy8amufpFKgRpj2VLEy@mail.gmail.com>
Reply-To: weigelt@metux.de
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 05 22:49:51 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Oh7Ns-0007em-HS
	for gcvg-git-2@lo.gmane.org; Thu, 05 Aug 2010 22:49:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933030Ab0HEUtj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Aug 2010 16:49:39 -0400
Received: from caprica.metux.de ([82.165.128.25]:52562 "EHLO
	mailgate.caprica.metux.de" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S932849Ab0HEUth (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 5 Aug 2010 16:49:37 -0400
Received: from mailgate.caprica.metux.de (localhost.localdomain [127.0.0.1])
	by mailgate.caprica.metux.de (8.14.4/8.14.4) with ESMTP id o75Kn1DO015812
	for <git@vger.kernel.org>; Thu, 5 Aug 2010 22:49:02 +0200
Received: (from uucp@localhost)
	by mailgate.caprica.metux.de (8.14.4/8.14.4/Submit) with UUCP id o75KmjIN015804
	for git@vger.kernel.org; Thu, 5 Aug 2010 22:48:45 +0200
Received: (from weigelt@localhost)
	by nibiru.metux.de (8.12.10/8.12.10) id o75Kg7OU003063
	for git@vger.kernel.org; Thu, 5 Aug 2010 22:42:07 +0200
Content-Disposition: inline
In-Reply-To: <AANLkTi=5HVQ2kSEt7O+OXdMRtvy8amufpFKgRpj2VLEy@mail.gmail.com>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152713>

* Jussi Sirpoma <jussi.sirpoma@sks.fi> wrote:

> Sorry not really. Maybe compiling kernel with lots of jobs would reveal some
> problems?

okay, I'll have a try :)

BTW: I'm currently recreating one of the broken repos (mozilla,
which might be large enough for stresstest ;-)) by adding and
fetching the remotes step by step. Reposity size now about 250M
(reduced the packsize to 32M, since this already helped on some
other repos) - yet no breaks occoured.

Let's see where it goes ...


cu
-- 
----------------------------------------------------------------------
 Enrico Weigelt, metux IT service -- http://www.metux.de/

 phone:  +49 36207 519931  email: weigelt@metux.de
 mobile: +49 151 27565287  icq:   210169427         skype: nekrad666
----------------------------------------------------------------------
 Embedded-Linux / Portierung / Opensource-QM / Verteilte Systeme
----------------------------------------------------------------------
