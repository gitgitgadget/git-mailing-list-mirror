From: Mukund Sivaraman <muks@banu.com>
Subject: Re: Including branch info in git format-patch
Date: Fri, 20 Jun 2008 02:56:27 +0530
Message-ID: <20080619212626.GA29643@jurassic>
References: <20080619154251.GA16475@jurassic> <20080619202843.GA6207@sigill.intra.peff.net> <7vskv9rvrc.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jun 19 23:27:47 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K9RfM-0008Rj-2Q
	for gcvg-git-2@gmane.org; Thu, 19 Jun 2008 23:27:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751643AbYFSV0h (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Jun 2008 17:26:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751779AbYFSV0h
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Jun 2008 17:26:37 -0400
Received: from mail.banu.com ([67.19.28.195]:50180 "EHLO mail.banu.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751600AbYFSV0h (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Jun 2008 17:26:37 -0400
Received: from ? (unknown [59.93.72.96])
	by mail.banu.com (Postfix) with ESMTP id 974E31110066;
	Thu, 19 Jun 2008 16:26:33 -0500 (CDT)
Content-Disposition: inline
In-Reply-To: <7vskv9rvrc.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85535>

On Thu, Jun 19, 2008 at 01:54:15PM -0700, Junio C Hamano wrote:
> If you have a history of this shape:
> 
>                     (other cruft)
>                           \
>                    ----o---o next
>                       /
>          o---o---o---o master
>         /       /
>     ---o---o---A
> 
> which "branch label" would you give to the format-patch output that shows
> commit A?  It may apply to both master and next, and it is really up to
> the project's convention what to do with it.  The side branch the patch
> was developed on may be named "quick-hack", which would not have any
> relevance to the final location of where that patch wants to be in.

I follow what you are saying. In our workflow case, pointing out the
remote (public) branch name should be sufficient (as this's the public
shared branch among us, and all patchsets shared with others are against
the public branches). Perhaps I can add it to the [PATCH] text in the
subject line as Jeff suggests.

My problem is that I can't send a patch out to the list for other
developers to try, without some annotation for them, of which branch to
try it on.

		Mukund
