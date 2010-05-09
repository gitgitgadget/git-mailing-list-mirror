From: Eyvind Bernhardsen <eyvind.bernhardsen@gmail.com>
Subject: Re: [PATCH/RFC 0/3] Per-repository end-of-line normalization
Date: Sun, 9 May 2010 09:49:03 +0200
Message-ID: <42C31791-ACD3-4D43-99E6-287F9E63EDAB@gmail.com>
References: <alpine.LFD.2.00.1005071303040.901@i5.linux-foundation.org> <alpine.LFD.2.00.1005071306190.901@i5.linux-foundation.org> <576B55DC-C92D-4FEB-B4E8-4A042D6F024B@gmail.com> <alpine.LFD.2.00.1005071355380.901@i5.linux-foundation.org> <384AA932-227B-43B0-9D38-560A3567918A@gmail.com> <alpine.LFD.2.00.1005071421340.901@i5.linux-foundation.org> <m2z32541b131005071430vcd851ac8yd3c783429a84f875@mail.gmail.com> <alpine.LFD.2.00.1005071441341.901@i5.linux-foundation.org> <20100508204934.GA25566@dpotapov.dyndns.org> <alpine.LFD.2.00.1005081450260.3711@i5.linux-foundation.org> <20100508234222.GA14069@dpotapov.dyndns.org>
Mime-Version: 1.0 (Apple Message framework v1078)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Avery Pennarun <apenwarr@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	hasan.aljudy@gmail.com, kusmabite@googlemail.com, prohaska@zib.de
To: Dmitry Potapov <dpotapov@gmail.com>
X-From: git-owner@vger.kernel.org Sun May 09 09:49:17 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OB1GG-0000c0-TB
	for gcvg-git-2@lo.gmane.org; Sun, 09 May 2010 09:49:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751667Ab0EIHtK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 9 May 2010 03:49:10 -0400
Received: from mail-ew0-f220.google.com ([209.85.219.220]:45026 "EHLO
	mail-ew0-f220.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751644Ab0EIHtJ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 9 May 2010 03:49:09 -0400
Received: by ewy20 with SMTP id 20so629256ewy.1
        for <git@vger.kernel.org>; Sun, 09 May 2010 00:49:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:subject:mime-version
         :content-type:from:in-reply-to:date:cc:content-transfer-encoding
         :message-id:references:to:x-mailer;
        bh=0FGfY+F82ZRkQ3n/3LsG6SaertYAhWcU2h/5JouYle0=;
        b=ggQq20r8kmjUNZ69pPe+0NtsYAv9twdynYTlERk/EptwghWDr+Pwi3bEiWIsloR0pE
         4zOJsxgyi+8FQ635uCByUqEwHhYn+lpkRw1YiCoY68gv7+1+J6k5eS9U+/P90beNsrnX
         BxkNQgdRx3UtnYPGwAEE3l2cMmHqVTJ2uwYOU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=subject:mime-version:content-type:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to:x-mailer;
        b=po9F7cj2XujlCidP42D7ABtHiUFZLIaEn3UG6H2mCBu0qKH9U63i2j6mrIjCf0V0Lk
         9AHqWjdoz2PWhuIAW1tq4UFqGxwpbQ/yN+lDVA06toUZGKkjEgqqgAFOFo3JZiy+C1Qm
         p0hh9IWe5cAFU3WioHFn2Nwv1xKXzcjbnLowM=
Received: by 10.213.60.138 with SMTP id p10mr662292ebh.35.1273391345802;
        Sun, 09 May 2010 00:49:05 -0700 (PDT)
Received: from vredefort.d.eyvind.bernhardsens.net (eyvind.bernhardsens.net [84.49.224.5])
        by mx.google.com with ESMTPS id 16sm1931887ewy.7.2010.05.09.00.49.04
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 09 May 2010 00:49:05 -0700 (PDT)
In-Reply-To: <20100508234222.GA14069@dpotapov.dyndns.org>
X-Mailer: Apple Mail (2.1078)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146709>

On 9. mai 2010, at 01.42, Dmitry Potapov wrote:

> On Sat, May 08, 2010 at 02:54:35PM -0700, Linus Torvalds wrote:

[...]

>> You could talk about "binary" vs "text", and it would make sense, but your 
>> argument that "eol" is somehow better than "crlf" is just insane.
>> 
>> So I could certainly see
>> 
>> 	*.jpg binary
>> 	*.txt text
>> 
>> making sense. But "eol" is certainly no better than "crlf". 
> 
> What about .sln files? They are xml files with CRLF ending. Does it mean
> they are binary? Based on how it is stored, it is certainly binary, but
> when it comes to "diff" or even "merge" you may want to think about them
> as text, and, in general, people tend to think about them as text files.
> 
> Another example is shell scripts. You really want them to be LF even on
> Windows. So, is it a binary file too?

I think "binary" and "text" are the wrong things to talk about in this case.

If we were to following Avery's suggestion that we look at what we would have implemented had autocrlf not already existed, it would be better to call "crlf" something like "eolconv".  You're not saying that a file is text or binary as such, rather that "I want eol conversion for this file" or "I don't want eol conversion for this file".

Flagging a file as "-eolconv" because it should always have LFs or always CRLFs seems logical to me.  "eolconv=auto" also makes sense.

[...]

>> In the end, crlf is what we have. We're not getting rid of it, so if 
>> somebody were to actually rename it, that would just mean that there are 
>> _two_ different ways to say the same thing. And quite frankly, I think 
>> that's worse than what we have now, so I don't think it's worth it.
> 
> I was not sure myself that the idea of renaming worth it... While I do
> think that "eol" is a better name than "crlf", but not by big margin,
> and as you said crlf is what we have now... so be it...

Renaming "crlf" might not be worth it, but thinking about what it should look like definitely is worth it.  Since I already have a patch series that changes this area, I'd like for it to be future proof.

I think the idea that we're stuck with "crlf" (or any bad ui design) for ever and ever is depressing, and I reject it.  It would be easy to create a new attribute with a better name that is the same setting under the hood, and deprecate "crlf".  The old attribute would still work in existing repositories (indefinitely, if needs be), but new users wouldn't have to be confused by its poor name.

I'm not saying I want to replace "crlf" right now!  I'm just saying that it makes sense to think about how we would want to replace it, and try not to introduce any new change that will make it harder to do the right thing later.
-- 
Eyvind
