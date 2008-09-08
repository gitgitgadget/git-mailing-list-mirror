From: "Stephen R. van den Berg" <srb@cuci.nl>
Subject: Re: [RFC] cherry-pick using multiple parents to implement -x
Date: Mon, 8 Sep 2008 08:57:23 +0200
Message-ID: <20080908065723.GA29969@cuci.nl>
References: <20080907103415.GA3139@cuci.nl> <20080907172807.GA25233@coredump.intra.peff.net> <20080907195626.GA8765@cuci.nl> <20080907200441.GA26705@coredump.intra.peff.net> <20080907202202.GC8765@cuci.nl> <20080908014959.GA29129@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Sep 08 08:58:42 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kcaht-0005iS-AP
	for gcvg-git-2@gmane.org; Mon, 08 Sep 2008 08:58:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752204AbYIHG5Z (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Sep 2008 02:57:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752150AbYIHG5Z
	(ORCPT <rfc822;git-outgoing>); Mon, 8 Sep 2008 02:57:25 -0400
Received: from aristoteles.cuci.nl ([212.125.128.18]:52227 "EHLO
	aristoteles.cuci.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752168AbYIHG5Y (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Sep 2008 02:57:24 -0400
Received: by aristoteles.cuci.nl (Postfix, from userid 500)
	id 7C8BF5465; Mon,  8 Sep 2008 08:57:23 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20080908014959.GA29129@coredump.intra.peff.net>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95220>

Jeff King wrote:
>On Sun, Sep 07, 2008 at 10:22:02PM +0200, Stephen R. van den Berg wrote:
>> >But then it will fail to find legitimate merge bases. So yes, you _can_

>> Will it?  Can you give me one example where it would find the wrong one?

>How about the example I gave already? The first merge-base is E, but
>that is not correct for the merge I gave. So you propose an algorithm
>which will find A. But now imagine the exact some topology, but there
>was no cherry-pick; instead, E' is actually a merge. Wouldn't E be the
>right merge-base then?

Indeed.  Q.E.D.
I'll drop the idea with the parentlinks.
-- 
Sincerely,
           Stephen R. van den Berg.
The Horkheimer Effect: "The odds of it being cloudy are directly proportional
to the importance of an astronomical event."
