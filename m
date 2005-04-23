From: Thomas Glanzmann <sithglan@stud.uni-erlangen.de>
Subject: Re: Git-commits mailing list feed.
Date: Sat, 23 Apr 2005 21:02:57 +0200
Message-ID: <20050423190257.GA4194@cip.informatik.uni-erlangen.de>
References: <200504210422.j3L4Mo8L021495@hera.kernel.org> <42674724.90005@ppp0.net> <20050422002922.GB6829@kroah.com> <426A4669.7080500@ppp0.net> <1114266083.3419.40.camel@localhost.localdomain> <426A5BFC.1020507@ppp0.net> <1114266907.3419.43.camel@localhost.localdomain> <Pine.LNX.4.58.0504231010580.2344@ppc970.osdl.org> <2646.10.10.10.24.1114278656.squirrel@linux1>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@osdl.org>,
	David Woodhouse <dwmw2@infradead.org>,
	Jan Dittmer <jdittmer@ppp0.net>, Greg KH <greg@kroah.com>,
	Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Apr 23 21:06:06 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DPPx7-0006Oz-Fm
	for gcvg-git@gmane.org; Sat, 23 Apr 2005 21:06:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261726AbVDWTKn (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 23 Apr 2005 15:10:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261714AbVDWTKn
	(ORCPT <rfc822;git-outgoing>); Sat, 23 Apr 2005 15:10:43 -0400
Received: from faui03.informatik.uni-erlangen.de ([131.188.30.103]:8922 "EHLO
	faui03.informatik.uni-erlangen.de") by vger.kernel.org with ESMTP
	id S261711AbVDWTKh (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 23 Apr 2005 15:10:37 -0400
Received: from faui03.informatik.uni-erlangen.de (faui03.informatik.uni-erlangen.de [131.188.30.103])
	by faui03.informatik.uni-erlangen.de (8.12.9/8.12.9) with ESMTP id j3NJ2vS8007532
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Sat, 23 Apr 2005 19:02:57 GMT
Received: (from sithglan@localhost)
	by faui03.informatik.uni-erlangen.de (8.12.9/8.12.9) id j3NJ2vb7007531;
	Sat, 23 Apr 2005 21:02:57 +0200 (CEST)
To: Sean <seanlkml@sympatico.ca>
Mail-Followup-To: Sean <seanlkml@sympatico.ca>,
	Linus Torvalds <torvalds@osdl.org>,
	David Woodhouse <dwmw2@infradead.org>,
	Jan Dittmer <jdittmer@ppp0.net>, Greg KH <greg@kroah.com>,
	Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Git Mailing List <git@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <2646.10.10.10.24.1114278656.squirrel@linux1>
X-URL: http://wwwcip.informatik.uni-erlangen.de/~sithglan/
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Hello,

> Why not leave tags open to being signed or unsigned?

I think that this is the idea anyway.

> For presentation in the log or whatever, the script can look inside the
> clear text message, grab the SHA1 and display it in the header area; even
> though it's not really in the header, always just in the clear text area.

Having the SHA1 signature twice in would be confusing and error-prone
when checking is done automated.

So establishing the infrastructure is a good thing. To use it for every
commit is another issue.

	Thomas
