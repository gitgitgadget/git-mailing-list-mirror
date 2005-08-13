From: Carl Baldwin <cnb@fc.hp.com>
Subject: Re: How is working on arbitrary remote heads supposed to work in Cogito (+ PATCH)?
Date: Fri, 12 Aug 2005 22:11:14 -0600
Organization: Hewlett Packard
Message-ID: <20050813041114.GA29412@hpsvcnb.fc.hp.com>
References: <20050729081051.GH24895@pasky.ji.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Aug 13 06:12:22 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E3nNA-00075u-DS
	for gcvg-git@gmane.org; Sat, 13 Aug 2005 06:11:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750712AbVHMELZ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 13 Aug 2005 00:11:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751045AbVHMELZ
	(ORCPT <rfc822;git-outgoing>); Sat, 13 Aug 2005 00:11:25 -0400
Received: from atlrel9.hp.com ([156.153.255.214]:16798 "EHLO atlrel9.hp.com")
	by vger.kernel.org with ESMTP id S1750712AbVHMELZ (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 13 Aug 2005 00:11:25 -0400
Received: from smtp2.fc.hp.com (smtp.fc.hp.com [15.15.136.253])
	by atlrel9.hp.com (Postfix) with ESMTP id 45CF2722C;
	Sat, 13 Aug 2005 00:11:20 -0400 (EDT)
Received: from hpsvcnb.fc.hp.com (hpsvcnb.fc.hp.com [15.6.94.42])
	by smtp2.fc.hp.com (Postfix) with ESMTP
	id E3EF5420A75; Sat, 13 Aug 2005 04:11:14 +0000 (UTC)
Received: by hpsvcnb.fc.hp.com (Postfix, from userid 21523)
	id 740462ABD9; Fri, 12 Aug 2005 22:11:14 -0600 (MDT)
To: Petr Baudis <pasky@suse.cz>
Content-Disposition: inline
In-Reply-To: <20050729081051.GH24895@pasky.ji.cz>
X-Origin: hpescnb.fc.hp.com
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Fri, Jul 29, 2005 at 08:10:51AM +0000, Petr Baudis wrote:
> Exactly. I want much more freedom in pushing, the only requirement being
> that "the to-be-replaced remote head is ancestor of the to-be-pushed
> local head". I think (am I wrong?) git-send-pack localhead:remotehead
> would work just fine for me, the only thing I need is the support for
> different local and remote head names.

Greetings,

Sorry to join the game so late.  I've only read this thread now.

It seems to me that this is the way to go.  Several have mentioned that
head names should be the same on the remote and the local side.
However, I wanted to point out that it may be impossible to keep these
names in sync due to the 'loosely knit' nature of the types of projects
that are likely to use git.

It seems that the requirement that the remote head be a strict ancestor
of the local head is actually quite strong and should avoid mistakes
like pushing to the wrong head.

Anyway, those are my two cents.  I couldn't tell wether a resolution had
been achieved so I thought I would pipe up.

Carl

-- 
- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
 Carl Baldwin                        Systems VLSI Laboratory
 Hewlett Packard Company
 MS 88                               work: 970 898-1523
 3404 E. Harmony Rd.                 work: Carl.N.Baldwin@hp.com
 Fort Collins, CO 80525              home: Carl@ecBaldwin.net
- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
