From: Brandon Casey <casey@nrlssc.navy.mil>
Subject: Re: What's cooking in git.git (topics)
Date: Fri, 22 Feb 2008 20:43:23 -0600
Message-ID: <47BF884B.6020302@nrlssc.navy.mil>
References: <7v7ihmuwzi.fsf@gitster.siamese.dyndns.org> <7vodavd9qw.fsf@gitster.siamese.dyndns.org> <7vbq6tset4.fsf@gitster.siamese.dyndns.org> <7vmyq9gk94.fsf@gitster.siamese.dyndns.org> <7vk5la4oxq.fsf@gitster.siamese.dyndns.org> <7vejbc44hu.fsf@gitster.siamese.dyndns.org> <7v8x1fymei.fsf@gitster.siamese.dyndns.org> <alpine.LSU.1.00.0802211024200.17164@racer.site> <47BF18DF.6050100@nrlssc.navy.mil> <7vhcg07hmd.fsf@gitster.siamese.dyndns.org> <47BF669F.4070803@nrlssc.navy.mil> <7voda85wc3.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Feb 23 03:44:05 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JSkMu-0005j6-6n
	for gcvg-git-2@gmane.org; Sat, 23 Feb 2008 03:44:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754950AbYBWCn3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Feb 2008 21:43:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754943AbYBWCn3
	(ORCPT <rfc822;git-outgoing>); Fri, 22 Feb 2008 21:43:29 -0500
Received: from mail1.nrlssc.navy.mil ([128.160.35.1]:57349 "EHLO
	mail.nrlssc.navy.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754896AbYBWCn2 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Feb 2008 21:43:28 -0500
Received: from starfish.gems.nrlssc.navy.mil (localhost [127.0.0.1])
	by mail.nrlssc.navy.mil (8.13.7/8.13.7) with ESMTP id m1N2hNWi000884;
	Fri, 22 Feb 2008 20:43:24 -0600
Received: from tick.nrlssc.navy.mil ([128.160.25.48]) by starfish.gems.nrlssc.navy.mil with Microsoft SMTPSVC(6.0.3790.3959);
	 Fri, 22 Feb 2008 20:43:23 -0600
User-Agent: Thunderbird 2.0.0.9 (X11/20071031)
In-Reply-To: <7voda85wc3.fsf@gitster.siamese.dyndns.org>
X-OriginalArrivalTime: 23 Feb 2008 02:43:23.0320 (UTC) FILETIME=[DB976B80:01C875C5]
X-TM-AS-Product-Ver: : ISVW-6.0.0.2339-5.0.0.1023-15736001
X-TM-AS-Result: : Yes--19.586500-0-31-1
X-TM-AS-Category-Info: : 31:0.000000
X-TM-AS-MatchedID: : =?us-ascii?B?MTUwNTY3LTcwMDA3NS0xMzkw?=
	=?us-ascii?B?MTAtNzAwMTYwLTcwMzczMS03MDIwNDQtNzA5MTg1LTcwODE3OS03?=
	=?us-ascii?B?MDIzNTgtNzA3MzYxLTcwMzE1Ny03MDA2MTctMTA1NzAwLTcwOTU4?=
	=?us-ascii?B?NC03MDE0NTUtNzAxOTE0LTcwMTYxOC03MDMzMjEtNzAzMjgzLTcw?=
	=?us-ascii?B?MTIwMi03MDIwMjAtNzAwOTQyLTcwOTEzNy03MDc3NjAtMTQ4MDM5?=
	=?us-ascii?B?LTE0ODA1MS0yMDA0Mw==?=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74789>

Junio C Hamano wrote:
> Brandon Casey <casey@nrlssc.navy.mil> writes:
> 
>> Junio C Hamano wrote:
>>
>>>  Also we may want to introduce a stash per branch if we do this.
>> This isn't necessary for how I use stash.
> 
> That's what I thought initially.  But after thinking about it a
> bit, I do not think so anymore.
> 
> It feels limiting not to be able to stash here and unstash
> there.  You cannot stash on one branch and apply on another as
> easily (you should still be able to, by naming the stash
> explicitly, if you really wanted to).
> 
> But why would one even want to?  "What I've been hacking on is
> getting into a good shape but now I noticed I was on a wrong
> branch", is probably the only reason.  But that is what branch
> switching "git checkout" (and its -m variant) does.  If your
> changes are something that would make "checkout -m" conflict,
> stashing and unstashing will result in the same conflict anyway,
> so nothing is lost.

Ok, I had to read that more than once, but you've convinced me.
per-branch stash is interesting.

-brandon
