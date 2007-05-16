From: Jeff Garzik <jeff@garzik.org>
Subject: Re: Losing branches (whee, data loss)
Date: Wed, 16 May 2007 02:40:09 -0400
Message-ID: <464AA749.90101@garzik.org>
References: <464A940C.3080906@garzik.org> <7vtzudfgam.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Wed May 16 08:40:37 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HoDBc-0002Bg-Sq
	for gcvg-git@gmane.org; Wed, 16 May 2007 08:40:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757318AbXEPGkP (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 16 May 2007 02:40:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754457AbXEPGkP
	(ORCPT <rfc822;git-outgoing>); Wed, 16 May 2007 02:40:15 -0400
Received: from srv5.dvmed.net ([207.36.208.214]:54005 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757318AbXEPGkN (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 May 2007 02:40:13 -0400
Received: from cpe-065-190-194-075.nc.res.rr.com ([65.190.194.75] helo=[10.10.10.10])
	by mail.dvmed.net with esmtpsa (Exim 4.63 #1 (Red Hat Linux))
	id 1HoDBE-0006Sm-Kr; Wed, 16 May 2007 06:40:13 +0000
User-Agent: Thunderbird 1.5.0.10 (X11/20070302)
In-Reply-To: <7vtzudfgam.fsf@assigned-by-dhcp.cox.net>
X-Spam-Score: -4.3 (----)
X-Spam-Report: SpamAssassin version 3.1.8 on srv5.dvmed.net summary:
	Content analysis details:   (-4.3 points, 5.0 required)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47418>

Junio C Hamano wrote:
> Jeff Garzik <jeff@garzik.org> writes:
> 
>> Grumble!
>>
>> When all this started, the branch 'upstream-fixes' exists, and branch
>> 'tmp' does not exist.  This is my local clone of
>> git://git.kernel.org/pub/scm/linux/kernel/git/jgarzik/libata-dev.git
>>
>> [jgarzik@pretzel libata-dev]$ git branch -m upstream-fixes tmp
>> error: Could not open config file!
>> fatal: Branch rename failed
> 
> Sorry to hear that.
> 
> We used to have a problem with "branch -m" when you did not have
> a .git/config file (or it was unwritable).  I think 1.5.0.X
> series and 1.5.1 release had this bug; 1.5.1.1 and later should
> have the appropriate fix.

Using the latest version from Fedora Extras: git-core-1.5.0.6-1.fc6


> Was this really a "whee, data loss", I wonder...?

The branches definitely went away.  The sha1-indexed commits are 
probably still there...

	Jeff
