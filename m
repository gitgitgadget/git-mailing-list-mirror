From: Enrico Weigelt <weigelt@metux.de>
Subject: BUG! missing .idx causes .pack to be removed
Date: Thu, 5 Aug 2010 19:01:37 +0200
Message-ID: <20100805170137.GA2630@nibiru.local>
Reply-To: weigelt@metux.de
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 05 19:15:45 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Oh42h-0004M8-B7
	for gcvg-git-2@lo.gmane.org; Thu, 05 Aug 2010 19:15:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758956Ab0HERPh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Aug 2010 13:15:37 -0400
Received: from caprica.metux.de ([82.165.128.25]:59437 "EHLO
	mailgate.caprica.metux.de" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1755984Ab0HERPg (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 5 Aug 2010 13:15:36 -0400
X-Greylist: delayed 359 seconds by postgrey-1.27 at vger.kernel.org; Thu, 05 Aug 2010 13:15:35 EDT
Received: from mailgate.caprica.metux.de (localhost.localdomain [127.0.0.1])
	by mailgate.caprica.metux.de (8.14.4/8.14.4) with ESMTP id o75H91Xu010615
	for <git@vger.kernel.org>; Thu, 5 Aug 2010 19:09:01 +0200
Received: (from uucp@localhost)
	by mailgate.caprica.metux.de (8.14.4/8.14.4/Submit) with UUCP id o75H8i4Z010606
	for git@vger.kernel.org; Thu, 5 Aug 2010 19:08:44 +0200
Received: (from weigelt@localhost)
	by nibiru.metux.de (8.12.10/8.12.10) id o75H1bhb008453
	for git@vger.kernel.org; Thu, 5 Aug 2010 19:01:37 +0200
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152694>

Hi folks,


while doing some experiments I've removed the *.idx files and 
ran git-repack - that complained about missing objects and removed
all *.pack files !

I'm sure that's a bug - an ugly one ;-o


cu
-- 
----------------------------------------------------------------------
 Enrico Weigelt, metux IT service -- http://www.metux.de/

 phone:  +49 36207 519931  email: weigelt@metux.de
 mobile: +49 151 27565287  icq:   210169427         skype: nekrad666
----------------------------------------------------------------------
 Embedded-Linux / Portierung / Opensource-QM / Verteilte Systeme
----------------------------------------------------------------------
