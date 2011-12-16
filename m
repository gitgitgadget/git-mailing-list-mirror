From: Hallvard Breien Furuseth <h.b.furuseth@usit.uio.no>
Subject: Re: Any tips for improving the performance of cloning large repositories?
Date: Fri, 16 Dec 2011 14:11:11 +0100
Message-ID: <hbf.20111216yufz@bombur.uio.no>
References: <CAJ-05NPP7aCcr_SYxLYk8U1entDMv0aF2Me3cTGmOLjYqFKUOA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Alex Bennee <kernel-hacker@bennee.com>
X-From: git-owner@vger.kernel.org Fri Dec 16 14:11:19 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RbXZH-0007Iw-3R
	for gcvg-git-2@lo.gmane.org; Fri, 16 Dec 2011 14:11:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759124Ab1LPNLO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 16 Dec 2011 08:11:14 -0500
Received: from mail-out1.uio.no ([129.240.10.57]:57178 "EHLO mail-out1.uio.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751978Ab1LPNLN (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Dec 2011 08:11:13 -0500
Received: from mail-mx3.uio.no ([129.240.10.44])
	by mail-out1.uio.no with esmtp (Exim 4.75)
	(envelope-from <hbf@ulrik.uio.no>)
	id 1RbXZA-0005lr-Fo; Fri, 16 Dec 2011 14:11:12 +0100
Received: from bombur.uio.no ([129.240.6.233])
	by mail-mx3.uio.no with esmtp  (Exim 4.76)
	(envelope-from <hbf@ulrik.uio.no>)
	id 1RbXZA-0000r8-4w; Fri, 16 Dec 2011 14:11:12 +0100
Received: by bombur.uio.no (Postfix, from userid 2112)
	id AD3E5FD5; Fri, 16 Dec 2011 14:11:11 +0100 (CET)
In-Reply-To: <CAJ-05NPP7aCcr_SYxLYk8U1entDMv0aF2Me3cTGmOLjYqFKUOA@mail.gmail.com>
X-Mailer: VM 7.19 under Emacs 23.1.1
X-UiO-Ratelimit-Test: rcpts/h 2 msgs/h 1 sum rcpts/h 5 sum msgs/h 2 total rcpts 2049 max rcpts/h 17 ratelimit 0
X-UiO-Spam-info: not spam, SpamAssassin (score=-7.0, required=5.0, autolearn=disabled, RP_MATCHES_RCVD=-2.023,UIO_MAIL_IS_INTERNAL=-5, uiobl=NO, uiouri=NO)
X-UiO-Scanned: 73D3DEB4FF3F22F2C95FEE00412CF29F9E4329FB
X-UiO-SPAM-Test: remote_host: 129.240.6.233 spam_score: -69 maxlevel 80 minaction 2 bait 0 mail/h: 1 total 881 max/h 5 blacklist 0 greylist 0 ratelimit 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187276>

Alex Bennee writes:
> We've migrated our old CVS repository into GIT without too many
> issues. However now we are rolling out the usage of the new repository
> we are hitting some performance bottlenecks, especially on the initial
> clone (something our buildbot instance does a lot).

Do you often need to clone from a remote?  Instead of cloning from a
local (git clone --mirror) which gets auto-updated from the remote.

Could the buildbot make do with a shallow repo, clone --depth <num>?

-- 
Hallvard
