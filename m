From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: Mercurial v0.4d
Date: Thu, 05 May 2005 15:04:31 -0400
Message-ID: <427A6E3F.5090904@pobox.com>
References: <20050504025852.GK22038@waste.org> <20050504181802.GS22038@waste.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Cc: linux-kernel <linux-kernel@vger.kernel.org>, git@vger.kernel.org,
	Linus Torvalds <torvalds@osdl.org>
X-From: git-owner@vger.kernel.org Thu May 05 21:03:40 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DTlcL-0005r7-K3
	for gcvg-git@gmane.org; Thu, 05 May 2005 21:02:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262179AbVEETIK (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 5 May 2005 15:08:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262172AbVEETFE
	(ORCPT <rfc822;git-outgoing>); Thu, 5 May 2005 15:05:04 -0400
Received: from mail.dvmed.net ([216.237.124.58]:901 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S262178AbVEETEi (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 5 May 2005 15:04:38 -0400
Received: from cpe-065-184-065-144.nc.res.rr.com ([65.184.65.144] helo=[10.10.10.88])
	by mail.dvmed.net with esmtpsa (Exim 4.50 #1 (Red Hat Linux))
	id 1DTleH-0001OA-AO; Thu, 05 May 2005 19:04:37 +0000
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.6) Gecko/20050328 Fedora/1.7.6-1.2.5
X-Accept-Language: en-us, en
To: Matt Mackall <mpm@selenic.com>
In-Reply-To: <20050504181802.GS22038@waste.org>
X-Spam-Score: 0.0 (/)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Matt Mackall wrote:
> The web protocol is painfully slow, mostly because it makes an http
> round trip per file revision to pull. I'm about to start working on a
> replacement that minimizes round trips.

Can you make it do HTTP 1.1 pipelining?

	Jeff


