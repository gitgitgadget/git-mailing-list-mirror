From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: 'git commit' ignoring args?
Date: Tue, 29 Nov 2005 06:03:11 -0500
Message-ID: <438C356F.9080301@pobox.com>
References: <438B2F40.6070801@pobox.com> <7vzmnotwyr.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Nov 29 14:27:00 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Eh3Gg-0001rN-6k
	for gcvg-git@gmane.org; Tue, 29 Nov 2005 12:03:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751144AbVK2LDT (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 29 Nov 2005 06:03:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751196AbVK2LDT
	(ORCPT <rfc822;git-outgoing>); Tue, 29 Nov 2005 06:03:19 -0500
Received: from mail.dvmed.net ([216.237.124.58]:29609 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1751144AbVK2LDS (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 29 Nov 2005 06:03:18 -0500
Received: from cpe-069-134-188-146.nc.res.rr.com ([69.134.188.146] helo=[10.10.10.88])
	by mail.dvmed.net with esmtpsa (Exim 4.52 #1 (Red Hat Linux))
	id 1Eh3GU-0006s2-LB; Tue, 29 Nov 2005 11:03:15 +0000
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vzmnotwyr.fsf@assigned-by-dhcp.cox.net>
X-Spam-Score: 0.1 (/)
X-Spam-Report: Spam detection software, running on the system "srv2.dvmed.net", has
	identified this incoming email as possible spam.  The original message
	has been attached to this so you can view it (if it isn't spam) or label
	similar future email.  If you have any questions, see
	the administrator of that system for details.
	Content preview:  Junio C Hamano wrote: > Could it be that at some point
	after touching book.xml before > running git commit you did
	update-index on it? Not according to scrollback, no. > -- >8 -- > Here
	is what I did to reproduce. [...] 
	Content analysis details:   (0.1 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	0.1 RCVD_IN_SORBS_DUL      RBL: SORBS: sent directly from dynamic IP address
	[69.134.188.146 listed in dnsbl.sorbs.net]
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12939>

Junio C Hamano wrote:
> Could it be that at some point after touching book.xml before
> running git commit you did update-index on it?

Not according to scrollback, no.


> -- >8 --
> Here is what I did to reproduce.

Unfortunately, I cannot reproduce the problem either :(

Oh well, as long as the facility works in general, I'll live to fight 
another day :)

	Jeff
