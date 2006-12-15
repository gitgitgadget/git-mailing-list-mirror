X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Junio C Hamano <junkio@cox.net>
Subject: Re: Avoiding uninteresting merges in Cairo
Date: Fri, 15 Dec 2006 13:03:21 -0800
Message-ID: <7vvekcub1i.fsf@assigned-by-dhcp.cox.net>
References: <20061215020629.GK26202@spearce.org>
	<87tzzx4zm7.wl%cworth@cworth.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Fri, 15 Dec 2006 21:03:31 +0000 (UTC)
Cc: git@vger.kernel.org, Shawn Pearce <spearce@spearce.org>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <87tzzx4zm7.wl%cworth@cworth.org> (Carl Worth's message of "Thu,
	14 Dec 2006 19:17:04 -0800")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34549>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GvKDG-0007uN-7q for gcvg-git@gmane.org; Fri, 15 Dec
 2006 22:03:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S964943AbWLOVDX (ORCPT <rfc822;gcvg-git@m.gmane.org>); Fri, 15 Dec 2006
 16:03:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964945AbWLOVDX
 (ORCPT <rfc822;git-outgoing>); Fri, 15 Dec 2006 16:03:23 -0500
Received: from fed1rmmtao11.cox.net ([68.230.241.28]:58690 "EHLO
 fed1rmmtao11.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
 id S964943AbWLOVDW (ORCPT <rfc822;git@vger.kernel.org>); Fri, 15 Dec 2006
 16:03:22 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72]) by fed1rmmtao11.cox.net
 (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP id
 <20061215210321.SSPA25875.fed1rmmtao11.cox.net@fed1rmimpo02.cox.net>; Fri, 15
 Dec 2006 16:03:21 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80]) by
 fed1rmimpo02.cox.net with bizsmtp id z93Z1V00H1kojtg0000000; Fri, 15 Dec 2006
 16:03:33 -0500
To: Carl Worth <cworth@cworth.org>
Sender: git-owner@vger.kernel.org

Carl Worth <cworth@cworth.org> writes:

> On Thu, 14 Dec 2006 21:06:29 -0500, Shawn Pearce wrote:
>> ...
>> Cairo has seriously been using `reset --hard HEAD^` as part of its
>> workflow since April?
> ...
> Also, I don't actually need this. I don't use the "reset --hard"
> workflow suggested in the mail above. I always obtain remote changes
> with "git fetch" and then examine things locally and decide to either
> merge (or fast forward) with "git pull", (though maybe I'll start
> using "git merge" now), or else to use "git rebase" to avoid the noisy
> merge commits.

I wish I have more time to keep track of "recommended workflows"
that projects using git give to its developers.

I think what you recommend makes quite a lot of sense, for
very centralized setting, and would leave much more usable
history than the simple-minded way cvs-migration suggests.


