From: David Kastrup <dak@gnu.org>
Subject: Re: git-svn and a nested branches folder
Date: Tue, 04 Sep 2007 16:46:10 +0200
Message-ID: <86veaqebf1.fsf@lola.quinscape.zz>
References: <46DD6EEA.9010304@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Sep 04 16:46:55 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ISZg5-000138-6v
	for gcvg-git@gmane.org; Tue, 04 Sep 2007 16:46:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754238AbXIDOqt (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 4 Sep 2007 10:46:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754194AbXIDOqs
	(ORCPT <rfc822;git-outgoing>); Tue, 4 Sep 2007 10:46:48 -0400
Received: from main.gmane.org ([80.91.229.2]:39927 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754186AbXIDOqs (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Sep 2007 10:46:48 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1ISZfl-00016L-SD
	for git@vger.kernel.org; Tue, 04 Sep 2007 16:46:34 +0200
Received: from pd95b0fdb.dip0.t-ipconnect.de ([217.91.15.219])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 04 Sep 2007 16:46:33 +0200
Received: from dak by pd95b0fdb.dip0.t-ipconnect.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 04 Sep 2007 16:46:33 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: pd95b0fdb.dip0.t-ipconnect.de
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1.50 (gnu/linux)
Cancel-Lock: sha1:lI0+rX7Mh3Lif1pzIt94+/73nvs=
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57584>

Russ Brown <pickscrape@gmail.com> writes:

> I'm having some trouble with using git-svn to fetch a repository, and I
> think it's because the repository doesn't store branches as a flat list
> directly under the 'branches' directory.
>
> Basically, we have a structure like this:
>
> |
> +-trunk
> +-tags
> +-branches
>   + category-a
>     + branch-a
>     + branch-b
>   + category-b
>     + branch-c
>     + branch-d
>
> etc. category-a and category-b are simple directories created using svn
> mkdir. The branches are created using svn cp.
>
> It helps us to organise the branches better, but the rationale is
> besides the point. The problem is that git-svn seems to want to
> treat category-a and category-b as branches, which isn't right at
> all. As a result, git-svn seems to skip most (if not all) revisions
> that occur in these directories and creates a lot of entries in
> unhandled.log.

So what did you specify in your .git/config file regarding the svn
structure?

-- 
David Kastrup
