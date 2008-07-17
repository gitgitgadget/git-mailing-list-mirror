From: David Kastrup <dak@gnu.org>
Subject: Re: Considering teaching plumbing to users harmful
Date: Thu, 17 Jul 2008 13:18:02 +0200
Message-ID: <861w1sn4id.fsf@lola.quinscape.zz>
References: <alpine.DEB.1.00.0807161804400.8950@racer>
	<32541b130807161053w24a21d7bh1fa800a714ce75db@mail.gmail.com>
	<alpine.DEB.1.00.0807161902400.8986@racer>
	<32541b130807161135h64024151xc60e23d222a3a508@mail.gmail.com>
	<alpine.LNX.1.00.0807161605550.19665@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jul 17 13:19:14 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KJRVw-0003f6-3u
	for gcvg-git-2@gmane.org; Thu, 17 Jul 2008 13:19:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751273AbYGQLSL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Jul 2008 07:18:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750998AbYGQLSL
	(ORCPT <rfc822;git-outgoing>); Thu, 17 Jul 2008 07:18:11 -0400
Received: from main.gmane.org ([80.91.229.2]:57577 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751202AbYGQLSK (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Jul 2008 07:18:10 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1KJRUv-0002A6-8M
	for git@vger.kernel.org; Thu, 17 Jul 2008 11:18:09 +0000
Received: from pd95b0fdb.dip0.t-ipconnect.de ([217.91.15.219])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 17 Jul 2008 11:18:09 +0000
Received: from dak by pd95b0fdb.dip0.t-ipconnect.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 17 Jul 2008 11:18:09 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: pd95b0fdb.dip0.t-ipconnect.de
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.0.60 (gnu/linux)
Cancel-Lock: sha1:fZ8VXXQQ/q/gTyHSxcyf0q8qH6Q=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88831>

Daniel Barkalow <barkalow@iabervon.org> writes:

> You're simply wrong. A ref isn't a name for a commit (the point of
> having a ref is that it doesn't persist in naming the same commit). A
> commit isn't a blob. If you start telling people complicated and wrong
> things, they're surely going to be confused.
>
> Git maintains history as a directed graph, with each commit pointing
> back at its history. Refs are the what holds the newest commits that
> nothing else points back to. If directed graphs aren't in your users'
> experience, you can put it this way: git maintains history like
> knitting, where each new stitch holds on to one or more previous
> stitches, and refs are the knitting needles that hold the ends where
> you're working (except that knitting is a lot wider than software
> development). gitk --all even provides the diagram you want to explain
> it.

Complicated and right things are not much less confusing...

> SVN branches are incredible confusing because they fail to distinguish
> the directory structure of the project's source tree from the
> arrangement of available latest versions.

That is because there _is_ no difference.  You just store different
versions in different places.  What they are named is a convention,
nothing more, nothing less.

> And the version numbers for your branch increase when changes are made
> to other branches.

You are confusing "version numbers" which are assigned by humans with
"revision numbers" which are just an administrational timeline for the
whole repository.

Really, Subversion is rather simple to understand.  But it is not a
DVCS.  Moving a history from one repository to another is not really
feasible unless you are doing straight mirroring.

-- 
David Kastrup
