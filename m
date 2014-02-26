From: lists@haller-berlin.de (Stefan Haller)
Subject: Re: `git stash pop` UX Problem
Date: Wed, 26 Feb 2014 11:24:00 +0100
Message-ID: <1lho9x8.1qh70zkp477M%lists@haller-berlin.de>
References: <xmqqvbw24yt3.fsf@gitster.dls.corp.google.com>
Cc: git@vger.kernel.org
To: gitster@pobox.com (Junio C Hamano),
	stephen_leake@stephe-leake.org (Stephen Leake)
X-From: git-owner@vger.kernel.org Wed Feb 26 11:30:51 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WIblJ-0004wa-Vf
	for gcvg-git-2@plane.gmane.org; Wed, 26 Feb 2014 11:30:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752394AbaBZKal (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 26 Feb 2014 05:30:41 -0500
Received: from server90.greatnet.de ([83.133.96.186]:54012 "EHLO
	server90.greatnet.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752408AbaBZKaj (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 Feb 2014 05:30:39 -0500
X-Greylist: delayed 399 seconds by postgrey-1.27 at vger.kernel.org; Wed, 26 Feb 2014 05:30:39 EST
Received: from [10.1.12.70] (nat1.ableton.net [217.110.199.117])
	by server90.greatnet.de (Postfix) with ESMTPA id 43C063B0DAF;
	Wed, 26 Feb 2014 11:23:59 +0100 (CET)
In-Reply-To: <xmqqvbw24yt3.fsf@gitster.dls.corp.google.com>
User-Agent: MacSOUP/2.8.4 (Mac OS X version 10.9.2 (x86))
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242709>

Junio C Hamano <gitster@pobox.com> wrote:

> Stephen Leake <stephen_leake@stephe-leake.org> writes:
> 
> >> Dropping the stash on a "git add" operation would be really, really
> >> weird...
> >
> > Why? That is when the merge conflicts are resolved, which is what
> > logically indicates that the stash is no longer needed,...
> 
> Not necessarily.  Imagine a case where you used stash to quickly
> save away a tangled mess that was not ready for a logically single
> commit and now you are in the process of creating the first commit
> by applying it piece-by-piece to create multiple resulting ones.
> After you commit the result, you would still want to keep the parts
> of that stashed change you did not include in the first commit so
> that you can go back, no?
> 
> You may run "git add", but that does not say anything about what you
> are going to use the rest of the stash for.  Not even "git commit"
> may be a good enough sign.

But we are only talking about the situation where you typed "git stash
pop", and this resulted in a merge conflict. Your intention was clearly
to drop the stash, it just wasn't dropped because of the conflict.
Dropping it automatically once the conflict is resolved would be nice.

I know it happened to me too that I forgot to drop a stash after
resolving conflicts, so I'd appreciate a feature that somehow does this
automatically for me.


-- 
Stefan Haller
Berlin, Germany
http://www.haller-berlin.de/
