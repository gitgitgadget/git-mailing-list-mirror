From: Mark Levedahl <mdl123@verizon.net>
Subject: Re: [PATCH] git-bundle - bundle objects and references for
 disconnected   transfer.
Date: Thu, 15 Feb 2007 19:12:04 -0500
Message-ID: <45D4F6D4.9070703@verizon.net>
References: <11714622292110-git-send-email-mdl123@verizon.net>
 <11714622292295-git-send-email-mdl123@verizon.net>
 <Pine.LNX.4.63.0702142238310.22628@wbgn013.biozentrum.uni-wuerzburg.de>
 <45D398F9.6070205@verizon.net>
 <Pine.LNX.4.63.0702150054210.22628@wbgn013.biozentrum.uni-wuerzburg.de>
 <45D3C62D.6090609@verizon.net>
 <Pine.LNX.4.63.0702151629130.22628@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Fri Feb 16 01:12:59 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HHqif-0005y1-IU
	for gcvg-git@gmane.org; Fri, 16 Feb 2007 01:12:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422804AbXBPAMG (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 15 Feb 2007 19:12:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422801AbXBPAMG
	(ORCPT <rfc822;git-outgoing>); Thu, 15 Feb 2007 19:12:06 -0500
Received: from vms042pub.verizon.net ([206.46.252.42]:48840 "EHLO
	vms042pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1422803AbXBPAMF (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Feb 2007 19:12:05 -0500
Received: from [127.0.0.1] ([71.246.235.75])
 by vms042.mailsrvcs.net (Sun Java System Messaging Server 6.2-6.01 (built Apr
 3 2006)) with ESMTPA id <0JDJ00KCD4K3ID86@vms042.mailsrvcs.net> for
 git@vger.kernel.org; Thu, 15 Feb 2007 18:12:04 -0600 (CST)
In-reply-to: <Pine.LNX.4.63.0702151629130.22628@wbgn013.biozentrum.uni-wuerzburg.de>
User-Agent: Thunderbird 1.5.0.9 (Windows/20061207)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39865>

Johannes Schindelin wrote:
> Why not force unmixing? I.e. first the options for git-bundle, _then_ the 
> rest? (In that case, you would leave out the "-*)" clause).
>   
This would just trade one usability issue for another.
> It does not have to be tar. There is no good reason that the parts you put 
> into the bundle have to be files, rather than header and body.
>   
sh does not handle binary files: there is no way to split header from 
binary payload.

Mark
