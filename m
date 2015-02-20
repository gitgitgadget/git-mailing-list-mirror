From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFH] GSoC 2015 application
Date: Fri, 20 Feb 2015 00:26:29 -0800
Message-ID: <CAPc5daVJ_nYk=tWqpUYPpsX6Z50H429jOh8QfMwUdNDdTDMq9w@mail.gmail.com>
References: <20150218191417.GA7767@peff.net> <CACsJy8B_zkAecL2Wag8a5c9-_C9eoA9dYj4ciBXqXRVmRW77zw@mail.gmail.com>
 <20150220071342.GB8763@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Duy Nguyen <pclouds@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Feb 20 09:26:56 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YOivH-0004e3-7W
	for gcvg-git-2@plane.gmane.org; Fri, 20 Feb 2015 09:26:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753618AbbBTI0v (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Feb 2015 03:26:51 -0500
Received: from mail-ob0-f170.google.com ([209.85.214.170]:46562 "EHLO
	mail-ob0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752663AbbBTI0u (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Feb 2015 03:26:50 -0500
Received: by mail-ob0-f170.google.com with SMTP id va2so22852037obc.1
        for <git@vger.kernel.org>; Fri, 20 Feb 2015 00:26:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=QQLVuUSvfuiI30xD6NAPXET53RsnRjKiqBap1AR3qyc=;
        b=Q8OJiYedPWe+tX2CCeIrRJY0fwwQYvcxkixk8qpXuZgNNHv1nuw52/OfhdjTfdbAtv
         5Iv++6GirFyh4wE2ZgCDTgFnz6ZRRoq995DCfwOD/yUiDjpcqKLqmxYotNG8QBmCn6yQ
         Poz84HQrcJmFHbYFR1wx+358FiQqBmFogzrYTuZRAu/d/Qlw0KTq2KE/pPcJNGahWIPi
         k8FOUyMnHKVkyj9+XHEIQ0McqrgbWXxvuVSivjl1d7lQR7YcyKJTSlii0PSgZCChnURV
         s5Xi7EHjdDwKSc/hfwbuqEKJKl+DSEAYk5dHtYx3Qzfl/G6pD1TS8XbbY+CC6lo4CyEb
         g+dA==
X-Received: by 10.182.68.12 with SMTP id r12mr5761205obt.84.1424420809806;
 Fri, 20 Feb 2015 00:26:49 -0800 (PST)
Received: by 10.202.48.132 with HTTP; Fri, 20 Feb 2015 00:26:29 -0800 (PST)
In-Reply-To: <20150220071342.GB8763@peff.net>
X-Google-Sender-Auth: oChghtSU-Vl6gABf_82nVy0b-Uc
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264141>

On Thu, Feb 19, 2015 at 11:13 PM, Jeff King <peff@peff.net> wrote:

>> There is debian bug 777690 [1] that's basically about making tag's
>> version sort aware about -rc, -pre suffixes. I imagine it would touch
>> versioncmp.c and builtin/tag.c (to retrieve the suffixes from config
>> file).
>>
>> [1] https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=777690
>
> I think that's a reasonable thing to work on, but it's too big for a
> microproject and too small for a GSoC.

That is certainly too big as a Micro, but I do not think it is too small
for GSoC, if it is to be done right (meaning, not just implementing an
arbitrary version comparison hardwired, but design how to make it
extensible).

I have a feeling that I am complaining that student projects are
designed to be too grand and getting told that I am overly pessimistic
by everybody else every year. Perhaps this year others may prove
me wrong, if we can find mentors, that is ;-)
