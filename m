From: Mukund Sivaraman <muks@banu.com>
Subject: Re: Including branch info in git format-patch
Date: Fri, 20 Jun 2008 03:25:13 +0530
Message-ID: <20080619215512.GA29693@jurassic>
References: <20080619154251.GA16475@jurassic> <20080619202843.GA6207@sigill.intra.peff.net> <7vskv9rvrc.fsf@gitster.siamese.dyndns.org> <20080619212626.GA29643@jurassic> <7vod5xrtjx.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jun 19 23:56:33 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K9S7M-0001AS-A0
	for gcvg-git-2@gmane.org; Thu, 19 Jun 2008 23:56:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752015AbYFSVzZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Jun 2008 17:55:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751564AbYFSVzY
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Jun 2008 17:55:24 -0400
Received: from mail.banu.com ([67.19.28.195]:60424 "EHLO mail.banu.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751304AbYFSVzW (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Jun 2008 17:55:22 -0400
Received: from ? (unknown [59.93.72.96])
	by mail.banu.com (Postfix) with ESMTP id 976C21110066;
	Thu, 19 Jun 2008 16:55:19 -0500 (CDT)
Content-Disposition: inline
In-Reply-To: <7vod5xrtjx.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85544>

On Thu, Jun 19, 2008 at 02:41:54PM -0700, Junio C Hamano wrote:
> > My problem is that I can't send a patch out to the list for other
> > developers to try, without some annotation for them, of which branch to
> > try it on.
> 
> So what's wrong telling that when you send out the patch, between the time
> you run format-patch and send-email?
> 

I had asked if there was some way the remote branch name could
automatically be inserted by git format-patch, instead of manually adding
it in the patch message or in a cover letter. What Jeff suggested seems
good to me (of using --subject-prefix) as that is removed automatically
when the patch is applied by git am.

		Mukund
