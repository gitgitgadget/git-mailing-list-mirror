From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: git --version
Date: Wed, 31 May 2006 12:23:50 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0605311222010.24646@g5.osdl.org>
References: <4d8e3fd30605301516l782ad81dk5b11074e88db90a4@mail.gmail.com> 
 <7vu077ywmw.fsf@assigned-by-dhcp.cox.net>  <4d8e3fd30605311158n9d669dgd6c392ee8d194b78@mail.gmail.com>
  <7vac8yypxc.fsf@assigned-by-dhcp.cox.net> <4d8e3fd30605311213m6f2f2660u90701ad6bd5daabc@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 31 21:24:26 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FlWIT-0000np-Vz
	for gcvg-git@gmane.org; Wed, 31 May 2006 21:24:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965109AbWEaTX7 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 31 May 2006 15:23:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965113AbWEaTX7
	(ORCPT <rfc822;git-outgoing>); Wed, 31 May 2006 15:23:59 -0400
Received: from smtp.osdl.org ([65.172.181.4]:14772 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S965109AbWEaTX6 (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 31 May 2006 15:23:58 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k4VJNp2g002534
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Wed, 31 May 2006 12:23:52 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k4VJNopO003251;
	Wed, 31 May 2006 12:23:51 -0700
To: Paolo Ciarrocchi <paolo.ciarrocchi@gmail.com>
In-Reply-To: <4d8e3fd30605311213m6f2f2660u90701ad6bd5daabc@mail.gmail.com>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.75__
X-MIMEDefang-Filter: osdl$Revision: 1.135 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21079>



On Wed, 31 May 2006, Paolo Ciarrocchi wrote:
> [...]
> install git gitk '/home/paolo/bin'

Why are you doing a "sudo" when you install in your own ~/bin (the default 
for git).

The whole point of installing in ~/bin is to not need any elevated 
priorities.

I get the feeling that you might have installed something in /usr/bin/ or 
/usr/local/bin earlier, and that they are before ~/bin in your PATH.

		Linus
