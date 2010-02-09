From: Larry D'Anna <larry@elder-gods.org>
Subject: Re: [PATCH v3 2/3] git-push: clean up some of the output from git
 push --porcelain
Date: Tue, 9 Feb 2010 00:48:20 -0500
Message-ID: <20100209054820.GA30907@cthulhu>
References: <214a0317f2e4707a866b2f5d10509296bc1479c1.1265661033.git.larry@elder-gods.org>
 <a1b71c9f6566549e6117f5c98c2f1e60754a7334.1265661033.git.larry@elder-gods.org>
 <7vtytrih7b.fsf@alter.siamese.dyndns.org>
 <7vvde7h1mn.fsf@alter.siamese.dyndns.org>
 <20100208213256.GA470@coredump.intra.peff.net>
 <7viqa7cqs9.fsf@alter.siamese.dyndns.org>
 <20100208223107.GB21718@cthulhu>
 <7vpr4f9wey.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Feb 09 06:48:27 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NeixW-0003rf-MW
	for gcvg-git-2@lo.gmane.org; Tue, 09 Feb 2010 06:48:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752210Ab0BIFsV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Feb 2010 00:48:21 -0500
Received: from cthulhu.elder-gods.org ([140.239.99.253]:47419 "EHLO
	cthulhu.elder-gods.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750881Ab0BIFsV (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Feb 2010 00:48:21 -0500
Received: by cthulhu.elder-gods.org (Postfix, from userid 1000)
	id 5E37682200E; Tue,  9 Feb 2010 00:48:20 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <7vpr4f9wey.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139364>

* Junio C Hamano (gitster@pobox.com) [100208 17:48]:
> *1* As I hinted repeatedly, I think many of them are mere churn, except
> for "don't advice porcelain scripts" (good) and perhaps "exit with failure
> status upon only this kind of failure" (I am undecided).  Especially I
> want to see the "send advice to the standard error stream" one as a
> separate patch, if you insist including that change in the series.

For some reason I thought you wanted the series squashed into one patch.  Here
it is again (to follow) with each discrete change as a single patch, and without
messing with "Everything up-to-date"

        --larry
