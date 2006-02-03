From: Junio C Hamano <junkio@cox.net>
Subject: Re: The merge from hell...
Date: Thu, 02 Feb 2006 22:33:54 -0800
Message-ID: <7v1wylj6i5.fsf@assigned-by-dhcp.cox.net>
References: <F7DC2337C7631D4386A2DF6E8FB22B3005EFE838@hdsmsx401.amr.corp.intel.com>
	<Pine.LNX.4.64.0602022210540.3462@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Brown, Len" <len.brown@intel.com>,
	Git Mailing List <git@vger.kernel.org>,
	Paul Mackerras <paulus@samba.org>,
	Marco Costalba <mcostalba@yahoo.it>,
	Aneesh Kumar <aneesh.kumar@gmail.com>
X-From: git-owner@vger.kernel.org Fri Feb 03 07:34:02 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F4uW7-0003qs-HM
	for gcvg-git@gmane.org; Fri, 03 Feb 2006 07:33:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932355AbWBCGd5 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 3 Feb 2006 01:33:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932506AbWBCGd5
	(ORCPT <rfc822;git-outgoing>); Fri, 3 Feb 2006 01:33:57 -0500
Received: from fed1rmmtao01.cox.net ([68.230.241.38]:1725 "EHLO
	fed1rmmtao01.cox.net") by vger.kernel.org with ESMTP
	id S932355AbWBCGd4 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 Feb 2006 01:33:56 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao01.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060203063251.VNNV15695.fed1rmmtao01.cox.net@assigned-by-dhcp.cox.net>;
          Fri, 3 Feb 2006 01:32:51 -0500
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0602022210540.3462@g5.osdl.org> (Linus Torvalds's
	message of "Thu, 2 Feb 2006 22:16:05 -0800 (PST)")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15531>

Linus Torvalds <torvalds@osdl.org> writes:

> On Fri, 3 Feb 2006, Brown, Len wrote:
>>
>> In the back of my head I was worried about using plain
>> numbers when I saw somebody refer to "shorthand SHA1".
>> Hopefully this is an idle worry and it is not possible
>> for the tool to confuse a numeric branch name with a SHA1 id.
>
> It _is_ possible, but the rule is that references will be resolved first. 

I have to admit that I had this broken for a while.  The
breakage was when you have the same numeric branch name _and_
tagname, then ref resolution was skipped and short SHA1 was
taken.  It _might_ have bitten somebody in real life until I
fixed it.  But I believe this is fixed now.

> It's pretty unlikely, of course. But it's one reason to try to avoid using 
> ref names that are numeric.

Or even non numeric ones, like "deadbeef".
