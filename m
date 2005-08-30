From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Bisection visualization hint..
Date: Tue, 30 Aug 2005 11:17:55 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0508301116100.4237@g5.osdl.org>
References: <Pine.LNX.4.58.0508301026450.4293@g5.osdl.org>
 <7vhdd7joz6.fsf@assigned-by-dhcp.cox.net> <43149F79.4020809@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Aug 30 20:43:10 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EAAgR-0005F1-LH
	for gcvg-git@gmane.org; Tue, 30 Aug 2005 20:18:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932252AbVH3SSE (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 30 Aug 2005 14:18:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932256AbVH3SSE
	(ORCPT <rfc822;git-outgoing>); Tue, 30 Aug 2005 14:18:04 -0400
Received: from smtp.osdl.org ([65.172.181.4]:43973 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932252AbVH3SSD (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 30 Aug 2005 14:18:03 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j7UIHvjA020745
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Tue, 30 Aug 2005 11:17:57 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j7UIHtUd017398;
	Tue, 30 Aug 2005 11:17:56 -0700
To: A Large Angry SCM <gitzilla@gmail.com>
In-Reply-To: <43149F79.4020809@gmail.com>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.45__
X-MIMEDefang-Filter: osdl$Revision: 1.114 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/7960>



On Tue, 30 Aug 2005, A Large Angry SCM wrote:
> 
> Unless gitk will always be part of git, this is better off as a gitk 
> feature or gitk helper script. IE. it belongs in the gitk namespace, not 
> the git namespace.

I really think that gitk is pretty fundamental. If for no other reason 
than the big fact that it helps people understand what is going on. That's 
why it's mentioned in the tutorial - people who have only used something 
broken like CVS will have a hard time visualizing what's going on, I 
suspect, but with gitk it all looks simple.

		Linus
