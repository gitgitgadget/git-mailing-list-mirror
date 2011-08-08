From: Christian Couder <christian.couder@gmail.com>
Subject: Re: [PATCH 17/18] revert: Introduce --continue to continue the operation
Date: Mon, 8 Aug 2011 09:31:03 +0200
Message-ID: <CAP8UFD0izFOW0xHQB8ZT3+bbTjGtSm-ZWHs6AWdJoEneRX32mw@mail.gmail.com>
References: <1312454356-3070-1-git-send-email-artagnon@gmail.com>
	<1312454356-3070-18-git-send-email-artagnon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Christian Couder <chriscool@tuxfamily.org>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Jeff King <peff@peff.net>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Mon Aug 08 09:31:10 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QqKIo-0000n6-49
	for gcvg-git-2@lo.gmane.org; Mon, 08 Aug 2011 09:31:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753513Ab1HHHbG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Aug 2011 03:31:06 -0400
Received: from mail-yx0-f174.google.com ([209.85.213.174]:35615 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753176Ab1HHHbD (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Aug 2011 03:31:03 -0400
Received: by yxj19 with SMTP id 19so2326961yxj.19
        for <git@vger.kernel.org>; Mon, 08 Aug 2011 00:31:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=Ht0sRe1j/B7mNfNE0Nhx4je7KQs4cRTUKNCyqglV+Fo=;
        b=NVLMOrWt+YwkAjxJ1Vt+B4kkxXCHNuoIcuUGI88tvpQ5AwBG9MbPB5Skv9xYwToNBs
         SY77GChAKd391YwQGbldV4Wx1M/Esy9hdMSTn9h6HB9X7E9Hy5TbjroQBXb71HrQueOx
         LrLU+VH4JqEf/ZQxlpd4F+efuGjN5yP6emvEM=
Received: by 10.150.104.20 with SMTP id b20mr1282400ybc.301.1312788663132;
 Mon, 08 Aug 2011 00:31:03 -0700 (PDT)
Received: by 10.147.41.13 with HTTP; Mon, 8 Aug 2011 00:31:03 -0700 (PDT)
In-Reply-To: <1312454356-3070-18-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178945>

Hi Ram,

On Thursday 04 August 2011 12:39:15 Ramkumar Ramachandra wrote:
>
> +test_expect_success '--signoff is not automatically propogated to resolved
> conflict' '

s/propogated/propagated/

I found nothing else from another look at the tests in the series so you can
add an "Acked-by: Christian Couder <chriscool@tuxfamily.org>" or "Signed-of-
by: Christian Couder <chriscool@tuxfamily.org>".

Thanks,
Christian.
