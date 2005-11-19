From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [RFC] Applying a graft to a tree and "rippling" the changes
 through
Date: Fri, 18 Nov 2005 17:29:27 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0511181728160.13959@g5.osdl.org>
References: <20051117230723.GD26122@nowhere.earth> <437DDDB1.60103@b-i-t.de>
 <Pine.LNX.4.64.0511180915560.13959@g5.osdl.org> <7v3bltea1t.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.64.0511181705390.13959@g5.osdl.org> <7vr79dcu0j.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Nov 19 02:30:04 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EdHXx-0007La-FZ
	for gcvg-git@gmane.org; Sat, 19 Nov 2005 02:29:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161098AbVKSB3i (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 18 Nov 2005 20:29:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030271AbVKSB3i
	(ORCPT <rfc822;git-outgoing>); Fri, 18 Nov 2005 20:29:38 -0500
Received: from smtp.osdl.org ([65.172.181.4]:484 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1030266AbVKSB3i (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 18 Nov 2005 20:29:38 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id jAJ1TWnO009492
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Fri, 18 Nov 2005 17:29:32 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id jAJ1TSxb012050;
	Fri, 18 Nov 2005 17:29:30 -0800
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vr79dcu0j.fsf@assigned-by-dhcp.cox.net>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.55__
X-MIMEDefang-Filter: osdl$Revision: 1.127 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12318>



On Fri, 18 Nov 2005, Junio C Hamano wrote:
> 
> Nah, it is more like a commit object that records its tree and
> another tree as its parent ;-).

I don't think fsck would allow that. At least it wasn't _meant_ to allow 
it, and it should complain about an object having the wrong type.

And I'd hope that "git-commit-tree" would refuse to write such a thing.

		Linus
