From: Steven Grimm <koreth@midwinter.com>
Subject: Re: pull into dirty working tree
Date: Thu, 14 Jun 2007 01:06:21 -0700
Message-ID: <4670F6FD.4060704@midwinter.com>
References: <18031.64456.948230.375333@lisa.zopyra.com>	<alpine.LFD.0.98.0706132216300.14121@woody.linux-foundation.org> <7vps3zascu.fsf@assigned-by-dhcp.pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Bill Lear <rael@zopyra.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jun 14 10:06:09 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HykL9-0006uZ-U8
	for gcvg-git@gmane.org; Thu, 14 Jun 2007 10:06:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751084AbXFNIFz (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 14 Jun 2007 04:05:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751618AbXFNIFy
	(ORCPT <rfc822;git-outgoing>); Thu, 14 Jun 2007 04:05:54 -0400
Received: from 91.86.32.216.static.reverse.layeredtech.com ([216.32.86.91]:42557
	"HELO midwinter.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with SMTP id S1751058AbXFNIFx (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Jun 2007 04:05:53 -0400
Received: (qmail 14758 invoked from network); 14 Jun 2007 08:05:52 -0000
Received: from c-76-21-17-123.hsd1.ca.comcast.net (HELO pinklady.local) (koreth@76.21.17.123)
  by tater.midwinter.com with SMTP; 14 Jun 2007 08:05:52 -0000
User-Agent: Thunderbird 2.0.0.0 (Macintosh/20070326)
In-Reply-To: <7vps3zascu.fsf@assigned-by-dhcp.pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50178>

Junio C Hamano wrote:
> If a bad model _is_ supported, what incentive is there for these
> people to move into the good model, I honestly wonder..

Presumably it's a good model because it's easier, more productive, more 
predictable, more reliable, or some combination of those things; that's 
the incentive. If it's none of those things for a given developer, then 
maybe it's not in fact a better model for them.

Of course, even if it is better for them, some people will never move -- 
but those are the people who won't willingly move to git anyway unless 
the bad model is supported. There are enough of them out there that 
people who *do* want to use the good model, but have to work in an 
environment where they're outnumbered by those other folks, find they 
can't sell the organization on git because it forces a change in work 
style on people who aren't interested in changing their work styles. 
(Not a purely hypothetical statement, sadly.)

You can view this in terms of being a leg up for people who *do* want to 
use git, but are in environments where they are unable to convince or 
force everyone else to adopt git-style workflows. I think it's telling 
that almost all the discussions about this kind of feature are of the 
form, "I'm trying to convince my team to use git, and they find it no 
good because of X." It's the person trying to sell git to the group, 
presumably so they can use it themselves without having to go through a 
CVS or Subversion or p4 gateway, that this stuff really helps. That the 
rest of the team will benefit down the road too is nice but probably not 
the immediate selfish personal goal of the people who are asking for 
this kind of feature.

-Steve
