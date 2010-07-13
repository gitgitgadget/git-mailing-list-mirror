From: Enrico Weigelt <weigelt@metux.de>
Subject: Massive repository corruptions
Date: Tue, 13 Jul 2010 03:56:00 +0200
Message-ID: <20100713015600.GA29392@nibiru.local>
Reply-To: weigelt@metux.de
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 13 04:02:26 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OYUpF-0006wf-83
	for gcvg-git-2@lo.gmane.org; Tue, 13 Jul 2010 04:02:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755949Ab0GMCCU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Jul 2010 22:02:20 -0400
Received: from forum.psychotherapie.org ([217.160.22.205]:58507 "EHLO
	s15216962.onlinehome-server.info" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755532Ab0GMCCT (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 12 Jul 2010 22:02:19 -0400
Received: (from uucp@localhost)
	by s15216962.onlinehome-server.info (8.13.3/8.13.3) with UUCP id o6D22GbA017831
	for git@vger.kernel.org; Tue, 13 Jul 2010 04:02:16 +0200
Received: (from weigelt@localhost)
	by nibiru.metux.de (8.12.10/8.12.10) id o6D1u0bw017027
	for git@vger.kernel.org; Tue, 13 Jul 2010 03:56:00 +0200
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150869>


Hi folks,


I've just reorganized several repositories (eg. splitted off a large 
repo into several small ones), and then I had massive corruptions
(broken pack files) in the new repos (after they already had been clean).

Maybe it has something to do with a cronjob which frequently GC's
all the repos, and it could get even worse if the fs sometimes 
goes full within this process.

Could multiple GCs running on the same repo cause this ?


cu
-- 
----------------------------------------------------------------------
 Enrico Weigelt, metux IT service -- http://www.metux.de/

 phone:  +49 36207 519931  email: weigelt@metux.de
 mobile: +49 151 27565287  icq:   210169427         skype: nekrad666
----------------------------------------------------------------------
 Embedded-Linux / Portierung / Opensource-QM / Verteilte Systeme
----------------------------------------------------------------------
