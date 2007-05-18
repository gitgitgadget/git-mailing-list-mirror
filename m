From: Steffen Prohaska <prohaska@zib.de>
Subject: merge summaries
Date: Fri, 18 May 2007 07:44:53 +0200
Message-ID: <25A3C618-8D12-42A8-9478-D3A4E7633CE7@zib.de>
Mime-Version: 1.0 (Apple Message framework v752.3)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Content-Transfer-Encoding: 7bit
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri May 18 07:44:56 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HovGo-00022C-7o
	for gcvg-git@gmane.org; Fri, 18 May 2007 07:44:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752694AbXERFoq (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 18 May 2007 01:44:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753875AbXERFoq
	(ORCPT <rfc822;git-outgoing>); Fri, 18 May 2007 01:44:46 -0400
Received: from mailer.zib.de ([130.73.108.11]:59168 "EHLO mailer.zib.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752694AbXERFoq (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 May 2007 01:44:46 -0400
Received: from mailsrv2.zib.de (sc2.zib.de [130.73.108.31])
	by mailer.zib.de (8.13.7+Sun/8.13.7) with ESMTP id l4I5ii0J019431
	for <git@vger.kernel.org>; Fri, 18 May 2007 07:44:44 +0200 (CEST)
Received: from [192.168.178.32] (brln-4db1b6e0.pool.einsundeins.de [77.177.182.224])
	(authenticated bits=0)
	by mailsrv2.zib.de (8.13.4/8.13.4) with ESMTP id l4I5ihUO003480
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NO);
	Fri, 18 May 2007 07:44:44 +0200 (MEST)
X-Mailer: Apple Mail (2.752.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47572>

It took me some time to figure out how to get summaries of the merged  
branch into merge messages. Finally I recognized that I simply need  
to set

	git-config merge.summary true


I have two questions:
1) Why isn't 'true' the default setting? The two probably most  
prominent git repositories, git and kernel, both use merge summaries.  
After some time working with git I started to wonder, how these guys  
create the nicely formatted branch summaries. If merge summaries are  
apparently best practice, why are they missing in my local merges?

2) Why does git-merge have a switch '--no-summary' to switch  
summaries off, but doesn't have a switch '--summary' to switch them  
on? After some time of searching for the solution I started to  
believe that Linus and Junio might use some shell magic to create  
their merge messages, which they pipe to git-merge's -m switch. This  
inconsistency made finding the simple solution even harder.

- Steffen
