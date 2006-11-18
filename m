X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Do not ignore hidden refs
Date: Sat, 18 Nov 2006 11:50:23 -0800
Message-ID: <7vejs0cz5s.fsf@assigned-by-dhcp.cox.net>
References: <20061118041137.6064.75827.stgit@machine.or.cz>
	<7v8xi9fjw9.fsf@assigned-by-dhcp.cox.net>
	<20061118045323.GK7201@pasky.or.cz>
	<7vzmapdxki.fsf@assigned-by-dhcp.cox.net>
	<20061118192830.GP7201@pasky.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Sat, 18 Nov 2006 19:50:40 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <20061118192830.GP7201@pasky.or.cz> (Petr Baudis's message of
	"Sat, 18 Nov 2006 20:28:30 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31797>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GlWCu-00046a-KI for gcvg-git@gmane.org; Sat, 18 Nov
 2006 20:50:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1755235AbWKRTuZ (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sat, 18 Nov 2006
 14:50:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755239AbWKRTuZ
 (ORCPT <rfc822;git-outgoing>); Sat, 18 Nov 2006 14:50:25 -0500
Received: from fed1rmmtao09.cox.net ([68.230.241.30]:19688 "EHLO
 fed1rmmtao09.cox.net") by vger.kernel.org with ESMTP id S1755235AbWKRTuZ
 (ORCPT <rfc822;git@vger.kernel.org>); Sat, 18 Nov 2006 14:50:25 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71]) by fed1rmmtao09.cox.net
 (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP id
 <20061118195024.HHSF18767.fed1rmmtao09.cox.net@fed1rmimpo01.cox.net>; Sat, 18
 Nov 2006 14:50:24 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80]) by
 fed1rmimpo01.cox.net with bizsmtp id oKpw1V0091kojtg0000000; Sat, 18 Nov 2006
 14:49:56 -0500
To: Petr Baudis <pasky@suse.cz>
Sender: git-owner@vger.kernel.org

Petr Baudis <pasky@suse.cz> writes:

> On Sat, Nov 18, 2006 at 08:27:09AM CET, Junio C Hamano wrote:
>> I think, however, if we (collectively as all the Porcelain
>> writers although I am not really one of them) are to support it,
>> they should not make distinction to the core, and it should be
>> handled with the agreed-upon convention.
>
> I guess I agree.
>
>> ...  I do not think it is a great
>> enough convention to be promoted as the official BCP, but it has
>> been good enough for me, ...
>
> That's way too arbitrary for my taste, I think I needn't explain why.

Because _I_ explained why already ;-).

> What about leading underscore?

I would rather prefer to do refs/{heads,private}/ and allow
checkout to treat either of them as branches.  We are talking
about allowing checkout to go to a non-branch by storing a raw
commit object name in HEAD instead of leaving it as a symref, so
we know we are going to touch that area already.



