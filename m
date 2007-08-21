From: David Kastrup <dak@gnu.org>
Subject: Re: Multiple branches and git-svn
Date: Tue, 21 Aug 2007 13:04:28 +0200
Message-ID: <861wdxgncz.fsf@lola.quinscape.zz>
References: <864pj16r10.fsf@lola.quinscape.zz> <9FD13095-36B5-4663-B658-082981B1ACD9@lrde.epita.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 21 13:04:52 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1INRXY-0005g6-DP
	for gcvg-git@gmane.org; Tue, 21 Aug 2007 13:04:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756008AbXHULEr (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 21 Aug 2007 07:04:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756002AbXHULEq
	(ORCPT <rfc822;git-outgoing>); Tue, 21 Aug 2007 07:04:46 -0400
Received: from main.gmane.org ([80.91.229.2]:54162 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755996AbXHULEq (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Aug 2007 07:04:46 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1INRXM-0006Gy-Rc
	for git@vger.kernel.org; Tue, 21 Aug 2007 13:04:40 +0200
Received: from pd95b0fdb.dip0.t-ipconnect.de ([217.91.15.219])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 21 Aug 2007 13:04:40 +0200
Received: from dak by pd95b0fdb.dip0.t-ipconnect.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 21 Aug 2007 13:04:40 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: pd95b0fdb.dip0.t-ipconnect.de
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1.50 (gnu/linux)
Cancel-Lock: sha1:fc+0e4DznFsHQTk0zcbZr5EN+zE=
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56289>

Benoit SIGOURE <tsuna@lrde.epita.fr> writes:

> On Aug 15, 2007, at 12:17 PM, David Kastrup wrote:
>
>>
>> After having had several embarrassing occurences with git-svn dcommit,
>> I think it would not be amiss to mention in the docs just how git-svn
>> happens to figure out which Subversion remote it is associated with.
>>
>> One surprising relevation was that this association changed after a
>> git-rebase.
>>
>> It may be a general git thing, or it may be git-svn specific, but it
>> was not exactly what I expected.  And the docs were not really that
>> helpful.
>>
>> In particular, man git-svn is completely silent about this.
>
> What I do usually is that I look in git log until I see a git-svn-id
> line:
> git-svn-id: https://svn.foo.com/svn/project/branches/bar@<rev-SVN>
> <Repository UUID>
> AFAIK git-svn dcommit will commit in the branch specified in the last
> git-svn-id.  I also dcommitted in the wrong branch after a rebase
> because I imported commits from another branch and the topmost commit
> in git-log was "pointing to" a different branch.

Sounds insane: apparently one result is that when you do a merge and
dcommit, the commit will go to the branch you merged.

The whole point of merging is to stay on one's current branch.

-- 
David Kastrup
