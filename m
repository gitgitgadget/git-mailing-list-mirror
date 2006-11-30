X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Salikh Zakirov <Salikh.Zakirov@Intel.com>
Subject: Re: [PATCH 0/2] Making "git commit" to mean "git commit -a".
Date: Thu, 30 Nov 2006 15:23:13 +0300
Message-ID: <ekmkoe$a52$1@sea.gmane.org>
References: <Pine.LNX.4.64.0611271622260.9647@xanadu.home>	<7vmz6cfsuw.fsf@assigned-by-dhcp.cox.net>	<87bqmswm1e.wl%cworth@cworth.org>	<7vodqse90q.fsf@assigned-by-dhcp.cox.net>	<87ac2cwha4.wl%cworth@cworth.org>	<7vy7pwcsgp.fsf@assigned-by-dhcp.cox.net>	<878xhwwdyj.wl%cworth@cworth.org>	<7vk61gcnzl.fsf@assigned-by-dhcp.cox.net> <7vd5786opj.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Thu, 30 Nov 2006 13:05:38 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Injected-Via-Gmane: http://gmane.org/
Original-Lines: 21
Original-X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: msfwpr01.ims.intel.com
User-Agent: Thunderbird 1.5.0.8 (Windows/20061025)
In-Reply-To: <7vd5786opj.fsf@assigned-by-dhcp.cox.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32738>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GplbR-0005H2-Nf for gcvg-git@gmane.org; Thu, 30 Nov
 2006 14:05:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S966288AbWK3NFU (ORCPT <rfc822;gcvg-git@m.gmane.org>); Thu, 30 Nov 2006
 08:05:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S936379AbWK3NFU
 (ORCPT <rfc822;git-outgoing>); Thu, 30 Nov 2006 08:05:20 -0500
Received: from main.gmane.org ([80.91.229.2]:8138 "EHLO ciao.gmane.org") by
 vger.kernel.org with ESMTP id S936287AbWK3NFS (ORCPT
 <rfc822;git@vger.kernel.org>); Thu, 30 Nov 2006 08:05:18 -0500
Received: from root by ciao.gmane.org with local (Exim 4.43) id
 1Gplb4-0005Ai-L1 for git@vger.kernel.org; Thu, 30 Nov 2006 14:05:03 +0100
Received: from msfwpr01.ims.intel.com ([62.118.80.132]) by main.gmane.org
 with esmtp (Gmexim 0.1 (Debian)) id 1AlnuQ-0007hv-00 for
 <git@vger.kernel.org>; Thu, 30 Nov 2006 14:05:02 +0100
Received: from Salikh.Zakirov by msfwpr01.ims.intel.com with local (Gmexim
 0.1 (Debian)) id 1AlnuQ-0007hv-00 for <git@vger.kernel.org>; Thu, 30 Nov 2006
 14:05:02 +0100
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

Junio C Hamano wrote:
> I've been playing with a "private edition" git to see how it
> feels like to use "git commit" that defaults to the "-a"
> behaviour, using myself as a guinea pig, for the rest of the
> evening.

Thanks a lot for the patches, Junio!

I am using them for two days, and my experience is great!
Many times it saved me annoyances of forgetting to put '-a' to 'git commit'.

It should be noted, that I mostly used 'git-commit files...'
or 'git-commit -a' forms before.

Someone said, that default '-a' does not go well with 'git-commit --amend',
and I second that. It was somewhat suprising to see that 'git commit --amend'
is going to include all of the dirty state into the commit,
and since there is no easy way to abort a --amend commit (because the comment
buffer wasn't empty, and :q! does not work as it would on the regular commit),
I had to untwine the changes manually.

