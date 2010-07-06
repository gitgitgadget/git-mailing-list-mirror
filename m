From: Enrico Weigelt <weigelt@metux.de>
Subject: get-remote-ref hook
Date: Tue, 6 Jul 2010 22:00:49 +0200
Message-ID: <20100706200049.GD29232@nibiru.local>
Reply-To: weigelt@metux.de
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 06 22:13:17 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OWEW4-0003n3-LP
	for gcvg-git-2@lo.gmane.org; Tue, 06 Jul 2010 22:13:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753462Ab0GFUNM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 Jul 2010 16:13:12 -0400
Received: from forum.psychotherapie.org ([217.160.22.205]:34659 "EHLO
	s15216962.onlinehome-server.info" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752200Ab0GFUNK (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 6 Jul 2010 16:13:10 -0400
X-Greylist: delayed 376 seconds by postgrey-1.27 at vger.kernel.org; Tue, 06 Jul 2010 16:13:10 EDT
Received: (from uucp@localhost)
	by s15216962.onlinehome-server.info (8.13.3/8.13.3) with UUCP id o66K6q2M011714
	for git@vger.kernel.org; Tue, 6 Jul 2010 22:06:52 +0200
Received: (from weigelt@localhost)
	by nibiru.metux.de (8.12.10/8.12.10) id o66K0n9c008303
	for git@vger.kernel.org; Tue, 6 Jul 2010 22:00:49 +0200
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150407>


Hi folks,


I've implemented a little hook for filtering out remote refs
(and the associated objects). This allows to make partial clones.

http://repo.or.cz/w/oss-qm-packages.git/commitdiff/9deb95ff86cb1bd9fc86f7cb4978bf831879f948


cu
-- 
---------------------------------------------------------------------
 Enrico Weigelt    ==   metux IT service - http://www.metux.de/
---------------------------------------------------------------------
 Please visit the OpenSource QM Taskforce:
 	http://wiki.metux.de/public/OpenSource_QM_Taskforce
 Patches / Fixes for a lot dozens of packages in dozens of versions:
	http://patches.metux.de/
---------------------------------------------------------------------
