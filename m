From: tytso@mit.edu
Subject: Re: Why is "git tag --contains" so slow?
Date: Thu, 1 Jul 2010 08:17:11 -0400
Message-ID: <20100701121711.GF1333@thunk.org>
References: <E1OU82h-0001xY-3b@closure.thunk.org>
 <AANLkTikkLIKm3soF9agXnN34P7Xnq4AiVqGU_qFaaRmZ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Avery Pennarun <apenwarr@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jul 01 16:17:54 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OUKaQ-0002m3-Aa
	for gcvg-git-2@lo.gmane.org; Thu, 01 Jul 2010 16:17:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753768Ab0GAORs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 1 Jul 2010 10:17:48 -0400
Received: from thunk.org ([69.25.196.29]:42825 "EHLO thunker.thunk.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752896Ab0GAORr (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 Jul 2010 10:17:47 -0400
Received: from root (helo=closure.thunk.org)
	by thunker.thunk.org with local-esmtp   (Exim 4.50 #1 (Debian))
	id 1OUKaD-0003Em-Q9; Thu, 01 Jul 2010 10:17:41 -0400
Received: from tytso by closure.thunk.org with local (Exim 4.71)
	(envelope-from <tytso@thunk.org>)
	id 1OUIhb-0003Ok-DK; Thu, 01 Jul 2010 08:17:11 -0400
Content-Disposition: inline
In-Reply-To: <AANLkTikkLIKm3soF9agXnN34P7Xnq4AiVqGU_qFaaRmZ@mail.gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on thunker.thunk.org); SAEximRunCond expanded to false
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150038>

On Wed, Jun 30, 2010 at 09:00:21PM -0400, Avery Pennarun wrote:
> 
> There's a big difference between the two: the gitk command you're
> using only works if the given commit is *itself* named by a tag, while
> 'git tag --contains' needs to search the entire history of every tag
> to see if the given commit is *inside* it somewhere.

Gitk provides both.  What I want is listed on the "Preceeds" line in
the lower right hand box (the sixth line from the top in the
per-commit box).

> If all you want is to see if a given commit exactly matches a tag,
> perhaps you want something like
> 
>    git describe --exact-match <commit-id>

Yeah, I'm not talking about the tag and branch names that show up in
the top gitk box (and which you can also get via git log --annotate).
I'm specifically talking about what you get with:

	git tags --contains <commit-id>

							- Ted
