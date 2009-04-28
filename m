From: Sitaram Chamarty <sitaramc@gmail.com>
Subject: Re: Git workflow: how to achieve?
Date: Tue, 28 Apr 2009 15:59:56 +0000 (UTC)
Organization: disorganised!
Message-ID: <slrngve9vs.is7.sitaramc@sitaramc.homelinux.net>
References: <49F6AF12.70906@op5.se>
 <20090428140248.31237.qmail@science.horizon.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 28 18:00:24 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LypjJ-0001Et-Rd
	for gcvg-git-2@gmane.org; Tue, 28 Apr 2009 18:00:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761614AbZD1QAM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 Apr 2009 12:00:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761410AbZD1QAL
	(ORCPT <rfc822;git-outgoing>); Tue, 28 Apr 2009 12:00:11 -0400
Received: from main.gmane.org ([80.91.229.2]:55636 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759119AbZD1QAJ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Apr 2009 12:00:09 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1Lypj5-0001yI-Cr
	for git@vger.kernel.org; Tue, 28 Apr 2009 16:00:07 +0000
Received: from atcmail.atc.tcs.co.in ([203.200.212.145])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 28 Apr 2009 16:00:07 +0000
Received: from sitaramc by atcmail.atc.tcs.co.in with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 28 Apr 2009 16:00:07 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: atcmail.atc.tcs.co.in
User-Agent: slrn/0.9.9 (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117795>

On 2009-04-28, George Spelvin <linux@horizon.com> wrote:

> I want, AT ALL TIMES, to be running the kernel consisting of
> Linus's latest plus my various local hacks.  I want to be able to
> freely update any of the components that make up the result,
> and have the sum automatically recomputed for me.

[and]

> (Because I'm currently organized as a linear list of local
> patches on top of upstream.  I'd prefer separate feature
> branches plus merges, but that's what I'm asking how to make
> work efficiently.)

I'll freely admit I'm focusing on just those two paras out
of a fairly long email, but topgit does precisely this.
I've started to use it, and it seems to do the job well.
When a feature branch gets updated, you just check out what
I will call "t/all" and do a "tg update" and it picks up the
new stuff.

So the everyday stuff works.

The only sort-of-open question, right now, is how do you
remove a dependency when one of your "local hacks" grows up
and goes off to college.  Er... I mean gets accepted
upstream :-)

My guess is that as long as all these local hacks are indeed
local, the branch that represents the "sum total" can be
blown away and rebuilt when that happens; you'd just list
all but the recently graduated feature as dependencies.

Regards,

Sitaram
