From: Enrico Weigelt <weigelt@metux.de>
Subject: Re: checkout w/ removing untracked files
Date: Mon, 23 Aug 2010 14:12:30 +0200
Message-ID: <20100823121229.GA12810@nibiru.local>
References: <20100818193154.GA13204@nibiru.local> <7v39ubaedg.fsf@alter.siamese.dyndns.org>
Reply-To: weigelt@metux.de
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Aug 23 14:22:19 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OnW2a-00056f-Ig
	for gcvg-git-2@lo.gmane.org; Mon, 23 Aug 2010 14:22:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752734Ab0HWMWJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Aug 2010 08:22:09 -0400
Received: from caprica.metux.de ([82.165.128.25]:53156 "EHLO
	mailgate.caprica.metux.de" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751745Ab0HWMWI (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 23 Aug 2010 08:22:08 -0400
Received: from mailgate.caprica.metux.de (localhost.localdomain [127.0.0.1])
	by mailgate.caprica.metux.de (8.14.4/8.14.4) with ESMTP id o7NCM1Zk024370
	for <git@vger.kernel.org>; Mon, 23 Aug 2010 14:22:02 +0200
Received: (from uucp@localhost)
	by mailgate.caprica.metux.de (8.14.4/8.14.4/Submit) with UUCP id o7NCLOq2024331
	for git@vger.kernel.org; Mon, 23 Aug 2010 14:21:24 +0200
Received: (from weigelt@localhost)
	by nibiru.metux.de (8.12.10/8.12.10) id o7NCCUqu016492
	for git@vger.kernel.org; Mon, 23 Aug 2010 14:12:30 +0200
Mail-Followup-To: git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <7v39ubaedg.fsf@alter.siamese.dyndns.org>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154222>

* Junio C Hamano <gitster@pobox.com> wrote:
> Enrico Weigelt <weigelt@metux.de> writes:
> 
> > For my Briegel buildsystem (git://pubgit.metux.de/projects/briegel.git/)
> > I need to checkout a really tree (iow: no untracked files may be
> > left in the workdir) from git. ATM I'm removing and recreating the
> > whole directory first, but I hope to get rid of this step.
> 
> (1) If you have a correctly working "make reallyclean" to remove build
>     artifacts, you wouldn't even need such an option.

I can't rely on that. Some of the trees aren't even sourcetrees 
but sysroot images. I need a guaranteed fresh tree w/o any 
user intervention.


> (2) Have you tried to read up on "git clean -dfqx"?

Thanks, that should do it :)


cu
-- 
----------------------------------------------------------------------
 Enrico Weigelt, metux IT service -- http://www.metux.de/

 phone:  +49 36207 519931  email: weigelt@metux.de
 mobile: +49 151 27565287  icq:   210169427         skype: nekrad666
----------------------------------------------------------------------
 Embedded-Linux / Portierung / Opensource-QM / Verteilte Systeme
----------------------------------------------------------------------
