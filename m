From: Eric Wong <normalperson@yhbt.net>
Subject: Re: [PATCH/RFC] git-svn: don't create master if another head exists
Date: Wed, 11 Jul 2012 01:26:17 +0000
Message-ID: <20120711012617.GA18369@dcvr.yhbt.net>
References: <20120624220835.GA4762@beczulka>
 <7v4nq0hrjb.fsf@alter.siamese.dyndns.org>
 <20120625075726.GO3125@beczulka>
 <7vehp3gwbx.fsf@alter.siamese.dyndns.org>
 <20120626212108.GR3125@beczulka>
 <7vfw9hafz8.fsf@alter.siamese.dyndns.org>
 <20120626223215.GB8336@beczulka>
 <20120709220321.GE30213@beczulka>
 <7v8vesk12v.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Marcin Owsiany <marcin@owsiany.pl>
X-From: git-owner@vger.kernel.org Wed Jul 11 03:26:23 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Solh8-00079k-Vr
	for gcvg-git-2@plane.gmane.org; Wed, 11 Jul 2012 03:26:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754712Ab2GKB0S (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Jul 2012 21:26:18 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:44835 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753982Ab2GKB0R (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Jul 2012 21:26:17 -0400
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4D5A91F427;
	Wed, 11 Jul 2012 01:26:17 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <7v8vesk12v.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201288>

Junio C Hamano <gitster@pobox.com> wrote:
> Marcin Owsiany <marcin@owsiany.pl> writes:
> 
> >> This makes my idea to do the same to "my something else instead of
> >> master" much less attractive. In fact I don't think such behaviour would
> >> be useful.
> >> 
> >> I think with the suggested patch git-svn works as I would like it to:
> >>  - creates "master" at initial checkout - consistent with git clone
> >>  - using a different "tracking-like" branch is possible with "dcommit"
> >>  - does not re-create "master" on fetch - so the annoying part is gone
> >
> > Any comments?
> 
> Not from me.  Even though I'd love to hear Eric's opinion, your "I
> don't think such behaviour would be useful." gave me an impression
> that you would justify the change in a different way (i.e. a rewrite
> of proposed log message) or tweak the patch (i.e. a modified
> behaviour), or perhaps both, in your re-roll, the ball was in your
> court, and we were waiting for such a rerolled patch.

Sorry, I keep forgetting this topic.  But yes, I thought you would tweak
your patch.
