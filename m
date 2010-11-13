From: Enrico Weigelt <weigelt@metux.de>
Subject: Re: Using a different index and HEAD
Date: Sat, 13 Nov 2010 20:41:29 +0100
Message-ID: <20101113194128.GA8878@nibiru.local>
References: <20101113152906.GA24903@nibiru.local> <20101113160546.GA5535@burratino>
Reply-To: weigelt@metux.de
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Nov 13 20:56:05 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PHMCh-0003Xf-1w
	for gcvg-git-2@lo.gmane.org; Sat, 13 Nov 2010 20:56:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756192Ab0KMTz4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 13 Nov 2010 14:55:56 -0500
Received: from caprica.metux.de ([82.165.128.25]:39282 "EHLO
	mailgate.caprica.metux.de" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1755316Ab0KMTz4 (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 13 Nov 2010 14:55:56 -0500
Received: from mailgate.caprica.metux.de (localhost.localdomain [127.0.0.1])
	by mailgate.caprica.metux.de (8.14.4/8.14.4) with ESMTP id oADJvsJI006641;
	Sat, 13 Nov 2010 20:57:54 +0100
Received: (from uucp@localhost)
	by mailgate.caprica.metux.de (8.14.4/8.14.4/Submit) with UUCP id oADJvhLh006606;
	Sat, 13 Nov 2010 20:57:43 +0100
Received: (from weigelt@localhost)
	by nibiru.metux.de (8.12.10/8.12.10) id oADJfTh4019216;
	Sat, 13 Nov 2010 20:41:29 +0100
Mail-Followup-To: Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <20101113160546.GA5535@burratino>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161395>

* Jonathan Nieder <jrnieder@gmail.com> schrieb:

Hi,

> > Is there already a way to tell other locations for index file
> > and current HEAD symref on command line (just like we have w/
> > --work-dir etc) ?
> 
> You might like the git-new-workdir script, available from
> contrib/workdir.

I didnt have time for a deeper look yet, but I'll try to explain
my ideas a bit more:

Suppose I choose to work on an branch "one" (which probably is
synced to some remote). That will create some temporary (local)
WIP branch, where each file change from the IDE (working in a
separate workdir or maybe completely w/o one) gets committed
immediately. Now I click some "commit" button and it asks me what
exactly to commit - I now can interactively selected changes to
be committed (maybe even on single changelets within a file),
they'll be squashed together (maybe involving some rebase magic)
and an commit final commit object is created on the "one" branch.
After this, the local WIP branch gets rebased to latest "one".


cu
-- 
----------------------------------------------------------------------
 Enrico Weigelt, metux IT service -- http://www.metux.de/

 phone:  +49 36207 519931  email: weigelt@metux.de
 mobile: +49 151 27565287  icq:   210169427         skype: nekrad666
----------------------------------------------------------------------
 Embedded-Linux / Portierung / Opensource-QM / Verteilte Systeme
----------------------------------------------------------------------
