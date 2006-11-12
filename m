X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Junio C Hamano <junkio@cox.net>
Subject: Re: Shallow clone
Date: Sun, 12 Nov 2006 12:04:42 -0800
Message-ID: <7vodrcctyd.fsf@assigned-by-dhcp.cox.net>
References: <7v8ximwrm3.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.63.0611072009220.2601@qynat.qvtvafvgr.pbz>
	<45520872.3090506@gmail.com> <45521AE9.7050902@gmail.com>
	<20061112131209.GC7201@pasky.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Sun, 12 Nov 2006 20:04:54 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31275>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GjLZR-0002iq-4r for gcvg-git@gmane.org; Sun, 12 Nov
 2006 21:04:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1753022AbWKLUEo (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sun, 12 Nov 2006
 15:04:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753025AbWKLUEo
 (ORCPT <rfc822;git-outgoing>); Sun, 12 Nov 2006 15:04:44 -0500
Received: from fed1rmmtao02.cox.net ([68.230.241.37]:25787 "EHLO
 fed1rmmtao02.cox.net") by vger.kernel.org with ESMTP id S1753034AbWKLUEn
 (ORCPT <rfc822;git@vger.kernel.org>); Sun, 12 Nov 2006 15:04:43 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71]) by fed1rmmtao02.cox.net
 (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP id
 <20061112200443.YXDV97.fed1rmmtao02.cox.net@fed1rmimpo01.cox.net>; Sun, 12
 Nov 2006 15:04:43 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80]) by
 fed1rmimpo01.cox.net with bizsmtp id lw4J1V0011kojtg0000000; Sun, 12 Nov 2006
 15:04:18 -0500
To: Petr Baudis <pasky@suse.cz>
Sender: git-owner@vger.kernel.org

Petr Baudis <pasky@suse.cz> writes:

> On Wed, Nov 08, 2006 at 06:59:05PM CET, Aneesh Kumar K.V wrote:
>> diff --git a/Documentation/repository-layout.txt b/Documentation/repository-layout.txt
>> index 275d18b..03a6f77 100644
>> --- a/Documentation/repository-layout.txt
>> +++ b/Documentation/repository-layout.txt
>> @@ -141,3 +141,9 @@ logs/refs/heads/`name`::
>>  
>>  logs/refs/tags/`name`::
>>  	Records all changes made to the tag named `name`.
>> +
>> +shallow::
>
> Hmm, shouldn't the shallow file rather belong to the info/ subdirectory?

I think that makes sense.
