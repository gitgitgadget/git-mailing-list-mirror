X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Andy Whitcroft <apw@shadowen.org>
Subject: Re: [PATCH 0/2] Making "git commit" to mean "git commit -a".
Date: Thu, 30 Nov 2006 17:13:44 +0000
Message-ID: <456F1148.2020907@shadowen.org>
References: <Pine.LNX.4.64.0611271622260.9647@xanadu.home>	<7vmz6cfsuw.fsf@assigned-by-dhcp.cox.net>	<87bqmswm1e.wl%cworth@cworth.org>	<7vodqse90q.fsf@assigned-by-dhcp.cox.net>	<87ac2cwha4.wl%cworth@cworth.org>	<7vy7pwcsgp.fsf@assigned-by-dhcp.cox.net>	<878xhwwdyj.wl%cworth@cworth.org>	<7vk61gcnzl.fsf@assigned-by-dhcp.cox.net> <7vd5786opj.fsf@assigned-by-dhcp.cox.net> <ekmkoe$a52$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Thu, 30 Nov 2006 17:14:21 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
User-Agent: Thunderbird 1.5.0.7 (X11/20060927)
In-Reply-To: <ekmkoe$a52$1@sea.gmane.org>
X-Enigmail-Version: 0.94.0.0
OpenPGP: url=http://www.shadowen.org/~apw/public-key
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32777>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GppTr-0005Sr-4z for gcvg-git@gmane.org; Thu, 30 Nov
 2006 18:13:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1030774AbWK3RNs (ORCPT <rfc822;gcvg-git@m.gmane.org>); Thu, 30 Nov 2006
 12:13:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030816AbWK3RNs
 (ORCPT <rfc822;git-outgoing>); Thu, 30 Nov 2006 12:13:48 -0500
Received: from hellhawk.shadowen.org ([80.68.90.175]:30725 "EHLO
 hellhawk.shadowen.org") by vger.kernel.org with ESMTP id S1030774AbWK3RNr
 (ORCPT <rfc822;git@vger.kernel.org>); Thu, 30 Nov 2006 12:13:47 -0500
Received: from localhost ([127.0.0.1]) by hellhawk.shadowen.org with esmtp
 (Exim 4.50) id 1GppT1-0001q4-LY; Thu, 30 Nov 2006 17:13:00 +0000
To: Salikh Zakirov <Salikh.Zakirov@Intel.com>
Sender: git-owner@vger.kernel.org

Salikh Zakirov wrote:
> Junio C Hamano wrote:
>> I've been playing with a "private edition" git to see how it
>> feels like to use "git commit" that defaults to the "-a"
>> behaviour, using myself as a guinea pig, for the rest of the
>> evening.
> 
> Thanks a lot for the patches, Junio!
> 
> I am using them for two days, and my experience is great!
> Many times it saved me annoyances of forgetting to put '-a' to 'git commit'.
> 
> It should be noted, that I mostly used 'git-commit files...'
> or 'git-commit -a' forms before.
> 
> Someone said, that default '-a' does not go well with 'git-commit --amend',
> and I second that. It was somewhat suprising to see that 'git commit --amend'
> is going to include all of the dirty state into the commit,
> and since there is no easy way to abort a --amend commit (because the comment
> buffer wasn't empty, and :q! does not work as it would on the regular commit),
> I had to untwine the changes manually.

If you have no commit message the commit will be aborted.  So just write
back a completly empty commit message.  "dG:wq" in vi land.

apw@larry:~/git/linux-2.6$ git commit --amend
* no commit message?  aborting commit.
apw@larry:~/git/linux-2.6$

