From: David Howells <dhowells@redhat.com>
Subject: Re: [PATCH] Simplified GIT usage guide
Date: Sat, 13 Dec 2008 01:12:56 +0000
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
Message-ID: <32096.1229130776@redhat.com>
References: <20081212190900.GL5691@genesis.frugalware.org> <20081212185347.GK5691@genesis.frugalware.org> <20081212182827.28408.40963.stgit@warthog.procyon.org.uk> <28996.1229108561@redhat.com>
Cc: dhowells@redhat.com, torvalds@osdl.org, git@vger.kernel.org,
	linux-kernel@vger.kernel.org
To: Miklos Vajna <vmiklos@frugalware.org>
X-From: git-owner@vger.kernel.org Sat Dec 13 02:14:58 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LBJ5s-0001nq-NU
	for gcvg-git-2@gmane.org; Sat, 13 Dec 2008 02:14:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753328AbYLMBNj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Dec 2008 20:13:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753166AbYLMBNj
	(ORCPT <rfc822;git-outgoing>); Fri, 12 Dec 2008 20:13:39 -0500
Received: from mx2.redhat.com ([66.187.237.31]:59053 "EHLO mx2.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752778AbYLMBNi (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Dec 2008 20:13:38 -0500
Received: from int-mx2.corp.redhat.com (int-mx2.corp.redhat.com [172.16.27.26])
	by mx2.redhat.com (8.13.8/8.13.8) with ESMTP id mBD1CxSN005869;
	Fri, 12 Dec 2008 20:12:59 -0500
Received: from ns3.rdu.redhat.com (ns3.rdu.redhat.com [10.11.255.199])
	by int-mx2.corp.redhat.com (8.13.1/8.13.1) with ESMTP id mBD1Cvuu031021;
	Fri, 12 Dec 2008 20:12:58 -0500
Received: from warthog.cambridge.redhat.com (kibblesnbits.boston.devel.redhat.com [10.16.60.12])
	by ns3.rdu.redhat.com (8.13.8/8.13.8) with ESMTP id mBD1Cue3024835;
	Fri, 12 Dec 2008 20:12:57 -0500
Received: from [127.0.0.1] (helo=redhat.com)
	by warthog.cambridge.redhat.com with esmtp (Exim 4.68 #1 (Red Hat Linux))
	id 1LBJ3w-0008Lh-Kd; Sat, 13 Dec 2008 01:12:56 +0000
In-Reply-To: <20081212190900.GL5691@genesis.frugalware.org>
X-Scanned-By: MIMEDefang 2.58 on 172.16.27.26
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102974>

Miklos Vajna <vmiklos@frugalware.org> wrote:

> > > Is there any reason you hide the tag object?
> > 
> > What's a tag object?
> 
> http://www.kernel.org/pub/software/scm/git/docs/gitglossary.html#def_tag_object

Okay.  I do mention tags.  How they're stored in the database is irrelevant.
As far as most users need be concerned, a tag is a symbolic representation of
a particular commit in the tree; a particular state of the source tree.

Think of symbolic links as an analogy.  Most users just need to know that a
symlink represents the location of another part of the VFS tree; actually most
users will just think of them as a pointer to the name of a file, if even that
much.  The fact that, say, ReiserFS tail packs them because they tend to be
small, or that AFS symlinks have weird properties that encode mountpoints is
irrelevant to most users.  You don't need to know that to use them.

Yes, GIT's database has blob objects, tree objects, commit objects and tag
objects; but as far as the normal user is concerned, it stores files, lists of
files (directories or, more probably, folders), commits and tags.  The
physical low-level stuff is completely irrelevant.

There is one exception to that: commit IDs.  These are public-facing as it
were.  GIT waves them in your face, and you have to use them occasionally, so
it's useful to say a bit about them.

David
