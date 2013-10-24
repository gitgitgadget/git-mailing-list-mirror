From: Andreas Krey <a.krey@gmx.de>
Subject: Re: [PATCH v2 00/14] Officially start moving to the term 'staging area'
Date: Thu, 24 Oct 2013 10:32:47 +0200
Message-ID: <20131024083247.GA1705@inner.h.apk.li>
References: <1381789769-9893-1-git-send-email-felipe.contreras@gmail.com> <1381789769-9893-4-git-send-email-felipe.contreras@gmail.com> <5261C42E.4050208@gmail.com> <8FC260D94D1A4711AAA8A0DE7477791B@PhilipOakley> <5268706B.4040303@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>
To: Karsten Blees <karsten.blees@gmail.com>
X-From: git-owner@vger.kernel.org Thu Oct 24 10:39:36 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VZGS6-0003rl-Fg
	for gcvg-git-2@plane.gmane.org; Thu, 24 Oct 2013 10:39:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754184Ab3JXIja (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Oct 2013 04:39:30 -0400
Received: from continuum.iocl.org ([217.140.74.2]:59948 "EHLO
	continuum.iocl.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753090Ab3JXIj3 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Oct 2013 04:39:29 -0400
X-Greylist: delayed 395 seconds by postgrey-1.27 at vger.kernel.org; Thu, 24 Oct 2013 04:39:28 EDT
Received: (from krey@localhost)
	by continuum.iocl.org (8.11.3/8.9.3) id r9O8Wl203674;
	Thu, 24 Oct 2013 10:32:47 +0200
Content-Disposition: inline
In-Reply-To: <5268706B.4040303@gmail.com>
User-Agent: Mutt/1.4.2.1i
X-message-flag: What did you expect to see here?
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236571>

On Thu, 24 Oct 2013 02:57:15 +0000, Karsten Blees wrote:
...
> The latter. I don't know about 'broader', but I'll try to summarize _my_ world view:
> 
> (1) Audience matters
> 
> For actual users, we need an accurate model that supports a variety of use cases without falling apart. IMO, a working model is more important than simplicity. Finally, its more important to agree on the actual model than on a vague term that can mean many things (theater stage vs. loading dock...).

Terms almost invariable mean multiple things in different contexts,
and assume new meaning in new fields.

> For potential users / decision makers, we need to describe git's features in unmistakable terms that don't need extra explanation. In this sense, the index / cache / staging area is not a feature in itself but facilitates a variaty of broader features:
> - fine grained commit control (via index (add -i), but also commit -p, commit --amend, cherry-pick, rebase etc.)

The audience will have a hard time understanding what these features
actually do (and how they interact) if we hide the underlying model from
them - they then need to build that model themselves.

And no decision-maker will make the effort to understand either the
operations you mention or the concept of the staging area, unless they
are also users.

...
> An index, as in a library, maps almost perfectly to what the git index is _and_ what we do with it.

No, it doesn't. The git index actually contains the content of the added
files, not just an identity reference. (Unless, maybe, you consider file
sha1s as a reference and not actual content.) The point is that the
index doesn't just contain a mapping from file names to some objects,
but de facto a tree - that will form the next commit.

...
> (3a) Staging area (logistics)
> 
> A staging area, as in (military) logistics / transportation, is about moving physical goods around. You move an item from your stock to the staging area, then onto the truck and finally deliver it to the customer.
> 
> The defining characteristic of a physical good is its physical existence. Each item is uniquely identifiable by a serial number.

Please show me the serial numbers on bullets.

> Problem #1: If an item in the staging area is broken, you fix it directly in the staging area, because that's where it _is_.

That may be true in a physical world, and may not be - you can as well
replace them instead of repairing them in place.

The real problem: You can find some reason why any possible existing
name for this concept isn't correct.

...
> I don't see how a stage (as in a theater) is in any way related to the git index.

It's because the name 'stage (noun)' goes with the verb 'stage'. You
stage a play, or you stage content to be committed. From that, you
may almost call the index just 'stage'.

Andreas

-- 
"Totally trivial. Famous last words."
From: Linus Torvalds <torvalds@*.org>
Date: Fri, 22 Jan 2010 07:29:21 -0800
