From: Miles Bader <miles@gnu.org>
Subject: Re: way to automatically add untracked files?
Date: Sun, 05 Aug 2007 13:30:03 +0900
Message-ID: <87d4y2li2c.fsf@catnip.gol.com>
References: <873ayymzc1.fsf@catnip.gol.com>
	<fc339e4a0708042100jdf0a0f1jd1fddfb5dc1c1052@mail.gmail.com>
	<20070805041320.GH9527@spearce.org> <87lkcqlif2.fsf@catnip.gol.com>
	<7v8x8qip7n.fsf@assigned-by-dhcp.cox.net>
Reply-To: Miles Bader <miles@gnu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Aug 05 06:30:04 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IHXkh-0000r4-1x
	for gcvg-git@gmane.org; Sun, 05 Aug 2007 06:30:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750914AbXHEE3s (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 5 Aug 2007 00:29:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751349AbXHEE3s
	(ORCPT <rfc822;git-outgoing>); Sun, 5 Aug 2007 00:29:48 -0400
Received: from smtp02.dentaku.gol.com ([203.216.5.72]:48637 "EHLO
	smtp02.dentaku.gol.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750885AbXHEE3r (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 5 Aug 2007 00:29:47 -0400
Received: from 203-216-96-074.dsl.gol.ne.jp ([203.216.96.74] helo=catnip.gol.com)
	by smtp02.dentaku.gol.com with esmtpa (Dentaku)
	id 1IHXkQ-0003XE-Bw; Sun, 05 Aug 2007 13:29:46 +0900
Received: by catnip.gol.com (Postfix, from userid 1000)
	id 6DA0E300F; Sun,  5 Aug 2007 13:30:03 +0900 (JST)
System-Type: i686-pc-linux-gnu
In-Reply-To: <7v8x8qip7n.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's message of "Sat\, 04 Aug 2007 21\:23\:56 -0700")
X-Abuse-Complaints: abuse@gol.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54939>

Junio C Hamano <gitster@pobox.com> writes:
>> Really I want a single command that just tells git "please add to the
>> index _all changes that you can find_".
>
> "git add -u"

So, to _really_ add all changes, I should give two commands:

   git add .
   git add -u

?

(I tried combining them:  "git add -u .", but that didn't seem to do
anything useful)

-Miles
-- 
o The existentialist, not having a pillow, goes everywhere with the book by
  Sullivan, _I am going to spit on your graves_.
