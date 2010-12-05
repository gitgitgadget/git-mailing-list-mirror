From: Patrick Rouleau <pfrouleau@gmail.com>
Subject: Re: What's cooking in git.git (Dec 2010, #01; Sat, 4)
Date: Sun, 5 Dec 2010 15:51:58 +0000 (UTC)
Message-ID: <loom.20101205T162647-790@post.gmane.org>
References: <7voc90wx36.fsf@alter.siamese.dyndns.org> <alpine.SOC.2.00.1012051420230.18993@kekkonen.cs.hut.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Dec 05 16:52:25 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PPGsz-0004Ke-3Z
	for gcvg-git-2@lo.gmane.org; Sun, 05 Dec 2010 16:52:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756152Ab0LEPwP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 5 Dec 2010 10:52:15 -0500
Received: from lo.gmane.org ([80.91.229.12]:56599 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755282Ab0LEPwP (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 5 Dec 2010 10:52:15 -0500
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1PPGsm-0004FP-8x
	for git@vger.kernel.org; Sun, 05 Dec 2010 16:52:12 +0100
Received: from modemcable243.80-176-173.mc.videotron.ca ([173.176.80.243])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 05 Dec 2010 16:52:12 +0100
Received: from pfrouleau by modemcable243.80-176-173.mc.videotron.ca with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 05 Dec 2010 16:52:12 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: sea.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 173.176.80.243 (Mozilla/5.0 (X11; U; Linux i686; en-US) AppleWebKit/534.7 (KHTML, like Gecko) Chrome/7.0.517.44 Safari/534.7)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162951>

 <aleksi.aalto <at> iki.fi> writes:

> 
> On Sat, 4 Dec 2010, Junio C Hamano wrote:
> > * aa/status-hilite-branch (2010-11-18) 1 commit
> > - status: show branchname with a configurable color
> >
> > I am indifferent/uninterested; I don't see anything wrong with it, but I
> > do not find coloring the field particularly useful myself.
> 
> The idea for this patch came from my daywork, where I have lately been 
> trying to teach new users effective use of Git. We promote heavy usage of 
> "git status" for new users in order for them to understand what all the 
> basic commands do. A great amount of users fail to notice in which branch 
> they are even when looking at the status message. I think this small tweak 
> could help at least some of such new users without causing considerable 
> harm for more advanced users.

I see the same problem at my daywork. 

But like others, I'm not sure about the default color. I would opt for green 
which is the default used by the branch command for highlight the current branch.

Maybe we can add an empty line after the branch name, to make it stand out a bit 
more, with or without color?
