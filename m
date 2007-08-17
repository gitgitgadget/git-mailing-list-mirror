From: David Kastrup <dak@gnu.org>
Subject: How do I manage this setup with git-svn and/or git remotes?
Date: Fri, 17 Aug 2007 19:24:14 +0200
Message-ID: <86y7gaxef5.fsf@lola.quinscape.zz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 17 19:24:46 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IM5Yy-0007tO-RX
	for gcvg-git@gmane.org; Fri, 17 Aug 2007 19:24:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755753AbXHQRY3 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 17 Aug 2007 13:24:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754376AbXHQRY3
	(ORCPT <rfc822;git-outgoing>); Fri, 17 Aug 2007 13:24:29 -0400
Received: from main.gmane.org ([80.91.229.2]:38092 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753875AbXHQRY2 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 17 Aug 2007 13:24:28 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1IM5Yc-0005Rf-He
	for git@vger.kernel.org; Fri, 17 Aug 2007 19:24:22 +0200
Received: from pd95b0fdb.dip0.t-ipconnect.de ([217.91.15.219])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 17 Aug 2007 19:24:22 +0200
Received: from dak by pd95b0fdb.dip0.t-ipconnect.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 17 Aug 2007 19:24:22 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: pd95b0fdb.dip0.t-ipconnect.de
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1.50 (gnu/linux)
Cancel-Lock: sha1:LwlL6kIh2NqcuGc2KzrZVzA6maE=
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56072>


I have a Subversion repository which contains the following:

https://repo.here/svn/dsp/{trunk,tags,branches}
and
https://repo.here/svn/projects/great/{trunk/tags/branches}

I have those currently checked out into separate git repositories.
However,

https://repo.here/svn/projects/great/{trunk/tags/branches}

contain a subdirectory dsp that has been copied via Subversion from
the main dsp trunk.  Subsequently this copy and the original dsp have
progressed.

Now is there any chance to set up a git structure that will me allow
to let _git_ perform merges between the standalone dsp project and the
part that has started off as a copy of it in a subdirectory from
projects/great, so that I have a merge history in my git mirror?

Or is basically the only thing I can do to create selective patches
and apply them, thus not tracking the merges?

-- 
David Kastrup
