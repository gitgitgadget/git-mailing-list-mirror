From: Petr Sebor <petr@scssoft.com>
Subject: Re: git diff - no newline after @@ ?
Date: Fri, 18 Aug 2006 14:37:42 +0200
Organization: SCS Software
Message-ID: <44E5B496.3070901@scssoft.com>
References: <44E5AE42.6090506@scssoft.com> <81b0412b0608180525t284d3124j867a9461bf14ed91@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 18 14:37:52 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GE3bc-00047n-K2
	for gcvg-git@gmane.org; Fri, 18 Aug 2006 14:37:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932083AbWHRMhl (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 18 Aug 2006 08:37:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932086AbWHRMhl
	(ORCPT <rfc822;git-outgoing>); Fri, 18 Aug 2006 08:37:41 -0400
Received: from opteron.scssoft.com ([85.207.19.51]:44983 "EHLO
	opteron.scssoft.com") by vger.kernel.org with ESMTP id S932083AbWHRMhk
	(ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Aug 2006 08:37:40 -0400
Received: from [IPv6:2001:6f8:12f6:1:211:9ff:fec1:49c7] (donkey.scssoft.com [IPv6:2001:6f8:12f6:1:211:9ff:fec1:49c7])
	by opteron.scssoft.com (Postfix) with ESMTP id AF8845647CF;
	Fri, 18 Aug 2006 14:37:38 +0200 (CEST)
User-Agent: Thunderbird 1.5.0.5 (Windows/20060719)
To: Alex Riesen <raa.lkml@gmail.com>
In-Reply-To: <81b0412b0608180525t284d3124j867a9461bf14ed91@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25656>

Alex Riesen wrote:
> On 8/18/06, Petr Sebor <petr@scssoft.com> wrote:
>> Hello,
>>
>> has anyone noticed that the 'git diff' output somehow lacks the newline
>> after the @@ tag?
>>
>
> Why should it? It's hunk comment.
Hunk comment? Maybe we don't understand each other...

check another example:

--- a/include/linux/kernel.h
+++ b/include/linux/kernel.h
@@ -13,6 +13,7 @@ #include <linux/stddef.h>
 #include <linux/types.h>
 #include <linux/compiler.h>
 #include <linux/bitops.h>
+#include <linux/memleak.h>
 #include <asm/byteorder.h>
 #include <asm/bug.h>

whereas gnu diff would output

--- a/include/linux/kernel.h
+++ b/include/linux/kernel.h
@@ -13,6 +13,7 @@
 #include <linux/stddef.h>
 #include <linux/types.h>
 #include <linux/compiler.h>
 #include <linux/bitops.h>
+#include <linux/memleak.h>
 #include <asm/byteorder.h>
 #include <asm/bug.h>

Petr
