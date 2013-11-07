From: Christian Couder <christian.couder@gmail.com>
Subject: Re: [PATCH v3 2/2] Rename suffixcmp() to has_suffix() and invert its result
Date: Thu, 7 Nov 2013 12:04:42 +0100
Message-ID: <CAP8UFD1AZQM8HX-DgW0NzN2RidTi9fAcN0XHC8=sz3J4nrwQ1Q@mail.gmail.com>
References: <20131105210237.21525.61810.chriscool@tuxfamily.org>
	<20131106221735.GB10302@google.com>
	<xmqq38n96pdo.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Christian Couder <chriscool@tuxfamily.org>,
	git <git@vger.kernel.org>, Avery Pennarun <apenwarr@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Jeff King <peff@peff.net>, Max Horn <max@quendi.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Nov 07 12:04:52 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VeNOO-0005pl-4s
	for gcvg-git-2@plane.gmane.org; Thu, 07 Nov 2013 12:04:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754333Ab3KGLEp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 Nov 2013 06:04:45 -0500
Received: from mail-vc0-f174.google.com ([209.85.220.174]:37787 "EHLO
	mail-vc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752474Ab3KGLEn (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Nov 2013 06:04:43 -0500
Received: by mail-vc0-f174.google.com with SMTP id ld13so244129vcb.19
        for <git@vger.kernel.org>; Thu, 07 Nov 2013 03:04:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=x7SfcVdUEssVElroeB/ML5dG2xhQMOwS6NZ16baJl2Q=;
        b=GKzXSJokMCAXupU7sKiFeDSyeN4munDTiqq8EP0QNU2kM83jNZqLBNG8VD6rYDZXKg
         lFcLbLTXugbXAdi9IUGbE/qGYJFCEo04V8zcP2UW+h4PQlG+B9VKQj9kmgormvqdbp3b
         uFJy8MwRMBS0VN3mlULwWVOgr/RnAod2lfg8lleQjEKO1z9oByRolQAyABaX/lrSNHDA
         FLDuebr1hjji/OKcM2IO6thAUeG0XWKqSgicwb+o0Dv8inqqj6EfshVGP6Au4G+hg2Ab
         427EqX0k/cz/SEqID2A4H1P01iVg8/fJHYM2/CKuir/oOsBky8vPZmuEP7YEE4pkNw1j
         SZKA==
X-Received: by 10.58.216.74 with SMTP id oo10mr6286791vec.0.1383822282942;
 Thu, 07 Nov 2013 03:04:42 -0800 (PST)
Received: by 10.58.253.136 with HTTP; Thu, 7 Nov 2013 03:04:42 -0800 (PST)
In-Reply-To: <xmqq38n96pdo.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237394>

On Thu, Nov 7, 2013 at 1:12 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Jonathan Nieder <jrnieder@gmail.com> writes:
>
>>> The old name followed the pattern anything-cmp(), which suggests
>>> a general comparison function suitable for e.g. sorting objects.
>>> But this was not the case for suffixcmp().
>>
>> It's not clear to me that prefixcmp() is usable for sorting objects,
>> either.  Shouldn't it get the same treatment?
>
> Sounds like a plan for a good follow-up series.

Ok, I will have a look.

>> If some day we invent a type for 4-byte-aligned object names, it might
>> make sense to do something similar to hashcmp, distinguishing between
>> hashcmp for use where ordering is important and something like hash_eq
>> when checking for equality (since I suspect the latter can be made
>> faster).
>
> Interesting.

Yeah, but I will pass on this one.

Thanks,
Christian.
