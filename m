X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-1.6 required=3.0 tests=AWL,BAYES_00,
	DATE_IN_PAST_96_XX,HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
From: Sam Vilain <sam@vilain.net>
Subject: Re: Topic descriptions
Date: Sat, 09 Dec 2006 12:11:48 +1100
Message-ID: <457A0D54.80802@vilain.net>
References: <200612062153.30639.andyparkins@gmail.com> <7v4ps8y7un.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Wed, 13 Dec 2006 05:44:06 +0000 (UTC)
Cc: Andy Parkins <andyparkins@gmail.com>, git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Greylist: delayed 1307 seconds by postgrey-1.27 at vger.kernel.org; Wed, 13 Dec 2006 00:43:58 EST
User-Agent: Thunderbird 1.5.0.4 (X11/20060615)
In-Reply-To: <7v4ps8y7un.fsf@assigned-by-dhcp.cox.net>
X-Enigmail-Version: 0.94.0.0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34183>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GuMuP-00084o-L3 for gcvg-git@gmane.org; Wed, 13 Dec
 2006 06:44:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S964942AbWLMFn7 (ORCPT <rfc822;gcvg-git@m.gmane.org>); Wed, 13 Dec 2006
 00:43:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964936AbWLMFn7
 (ORCPT <rfc822;git-outgoing>); Wed, 13 Dec 2006 00:43:59 -0500
Received: from watts.utsl.gen.nz ([202.78.240.73]:51901 "EHLO
 magnus.utsl.gen.nz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP id
 S964942AbWLMFn6 (ORCPT <rfc822;git@vger.kernel.org>); Wed, 13 Dec 2006
 00:43:58 -0500
Received: by magnus.utsl.gen.nz (Postfix, from userid 65534) id 67F70139B2D;
 Wed, 13 Dec 2006 18:22:09 +1300 (NZDT)
Received: from [127.0.0.1] (longdrop.magnus.utsl.gen.nz [192.168.253.12])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by magnus.utsl.gen.nz (Postfix) with ESMTP id
 E5142139B2B; Wed, 13 Dec 2006 18:22:01 +1300 (NZDT)
To: Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org

Junio C Hamano wrote:
> I think the right place to store that <anything at all>
> information is per-branch configuration item.  Perhaps:
> 
> 	[branch "ap/clone-origin"]
>         description = we talk about what this thing does and \
>         what the current status of it is.
> 
> I am unlikely to use such a thing for the "What's in" message,
> though.  The part that talks about "what the current status is"
> is much easier to write when I need to talk about "the current";
> otherwise I'd be forced to remember to think if I need to update
> the information, every time I touch topic branches.

And this information could even be put into the commit message of the
merge commit.

gitweb/repo could give a "dashboard" of feature branches;

  - creator
  - aim/description of feature branch
  - (computed) mergability with master/trunk/etc (perhaps
    config "merge target(s)")
  - whether tests are passing on this branch (obviously not a
    git-core feature, but a useful thing to know)
  - how many new tests are introduced by this branch.

Some ideas that occurred from watching Martin Pool's talk on managing
distributed VCS with bzr, and the Patch Queue Manager.

Some people might like to include all of the above information in the
merge commit to close the branch, others just the non-redundant information.

Sam.
