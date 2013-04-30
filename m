From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH v2 3/6] sha1_name: avoid Yoda conditions
Date: Tue, 30 Apr 2013 17:20:30 -0500
Message-ID: <CAMP44s3K8BOfnUdc0514KgvYsbncSBO4DRSyfqhFQJomGrZN0A@mail.gmail.com>
References: <1367358554-4257-1-git-send-email-felipe.contreras@gmail.com>
	<1367358554-4257-4-git-send-email-felipe.contreras@gmail.com>
	<7vehdrbrvz.fsf@alter.siamese.dyndns.org>
	<CAMP44s3osZJO1P6_KoPVON0cOSAD5D-OZmL=aKGkcWReortiCw@mail.gmail.com>
	<7v1u9rbrb4.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, Ramkumar Ramachandra <artagnon@gmail.com>,
	Jeff King <peff@peff.net>, Duy Nguyen <pclouds@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed May 01 00:20:38 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UXIub-00067O-2K
	for gcvg-git-2@plane.gmane.org; Wed, 01 May 2013 00:20:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933831Ab3D3WUc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Apr 2013 18:20:32 -0400
Received: from mail-lb0-f170.google.com ([209.85.217.170]:56525 "EHLO
	mail-lb0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755642Ab3D3WUb (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Apr 2013 18:20:31 -0400
Received: by mail-lb0-f170.google.com with SMTP id r10so1009787lbi.15
        for <git@vger.kernel.org>; Tue, 30 Apr 2013 15:20:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        bh=Ny7R/9qCW750XemEZlhUhbbZUbyM29bolD77fMWgWk0=;
        b=E/9rPI4kZNaSfxPKaLK27NCJzH4k35s2JlAIGY/II8d++30SXj106ZSGfRdXiIClLc
         +x+kUGcx7+Xa0SfBPQMla9iwF9QwvezUui6G7sApN+rF170x1Nv4nibPiOSe0QPv+r7I
         0tRsz5Nr80Wsq20jneb89h+/V7no5ZGnDGk47yjMptVTUvRxn56Gwff0WkVtTY9wOd9E
         tNqsYd1Dk3x/6qCUflYrCy2XdDRGS3PIQSZcyoz3kIS2Rv0GLOpD9c5K5wLsCQKY8qb7
         dRxw7hVvTnDqTHmeFGgUzgH0e5OytdfhTkAp5rjZ4QNgxfAv6s51Be9x5PhrfyRXz8f0
         JtXw==
X-Received: by 10.112.166.101 with SMTP id zf5mr317644lbb.59.1367360430288;
 Tue, 30 Apr 2013 15:20:30 -0700 (PDT)
Received: by 10.114.83.167 with HTTP; Tue, 30 Apr 2013 15:20:30 -0700 (PDT)
In-Reply-To: <7v1u9rbrb4.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223028>

On Tue, Apr 30, 2013 at 5:13 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Felipe Contreras <felipe.contreras@gmail.com> writes:
>
>> On Tue, Apr 30, 2013 at 5:00 PM, Junio C Hamano <gitster@pobox.com> wrote:
>>> What is a Yoda condition?
>>
>> ---
>> Using if (constant == variable) instead of if (variable == constant),
>> like if (4 == foo).
>>
>> Because it's like saying "if blue is the sky" or "if tall is the man".
>
> That is an invalid analogy, as the sentences do not make sense.
>
> A much better explanation I heard on this list is that people do not
> say "If 1 is smaller than the number of your wives, you have a big
> problem".
>
> I actually was not asking why people find the convention to visually
> align comparison with number lines unusual. We discussed this style
> long time ago on this list.  I haven't heard the "Yoda condtion"
> expression and was asking about the "Yoda" part.

It's popular culture.

http://en.wikipedia.org/wiki/Yoda

-- 
Felipe Contreras
