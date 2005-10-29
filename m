From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: Problem with cg-clone
Date: Sat, 29 Oct 2005 22:10:53 +0200
Message-ID: <1130616653.5396.56.camel@blade>
References: <1130605726.5396.39.camel@blade>
	 <7vwtjwytzw.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Oct 29 22:15:15 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EVx2l-0001O8-VP
	for gcvg-git@gmane.org; Sat, 29 Oct 2005 22:11:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932212AbVJ2ULA (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 29 Oct 2005 16:11:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932625AbVJ2UK6
	(ORCPT <rfc822;git-outgoing>); Sat, 29 Oct 2005 16:10:58 -0400
Received: from coyote.holtmann.net ([217.160.111.169]:8073 "EHLO
	mail.holtmann.net") by vger.kernel.org with ESMTP id S932603AbVJ2UK4
	(ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 29 Oct 2005 16:10:56 -0400
Received: from blade (p5487F34C.dip.t-dialin.net [84.135.243.76])
	by mail.holtmann.net (8.12.3/8.12.3/Debian-7.1) with ESMTP id j9TKB0GB031869
	(version=TLSv1/SSLv3 cipher=RC4-MD5 bits=128 verify=NO);
	Sat, 29 Oct 2005 22:11:01 +0200
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vwtjwytzw.fsf@assigned-by-dhcp.cox.net>
X-Mailer: Evolution 2.4.1 
X-Virus-Scanned: ClamAV 0.85.1/1149/Thu Oct 27 22:20:09 2005 on coyote.holtmann.net
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10806>

Hi Junio,

> > I installed the latest git and cogito from their repositories and now
> > the local clone command is failing:
> >
> > # cg-clone linux-2.6 test-2.6
> > defaulting to local storage area
> > Using hard links
> > `/data/kernel/linux-2.6/.git/HEAD' -> `.git/refs/heads/.origin-fetching'
> > error: Couldn't find 8a212ab6b8a4ccc6f3c3d1beba5f92655c576404: not separate or in any pack
> > Cannot obtain needed object 8a212ab6b8a4ccc6f3c3d1beba5f92655c576404
> > while processing commit 0000000000000000000000000000000000000000.
> > cg-fetch: objects fetch failed
> > cg-clone: fetch failed
> 
> The attached patch should fix git-local-fetch which I think the
> above problem is.  git-clone -l -s would be much faster if you
> are doing a local clone, however.

I can confirm that with this patch everything is back to normal.

Regards

Marcel
