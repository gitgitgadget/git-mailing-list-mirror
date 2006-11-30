X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Junio C Hamano <junkio@cox.net>
Subject: Re: [RFD] making separate-remote layout easier to use
Date: Thu, 30 Nov 2006 13:22:15 -0800
Message-ID: <7v64cwiq9k.fsf@assigned-by-dhcp.cox.net>
References: <7v1wnr19do.fsf@assigned-by-dhcp.cox.net>
	<ekafpm$fs7$1@sea.gmane.org> <20061126033433.GD29394@spearce.org>
	<7vvel2yi2u.fsf@assigned-by-dhcp.cox.net>
	<1164910560.4724.117.camel@cashmere.sps.mot.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Thu, 30 Nov 2006 21:22:25 +0000 (UTC)
Cc: Shawn Pearce <spearce@spearce.org>, Git List <git@vger.kernel.org>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32802>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GptMK-0006o9-UN for gcvg-git@gmane.org; Thu, 30 Nov
 2006 22:22:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1031506AbWK3VWS (ORCPT <rfc822;gcvg-git@m.gmane.org>); Thu, 30 Nov 2006
 16:22:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031519AbWK3VWS
 (ORCPT <rfc822;git-outgoing>); Thu, 30 Nov 2006 16:22:18 -0500
Received: from fed1rmmtao03.cox.net ([68.230.241.36]:33690 "EHLO
 fed1rmmtao03.cox.net") by vger.kernel.org with ESMTP id S1031506AbWK3VWR
 (ORCPT <rfc822;git@vger.kernel.org>); Thu, 30 Nov 2006 16:22:17 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72]) by fed1rmmtao03.cox.net
 (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP id
 <20061130212216.CYHK4817.fed1rmmtao03.cox.net@fed1rmimpo02.cox.net>; Thu, 30
 Nov 2006 16:22:16 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80]) by
 fed1rmimpo02.cox.net with bizsmtp id t9NR1V0031kojtg0000000; Thu, 30 Nov 2006
 16:22:25 -0500
To: Jon Loeliger <jdl@freescale.com>
Sender: git-owner@vger.kernel.org

Jon Loeliger <jdl@freescale.com> writes:

> On Sat, 2006-11-25 at 21:58, Junio C Hamano wrote:
>> > ...
>> > I would prefer to see the upstream be able to publish a short
>> > description of each branch, where the repository owner can describe
>> > the policy of that branch,...
>> ...
>> I like this approach very much.
>
> I see how it is! :-)  When Shawn says it, it is to be liked.
> But when I allude to it a _year_ ago, I'm ignored.

Think of it not as a difference between you and Shawn, but as a
difference in me back then and me now, who finally saw the light
in your revelation after gaining a year's worth of experience ;-).

Seriously, I did not ignore it, and I think some of your other
comments in the message contributed to improved documentation.
When your message was posted, the issue Shawn raised in his
message was not so prominent, because people did not even get
that "Pull: refs/heads/pu:refs/heads/pu" line in their remotes/
file by default back then.  It was back in 0.99.9 era and a few
days after your message, a patch was posted to put more than
just the 'master' mapping in the remotes/ file clone creates.
It became an issue after that change but we lacked the resources
nor sense of urgency to do the out-of-band stuff, as we were
busy working on other things.
