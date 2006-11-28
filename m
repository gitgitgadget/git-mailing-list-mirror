X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Andy Whitcroft <apw@shadowen.org>
Subject: Re: [PATCH 0/2] Making "git commit" to mean "git commit -a".
Date: Tue, 28 Nov 2006 10:26:49 +0000
Message-ID: <456C0EE9.9050004@shadowen.org>
References: <Pine.LNX.4.64.0611271622260.9647@xanadu.home>	<7vmz6cfsuw.fsf@assigned-by-dhcp.cox.net>	<87bqmswm1e.wl%cworth@cworth.org>	<7vodqse90q.fsf@assigned-by-dhcp.cox.net>	<87ac2cwha4.wl%cworth@cworth.org>	<7vy7pwcsgp.fsf@assigned-by-dhcp.cox.net>	<878xhwwdyj.wl%cworth@cworth.org>	<7vk61gcnzl.fsf@assigned-by-dhcp.cox.net> <7vd5786opj.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Tue, 28 Nov 2006 10:27:09 +0000 (UTC)
Cc: Carl Worth <cworth@cworth.org>, git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
User-Agent: Thunderbird 1.5.0.7 (X11/20060927)
In-Reply-To: <7vd5786opj.fsf@assigned-by-dhcp.cox.net>
X-Enigmail-Version: 0.94.0.0
OpenPGP: url=http://www.shadowen.org/~apw/public-key
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32502>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gp0B3-0006L3-Dt for gcvg-git@gmane.org; Tue, 28 Nov
 2006 11:27:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S935810AbWK1K06 (ORCPT <rfc822;gcvg-git@m.gmane.org>); Tue, 28 Nov 2006
 05:26:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S935811AbWK1K05
 (ORCPT <rfc822;git-outgoing>); Tue, 28 Nov 2006 05:26:57 -0500
Received: from hellhawk.shadowen.org ([80.68.90.175]:50187 "EHLO
 hellhawk.shadowen.org") by vger.kernel.org with ESMTP id S935810AbWK1K05
 (ORCPT <rfc822;git@vger.kernel.org>); Tue, 28 Nov 2006 05:26:57 -0500
Received: from localhost ([127.0.0.1]) by hellhawk.shadowen.org with esmtp
 (Exim 4.50) id 1Gp0AA-0003en-JH; Tue, 28 Nov 2006 10:26:06 +0000
To: Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org

Junio C Hamano wrote:
> Junio C Hamano <junkio@cox.net> writes:
> 
>> Enough about "git commit -a" for tonight.
> 
> I've been playing with a "private edition" git to see how it
> feels like to use "git commit" that defaults to the "-a"
> behaviour, using myself as a guinea pig, for the rest of the
> evening.

I for one would find this change confusing.  Yes like most virgins I
found the -a being needed all the time left me with a bit of "huh, why
not turn it on by default" feeling.  But as time goes by and you use git
more and start to rebase and merge and start to get those conflicts then
the index comes into focus, you can see why that 'stupid layer' is there
and its power.  I am now finding myself using the index more and more as
you described as a staging ground for the 'commit in progres'.

I think the new wording in the tutorial really is a much better way
round to teach it, and would have saved me some mental movement.  But
the index really is there and useful when you get beyond the trivial.  I
am using git almost exclusivly in a contributer role and find it so.

my $0.02.

