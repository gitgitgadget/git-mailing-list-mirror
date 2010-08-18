From: Enrico Weigelt <weigelt@metux.de>
Subject: checkout w/ removing untracked files
Date: Wed, 18 Aug 2010 21:31:54 +0200
Message-ID: <20100818193154.GA13204@nibiru.local>
Reply-To: weigelt@metux.de
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 18 21:46:22 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Oloab-00013k-Jt
	for gcvg-git-2@lo.gmane.org; Wed, 18 Aug 2010 21:46:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752272Ab0HRTqQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Aug 2010 15:46:16 -0400
Received: from caprica.metux.de ([82.165.128.25]:45336 "EHLO
	mailgate.caprica.metux.de" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751067Ab0HRTqO (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 18 Aug 2010 15:46:14 -0400
Received: from mailgate.caprica.metux.de (localhost.localdomain [127.0.0.1])
	by mailgate.caprica.metux.de (8.14.4/8.14.4) with ESMTP id o7IJk1XA003928
	for <git@vger.kernel.org>; Wed, 18 Aug 2010 21:46:01 +0200
Received: (from uucp@localhost)
	by mailgate.caprica.metux.de (8.14.4/8.14.4/Submit) with UUCP id o7IJjSKh003900
	for git@vger.kernel.org; Wed, 18 Aug 2010 21:45:28 +0200
Received: (from weigelt@localhost)
	by nibiru.metux.de (8.12.10/8.12.10) id o7IJVtUb020819
	for git@vger.kernel.org; Wed, 18 Aug 2010 21:31:55 +0200
Mail-Followup-To: git@vger.kernel.org
Content-Disposition: inline
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153880>


Hi folks,

is there an option to do a checkout _exactly_ as the ref'ed tree ?
(so, also remove untracked files) ?

For my Briegel buildsystem (git://pubgit.metux.de/projects/briegel.git/)
I need to checkout a really tree (iow: no untracked files may be
left in the workdir) from git. ATM I'm removing and recreating the
whole directory first, but I hope to get rid of this step.


cu
-- 
----------------------------------------------------------------------
 Enrico Weigelt, metux IT service -- http://www.metux.de/

 phone:  +49 36207 519931  email: weigelt@metux.de
 mobile: +49 151 27565287  icq:   210169427         skype: nekrad666
----------------------------------------------------------------------
 Embedded-Linux / Portierung / Opensource-QM / Verteilte Systeme
----------------------------------------------------------------------
