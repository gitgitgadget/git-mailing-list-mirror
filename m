From: David Kastrup <dak@gnu.org>
Subject: Re: [PATCH] git-svn: update documentation with CAVEATS section
Date: Thu, 23 Aug 2007 09:48:51 +0200
Message-ID: <86odgybsik.fsf@lola.quinscape.zz>
References: <20070816085645.GA3159@soma>
	<7v4piri44r.fsf@gitster.siamese.dyndns.org>
	<853aybkwsc.fsf@lola.goethe.zz> <20070823053009.GC4978@muzzle>
	<85r6luiydb.fsf@lola.goethe.zz> <20070823062631.GD4417@hand.yhbt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 23 09:49:20 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IO7RP-0005fm-Pf
	for gcvg-git@gmane.org; Thu, 23 Aug 2007 09:49:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755740AbXHWHtR (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 23 Aug 2007 03:49:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755868AbXHWHtR
	(ORCPT <rfc822;git-outgoing>); Thu, 23 Aug 2007 03:49:17 -0400
Received: from main.gmane.org ([80.91.229.2]:54521 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751044AbXHWHtQ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 Aug 2007 03:49:16 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1IO7RC-0002BE-Gn
	for git@vger.kernel.org; Thu, 23 Aug 2007 09:49:06 +0200
Received: from pd95b0fdb.dip0.t-ipconnect.de ([217.91.15.219])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 23 Aug 2007 09:49:06 +0200
Received: from dak by pd95b0fdb.dip0.t-ipconnect.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 23 Aug 2007 09:49:06 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: pd95b0fdb.dip0.t-ipconnect.de
In-Reply-To: <20070823062631.GD4417@hand.yhbt.net> (Eric Wong's message of "Wed\, 22 Aug 2007 23\:26\:31 -0700")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1.50 (gnu/linux)
Cancel-Lock: sha1:wUUwC7+i/d7h2hKy9436JXOeIlI=
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56467>

Eric Wong <normalperson@yhbt.net> writes:

> David Kastrup <dak@gnu.org> wrote:
>
>> This is already a _large_ help for avoiding clobbering the central
>> repository.  But I stress that it would be much better if git-svn
>> dcommit/rebase stayed exclusively on the branch that is associated
>> with it/fetching in the "svn" config section, like git does in
>> general with remotes.  No random branch jumping after merges or (to
>> be _really_ avoided) rebases and certainly after cherry-picking
>> within git.
>
> I think I see where you're coming from, now.  git-svn doesn't ever
> associate remotes with local branches in the .git/config like
> regular git-clone.
>
> I just cloned git.git from kernel.org again to see that .git/config
> associates a local branch with a remote branch like this:
>
> ----------------------------------------------------------------
> [branch "master"]
>         remote = origin
>         merge = refs/heads/master
> ----------------------------------------------------------------
>
> I used git before this feature ever existed, and got used to git
> without ever needing it myself.  I've always had a good idea of
> where I branched off from last, or I can ask with "gitk --all"
> otherwise.

But with -t support, git-svn already has a good notion about what
branch belongs to what remote.

> So yes, I'll shamefully admit that I've never used this feature of
> git and in my very quick (and sleepy) evaluation of it, it seems
> quite limiting...

Oh, I don't mind being limited from wreaking havoc on a central
repository.

-- 
David Kastrup
