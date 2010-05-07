From: Eyvind Bernhardsen <eyvind@bernhardsen.org>
Subject: Re: [PATCH/RFC 0/3] Per-repository end-of-line normalization
Date: Fri, 7 May 2010 23:37:20 +0200
Message-ID: <FA7479D2-1859-4F8B-AC94-013BD6A4F608@bernhardsen.org>
References: <x2s40aa078e1005061340vaf404ab3g30b2b98ca408205@mail.gmail.com>  <i2i32541b131005071235z64c9de56w29a2d555cf801c9a@mail.gmail.com>  <alpine.LFD.2.00.1005071240590.901@i5.linux-foundation.org>  <g2s32541b131005071258s92e058bakc8f3a4df1e1dc634@mail.gmail.com>  <alpine.LFD.2.00.1005071303040.901@i5.linux-foundation.org>  <alpine.LFD.2.00.1005071306190.901@i5.linux-foundation.org>  <576B55DC-C92D-4FEB-B4E8-4A042D6F024B@gmail.com> <alpine.LFD.2.00.1005071355380.901@i5.linux-foundation.org>  <384AA932-227B-43B0-9D38-560A3567918A@gmail.com> <alpine.LFD.2.00.1005071421340.901@i5.linux-foundation.org> <m2z32541b131005071430vcd851ac8yd3c783429a84f875@mail.gmail.com>
Mime-Version: 1.0 (iPhone Mail 7E18)
Content-Type: text/plain;
	charset=us-ascii;
	format=flowed;
	delsp=yes
Content-Transfer-Encoding: 7bit
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Eyvind Bernhardsen <eyvind.bernhardsen@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>,
	"hasan.aljudy@gmail.com" <hasan.aljudy@gmail.com>,
	"kusmabite@googlemail.com" <kusmabite@googlemail.com>,
	"prohaska@zib.de" <prohaska@zib.de>
To: Avery Pennarun <apenwarr@gmail.com>
X-From: git-owner@vger.kernel.org Fri May 07 23:57:40 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OAVY8-00083g-Uu
	for gcvg-git-2@lo.gmane.org; Fri, 07 May 2010 23:57:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758684Ab0EGV5c (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 May 2010 17:57:32 -0400
Received: from eyvind.bernhardsens.net ([84.49.224.5]:49519 "EHLO
	eyvind.bernhardsens.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753903Ab0EGV5b (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 May 2010 17:57:31 -0400
X-Greylist: delayed 1261 seconds by postgrey-1.27 at vger.kernel.org; Fri, 07 May 2010 17:57:30 EDT
Received: from [172.16.3.207] (iheltens-fon.d.eyvind.bernhardsens.net [172.16.3.207])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by eyvind.bernhardsens.net (Postfix) with ESMTP id 004E22A92D0;
	Fri,  7 May 2010 23:36:28 +0200 (CEST)
In-Reply-To: <m2z32541b131005071430vcd851ac8yd3c783429a84f875@mail.gmail.com>
X-Mailer: iPhone Mail (7E18)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146606>

On 7. mai 2010, at 23.30, Avery Pennarun <apenwarr@gmail.com> wrote:

> On Fri, May 7, 2010 at 5:23 PM, Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
>> On Fri, 7 May 2010, Eyvind Bernhardsen wrote:
>>> I don't understand.  All you have to do is add "* auto-eol=true"  
>>> to your
>>> .gitattributes, and line endings will be normalized exactly as if  
>>> you'd
>>> set "core.autocrlf".  Why would you have to write totally new rules?
>>> Which rules?
>>
>> I think "* auto-eol=true" is just crazy. We would _never_ want to  
>> do that.
>> Any project that does that should be shot in the head.
>
> In the interests of further making myself look like an idiot:
>
> Just to clarify, is it crazy because that line would convert all
> files, even binary ones, where core.autocrlf auto-detects whether
> files are binary or text?

Just to clarify a bit more, that is _not_ what it would do.  The  
"crlf" attribute is still respected, of course.

Also, I meant to write "* crlf=auto", not "* auto-eol=true", if that  
makes it any less crazy.
-- 
Eyvind
