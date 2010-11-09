From: Enrico Weigelt <weigelt@metux.de>
Subject: Re: import determinism
Date: Tue, 9 Nov 2010 14:43:37 +0100
Message-ID: <20101109134337.GA19430@nibiru.local>
References: <20101107202535.GA18766@nibiru.local> <AANLkTi=mx0AAKo2Asn5XJVcs30-PLuwhTbM=o0y36Wa_@mail.gmail.com> <m2lj54u9uj.fsf@igel.home> <AANLkTikXxM=CfU2dKAY9khi1_tAsGDdUEc8S5AxooGH9@mail.gmail.com> <m2d3qgu50c.fsf@igel.home>
Reply-To: weigelt@metux.de
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Nov 09 14:57:12 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PFohE-00063p-5F
	for gcvg-git-2@lo.gmane.org; Tue, 09 Nov 2010 14:57:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752027Ab0KIN5H (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Nov 2010 08:57:07 -0500
Received: from caprica.metux.de ([82.165.128.25]:40390 "EHLO
	mailgate.caprica.metux.de" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751265Ab0KIN5E (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 9 Nov 2010 08:57:04 -0500
Received: from mailgate.caprica.metux.de (localhost.localdomain [127.0.0.1])
	by mailgate.caprica.metux.de (8.14.4/8.14.4) with ESMTP id oA9Dx1UT015963
	for <git@vger.kernel.org>; Tue, 9 Nov 2010 14:59:02 +0100
Received: (from uucp@localhost)
	by mailgate.caprica.metux.de (8.14.4/8.14.4/Submit) with UUCP id oA9DwWvj015691
	for git@vger.kernel.org; Tue, 9 Nov 2010 14:58:32 +0100
Received: (from weigelt@localhost)
	by nibiru.metux.de (8.12.10/8.12.10) id oA9DhbnV024694
	for git@vger.kernel.org; Tue, 9 Nov 2010 14:43:37 +0100
Mail-Followup-To: git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <m2d3qgu50c.fsf@igel.home>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161047>

* Andreas Schwab <schwab@linux-m68k.org> wrote:

> > For cvsimport, it is not deterministic. Given cvs'
> > ambiguous/buggy/inconsistent internal semantics around some
> > operations, cvsps makes educated guesses about what happened.
> >
> > Later commits can affect those educated guesses.
> 
> The OP was assuming an unchanging repository.

My assumption is:

* the original cvs repo will have later additions
  (so I'm incrementally importing)
* no commints (besides cvsimport) in the git mirror, but others
  for off from there
* the mirror could get lost in an desaster (no separate backup)
  and should be recreated afresh in that case.


The point behind this is: I'm running a growing number of cvs2git
mirrors and dont want to do full backups of them.


cu
-- 
----------------------------------------------------------------------
 Enrico Weigelt, metux IT service -- http://www.metux.de/

 phone:  +49 36207 519931  email: weigelt@metux.de
 mobile: +49 151 27565287  icq:   210169427         skype: nekrad666
----------------------------------------------------------------------
 Embedded-Linux / Portierung / Opensource-QM / Verteilte Systeme
----------------------------------------------------------------------
