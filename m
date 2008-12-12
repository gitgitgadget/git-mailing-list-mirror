From: David Howells <dhowells@redhat.com>
Subject: Re: [PATCH] Simplified GIT usage guide
Date: Fri, 12 Dec 2008 19:12:13 +0000
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
Message-ID: <29095.1229109133@redhat.com>
References: <alpine.DEB.1.00.0812121952320.5873@eeepc-johanness> <20081212182827.28408.40963.stgit@warthog.procyon.org.uk>
Cc: dhowells@redhat.com, torvalds@osdl.org, git@vger.kernel.org,
	linux-kernel@vger.kernel.org, Miklos Vajna <vmiklos@frugalware.org>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Fri Dec 12 20:13:51 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LBDSN-0003sD-H3
	for gcvg-git-2@gmane.org; Fri, 12 Dec 2008 20:13:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751216AbYLLTM3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Dec 2008 14:12:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751060AbYLLTM3
	(ORCPT <rfc822;git-outgoing>); Fri, 12 Dec 2008 14:12:29 -0500
Received: from mx2.redhat.com ([66.187.237.31]:56829 "EHLO mx2.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750877AbYLLTM2 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Dec 2008 14:12:28 -0500
Received: from int-mx2.corp.redhat.com (int-mx2.corp.redhat.com [172.16.27.26])
	by mx2.redhat.com (8.13.8/8.13.8) with ESMTP id mBCJCFYu015257;
	Fri, 12 Dec 2008 14:12:15 -0500
Received: from ns3.rdu.redhat.com (ns3.rdu.redhat.com [10.11.255.199])
	by int-mx2.corp.redhat.com (8.13.1/8.13.1) with ESMTP id mBCJCEIK027753;
	Fri, 12 Dec 2008 14:12:14 -0500
Received: from warthog.cambridge.redhat.com (kibblesnbits.boston.devel.redhat.com [10.16.60.12])
	by ns3.rdu.redhat.com (8.13.8/8.13.8) with ESMTP id mBCJCDYI020077;
	Fri, 12 Dec 2008 14:12:13 -0500
Received: from [127.0.0.1] (helo=redhat.com)
	by warthog.cambridge.redhat.com with esmtp (Exim 4.68 #1 (Red Hat Linux))
	id 1LBDQr-0007ZI-AE; Fri, 12 Dec 2008 19:12:13 +0000
In-Reply-To: <alpine.DEB.1.00.0812121952320.5873@eeepc-johanness>
X-Scanned-By: MIMEDefang 2.58 on 172.16.27.26
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102929>

Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:

> > +I don't really know what I'm doing with GIT either.
> 
> Strike the "either".

The whole point of the introduction is that this is aimed at someone who
doesn't know what they're doing, so IMO the "either" is quite correct here.

> > +===============
> > +OVERVIEW OF GIT
> > +===============
> 
> Your overview seems to be what "Git from the bottom up" is all about (see 
> the Git Wiki for more information where to find it).

The problem is I need to describe some terminology, and the best way to do
that is with some pictures.  I was wondering if I should break this out into a
separate document and simplify what I keep.

In my opinion, it's much easier to deal with if you can visualise how it
works, even if that visualisation isn't a true representation of reality,
which references Miklos's points.

> From my experience with new users, this is exactly the wrong way to go 
> about it.  You don't introduce object types of the Git database before 
> telling the users what the heck they are good for.  And most users do not 
> need to bother with tree objects either, anyway.  So maybe you just tell 
> them what the heck the object types are good for, without even teaching 
> them the object types at all.

Perhaps.  The main thing I want to introduce is the idea of a tree with three
levels, as it were: commits, directories, files.

> So I think that your document might do a good job scaring people away from 
> Git.  But I do not believe that your document, especially in the tone it 
> is written, does a good job of helping Git newbies.

Hmmm.  So what would you suggest is a good way to write for GIT newbies?  Is
it just that the overview should be canned or drastically simplified?

David
