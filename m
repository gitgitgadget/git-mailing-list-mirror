From: Luke Lu <git@vicaya.com>
Subject: Re: I'm a total push-over..
Date: Wed, 23 Jan 2008 22:51:37 -0800
Message-ID: <F23CA352-416C-49EC-8132-688784CF3C18@vicaya.com>
References: <alpine.LFD.1.00.0801221515350.1741@woody.linux-foundation.org>	 <4796FBB6.9080609@op5.se> <20080123091558.GP14871@dpotapov.dyndns.org>	 <4797095F.9020602@op5.se> <e51f66da0801230601n6edd2639lff70415afa9f9026@mail.gmail.com> <4797518A.3040704@op5.se>
Mime-Version: 1.0 (Apple Message framework v753)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Marko Kreen <markokr@gmail.com>,
	Dmitry Potapov <dpotapov@gmail.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Andreas Ericsson <ae@op5.se>
X-From: git-owner@vger.kernel.org Thu Jan 24 07:52:17 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JHvwc-0004dE-NZ
	for gcvg-git-2@gmane.org; Thu, 24 Jan 2008 07:52:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752419AbYAXGvn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Jan 2008 01:51:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752265AbYAXGvn
	(ORCPT <rfc822;git-outgoing>); Thu, 24 Jan 2008 01:51:43 -0500
Received: from rv-out-0910.google.com ([209.85.198.185]:18183 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750714AbYAXGvm (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Jan 2008 01:51:42 -0500
Received: by rv-out-0910.google.com with SMTP id k20so147013rvb.1
        for <git@vger.kernel.org>; Wed, 23 Jan 2008 22:51:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:in-reply-to:references:mime-version:content-type:message-id:cc:content-transfer-encoding:from:subject:date:to:x-mailer:sender;
        bh=veRyNwcgTxAy6QStJy+HxP96YGP5bFdEzD/E+cPb3qs=;
        b=QZsFQvdfagJqKvA8aYJ1c2DMxFvFRuNlOoNjiluWRNYd0i+RBHyobyg0qUcfvF0aqD8993aQrrN0Vn6AKEqIsdH5VfQF/4kaYfxynrN32LUeAf5cz70r6AvGCGvJfPWWpFHuQQV28PeCMIVo35LlO0/YyHTn3IowPk35LJJVkYM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=in-reply-to:references:mime-version:content-type:message-id:cc:content-transfer-encoding:from:subject:date:to:x-mailer:sender;
        b=KTHhpt0ts4NHtth6sdXkHK6g6ss+4eVWSt+75bVyIosG2wpG5n+bJZQ1SEyFmQI1deKhaZZf46nLAUziJR2GSkQyIjApTw8+1yTpwM6rUdBvp7NYuOC8AAmMAUjbZ1DxOqwBp7nWEH8oO+DnYM2hMhMGD+6k4SgrBlpaSlYDR54=
Received: by 10.140.188.10 with SMTP id l10mr219129rvf.247.1201157500544;
        Wed, 23 Jan 2008 22:51:40 -0800 (PST)
Received: from ?192.168.15.20? ( [98.207.63.2])
        by mx.google.com with ESMTPS id b39sm1036827rvf.8.2008.01.23.22.51.39
        (version=SSLv3 cipher=OTHER);
        Wed, 23 Jan 2008 22:51:39 -0800 (PST)
In-Reply-To: <4797518A.3040704@op5.se>
X-Mailer: Apple Mail (2.753)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71593>

On Jan 23, 2008, at 6:39 AM, Andreas Ericsson wrote:
> Marko Kreen wrote:
>> On 1/23/08, Andreas Ericsson <ae@op5.se> wrote:
>>> Dmitry Potapov wrote:
>>>> On Wed, Jan 23, 2008 at 09:32:54AM +0100, Andreas Ericsson wrote:
>>>>> The FNV hash would be better (pasted below), but I doubt
>>>>> anyone will ever care, and there will be larger differences
>>>>> between architectures with this one than the lt_git hash (well,
>>>>> a function's gotta have a name).
>>>> Actually, Bob Jenkins' lookup3 hash is twice faster in my tests
>>>> than FNV, and also it is much less likely to have any collision.
>>>>
>>> >From http://burtleburtle.net/bob/hash/doobs.html
>>> ---
>>> FNV Hash
>>>
>>> I need to fill this in. Search the web for FNV hash. It's faster  
>>> than my hash on Intel (because Intel has fast multiplication),  
>>> but slower on most other platforms. Preliminary tests suggested  
>>> it has decent distributions.
>> I suspect that this paragraph was about comparison with lookup2
>
>
> It might be. It's from the link Dmitry posted in his reply to my  
> original
> message. (something/something/doobs.html).
>
>> (not lookup3) because lookup3 beat easily all the "simple" hashes
>
> By how much? FNV beat Linus' hash by 0.01 microseconds / insertion,
> and 0.1 microsecons / lookup. We're talking about a case here where
> there will never be more lookups than insertions (unless I'm much
> mistaken).
>
>> If you don't mind few percent speed penalty compared to Jenkings
>> own optimized version, you can use my simplified version:
>>   http://repo.or.cz/w/pgbouncer.git?a=blob;f=src/ 
>> hash.c;h=5c9a73639ad098c296c0be562c34573189f3e083;hb=HEAD
>
> I don't, but I don't care that deeply either. On the one hand,
> it would be nifty to have an excellent hash-function in git.
> On the other hand, it would look stupid with something that's
> quite clearly over-kill.
>
>> It works always with "native" endianess, unlike Jenkins fixed-endian
>> hashlittle() / hashbig().  It may or may not matter if you plan
>> to write values on disk.
>> Speed-wise it may be 10-30% slower worst case (in my case sparc- 
>> classic
>> with unaligned data), but on x86, lucky gcc version and maybe
>> also memcpy() hack seen in system.h, it tends to be ~10% faster,
>> especially as it does always 4byte read in main loop.
>
> It would have to be a significant improvement in wall-clock time
> on a test-case of hashing 30k strings to warrant going from 6 to 80
> lines of code, imo. I still believe the original dumb hash Linus
> wrote is "good enough".
>
> On a side-note, it was very interesting reading, and I shall have
> to add jenkins3_mkreen() to my test-suite (although the "keep
> copyright note" license thing bugs me a bit).

Would you, for completeness' sake, please add Tcl and STL hashes to  
your test suite? The numbers are quite interesting. Is your test  
suite available somewhere, so we can test with our own data and  
hardware as well. Both Tcl hash and STL (from SGI probably HP days,  
still the current default with g++) string hashes are extremely  
simple (excluding the loop constructs):

Tcl: h += (h<<3) + c; 	// essentially *9+c (but work better on non- 
late-intels)
STL: h = h * 5 + c;	// worse than above for most of my data

Thanks,

__Luke
