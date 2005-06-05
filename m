From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: git-shortlog script
Date: Sat, 04 Jun 2005 20:19:47 -0400
Message-ID: <42A24523.5010404@pobox.com>
References: <42A22C20.10002@pobox.com> <Pine.LNX.4.58.0506041642530.1876@ppc970.osdl.org> <42A24274.7040906@pobox.com> <Pine.LNX.4.58.0506041715170.1876@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>,
	Linux Kernel <linux-kernel@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Jun 05 02:16:46 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Deiok-0001CU-Sq
	for gcvg-git@gmane.org; Sun, 05 Jun 2005 02:16:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261448AbVFEAT6 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 4 Jun 2005 20:19:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261453AbVFEAT6
	(ORCPT <rfc822;git-outgoing>); Sat, 4 Jun 2005 20:19:58 -0400
Received: from mail.dvmed.net ([216.237.124.58]:9411 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S261450AbVFEATv (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 4 Jun 2005 20:19:51 -0400
Received: from cpe-065-184-065-144.nc.res.rr.com ([65.184.65.144] helo=[10.10.10.88])
	by mail.dvmed.net with esmtpsa (Exim 4.51 #1 (Red Hat Linux))
	id 1Deirl-0002Vo-U3; Sun, 05 Jun 2005 00:19:51 +0000
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.6) Gecko/20050328 Fedora/1.7.6-1.2.5
X-Accept-Language: en-us, en
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0506041715170.1876@ppc970.osdl.org>
X-Spam-Score: 0.0 (/)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Linus Torvalds wrote:
> 
> On Sat, 4 Jun 2005, Jeff Garzik wrote:
> 
>>I'm surprised git doesn't fall back to GIT_COMMITTER_NAME if 
>>GIT_AUTHOR_NAME doesn't exist, though.
> 
> 
> GIT_AUTHOR_NAME existed first ;)
> 
> Btw, what does your /etc/passwd look like, and I'll try to hack it up to 
> just get that case right by default too..

ah, it looks like I forget the name when I was creating the account.

> [jgarzik@pretzel libata-dev]$ grep jgarzik /etc/passwd
> jgarzik:x:500:500::/g/g:/bin/bash

> [jgarzik@pretzel libata-dev]$ chfn
> Changing finger information for jgarzik.
> Password: 
> Name []: Jeff Garzik
> Office []: 
> Office Phone []: 
> Home Phone []: 
> 
> Finger information changed.

Fixed.  :)

In any case, I'll set GIT_AUTHOR_NAME in .bash_profile, to get my proper 
email addy rather than the local one.

	Jeff


