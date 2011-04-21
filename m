From: Damien Wyart <damien.wyart@gmail.com>
Subject: Re: libreoffice merge issue ...
Date: Thu, 21 Apr 2011 16:01:32 +0200
Message-ID: <20110421140132.GA6696@brouette>
References: <1297699635.31477.253.camel@lenovo-w500>
 <20110215094546.GA25530@sigill.intra.peff.net>
 <7vaahxp250.fsf@alter.siamese.dyndns.org>
 <20110216025726.GC7085@sigill.intra.peff.net>
 <7vfwrnis50.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Apr 21 16:10:15 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QCuaE-00063o-11
	for gcvg-git-2@lo.gmane.org; Thu, 21 Apr 2011 16:10:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752561Ab1DUOKH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 Apr 2011 10:10:07 -0400
Received: from mailhost-k4-p1.nerim.net ([195.5.209.41]:22721 "EHLO
	smtp-delay1.nerim.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750915Ab1DUOKG (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Apr 2011 10:10:06 -0400
X-Greylist: delayed 490 seconds by postgrey-1.27 at vger.kernel.org; Thu, 21 Apr 2011 10:10:06 EDT
Received: from maiev.nerim.net (smtp-154-thursday.nerim.net [194.79.134.154])
	by smtp-delay1.nerim.net (Postfix) with ESMTP id 2C66122E870
	for <git@vger.kernel.org>; Thu, 21 Apr 2011 15:54:09 +0200 (CEST)
Received: from brouette (damien.wyart.pck.nerim.net [213.41.244.197])
	by maiev.nerim.net (Postfix) with ESMTP id DD7232E031;
	Thu, 21 Apr 2011 16:01:32 +0200 (CEST)
Received: by brouette (Postfix, from userid 1000)
	id A8641401186; Thu, 21 Apr 2011 16:01:32 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <7vfwrnis50.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171907>

Hi,

Sorry to wake up an old thread.

* Junio C Hamano <gitster@pobox.com> [2011-02-16 13:30]:
> Yeah, the reverted 83c9031 (unpack_trees(): skip trees that are the
> same in all input, 2010-12-22) also seems to have seriously broken
> intermediate merge merge-recursive makes. I actually recall scratching
> my head when I made 00e6ee7 (Merge branch 'maint', 2011-02-11) that
> was causing add/add conflict when it shouldn't. It turns out that
> quite a lot of entries were missing in contrib/ area from the virtual
> common ancestry tree synthesized by merge-recursive that called into
> the botched unpack_trees()---it of course would result in add/add
> conflict if a merge is done using such a tree as the common.

> No, I haven't had a chance nor energy to dig further than what
> I reported above.

Out of curiosity, I would like to know if digging further into this
issue is still on your TODO list. I feel understanding exactly what was
wrong in 83c9031 would be interesting ; having just the revert is a bit
frustrating.

The initial optimization in 83c9031 seemed right at first glance, so
I would be interesting in having a more final answer to this.


Many thanks in advance,
-- 
Damien Wyart
