From: Jon Loeliger <jdl@jdl.com>
Subject: Re: git daemon directory munging?
Date: Sun, 04 Jun 2006 21:10:07 -0500
Message-ID: <E1Fn4Xf-0000bL-82@jdl.com>
X-From: git-owner@vger.kernel.org Mon Jun 05 04:10:15 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fn4Xl-0000yZ-F8
	for gcvg-git@gmane.org; Mon, 05 Jun 2006 04:10:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932382AbWFECKK (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 4 Jun 2006 22:10:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932383AbWFECKJ
	(ORCPT <rfc822;git-outgoing>); Sun, 4 Jun 2006 22:10:09 -0400
Received: from mail.jdl.com ([66.118.10.122]:46569 "EHLO jdl.com")
	by vger.kernel.org with ESMTP id S932382AbWFECKJ (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 4 Jun 2006 22:10:09 -0400
Received: from jdl (helo=jdl.com)
	by jdl.com with local-esmtp (Exim 4.44)
	id 1Fn4Xf-0000bL-82
	for git@vger.kernel.org; Sun, 04 Jun 2006 21:10:08 -0500
To: git@vger.kernel.org
In-Reply-To: 44836803.5070405@zytor.com
X-Spam-Score: -5.9 (-----)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21306>


> Well, you can bind different git daemons to different IP addresses 
> (IP-based vhosting) or different ports (with SRV records in DNS.)

Is there existing support for telling the git-daemon what
specific IP to bind to out of an inetd setup and I just
missed it?

I could set that up realatively easily and gain the 
functionality I wanted that way too.

I've also hacked in a host interpolation too.

But like you said, canonicalizing it and checking it is likely
a bit of a pain.  I've side-stepped one angle of that by
symlinking in my /pub directory for multiple different
hostnames too.  :-)

jdl
