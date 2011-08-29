From: Boaz Harrosh <bharrosh@panasas.com>
Subject: Re: [PATCH] .gitattributes: Enable cpp diff parsing for .[ch] files
Date: Mon, 29 Aug 2011 13:57:26 -0700
Message-ID: <4E5BFD36.2090000@panasas.com>
References: <4E56CE8F.8080501@panasas.com>  <CA+55aFxNXK-AJdrHBBycM5W632qUBi4E=jangcdRoefQiHzbug@mail.gmail.com>  <4E580830.4010305@panasas.com> <1314624752.2816.32.camel@twins>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Git Mailing List <git@vger.kernel.org>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Peter Zijlstra <peterz@infradead.org>
X-From: linux-kernel-owner@vger.kernel.org Mon Aug 29 22:58:57 2011
Return-path: <linux-kernel-owner@vger.kernel.org>
Envelope-to: glk-linux-kernel-3@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <linux-kernel-owner@vger.kernel.org>)
	id 1Qy8v2-0000tH-7Y
	for glk-linux-kernel-3@lo.gmane.org; Mon, 29 Aug 2011 22:58:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754929Ab1H2U6o (ORCPT <rfc822;glk-linux-kernel-3@m.gmane.org>);
	Mon, 29 Aug 2011 16:58:44 -0400
Received: from natasha.panasas.com ([67.152.220.90]:56702 "EHLO
	natasha.panasas.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754646Ab1H2U6n (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Aug 2011 16:58:43 -0400
Received: from zenyatta.panasas.com (zenyatta.int.panasas.com [172.17.28.63])
	by natasha.panasas.com (8.13.1/8.13.1) with ESMTP id p7TKvYou027030;
	Mon, 29 Aug 2011 16:57:34 -0400
Received: from [172.17.132.75] (172.17.132.75) by zenyatta.int.panasas.com
 (172.17.28.63) with Microsoft SMTP Server (TLS) id 14.1.289.1; Mon, 29 Aug
 2011 16:57:28 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:5.0) Gecko/20110707 Thunderbird/5.0
In-Reply-To: <1314624752.2816.32.camel@twins>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180351>

On 08/29/2011 06:32 AM, Peter Zijlstra wrote:
> On Fri, 2011-08-26 at 13:55 -0700, Boaz Harrosh wrote:
> 
>> But this patch is for all the people and distributions that are going
>> to use the old git versions for a while, (Years).
>>
>> It is important for the Linux mailing-list review, because you get
>> patches with:
>>
>> @@@ lable out:
>> -	change foo
>> +	to bazz
>>
>> And how the hell are you suppose to know where in the file it is.
>> This is such a trivial addition, that can help unify everyone's
>> usage. I don't see the down sides.
> 
> Ah, I'm using:
> 
> # cat ~/.gitconfig 
> [diff "default"]
>                 xfuncname = "^[[:alpha:]$_].*[^:]$"
> 
> 
> For this.

It looks like a lost cause so I'll try for the last time.

Everyone is suggesting that each one do his own cooked up secrets and solutions.
And those that are stupid and know nothing like me are un-lucky. But what I'm
proposing is that by just doing a "git clone" you'll be using these settings
that we like to see, when you send us your patches.

Adding a .gitattributes file to the Linux git tree is a very simple message.
"In the linux git tree all .c and .h files are c-source files" (And git will
treat them that way)

Now that was not so hard was it? Really, no one said anything bad or negative
about the patch, only excuses how it can be achieved, very difficultly, in
another way. So for the last time:
  What are you guys afraid of? what possibly could be bad about this patch?

Sigh

Good bye to this subject
Boaz
