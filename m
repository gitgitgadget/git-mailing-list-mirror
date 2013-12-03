From: Christian Couder <christian.couder@gmail.com>
Subject: Re: [PATCH 0/5] use starts_with() and ends_with()
Date: Tue, 3 Dec 2013 07:06:59 +0100
Message-ID: <CAP8UFD2gNv7-W8ERf7Ccypb8BOMvQ6VmncMSfJ6vmAt9PSBtLw@mail.gmail.com>
References: <20131201074818.3042.57357.chriscool@tuxfamily.org>
	<20131202150956.GA20543@sigill.intra.peff.net>
	<xmqq1u1vrtmo.fsf@gitster.dls.corp.google.com>
	<20131202.202952.431769670287377861.chriscool@tuxfamily.org>
	<CALWbr2xAcvaH7L=3U=amqK3=Gf-TPOK+X0fJ3u56mGTnUDR+kw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Christian Couder <chriscool@tuxfamily.org>,
	Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>, git <git@vger.kernel.org>,
	Avery Pennarun <apenwarr@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Jonathan Nieder <jrnieder@gmail.com>, Max Horn <max@quendi.de>,
	Andreas Ericsson <ae@op5.se>
To: Antoine Pelisse <apelisse@gmail.com>
X-From: git-owner@vger.kernel.org Tue Dec 03 07:07:19 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vnj8g-0000bP-Oc
	for gcvg-git-2@plane.gmane.org; Tue, 03 Dec 2013 07:07:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752327Ab3LCGHE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Dec 2013 01:07:04 -0500
Received: from mail-ve0-f170.google.com ([209.85.128.170]:34904 "EHLO
	mail-ve0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752115Ab3LCGHA (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Dec 2013 01:07:00 -0500
Received: by mail-ve0-f170.google.com with SMTP id oy12so9786825veb.15
        for <git@vger.kernel.org>; Mon, 02 Dec 2013 22:06:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=zQFQpHH/G3cPyq97PILMFkBp8ogiMMI0atUTRhlzVtM=;
        b=cLODAvI8ngeHSythOp79CF+ypjeDbNGyX1f3NcIwHGxa6MV8WpqekLWQhSUruzixlA
         IRdiNZ9aoB7vb4BFkJblfv4CHsHQeRxNYXeKgFZFdx3PyIe8mTzqSfrnn4IYnIAQUABJ
         IK6SJ2rbWVDqepyxy0af8bCn98B4zgmWUIpVPvz3RYgtFRf6WmBfYDJltInDf5QvboWk
         UkdpDprgrY96OADLZyi5o2Zoy+hjsZztPzuZvydZIX6dqi73D9vajO5I4L2ZSD2jD/uX
         rSZy4eUDnBB37B9sG4rB7kSnVP4BkWClO1KSrR+l6t41hCrz+AE5rhpSpuuCZuYw66S6
         r01w==
X-Received: by 10.52.106.107 with SMTP id gt11mr27648768vdb.7.1386050819652;
 Mon, 02 Dec 2013 22:06:59 -0800 (PST)
Received: by 10.58.253.136 with HTTP; Mon, 2 Dec 2013 22:06:59 -0800 (PST)
In-Reply-To: <CALWbr2xAcvaH7L=3U=amqK3=Gf-TPOK+X0fJ3u56mGTnUDR+kw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238673>

On Mon, Dec 2, 2013 at 8:32 PM, Antoine Pelisse <apelisse@gmail.com> wrote:
> On Mon, Dec 2, 2013 at 8:29 PM, Christian Couder
> <chriscool@tuxfamily.org> wrote:
>> From: Junio C Hamano <gitster@pobox.com>
>>>
>>> Jeff King <peff@peff.net> writes:
>>>
>>>> This looks sane to me. Your 4/5 did not make it to the list (nor
>>>> directly to me), though. Perhaps because it is huge?
>>>
>>> Nor to me, either.
>>
>> Sorry about that I don't know what happened. Maybe my ISP has blocked
>> it because it is big.
>
> I don't know, I received it.

When I send it to my gmail account, I receive it too.
