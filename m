From: Mark Levedahl <mdl123@verizon.net>
Subject: gitk - fails to highlight commits
Date: Tue, 03 Jul 2007 20:44:44 -0400
Message-ID: <468AED7C.5040507@verizon.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: Paul Mackerras <paulus@samba.org>
X-From: git-owner@vger.kernel.org Wed Jul 04 02:45:34 2007
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I5szq-0001lF-Mi
	for gcvg-git@gmane.org; Wed, 04 Jul 2007 02:45:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753286AbXGDApK (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 3 Jul 2007 20:45:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753765AbXGDApK
	(ORCPT <rfc822;git-outgoing>); Tue, 3 Jul 2007 20:45:10 -0400
Received: from vms046pub.verizon.net ([206.46.252.46]:53272 "EHLO
	vms046pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752372AbXGDApJ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Jul 2007 20:45:09 -0400
Received: from [192.168.100.117] ([72.66.70.164])
 by vms046.mailsrvcs.net (Sun Java System Messaging Server 6.2-6.01 (built Apr
 3 2006)) with ESMTPA id <0JKM00K28Q2LSYFH@vms046.mailsrvcs.net> for
 git@vger.kernel.org; Tue, 03 Jul 2007 19:44:45 -0500 (CDT)
User-Agent: Thunderbird 1.5.0.12 (Windows/20070509)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51554>

Using gitk on master (281404ca1db4c921ac162f3c0 in the gitk) gitk's 
highlighting is sporadic. Running gitk from a gitk sandbox and typing 
'gitk' into the 'Highlight Commits' box shows nothing highlighted, but 
all commits should be highlighted. After doing this, many of the commits 
revealed by scrolling down the list are highlighted, just not the ones 
visisble at the top nor the first few below.

This problem first appears in commit 322a8cc ("gitk: New algorithm for 
drawing the graph lines).

Mark
