X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Documentation: Update information about <format> in git-for-each-ref
Date: Wed, 01 Nov 2006 00:47:34 -0800
Message-ID: <7vd5877duh.fsf@assigned-by-dhcp.cox.net>
References: <200610281930.05889.jnareb@gmail.com>
	<7vslh86uz9.fsf@assigned-by-dhcp.cox.net>
	<200610282323.57797.jnareb@gmail.com> <45485A0F.3040807@op5.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Wed, 1 Nov 2006 08:47:49 +0000 (UTC)
Cc: git@vger.kernel.org, Jakub Narebski <jnareb@gmail.com>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <45485A0F.3040807@op5.se> (Andreas Ericsson's message of "Wed, 01
	Nov 2006 09:25:51 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30623>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GfBl5-0005DN-55 for gcvg-git@gmane.org; Wed, 01 Nov
 2006 09:47:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1423953AbWKAIrg (ORCPT <rfc822;gcvg-git@m.gmane.org>); Wed, 1 Nov 2006
 03:47:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423954AbWKAIrg
 (ORCPT <rfc822;git-outgoing>); Wed, 1 Nov 2006 03:47:36 -0500
Received: from fed1rmmtao06.cox.net ([68.230.241.33]:9346 "EHLO
 fed1rmmtao06.cox.net") by vger.kernel.org with ESMTP id S1423953AbWKAIrf
 (ORCPT <rfc822;git@vger.kernel.org>); Wed, 1 Nov 2006 03:47:35 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71]) by fed1rmmtao06.cox.net
 (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP id
 <20061101084734.BYOX6235.fed1rmmtao06.cox.net@fed1rmimpo01.cox.net>; Wed, 1
 Nov 2006 03:47:34 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80]) by
 fed1rmimpo01.cox.net with bizsmtp id hLnE1V0081kojtg0000000 Wed, 01 Nov 2006
 03:47:15 -0500
To: Andreas Ericsson <ae@op5.se>
Sender: git-owner@vger.kernel.org

Andreas Ericsson <ae@op5.se> writes:

> Jakub Narebski wrote:
>
>> BTW. I had to translate
>> +       if (strcmp(who, "tagger") && strcmp(who, "committer"))
>> to
>> +       if (strcmp(who, "tagger") == 0 || strcmp(who, "committer") == 0)
>> to understand it. But this is probably my lack of contact with such
>> C idioms.
>
> But this does the exact opposite....
> "Compare" (as in "strcmp") also translates to "are equal to" and isn't
> only a verb. This is unfortunate for people who aren't natively
> english and has had me confused on many a long night...

Being a non-English speaker, I always pronounce xxxcmp() used as
boolean 'is different' in my head.  The (correct version of the)
above example expression is read as 'if it is different from
"tagger" and it is different from "committer", then do this'.

Otherwise I pronounce xxxcmp(a,b) "difference"; it's sign
matches (a-b).

if (xxxcmp(a,b) < 0) is similar to if ((a-b) < 0) which is
equivalent to if (a < b).

