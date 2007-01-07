From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [KORG] Re: kernel.org lies about latest -mm kernel
Date: Sun, 07 Jan 2007 17:21:47 -0500
Message-ID: <45A1727B.7070302@garzik.org>
References: <20061214223718.GA3816@elf.ucw.cz>	<20061216094421.416a271e.randy.dunlap@oracle.com>	<20061216095702.3e6f1d1f.akpm@osdl.org> <458434B0.4090506@oracle.com>	<1166297434.26330.34.camel@localhost.localdomain>	<1166304080.13548.8.camel@nigel.suspend2.net>	<459152B1.9040106@zytor.com>	<1168140954.2153.1.camel@nigel.suspend2.net>	<45A07587.3080503@garzik.org> <20070107201146.GA21956@suse.de> <7v4pr21p0o.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Greg KH <gregkh@suse.de>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jan 07 23:22:24 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H3gOp-0007CX-Vd
	for gcvg-git@gmane.org; Sun, 07 Jan 2007 23:21:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965229AbXAGWVx (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 7 Jan 2007 17:21:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965230AbXAGWVw
	(ORCPT <rfc822;git-outgoing>); Sun, 7 Jan 2007 17:21:52 -0500
Received: from srv5.dvmed.net ([207.36.208.214]:50669 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965229AbXAGWVw (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Jan 2007 17:21:52 -0500
Received: from cpe-065-190-194-075.nc.res.rr.com ([65.190.194.75] helo=[10.10.10.10])
	by mail.dvmed.net with esmtpsa (Exim 4.63 #1 (Red Hat Linux))
	id 1H3gOi-0006Zz-Vh; Sun, 07 Jan 2007 22:21:49 +0000
User-Agent: Thunderbird 1.5.0.9 (X11/20061219)
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7v4pr21p0o.fsf@assigned-by-dhcp.cox.net>
X-Spam-Score: -4.3 (----)
X-Spam-Report: SpamAssassin version 3.1.7 on srv5.dvmed.net summary:
	Content analysis details:   (-4.3 points, 5.0 required)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36202>

Junio C Hamano wrote:
> Greg KH <gregkh@suse.de> writes:
> 
>> Any shortcut to clone or set up a repo using "alternatives" so that we
>> don't have this issue at all?
> 
> "clone -l -s" has been there for quote a long time (since mid Aug
> 2005).  Because -s implies -l since end of November 2005, you
> should be able to say
> 
> 	git clone --bare -s ..../torvalds/linux-2.6.git stable-queue.git

Yes but what about existing trees?

Can you add an alternatives file, then prune, and get the same result as 
if you had done a clone -s ?

	Jeff
