From: David Kastrup <dak@gnu.org>
Subject: Re: "svn switch" equivalent when using git-svn -- git-filter-branch?
Date: Tue, 10 Jul 2007 10:24:06 +0200
Message-ID: <86ejjgzmxl.fsf@lola.quinscape.zz>
References: <86sl7x7nzq.fsf@lola.quinscape.zz> <20070710054038.GA17675@muzzle>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 10 10:24:36 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I8B1P-0006r7-9P
	for gcvg-git@gmane.org; Tue, 10 Jul 2007 10:24:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760955AbXGJIYZ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 10 Jul 2007 04:24:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759221AbXGJIYX
	(ORCPT <rfc822;git-outgoing>); Tue, 10 Jul 2007 04:24:23 -0400
Received: from main.gmane.org ([80.91.229.2]:46821 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758173AbXGJIYV (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Jul 2007 04:24:21 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1I8B14-0006Xk-Br
	for git@vger.kernel.org; Tue, 10 Jul 2007 10:24:14 +0200
Received: from pd95b0fdb.dip0.t-ipconnect.de ([217.91.15.219])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 10 Jul 2007 10:24:14 +0200
Received: from dak by pd95b0fdb.dip0.t-ipconnect.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 10 Jul 2007 10:24:14 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: pd95b0fdb.dip0.t-ipconnect.de
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/23.0.51 (gnu/linux)
Cancel-Lock: sha1:M5Mp+PEOWmyj7hY9RZc9EDLyFq4=
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52054>

Eric Wong <normalperson@yhbt.net> writes:

> David Kastrup <dak@gnu.org> wrote:
>> Hi,
>> 
>> an upstream svn repository that I access with git-svn has moved.  I
>> seem to be too stupid to use git-filter-branch and/or .git/config
>> and/or git-reset to make my git mirror follow the switch.
>
> Just changing the url key in the [svn-remote] section of the .git/config
> file should be enough.
>
> You'll probably need to fetch at least one revision from the new URL
> before being able to dcommit, though.

git-fetch works, but git-rebase -l still complains:

git-svn rebase -l
Unable to determine upstream SVN information from working tree history

And consequently I can't actually update.

-- 
David Kastrup
