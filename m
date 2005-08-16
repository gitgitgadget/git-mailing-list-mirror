From: Carl Baldwin <cnb@fc.hp.com>
Subject: Re: Making note, in the repository, of push/pull relationships
Date: Tue, 16 Aug 2005 10:03:27 -0600
Organization: Hewlett Packard
Message-ID: <20050816160327.GA20016@hpsvcnb.fc.hp.com>
References: <20050815162519.GB9719@hpsvcnb.fc.hp.com> <Pine.LNX.4.63.0508160044490.25894@wgmdd8.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Carl Baldwin <cnb@fc.hp.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 16 18:06:10 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E53vQ-0007Fj-Ho
	for gcvg-git@gmane.org; Tue, 16 Aug 2005 18:04:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030206AbVHPQER (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 16 Aug 2005 12:04:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030208AbVHPQER
	(ORCPT <rfc822;git-outgoing>); Tue, 16 Aug 2005 12:04:17 -0400
Received: from atlrel7.hp.com ([156.153.255.213]:28397 "EHLO atlrel7.hp.com")
	by vger.kernel.org with ESMTP id S1030206AbVHPQEQ (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 16 Aug 2005 12:04:16 -0400
Received: from smtp2.fc.hp.com (smtp.fc.hp.com [15.15.136.253])
	by atlrel7.hp.com (Postfix) with ESMTP id 14C14211A;
	Tue, 16 Aug 2005 12:03:58 -0400 (EDT)
Received: from hpsvcnb.fc.hp.com (hpsvcnb.fc.hp.com [15.6.94.42])
	by smtp2.fc.hp.com (Postfix) with ESMTP
	id CCC374214CC; Tue, 16 Aug 2005 16:03:57 +0000 (UTC)
Received: by hpsvcnb.fc.hp.com (Postfix, from userid 21523)
	id 75FDF4862; Tue, 16 Aug 2005 10:03:27 -0600 (MDT)
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.63.0508160044490.25894@wgmdd8.biozentrum.uni-wuerzburg.de>
X-Origin: hpescnb.fc.hp.com
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Tue, Aug 16, 2005 at 12:49:33AM +0200, Johannes Schindelin wrote:
> Hi,
> 
> On Mon, 15 Aug 2005, Carl Baldwin wrote:
> 
> > Somewhere in the thread something was mentioned about maintaining
> > <local branch>:<remote branch> pairs in the git repository when pushes
> > and pulls are performed.  I think the argument was actually against
> > keeping this information and ultimately against allowing pushes to a
> > branch of a different name.
> 
> I think the loudest voice was mine :-)
> 
> Actually, I was not against *keeping* the information, but against 
> *pulling* in such strange ways. If "cross-pulling" is allowed, I am all 
> for keeping track of that.

So, just a question.  What, exactly, is meant by 'cross-pulling'?

> In the meantime, I did not think about the issue at all :-) However, as is 
> often the case in an open discussion, I think I was wrong after all. There 
> may be cases you want that, and in the end, nobody forces me to use that 
> feature.
> 
> Anyway, Junio decided to enhance the fetch mechanism to support the 
> cross-pulling (and also multi-pulling).
> 
> Ciao,
> Dscho
> 

-- 
- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
 Carl Baldwin                        Systems VLSI Laboratory
 Hewlett Packard Company
 MS 88                               work: 970 898-1523
 3404 E. Harmony Rd.                 work: Carl.N.Baldwin@hp.com
 Fort Collins, CO 80525              home: Carl@ecBaldwin.net
- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
