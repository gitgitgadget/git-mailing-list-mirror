From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Now What?
Date: Thu, 3 Nov 2005 09:27:05 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0511030926020.27915@g5.osdl.org>
References: <E1EXTw5-00063o-Gt@jdl.com> <20051103083840.GA28300@ebar091.ebar.dtu.dk>
 <7v4q6uhx0a.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0511031151070.25300@iabervon.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>,
	Peter Eriksen <s022018@student.dtu.dk>, git@vger.kernel.org,
	Jon Loeliger <jdl@freescale.com>
X-From: git-owner@vger.kernel.org Thu Nov 03 18:29:14 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EXis4-0001Rc-AI
	for gcvg-git@gmane.org; Thu, 03 Nov 2005 18:27:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751222AbVKCR1Z (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 3 Nov 2005 12:27:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751313AbVKCR1Z
	(ORCPT <rfc822;git-outgoing>); Thu, 3 Nov 2005 12:27:25 -0500
Received: from smtp.osdl.org ([65.172.181.4]:9954 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751222AbVKCR1Z (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 3 Nov 2005 12:27:25 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id jA3HR6W6003112
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Thu, 3 Nov 2005 09:27:06 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id jA3HR5k6018528;
	Thu, 3 Nov 2005 09:27:05 -0800
To: Daniel Barkalow <barkalow@iabervon.org>
In-Reply-To: <Pine.LNX.4.64.0511031151070.25300@iabervon.org>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.55__
X-MIMEDefang-Filter: osdl$Revision: 1.127 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11077>



On Thu, 3 Nov 2005, Daniel Barkalow wrote:
> 
> I think the situation is that he really wanted to update master, but 
> forgot that he was on the maint branch. So now he's in a merge of things 
> he didn't actually want to merge and wants to get back to not having junk 
> all over the place (some files that need to be merged, some files that 
> have been merged, new files, removed files, etc).

And that's exactly what "git reset --hard" is there for. It will reset to 
the old head of the branch you are on (ie HEAD), and get rid of everything 
that was done to the tree.

		Linus
