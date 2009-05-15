From: Brian Gernhardt <benji@silverinsanity.com>
Subject: Re: [PATCH] Showing stash state in bash prompt
Date: Fri, 15 May 2009 03:01:44 -0400
Message-ID: <81932ACA-EE6B-4922-9506-13DB5D6EF551@silverinsanity.com>
References: <20090513094448.GC2106@bug.science-computing.de> <20090513112535.GD2106@bug.science-computing.de> <7v4ovo4xyt.fsf@alter.siamese.dyndns.org> <200905142025.02592.trast@student.ethz.ch> <buo1vqrqj2n.fsf@dhlpc061.dev.necel.com> <20090515021105.GA19241@coredump.intra.peff.net> <43d8ce650905142339p266c2f0fye1174036d6251ed0@mail.gmail.com>
Mime-Version: 1.0 (Apple Message framework v935.3)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Cc: Jeff King <peff@peff.net>, Miles Bader <miles@gnu.org>,
	Thomas Rast <trast@student.ethz.ch>,
	Daniel Trstenjak <Daniel.Trstenjak@science-computing.de>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	spearce@spearce.org
To: John Tapsell <johnflux@gmail.com>
X-From: git-owner@vger.kernel.org Fri May 15 09:02:00 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M4rQb-0006c2-Mn
	for gcvg-git-2@gmane.org; Fri, 15 May 2009 09:01:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754674AbZEOHBt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 15 May 2009 03:01:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753861AbZEOHBs
	(ORCPT <rfc822;git-outgoing>); Fri, 15 May 2009 03:01:48 -0400
Received: from vs072.rosehosting.com ([216.114.78.72]:57267 "EHLO
	silverinsanity.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752757AbZEOHBs (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 May 2009 03:01:48 -0400
Received: by silverinsanity.com (Postfix, from userid 5001)
	id 354541FFC1C8; Fri, 15 May 2009 07:01:36 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.2.5 (2008-06-10) on silverinsanity.com
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=4.0 tests=ALL_TRUSTED,AWL,BAYES_00
	autolearn=ham version=3.2.5
Received: from [192.168.1.115] (cpe-74-74-137-205.rochester.res.rr.com [74.74.137.205])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by silverinsanity.com (Postfix) with ESMTPSA id 8E9321FFC1C6;
	Fri, 15 May 2009 07:01:33 +0000 (UTC)
In-Reply-To: <43d8ce650905142339p266c2f0fye1174036d6251ed0@mail.gmail.com>
X-Mailer: Apple Mail (2.935.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119249>


On May 15, 2009, at 2:39 AM, John Tapsell wrote:

>>> I'd often end up in a situation where I'd lose track of whether I  
>>> had
>>> done a stash apply or not, and the risk of inadvertently doing a  
>>> drop
>
> While we're on this - would anyone else like to see a "git unstash" as
> an alias to "git stash apply" ?
> For me it seems more natural to be able to do :
>
> git stash
> something
> git unstash

Try this:

git config --global alias.unstash "stash apply"

~~ B
