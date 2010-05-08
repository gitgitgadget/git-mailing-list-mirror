From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH/RFC 0/3] Per-repository end-of-line normalization
Date: Sat, 8 May 2010 14:54:35 -0700 (PDT)
Message-ID: <alpine.LFD.2.00.1005081450260.3711@i5.linux-foundation.org>
References: <alpine.LFD.2.00.1005071240590.901@i5.linux-foundation.org> <g2s32541b131005071258s92e058bakc8f3a4df1e1dc634@mail.gmail.com> <alpine.LFD.2.00.1005071303040.901@i5.linux-foundation.org> <alpine.LFD.2.00.1005071306190.901@i5.linux-foundation.org>
 <576B55DC-C92D-4FEB-B4E8-4A042D6F024B@gmail.com> <alpine.LFD.2.00.1005071355380.901@i5.linux-foundation.org> <384AA932-227B-43B0-9D38-560A3567918A@gmail.com> <alpine.LFD.2.00.1005071421340.901@i5.linux-foundation.org> <m2z32541b131005071430vcd851ac8yd3c783429a84f875@mail.gmail.com>
 <alpine.LFD.2.00.1005071441341.901@i5.linux-foundation.org> <20100508204934.GA25566@dpotapov.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Avery Pennarun <apenwarr@gmail.com>,
	Eyvind Bernhardsen <eyvind.bernhardsen@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	hasan.aljudy@gmail.com, kusmabite@googlemail.com, prohaska@zib.de
To: Dmitry Potapov <dpotapov@gmail.com>
X-From: git-owner@vger.kernel.org Sat May 08 23:56:57 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OAs12-0000gE-Gv
	for gcvg-git-2@lo.gmane.org; Sat, 08 May 2010 23:56:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753695Ab0EHV4l (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 8 May 2010 17:56:41 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:37508 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753360Ab0EHV4k (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 8 May 2010 17:56:40 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id o48LuZc5029533
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Sat, 8 May 2010 14:56:36 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id o48LuYCX004616;
	Sat, 8 May 2010 14:56:34 -0700
In-Reply-To: <20100508204934.GA25566@dpotapov.dyndns.org>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
X-Spam-Status: No, hits=-3.945 required=5 tests=AWL,BAYES_00,OSDL_HEADER_SUBJECT_BRACKETED
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146679>



On Sun, 9 May 2010, Dmitry Potapov wrote:
>
> explanation could be easily avoided by renaming 'crlf' as 'eol'.

What the heck is wrong with people?

> Now, if you look at this:
> 
>       *.sln -eol
>       *.jpg -eol
>       *.txt eol
>       *.[ch] eol

Right. Look at it. It's totally incomprehensible. It's _worse_ than "crlf" 
as a name.

What the f*ck does "jpg" have to do with "eol"? Nothing.

You could talk about "binary" vs "text", and it would make sense, but your 
argument that "eol" is somehow better than "crlf" is just insane.

So I could certainly see

	*.jpg binary
	*.txt text

making sense. But "eol" is certainly no better than "crlf". 

In the end, crlf is what we have. We're not getting rid of it, so if 
somebody were to actually rename it, that would just mean that there are 
_two_ different ways to say the same thing. And quite frankly, I think 
that's worse than what we have now, so I don't think it's worth it.

		Linus
