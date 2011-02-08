From: Enrico Weigelt <weigelt@metux.de>
Subject: Re: [1.8.0] Provide proper remote ref namespaces
Date: Tue, 8 Feb 2011 20:11:48 +0100
Message-ID: <20110208191147.GA8675@nibiru.local>
References: <AANLkTi=yFwOAQMHhvLsB1_xmYOE9HHP2YB4H4TQzwwc8@mail.gmail.com> <201102070429.05033.johan@herland.net> <20110208010648.GA3132@dpotapov.dyndns.org> <201102080915.27484.johan@herland.net>
Reply-To: weigelt@metux.de
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 08 20:21:13 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pmt7g-0002GH-LB
	for gcvg-git-2@lo.gmane.org; Tue, 08 Feb 2011 20:21:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754047Ab1BHTVF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Feb 2011 14:21:05 -0500
Received: from caprica.metux.de ([82.165.128.25]:36992 "EHLO
	mailgate.caprica.metux.de" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1750923Ab1BHTVE (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 8 Feb 2011 14:21:04 -0500
Received: from mailgate.caprica.metux.de (localhost.localdomain [127.0.0.1])
	by mailgate.caprica.metux.de (8.14.4/8.14.4) with ESMTP id p18JHeHm001253
	for <git@vger.kernel.org>; Tue, 8 Feb 2011 20:17:44 +0100
Received: (from uucp@localhost)
	by mailgate.caprica.metux.de (8.14.4/8.14.4/Submit) with UUCP id p18JHVMt001249
	for git@vger.kernel.org; Tue, 8 Feb 2011 20:17:31 +0100
Received: (from weigelt@localhost)
	by nibiru.metux.de (8.12.10/8.12.10) id p18JBmVX021447
	for git@vger.kernel.org; Tue, 8 Feb 2011 20:11:48 +0100
Mail-Followup-To: git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <201102080915.27484.johan@herland.net>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166365>

* Johan Herland <johan@herland.net> wrote:

> Ah, yes, I should have been more specific:
> 
>     remote.origin.fetch = ~refs/tags/*:refs/tags/*
> 
> In my proposal, I suggest using a "~" prefix to signal auto-following 
> behavior. This is needed in order to be able to explicitly specify the 
> current fetch behavior in the configuration.

Under the hood, this line could be automatically "added" (internally)
unless some "fetch.autotag = false" is given.


cu
-- 
----------------------------------------------------------------------
 Enrico Weigelt, metux IT service -- http://www.metux.de/

 phone:  +49 36207 519931  email: weigelt@metux.de
 mobile: +49 151 27565287  icq:   210169427         skype: nekrad666
----------------------------------------------------------------------
 Embedded-Linux / Portierung / Opensource-QM / Verteilte Systeme
----------------------------------------------------------------------
