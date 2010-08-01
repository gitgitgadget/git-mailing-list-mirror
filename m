From: Andreas Schwab <schwab@linux-m68k.org>
Subject: Re: Newbie in Git. How to get back from last pull?
Date: Sun, 01 Aug 2010 11:32:15 +0200
Message-ID: <m2k4oaptk0.fsf@igel.home>
References: <1280649966984-5360499.post@n2.nabble.com>
	<20100801083000.GF26006@kytes> <87bp9mbsp0.fsf@catnip.gol.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Miles Bader <miles@gnu.org>
X-From: git-owner@vger.kernel.org Sun Aug 01 11:32:23 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OfUu6-0002e3-Rl
	for gcvg-git-2@lo.gmane.org; Sun, 01 Aug 2010 11:32:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754416Ab0HAJcS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 1 Aug 2010 05:32:18 -0400
Received: from mail-out.m-online.net ([212.18.0.9]:54679 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753305Ab0HAJcR (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 1 Aug 2010 05:32:17 -0400
Received: from frontend1.mail.m-online.net (unknown [192.168.8.180])
	by mail-out.m-online.net (Postfix) with ESMTP id 32CDE1C154E0;
	Sun,  1 Aug 2010 11:32:16 +0200 (CEST)
Received: from igel.home (ppp-88-217-109-150.dynamic.mnet-online.de [88.217.109.150])
	by mail.mnet-online.de (Postfix) with ESMTP id EF7271C0008D;
	Sun,  1 Aug 2010 11:32:15 +0200 (CEST)
Received: by igel.home (Postfix, from userid 501)
	id 7878DCA297; Sun,  1 Aug 2010 11:32:15 +0200 (CEST)
X-Yow: I appoint you ambassador to Fantasy Island!!!
In-Reply-To: <87bp9mbsp0.fsf@catnip.gol.com> (Miles Bader's message of "Sun,
	01 Aug 2010 18:14:35 +0900")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152374>

Miles Bader <miles@gnu.org> writes:

> Ramkumar Ramachandra <artagnon@gmail.com> writes:
>> I don't understand exactly what you want to do, but here are the
>> basics- you can decide what you want to do.
>> 1. Use `git reflog` to see a history of your operations.
>> 2. If you want your working copy to switch to an existing commit, use
>>    `git checkout <SHA1 of commit>`.
>> 3. If you want to irreversibly destroy everything and switch your
>>    working copy to a desired commit, use `git reset --hard <SHA1 of
>>    commit>`. Use with care!
>
> ... and:  0. In "emergency recovery situations", _back up your whole
> source dir (including .git subdir) somewhere else before screwing
> around_!

IMHO the very first step should be to run "git status" and see what it
says.  With that information it would be much easier to recommend
further steps.

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
