From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Updated git HOWTO for kernel hackers
Date: Wed, 22 Jun 2005 18:53:06 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0506221850030.11175@ppc970.osdl.org>
References: <42B9E536.60704@pobox.com> <Pine.LNX.4.58.0506221603120.11175@ppc970.osdl.org>
 <42B9FF3A.4010700@pobox.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Linux Kernel <linux-kernel@vger.kernel.org>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Jun 23 03:50:59 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DlGrg-0002Ww-Nf
	for gcvg-git@gmane.org; Thu, 23 Jun 2005 03:50:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261987AbVFWByS (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 22 Jun 2005 21:54:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261976AbVFWByS
	(ORCPT <rfc822;git-outgoing>); Wed, 22 Jun 2005 21:54:18 -0400
Received: from smtp.osdl.org ([65.172.181.4]:25243 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261972AbVFWBvJ (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 22 Jun 2005 21:51:09 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j5N1p1jA011749
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Wed, 22 Jun 2005 18:51:01 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j5N1p0k9019315;
	Wed, 22 Jun 2005 18:51:00 -0700
To: Jeff Garzik <jgarzik@pobox.com>
In-Reply-To: <42B9FF3A.4010700@pobox.com>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.40__
X-MIMEDefang-Filter: osdl$Revision: 1.111 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Wed, 22 Jun 2005, Jeff Garzik wrote:
> 
> git-clone-script would indeed be nice, even if its only a 2-line script.

Ok, added. You can update your tutorial to make the initial setup of a 
kernel archive slightly less scary, ie it's now

	git clone rsync://rsync.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6.git linux-2.6
	cd linux-2.6
	git checkout

which looks almost user-friendly.

(Of course, since the rsync protocol doesn't know anything about git
consistency, if the mirroring is half-way, you'll end up with something
less than wonderful, and confusing. Details, details)

		Linus
