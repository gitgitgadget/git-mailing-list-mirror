From: Stefan Beller <stefanbeller@googlemail.com>
Subject: Re: [PATCH] .mailmap: Map email addresses to names
Date: Fri, 12 Jul 2013 21:10:23 +0200
Message-ID: <51E0549F.2000103@googlemail.com>
References: <7vzjttq9wk.fsf@alter.siamese.dyndns.org> <1373629769-23647-1-git-send-email-stefanbeller@googlemail.com> <1373629769-23647-2-git-send-email-stefanbeller@googlemail.com> <20130712185735.GC8482@google.com> <51E052DC.3080304@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jul 12 21:10:30 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uxijc-0000uh-In
	for gcvg-git-2@plane.gmane.org; Fri, 12 Jul 2013 21:10:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965331Ab3GLTKY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Jul 2013 15:10:24 -0400
Received: from mail-wi0-f172.google.com ([209.85.212.172]:49085 "EHLO
	mail-wi0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965199Ab3GLTKY (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Jul 2013 15:10:24 -0400
Received: by mail-wi0-f172.google.com with SMTP id c10so1036702wiw.5
        for <git@vger.kernel.org>; Fri, 12 Jul 2013 12:10:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:x-enigmail-version:content-type
         :content-transfer-encoding;
        bh=/EDQ6JrOS07EaSPseBoqJC8Kc050MqmgGqkirEI4Y4Y=;
        b=ba1AeG7gWusSL6JU1CKYiznugOQre2TMtrBDj3Fw9Iv/EBy1CiNRito/Wb4Y7VgWOm
         /W+BpTsKlrgfWpWnketPPl9y+q3jysIYscthE6PxCg65VxF2vLeI9JcIUxwU5TT82VET
         htu6mSWJyDTWbXTjG9pP35db+FA0I48CZ6FRx8a26qp3SqbOdMtTWfcGFdZ44waGMBbl
         //59g5OW524h0qkYSULeruvi6zDz64V0hA84CmP3eFLDAk33FT2T0lrazObqi0FlnQ0J
         pHkWvSbMdw8oz6x2ezm8kqwTMn2b+zMSv4kzrzU5lXY5no5Sr1pHAeJf8EzQyePqfV8n
         QSNA==
X-Received: by 10.194.82.97 with SMTP id h1mr24731059wjy.95.1373656222490;
        Fri, 12 Jul 2013 12:10:22 -0700 (PDT)
Received: from [192.168.1.3] (ip-109-91-109-128.unitymediagroup.de. [109.91.109.128])
        by mx.google.com with ESMTPSA id i1sm5084367wiz.6.2013.07.12.12.10.21
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Fri, 12 Jul 2013 12:10:21 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130623 Thunderbird/17.0.7
In-Reply-To: <51E052DC.3080304@googlemail.com>
X-Enigmail-Version: 1.4.6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230241>

>From the man page

*** WARNING *** The locale specified by the environment affects sort
order.  Set LC_ALL=C to get the traditional sort  order  that  uses
       native byte values.

And indeed I can avoid being nitpicked again for wrong sorting. ;)

On 07/12/2013 09:02 PM, Stefan Beller wrote:
> 
> Which tool would you recommend to sort stuff?
> Or rather the exact parameters for /usr/bin/sort ?
> 
> Thanks,
> Stefan
> 
> On 07/12/2013 08:57 PM, Jonathan Nieder wrote:
>> Stefan Beller wrote:
>>
>>> --- a/.mailmap
>>> +++ b/.mailmap
>>> @@ -5,99 +5,146 @@
>> [...]
>>>  Chris Shoemaker <c.shoemaker@cox.net>
>>> -Dan Johnson <computerdruid@gmail.com>
>>>  Dana L. How <danahow@gmail.com>
>>>  Dana L. How <how@deathvalley.cswitch.com>
>>>  Daniel Barkalow <barkalow@iabervon.org>
>>> +Dan Johnson <computerdruid@gmail.com>
>>
>> Small nit: the sorting looks broken here and in similar places below
>> (the usual ordering is Dan < Dana < Daniel).
>>
>> Thanks,
>> Jonathan
>>
> 
