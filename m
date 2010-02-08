From: Larry D'Anna <larry@elder-gods.org>
Subject: Re: [PATCH v3 2/3] git-push: clean up some of the output from git
 push --porcelain
Date: Mon, 8 Feb 2010 17:31:07 -0500
Message-ID: <20100208223107.GB21718@cthulhu>
References: <214a0317f2e4707a866b2f5d10509296bc1479c1.1265661033.git.larry@elder-gods.org>
 <a1b71c9f6566549e6117f5c98c2f1e60754a7334.1265661033.git.larry@elder-gods.org>
 <7vtytrih7b.fsf@alter.siamese.dyndns.org>
 <7vvde7h1mn.fsf@alter.siamese.dyndns.org>
 <20100208213256.GA470@coredump.intra.peff.net>
 <7viqa7cqs9.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Feb 08 23:31:21 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nec8U-0000w4-0F
	for gcvg-git-2@lo.gmane.org; Mon, 08 Feb 2010 23:31:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751543Ab0BHWbK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Feb 2010 17:31:10 -0500
Received: from cthulhu.elder-gods.org ([140.239.99.253]:54143 "EHLO
	cthulhu.elder-gods.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750851Ab0BHWbJ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Feb 2010 17:31:09 -0500
Received: by cthulhu.elder-gods.org (Postfix, from userid 1000)
	id 5A27D82205A; Mon,  8 Feb 2010 17:31:07 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <7viqa7cqs9.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139327>

* Junio C Hamano (gitster@pobox.com) [100208 17:22]:
> Jeff King <peff@peff.net> writes:
> 
> > ... Which means that the original porcelain
> > format was perhaps not very well thought-out.
> > ...
> > now whether to fix it and break compatibility, or leave it broken...
> 
> I think the purpose of the patches that started this thread was to admit
> that 1965ff7 (add --porcelain option to git-push, 2009-06-22) was not well
> thought out, and to break compatibility to fix it.
> 
> Having said that, I would say that what 1965ff7 specified was only these
> two:
> 
>     = TAB refs/heads/master:refs/heads/master TAB [up to date]
>     - TAB :refs/heads/foobar TAB [deleted]


also these

X TAB ...
! TAB ...
* TAB ...
+ TAB ...
SPACE TAB ...

I'll respond to this message with another iteration of the patch.

     --larry
