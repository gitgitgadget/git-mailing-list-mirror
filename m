From: David Lang <david.lang@digitalinsight.com>
Subject: Re: I want to release a "git-1.0"
Date: Tue, 31 May 2005 19:25:15 -0700 (PDT)
Message-ID: <Pine.LNX.4.62.0505311923240.19864@qynat.qvtvafvgr.pbz>
References: <Pine.LNX.4.58.0505301253070.1876@ppc970.osdl.org><972477.0a6782ba1d3b9f05216ed520ef720fcf.ANY@taniwha.stupidest.org><Pine.LNX.4.58.0505301801520.1876@ppc970.osdl.org>
 <7vu0kiu8pm.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: Chris Wedgwood <cw@f00f.org>, Linus Torvalds <torvalds@osdl.org>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Jun 01 04:23:34 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DdIso-0001JJ-8l
	for gcvg-git@gmane.org; Wed, 01 Jun 2005 04:23:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261238AbVFACZl (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 31 May 2005 22:25:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261241AbVFACZl
	(ORCPT <rfc822;git-outgoing>); Tue, 31 May 2005 22:25:41 -0400
Received: from warden3-p.diginsite.com ([208.147.64.186]:31980 "HELO
	warden3.diginsite.com") by vger.kernel.org with SMTP
	id S261238AbVFACZd (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 31 May 2005 22:25:33 -0400
Received: from sacims01.digitalinsight.com by warden3.diginsite.com
          via smtpd (for vger.kernel.org [12.107.209.244]) with SMTP; Tue, 31 May 2005 19:25:33 -0700
Received: by sacexc01.diginsite.com with Internet Mail Service (5.5.2657.72)
	id <L6ZZHMSQ>; Tue, 31 May 2005 19:25:19 -0700
Received: from dlang.diginsite.com ([10.201.10.67]) by wlvexc00.digitalinsight.com with SMTP (Microsoft Exchange Internet Mail Service Version 5.5.2657.72)
	id L6Z7JW1B; Tue, 31 May 2005 19:25:15 -0700
To: Junio C Hamano <junkio@cox.net>
X-X-Sender: dlang@dlang.diginsite.com
In-Reply-To: <7vu0kiu8pm.fsf@assigned-by-dhcp.cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Tue, 31 May 2005, Junio C Hamano wrote:

>>>>>> "LT" == Linus Torvalds <torvalds@osdl.org> writes:
>
> LT> On Mon, 30 May 2005, Chris Wedgwood wrote:
>>>
>>> I'm still at a loss how to do the equivalent of annotate.  I know a
>>> couple of front ends can do this but I have no idea what command line
>>> magic would be equivalent.
>
> LT> There isn't any. It's actually pretty nasty to do, following history
> LT> backwards and keeping track of lines as they are added. I know how, I'm
> LT> just really lazy and hoping somebody else will do it, since I really end
> LT> up not caring that much myself.
>
> LT> I notice that Thomas Gleixner seems to have one, but that one is based on
> LT> a database, and doesn't look usable as a standalone command..
>
> Here is my quick-and-dirty one done in Perl.  This is dog-slow
> and not suited for interactive use, but its algorithm should
> handle the merges, renames and complete rewrites correctly.

Hmm, thinking out loud. would it help to look at the deltify scripts and 
let them find the major chunks and then look in detail only when that 
fails?

David Lang
