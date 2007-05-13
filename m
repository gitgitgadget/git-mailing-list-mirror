From: Sean <seanlkml@sympatico.ca>
Subject: ~ and ^
Date: Sun, 13 May 2007 14:44:42 -0400
Message-ID: <20070513144442.b3cba792.seanlkml@sympatico.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun May 13 20:44:53 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HnJ3r-0001XI-7A
	for gcvg-git@gmane.org; Sun, 13 May 2007 20:44:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757559AbXEMSop (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 13 May 2007 14:44:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757568AbXEMSop
	(ORCPT <rfc822;git-outgoing>); Sun, 13 May 2007 14:44:45 -0400
Received: from bay0-omc2-s30.bay0.hotmail.com ([65.54.246.166]:15387 "EHLO
	bay0-omc2-s30.bay0.hotmail.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757559AbXEMSop (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 13 May 2007 14:44:45 -0400
Received: from bayc1-pasmtp07.bayc1.hotmail.com ([65.54.191.167]) by bay0-omc2-s30.bay0.hotmail.com with Microsoft SMTPSVC(6.0.3790.2668);
	 Sun, 13 May 2007 11:44:44 -0700
X-Originating-IP: [65.95.67.118]
X-Originating-Email: [seanlkml@sympatico.ca]
Received: from linux1.attic.local ([65.95.67.118]) by bayc1-pasmtp07.bayc1.hotmail.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.2668);
	 Sun, 13 May 2007 11:45:24 -0700
Received: from guru.attic.local ([10.10.10.28])
	by linux1.attic.local with esmtp (Exim 4.43)
	id 1HnJ2Q-0002aF-T8
	for git@vger.kernel.org; Sun, 13 May 2007 14:43:22 -0400
X-Mailer: Sylpheed 2.3.1 (GTK+ 2.10.8; i386-redhat-linux-gnu)
X-OriginalArrivalTime: 13 May 2007 18:45:24.0468 (UTC) FILETIME=[DDEF2340:01C7958E]
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47165>


Would it be possible/reasonable to treat a bare ~3 (or ^) on the git command
line as equivalent to "<current branch>~3" ?    At least @{3} already works
this way and it would be nice to do the same for the even more common tilde
and hat operations.  If so, it would be a small convenience to just type:
"git show ~3"

Thanks,
Sean
