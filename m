From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: git --version
Date: Wed, 31 May 2006 13:08:03 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0605311307250.24646@g5.osdl.org>
References: <4d8e3fd30605301516l782ad81dk5b11074e88db90a4@mail.gmail.com> 
 <4d8e3fd30605311158n9d669dgd6c392ee8d194b78@mail.gmail.com> 
 <7vac8yypxc.fsf@assigned-by-dhcp.cox.net>  <4d8e3fd30605311213m6f2f2660u90701ad6bd5daabc@mail.gmail.com>
  <4d8e3fd30605311220t17d319efyd5234dd4eb74fc96@mail.gmail.com> 
 <Pine.LNX.4.64.0605311224360.24646@g5.osdl.org> 
 <4d8e3fd30605311230h53981e57x8a417b176bedba86@mail.gmail.com> 
 <Pine.LNX.4.64.0605311233030.24646@g5.osdl.org> 
 <4d8e3fd30605311243q5a93a7a9l827c55827817602f@mail.gmail.com> 
 <4d8e3fd30605311249l6ba4ff74l72778ffe60462263@mail.gmail.com>
 <4d8e3fd30605311256o67e45d06ve0efeff65fcf4851@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 31 22:09:18 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FlWzJ-0001J3-LP
	for gcvg-git@gmane.org; Wed, 31 May 2006 22:08:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932479AbWEaUIP (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 31 May 2006 16:08:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932488AbWEaUIP
	(ORCPT <rfc822;git-outgoing>); Wed, 31 May 2006 16:08:15 -0400
Received: from smtp.osdl.org ([65.172.181.4]:60098 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932479AbWEaUIO (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 31 May 2006 16:08:14 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k4VK842g005130
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Wed, 31 May 2006 13:08:04 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k4VK83fm004618;
	Wed, 31 May 2006 13:08:03 -0700
To: Paolo Ciarrocchi <paolo.ciarrocchi@gmail.com>
In-Reply-To: <4d8e3fd30605311256o67e45d06ve0efeff65fcf4851@mail.gmail.com>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.75__
X-MIMEDefang-Filter: osdl$Revision: 1.135 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21089>



On Wed, 31 May 2006, Paolo Ciarrocchi wrote:
> 
> Thanks to loops on #git for asking me to do the following test:
> 
> <PaoloC> paolo@Italia:~/git$ sudo ./GIT-VERSION-GEN
> <PaoloC> GIT_VERSION = 1.3.GIT
> <PaoloC> paolo@Italia:~/git$ ./GIT-VERSION-GEN
> <PaoloC> GIT_VERSION = 1.3.3.g2186
> 
> I don't know why it's happening...

Heh. You don't have git in your PATH as root. So as root you don't know 
what version of git you have ;)

		Linus
