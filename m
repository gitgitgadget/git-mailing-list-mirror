From: Jonas Fonseca <fonseca@diku.dk>
Subject: Re: [PATCH] revert/cherry-pick: allow the last parameter to be -h
Date: Wed, 23 May 2007 07:31:11 +0200
Message-ID: <20070523053110.GA23971@diku.dk>
References: <20070522212945.GA8002@diku.dk> <20070522221156.GL30871@steel.home> <7vwsz07b10.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Alex Riesen <raa.lkml@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Wed May 23 07:31:20 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HqjRN-0007k1-CL
	for gcvg-git@gmane.org; Wed, 23 May 2007 07:31:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756000AbXEWFbP (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 23 May 2007 01:31:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756235AbXEWFbO
	(ORCPT <rfc822;git-outgoing>); Wed, 23 May 2007 01:31:14 -0400
Received: from mgw1.diku.dk ([130.225.96.91]:38679 "EHLO mgw1.diku.dk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756000AbXEWFbO (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 May 2007 01:31:14 -0400
Received: from localhost (localhost [127.0.0.1])
	by mgw1.diku.dk (Postfix) with ESMTP id 9BEA896802E;
	Wed, 23 May 2007 07:31:12 +0200 (CEST)
X-Virus-Scanned: amavisd-new at diku.dk
Received: from mgw1.diku.dk ([127.0.0.1])
	by localhost (mgw1.diku.dk [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id oNM89+-2DacM; Wed, 23 May 2007 07:31:11 +0200 (CEST)
Received: from nhugin.diku.dk (nhugin.diku.dk [130.225.96.140])
	by mgw1.diku.dk (Postfix) with ESMTP id 5421A9680DF;
	Wed, 23 May 2007 07:31:11 +0200 (CEST)
Received: from ask.diku.dk (ask.diku.dk [130.225.96.225])
	by nhugin.diku.dk (Postfix) with ESMTP
	id 3A62B6DFC49; Wed, 23 May 2007 07:29:21 +0200 (CEST)
Received: by ask.diku.dk (Postfix, from userid 3873)
	id 325F562A5E; Wed, 23 May 2007 07:31:11 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <7vwsz07b10.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.5.6i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48142>

Junio C Hamano <junkio@cox.net> wrote Tue, May 22, 2007:
> Alex Riesen <raa.lkml@gmail.com> writes:
> 
> > Jonas Fonseca, Tue, May 22, 2007 23:29:45 +0200:
> >> +	if (!strcmp(arg, "-h"))
> >> +		usage(usage_str);
> >
> >     $ git rev-list --usage
> >     usage: git-rev-list [OPTION] <commit-id>... [ -- paths... ]
> >       limiting output:
> > 	--max-count=nr
> > 	--max-age=epoch
> >     ...
> >
> > Why should cherry-pick be different?
> 
> Good question.  FYI
> 
> 	$ git rev-list --huh?
> 
> works equally well ;-)

Because it is different?

   $ git revert --why-must-it-be-so-hard-to-learn-git-sometimes
   fatal: Cannot find '--why-must-it-be-so-hard-to-learn-git-sometimes'

Because, contrary to git-rev-list, git-revert/cherry-pick is considered
part of the porcelain? Because asking that question to every small UI
improvement is not very useful?

And yes I could spell out '--help', but it just seems weird that I need
to know the calling convention of git-revert (_and_ git-cherry-pick for
that matter) in order to get the usage string, because that was what I
wanted to know in the first place. Anyway, if you don't like it, please
just drop the patch. :)

-- 
Jonas Fonseca
