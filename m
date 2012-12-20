From: Adam Spiers <git@adamspiers.org>
Subject: Re: [PATCH v6 0/7] make test output coloring more intuitive
Date: Thu, 20 Dec 2012 18:08:15 +0000
Message-ID: <CAOkDyE-yfFQxxgsumRB8N1zXN2LTq89=pArU-85Z+3Oyruiwxg@mail.gmail.com>
References: <1355682495-22382-1-git-send-email-git@adamspiers.org>
	<7v8v8xrfnp.fsf@alter.siamese.dyndns.org>
	<CAOkDyE9B_HfUZmqNqO35mtjTvdihBTiW=uOV2oEQgLUw1xyf=A@mail.gmail.com>
	<20121220153411.GA1497@sigill.intra.peff.net>
	<CAOkDyE9y6JvNKTCBoJqu47Hn-3axfjZPUdBhf4bOEfSP-9Q84A@mail.gmail.com>
	<20121220161110.GA10605@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Junio C Hamano <gitster@pobox.com>, git list <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Dec 20 19:16:00 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tlkev-0006qh-UY
	for gcvg-git-2@plane.gmane.org; Thu, 20 Dec 2012 19:15:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752061Ab2LTSPh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 Dec 2012 13:15:37 -0500
Received: from mail-we0-f177.google.com ([74.125.82.177]:60328 "EHLO
	mail-we0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751274Ab2LTSPf (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Dec 2012 13:15:35 -0500
X-Greylist: delayed 439 seconds by postgrey-1.27 at vger.kernel.org; Thu, 20 Dec 2012 13:15:35 EST
Received: by mail-we0-f177.google.com with SMTP id x48so1710201wey.22
        for <git@vger.kernel.org>; Thu, 20 Dec 2012 10:15:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type;
        bh=U2/Q2PxqBeV3oVmvtoVTyId6XnVwZ4VKN66tvWrt4e8=;
        b=Fw1NNn05vg1dIciQR+oHsuXrhcHxB77w0n9cpmL/j0Yy/5ybF0x7cBkZ77pj30rpKV
         pXBpho2fpcuak1HpA06o4xSQWKMiZuA+q4vJaMRgUGiNVDeUA71QPlIb+1V2A14fv2JF
         NdkppycC4DSZPLhJEFDSIjxqBMYiLTSQ/yMhyI0me3/AmNHY/5ERNMTSycv4k+mPlDOe
         qyexQjWkt2vekAMTj/BfqyC28yk2tkcYb0py8Z8pPeuO97A0OJj/rQh1uLEAAsOTbIIl
         eB7wfl4o7JKeQZ1wJq/VSTVZsU0h9EygAXvKGShLoHHN3ZYte60EdsQBR/ATtZfJvm3m
         qAiQ==
Received: by 10.180.85.165 with SMTP id i5mr18481903wiz.11.1356026895148; Thu,
 20 Dec 2012 10:08:15 -0800 (PST)
Received: by 10.194.56.232 with HTTP; Thu, 20 Dec 2012 10:08:15 -0800 (PST)
In-Reply-To: <20121220161110.GA10605@sigill.intra.peff.net>
X-Google-Sender-Auth: bVeo69tn9VZDLMTPd0ZykC0LCVs
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211910>

On Thu, Dec 20, 2012 at 4:11 PM, Jeff King <peff@peff.net> wrote:
> On Thu, Dec 20, 2012 at 03:44:53PM +0000, Adam Spiers wrote:
>> > diff --git a/t/test-lib.sh b/t/test-lib.sh
>> > index 256f1c6..31f59af 100644
>> > --- a/t/test-lib.sh
>> > +++ b/t/test-lib.sh
>> > @@ -227,7 +227,7 @@ then
>> >                 pass)
>> >                         tput setaf 2;;            # green
>> >                 info)
>> > -                       tput bold; tput setaf 6;; # bold cyan
>> > +                       tput setaf 6;; # cyan
>> >                 *)
>> >                         test -n "$quiet" && return;;
>> >                 esac
>> >
>>
>> Good point, I forgot to check what it looked like with -v.  Since this
>> series is already on v6, is there a more lightweight way of addressing
>> this tiny tweak than sending v7?
>
> It is ultimately up to Junio, but I suspect he would be OK if you just
> reposted patch 4/7 with the above squashed.

I'll do that if Junio is OK with that.

> Or even just said "I like
> this, please squash it into patch 4 (change info messages from
> yellow/brown to bold cyan).

Yes, I'm OK with this way too :)  Of course "bold" would need to be dropped
from the commit message.
