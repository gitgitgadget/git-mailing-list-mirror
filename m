From: David Lang <dlang@digitalinsight.com>
Subject: Re: [PATCH] [BUG] Add a test to check git-prune does not throw 
 awayrevs hidden by a graft.
Date: Fri, 19 May 2006 15:26:45 -0700 (PDT)
Message-ID: <Pine.LNX.4.62.0605191526060.2828@qynat.qvtvafvgr.pbz>
References: <20060518213519.14577.67309.stgit@gandelf.nowhere.earth><Pine.LN
 X.4.64.0605181435230.10823@g5.osdl.org> 
 <7viro3nh07.fsf@assigned-by-dhcp.cox.net><20060518222045.GB6535@nowhere.ear
 th>  <20060518225216.GC6535@nowhere.earth><7vsln7lzbj.fsf@assigned-by-dhcp.cox.n
 et> <20060519185558.GE6535@nowhere.earth> <Pine.LNX.4.64.0605191159520.10823@g5.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: Yann Dirson <ydirson@altern.org>, Junio C Hamano <junkio@cox.net>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 20 00:27:02 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FhDQz-0002sA-IQ
	for gcvg-git@gmane.org; Sat, 20 May 2006 00:27:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751380AbWESW07 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 19 May 2006 18:26:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751413AbWESW07
	(ORCPT <rfc822;git-outgoing>); Fri, 19 May 2006 18:26:59 -0400
Received: from warden-p.diginsite.com ([208.29.163.248]:897 "HELO
	warden.diginsite.com") by vger.kernel.org with SMTP
	id S1751380AbWESW06 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 May 2006 18:26:58 -0400
Received: from no.name.available by warden.diginsite.com
          via smtpd (for vger.kernel.org [209.132.176.167]) with SMTP; Fri, 19 May 2006 15:26:58 -0700
Received: from dlang.diginsite.com ([10.201.10.67]) by wlvims02.corp.ad.diginsite.com with InterScan Message Security Suite; Fri, 19 May 2006 15:26:46 -0700
X-X-Sender: dlang@dlang.diginsite.com
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0605191159520.10823@g5.osdl.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20361>

On Fri, 19 May 2006, Linus Torvalds wrote:

> On Fri, 19 May 2006, Yann Dirson wrote:
>
>> On Thu, May 18, 2006 at 03:53:36PM -0700, Junio C Hamano wrote:
>>> Yann Dirson <ydirson@altern.org> writes:
>>>
>>>> To make my point maybe more clear: if someone really wants to make a
>>>> graft permanent, wouldn't some history rewriting ... be the
>>>> way to go,...
>>>
>>> Yes.
>>
>> So if temporary usage is a typical use for grafts, don't we want to
>> protect people using them from pruning ?  I got no feedback to my
>> suggestion of changing the default behaviour, even to say it was a bad
>> idea :)
>
> I don't actually know how much grafts end up being used. Right now, the
> only really valid use I know about is to graft together the old kernel
> history kind of thing, and I suspect not a whole lot of people do that (I
> keep a separate kernel history tree around for when I need to look at it,
> and it doesn't happen all that often).
>
> So I think the lack of feedback on the graft-related issue comes directly
> from that lack of graft usage.

if/when shallow clones become available I would expect to see graft useage 
climb significantly

David Lang

-- 
There are two ways of constructing a software design. One way is to make it so simple that there are obviously no deficiencies. And the other way is to make it so complicated that there are no obvious deficiencies.
  -- C.A.R. Hoare
