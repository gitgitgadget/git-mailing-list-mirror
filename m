From: Enrico Weigelt <weigelt@metux.de>
Subject: Re: Project- vs. Package-Level Branching in Git
Date: Sat, 29 Jan 2011 20:33:23 +0100
Message-ID: <20110129193323.GD602@nibiru.local>
References: <14F4737F-E8E4-4E4E-A625-16CA63CF9EFF@shaggyfrog.com> <AANLkTinTRgzv0s9MTyM4TaOwVOmhwRckDqMfxrbsKVfm@mail.gmail.com> <15B7CA2E-C584-4563-B9E3-D80861CD9565@shaggyfrog.com>
Reply-To: weigelt@metux.de
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jan 29 20:44:02 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PjGiG-0000O3-Mu
	for gcvg-git-2@lo.gmane.org; Sat, 29 Jan 2011 20:44:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754736Ab1A2Tnp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 29 Jan 2011 14:43:45 -0500
Received: from caprica.metux.de ([82.165.128.25]:48405 "EHLO
	mailgate.caprica.metux.de" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1752634Ab1A2Tno (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 29 Jan 2011 14:43:44 -0500
Received: from mailgate.caprica.metux.de (localhost.localdomain [127.0.0.1])
	by mailgate.caprica.metux.de (8.14.4/8.14.4) with ESMTP id p0TJe1Bb002593
	for <git@vger.kernel.org>; Sat, 29 Jan 2011 20:40:10 +0100
Received: (from uucp@localhost)
	by mailgate.caprica.metux.de (8.14.4/8.14.4/Submit) with UUCP id p0TJdVd5002457
	for git@vger.kernel.org; Sat, 29 Jan 2011 20:39:31 +0100
Received: (from weigelt@localhost)
	by nibiru.metux.de (8.12.10/8.12.10) id p0TJXNVp022568
	for git@vger.kernel.org; Sat, 29 Jan 2011 20:33:23 +0100
Mail-Followup-To: git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <15B7CA2E-C584-4563-B9E3-D80861CD9565@shaggyfrog.com>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165668>

* Thomas Hauk <tom@shaggyfrog.com> wrote:

> Imagine a project that uses liba and libb, which both reference libc.
> To use Git, I'd have to have copies of libc existing in three
> repositories, and copies of liba and lib in two repositories each. 

No, just leave them as they are: separate packages. Period.
Let a dist buildsystem handle the project's build process,
including dependency resolving, packaging, etc.

> Git just doesn't seem to scale when it comes to componentized
> projects. 

These "componentized" projects (as you call it - I'd rather call
it the exact opposite) suffer from an ideology that doens't know
to differenciate between the fundamental stages of an software
building up to deployment, they try do to everything in one fat
blob - that's why fail or burn expensive resources frequently.
(I've seen that often enough in my last 15 years of software
engineering ...)


cu
-- 
----------------------------------------------------------------------
 Enrico Weigelt, metux IT service -- http://www.metux.de/

 phone:  +49 36207 519931  email: weigelt@metux.de
 mobile: +49 151 27565287  icq:   210169427         skype: nekrad666
----------------------------------------------------------------------
 Embedded-Linux / Portierung / Opensource-QM / Verteilte Systeme
----------------------------------------------------------------------
