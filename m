X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] git-svnimport: support for partial imports
Date: Tue, 31 Oct 2006 15:48:36 -0800
Message-ID: <7v1wooqc6j.fsf@assigned-by-dhcp.cox.net>
References: <20061025225026.GA13031@sashak.voltaire.com>
	<20061031225054.GA20211@sashak.voltaire.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Tue, 31 Oct 2006 23:48:50 +0000 (UTC)
Cc: git@vger.kernel.org, Matthias Urlichs <smurf@smurf.noris.de>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <20061031225054.GA20211@sashak.voltaire.com> (Sasha Khapyorsky's
	message of "Wed, 1 Nov 2006 00:50:54 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30606>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gf3LW-0003JW-0x for gcvg-git@gmane.org; Wed, 01 Nov
 2006 00:48:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1946026AbWJaXsj (ORCPT <rfc822;gcvg-git@m.gmane.org>); Tue, 31 Oct 2006
 18:48:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946150AbWJaXsj
 (ORCPT <rfc822;git-outgoing>); Tue, 31 Oct 2006 18:48:39 -0500
Received: from fed1rmmtao08.cox.net ([68.230.241.31]:56316 "EHLO
 fed1rmmtao08.cox.net") by vger.kernel.org with ESMTP id S1946026AbWJaXsi
 (ORCPT <rfc822;git@vger.kernel.org>); Tue, 31 Oct 2006 18:48:38 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72]) by fed1rmmtao08.cox.net
 (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP id
 <20061031234837.NJTP22977.fed1rmmtao08.cox.net@fed1rmimpo02.cox.net>; Tue, 31
 Oct 2006 18:48:37 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80]) by
 fed1rmimpo02.cox.net with bizsmtp id hBoh1V00T1kojtg0000000 Tue, 31 Oct 2006
 18:48:42 -0500
To: Sasha Khapyorsky <sashak@voltaire.com>
Sender: git-owner@vger.kernel.org

Sasha Khapyorsky <sashak@voltaire.com> writes:

> On 00:50 Thu 26 Oct     , Sasha Khapyorsky wrote:
>> This adds support for partial svn imports. Let's assume that SVN
>> repository layout looks like:
>> 
>>   $trunk/path/to/our/project
>>   $branches/path/to/our/project
>>   $tags/path/to/our/project
>> 
>> , and we would like to import only tree under this specific
>> 'path/to/our/project' and not whole tree under $trunk, $branches, etc..
>> Now we will be be able to do it by using '-P path/to/our/project' option
>> with git-svnimport.
>> 
>> Signed-off-by: Sasha Khapyorsky <sashak@voltaire.com>
>
> Any news about status of this patch?

Somebody mentioned this duplicates something that can be already
done, and I saw you refuted that.  At that point I thought then
it would be Ok to add, and then I forgot about it.  Sorry.

Will apply unless somebody objects immediately ;-).
