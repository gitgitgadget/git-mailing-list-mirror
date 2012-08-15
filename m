From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: Your branch and 'origin/master' have diverged
Date: Wed, 15 Aug 2012 08:59:02 +0200
Message-ID: <87sjbo63pl.fsf@thomas.inf.ethz.ch>
References: <CAE1pOi1WTbMSK8dOus6pFCa2C9vGA8QNE3+8w0LFmGkvcfq5fg@mail.gmail.com>
	<87zk5x6fox.fsf@thomas.inf.ethz.ch>
	<CAE1pOi1YFe9GB1L_==RTecEAipdTKj2-ixpwTnrmOgkkV8rkYw@mail.gmail.com>
	<7v628lbdcw.fsf@alter.siamese.dyndns.org>
	<CAE1pOi2DZNkYYwkH1MFh0m708T=DEdJawZCQgvk1HTGrqjkz2w@mail.gmail.com>
	<87lihh8c7s.fsf@thomas.inf.ethz.ch>
	<7vr4r98ah5.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Cc: Thomas Rast <trast@student.ethz.ch>,
	Hilco Wijbenga <hilco.wijbenga@gmail.com>,
	Git Users <git@vger.kernel.org>, Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Aug 15 08:59:34 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T1XZm-0006Wt-5h
	for gcvg-git-2@plane.gmane.org; Wed, 15 Aug 2012 08:59:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752105Ab2HOG7I (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 15 Aug 2012 02:59:08 -0400
Received: from edge10.ethz.ch ([82.130.75.186]:34286 "EHLO edge10.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751447Ab2HOG7H (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 Aug 2012 02:59:07 -0400
Received: from CAS22.d.ethz.ch (172.31.51.112) by edge10.ethz.ch
 (82.130.75.186) with Microsoft SMTP Server (TLS) id 14.2.298.4; Wed, 15 Aug
 2012 08:59:02 +0200
Received: from thomas.inf.ethz.ch.ethz.ch (129.132.153.233) by CAS22.d.ethz.ch
 (172.31.51.112) with Microsoft SMTP Server (TLS) id 14.2.298.4; Wed, 15 Aug
 2012 08:59:03 +0200
In-Reply-To: <7vr4r98ah5.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
	message of "Tue, 14 Aug 2012 13:49:58 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Originating-IP: [129.132.153.233]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/203463>

Junio C Hamano <gitster@pobox.com> writes:

> Thomas Rast <trast@student.ethz.ch> writes:
>
>> In some sense this is a really bad case of wrong UI design, because we
>> (this happens on #git a lot) have to teach users not to use the command
>> so they won't trip over this problem.  It would be better to fix the
>> real issue instead.  IIRC it was even on the 1.8.0 wishlist...
>
> Is it?
>
> There already is a way to ask it to update the single tracking
> branch while fetching; "git fetch origin master" that
> unconditionally updates refs/remotes/origin/master without a way to
> tell it not to do so will be a grave usability regression.

Grave?  Do you have any data/use-cases to back that up with?

I have never had a need for a fetch that doesn't update the remote
namespace, nor heard anyone on IRC who has.  OTOH, I do have anecdotal
evidence in support of "the current state is confusing": this thread, or
the fact that Jan's IRC bot grew bot-quotes !fetch4/!pull4 that people
use to warn users of 'git pull origin master' (it's apparently very
common).


The 1.8.0 thread is here, and Peff even said he had a patch he uses in
his tree:

http://thread.gmane.org/gmane.comp.version-control.git/165720/focus=165758

There's even a newer thread suggesting the same:

http://thread.gmane.org/gmane.comp.version-control.git/192252

-- 
Thomas Rast
trast@{inf,student}.ethz.ch
