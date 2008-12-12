From: David Howells <dhowells@redhat.com>
Subject: Re: [PATCH] Simplified GIT usage guide
Date: Fri, 12 Dec 2008 19:02:41 +0000
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
Message-ID: <28996.1229108561@redhat.com>
References: <20081212185347.GK5691@genesis.frugalware.org> <20081212182827.28408.40963.stgit@warthog.procyon.org.uk>
Cc: dhowells@redhat.com, torvalds@osdl.org, git@vger.kernel.org,
	linux-kernel@vger.kernel.org
To: Miklos Vajna <vmiklos@frugalware.org>
X-From: git-owner@vger.kernel.org Fri Dec 12 20:04:48 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LBDJf-0000Ih-Iz
	for gcvg-git-2@gmane.org; Fri, 12 Dec 2008 20:04:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751183AbYLLTDZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Dec 2008 14:03:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750927AbYLLTDY
	(ORCPT <rfc822;git-outgoing>); Fri, 12 Dec 2008 14:03:24 -0500
Received: from mx2.redhat.com ([66.187.237.31]:54499 "EHLO mx2.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750761AbYLLTDX (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Dec 2008 14:03:23 -0500
Received: from int-mx2.corp.redhat.com (int-mx2.corp.redhat.com [172.16.27.26])
	by mx2.redhat.com (8.13.8/8.13.8) with ESMTP id mBCJ2iZb013408;
	Fri, 12 Dec 2008 14:02:44 -0500
Received: from ns3.rdu.redhat.com (ns3.rdu.redhat.com [10.11.255.199])
	by int-mx2.corp.redhat.com (8.13.1/8.13.1) with ESMTP id mBCJ2huv025590;
	Fri, 12 Dec 2008 14:02:43 -0500
Received: from warthog.cambridge.redhat.com (kibblesnbits.boston.devel.redhat.com [10.16.60.12])
	by ns3.rdu.redhat.com (8.13.8/8.13.8) with ESMTP id mBCJ2ffq018771;
	Fri, 12 Dec 2008 14:02:42 -0500
Received: from [127.0.0.1] (helo=redhat.com)
	by warthog.cambridge.redhat.com with esmtp (Exim 4.68 #1 (Red Hat Linux))
	id 1LBDHd-0007Xh-ME; Fri, 12 Dec 2008 19:02:41 +0000
In-Reply-To: <20081212185347.GK5691@genesis.frugalware.org>
X-Scanned-By: MIMEDefang 2.58 on 172.16.27.26
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102927>

Miklos Vajna <vmiklos@frugalware.org> wrote:

> This is incorrect, a 'blob' contains only the contents of the blob, the
> file mode is stored in the 'tree' object.

It seems I understand GIT's database less well than I thought.

> Is there any reason you hide the tag object?

What's a tag object?

> Using git clone --mirror would be much efficient, I think.

	warthog>man git-clone | grep mirror
	warthog1>

> Here and later below, IIRC -l is the default for local clones.

Okay.

> --bare implies -n.

Obvious.

> Why not using git stash and git stash pop?

I didn't know such existed.  That's why I want a crib sheet.

David
