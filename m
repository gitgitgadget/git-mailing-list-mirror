From: Eyvind Bernhardsen <eyvind.bernhardsen@gmail.com>
Subject: Re: [PATCH/RFC v2 1/4] Add "core.eolStyle" variable to control end-of-line conversion
Date: Sun, 9 May 2010 22:11:01 +0200
Message-ID: <06EEFAAE-31E7-4DAD-9FD3-D9809B16BCD9@gmail.com>
References: <cover.1273352819.git.eyvind.bernhardsen@gmail.com> <c8ef28b72709013f17e093954a0f4e2ad1fb9652.1273352819.git.eyvind.bernhardsen@gmail.com> <alpine.LFD.2.00.1005081455450.3711@i5.linux-foundation.org> <E2A9C4D2-010F-44B2-BF6A-627DE8B72FB5@gmail.com> <BFFD3CAC-E7D9-49D8-9B67-C3F5157646F3@gmail.com> <alpine.LFD.2.00.1005081600490.3711@i5.linux-foundation.org> <A5422145-63E1-4AF4-9184-7A6D15E9C2B6@gmail.com> <alpine.LFD.2.00.1005091046570.3711@i5.linux-foundation.org>
Mime-Version: 1.0 (Apple Message framework v1078)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	mat <matthieu.stigler@gmail.com>,
	hasen j <hasan.aljudy@gmail.com>,
	Erik Faye-Lund <kusmabite@googlemail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Avery Pennarun <apenwarr@gmail.com>,
	Dmitry Potapov <dpotapov@gmail.com>,
	Robert Buck <buck.robert.j@gmail.com>,
	Finn Arne Gangstad <finnag@pvv.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Sun May 09 22:12:00 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OBCr1-0003K1-Qd
	for gcvg-git-2@lo.gmane.org; Sun, 09 May 2010 22:12:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751374Ab0EIULJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 9 May 2010 16:11:09 -0400
Received: from mail-ew0-f220.google.com ([209.85.219.220]:43893 "EHLO
	mail-ew0-f220.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750770Ab0EIULH convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 9 May 2010 16:11:07 -0400
Received: by ewy20 with SMTP id 20so727646ewy.1
        for <git@vger.kernel.org>; Sun, 09 May 2010 13:11:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:subject:mime-version
         :content-type:from:in-reply-to:date:cc:content-transfer-encoding
         :message-id:references:to:x-mailer;
        bh=Ex27G9p7gLIb57yQGJxiIHp6G3HJDccALYP5u9Tj98I=;
        b=tHWw6E/s3GBHT+f4u9n92+aIDLz/6JzSUNTMvM/oDWHvx/XOLujukDKs2RkWs101KX
         2wqeQ8TdIEXJGM3P5DILaYcuEn5VdSfcs2zdtynTRc31+YmnxJeozxn+tQL/HLmkZzSZ
         lH7z1X/Ty4VbDCrqNxmSTPEJExmGlPSK6ZAGE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=subject:mime-version:content-type:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to:x-mailer;
        b=rpInhwjP+Gh+os8dNRnDdsYAnn3WTLMLuiTRb9RIuGwR/jlG7FSXI2bd5Xa/gCfJSz
         Ae9o4eNGnSp95b5QSCodAIqqdY8deHgdBhdvmFy2kvtiOV9jw77yYvAmR3F2ByIWSfkS
         ixZ8MFC2m0CYAjKVBny1ic65zyVrRdPY357WI=
Received: by 10.213.44.14 with SMTP id y14mr1213861ebe.96.1273435864026;
        Sun, 09 May 2010 13:11:04 -0700 (PDT)
Received: from vredefort.d.eyvind.bernhardsens.net (eyvind.bernhardsens.net [84.49.224.5])
        by mx.google.com with ESMTPS id 16sm2187094ewy.11.2010.05.09.13.11.03
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 09 May 2010 13:11:03 -0700 (PDT)
In-Reply-To: <alpine.LFD.2.00.1005091046570.3711@i5.linux-foundation.org>
X-Mailer: Apple Mail (2.1078)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146744>

On 9. mai 2010, at 20.11, Linus Torvalds wrote:

> On Sun, 9 May 2010, Eyvind Bernhardsen wrote:
>> 
>> I'm sorry.  Are you the same Linus Torvalds who wrote this:
>> 
>>> Btw, since we're discussing this, I do think that our current "crlf=input" 
>>> syntax for .gitattributes is pretty dubious.
> 
> Yes, it's dubious. But as with the kernel, we need to support backwards 
> compatibility for things that have reasonably been used (and "input" has).

Oh, absolutely.  I'm not suggesting removing support for it, I just don't think it's a good reason to keep the old naming alive.

> I really brought it up as an example of things that weren't necessarily 
> all that well designed.
> 
> That said, it looks like people actually do want per-file line-ending 
> settings, ie not just a global "I want CRLF vs LF". So it looks like 
> crlf=input is actually useful in a .gitattributes files, if only because 
> some people seem to want to mix CRLF and just LF in the same repository.
> 
> It also sounds like people actually want to have the reverse (ie not just 
> "input", but have a mode where LF may be the default, but then some 
> particular files must always be CRLF even if most files are normal text).

My plan was to "support" that by disabling conversion for those files; git wouldn't enforce the line endings, but at least it wouldn't break them.

I guess there's no reason not to have the option to enforce in there if there is a huge demand for that.

> So I suspect we want to really have support for all four combinations 
> _both_ in the .git/config file, _and_ in the .gitattributes file.
> 
> The four cases would be "none" ("binary" or "-crlf"), "lf" ("input" or 
> "crlf=input"), "system default", and "force crlf".

Well, "crlf=crlf" and "crlf=lf" would look silly, but no more than I could live with.  .gitconfig is already covered in my series.
-- 
Eyvind
