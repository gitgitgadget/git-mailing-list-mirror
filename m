From: John Tapsell <johnflux@gmail.com>
Subject: Re: [PATCH 2/6] Google has renamed the imap folder
Date: Thu, 19 Feb 2009 08:19:36 +0000
Message-ID: <43d8ce650902190019v14ff79a1q40e1ad3f2eb61b38@mail.gmail.com>
References: <200902190736.11912.johnflux@gmail.com>
	 <20090219080930.GA7774@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Feb 19 09:21:09 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1La49a-00087H-7I
	for gcvg-git-2@gmane.org; Thu, 19 Feb 2009 09:21:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753531AbZBSITi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Feb 2009 03:19:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753477AbZBSITi
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Feb 2009 03:19:38 -0500
Received: from yw-out-2324.google.com ([74.125.46.28]:11627 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753459AbZBSITh (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Feb 2009 03:19:37 -0500
Received: by yw-out-2324.google.com with SMTP id 5so116062ywh.1
        for <git@vger.kernel.org>; Thu, 19 Feb 2009 00:19:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=df6PY3Ss3sTHHoTHN7w5xxSKb9f2gR3rxQ6jghtIiR8=;
        b=mu5lNkOkoNQNCqN36e3b/BnJgHOyKwGp5P13dJwJfPUESi1p6eeyYdxXlfTGIFSzNo
         HnL58tz62R5Cj8bh42bOSRCE6iXulqEsmfbwykVhG4UD0yyJxzgOtLPE/6yJqTf1TttK
         QtOOZa64BBFesoBaXfqs8rg0WJGJoHWfqM3Lk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=UZ+CejIm06B8QzQ0KjVWdFWL4lKyExSIrp342RnA0n5QWNmanBXWm5qr2NpG2kyijy
         3TIKC/+ua/7PwmQyby/DM8Q7ztjVQEYGg1O7YXMhFfWTMqceHqWMFAYCULXll+XCt5LE
         Xag7yUGBdpSmy/gLC1W+LFUzthkcakuQslOgw=
Received: by 10.150.203.8 with SMTP id a8mr752430ybg.78.1235031576294; Thu, 19 
	Feb 2009 00:19:36 -0800 (PST)
In-Reply-To: <20090219080930.GA7774@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110645>

2009/2/19 Jeff King <peff@peff.net>:
> On Thu, Feb 19, 2009 at 07:36:11AM +0000, John Tapsell wrote:
>
>>  [imap]
>> -     folder = "[Gmail]/Drafts"
>> +     folder = "[Google Mail]/Drafts"
>
> I thought the consensus from the last patch was that it should stay
> Gmail, as that is the name used in most countries?

Doh, I meant to remove that change :)

>
>> +You might need to instead use:  folder = "[Google Mail]/Drafts" if you get an error
>> +that the "Folder doesn't exist".
>
> And this hunk certainly implies that's what you were shooting for.
>
> -Peff
>
