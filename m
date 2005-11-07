From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: Problem in update from the linux-2.6 repository
Date: Mon, 07 Nov 2005 23:18:51 +0100
Message-ID: <1131401931.5824.149.camel@blade>
References: <1131380293.5824.139.camel@blade>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Mon Nov 07 23:21:04 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EZFKY-0006PU-Nv
	for gcvg-git@gmane.org; Mon, 07 Nov 2005 23:19:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965479AbVKGWSs (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 7 Nov 2005 17:18:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965484AbVKGWSs
	(ORCPT <rfc822;git-outgoing>); Mon, 7 Nov 2005 17:18:48 -0500
Received: from coyote.holtmann.net ([217.160.111.169]:54418 "EHLO
	mail.holtmann.net") by vger.kernel.org with ESMTP id S965482AbVKGWSr
	(ORCPT <rfc822;git@vger.kernel.org>); Mon, 7 Nov 2005 17:18:47 -0500
Received: from blade (p5487DB86.dip.t-dialin.net [84.135.219.134])
	by mail.holtmann.net (8.12.3/8.12.3/Debian-7.1) with ESMTP id jA7MIuGB024792
	(version=TLSv1/SSLv3 cipher=RC4-MD5 bits=128 verify=NO)
	for <git@vger.kernel.org>; Mon, 7 Nov 2005 23:18:57 +0100
To: git@vger.kernel.org
In-Reply-To: <1131380293.5824.139.camel@blade>
X-Mailer: Evolution 2.5.1 
X-Virus-Scanned: ClamAV 0.85.1/1165/Sun Nov  6 06:12:58 2005 on coyote.holtmann.net
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11282>

Hi,

> I run into a weird problem when trying to update my clone of the
> linux-2.6 repository from Linus:
> 
> ---
> # cg-update -f
> 17:09:00 URL:http://www.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6.git/HEAD [41/41] -> "refs/heads/.origin-fetching" [1]
> Getting alternates list
> Getting pack list
> error: Unable to find 2ed5e6d09e266bd2288d49aaaf240ed8c468c13c under http://www.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6.git/
> 
> Cannot obtain needed object 2ed5e6d09e266bd2288d49aaaf240ed8c468c13c
> while processing commit 0000000000000000000000000000000000000000.
> cg-fetch: objects fetch failed
> ---

forget about this thing. The reason for this problem was the kernel.org
mirroring and the repository wasn't in a sane state. However it would be
great if we can detect this somehow.

Regards

Marcel
