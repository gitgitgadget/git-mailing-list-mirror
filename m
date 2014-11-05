From: Joe Perches <joe@perches.com>
Subject: Re: Odd git am behavior rewriting subject, adding "ASoC: " prefix
Date: Wed, 05 Nov 2014 05:51:43 -0800
Message-ID: <1415195503.6634.7.camel@perches.com>
References: <1415149921.6634.1.camel@perches.com>
	 <CAFOYHZAimkSMWC42S_C=OkNuz+cjT3vhsGo6AwuCtt8M2REkig@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git <git@vger.kernel.org>
To: Chris Packham <judge.packham@gmail.com>
X-From: git-owner@vger.kernel.org Wed Nov 05 14:51:56 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xm104-00065t-Eb
	for gcvg-git-2@plane.gmane.org; Wed, 05 Nov 2014 14:51:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754713AbaKENvs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Nov 2014 08:51:48 -0500
Received: from smtprelay0132.hostedemail.com ([216.40.44.132]:59173 "EHLO
	smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1753644AbaKENvr (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 5 Nov 2014 08:51:47 -0500
Received: from filter.hostedemail.com (unknown [216.40.38.60])
	by smtprelay04.hostedemail.com (Postfix) with ESMTP id 283BD351F77;
	Wed,  5 Nov 2014 13:51:46 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,:::,RULES_HIT:41:355:379:541:599:800:960:973:988:989:1260:1277:1311:1313:1314:1345:1359:1373:1437:1515:1516:1518:1534:1537:1567:1593:1594:1711:1714:1730:1747:1777:1792:2393:2553:2559:2562:2828:3138:3139:3140:3141:3142:3622:3865:3866:3873:3874:4321:5007:6119:6261:7903:10004:10400:10848:11232:11658:11914:12517:12519:12740:13069:13311:13357:21080,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:fn,MSBL:0,DNSBL:none,Custom_rules:0:0:0
X-HE-Tag: move04_498d0da79b33d
X-Filterd-Recvd-Size: 1245
Received: from joe-X200MA.home (pool-71-103-235-196.lsanca.fios.verizon.net [71.103.235.196])
	(Authenticated sender: joe@perches.com)
	by omf02.hostedemail.com (Postfix) with ESMTPA;
	Wed,  5 Nov 2014 13:51:45 +0000 (UTC)
In-Reply-To: <CAFOYHZAimkSMWC42S_C=OkNuz+cjT3vhsGo6AwuCtt8M2REkig@mail.gmail.com>
X-Mailer: Evolution 3.12.7-0ubuntu1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, 2014-11-05 at 22:12 +1300, Chris Packham wrote:
> On Wed, Nov 5, 2014 at 2:12 PM, Joe Perches <joe@perches.com> wrote:
> > I have a patch file created by git format-patch.
[]
> > ASoC:? where does that come from?
[]
> Looks like you have an apply-patch-msg hook installed. What does the
> output of 'ls -l .git/hooks' look like.

Correct.  I didn't look there.  Thanks. 
