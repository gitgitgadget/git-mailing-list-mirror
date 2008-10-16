From: David Kastrup <dak@gnu.org>
Subject: Re: Rebasing Multiple branches at once...
Date: Thu, 16 Oct 2008 15:59:17 +0200
Message-ID: <8663nsfxoq.fsf@lola.quinscape.zz>
References: <48F730D0.9040008@calicojack.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Oct 16 16:00:43 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KqTP8-0004Xu-0Z
	for gcvg-git-2@gmane.org; Thu, 16 Oct 2008 16:00:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753434AbYJPN73 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 16 Oct 2008 09:59:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753394AbYJPN73
	(ORCPT <rfc822;git-outgoing>); Thu, 16 Oct 2008 09:59:29 -0400
Received: from main.gmane.org ([80.91.229.2]:55822 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753230AbYJPN72 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Oct 2008 09:59:28 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1KqTNr-0005De-U9
	for git@vger.kernel.org; Thu, 16 Oct 2008 13:59:24 +0000
Received: from pd95b0fdb.dip0.t-ipconnect.de ([217.91.15.219])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 16 Oct 2008 13:59:23 +0000
Received: from dak by pd95b0fdb.dip0.t-ipconnect.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 16 Oct 2008 13:59:23 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: pd95b0fdb.dip0.t-ipconnect.de
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.0.60 (gnu/linux)
Cancel-Lock: sha1:RZJLGm7D8SReOahPUU19MnKROiE=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98383>

Rick Moynihan <rick@calicojack.co.uk> writes:

> Hi,
>
> I have a master branch, a dev branch and a number of feature branches
> from dev.  And I was wondering if there was an easy way to rebase dev
> and all of it's sub-branches onto master.
>
> I know I can run this as a series of commands, and use --onto to do
> this, but was wondering if there was an easier way.  As running:
>
> git rebase master
>
> when on the dev branch only rebases dev and not it's dependent branches.

Rebasing has no relation to dependent branches.  It creates a new branch
from the branch point.  After it finishes, it just reseats HEAD of the
branch to the new one.  There is no operation that would work implicitly
on originally dependent branches.

-- 
David Kastrup
