From: Jonathan del Strother <maillist@steelskies.com>
Subject: [BUG] git-filter-branch and filename case changes on insensitive file systems
Date: Wed, 10 Oct 2007 10:40:08 +0100
Message-ID: <80A15F58-5A53-419B-9E22-E967CD590A12@steelskies.com>
Mime-Version: 1.0 (Apple Message framework v907)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Oct 10 11:40:25 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IfY3F-0005kx-H9
	for gcvg-git-2@gmane.org; Wed, 10 Oct 2007 11:40:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754645AbXJJJkP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Oct 2007 05:40:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754598AbXJJJkO
	(ORCPT <rfc822;git-outgoing>); Wed, 10 Oct 2007 05:40:14 -0400
Received: from juliet.asmallorange.com ([207.210.105.70]:43300 "EHLO
	juliet.asmallorange.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754511AbXJJJkN (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Oct 2007 05:40:13 -0400
Received: from gir.office.bestbefore.tv ([89.105.122.147]:56212)
	by juliet.asmallorange.com with esmtpa (Exim 4.68)
	(envelope-from <maillist@steelskies.com>)
	id 1IfY31-0002Ef-MO
	for git@vger.kernel.org; Wed, 10 Oct 2007 05:40:11 -0400
X-Mailer: Apple Mail (2.907)
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - juliet.asmallorange.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - steelskies.com
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60487>

My repo has a change where a directory named Src was renamed to src.   
When I run "git filter-branch HEAD", my repo history is  rewritten so  
it appears that the Src directory was simply deleted.  I'm using case  
insensitive HFS+.
Fortunately, I can work around this by using -d to work off a case  
sensitive HFS+ volume - "git filter-branch -d /Volumes/CaseSensitive/ 
test HEAD" correctly changes nothing.

Anyone know why this happens?

Jon
