From: Eyvind Bernhardsen <eyvind.bernhardsen@gmail.com>
Subject: Re: [PATCH/RFC v2 1/4] Add "core.eolStyle" variable to control end-of-line conversion
Date: Sun, 9 May 2010 10:34:23 +0200
Message-ID: <B840F421-1037-4628-99FA-3A1F2A9A9DC3@gmail.com>
References: <cover.1273352819.git.eyvind.bernhardsen@gmail.com> <c8ef28b72709013f17e093954a0f4e2ad1fb9652.1273352819.git.eyvind.bernhardsen@gmail.com> <alpine.LFD.2.00.1005081455450.3711@i5.linux-foundation.org> <E2A9C4D2-010F-44B2-BF6A-627DE8B72FB5@gmail.com> <BFFD3CAC-E7D9-49D8-9B67-C3F5157646F3@gmail.com> <20100509070043.GB14069@dpotapov.dyndns.org>
Mime-Version: 1.0 (Apple Message framework v1078)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	"git@vger.kernel.org" <git@vger.kernel.org>,
	mat <matthieu.stigler@gmail.com>,
	hasen j <hasan.aljudy@gmail.com>,
	Erik Faye-Lund <kusmabite@googlemail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Avery Pennarun <apenwarr@gmail.com>,
	Robert Buck <buck.robert.j@gmail.com>,
	Finn Arne Gangstad <finnag@pvv.org>
To: Dmitry Potapov <dpotapov@gmail.com>
X-From: git-owner@vger.kernel.org Sun May 09 10:34:35 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OB1y6-0006Sp-Ru
	for gcvg-git-2@lo.gmane.org; Sun, 09 May 2010 10:34:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751976Ab0EIIe3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 9 May 2010 04:34:29 -0400
Received: from mail-ew0-f220.google.com ([209.85.219.220]:47596 "EHLO
	mail-ew0-f220.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751722Ab0EIIe2 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 9 May 2010 04:34:28 -0400
Received: by ewy20 with SMTP id 20so633888ewy.1
        for <git@vger.kernel.org>; Sun, 09 May 2010 01:34:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:subject:mime-version
         :content-type:from:in-reply-to:date:cc:content-transfer-encoding
         :message-id:references:to:x-mailer;
        bh=Kqnf/VEqBWQWC6055Fnp97cylTuHqnROOCFZr3Af67Y=;
        b=UMa+11XLs8trfNXio08NXmgPj5JArLiQT+1FxiphDnipKV8akUzk+69n2CEfUeAUrS
         fcxkDv7yuQz85zJpfh9QPRcwPunP83r5S0EK36yrmHEiZd1dE0OFmTVZIW/x2eb+cvGB
         JlyOZAnEKab7Nxq6+FyCqIETIC04YfsDs1vwM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=subject:mime-version:content-type:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to:x-mailer;
        b=v7r5yMua8pe6KXrGoiemyKR6bzDsIBRZoDh0tlsZj0EGMzUyPj3T9gEJbmgAI4U1IL
         KQK6uHzXvMh9WzTOesvrMIYji5n7LDfnsreaUaMUiFldDSrHHt8RZu3qBYBw2j7+zFVH
         YVuEeGQpHBbk39a/Zf/jZq5u6j+n7OyupbuZA=
Received: by 10.213.67.129 with SMTP id r1mr978338ebi.69.1273394067303;
        Sun, 09 May 2010 01:34:27 -0700 (PDT)
Received: from vredefort.d.eyvind.bernhardsens.net (eyvind.bernhardsens.net [84.49.224.5])
        by mx.google.com with ESMTPS id 16sm1943874ewy.15.2010.05.09.01.34.24
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 09 May 2010 01:34:26 -0700 (PDT)
In-Reply-To: <20100509070043.GB14069@dpotapov.dyndns.org>
X-Mailer: Apple Mail (2.1078)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146712>

On 9. mai 2010, at 09.00, Dmitry Potapov wrote:

> On Sun, May 09, 2010 at 12:53:17AM +0200, Eyvind Bernhardsen wrote:
>> On 9. mai 2010, at 00.17, Eyvind Bernhardsen
>> <eyvind.bernhardsen@gmail.com> wrote:
>> 
>>> I'll try to think of a better name.
>> 
>> Heh. How about "localcrlf={true,false,native}"?
> 
> IMHO, the 'local' prefix certainly does not improve anything. Also,
> I would rather call default as "default" instead of "native". So,
> why not use "core.crlf={true, false, default}"?
> 
> Though crlf is not my preferable name, I think consistency is important,
> and we should use the same name here as in git attributes.

But the attribute does something different!  The attribute turns eol conversion on and off, the configuration variable decides which line endings to use when conversion is on.  They should be related, but making them identical doesn't make any kind of sense.

To be consistent, I would expect a variable called "core.crlf" to do the same thing as the attribute, so "core.crlf=auto" would replace "core.autocrlf={true,input}", allowing you to turn on line ending conversion without having to modify the repository.

If we added this consistently named "core.crlf", we'd still need a separate config variable to decide between LFs and CRLFs in the working directory, so what should that variable be called?

"localcrlf" at least conveys the idea that this is a local setting, so it's not too much of a stretch to guess that it controls the working directory.
-- 
Eyvind
