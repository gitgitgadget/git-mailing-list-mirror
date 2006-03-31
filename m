From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH/RFC 2/2] Make path-limiting be incremental when possible.
Date: Fri, 31 Mar 2006 12:50:47 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0603311249550.27203@g5.osdl.org>
References: <Pine.LNX.4.64.0603301648530.27203@g5.osdl.org>
 <Pine.LNX.4.64.0603301652531.27203@g5.osdl.org> <Pine.LNX.4.64.0603302153350.27203@g5.osdl.org>
 <7v3bgzxgbg.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0603311135290.27203@g5.osdl.org>
 <7vfykyuzc2.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Mar 31 22:51:07 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FPQa9-00082A-6Z
	for gcvg-git@gmane.org; Fri, 31 Mar 2006 22:50:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932154AbWCaUux (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 31 Mar 2006 15:50:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932223AbWCaUux
	(ORCPT <rfc822;git-outgoing>); Fri, 31 Mar 2006 15:50:53 -0500
Received: from smtp.osdl.org ([65.172.181.4]:40581 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932154AbWCaUuw (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 31 Mar 2006 15:50:52 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k2VKomEX018711
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Fri, 31 Mar 2006 12:50:49 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k2VKolHm003415;
	Fri, 31 Mar 2006 12:50:48 -0800
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vfykyuzc2.fsf@assigned-by-dhcp.cox.net>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.72__
X-MIMEDefang-Filter: osdl$Revision: 1.133 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18232>



On Fri, 31 Mar 2006, Junio C Hamano wrote:
> 
> Yes, that is exactly the fix I have in "pu" -- I suspect you
> replied before getting to my response last night.

No, I just get too much email, and hadn't read your response carefully 
enough, so I just missed the fact that you had already found the problem. 

			Linus
