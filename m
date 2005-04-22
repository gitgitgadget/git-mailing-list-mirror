From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: Mozilla SHA1 implementation
Date: Fri, 22 Apr 2005 16:29:45 -0400 (EDT)
Message-ID: <Pine.LNX.4.21.0504221625070.30848-100000@iabervon.org>
References: <Pine.LNX.4.58.0504220824480.2344@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Paul Mackerras <paulus@samba.org>, Edgar Toernig <froese@gmx.de>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Apr 22 22:26:39 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DP4iD-00017F-W0
	for gcvg-git@gmane.org; Fri, 22 Apr 2005 22:25:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262121AbVDVU3v (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 22 Apr 2005 16:29:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262123AbVDVU3v
	(ORCPT <rfc822;git-outgoing>); Fri, 22 Apr 2005 16:29:51 -0400
Received: from iabervon.org ([66.92.72.58]:19974 "EHLO iabervon.org")
	by vger.kernel.org with ESMTP id S262121AbVDVU3t (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 22 Apr 2005 16:29:49 -0400
Received: from barkalow (helo=localhost)
	by iabervon.org with local-esmtp (Exim 2.12 #2)
	id 1DP4mX-0007bQ-00; Fri, 22 Apr 2005 16:29:45 -0400
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0504220824480.2344@ppc970.osdl.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Fri, 22 Apr 2005, Linus Torvalds wrote:

> But it's more likely the precompiled libssl. I'm not compiling the openssl
> thing myself, but just using the standard 0.9.7a version that comes with
> YDL. Which, btw, causes all of 
> 
> 	/lib/libcrypto.so.4

This is the one that actually has the SHA1 stuff, not libssl at all. You
can skip at least some of this by just using -lcrypto.

> 	/usr/lib/libgssapi_krb5.so.2
> 	/usr/lib/libkrb5.so.3
> 	/lib/libcom_err.so.2
> 	/usr/lib/libk5crypto.so.3
> 	/lib/libresolv.so.2
> 	/lib/libdl.so.2

	-Daniel
*This .sig left intentionally blank*

