From: =?ISO-8859-15?Q?Dirk_S=FCsserott?= <newsletter@dirk.my1.cc>
Subject: Q: rebasing (moving) a whole tree (not just one branch)
Date: Fri, 18 Mar 2011 21:05:30 +0100
Message-ID: <4D83BB0A.8070307@dirk.my1.cc>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Mar 18 21:05:41 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q0fvY-0007IH-BV
	for gcvg-git-2@lo.gmane.org; Fri, 18 Mar 2011 21:05:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932143Ab1CRUFf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 Mar 2011 16:05:35 -0400
Received: from smtprelay05.ispgateway.de ([80.67.31.100]:38850 "EHLO
	smtprelay05.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756818Ab1CRUFe (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Mar 2011 16:05:34 -0400
Received: from [84.176.61.125] (helo=[192.168.2.100])
	by smtprelay05.ispgateway.de with esmtpa (Exim 4.68)
	(envelope-from <newsletter@dirk.my1.cc>)
	id 1Q0fvP-0008LW-Mt
	for git@vger.kernel.org; Fri, 18 Mar 2011 21:05:31 +0100
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; de; rv:1.9.2.15) Gecko/20110303 Lightning/1.0b2 Thunderbird/3.1.9
X-Df-Sender: 757646
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169353>

Hi,

I'd like to rebase a whole tree from A to B. Not just a single branch, 
but a whole tree. Let's say I have the following history:

--- A --- B
     |
     + -- C -- D
          |
          + E -- F

I'd like to rebase C and its descendants from A to B so it becomes:

--- A --- B
           |
           + -- C' -- D'
                |
                + E' -- F'

I know I can do it manually with

git rebase B C
git rebase C D
git rebase C E
git rebase E F

Is there a way to just say "rebase C and all after that from A to B"?

Dirk
