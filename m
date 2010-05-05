From: Gelonida <gelonida@gmail.com>
Subject: Re: how to squash a few commits in the past
Date: Wed, 05 May 2010 23:41:10 +0200
Message-ID: <4BE1E5F6.3040606@gmail.com>
References: <loom.20100503T112508-677@post.gmane.org> <4BDEA0D7.9090201@drmicha.warpmail.net> 	<hrncm3$pg8$1@dough.gmane.org> <hrnem4$1m0$1@dough.gmane.org> <w2zf3271551005050619td67d697y97d7e9181c4496fc@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Michael J Gruber <git@drmicha.warpmail.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 05 23:41:28 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O9mLO-0008Pe-MY
	for gcvg-git-2@lo.gmane.org; Wed, 05 May 2010 23:41:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758752Ab0EEVlU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 May 2010 17:41:20 -0400
Received: from lo.gmane.org ([80.91.229.12]:43221 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758666Ab0EEVlT (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 May 2010 17:41:19 -0400
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1O9mLG-0008KO-Ru
	for git@vger.kernel.org; Wed, 05 May 2010 23:41:18 +0200
Received: from unicorn.dungeon.de ([81.56.82.123])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 05 May 2010 23:41:18 +0200
Received: from gelonida by unicorn.dungeon.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 05 May 2010 23:41:18 +0200
X-Injected-Via-Gmane: http://gmane.org/
connect(): No such file or directory
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: unicorn.dungeon.de
User-Agent: Thunderbird 2.0.0.24 (X11/20100411)
In-Reply-To: <w2zf3271551005050619td67d697y97d7e9181c4496fc@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146424>

Hi Ragu,

Ramkumar Ramachandra wrote:
> Hi,
> 
> On Mon, May 3, 2010 at 11:20 PM, Gelonida <gelonida@gmail.com> wrote:
>> Is it normal, that git gets lost wehn rebasing such a structure.
> 
> While performing an interactive rebase, conflicts can often occur and
> this is quite normal.
> 
>>> Automatic cherry-pick failed.  After resolving the conflicts,
>>> mark the corrected paths with 'git add <paths>', and
>>> run 'git rebase --continue'
>>> Could not apply 67f3f6d... preparation for #241
> 
> The problem and solution is described in that message. Open the file,
> resolve the conflict and continue the rebase operation.



Yes merging manually could be a theortical solution, but I really don't
understand, why I should merge anything at all.



The history is purely linear at the places where I want to squash.

These two commits precede a few more consecutive commits, traverse then
a tree which forks to multiple branches, which partially cherrypick from
each other and will then join again to a unique linear sequence.

If I have a history of several hundred commits and I am asked several
times to merge, just because I want to squash two consecutve commits
without any branches going out or in, then something (probably the way I
try to attack the problem or much less likely a mysterious git bug) is
kind of wrong.



I'm still looking for a solution, where I specify only the commits to be
squashed and everything else stays untouched without any further
userinteraction
