From: tom fogal <tfogal@alumni.unh.edu>
Subject: sharing git work while downstream from svn?
Date: Tue, 11 Aug 2009 16:55:15 -0600
Message-ID: <auto-000020209577@sci.utah.edu>
Reply-To: tfogal@sci.utah.edu
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 12 00:53:20 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mb0DX-0000Sx-MA
	for gcvg-git-2@gmane.org; Wed, 12 Aug 2009 00:53:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755525AbZHKWxJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Aug 2009 18:53:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754622AbZHKWxI
	(ORCPT <rfc822;git-outgoing>); Tue, 11 Aug 2009 18:53:08 -0400
Received: from mail.sci.utah.edu ([155.98.58.79]:42314 "EHLO sci.utah.edu"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1754470AbZHKWxI (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Aug 2009 18:53:08 -0400
Received: from dummy.name; Tue, 11 Aug 2009 16:53:07 -0600
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125611>

How do others manage distributed version control when everyone is
forced to rebase all the time?

To give a concrete example: in one project where I have this issue,
there's a developer who is effectively 'downstream' from me.  There's
a few other developers who are peers, w/ commit bits set on the
centralized server.  I'll make some patches that should end up on our
centralized trunk, and some that our for our experimental sub-project,
so I use format-patch and send patches around for those.

This gets to be a mess when trunk changes: I'll rebase + potentially
fix some conflicts.  Other developers with some of the experimental
patches will svn update, and get similar conflicts.  These might differ
in subtle ways, and now exchanging patches gets more difficult.

I'm not sure getting them to use git would even help.  Once I rebase,
I screw my downstream.  Yet I can't avoid rebasing since I need to
update.

As I recall, some members of the gcc community are handling this
problem, somehow.  How do you do it?  Or do you just not collaborate at
the git level?

Thanks,

-tom
