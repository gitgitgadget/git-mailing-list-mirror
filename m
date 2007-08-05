From: Miles Bader <miles@gnu.org>
Subject: Re: way to automatically add untracked files?
Date: Sun, 05 Aug 2007 13:22:25 +0900
Message-ID: <87lkcqlif2.fsf@catnip.gol.com>
References: <873ayymzc1.fsf@catnip.gol.com>
	<fc339e4a0708042100jdf0a0f1jd1fddfb5dc1c1052@mail.gmail.com>
	<20070805041320.GH9527@spearce.org>
Reply-To: Miles Bader <miles@gnu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Aug 05 06:22:14 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IHXd7-0008G8-Dy
	for gcvg-git@gmane.org; Sun, 05 Aug 2007 06:22:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751255AbXHEEWL (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 5 Aug 2007 00:22:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751349AbXHEEWJ
	(ORCPT <rfc822;git-outgoing>); Sun, 5 Aug 2007 00:22:09 -0400
Received: from smtp02.dentaku.gol.com ([203.216.5.72]:55905 "EHLO
	smtp02.dentaku.gol.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750773AbXHEEWI (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 5 Aug 2007 00:22:08 -0400
Received: from 203-216-96-074.dsl.gol.ne.jp ([203.216.96.74] helo=catnip.gol.com)
	by smtp02.dentaku.gol.com with esmtpa (Dentaku)
	id 1IHXd0-00030o-8c; Sun, 05 Aug 2007 13:22:06 +0900
Received: by catnip.gol.com (Postfix, from userid 1000)
	id 58639300F; Sun,  5 Aug 2007 13:22:25 +0900 (JST)
System-Type: i686-pc-linux-gnu
In-Reply-To: <20070805041320.GH9527@spearce.org> (Shawn O. Pearce's message of "Sun\, 5 Aug 2007 00\:13\:20 -0400")
X-Abuse-Complaints: abuse@gol.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54937>

"Shawn O. Pearce" <spearce@spearce.org> writes:
>>     mv foo.cc bar.cc
>>     git add .
>
> Right.  Who wants "add" to actually mean "add and delete"?
> Shouldn't that be then called "git-add-and-rm"?

"git-add ." can just as easily be thought as meaning "add the current
state of directory ".", including additions and removals"; removals,
are, after all, part of the directory's state.

>> Am I doing something wrong, or is this just missing functionality?
>
> Try adding the -M option to "git-diff".  That will enable the rename
> detection, and show the rename you are looking to see.

No, it doesn't.

The problem seems to be not because git's rename detection isn't enabled
(I have it turned on by default in my globaing settings), but rather
because git hasn't been told about the removal.

And I don't see anyway to automatically tell git "please mark for
removal all files that seem to have disappeared" -- "git-add ." doesn't do
it, and git-rm doesn't seem to have any option for doing this.

Really I want a single command that just tells git "please add to the
index _all changes that you can find_".

Thanks,

-Miles

-- 
A zen-buddhist walked into a pizza shop and
said, "Make me one with everything."
