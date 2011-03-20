From: Shawn Pearce <spearce@spearce.org>
Subject: Re: Histogram diff, libgit2 enhancement, libgit2 => git merge (GSOC)
Date: Sun, 20 Mar 2011 11:06:48 -0700
Message-ID: <AANLkTi=6z=4m8opfhy9pV1S6ySobSA+WEEESESOJ0MZ4@mail.gmail.com>
References: <op.vsm1yszq2m56ex@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org
To: Pavel Raiskup <xraisk00@gmail.com>
X-From: git-owner@vger.kernel.org Sun Mar 20 19:07:36 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q1N2M-00025w-LJ
	for gcvg-git-2@lo.gmane.org; Sun, 20 Mar 2011 19:07:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752053Ab1CTSHK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 20 Mar 2011 14:07:10 -0400
Received: from mail-vx0-f174.google.com ([209.85.220.174]:32852 "EHLO
	mail-vx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752006Ab1CTSHI (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 20 Mar 2011 14:07:08 -0400
Received: by vxi39 with SMTP id 39so4727234vxi.19
        for <git@vger.kernel.org>; Sun, 20 Mar 2011 11:07:08 -0700 (PDT)
Received: by 10.52.91.166 with SMTP id cf6mr4488712vdb.192.1300644428072; Sun,
 20 Mar 2011 11:07:08 -0700 (PDT)
Received: by 10.52.164.105 with HTTP; Sun, 20 Mar 2011 11:06:48 -0700 (PDT)
In-Reply-To: <op.vsm1yszq2m56ex@localhost.localdomain>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169516>

On Sun, Mar 20, 2011 at 03:55, Pavel Raiskup <xraisk00@gmail.com> wrote:
> I'd like to ask you for some details about "histogram diff" and "libgit"
> enhancement/git-merge tasks for this year's GSOC.
>
> Histogram diff:
> There is no mentor mentioned in [1]. Does it mean that there is no person
> who can be a mentor for this task or is that assignment possible to be
> mentored by everyone mentioned in other tasks? I'd like to do this task very
> much. After doing a small observing around source code of git/jgit it looks
> feasible for me.

As the original author of HistogramDiff in JGit, and a contributor to
C Git... I'm probably the best person to mentor this task. I'm really
busy, so I didn't sign up to mentor anything else this year, but I
think I would make time for this project.

> There is a goal "Get this feature merged to the upstream git." -- but I have
> one theoretical question -- what if the benchmarking/study of histogram diff
> leads to conclusion that this algorithm will not be useful for upstream?

Then the project doesn't merge. :-)

> Does it mean "fail" in terms of GSOC? I have to think about it even if it
> looks that there should be speedup quite obvious. I don't want to fail
> a priory :).

I don't think so

I think the success of this project is if the code is of the quality
that upstream would accept it, and if the final analysis data makes it
clear whether or not its worth including. Its probably not worth
including if its the same speed as the current Myers diff
implementation from libxdiff or slower. But if its 2x faster, its
probably worth merging. If the code quality is acceptable to the
upstream maintainers.

> [1] https://git.wiki.kernel.org/index.php/SoC2011Ideas

-- 
Shawn.
