From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: gitk shows an empty line between "Comments" and changed files
Date: Fri, 28 Oct 2005 21:33:03 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0510282132120.3348@g5.osdl.org>
References: <1130434230.19641.21.camel@dv> <7vslum3l2w.fsf@assigned-by-dhcp.cox.net>
 <1130463389.2186.14.camel@dv> <7v4q72xavz.fsf@assigned-by-dhcp.cox.net>
 <1130539503.10531.43.camel@dv> <7vslul2g29.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.64.0510282003360.3348@g5.osdl.org> <20051029002357.iq88cg8gcsogk4kc@webmail.spamcop.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Oct 29 06:34:39 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EViP6-0006L8-CX
	for gcvg-git@gmane.org; Sat, 29 Oct 2005 06:33:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751142AbVJ2EdL (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 29 Oct 2005 00:33:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751138AbVJ2EdL
	(ORCPT <rfc822;git-outgoing>); Sat, 29 Oct 2005 00:33:11 -0400
Received: from smtp.osdl.org ([65.172.181.4]:655 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751142AbVJ2EdK (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 29 Oct 2005 00:33:10 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j9T4X4FC019775
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Fri, 28 Oct 2005 21:33:04 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j9T4X3Yc004073;
	Fri, 28 Oct 2005 21:33:03 -0700
To: Pavel Roskin <proski@gnu.org>
In-Reply-To: <20051029002357.iq88cg8gcsogk4kc@webmail.spamcop.net>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.55__
X-MIMEDefang-Filter: osdl$Revision: 1.127 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10792>



On Sat, 29 Oct 2005, Pavel Roskin wrote:
> 
> I understand the default behavior of git-diff-tree won't change, so I'll simply
> strip the first line.

Be careful, though. The merge case uses git-diff-tree differently, so I 
think there is no extra line for a merge. 

		Linus
