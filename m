From: Robert Buck <buck.robert.j@gmail.com>
Subject: Re: [PATCH/RFC v2 1/4] Add "core.eolStyle" variable to control 
	end-of-line conversion
Date: Sun, 9 May 2010 16:46:37 -0400
Message-ID: <AANLkTikg7Tc6zJvfBELBQoeAxebFenNLivEs92j8c83D@mail.gmail.com>
References: <cover.1273352819.git.eyvind.bernhardsen@gmail.com>
	 <c8ef28b72709013f17e093954a0f4e2ad1fb9652.1273352819.git.eyvind.bernhardsen@gmail.com>
	 <alpine.LFD.2.00.1005081455450.3711@i5.linux-foundation.org>
	 <E2A9C4D2-010F-44B2-BF6A-627DE8B72FB5@gmail.com>
	 <BFFD3CAC-E7D9-49D8-9B67-C3F5157646F3@gmail.com>
	 <20100509070043.GB14069@dpotapov.dyndns.org>
	 <CD080D38-811C-4BBF-A5CB-6B613555FE72@gmail.com>
	 <AANLkTikRJ6Hl_fRNRZbxeNNgwv9UTm2fPrOKv4GbT0qJ@mail.gmail.com>
	 <E6434515-5357-4FF4-8049-5E4FCE8B29E4@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org List" <git@vger.kernel.org>,
	Dmitry Potapov <dpotapov@gmail.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	mat <matthieu.stigler@gmail.com>,
	hasen j <hasan.aljudy@gmail.com>,
	Erik Faye-Lund <kusmabite@googlemail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Avery Pennarun <apenwarr@gmail.com>,
	Finn Arne Gangstad <finnag@pvv.org>
To: Eyvind Bernhardsen <eyvind.bernhardsen@gmail.com>
X-From: git-owner@vger.kernel.org Sun May 09 22:46:46 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OBDOg-00070e-71
	for gcvg-git-2@lo.gmane.org; Sun, 09 May 2010 22:46:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751300Ab0EIUqj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 9 May 2010 16:46:39 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:45687 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751100Ab0EIUqi (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 9 May 2010 16:46:38 -0400
Received: by wyf19 with SMTP id 19so448520wyf.19
        for <git@vger.kernel.org>; Sun, 09 May 2010 13:46:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type;
        bh=spOYQ3SF5mYBCiqnss5Le2/64A/YJeo673YNIbA9+Ak=;
        b=aJ1G5+K1uxLhZ1D2OxbpipEz270t9Ws78Nuo54VImlxfCjub6U0d0+SvwjNKqoke85
         YVDwvKkGzkW43+7LtUWJMX0XLUfCSrJFJbmNvJw/eJw7FLtUbd4Vz6NE5D8EbI/lIul8
         vNkwYlyE3sY/CCmvuR9IV1Qlq6FWLI3NYeoMk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=K5/fC8KgBHFfFDz6wis8bLX9lF7Bsg8creCVVLTZrZoIrluBUpLJmyciHPQlQx3G1A
         sYSbZCvAgVBzJ9pF6/xX80mYCuMfoMIM6eBH/qOD/Q6eUg2AgByqKJUtvgpqMzgIBKJg
         VA6NW+LrMICZpySjcz9uFFVsKxLW0ONiJGNI8=
Received: by 10.216.90.84 with SMTP id d62mr1787102wef.211.1273437997243; Sun, 
	09 May 2010 13:46:37 -0700 (PDT)
Received: by 10.216.7.207 with HTTP; Sun, 9 May 2010 13:46:37 -0700 (PDT)
In-Reply-To: <E6434515-5357-4FF4-8049-5E4FCE8B29E4@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146746>

> On 9. mai 2010, at 13.14, Robert Buck wrote:
>
>> So, the meanings of these would become...
>>
>> core.crlf [ auto | input | false ] : 'auto' means to enable
>> bidirectional normalization, and 'false' would mean do not
>> normalization, and 'input' would mean normalize on input only,
>> otherwise output lf. Is this true?
>
> No, "auto" means to enable normalization for files git doesn't identify as text files, "true" means to always normalize, and "false" means never normalize.

I probably missed something. The part that confuses me in this
statement is that you said "for files git doesn't identify as text
files". The convert.c source is the heart of this, and if a file is
not identified as text it is presumed to be binary. The statement made
seems to imply you'd auto-convert PDF files? I know you did not mean
that, but it could have been read that way.

What specifically happens in the three modes? Would it be precise to
say the following?

    "Files subject to EOL conversion are those that are explicitly
identified through attributes to be text files, or those
algorithmically determined to be text files which happen to not bear
the "text" file attribute. Otherwise the default value, "false",
applies and no EOL conversions occur."

-Bob
