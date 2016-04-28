From: Jacob Keller <jacob.keller@gmail.com>
Subject: Re: [PATCH 2/5] t5550: break submodule config test into multiple sub-tests
Date: Thu, 28 Apr 2016 08:25:41 -0700
Message-ID: <CA+P7+xqpntuL==uW75r29TxJsdjJ5WDdfBEorqd5-zHKZt5mQg@mail.gmail.com>
References: <20160428133534.GA19056@sigill.intra.peff.net> <20160428133704.GB25319@sigill.intra.peff.net>
 <CAGZ79kacgJ_=C-Y=QkSDmvEvCrmEbcvdMkg0x76zkj-Y86m4=g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jeff King <peff@peff.net>,
	Lars Schneider <larsxschneider@gmail.com>,
	Git Users <git@vger.kernel.org>,
	Jens Lehmann <Jens.Lehmann@web.de>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Thu Apr 28 17:26:17 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1avnpR-0004DH-7W
	for gcvg-git-2@plane.gmane.org; Thu, 28 Apr 2016 17:26:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752907AbcD1P0E (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Apr 2016 11:26:04 -0400
Received: from mail-oi0-f53.google.com ([209.85.218.53]:34131 "EHLO
	mail-oi0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752774AbcD1P0D (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Apr 2016 11:26:03 -0400
Received: by mail-oi0-f53.google.com with SMTP id k142so87382889oib.1
        for <git@vger.kernel.org>; Thu, 28 Apr 2016 08:26:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=ha8zJbcQ4VNEd9e82EP/YPr0KSY7RkafkSvVYkTyKN0=;
        b=Iah5Gm+cHnv6UoXgNAG9bzmHf87SLegpaJ/d3P/e1QiOEwEfGR1HrA8+DuuJMNf5VW
         8RiUbTopbkX5XF7RN0erHycvGQ1MWd86Ie/RwDuhOedMcRCxJkwk9pE5CebtN501t2ml
         3dCCnjOw6VhqnT0YkoCGangU8cUiJDRFnTatfIV9uHGIAf1wst6tBTrMub2gePHMMhr7
         BE9QAVBZsyDTUtC9qrHxRe3qj1eXTs0FH5E40zt5ZC2AoNck6ZcymfjFEnNuHppHHNiQ
         kz+NeeJOO6d3ywwN+9Tq5OkXU+P9x2bUHHUKXGBHcY7YF4VCuIplLRwQT02yzRxcK1S7
         dy7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=ha8zJbcQ4VNEd9e82EP/YPr0KSY7RkafkSvVYkTyKN0=;
        b=AhAa+rl3a9UeDxQPb+70dcT5jB6bHRWFao4qP972s7nVQzpm7PHIq1ZuQvpqZsTg3b
         ZQxwsljW3w8iOOmTFYfZKa/PFxO+IvuRJL2codh8xq5Dt7/sgPlWqmjGsOdcpcA8Kjke
         4PSExQNBlVH7IJcnpvHFD6XjD/JicM22kjfE/Ego8gtN5Y1Z0bS+0FuZ3eo4kQMZf27u
         7Cqilmf5iJGFPV3gkZ6aMJv6t4lLwvFA6zP7KdiGmrzq1El410lXWf3hTGpyi2eggS5t
         SFA2D2AtJHkIDc2KgkMudluFnB2i0+Obalw6tZPNluA73f6Fqzhu36HCMbFoWPRRcA8t
         fE2A==
X-Gm-Message-State: AOPr4FUC+AjlfhWErC925ZThbGc7OLj9ashMaECDxe39hwO6As3S3tYoAM5yCSyLw8el1gG7DfXF2+oQx0GY3g==
X-Received: by 10.157.39.202 with SMTP id c68mr6479836otb.36.1461857161124;
 Thu, 28 Apr 2016 08:26:01 -0700 (PDT)
Received: by 10.182.117.132 with HTTP; Thu, 28 Apr 2016 08:25:41 -0700 (PDT)
In-Reply-To: <CAGZ79kacgJ_=C-Y=QkSDmvEvCrmEbcvdMkg0x76zkj-Y86m4=g@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292899>

On Thu, Apr 28, 2016 at 8:21 AM, Stefan Beller <sbeller@google.com> wrote:
> On Thu, Apr 28, 2016 at 6:37 AM, Jeff King <peff@peff.net> wrote:
>> Right now we test only the cloning case, but there are other
>> interesting cases (e.g., fetching). Let's pull the setup
>> bits into their own test, which will make things flow more
>> logically once we start adding more tests which use the
>> setup.
>>
>> Let's also introduce some whitespace to the clone-test to
>> split the two parts: making sure it fails without our
>> cmdline config, and that it succeeds with it.
>>
>> Signed-off-by: Jeff King <peff@peff.net>
>> ---
>>  t/t5550-http-fetch-dumb.sh | 8 ++++++--
>>  1 file changed, 6 insertions(+), 2 deletions(-)
>>
>> diff --git a/t/t5550-http-fetch-dumb.sh b/t/t5550-http-fetch-dumb.sh
>> index 81cc57f..e8e91bb 100755
>> --- a/t/t5550-http-fetch-dumb.sh
>> +++ b/t/t5550-http-fetch-dumb.sh
>> @@ -91,17 +91,21 @@ test_expect_success 'configured username does not override URL' '
>>         expect_askpass pass user@host
>>  '
>>
>> -test_expect_success 'cmdline credential config passes into submodules' '
>> +test_expect_success 'set up repo with http submodules' '
>
> set up or setup?
>
> $ grep -r "set up" |wc -l
> 69
> $ grep -r "setup" |wc -l
> 1162
>
> Apart from that nit, this patch looks good to me.
>

Yes this looks quite a bit more readable.

Thanks,
Jake
