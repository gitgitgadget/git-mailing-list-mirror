From: Dmitry Potapov <dpotapov@gmail.com>
Subject: Re: [PATCH/RFC 0/3] Per-repository end-of-line normalization
Date: Sun, 9 May 2010 03:42:22 +0400
Message-ID: <20100508234222.GA14069@dpotapov.dyndns.org>
References: <alpine.LFD.2.00.1005071303040.901@i5.linux-foundation.org>
 <alpine.LFD.2.00.1005071306190.901@i5.linux-foundation.org>
 <576B55DC-C92D-4FEB-B4E8-4A042D6F024B@gmail.com>
 <alpine.LFD.2.00.1005071355380.901@i5.linux-foundation.org>
 <384AA932-227B-43B0-9D38-560A3567918A@gmail.com>
 <alpine.LFD.2.00.1005071421340.901@i5.linux-foundation.org>
 <m2z32541b131005071430vcd851ac8yd3c783429a84f875@mail.gmail.com>
 <alpine.LFD.2.00.1005071441341.901@i5.linux-foundation.org>
 <20100508204934.GA25566@dpotapov.dyndns.org>
 <alpine.LFD.2.00.1005081450260.3711@i5.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Avery Pennarun <apenwarr@gmail.com>,
	Eyvind Bernhardsen <eyvind.bernhardsen@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	hasan.aljudy@gmail.com, kusmabite@googlemail.com, prohaska@zib.de
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Sun May 09 01:47:08 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OAtjc-0002UI-1y
	for gcvg-git-2@lo.gmane.org; Sun, 09 May 2010 01:47:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752622Ab0EHXm1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 8 May 2010 19:42:27 -0400
Received: from mail-bw0-f219.google.com ([209.85.218.219]:35689 "EHLO
	mail-bw0-f219.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751065Ab0EHXm0 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 8 May 2010 19:42:26 -0400
Received: by bwz19 with SMTP id 19so1159346bwz.21
        for <git@vger.kernel.org>; Sat, 08 May 2010 16:42:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=PRDVIWNLcbvy0V9UkwmSlfaCoL2YZCW9xXts8VnHWsk=;
        b=QqwLHDQovBmBif0IpJ1QJrSRk97EVFVZuTtGH4VYEYvHvi15dANFp2Vk9KkTheXFXH
         reA3sMgfdk7Sypw2qdMVjKmxV1RPOxJvLZQPvtVAXaTxCvZf+ep3oJj5cyVfi48mcazy
         kEzwv7y/VkW+fUmPkl0cpegVSRykIJ6FMYxEY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=KOI8nVvFPbJDr2KhvInknxXcFkjrjbBxSY/XLg4CHBnZY+rSNixeGP4mhamBkwkGeN
         QaeEM898sdQmuerSVlAxkzWvnia8PVOYqh+CFvRdE5tPupkZUy9k30kd8LeJisFj0lM0
         d4YSH9oqXVGfCA+t3lLCO+T3Z7boCqfRp2YWE=
Received: by 10.204.131.198 with SMTP id y6mr1243727bks.4.1273362144989;
        Sat, 08 May 2010 16:42:24 -0700 (PDT)
Received: from localhost (ppp85-141-234-94.pppoe.mtu-net.ru [85.141.234.94])
        by mx.google.com with ESMTPS id 14sm1082228bwz.6.2010.05.08.16.42.23
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 08 May 2010 16:42:24 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <alpine.LFD.2.00.1005081450260.3711@i5.linux-foundation.org>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146687>

On Sat, May 08, 2010 at 02:54:35PM -0700, Linus Torvalds wrote:
> 
> 
> On Sun, 9 May 2010, Dmitry Potapov wrote:
> >
> > explanation could be easily avoided by renaming 'crlf' as 'eol'.
> 
> What the heck is wrong with people?
> 
> > Now, if you look at this:
> > 
> >       *.sln -eol
> >       *.jpg -eol
> >       *.txt eol
> >       *.[ch] eol
> 
> Right. Look at it. It's totally incomprehensible. It's _worse_ than "crlf" 
> as a name.
> 
> What the f*ck does "jpg" have to do with "eol"? Nothing.

Right, nothing, in other words, no eol conversion... and "-eol" seems to
express this idea well. So, I don't see why it is worse than "crlf"...

Personally, I do not care whether it is "crlf", or "eol", but a lot of
people that I know were confused by crlf, because they thought that it
means that this file is stored with crlf, while this attribute actually
means that file needs eol conversion.

> 
> You could talk about "binary" vs "text", and it would make sense, but your 
> argument that "eol" is somehow better than "crlf" is just insane.
> 
> So I could certainly see
> 
> 	*.jpg binary
> 	*.txt text
> 
> making sense. But "eol" is certainly no better than "crlf". 

What about .sln files? They are xml files with CRLF ending. Does it mean
they are binary? Based on how it is stored, it is certainly binary, but
when it comes to "diff" or even "merge" you may want to think about them
as text, and, in general, people tend to think about them as text files.

Another example is shell scripts. You really want them to be LF even on
Windows. So, is it a binary file too?

So, this approach is not so intuitive as it may appear if you consider
only .jpg and .txt.

> 
> In the end, crlf is what we have. We're not getting rid of it, so if 
> somebody were to actually rename it, that would just mean that there are 
> _two_ different ways to say the same thing. And quite frankly, I think 
> that's worse than what we have now, so I don't think it's worth it.

I was not sure myself that the idea of renaming worth it... While I do
think that "eol" is a better name than "crlf", but not by big margin,
and as you said crlf is what we have now... so be it...


Dmitry
