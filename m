From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [bug] git cannot find "git pull"?
Date: Fri, 12 Jun 2009 16:49:22 -0400
Message-ID: <4A32BF52.50603@garzik.org>
References: <4A319CE1.6040201@garzik.org> <20090612011737.GB5076@inocybe.localdomain> <4A323C56.1090703@garzik.org> <4A32A814.5050802@garzik.org> <20090612202642.GI5076@inocybe.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Todd Zullinger <tmz@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jun 12 22:50:01 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MFDhE-0001hB-MJ
	for gcvg-git-2@gmane.org; Fri, 12 Jun 2009 22:49:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756379AbZFLUtr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Jun 2009 16:49:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754795AbZFLUtr
	(ORCPT <rfc822;git-outgoing>); Fri, 12 Jun 2009 16:49:47 -0400
Received: from srv5.dvmed.net ([207.36.208.214]:56617 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754715AbZFLUtq (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Jun 2009 16:49:46 -0400
Received: from cpe-069-134-158-197.nc.res.rr.com ([69.134.158.197] helo=bd.yyz.us)
	by mail.dvmed.net with esmtpsa (Exim 4.69 #1 (Red Hat Linux))
	id 1MFDh5-0005tX-JR; Fri, 12 Jun 2009 20:49:48 +0000
User-Agent: Thunderbird 2.0.0.21 (X11/20090320)
In-Reply-To: <20090612202642.GI5076@inocybe.localdomain>
X-Spam-Score: -4.4 (----)
X-Spam-Report: SpamAssassin version 3.2.5 on srv5.dvmed.net summary:
	Content analysis details:   (-4.4 points, 5.0 required)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121448>

Todd Zullinger wrote:
> Jeff Garzik wrote:
>> Jeff Garzik wrote:
>>> No strange PATH settings, and this was a completely fresh
>>> Fedora-11/x86-64 reformat and reinstall...
>>>
>>> Adding "--exec-path=/usr/libexec/git-core" seems to work.
>>>
>>> I wonder if it is looking for /usr/libexec64/git-core or something?
>> Same failure (with same workaround) on Fedora 11/i386, fresh
>> install.
> 
> Well hell.  I can't reproduce this.  I setup an F-11/x86_64 instance
> and had no troubles.  Similarly for i386 using the Live USB image.
> 
> Is it possible that some other package is screwing up the git search
> path?  Running strings on /usr/bin/git I find libexec/git-core, so I
> don't think it's trying libexec64, which doesn't exist in an Fedora
> release that I know of.
> 
> I'd be very curious if anyone else can reproduce this and what
> differences there are in the package list between my working system
> and your broken ones.

FWIW, to reproduce my Fedora install, this is the setup I always use for 
my lab computers:

* perform a fresh format + install, not an upgrade
* uncheck 'office' category
* check 'software development' category
* do not select 'customize now', thus using Fedora's default package 
selection

So it is 100% Fedora-shipped software in $PATH...

Regards,

	Jeff
