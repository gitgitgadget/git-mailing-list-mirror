From: Hallvard Breien Furuseth <h.b.furuseth@usit.uio.no>
Subject: Re: Any tips for improving the performance of cloning large repositories?
Date: Fri, 16 Dec 2011 14:39:05 +0100
Message-ID: <hbf.20111216zcin@bombur.uio.no>
References: <CAJ-05NPP7aCcr_SYxLYk8U1entDMv0aF2Me3cTGmOLjYqFKUOA@mail.gmail.com>
	<hbf.20111216yufz@bombur.uio.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Alex Bennee <kernel-hacker@bennee.com>
X-From: git-owner@vger.kernel.org Fri Dec 16 14:39:18 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RbY0L-00035E-4x
	for gcvg-git-2@lo.gmane.org; Fri, 16 Dec 2011 14:39:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759133Ab1LPNjK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 16 Dec 2011 08:39:10 -0500
Received: from mail-out1.uio.no ([129.240.10.57]:37052 "EHLO mail-out1.uio.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755827Ab1LPNjI (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Dec 2011 08:39:08 -0500
Received: from mail-mx1.uio.no ([129.240.10.29])
	by mail-out1.uio.no with esmtp (Exim 4.75)
	(envelope-from <hbf@ulrik.uio.no>)
	id 1RbY0B-0006nP-PL; Fri, 16 Dec 2011 14:39:07 +0100
Received: from bombur.uio.no ([129.240.6.233])
	by mail-mx1.uio.no with esmtp  (Exim 4.76)
	(envelope-from <hbf@ulrik.uio.no>)
	id 1RbY0B-0003G1-B7; Fri, 16 Dec 2011 14:39:07 +0100
Received: by bombur.uio.no (Postfix, from userid 2112)
	id 06384E26; Fri, 16 Dec 2011 14:39:05 +0100 (CET)
In-Reply-To: <hbf.20111216yufz@bombur.uio.no>
X-Mailer: VM 7.19 under Emacs 23.1.1
X-UiO-Ratelimit-Test: rcpts/h 7 msgs/h 3 sum rcpts/h 10 sum msgs/h 4 total rcpts 2054 max rcpts/h 17 ratelimit 0
X-UiO-Spam-info: not spam, SpamAssassin (score=-7.0, required=5.0, autolearn=disabled, RP_MATCHES_RCVD=-2.023,UIO_MAIL_IS_INTERNAL=-5, uiobl=NO, uiouri=NO)
X-UiO-Scanned: DDD1AE0EABA9302A5CEFE220556F6EAA48214859
X-UiO-SPAM-Test: remote_host: 129.240.6.233 spam_score: -69 maxlevel 80 minaction 2 bait 0 mail/h: 3 total 883 max/h 5 blacklist 0 greylist 0 ratelimit 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187277>

I wrote:
> Do you often need to clone from a remote?  Instead of cloning from a
> local (git clone --mirror) which gets auto-updated from the remote.

Er, obviously not, since you tried that with rsync.  Create the mirror
with 'git clone --mirror', then update it with 'git fetch' rather than
rsync.

-- 
Hallvard
