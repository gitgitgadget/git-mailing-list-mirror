X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Junio C Hamano <junkio@cox.net>
Subject: Re: git-fetch fails with error code 128
Date: Thu, 14 Dec 2006 16:02:23 -0800
Message-ID: <7vfybiyqk0.fsf@assigned-by-dhcp.cox.net>
References: <200612142308.45376.andyparkins@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Fri, 15 Dec 2006 00:02:32 +0000 (UTC)
Cc: git@vger.kernel.org, Nicolas Pitre <nico@cam.org>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <200612142308.45376.andyparkins@gmail.com> (Andy Parkins's
	message of "Thu, 14 Dec 2006 23:08:43 +0000")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34445>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1Gv0Wz-0005lO-RE for gcvg-git@gmane.org; Fri, 15 Dec
 2006 01:02:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1752022AbWLOAC0 (ORCPT <rfc822;gcvg-git@m.gmane.org>); Thu, 14 Dec 2006
 19:02:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752040AbWLOAC0
 (ORCPT <rfc822;git-outgoing>); Thu, 14 Dec 2006 19:02:26 -0500
Received: from fed1rmmtao11.cox.net ([68.230.241.28]:32883 "EHLO
 fed1rmmtao11.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
 id S1752022AbWLOACZ (ORCPT <rfc822;git@vger.kernel.org>); Thu, 14 Dec 2006
 19:02:25 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72]) by fed1rmmtao11.cox.net
 (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP id
 <20061215000224.GKKF25875.fed1rmmtao11.cox.net@fed1rmimpo02.cox.net>; Thu, 14
 Dec 2006 19:02:24 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80]) by
 fed1rmimpo02.cox.net with bizsmtp id yo2b1V0191kojtg0000000; Thu, 14 Dec 2006
 19:02:36 -0500
To: Andy Parkins <andyparkins@gmail.com>
Sender: git-owner@vger.kernel.org

Andy Parkins <andyparkins@gmail.com> writes:

> $ git fetch
> remote: Generating pack...
> remote: Done counting 189146 objects.
> remote: Result has 186566 objects.
> remote: Deltifying 186566 objects.
> remote:  100% (186566/186566) done
> Unpacking 186566 objects
> fatal: failed to apply delta
> fatal: unpack-objects died with error code 128
> Fetch failure: /home/andyp/projects/temp/.git
>
> What does that mean?  I ran fsck --full on the source repository, but it's 
> made no difference.

Andy, which version of git do you run (I presume they are the
same version, as you are doing the local fetching), and which
version of git was the "slightly out of date" repository
prepared with?

I think this is the second time I've seen a report of unpacker
barfing on the mailing list.  Nico, anything rings a bell?

