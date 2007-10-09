From: Johannes Sixt <j.sixt@viscovery.net>
Subject: 'git diff' in rebase--interactive
Date: Tue, 09 Oct 2007 10:51:27 +0200
Message-ID: <470B410F.1040506@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Oct 09 10:51:46 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IfAoX-0000xZ-HN
	for gcvg-git-2@gmane.org; Tue, 09 Oct 2007 10:51:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751037AbXJIIva (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Oct 2007 04:51:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751126AbXJIIva
	(ORCPT <rfc822;git-outgoing>); Tue, 9 Oct 2007 04:51:30 -0400
Received: from lilzmailso01.liwest.at ([212.33.55.23]:10339 "EHLO
	lilzmailso01.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750930AbXJIIv3 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Oct 2007 04:51:29 -0400
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso01.liwest.at with esmtpa (Exim 4.66)
	(envelope-from <j.sixt@viscovery.net>)
	id 1IfAoD-0003Kh-U7; Tue, 09 Oct 2007 10:51:22 +0200
Received: from [192.168.1.42] (J6T.linz.viscovery [192.168.1.42])
	by linz.eudaptics.com (Postfix) with ESMTP
	id A817A69F; Tue,  9 Oct 2007 10:51:27 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.6 (Windows/20070728)
X-Spam-Score: 1.7 (+)
X-Spam-Report: ALL_TRUSTED=-1.8, BAYES_99=3.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60369>

I wonder for what reason rebase--interactive generates a patch using
'git diff' in the make_patch function. Is this an artefact?

I'd like to get rid of this use of 'git diff' because it invokes external 
diff drivers, which is totally unwanted if the driver is interactive - like 
the 'windiff' thing that I posted a week ago.

-- Hannes
