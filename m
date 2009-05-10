From: Eric Wong <normalperson@yhbt.net>
Subject: Re: [PATCH v2] git-svn: add --authors-prog option
Date: Sat, 9 May 2009 17:35:09 -0700
Message-ID: <20090510003509.GA2000@dcvr.yhbt.net>
References: <1241745069-2663-1-git-send-email-lodatom@gmail.com> <4A03E2A2.4050303@drmicha.warpmail.net> <ca433830905082048u6088a58ai16b1c979ef742f7@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Michael J Gruber <git@drmicha.warpmail.net>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>
To: Mark Lodato <lodatom@gmail.com>
X-From: git-owner@vger.kernel.org Sun May 10 02:35:26 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M2x0n-00047M-Gg
	for gcvg-git-2@gmane.org; Sun, 10 May 2009 02:35:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754663AbZEJAfK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 9 May 2009 20:35:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754409AbZEJAfK
	(ORCPT <rfc822;git-outgoing>); Sat, 9 May 2009 20:35:10 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:36614 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753691AbZEJAfJ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 9 May 2009 20:35:09 -0400
Received: from localhost (unknown [127.0.2.5])
	by dcvr.yhbt.net (Postfix) with ESMTP id B01F51F791;
	Sun, 10 May 2009 00:35:09 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <ca433830905082048u6088a58ai16b1c979ef742f7@mail.gmail.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118689>

Mark Lodato <lodatom@gmail.com> wrote:
> On Fri, May 8, 2009 at 3:43 AM, Michael J Gruber
> <git@drmicha.warpmail.net> wrote:
> > Mark Lodato venit, vidit, dixit 08.05.2009 03:11:
> > Maybe we want a config key also, just like for the authors file.
> 
> Yes, this is a very good idea.  I will figure out how to do this.

It already works :)  Command-line options taken by git svn have always
been automatically converted to config keys.

> > The feature itself looks useful for large user databases. For smaller
> > ones one could just as well update the authors file before each fetch by
> > dumping the whole db in there (or even conditionally on git svn fetch
> > erroring out due to encountering an unknown name).
> 
> Right.  This feature will most likely be useful in corporate
> environments.  In my case, it is not possible to dump the entire user
> database to a file, so this patch is the only solution.  Another
> possible use case is where SVN usernames are standardized, e.g. "jdoe"
> -> "J Doe <jdoe@example.com>".  Also, using --authors-prog solves the
> problem of keeping the authors file up-to-date, if users are regularly
> added or deleted.

Thanks Mark.  Your patch looks good and I'll apply the next one after
the grammar fixes.  I've actually thought about implementing this myself
back when I (briefly) worked in a corporate environment, but never
got around to it.

Sorry for the late response and not following the mailing list more
closely these days.

-- 
Eric Wong
