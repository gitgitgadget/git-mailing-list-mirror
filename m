From: Nanako Shiraishi <nanako3@lavabit.com>
Subject: Re: [RFC] pull/fetch rename
Date: Wed, 21 Oct 2009 06:42:43 +0900
Message-ID: <20091021064243.6117@nanako3.lavabit.com>
References: <200910201947.50423.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: <git@vger.kernel.org>, Bjrn Steinbrink <B.Steinbrink@gmx.de>
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Tue Oct 20 23:43:03 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N0MTu-0007IE-Rx
	for gcvg-git-2@lo.gmane.org; Tue, 20 Oct 2009 23:43:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751987AbZJTVmw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 20 Oct 2009 17:42:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751591AbZJTVmw
	(ORCPT <rfc822;git-outgoing>); Tue, 20 Oct 2009 17:42:52 -0400
Received: from karen.lavabit.com ([72.249.41.33]:42600 "EHLO karen.lavabit.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751470AbZJTVmv (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Oct 2009 17:42:51 -0400
Received: from c.earth.lavabit.com (c.earth.lavabit.com [192.168.111.12])
	by karen.lavabit.com (Postfix) with ESMTP id 834DB11B833;
	Tue, 20 Oct 2009 16:42:56 -0500 (CDT)
Received: from 7945.lavabit.com (customer-148-233-239-23.uninet.net.mx [148.233.239.23])
	by lavabit.com with ESMTP id UPEKVNO7WZGP; Tue, 20 Oct 2009 16:42:56 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws; s=lavabit; d=lavabit.com;
  b=CVB6v/1ombz2lcWnov2kexiDQLtcbbQy9tpP7RoHuGWa5RqaYWfsn3nLwSKAh5VSUI9AJOCfbSBXysbN7WEIvheWreTvvxJIWnx2hx6gm6wm6A8SUzb7eNR5dzr46Onp8aRMJ8Ak9oTXE7V4SjPJH7GWcMQOpTcWzGsPxvf/QK4=;
  h=From:To:Cc:Subject:References:In-Reply-To:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id;
In-Reply-To: <200910201947.50423.trast@student.ethz.ch>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130853>

Quoting Thomas Rast <trast@student.ethz.ch>

> Especially on IRC, we see many people who are some combination of
> misunderstanding, misusing or overusing git-pull.  I figure this is
> the result of several factors, notably
>
> a) pull/push are not symmetric,
>
> b) guides/tutorials recommend pull for situations where they
>    shouldn't,
>
> c) people blindly fire commands at git.
>
> While the latter two are probably hopeless, I find (a) rather
> annoying.  It breaks everyone's intuition of git-pull when they first
> see it.  (I know that BK has a pull that also merges, but I gather
> from the manual [never used it] that you cannot do the equivalent of
> git-fetch in BK.)
>
> As you probably guessed by now, here is an idea for a very aggressive
> transition plan to address (a) in four phases:
>
> 1. git-fetch gets options --merge/-m and --rebase that make it behave
>    like (current) git-pull, but requiring explicit arguments.
>    git-pull gets a new option --merge (-m) that only enforces presence
>    of arguments.
>
> 2. git-pull refuses to do any work unless given either --merge or
>    --rebase.  Deprecation warnings for this start at the same time as
>    (1.).
>
> 3. git-pull becomes a synonym for git-fetch.
>
> 4. git-fetch gives deprecation warnings that point the user to
>    git-pull instead.
>
> (1.) is probably harmless and could be put into any particular
> release.  (2.) obviously breaks everyone's favourite script and needs
> to fall on a major release.  (3.) should be delayed significantly from
> (2.) to allow time to expose such breakage, and similarly (4.) should
> be delayed after (3.) (or just ignored, but in any case git-pull would
> become the preferred spelling).

Sorry, but I don't understand what's the improvement in the end 
result.

I started reading your problem description and I thought you are 
fixing your item 'a) pull/push are not symmetric' by deprecating 
pull, to advertize fetch/push.  Then asymmetry of push/pull stops 
being an issue.

But it seems that eventually you will keep git-push and git-pull 
(because git-fetch gets deprecated); you have push/pull that are 
not symmetric.

What's the point of this change then?

-- 
Nanako Shiraishi
http://ivory.ap.teacup.com/nanako3/
