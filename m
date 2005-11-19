From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [RFC] Applying a graft to a tree and "rippling" the changes
 through
Date: Fri, 18 Nov 2005 17:07:38 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0511181705390.13959@g5.osdl.org>
References: <20051117230723.GD26122@nowhere.earth> <437DDDB1.60103@b-i-t.de>
 <Pine.LNX.4.64.0511180915560.13959@g5.osdl.org> <7v3bltea1t.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Nov 19 02:09:15 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EdHDF-0001yS-Qb
	for gcvg-git@gmane.org; Sat, 19 Nov 2005 02:08:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932144AbVKSBHv (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 18 Nov 2005 20:07:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932155AbVKSBHv
	(ORCPT <rfc822;git-outgoing>); Fri, 18 Nov 2005 20:07:51 -0500
Received: from smtp.osdl.org ([65.172.181.4]:35552 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751298AbVKSBHt (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 18 Nov 2005 20:07:49 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id jAJ17inO008727
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Fri, 18 Nov 2005 17:07:44 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id jAJ17c0M011367;
	Fri, 18 Nov 2005 17:07:42 -0800
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7v3bltea1t.fsf@assigned-by-dhcp.cox.net>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.55__
X-MIMEDefang-Filter: osdl$Revision: 1.127 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12314>



On Fri, 18 Nov 2005, Junio C Hamano wrote:
>
> At the same time, I am sympathetic if somebody wants to be able to say 
> just "The change this commit brings in can be used to modify the 
> behaviour X to Y".

Well, you can obviously use a commit that way, and indeed, every time we 
do a "rebase", that's effectively saying "I know the commit has history, 
but now I want to use it purely as a tree conversion".

I'm not convinced we ever really _need_ a pure "tree-to-tree" thing, 
although you can always do that by creating an extra commit with no parent 
and thus no history ;)

		Linus
