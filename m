From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH] Keep committer and committer dates
Date: Thu, 05 Jun 2008 09:10:50 +0200
Message-ID: <4847917A.2050700@viscovery.net>
References: <Pine.LNX.4.61.0806031647320.1798@tm8103-a.perex-int.cz> <alpine.DEB.1.00.0806032115340.13507@racer.site.net> <Pine.LNX.4.61.0806041113520.1798@tm8103-a.perex-int.cz> <20080604102906.GA2126@diana.vm.bytemark.co.uk> <m3ej7dzc7y.fsf@localhost.localdomain> <Pine.LNX.4.61.0806041424140.1798@tm8103-a.perex-int.cz> <alpine.DEB.1.00.0806041641150.13507@racer.site.net> <20080605010330.GB24466@leksak.fem-net> <alpine.DEB.1.00.0806050523120.21190@racer>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Jaroslav Kysela <perex@perex.cz>, git@vger.kernel.org
To: Stephan Beyer <s-beyer@gmx.net>
X-From: git-owner@vger.kernel.org Thu Jun 05 09:11:51 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K49dW-0007Ex-L6
	for gcvg-git-2@gmane.org; Thu, 05 Jun 2008 09:11:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752252AbYFEHK6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Jun 2008 03:10:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752235AbYFEHK6
	(ORCPT <rfc822;git-outgoing>); Thu, 5 Jun 2008 03:10:58 -0400
Received: from lilzmailso01.liwest.at ([212.33.55.23]:54433 "EHLO
	lilzmailso01.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752127AbYFEHK5 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Jun 2008 03:10:57 -0400
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso01.liwest.at with esmtpa (Exim 4.66)
	(envelope-from <j.sixt@viscovery.net>)
	id 1K49cZ-0006HJ-HR; Thu, 05 Jun 2008 09:10:54 +0200
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.42])
	by linz.eudaptics.com (Postfix) with ESMTP
	id 7CD476B7; Thu,  5 Jun 2008 09:10:50 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.6 (Windows/20070728)
In-Reply-To: <alpine.DEB.1.00.0806050523120.21190@racer>
X-Spam-Score: 1.7 (+)
X-Spam-Report: ALL_TRUSTED=-1.8, BAYES_99=3.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83869>

Johannes Schindelin schrieb:
> Hi,
> 
> On Thu, 5 Jun 2008, Stephan Beyer wrote:
> 
>>> - as has been pointed out several times now, you _are_ the committer, 
>>>   and you seem to want to lie there.
>> Lying is already possible with GIT_COMMITTER_{NAME,EMAIL,NAME} 
>> environment variables.
> 
> Of course it is possible!  I even pointed to a method!
> 
> The _point_ was that we do not want to recommend it.  And giving prominent 
> support for it, such as introducing a command line parameter, _would_ 
> have the effect of recommending it.

Furthermore, if you mess with committer dates, you can screw up revision
walking to some degree. committer dates aren't merely informational.

-- Hannes
