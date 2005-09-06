From: Carl Baldwin <cnb@fc.hp.com>
Subject: Re: [PATCH] unset CDPATH in git-clone
Date: Tue, 6 Sep 2005 08:52:01 -0600
Organization: Hewlett Packard
Message-ID: <20050906145201.GA4551@hpsvcnb.fc.hp.com>
References: <20050901152441.GA8694@hpsvcnb.fc.hp.com> <7v3boj486h.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Sep 06 16:54:45 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1ECeo0-0002em-VM
	for gcvg-git@gmane.org; Tue, 06 Sep 2005 16:52:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750703AbVIFOwE (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 6 Sep 2005 10:52:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750705AbVIFOwE
	(ORCPT <rfc822;git-outgoing>); Tue, 6 Sep 2005 10:52:04 -0400
Received: from atlrel7.hp.com ([156.153.255.213]:2773 "EHLO atlrel7.hp.com")
	by vger.kernel.org with ESMTP id S1750703AbVIFOwC (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 6 Sep 2005 10:52:02 -0400
Received: from smtp1.fc.hp.com (smtp1b.fc.hp.com [15.15.136.127])
	by atlrel7.hp.com (Postfix) with ESMTP id 853061C53;
	Tue,  6 Sep 2005 10:52:01 -0400 (EDT)
Received: from hpsvcnb.fc.hp.com (hpsvcnb.fc.hp.com [15.6.94.42])
	by smtp1.fc.hp.com (Postfix) with ESMTP
	id 38DDC388EA; Tue,  6 Sep 2005 14:52:01 +0000 (UTC)
Received: by hpsvcnb.fc.hp.com (Postfix, from userid 21523)
	id 23F9144A0; Tue,  6 Sep 2005 08:52:01 -0600 (MDT)
To: Junio C Hamano <junkio@cox.net>
Mail-Followup-To: Junio C Hamano <junkio@cox.net>,
	git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <7v3boj486h.fsf@assigned-by-dhcp.cox.net>
X-Origin: hpsvcnb.fc.hp.com
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8132>

On Mon, Sep 05, 2005 at 12:37:58PM -0700, Junio C Hamano wrote:
> Carl Baldwin <cnb@fc.hp.com> writes:
> 
> > The function get_repo_base seems to break with this CDPATH.
> 
> Sorry, your message somehow slipped my filtering.  Thanks for
> the analysis.  Of course, CDPATH would break it.
> 
> Is there any good reason why somebody would want to have CDPATH
> in his environment, inherited to be used by any shell scripts,
> as opposed to have it as a plain shell variable that is set only
> in interactive shells?  I do not think of any.

Good point.  There is no good reason at all.  It happens when one does
not know the difference between a plain shell variable and an
environment variable.

Carl

-- 
- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
 Carl Baldwin                        Systems VLSI Laboratory
 Hewlett Packard Company
 MS 88                               work: 970 898-1523
 3404 E. Harmony Rd.                 work: Carl.N.Baldwin@hp.com
 Fort Collins, CO 80525              home: Carl@ecBaldwin.net
- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
