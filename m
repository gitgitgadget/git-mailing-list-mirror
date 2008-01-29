From: Brandon Casey <drafnel@gmail.com>
Subject: Re: fetch <repo> <branch>:<branch> fetches tags?
Date: Tue, 29 Jan 2008 08:46:19 +0000 (UTC)
Message-ID: <loom.20080129T055937-532@post.gmane.org>
References: <479E9063.5000403@nrlssc.navy.mil> <7v3ashs5yg.fsf@gitster.siamese.dyndns.org> <7vodb5qk2b.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 29 09:47:09 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JJm7Y-0008S6-Ny
	for gcvg-git-2@gmane.org; Tue, 29 Jan 2008 09:47:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753437AbYA2Iqe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Jan 2008 03:46:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753355AbYA2Iqe
	(ORCPT <rfc822;git-outgoing>); Tue, 29 Jan 2008 03:46:34 -0500
Received: from main.gmane.org ([80.91.229.2]:55574 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753258AbYA2Iqd (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Jan 2008 03:46:33 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1JJm6x-00051g-CY
	for git@vger.kernel.org; Tue, 29 Jan 2008 08:46:31 +0000
Received: from m0b1b5e42.tmodns.net ([66.94.27.11])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 29 Jan 2008 08:46:31 +0000
Received: from drafnel by m0b1b5e42.tmodns.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 29 Jan 2008 08:46:31 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: main.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 66.94.27.11 (Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.1.11) Gecko/20071204 Ubuntu/7.10 (gutsy) Firefox/2.0.0.11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71967>

Junio C Hamano <gitster <at> pobox.com> writes:

> 
> Junio C Hamano <gitster <at> pobox.com> writes:
> 
> > Brandon Casey <casey <at> nrlssc.navy.mil> writes:
> > ...
> >> I expect these to _not_ fetch tags (and they don't):
> >>
> >>    git fetch <repo> <branch>
> >>    git pull <repo> <branch>
> >>
> >> But, I did not expect these to fetch tags:
> >>
> >>    git fetch <repo> <branch>:<branch>
> >>    git pull <repo> <branch>:<branch>
> >
> > Sigh... that matches my expectation.
> >
> > Did we break it when we overhauled "git fetch", or was this an
> > independent "improvement" that happened long before that?
> 
> Having said that, I do not particularly think the new behaviour
> is bad per-se.  If you are storing what you fetched locally in
> tracking branches, you are interested in their work enough to
> want to auto-follow their tags.

How is "tracking" defined? Is this a term that implies some configuration
to link a local branch to a remote branch? Or is any local branch created
from a remote branch considered "tracking"?

I thought that a tracking branch needed some setup like what the --track
option to git-branch or git-checkout would do. If setup is required, then
it implies some permanence to the branch and for the link between the
branch and the remote. In this case I agree you would want to auto-follow
tags.

-brandon
