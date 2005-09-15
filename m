From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: "Read my lips: no more merges" - aka Linux 2.6.14-rc1
Date: Wed, 14 Sep 2005 20:21:33 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0509142018410.26803@g5.osdl.org>
References: <7255.1126583985@kao2.melbourne.sgi.com> 
 <1126674993.5681.9.camel@localhost.localdomain> <1126745323.7199.3.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Sep 15 05:23:08 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EFkJl-00075w-BQ
	for gcvg-git@gmane.org; Thu, 15 Sep 2005 05:21:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750891AbVIODVm (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 14 Sep 2005 23:21:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750896AbVIODVm
	(ORCPT <rfc822;git-outgoing>); Wed, 14 Sep 2005 23:21:42 -0400
Received: from smtp.osdl.org ([65.172.181.4]:30178 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750891AbVIODVm (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 14 Sep 2005 23:21:42 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j8F3LaBo011326
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Wed, 14 Sep 2005 20:21:37 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j8F3LXie010738;
	Wed, 14 Sep 2005 20:21:34 -0700
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <1126745323.7199.3.camel@localhost.localdomain>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.45__
X-MIMEDefang-Filter: osdl$Revision: 1.115 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8581>



On Wed, 14 Sep 2005, Alejandro Bonilla Beeche wrote:
> 
> debian:~# cd linux-2.6/
> debian:~/linux-2.6# git log
> /usr/local/bin/git-log-script: line 4: less: command not found

A very strange Linux installation that doesn't come with "less"...

What a strange box. Anyway, that does point out that maybe the git RPM 
spec should have "less" as a dependency. 

		Linus
