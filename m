From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH gitweb] Visually indicating patch size with horizontal
 bars
Date: Fri, 28 Oct 2005 09:02:28 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0510280901410.4664@g5.osdl.org>
References: <20051027203945.GC1622@pe.Belkin> <7vfyqm1uvx.fsf@assigned-by-dhcp.cox.net>
 <46a038f90510271816i26389d5cqe136f515007ca057@mail.gmail.com>
 <Pine.LNX.4.64.0510271933140.4664@g5.osdl.org> <7vr7a6z4bc.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Martin Langhoff <martin.langhoff@gmail.com>,
	Chris Shoemaker <c.shoemaker@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Oct 28 18:05:36 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EVWh5-0007tP-UE
	for gcvg-git@gmane.org; Fri, 28 Oct 2005 18:03:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030230AbVJ1QCn (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 28 Oct 2005 12:02:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030234AbVJ1QCn
	(ORCPT <rfc822;git-outgoing>); Fri, 28 Oct 2005 12:02:43 -0400
Received: from smtp.osdl.org ([65.172.181.4]:29115 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1030230AbVJ1QCm (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 28 Oct 2005 12:02:42 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j9SG2TFC015012
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Fri, 28 Oct 2005 09:02:29 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j9SG2Sl7002929;
	Fri, 28 Oct 2005 09:02:28 -0700
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vr7a6z4bc.fsf@assigned-by-dhcp.cox.net>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.55__
X-MIMEDefang-Filter: osdl$Revision: 1.127 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10767>



On Thu, 27 Oct 2005, Junio C Hamano wrote:
>
> Linus Torvalds <torvalds@osdl.org> writes:
> 
> > Well, if you do full copy detection (and break detection), then 
> > git-diff-tree will actually have effectively calculated the size of the 
> > diff of each file. It just doesn't print them (well, it does a percentage 
> > for the renames/copies).
> 
> Unbroken in-place edit would never go through diffcore-rename,
> so that is a gross overstatement.

Well, the break detection will have _calculated_ the diff size.

The point being that all the work has been done - it's just not printed 
out.

		Linus
