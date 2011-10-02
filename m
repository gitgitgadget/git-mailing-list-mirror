From: Enrico Weigelt <weigelt@metux.de>
Subject: Re: Restoring timestamps (Re: Branches & directories)
Date: Sun, 2 Oct 2011 17:06:01 +0200
Message-ID: <20111002150601.GB15083@nibiru.local>
References: <CAGZ=bqK7H3zc8LK7EP8+uV8DpWW+czK2POfceGtcBF8Vmkhkow@mail.gmail.com> <CAE1pOi1J5DKtnyUQzu1K7G1+HLsWWCN7thCf6W8MwSzt4_vtOw@mail.gmail.com> <CAGZ=bqLZoLoyMcvnppg6SyFtJU8phSquQeBZ7uhwP=+ZL3DADw@mail.gmail.com> <CAE1pOi0Er1ZgftpNeCr85Zu27xR2127V_KdAtvKc1NOKmDUvzQ@mail.gmail.com> <CAGZ=bqLyS9tcpqztwGWFOXtDJRhugu+JYvz7wTnc0PTmECWX2g@mail.gmail.com> <CAE1pOi1axNmGaPVXqBH02x0N=Z6tgO9R00RTokuJm50eY-OoNg@mail.gmail.com> <20110822210141.GA3880@elie.gateway.2wire.net> <CAE1pOi1+nnpnHAuhYsXcfFNUroW0JcDQKLu6D7YNrUwJg0tXPw@mail.gmail.com> <CAFzf2Xw6=BFsKauYTG-4cw0D_LzLSNb_wqz8dQJ83wJHNQXbdg@mail.gmail.com> <CAE1pOi1J=TWUmJKZorotBsDoz3wozXsioN7fVO=7JBxdMD7Zqg@mail.gmail.com>
Reply-To: weigelt@metux.de
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Oct 02 17:09:02 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RANf3-00086s-Ur
	for gcvg-git-2@lo.gmane.org; Sun, 02 Oct 2011 17:09:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752798Ab1JBPIv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 2 Oct 2011 11:08:51 -0400
Received: from caprica.metux.de ([82.165.128.25]:53982 "EHLO
	mailgate.caprica.metux.de" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1752725Ab1JBPIu (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 2 Oct 2011 11:08:50 -0400
Received: from mailgate.caprica.metux.de (localhost.localdomain [127.0.0.1])
	by mailgate.caprica.metux.de (8.14.4/8.14.4) with ESMTP id p92F1wUC008338
	for <git@vger.kernel.org>; Sun, 2 Oct 2011 17:01:58 +0200
Received: (from uucp@localhost)
	by mailgate.caprica.metux.de (8.14.4/8.14.4/Submit) with UUCP id p92F1ksG008334
	for git@vger.kernel.org; Sun, 2 Oct 2011 17:01:46 +0200
Received: (from weigelt@localhost)
	by nibiru.metux.de (8.12.10/8.12.10) id p92F61n8004336
	for git@vger.kernel.org; Sun, 2 Oct 2011 17:06:01 +0200
Mail-Followup-To: Git Mailing List <git@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAE1pOi1J=TWUmJKZorotBsDoz3wozXsioN7fVO=7JBxdMD7Zqg@mail.gmail.com>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182602>

* Hilco Wijbenga <hilco.wijbenga@gmail.com> wrote:

> Eclipse is a wonderful IDE except for how it makes sharing workspaces
> practically impossible (where "share" means "put in SCM", not "used my
> several developers at the same time"). 

This is one the major points which render it rather useless for me ;-o

> Is it possible to do git stash pop without losing the stash? 

git cherry-pick stash{0}


Apropos IDEs:

I've been thinking about how to properly integrate IDEs with VCS'es
like git. My conclusion is that it should be directly built ontop
of it. Project metadata itself belongs into git, and the project
management tool should automatically create local working copies
on-demand. I would even delegate *all* the VCS handling to git
(even when using other VCS'es in the back)

Maybe I'll find some time to do some initial concepts.
Perhaps anybody likes to join in ?


cu
-- 
----------------------------------------------------------------------
 Enrico Weigelt, metux IT service -- http://www.metux.de/

 phone:  +49 36207 519931  email: weigelt@metux.de
 mobile: +49 151 27565287  icq:   210169427         skype: nekrad666
----------------------------------------------------------------------
 Embedded-Linux / Portierung / Opensource-QM / Verteilte Systeme
----------------------------------------------------------------------
