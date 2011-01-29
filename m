From: Enrico Weigelt <weigelt@metux.de>
Subject: Re: Why git tags are there in git?
Date: Sat, 29 Jan 2011 18:17:51 +0100
Message-ID: <20110129171750.GA602@nibiru.local>
References: <1296214676536-5969544.post@n2.nabble.com>
Reply-To: weigelt@metux.de
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jan 29 18:28:34 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PjEbC-0001ij-2H
	for gcvg-git-2@lo.gmane.org; Sat, 29 Jan 2011 18:28:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754205Ab1A2RZi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 29 Jan 2011 12:25:38 -0500
Received: from caprica.metux.de ([82.165.128.25]:47931 "EHLO
	mailgate.caprica.metux.de" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1753663Ab1A2RZh (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 29 Jan 2011 12:25:37 -0500
Received: from mailgate.caprica.metux.de (localhost.localdomain [127.0.0.1])
	by mailgate.caprica.metux.de (8.14.4/8.14.4) with ESMTP id p0THM15q009642
	for <git@vger.kernel.org>; Sat, 29 Jan 2011 18:22:03 +0100
Received: (from uucp@localhost)
	by mailgate.caprica.metux.de (8.14.4/8.14.4/Submit) with UUCP id p0THLigS009632
	for git@vger.kernel.org; Sat, 29 Jan 2011 18:21:44 +0100
Received: (from weigelt@localhost)
	by nibiru.metux.de (8.12.10/8.12.10) id p0THHpDF029192
	for git@vger.kernel.org; Sat, 29 Jan 2011 18:17:51 +0100
Mail-Followup-To: git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <1296214676536-5969544.post@n2.nabble.com>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165662>

* vikram2rhyme <vikram2rhyme@gmail.com> wrote:

Hi,

> I am wondering why the tags are there in git. As they are just
> pointer to the commit we can refer those commit by SHA sum only
> then why tagging? Moreover a commit can be tagged more than once
> that result in multiple tags pointing to the same point in the history.
> Is this a design flaw?

No, it's an important design aspect.

Tag references (not to be mixed up w/ tag objects) are very useful
to add a conveniently named pointer to some object (not necessarily
a commit), so humans as well as programs can easily find them.

For example, in my OSS-QM repositories [1], I have some robots
importing releases (sometimes from upstream's git repos, sometimes
from foreign VCSs, tarballs or even distro packages) and tag
them into a normalized namespace, so automatic systems (eg. my
Briegel buildsystem) can easily fetch sourcetrees from there
w/o further manual tweaking.


cu

[1] http://www.metux.de/download/oss-qm/normalized_repository.pdf
-- 
----------------------------------------------------------------------
 Enrico Weigelt, metux IT service -- http://www.metux.de/

 phone:  +49 36207 519931  email: weigelt@metux.de
 mobile: +49 151 27565287  icq:   210169427         skype: nekrad666
----------------------------------------------------------------------
 Embedded-Linux / Portierung / Opensource-QM / Verteilte Systeme
----------------------------------------------------------------------
