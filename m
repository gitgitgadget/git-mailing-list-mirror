From: Antoine Pelisse <apelisse@gmail.com>
Subject: Re: [PATCH 0/5] use starts_with() and ends_with()
Date: Mon, 2 Dec 2013 20:32:33 +0100
Message-ID: <CALWbr2xAcvaH7L=3U=amqK3=Gf-TPOK+X0fJ3u56mGTnUDR+kw@mail.gmail.com>
References: <20131201074818.3042.57357.chriscool@tuxfamily.org>
	<20131202150956.GA20543@sigill.intra.peff.net>
	<xmqq1u1vrtmo.fsf@gitster.dls.corp.google.com>
	<20131202.202952.431769670287377861.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	git <git@vger.kernel.org>, Avery Pennarun <apenwarr@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Jonathan Nieder <jrnieder@gmail.com>, Max Horn <max@quendi.de>,
	Andreas Ericsson <ae@op5.se>
To: Christian Couder <chriscool@tuxfamily.org>
X-From: git-owner@vger.kernel.org Mon Dec 02 20:32:41 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VnZEW-0007sF-9p
	for gcvg-git-2@plane.gmane.org; Mon, 02 Dec 2013 20:32:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755667Ab3LBTcg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 Dec 2013 14:32:36 -0500
Received: from mail-pd0-f169.google.com ([209.85.192.169]:61749 "EHLO
	mail-pd0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754427Ab3LBTcd (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Dec 2013 14:32:33 -0500
Received: by mail-pd0-f169.google.com with SMTP id v10so18866061pde.0
        for <git@vger.kernel.org>; Mon, 02 Dec 2013 11:32:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=UanVKuPEoAoGVcEx/2NCW8dS5NbJiQlQT/vkKABhjLI=;
        b=VZeg0KvofoWKCvvdu4t+Vhm83Nhsrsa6xrIcjJWuJAqv3BYuJ4hdcC1T2t3iabWu2P
         +V04IlCbuHB8pMLCsBLOfv44/MvMff+WfjdgJjCJrs3/zmQKgRj4x/vgWOnaGGRfbvnp
         1wH7zMtGiHC27FfEBZvqHrZtuGiDyUlV09UDfKjO5RH7vl4POeakqafSBSnYwAJjmPll
         kQfFul1g3EK4cZgPRrdBPOV/ZtWPoVA7Vs34Vky7u74KtsuJtAtXaLgPHAP8LZ46L6sf
         6FNYHb/ksqxldKvhVh1xlKWjnZ7+fJF5GpoZnGspDdhxoGqindQNvKqkQ0Gi8BFLnsZZ
         Lscw==
X-Received: by 10.68.138.226 with SMTP id qt2mr33409776pbb.65.1386012753076;
 Mon, 02 Dec 2013 11:32:33 -0800 (PST)
Received: by 10.70.93.35 with HTTP; Mon, 2 Dec 2013 11:32:33 -0800 (PST)
In-Reply-To: <20131202.202952.431769670287377861.chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238647>

On Mon, Dec 2, 2013 at 8:29 PM, Christian Couder
<chriscool@tuxfamily.org> wrote:
> From: Junio C Hamano <gitster@pobox.com>
>>
>> Jeff King <peff@peff.net> writes:
>>
>>> On Sun, Dec 01, 2013 at 08:49:13AM +0100, Christian Couder wrote:
>>>
>>>> This is a new patch series along the lines Junio suggested in this
>>>> thread:
>>>>
>>>> http://thread.gmane.org/gmane.comp.version-control.git/238054/
>>>>
>>>> I send it now because I saw a 1.8.5 tag.
>>>
>>> This looks sane to me. Your 4/5 did not make it to the list (nor
>>> directly to me), though. Perhaps because it is huge?
>>
>> Nor to me, either.
>
> Sorry about that I don't know what happened. Maybe my ISP has blocked
> it because it is big.

I don't know, I received it.
