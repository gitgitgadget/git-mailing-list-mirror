From: Nanako Shiraishi <nanako3@lavabit.com>
Subject: Re: What's cooking in git.git (topics)
Date: Fri, 18 Jul 2008 18:20:10 +0900
Message-ID: <20080718182010.6117@nanako3.lavabit.com>
References: <7vr69r8sqk.fsf@gitster.siamese.dyndns.org>
 <7vlk01hqzz.fsf@gitster.siamese.dyndns.org>
 <20080718175040.6117@nanako3.lavabit.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jul 18 11:22:17 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KJmAD-0001PY-NH
	for gcvg-git-2@gmane.org; Fri, 18 Jul 2008 11:22:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752954AbYGRJVG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 Jul 2008 05:21:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753543AbYGRJVF
	(ORCPT <rfc822;git-outgoing>); Fri, 18 Jul 2008 05:21:05 -0400
Received: from karen.lavabit.com ([72.249.41.33]:41519 "EHLO karen.lavabit.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752954AbYGRJVE (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Jul 2008 05:21:04 -0400
Received: from c.earth.lavabit.com (c.earth.lavabit.com [192.168.111.12])
	by karen.lavabit.com (Postfix) with ESMTP id 85BA4C840E;
	Fri, 18 Jul 2008 04:20:54 -0500 (CDT)
Received: from nanako3.lavabit.com (212.62.97.21)
	by lavabit.com with ESMTP id 7IYYQ8F2NNHE; Fri, 18 Jul 2008 04:21:02 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws; s=lavabit; d=lavabit.com;
  b=aUFOgl7d1D0W+HliLWcIDJuvBV4bPaHSEdtPA+Af2Hxo+0WUPUlLGV4Nd9RqhC2YZRTqZjbihJyaxMWN89beM6+SWs1oTAVb8Wd5/XkyUQIsyD4RLTwZup5az47hiiITMdUH9x7+IjXs0MiLnNBd4UT2yOfF9i4KzgX8ibyYp6c=;
  h=From:Subject:To:Cc:Date:In-Reply-To:References:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Quoting Junio C Hamano <gitster@pobox.com>;
In-Reply-To: <7vr69r8sqk.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89019>

Quoting Junio C Hamano <gitster@pobox.com>:

> Well, for one thing, I do not believe in their cause.  As I wrote in the
> log messages for these commits (actually not these above which is a series
> for merge fixup, but the other topic), I do not think it is a sensible
> thing to say "let's take as much automerge results as possible to salvage
> our changes where they do not overlap with what the upstream did, but I
> would give up our changes to places that the upstream also touched,
> because I do not understand what they did well enough to be able to
> resolve the merge conflicts correctly", and "merge -Xtheirs" is exactly
> that.

I do not know if "I do not understand what they did well enough" is the only reason people would want to use that feature. Isn't it better to let people decide that for themselves?

> That also was the reason I did not add any documentation to it.  But I do
> like the change to the infrastructure to allow passing strategy-specific
> options through git-merge and git-pull.  Perhaps I should write something
> up, if only to salvage that -X<option> part, even though I am very much
> inclined to discard -Xtheirs (and -Xours) part.

I think such a documentation will help people to decide if 'theirs' option makes sense for their workflow.

-- 
Nanako Shiraishi
http://ivory.ap.teacup.com/nanako3/
