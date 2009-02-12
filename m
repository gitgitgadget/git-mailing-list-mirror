From: Miles Bader <miles@gnu.org>
Subject: Re: [PATCH] stash: --keep option just saves
Date: Thu, 12 Feb 2009 14:01:37 +0900
Message-ID: <buovdrgckpa.fsf@dhlpc061.dev.necel.com>
References: <20090212062514.6117@nanako3.lavabit.com>
	<7vljscbp60.fsf@gitster.siamese.dyndns.org>
Reply-To: Miles Bader <miles@gnu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Nanako Shiraishi <nanako3@lavabit.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Feb 12 06:04:27 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LXTkQ-0006tm-B6
	for gcvg-git-2@gmane.org; Thu, 12 Feb 2009 06:04:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750770AbZBLFC6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Feb 2009 00:02:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750721AbZBLFC6
	(ORCPT <rfc822;git-outgoing>); Thu, 12 Feb 2009 00:02:58 -0500
Received: from TYO202.gate.nec.co.jp ([202.32.8.206]:54513 "EHLO
	tyo202.gate.nec.co.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750703AbZBLFC5 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Feb 2009 00:02:57 -0500
Received: from relay31.aps.necel.com ([10.29.19.54])
	by tyo202.gate.nec.co.jp (8.13.8/8.13.4) with ESMTP id n1C51b65021175;
	Thu, 12 Feb 2009 14:01:37 +0900 (JST)
Received: from relay11.aps.necel.com ([10.29.19.20] [10.29.19.20]) by relay31.aps.necel.com with ESMTP; Thu, 12 Feb 2009 14:01:37 +0900
Received: from dhlpc061 ([10.114.112.240] [10.114.112.240]) by relay11.aps.necel.com with ESMTP; Thu, 12 Feb 2009 14:01:37 +0900
Received: by dhlpc061 (Postfix, from userid 31295)
	id C073D52E2F8; Thu, 12 Feb 2009 14:01:37 +0900 (JST)
System-Type: x86_64-unknown-linux-gnu
Blat: Foop
In-Reply-To: <7vljscbp60.fsf@gitster.siamese.dyndns.org> (Junio C. Hamano's
	message of "Wed, 11 Feb 2009 14:10:31 -0800")
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109575>

Junio C Hamano <gitster@pobox.com> writes:
> This one, the "snapshot", and various other related topics, are quite
> different.  The workflow the --keep (and for that matter, "snapshot")
> would support I can think of does not sound a very good one we would want
> to recommend (--untracked is a different issue; I haven't formed an
> opinion).
>
> You build on a branch, but you are forever in the state of indecision, and
> instead of committing, you keep saying "save --keep" number of times to
> leave a checkpoint on your stash.  After number of iterations, you may
> have many stashes in "git stash list", but what you can do with them is
> "git reset --hard && git stash apply stash@{$n}" to go back to any of the
> state, but that is about it.

Yeah, but that's a pretty useful thing.

I often save checkpoints of my working state before starting a
tentative/intrusive series of edits -- if they are clearly just part
of a larger logical change, I may not want to make separate commits
[or perhaps more commonly, I'm not entirely sure what the final commit
will be like, and am still "exploring"].

Of course this can also be done in git by doing temporary commits
(to be changed later with --amend, or rolled back before making the
real commit), or whatever, but I think pretty much every usage of
git-stash can be done fairly easily via some other means in git;
git-stash is really just a convenience.

-miles

-- 
Politeness, n. The most acceptable hypocrisy.
