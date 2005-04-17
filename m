From: randy_dunlap <rdunlap@xenotime.net>
Subject: Re: Re-done kernel archive - real one?
Date: Sun, 17 Apr 2005 15:22:18 -0700
Organization: YPO4
Message-ID: <20050417152218.3501f2f1.rdunlap@xenotime.net>
References: <Pine.LNX.4.58.0504161543590.7211@ppc970.osdl.org>
	<1113774736.3884.4.camel@localhost.localdomain>
	<Pine.LNX.4.58.0504171511210.7211@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: dwmw2@infradead.org, git@vger.kernel.org, hpa@zytor.com
X-From: git-owner@vger.kernel.org Mon Apr 18 00:18:50 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DNI6G-00012e-57
	for gcvg-git@gmane.org; Mon, 18 Apr 2005 00:18:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261525AbVDQWWg (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 17 Apr 2005 18:22:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261526AbVDQWWg
	(ORCPT <rfc822;git-outgoing>); Sun, 17 Apr 2005 18:22:36 -0400
Received: from titan.genwebhost.com ([209.9.226.66]:8421 "EHLO
	titan.genwebhost.com") by vger.kernel.org with ESMTP
	id S261525AbVDQWWd (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 17 Apr 2005 18:22:33 -0400
Received: from wbar2.sea1-4-5-049-023.sea1.dsl-verizon.net ([4.5.49.23] helo=midway.verizon.net)
	by titan.genwebhost.com with esmtpa (Exim 4.44)
	id 1DNI9y-0004s0-Ad; Sun, 17 Apr 2005 18:22:35 -0400
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0504171511210.7211@ppc970.osdl.org>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - titan.genwebhost.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - xenotime.net
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Sun, 17 Apr 2005 15:17:50 -0700 (PDT) Linus Torvalds wrote:

| 
| 
| On Mon, 18 Apr 2005, David Woodhouse wrote:
| > 
| > Do you want the commits list running for it yet? Do you want the
| > changesets which are already in it re-mailed without a 'TESTING' tag?
| 
| I really don't know. I'm actually very happy where this thing is right
| now, and completing that first merge successfully was a big milestone to
| me personally. That said, actually _using_ this thing is not for the
| faint-of-heart, and while I think "git" already is showing itself to be
| useful, I'm very very biased.
| 
| In other words, I really wonder what an outsider that doesn't have the
| same kind of mental bias thinks of the current git tree. Is it useful, or
| is it still just a toy for Linus to test out his crazy SCM-wannabe.
| 
| Can people usefully track my current kernel git repository, or do you have
| to be crazy to do so? That's really the question. You be the judge. Me,
| I'm just giddy from a merge that was clearly done using interfaces that
| aren't actually really usable for anybody but me, and barely me at that ;)

TBD...

| 		Linus
| 
| Btw, I also do want this to show up in the BK trees for people who use 
| BitKeeper - the same way we always supported tar-ball + patch users 
| before. So I'll have to try to come up with some sane way to do that too. 
| Any ideas? The first series of 198 patches is obvious enough and can be 
| just done that way direcly, but the merge..

David did the commits-mailing-list script and I'm working on a
commits web-page like what was formerly seen at:
http://www.kernel.org/pub/linux/kernel/v2.6/testing/cset/
(with daily tarball)

based on some older scripts from David, however I'm wondering if
a variant of the gitlog.sh script wouldn't be a better starting
point for it.

---
~Randy
