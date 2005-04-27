From: Paul Mackerras <paulus@samba.org>
Subject: Re: Revised PPC assembly implementation
Date: Wed, 27 Apr 2005 13:39:02 +1000
Message-ID: <17007.2390.258823.189255@cargo.ozlabs.ibm.com>
References: <17005.38889.738457.359270@cargo.ozlabs.ibm.com>
	<20050427014712.13552.qmail@science.horizon.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: davem@davemloft.net, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 27 05:32:50 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DQdHn-0005Go-KW
	for gcvg-git@gmane.org; Wed, 27 Apr 2005 05:32:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261901AbVD0Dh1 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 26 Apr 2005 23:37:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261902AbVD0Dh1
	(ORCPT <rfc822;git-outgoing>); Tue, 26 Apr 2005 23:37:27 -0400
Received: from ozlabs.org ([203.10.76.45]:52407 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S261901AbVD0DhW (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 26 Apr 2005 23:37:22 -0400
Received: by ozlabs.org (Postfix, from userid 1003)
	id A4DE367B1A; Wed, 27 Apr 2005 13:37:20 +1000 (EST)
To: linux@horizon.com
In-Reply-To: <20050427014712.13552.qmail@science.horizon.com>
X-Mailer: VM 7.19 under Emacs 21.4.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

linux@horizon.com writes:

> Here's a massively revised version, scheduled very close to optimally for
> the G4.  (The main remaining limitation is the loading of the k value
> in %r5, which could be split up more.)
> 
> My hope is that the G5 will do decently on it as well.

Nice... your new version takes 4.413 seconds on my G5 for 1000MB,
compared to 4.606 for your old version, i.e. it's about 4.4% faster.
Unfortunately it gives the wrong answer, though.

On my powerbook, which has a 1.5GHz G4 (7447A), the same test takes
4.68 seconds with my version, 4.72 seconds with your old version, but
only 3.90 seconds with your new version.

Care to check the code and find out why it's giving the wrong answer?

Regards,
Paul.
