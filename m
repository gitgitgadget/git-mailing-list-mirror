From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH] Rename git-config-set to git-repo-config
Date: Fri, 25 Nov 2005 20:07:29 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0511252006050.13959@g5.osdl.org>
References: <Pine.LNX.4.63.0511201748440.14258@wbgn013.biozentrum.uni-wuerzburg.de>
 <200511210026.30280.Josef.Weidendorfer@gmx.de> <200511221831.03954.Josef.Weidendorfer@gmx.de>
 <Pine.LNX.4.63.0511221854120.27872@wbgn013.biozentrum.uni-wuerzburg.de>
 <438371E8.2030701@op5.se> <Pine.LNX.4.63.0511231553390.8191@wbgn013.biozentrum.uni-wuerzburg.de>
 <7viruj3q7z.fsf@assigned-by-dhcp.cox.net> <4384FB61.40506@op5.se>
 <Pine.LNX.4.63.0511240042350.11106@wbgn013.biozentrum.uni-wuerzburg.de>
 <43857430.7060103@op5.se> <7vsltmwiky.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.63.0511241127020.12985@wbgn013.biozentrum.uni-wuerzburg.de>
 <7v8xveth4l.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.63.0511241419390.14297@wbgn013.biozentrum.uni-wuerzburg.de>
 <7vmzjtn3h1.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.63.0511242252080.26485@wbgn013.biozentrum.uni-wuerzburg.de>
 <7vy83cdu7r.fsf@assigned-by-dhcp.co
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Nov 26 05:08:36 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EfrLr-0005bj-EY
	for gcvg-git@gmane.org; Sat, 26 Nov 2005 05:07:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932718AbVKZEHi (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 25 Nov 2005 23:07:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932719AbVKZEHi
	(ORCPT <rfc822;git-outgoing>); Fri, 25 Nov 2005 23:07:38 -0500
Received: from smtp.osdl.org ([65.172.181.4]:7296 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932718AbVKZEHh (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 25 Nov 2005 23:07:37 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id jAQ47UnO000855
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Fri, 25 Nov 2005 20:07:30 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id jAQ47Thw027214;
	Fri, 25 Nov 2005 20:07:29 -0800
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <Pine.LNX.4.64.0511251953081.13959@g5.osdl.org>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.56__
X-MIMEDefang-Filter: osdl$Revision: 1.127 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12766>



On Fri, 25 Nov 2005, Linus Torvalds wrote:
> 
> In fact, I'd prefer if _every_ command just did the right thing inside a 
> subdirectory. 

Side note: the thing I like best about the patch I just sent out is that 
it also makes things automagically work when you're inside the ".git" 
directory. So you should be able to do a "git log" inside a "raw" archive 
without setting GIT_DIR=. explicitly.

			Linus
