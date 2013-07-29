From: Daniele Segato <daniele.segato@gmail.com>
Subject: Re: [PATCHv3] git-tag man: when to use lightweight or annotated tags
Date: Mon, 29 Jul 2013 20:20:12 +0200
Message-ID: <51F6B25C.9040800@gmail.com>
References: <51EFA9A9.4010103@gmail.com> <7vtxjj66kn.fsf@alter.siamese.dyndns.org> <51F12BE6.80606@gmail.com> <51F13A8F.9040400@xiplink.com> <51F23706.5040009@gmail.com> <51F2375E.1080003@gmail.com> <51F28D08.8050507@xiplink.com> <51F2AFBA.4020602@gmail.com> <51F2B2CD.1030004@gmail.com> <20130726190602.GC29799@sigill.intra.peff.net> <51F2E676.6080404@xiplink.com> <7v4nbd2ys2.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Marc Branchaud <marcnarc@xiplink.com>, Jeff King <peff@peff.net>,
	Git Mailing List <git@vger.kernel.org>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jul 29 20:20:26 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V3s3V-0001ch-R2
	for gcvg-git-2@plane.gmane.org; Mon, 29 Jul 2013 20:20:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755799Ab3G2SUV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Jul 2013 14:20:21 -0400
Received: from mail-ee0-f50.google.com ([74.125.83.50]:48029 "EHLO
	mail-ee0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755234Ab3G2SUT (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Jul 2013 14:20:19 -0400
Received: by mail-ee0-f50.google.com with SMTP id d51so1624511eek.37
        for <git@vger.kernel.org>; Mon, 29 Jul 2013 11:20:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=8RhaS0XquiuNZnmL6sBMp/5MRH2yiniGPIhFTlbGkKM=;
        b=igIfr+Lg2eb5IiHqYKI8UEXS8Vx1krdPAW8x4mN7D+5f8XzRN7rjRNYPcI7K5/wfPt
         D30i/jXCdmgeuAeIUnUrQ6XhKmSq814S17pYN5CT8pYR2U4Fjjcj8UF3R5TJ8C8xL903
         8fJn4wE3Lj2q4dFeZeXju0aZVZwDBPxiTge7taU4DY/2k2QV4eJemDSzprCsgTsemg8N
         cZc3voWQRtZpHvqT002od2CXoFnfrCDWCqQi3MJ0PvZuXo2p6qjY/7YUOkHYdbM1GPx9
         I8QUiu8JFv4dfTgULMPG1r4bX5X0y8wi8FYVr+iHedNDX6BkRtocwmky5eaADoEi9iMQ
         il+Q==
X-Received: by 10.14.223.199 with SMTP id v47mr61072813eep.32.1375122018597;
        Mon, 29 Jul 2013 11:20:18 -0700 (PDT)
Received: from [192.168.1.16] (host253-69-dynamic.4-87-r.retail.telecomitalia.it. [87.4.69.253])
        by mx.google.com with ESMTPSA id n45sm103855534eew.1.2013.07.29.11.20.15
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Mon, 29 Jul 2013 11:20:17 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130620 Thunderbird/17.0.7
In-Reply-To: <7v4nbd2ys2.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231316>

On 07/29/2013 05:04 PM, Junio C Hamano wrote:
> Marc Branchaud <marcnarc@xiplink.com> writes:
>
>> On 13-07-26 03:06 PM, Jeff King wrote:
>>> On Fri, Jul 26, 2013 at 07:33:01PM +0200, Daniele Segato wrote:
>>>
>>>> stress the difference between the two with suggestion on when the user
>>>> should use one in place of the other.
>>>>
>>>> Signed-off-by: Daniele Segato <daniele.segato@gmail.com>
>>>
>>> The intent of your patch seems reasonable to me. There are a few minor
>>> language and typographical mistakes, and the patch itself is
>>> whitespace-damaged.
>>>
>>> I also do not know that it is accurate to say "most git commands ignore
>>> lightweight tags". It is really only "naming" ones like "git describe".
>>>
>>> Here is a re-send of your patch with the fixups I would recommend.
>>
>> I'm happy with Peff's version.
>>
>> Reviewed-by: Marc Branchaud <marcnarc@xiplink.com>
>>
>> (Daniele, don't feel put off because Jonathan & I are accepting Peff's text.
>>   If you think it still needs improving please speak up!)
>>

I'm not feeling putting off. I thank you for the help you gave me.
Hopefully I'll be able to provide a better patch next time.

>> 		M.
>
> Thank you all.  Will apply.
>

I'm probably too late, I did proposed another version of the page 
tweaking all the description part in response to Jonathan Nieder and 
re-using the Jeff King proposition.

I've been busy in the last days and couldn't reply before now.

I'll understand if you don't like it and don't want to lose more time on 
this.

Regards,
Daniele Segato
