From: Enrico Weigelt <weigelt@metux.de>
Subject: Re: Massive repository corruptions
Date: Wed, 14 Jul 2010 15:22:24 +0200
Message-ID: <20100714132224.GF29392@nibiru.local>
References: <20100713015600.GA29392@nibiru.local> <AANLkTilXQ3VgPjihf0pjt4QPN-nCjwAWyHwoosLMeRpH@mail.gmail.com> <20100713050350.GB29392@nibiru.local> <AANLkTimQPv5MhLo4wwVTt2LiaWxqWwoYykEbz3wBS-OY@mail.gmail.com> <20100713102245.GE29392@nibiru.local> <AANLkTimYeKr0asVE9mo8VcQEp5kdC18Wk5ykY9OFwixN@mail.gmail.com>
Reply-To: weigelt@metux.de
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jul 14 15:29:06 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OZ21K-0000Fr-Ec
	for gcvg-git-2@lo.gmane.org; Wed, 14 Jul 2010 15:29:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756999Ab0GNN3B (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Jul 2010 09:29:01 -0400
Received: from forum.psychotherapie.org ([217.160.22.205]:52896 "EHLO
	s15216962.onlinehome-server.info" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756980Ab0GNN27 (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 14 Jul 2010 09:28:59 -0400
Received: (from uucp@localhost)
	by s15216962.onlinehome-server.info (8.13.3/8.13.3) with UUCP id o6EDSv3Z005159
	for git@vger.kernel.org; Wed, 14 Jul 2010 15:28:57 +0200
Received: (from weigelt@localhost)
	by nibiru.metux.de (8.12.10/8.12.10) id o6EDMPGf004969
	for git@vger.kernel.org; Wed, 14 Jul 2010 15:22:25 +0200
Content-Disposition: inline
In-Reply-To: <AANLkTimYeKr0asVE9mo8VcQEp5kdC18Wk5ykY9OFwixN@mail.gmail.com>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150988>

* Avery Pennarun <apenwarr@gmail.com> wrote:

> If you got corruption at offset 37,075,832 (about 37 megs) and the
> pack is over 300 megs, then the file itself is corrupted right in the
> middle (not truncated) and this couldn't have been caused by disk full
> errors.  Either you have memory corruption problems, or disk
> corruption problems, or filesystem corruption problems.  You'd better
> watch out.

hmm, I have no signs of any hw corruption, but I had a patched
version of zlib installed. Maybe some of my patches broke it, 
so some strange overflow or sth like that caused that trouble.

Meanwhile, after reinstalling (unpatched) zlib and recloning the
broken repos, everything seems fine again. Maybe some of you would
like to have a look at my zlib patches ;-o


cu
-- 
----------------------------------------------------------------------
 Enrico Weigelt, metux IT service -- http://www.metux.de/

 phone:  +49 36207 519931  email: weigelt@metux.de
 mobile: +49 151 27565287  icq:   210169427         skype: nekrad666
----------------------------------------------------------------------
 Embedded-Linux / Portierung / Opensource-QM / Verteilte Systeme
----------------------------------------------------------------------
