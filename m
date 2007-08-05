From: Miles Bader <miles@gnu.org>
Subject: Re: git-diff new files (without using index)
Date: Sun, 05 Aug 2007 13:00:24 +0900
Message-ID: <87r6miljfr.fsf@catnip.gol.com>
References: <87wswalkad.fsf@catnip.gol.com>
	<20070805035245.GE9527@spearce.org>
Reply-To: Miles Bader <miles@gnu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Aug 05 06:00:11 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IHXHn-0005Mt-B0
	for gcvg-git@gmane.org; Sun, 05 Aug 2007 06:00:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750741AbXHEEAJ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 5 Aug 2007 00:00:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750736AbXHEEAI
	(ORCPT <rfc822;git-outgoing>); Sun, 5 Aug 2007 00:00:08 -0400
Received: from smtp02.dentaku.gol.com ([203.216.5.72]:44040 "EHLO
	smtp02.dentaku.gol.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750721AbXHEEAH (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 5 Aug 2007 00:00:07 -0400
Received: from 203-216-96-074.dsl.gol.ne.jp ([203.216.96.74] helo=catnip.gol.com)
	by smtp02.dentaku.gol.com with esmtpa (Dentaku)
	id 1IHXHh-0000x9-Pd; Sun, 05 Aug 2007 13:00:05 +0900
Received: by catnip.gol.com (Postfix, from userid 1000)
	id 9B5A7300F; Sun,  5 Aug 2007 13:00:24 +0900 (JST)
System-Type: i686-pc-linux-gnu
In-Reply-To: <20070805035245.GE9527@spearce.org> (Shawn O. Pearce's message of "Sat\, 4 Aug 2007 23\:52\:45 -0400")
X-Abuse-Complaints: abuse@gol.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54931>

"Shawn O. Pearce" <spearce@spearce.org> writes:
>> If I add things to the index, I can use "git-diff --cached" to do it;
>> however I'd actually like to be able to do this _without_ updating the
>> index
>
> Use a temporary index:
...
> Another option is to just add everything, then reset the index:
...
> Granted if you had other files staged they just became unstaged
> and will need to be restaged...  the temporary index trick above
> avoids that.

Thanks for the tip (I guess I can roll my own "git-diff-uncached"
script)!

The above sort of quirkiness does seem kind of a wart though; in my
(admittedly limited, using git) experience this sort of thing really
reduces the utility of the index, and I often end up feeling like it's
just getting in the way as a result.  Does adding something like a
"git-diff -N" option seem a _bad_ idea?

Thanks,

-Miles

-- 
"Suppose He doesn't give a shit?  Suppose there is a God but He
just doesn't give a shit?"  [George Carlin]
