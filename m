From: "Stephen R. van den Berg" <srb@cuci.nl>
Subject: Re: [RFC] origin link for cherry-pick and revert
Date: Wed, 10 Sep 2008 01:36:09 +0200
Message-ID: <20080909233609.GD7459@cuci.nl>
References: <20080909132212.GA25476@cuci.nl> <m3zlmhnx1z.fsf@localhost.localdomain> <20080909194354.GA13634@cuci.nl> <20080909195930.GA2785@coredump.intra.peff.net> <7vfxo958tj.fsf@gitster.siamese.dyndns.org> <20080909210917.GA3715@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Sep 10 01:37:21 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KdCls-0005dq-1s
	for gcvg-git-2@gmane.org; Wed, 10 Sep 2008 01:37:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754838AbYIIXgN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Sep 2008 19:36:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754465AbYIIXgL
	(ORCPT <rfc822;git-outgoing>); Tue, 9 Sep 2008 19:36:11 -0400
Received: from aristoteles.cuci.nl ([212.125.128.18]:47071 "EHLO
	aristoteles.cuci.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754748AbYIIXgL (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Sep 2008 19:36:11 -0400
Received: by aristoteles.cuci.nl (Postfix, from userid 500)
	id CE9DA5465; Wed, 10 Sep 2008 01:36:09 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20080909210917.GA3715@coredump.intra.peff.net>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95462>

Jeff King wrote:
>On Tue, Sep 09, 2008 at 02:05:28PM -0700, Junio C Hamano wrote:
>> To be consistent, when you are at HEAD and are merging side branch B,
>> because that merge is to incorporate what happened on the side branch
>> while you are looking the other way, we should say "by the way, the
>> difference between state $(git merge-base HEAD B) and state B was used to
>> make this commit." in the resulting merge commit, shouldn't we?

>I suppose you could, though in that case you can obviously calculate the
>merge base yourself from the parents of the merge. The difference with
>cherry-picking (or rebasing) is that you might not otherwise know about
>the "by the way" commits.

Quite.  The origin link is primarily intended for cherry-picks/reverts
which are otherwise difficult to find.  Anything that can use the normal
parent mechanism has no business using the origin links.
-- 
Sincerely,
           Stephen R. van den Berg.

"Be spontaneous!"
