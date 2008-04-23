From: Teemu Likonen <tlikonen@iki.fi>
Subject: Re: Friendly refspecs
Date: Wed, 23 Apr 2008 07:24:33 +0300
Message-ID: <20080423042433.GA3291@mithlond.arda.local>
References: <20080409222500.GB19248@mithlond> <20080409225112.GB12103@sigill.intra.peff.net> <20080413093102.GC12107@mithlond.arda.local> <20080416034823.GA11727@sigill.intra.peff.net> <alpine.LNX.1.00.0804161126280.19665@iabervon.org> <7vod89pnxx.fsf@gitster.siamese.dyndns.org> <20080422105658.GA11238@sigill.intra.peff.net> <7v63u9zva9.fsf@gitster.siamese.dyndns.org> <20080422200550.GB29313@sigill.intra.peff.net> <7vd4ohy5ym.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, Daniel Barkalow <barkalow@iabervon.org>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Apr 23 06:26:40 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JoWZ5-0001Si-Qa
	for gcvg-git-2@gmane.org; Wed, 23 Apr 2008 06:26:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751075AbYDWEZx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Apr 2008 00:25:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751076AbYDWEZx
	(ORCPT <rfc822;git-outgoing>); Wed, 23 Apr 2008 00:25:53 -0400
Received: from pne-smtpout4-sn2.hy.skanova.net ([81.228.8.154]:34317 "EHLO
	pne-smtpout4-sn2.hy.skanova.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751090AbYDWEZw (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 23 Apr 2008 00:25:52 -0400
Received: from mithlond.arda.local (80.220.180.181) by pne-smtpout4-sn2.hy.skanova.net (7.3.129)
        id 478BE663005A9586; Wed, 23 Apr 2008 06:24:41 +0200
Received: from dtw by mithlond.arda.local with local (Exim 4.63)
	(envelope-from <tlikonen@iki.fi>)
	id 1JoWX3-000141-Gt; Wed, 23 Apr 2008 07:24:33 +0300
Content-Disposition: inline
In-Reply-To: <7vd4ohy5ym.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80185>

Junio C Hamano wrote (2008-04-22 13:45 -0700):

> I thought the original poster's example was
> 
> 	git push $there $commit:branch2
> 
> where $commit happened to be "branch1".  Would we dwim
> 
> 	git push $there branch1~4:this_is_known_ok
> 
> to refs/heads/?

I guess this is what I meant. My original question was about
inconsistent user interface: "git push $there branch1" creates branch1
on the remote side (if it does not exist) but "git push $there
branch1:branch2" gives an error if branch2 does not exist
(branch1:refs/heads/branch2 is required).

The case has become much more complicated since, so I just speak aloud
my hope that need for refs/ paths in common situations would be reduced
to minimum.
