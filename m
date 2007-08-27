From: David Kastrup <dak@gnu.org>
Subject: Re: git-svn tags and branches
Date: Mon, 27 Aug 2007 17:09:30 +0200
Message-ID: <867inhqaj9.fsf@lola.quinscape.zz>
References: <faulrb$483$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Aug 27 17:10:46 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IPgEm-0000kt-TH
	for gcvg-git@gmane.org; Mon, 27 Aug 2007 17:10:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754199AbXH0PKL (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 27 Aug 2007 11:10:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757277AbXH0PKK
	(ORCPT <rfc822;git-outgoing>); Mon, 27 Aug 2007 11:10:10 -0400
Received: from main.gmane.org ([80.91.229.2]:52598 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755530AbXH0PKI (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Aug 2007 11:10:08 -0400
Received: from root by ciao.gmane.org with local (Exim 4.43)
	id 1IPgE6-0002jf-3J
	for git@vger.kernel.org; Mon, 27 Aug 2007 17:10:02 +0200
Received: from pd95b0fdb.dip0.t-ipconnect.de ([217.91.15.219])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 27 Aug 2007 17:10:02 +0200
Received: from dak by pd95b0fdb.dip0.t-ipconnect.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 27 Aug 2007 17:10:02 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: pd95b0fdb.dip0.t-ipconnect.de
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1.50 (gnu/linux)
Cancel-Lock: sha1:oT7YUR9gsRxgvjuTrcb0thEvFUY=
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56846>

Giuseppe Bilotta <giuseppe.bilotta@gmail.com> writes:

> I've recently started using git and I like it so much that
> I've decided to start using it also for some svn-based
> projects (in particular, rbot http://linuxbrit.co.uk/rbot).
>
> The long term goal would be to move the project to git, but
> for the time being (among the other things we're waiting for
> Trac to have proper support for git, which is something that
> won't happen before Trac 0.12 at least) I've decided to
> experiment with a dual git/svn development process, using
> (of course) git-svn.
>
> My experience with toying around with it for a couple of
> hours has been extremely positive, but I've got some
> questions, especially about the tags and branch management.
>
> Currently, git-svn imports svn tags as lightweight git tags.

It does?  I see them as branches.

> I was susprised when I discovered this (from 'git describe'
> failing and some helpful assistance on the IRC channel), so
> I'm now wondering: is there a technical reason why they
> aren't converted to annotated tags? If not, would it be
> possible to implement this in git-svn, possibly with some
> way to 'fix' existing git-svn repository?

I actually don't see how one can safely make them tags at all (rather
than branches) since Subversion does not enforce the members of a
"tags" subdirectory to remain unchanged after the initial copy.
Basically, tags are not different from branches in Subversion from
what you can do with them.

> My second question concerns the uses of branche in git-svn,
> but it might come from a not perfect understanding of the
> branching mechanism in git (and yes, I've read the
> documentation and Wiki pages).

I'll leave that question to people who actually understand git-svn and
git branches.

-- 
David Kastrup
