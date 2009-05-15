From: Jeff Garzik <jeff@garzik.org>
Subject: Re: git daemon request logging?
Date: Fri, 15 May 2009 17:01:16 -0400
Message-ID: <4A0DD81C.2000709@garzik.org>
References: <4A0DC4E0.7020001@garzik.org> <81b0412b0905151356t7bf613d5me39af08d37f72857@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: Alex Riesen <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Fri May 15 23:01:34 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M54X8-0008E5-6v
	for gcvg-git-2@gmane.org; Fri, 15 May 2009 23:01:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752765AbZEOVBS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 15 May 2009 17:01:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752461AbZEOVBS
	(ORCPT <rfc822;git-outgoing>); Fri, 15 May 2009 17:01:18 -0400
Received: from srv5.dvmed.net ([207.36.208.214]:33128 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752200AbZEOVBS (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 May 2009 17:01:18 -0400
Received: from cpe-069-134-158-197.nc.res.rr.com ([69.134.158.197] helo=bd.yyz.us)
	by mail.dvmed.net with esmtpsa (Exim 4.69 #1 (Red Hat Linux))
	id 1M54Ws-0007m7-Jv; Fri, 15 May 2009 21:01:19 +0000
User-Agent: Thunderbird 2.0.0.21 (X11/20090320)
In-Reply-To: <81b0412b0905151356t7bf613d5me39af08d37f72857@mail.gmail.com>
X-Spam-Score: -4.4 (----)
X-Spam-Report: SpamAssassin version 3.2.5 on srv5.dvmed.net summary:
	Content analysis details:   (-4.4 points, 5.0 required)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119296>

Alex Riesen wrote:
> 2009/5/15 Jeff Garzik <jeff@garzik.org>:
>> Does the git daemon do any sort of request logging?  Could it?
>>
>> I was thinking it would be nice to see the amount of pulls/clones for each
>> git.kernel.org repository.
> 
> Does this count?
> 
> May 15 22:54:47 tigra git[28923]: connect from 192.168.0.8 (192.168.0.8)
> May 15 22:54:47 tigra git-daemon[28924]: Connection from 192.168.0.8:40845
> May 15 22:54:47 tigra git-daemon[28924]: Extended attributes (11
> bytes) exist <host=gate>
> May 15 22:54:47 tigra git-daemon[28924]: Request upload-pack for '~raa/src/git'
> 
> fetch(pull)/clone are the same for daemon.

Honestly I was hoping for something more along the lines of httpd 
one-line request logging, as the above is a lot of data to log + parse.

	Jeff
