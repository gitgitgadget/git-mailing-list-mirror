From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: git --version
Date: Wed, 31 May 2006 12:25:28 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0605311224360.24646@g5.osdl.org>
References: <4d8e3fd30605301516l782ad81dk5b11074e88db90a4@mail.gmail.com> 
 <7vu077ywmw.fsf@assigned-by-dhcp.cox.net>  <4d8e3fd30605311158n9d669dgd6c392ee8d194b78@mail.gmail.com>
  <7vac8yypxc.fsf@assigned-by-dhcp.cox.net> 
 <4d8e3fd30605311213m6f2f2660u90701ad6bd5daabc@mail.gmail.com>
 <4d8e3fd30605311220t17d319efyd5234dd4eb74fc96@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 31 21:25:49 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FlWK8-00017v-3z
	for gcvg-git@gmane.org; Wed, 31 May 2006 21:25:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965114AbWEaTZk (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 31 May 2006 15:25:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965116AbWEaTZk
	(ORCPT <rfc822;git-outgoing>); Wed, 31 May 2006 15:25:40 -0400
Received: from smtp.osdl.org ([65.172.181.4]:43444 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S965114AbWEaTZk (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 31 May 2006 15:25:40 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k4VJPY2g002622
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Wed, 31 May 2006 12:25:34 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k4VJPSAG003309;
	Wed, 31 May 2006 12:25:30 -0700
To: Paolo Ciarrocchi <paolo.ciarrocchi@gmail.com>
In-Reply-To: <4d8e3fd30605311220t17d319efyd5234dd4eb74fc96@mail.gmail.com>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.75__
X-MIMEDefang-Filter: osdl$Revision: 1.135 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21080>



On Wed, 31 May 2006, Paolo Ciarrocchi wrote:
> 
> Tried with:
> make clean
> make && sudo make install
> [...]
> paolo@Italia:~/git$ git --version
> git version 1.3.GIT
> paolo@Italia:~/git$ ./GIT-VERSION-GEN
> GIT_VERSION = 1.3.3.g2186

What does

	git describe
	./git --version
	which git

say?

		Linus
