From: Clemens Buchacher <drizzd@aon.at>
Subject: Re: [PATCH v5 3/4] git-cherry-pick: Add test to validate new options
Date: Tue, 17 Apr 2012 23:38:52 +0200
Message-ID: <20120417213851.GA20082@ecki>
References: <1333136922-12872-1-git-send-email-nhorman@tuxdriver.com>
 <1334342707-3326-1-git-send-email-nhorman@tuxdriver.com>
 <1334342707-3326-4-git-send-email-nhorman@tuxdriver.com>
 <20120415093933.GB6263@ecki>
 <20120416161431.GD13366@hmsreliant.think-freely.org>
 <7vvckzws73.fsf@alter.siamese.dyndns.org>
 <20120416165024.GF13366@hmsreliant.think-freely.org>
 <20120416214247.GA5606@ecki>
 <20120417105604.GB11462@hmsreliant.think-freely.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Jeff King <peff@peff.net>, Phil Hord <phil.hord@gmail.com>
To: Neil Horman <nhorman@tuxdriver.com>
X-From: git-owner@vger.kernel.org Tue Apr 17 23:58:47 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SKGQA-0004J3-8K
	for gcvg-git-2@plane.gmane.org; Tue, 17 Apr 2012 23:58:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752073Ab2DQV6m (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Apr 2012 17:58:42 -0400
Received: from bsmtp.bon.at ([213.33.87.14]:48647 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751683Ab2DQV6l (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Apr 2012 17:58:41 -0400
Received: from [127.0.0.1] (p5B22CC82.dip.t-dialin.net [91.34.204.130])
	by bsmtp.bon.at (Postfix) with ESMTP id 7AD9BCDF88;
	Tue, 17 Apr 2012 23:59:18 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20120417105604.GB11462@hmsreliant.think-freely.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195812>

On Tue, Apr 17, 2012 at 06:56:04AM -0400, Neil Horman wrote:
> On Mon, Apr 16, 2012 at 11:42:49PM +0200, Clemens Buchacher wrote:
> > 
> > It seems that I was implying a lot more than I realized. What I meant
> > was that master and empty-branch2 are equivalent for the purposes of
> > that test (empty-branch2^ also is a non-empty commit [*1*]), but while
> > master is a moving target, empty-branch2 is untouched. 
> > 
> for the purposes of the --keep-redundant-commits however, the target is
> irrelevant.  The only requirement is that we cherry-pick a commit that is
> guaranteed to become empty when applied.

That we agree on.

> We certainly could do that on empty branch2, but theres no advantage
> to doing so,

The advantage is that I do not have to read the other tests in order to
understand what this test does, because contrary to the master branch,
they do not modify empty-branch2.

> and given that every other test attempts to cherry-pick to master, I
> rather like the consistency.

We could also consistently not use the master branch.

> > However, I just notice that empty-branch2 is also the root commit, so
> > maybe this will not work after all. But that should be easy to fix.
>
> It is easy to fix, given your clarified description above, its just that IMO,
> its not broken.

Well, I don't mind too badly if this doesn't go may way. But I hope that
I managed at least to explain my point.
