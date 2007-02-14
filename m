From: Mark Levedahl <mdl123@verizon.net>
Subject: Re: Scripts to use "bundles" for moving data between repositories
Date: Wed, 14 Feb 2007 09:37:50 -0500
Message-ID: <45D31EBE.9090106@verizon.net>
References: <11714622292110-git-send-email-mdl123@verizon.net>
 <vpq1wksbzf5.fsf@olympe.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 14 15:38:00 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HHLGh-00061o-4W
	for gcvg-git@gmane.org; Wed, 14 Feb 2007 15:37:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932320AbXBNOh4 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 14 Feb 2007 09:37:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932322AbXBNOh4
	(ORCPT <rfc822;git-outgoing>); Wed, 14 Feb 2007 09:37:56 -0500
Received: from vms042pub.verizon.net ([206.46.252.42]:56527 "EHLO
	vms042pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932321AbXBNOhz (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Feb 2007 09:37:55 -0500
Received: from [127.0.0.1] ([71.246.235.75])
 by vms042.mailsrvcs.net (Sun Java System Messaging Server 6.2-6.01 (built Apr
 3 2006)) with ESMTPA id <0JDG00DF7JAWCYX2@vms042.mailsrvcs.net> for
 git@vger.kernel.org; Wed, 14 Feb 2007 08:37:45 -0600 (CST)
In-reply-to: <vpq1wksbzf5.fsf@olympe.imag.fr>
User-Agent: Thunderbird 1.5.0.9 (Windows/20061207)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39653>

Matthieu Moy wrote:
>> Did you also have a look at
>>
>> http://kernel.org/git/?p=cogito/cogito-bundle.git
>>
>>     
Yes, I did. I rejected that for my use as it seemed much too 
restrictive: 1 branch at a time, no tags. What I wrote can pack up 
everything in a repository in one go if so desired, or any subpiece. 
Also, this requires nothing beyond git-core (no dependency upon cg), and 
cg and git-core do not interoperate well regarding remote branch 
definitions.

Mark
