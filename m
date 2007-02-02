From: Alexander Litvinov <lan@academsoft.ru>
Subject: Question: next, master and pu branches
Date: Fri, 2 Feb 2007 11:41:53 +0600
Organization: AcademSoft Ltd.
Message-ID: <200702021141.53997.lan@academsoft.ru>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Feb 02 07:03:22 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HCrW5-0003At-VT
	for gcvg-git@gmane.org; Fri, 02 Feb 2007 07:03:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423128AbXBBGDA (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 2 Feb 2007 01:03:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423127AbXBBGC7
	(ORCPT <rfc822;git-outgoing>); Fri, 2 Feb 2007 01:02:59 -0500
Received: from gw.ac-sw.com ([81.1.223.2]:41431 "EHLO gw.ac-sw.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1423124AbXBBGCy (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Feb 2007 01:02:54 -0500
X-Greylist: delayed 1243 seconds by postgrey-1.27 at vger.kernel.org; Fri, 02 Feb 2007 01:02:54 EST
Received: from localhost (localhost [127.0.0.1])
	by gw.ac-sw.com (Postfix) with ESMTP id DA258BDCA
	for <git@vger.kernel.org>; Fri,  2 Feb 2007 11:41:58 +0600 (NOVT)
Received: from gw.ac-sw.com ([127.0.0.1])
 by localhost (gw.ac-sw.com [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 19135-10 for <git@vger.kernel.org>; Fri,  2 Feb 2007 11:41:58 +0600 (NOVT)
Received: from lan.ac-sw.lcl (lan.ac-sw.lcl [192.168.0.69])
	by gw.ac-sw.com (Postfix) with ESMTP id F31D6BDCC
	for <git@vger.kernel.org>; Fri,  2 Feb 2007 11:41:57 +0600 (NOVT)
Received: by lan.ac-sw.lcl (Postfix, from userid 65534)
	id E6D588DA7A57; Fri,  2 Feb 2007 11:41:57 +0600 (NOVT)
Received: from localhost (localhost [127.0.0.1])
	by lan.ac-sw.lcl (Postfix) with ESMTP id 84D238DA7A57
	for <git@vger.kernel.org>; Fri,  2 Feb 2007 11:41:54 +0600 (NOVT)
User-Agent: KMail/1.8
Content-Disposition: inline
X-Virus-Scanned: amavisd-new at gw.ac-sw.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38457>

Hello,

Can somebody explain the meaning of next and pu branches and some documenation 
about using topic branches.

My development model use two branches now: stable release and develment 
branch. All changes in the stable release branch are bug-fix only changes. 
All (or most) of them must go to development release. Now I do this using 
cherry-pick but it is not easy to track what was merged especialy when merge 
pruduce confic resloved by hands. Stable branch live long life, much more 
than 100 commits. 

It seems topic branches can help me here, but reading Documentation under git 
sources teach to make topic branch from the branch point and then merge it to 
both branches. This can work while stable branch has short life and was not 
heavily rewritten. 

If there any technique that can help me ?
