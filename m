From: Enrico Weigelt <weigelt@metux.de>
Subject: Find successor of common ancestor
Date: Fri, 16 Jul 2010 10:29:37 +0200
Message-ID: <20100716082937.GA22894@nibiru.local>
Reply-To: weigelt@metux.de
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jul 16 10:36:43 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OZgPS-0004N7-Nd
	for gcvg-git-2@lo.gmane.org; Fri, 16 Jul 2010 10:36:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935994Ab0GPIgZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 16 Jul 2010 04:36:25 -0400
Received: from forum.psychotherapie.org ([217.160.22.205]:53460 "EHLO
	s15216962.onlinehome-server.info" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S935984Ab0GPIgW (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 16 Jul 2010 04:36:22 -0400
Received: (from uucp@localhost)
	by s15216962.onlinehome-server.info (8.13.3/8.13.3) with UUCP id o6G8aJwP022417
	for git@vger.kernel.org; Fri, 16 Jul 2010 10:36:19 +0200
Received: (from weigelt@localhost)
	by nibiru.metux.de (8.12.10/8.12.10) id o6G8Tbj0025319
	for git@vger.kernel.org; Fri, 16 Jul 2010 10:29:37 +0200
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151132>


Hi folks,


suppose the following situation:

I've forked some branch A into B, now A and B have evolved 
independently for quite some time into A' and B'. Now I'd like
to rebase B' along A' history line step by step - first on A+1, 
then A+3, ... until A' (that's what I'd call zip-rebase).

For this I need to find out the successor commit A (along the A'
history line). Does anyone know how to do that ?


cu
-- 
----------------------------------------------------------------------
 Enrico Weigelt, metux IT service -- http://www.metux.de/

 phone:  +49 36207 519931  email: weigelt@metux.de
 mobile: +49 151 27565287  icq:   210169427         skype: nekrad666
----------------------------------------------------------------------
 Embedded-Linux / Portierung / Opensource-QM / Verteilte Systeme
----------------------------------------------------------------------
