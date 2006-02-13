From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: Handling large files with GIT
Date: Mon, 13 Feb 2006 00:55:38 -0500
Message-ID: <43F01F5A.5020808@pobox.com>
References: <46a038f90602080114r2205d72cmc2b5c93f6fffe03d@mail.gmail.com>  <87slqty2c8.fsf@mid.deneb.enyo.de> <46a038f90602081435x49e53a1cgdc56040a19768adb@mail.gmail.com> <Pine.OSX.4.64.0602131416530.25089@piva.hawaga.org.uk> <Pine.LNX.4.64.0602121939070.3691@g5.osdl.org> <Pine.LNX.4.64.0602122049010.3691@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Ben Clifford <benc@hawaga.org.uk>,
	Martin Langhoff <martin.langhoff@gmail.com>,
	Florian Weimer <fw@deneb.enyo.de>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Feb 13 06:56:03 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F8Wgs-0005dg-68
	for gcvg-git@gmane.org; Mon, 13 Feb 2006 06:56:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750908AbWBMFz7 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 13 Feb 2006 00:55:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750912AbWBMFz7
	(ORCPT <rfc822;git-outgoing>); Mon, 13 Feb 2006 00:55:59 -0500
Received: from mail.dvmed.net ([216.237.124.58]:39903 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1750890AbWBMFz7 (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 13 Feb 2006 00:55:59 -0500
Received: from cpe-069-134-188-146.nc.res.rr.com ([69.134.188.146] helo=[10.10.10.99])
	by mail.dvmed.net with esmtpsa (Exim 4.52 #1 (Red Hat Linux))
	id 1F8Wga-0001FI-1K; Mon, 13 Feb 2006 05:55:44 +0000
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0602122049010.3691@g5.osdl.org>
X-Spam-Score: 0.1 (/)
X-Spam-Report: Spam detection software, running on the system "srv2.dvmed.net", has
	identified this incoming email as possible spam.  The original message
	has been attached to this so you can view it (if it isn't spam) or label
	similar future email.  If you have any questions, see
	the administrator of that system for details.
	Content preview:  Linus Torvalds wrote: > I've never used maildir layout,
	but if it is a couple of large _flat_ > subdirectories, That's what it
	is :/ One directory per mail folder, with each email an individual file
	in that dir. [...] 
	Content analysis details:   (0.1 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	0.1 RCVD_IN_SORBS_DUL      RBL: SORBS: sent directly from dynamic IP address
	[69.134.188.146 listed in dnsbl.sorbs.net]
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16047>

Linus Torvalds wrote:
> I've never used maildir layout, but if it is a couple of large _flat_ 
> subdirectories,

That's what it is :/   One directory per mail folder, with each email an 
individual file in that dir.

On the side I run a mini-ISP that offers (among other things) 
SMTP/IMAP/POP via exim/dovecot.  I use maildir for my customers, and am 
desperately searching for a better solution.  David Woodhouse and I talk 
off and on about using git for distributed mail storage.

OTOH, I wonder if a P2P-ish, sha1-indexed network service wouldn't be 
better for both a git fallback and email storage.

	Jeff
