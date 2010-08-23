From: Enrico Weigelt <weigelt@metux.de>
Subject: Re: git-svn mirror in bare repo
Date: Mon, 23 Aug 2010 15:13:48 +0200
Message-ID: <20100823131348.GC12810@nibiru.local>
References: <20100823122425.GB12810@nibiru.local> <4C72708B.202@drmicha.warpmail.net>
Reply-To: weigelt@metux.de
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Aug 23 15:24:15 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OnX0Y-0006t1-SL
	for gcvg-git-2@lo.gmane.org; Mon, 23 Aug 2010 15:24:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752919Ab0HWNYJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Aug 2010 09:24:09 -0400
Received: from caprica.metux.de ([82.165.128.25]:59220 "EHLO
	mailgate.caprica.metux.de" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751861Ab0HWNYI (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 23 Aug 2010 09:24:08 -0400
Received: from mailgate.caprica.metux.de (localhost.localdomain [127.0.0.1])
	by mailgate.caprica.metux.de (8.14.4/8.14.4) with ESMTP id o7NDO1AT027931
	for <git@vger.kernel.org>; Mon, 23 Aug 2010 15:24:02 +0200
Received: (from uucp@localhost)
	by mailgate.caprica.metux.de (8.14.4/8.14.4/Submit) with UUCP id o7NDNs0K027909
	for git@vger.kernel.org; Mon, 23 Aug 2010 15:23:54 +0200
Received: (from weigelt@localhost)
	by nibiru.metux.de (8.12.10/8.12.10) id o7NDDm5b027629
	for git@vger.kernel.org; Mon, 23 Aug 2010 15:13:48 +0200
Mail-Followup-To: git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <4C72708B.202@drmicha.warpmail.net>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154225>

* Michael J Gruber <git@drmicha.warpmail.net> wrote:
> Enrico Weigelt venit, vidit, dixit 23.08.2010 14:24:
> > 
> > Hi folks,
> > 
> > is it possible to use git-svn w/ an bare repository (eg. using
> > an temporary workdir when necessary or directly creating tree
> > and commit objects w/o going through workdir at all) ?
> 
> No.

hmm, can it work with an external workdir ?

> > I'm running a dozen of mirrors (also from cvs), some from fairly
> > large and I'd like to get rid of the working copies.
> 
> Your only option is a different conversion tool. GSoC resulted in a lot
> of code in this direction, but I'm not sure it can do without a workdir.
> It is based on svndump

I guess that requires access to the raw repository (on the server),
not just unprivileged svn client access, right ?


cu
-- 
----------------------------------------------------------------------
 Enrico Weigelt, metux IT service -- http://www.metux.de/

 phone:  +49 36207 519931  email: weigelt@metux.de
 mobile: +49 151 27565287  icq:   210169427         skype: nekrad666
----------------------------------------------------------------------
 Embedded-Linux / Portierung / Opensource-QM / Verteilte Systeme
----------------------------------------------------------------------
