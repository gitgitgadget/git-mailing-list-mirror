From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: Make errors
Date: Sun, 8 May 2005 15:43:15 -0400 (EDT)
Message-ID: <Pine.LNX.4.21.0505081538110.30848-100000@iabervon.org>
References: <1115580904.5536.28.camel@linux.site>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun May 08 21:39:23 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DUrcG-0003qK-Lx
	for gcvg-git@gmane.org; Sun, 08 May 2005 21:39:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262979AbVEHTpM (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 8 May 2005 15:45:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262955AbVEHTod
	(ORCPT <rfc822;git-outgoing>); Sun, 8 May 2005 15:44:33 -0400
Received: from iabervon.org ([66.92.72.58]:4100 "EHLO iabervon.org")
	by vger.kernel.org with ESMTP id S262879AbVEHTnc (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 8 May 2005 15:43:32 -0400
Received: from barkalow (helo=localhost)
	by iabervon.org with local-esmtp (Exim 2.12 #2)
	id 1DUrgJ-0001Jp-00; Sun, 8 May 2005 15:43:15 -0400
To: John Kacur <jkacur@rogers.com>
In-Reply-To: <1115580904.5536.28.camel@linux.site>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Sun, 8 May 2005, John Kacur wrote:

> gcc -g -O2 -Wall '-DSHA1_HEADER=<openssl/sha.h>' -o git-http-pull
> http-pull.c libgit.a -lz -lssl -lcurl
> http-pull.c:10:23: curl/curl.h: No such file or directory
> http-pull.c:11:23: curl/easy.h: No such file or directory
> http-pull.c:13: error: parse error before '*' token

You need to either install libcurl or remove "git-http-pull" from PROGS in
the Makefile. libcurl provides the HTTP implementation used to download
heads hosted on websites.

	-Daniel
*This .sig left intentionally blank*

