From: Mark Levedahl <mdl123@verizon.net>
Subject: Re: Scripts to use "bundles" for moving data between repositories
Date: Wed, 14 Feb 2007 16:24:00 -0500
Message-ID: <45D37DF0.70708@verizon.net>
References: <11714622292110-git-send-email-mdl123@verizon.net>
 <7vlkj0r7f0.fsf@assigned-by-dhcp.cox.net>	<45D34D58.8050701@verizon.net>
 <7vhctopqkw.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Wed Feb 14 22:24:16 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HHRbl-0002A6-Gs
	for gcvg-git@gmane.org; Wed, 14 Feb 2007 22:24:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932628AbXBNVYF (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 14 Feb 2007 16:24:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932630AbXBNVYE
	(ORCPT <rfc822;git-outgoing>); Wed, 14 Feb 2007 16:24:04 -0500
Received: from vms046pub.verizon.net ([206.46.252.46]:41777 "EHLO
	vms046pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932628AbXBNVYE (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Feb 2007 16:24:04 -0500
Received: from [127.0.0.1] ([71.246.235.75])
 by vms046.mailsrvcs.net (Sun Java System Messaging Server 6.2-6.01 (built Apr
 3 2006)) with ESMTPA id <0JDH00CNL23ZH434@vms046.mailsrvcs.net> for
 git@vger.kernel.org; Wed, 14 Feb 2007 15:24:02 -0600 (CST)
In-reply-to: <7vhctopqkw.fsf@assigned-by-dhcp.cox.net>
User-Agent: Thunderbird 1.5.0.9 (Windows/20061207)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39753>

Junio C Hamano wrote:
> Also we _might_ want to uuencode (or base85) so that you can
> even e-mail a bundle easily.
>
> I am 75% kidding ;-).
>   
Wouldn't such encoding more logically be a part of whatever is used for 
the transport? My experience (other than emailing patches to the git 
list :-[ ) in this area is that encode / decode of attachments is 
handled transparently by email clients. My email programs (including 
command line scripts) all know how to mime encode / decode arbitrary 
attachments, so I at least would gain nothing by such encoding.

Mark
