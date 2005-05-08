From: John Kacur <jkacur@rogers.com>
Subject: Re: Make errors
Date: Sun, 08 May 2005 15:57:40 -0400
Message-ID: <1115582260.5536.30.camel@linux.site>
References: <Pine.LNX.4.21.0505081538110.30848-100000@iabervon.org>
Reply-To: jkacur@rogers.com
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun May 08 22:32:03 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DUsQq-0002r6-6r
	for gcvg-git@gmane.org; Sun, 08 May 2005 22:31:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262879AbVEHUU2 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 8 May 2005 16:20:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262961AbVEHUUU
	(ORCPT <rfc822;git-outgoing>); Sun, 8 May 2005 16:20:20 -0400
Received: from smtp105.rog.mail.re2.yahoo.com ([206.190.36.83]:20904 "HELO
	smtp105.rog.mail.re2.yahoo.com") by vger.kernel.org with SMTP
	id S262879AbVEHT4Z (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 May 2005 15:56:25 -0400
Received: from unknown (HELO ?192.168.1.6?) (jkacur@65.48.213.144 with plain)
  by smtp105.rog.mail.re2.yahoo.com with SMTP; 8 May 2005 19:56:18 -0000
To: Daniel Barkalow <barkalow@iabervon.org>
In-Reply-To: <Pine.LNX.4.21.0505081538110.30848-100000@iabervon.org>
X-Mailer: Ximian Evolution 1.4.6 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Sun, 2005-05-08 at 15:43, Daniel Barkalow wrote:
> On Sun, 8 May 2005, John Kacur wrote:
> 
> > gcc -g -O2 -Wall '-DSHA1_HEADER=<openssl/sha.h>' -o git-http-pull
> > http-pull.c libgit.a -lz -lssl -lcurl
> > http-pull.c:10:23: curl/curl.h: No such file or directory
> > http-pull.c:11:23: curl/easy.h: No such file or directory
> > http-pull.c:13: error: parse error before '*' token
> 
> You need to either install libcurl or remove "git-http-pull" from PROGS in
> the Makefile. libcurl provides the HTTP implementation used to download
> heads hosted on websites.
> 
> 	-Daniel
> *This .sig left intentionally blank*
> 

Thank you, indeed it compiled fine after installing the curl-devel rpm

