From: Teemu Likonen <tlikonen@iki.fi>
Subject: Re: Friendly refspecs
Date: Thu, 10 Apr 2008 10:38:50 +0300
Message-ID: <20080410073850.GC3160@mithlond>
References: <20080409101428.GA2637@elte.hu> <20080409145758.GB20874@sigill.intra.peff.net> <20080409200836.GA19248@mithlond> <7vabk23esz.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Apr 10 09:39:49 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JjrNj-0002Ua-In
	for gcvg-git-2@gmane.org; Thu, 10 Apr 2008 09:39:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754433AbYDJHiz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Apr 2008 03:38:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754364AbYDJHiz
	(ORCPT <rfc822;git-outgoing>); Thu, 10 Apr 2008 03:38:55 -0400
Received: from pne-smtpout3-sn2.hy.skanova.net ([81.228.8.111]:35216 "EHLO
	pne-smtpout3-sn2.hy.skanova.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753032AbYDJHiy (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 10 Apr 2008 03:38:54 -0400
Received: from mithlond (80.220.180.181) by pne-smtpout3-sn2.hy.skanova.net (7.3.129)
        id 478BDB96004D2320; Thu, 10 Apr 2008 09:38:51 +0200
Received: from dtw by mithlond with local (Exim 4.63)
	(envelope-from <tlikonen@iki.fi>)
	id 1JjrMw-00011g-2z; Thu, 10 Apr 2008 10:38:50 +0300
Content-Disposition: inline
In-Reply-To: <7vabk23esz.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79187>

Junio C Hamano wrote (2008-04-09 14:21 -0700):

> [By the way, please never redirect the response to your messages away from
> you with:
> 
>     Mail-Followup-To: Jeff King <peff@peff.net>, Ingo Molnar <mingo@elte.hu>,
>             git@vger.kernel.org

Sorry, didn't even know such header existed. After consulting Mutt's
manual and some googling I think I understand it now. I'm a subscriber
to git list (and my Mutt knows that) and Mail-Followup-To told
everyone's MUAs to not include me in recipient list since I get
everything through the list. But this is configurable and generating
Mail-Followup-To should be now turned off.

> > Currently "git fetch <URL>" does not seem to do anything useful for
> > non-git-hackers. It seems to fetch objects but not create any
> > branches referring to them.
> 
> I'd suggest you to study:
> 
>   http://thread.gmane.org/gmane.comp.version-control.git/31351/focus=31634
> 
> Not everybody wants remote tracking.

Thanks, and I agree. Me neither always want remote tracking. Git's
current behaviour to only create/update FETCH_HEAD seems actually better
- now that I know what it does. I think it's a good idea to show "[new
branch] foo -> FETCH_HEAD" after fetching.
