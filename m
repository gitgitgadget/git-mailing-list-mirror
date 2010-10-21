From: Enrico Weigelt <weigelt@metux.de>
Subject: Re: GIT as binary repository
Date: Thu, 21 Oct 2010 21:19:25 +0200
Message-ID: <20101021191925.GE28700@nibiru.local>
References: <2EBB46ACFCD6CF48B45E2B1865BD02338037D36B4E@GVW1098EXB.americas.hpqcorp.net>
Reply-To: weigelt@metux.de
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: "git@vger.kernel.org" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Oct 21 21:28:41 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P90oW-0000od-2w
	for gcvg-git-2@lo.gmane.org; Thu, 21 Oct 2010 21:28:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752223Ab0JUT2a (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 Oct 2010 15:28:30 -0400
Received: from caprica.metux.de ([82.165.128.25]:52881 "EHLO
	mailgate.caprica.metux.de" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1750916Ab0JUT2a (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 21 Oct 2010 15:28:30 -0400
Received: from mailgate.caprica.metux.de (localhost.localdomain [127.0.0.1])
	by mailgate.caprica.metux.de (8.14.4/8.14.4) with ESMTP id o9LJTuqh018158
	for <git@vger.kernel.org>; Thu, 21 Oct 2010 21:29:58 +0200
Received: (from uucp@localhost)
	by mailgate.caprica.metux.de (8.14.4/8.14.4/Submit) with UUCP id o9LJTSPI018094
	for git@vger.kernel.org; Thu, 21 Oct 2010 21:29:28 +0200
Received: (from weigelt@localhost)
	by nibiru.metux.de (8.12.10/8.12.10) id o9LJJPV6000799
	for git@vger.kernel.org; Thu, 21 Oct 2010 21:19:25 +0200
Mail-Followup-To: "git@vger.kernel.org" <git@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <2EBB46ACFCD6CF48B45E2B1865BD02338037D36B4E@GVW1098EXB.americas.hpqcorp.net>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159546>

* Wilson, Kevin Lee (OpenView Engineer) <kevin.l.wilson@hp.com> wrote:

Hi,

> We are investigating the use of GIT as a binary repository solution.
> Our larger files are near 800MB and the total checked out repo size
> is about 3 GB the repo size in SVN is more like 20-30GB, if we could
> prune the history prior to MR, we could get these sizes down
> considerably. This binary repo is really for our super project build. 

What exactly do you need such large binary objects in an git repo ?

IMHO, Git isn't made for large files. I've noticed this when doing
git-based mail archives on an old P3 box w/ 256MB physical memory.
I had to split mbox'es to maildirs.

Perhaps you would like to have a look at some pure object store like
venti ? (It's not distributed yet, but I'm currently working on an
distributed successor, called Nebulon, which will also support
strong encryption, on-demand replication, etc).

> I also have some questions, about how the workflow would be for
> getting all of the changes merged from several different teams
> into the one repository would operate. 

IMHO, there should be some dedicated release manager role, which
is responsible for merging finished branches into the mainline
(eg. similar that Linus does for the official Linux tree).

BUT: you perhaps should think carefully, whether you need everything
in one big repo. Perhaps a bunch of smaller ones (eg. having separate
modules in the own repos/trees) would fit better.


cu
-- 
----------------------------------------------------------------------
 Enrico Weigelt, metux IT service -- http://www.metux.de/

 phone:  +49 36207 519931  email: weigelt@metux.de
 mobile: +49 151 27565287  icq:   210169427         skype: nekrad666
----------------------------------------------------------------------
 Embedded-Linux / Portierung / Opensource-QM / Verteilte Systeme
----------------------------------------------------------------------
