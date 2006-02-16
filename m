From: Eric Wong <normalperson@yhbt.net>
Subject: Re: [ANNOUNCE] git-svn - bidirection operations between svn and git
Date: Thu, 16 Feb 2006 00:48:59 -0800
Message-ID: <20060216084859.GB12055@hand.yhbt.net>
References: <20060216073826.GA12055@hand.yhbt.net> <7v4q2zg2an.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Feb 16 09:49:15 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F9ep0-0006r4-Fv
	for gcvg-git@gmane.org; Thu, 16 Feb 2006 09:49:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932075AbWBPItB (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 16 Feb 2006 03:49:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932514AbWBPItA
	(ORCPT <rfc822;git-outgoing>); Thu, 16 Feb 2006 03:49:00 -0500
Received: from hand.yhbt.net ([66.150.188.102]:64913 "EHLO hand.yhbt.net")
	by vger.kernel.org with ESMTP id S932075AbWBPItA (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 16 Feb 2006 03:49:00 -0500
Received: by hand.yhbt.net (Postfix, from userid 500)
	id A519C2DC01A; Thu, 16 Feb 2006 00:48:59 -0800 (PST)
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7v4q2zg2an.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16286>

Junio C Hamano <junkio@cox.net> wrote:
> Eric Wong <normalperson@yhbt.net> writes:
> 
> > @ Junio: Is there room for this in the git distribution alongside
> > git-svnimport?
> 
> Surely.  Things that superficially do similar things are not
> necessarily mutually exclusive, if that is what you are worried
> about.  There is not much incumbent advantage for tools that
> support a narrowly defined specific task (e.g. interfacing with
> foreign SCM X) on the periphery, while I would perhaps feel more
> hesitant to support 47 different variants of git-commit ;-).

<snip>
 
> Even having some experimental tools that are only starting to do
> useful things might be useful, if we had it in the git.git
> repository.  For one thing, it would give more exposure to them
> and help improve things.

Good to know.  I fully agree on this point.

> How about first adding a contrib/ directory and see how it goes?

Sure thing.  Don't worry about development history, there's hardly any
as it was all done pretty quickly.  Being able to draw from my
experiences with svn-arch-mirror, arch-svn-merge (this one sucked), and
git-archimport helped greatly; as did the very simple and flexible
nature of git.

-- 
Eric Wong
