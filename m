Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.8 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2F9261F955
	for <e@80x24.org>; Thu, 28 Jul 2016 12:10:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757303AbcG1MKR (ORCPT <rfc822;e@80x24.org>);
	Thu, 28 Jul 2016 08:10:17 -0400
Received: from mail-wm0-f51.google.com ([74.125.82.51]:36499 "EHLO
	mail-wm0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757122AbcG1MKQ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 28 Jul 2016 08:10:16 -0400
Received: by mail-wm0-f51.google.com with SMTP id q128so249191463wma.1
        for <git@vger.kernel.org>; Thu, 28 Jul 2016 05:10:15 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=b//C6PQAFTk38GkDlzHIhdyqcnIu4RQRRVCJDtEG9Ts=;
        b=OXiSao+6650/AVNUywSUNdags19+TKvG+BIyhalonbgzC8coZ1KanyWf/9N119Lo3o
         8T49P+iCMThJPMaiWGTVI+nqne/Mm+eG6YCRT1L7olHsMlHIXcVcgxzXZMWF2FGzPcq4
         42xWUOJsPu/m8x0GTO8E2ah64Er2Uz9j/Yux/56/JD+SLBvZJUqQVTqDDuHtvy+2CEHK
         qKzgGwK4fkYweWU14coeXTPMy9cmIirb8guB1luTXKyPLhfhb+5V6KqVHTuSTkGh+skC
         femKskHXdV3/gsAJrLneH3Eoz9gxk5ns/hylYfp9Ab3wJCxfE87lDpJaxhnHIhZCLfsS
         kbKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=b//C6PQAFTk38GkDlzHIhdyqcnIu4RQRRVCJDtEG9Ts=;
        b=gFYziz4uPrET6QK3DFlVob0AgcJwUEWYQOk8AjewFWgwX0Ia/VvcMivDf4hWslEOCa
         GyzktmrQBmAZY0CmjdMeIabiMR6XOKBMLPJrc7OV/8z8VSEOYH58vqVzGSGuwSzqYL4q
         pHI01I1KjmSkISXP16tHozT6eOBpaDAVpaxsXB6pr/geGBb/Vfq9NAzLz8Dnseg9mC8Y
         3yctj8JerbT/o//CK5EPoWWOhG41lUBx44Qxwbag/4/qPFoxIUJawpqvIGUUzpz9JZDF
         MaYQ6R6ct0ZxMXtoARHoe8oR6mNmjMvOGr6CGKHGDCbs8aSPAF+UmyzxEg37ijWyXBYJ
         IUog==
X-Gm-Message-State: AEkoouvOoBFiuY9uMpRySdYTNINiWE1f8uFwhwduynhZOxIq+SqaMdV0FGgvN4PPX2907g==
X-Received: by 10.194.6.229 with SMTP id e5mr31838266wja.85.1469707814623;
        Thu, 28 Jul 2016 05:10:14 -0700 (PDT)
Received: from slxbook4.ads.autodesk.com ([62.159.156.210])
        by smtp.gmail.com with ESMTPSA id gw4sm11204235wjc.45.2016.07.28.05.10.13
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 28 Jul 2016 05:10:13 -0700 (PDT)
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [PATCH v2 5/5] convert: add filter.<driver>.process option
From:	Lars Schneider <larsxschneider@gmail.com>
In-Reply-To: <20160727181148.GC32219@sigill.intra.peff.net>
Date:	Thu, 28 Jul 2016 14:10:12 +0200
Cc:	Git Mailing List <git@vger.kernel.org>, gitster@pobox.com,
	jnareb@gmail.com, tboegi@web.de, mlbright@gmail.com,
	remi.galan-alfonso@ensimag.grenoble-inp.fr, pclouds@gmail.com,
	e@80x24.org, ramsay@ramsayjones.plus.com
Content-Transfer-Encoding: 8BIT
Message-Id: <9AB58AFB-7533-4897-8497-187C6D1239C8@gmail.com>
References: <20160722154900.19477-1-larsxschneider@gmail.com> <20160727000605.49982-1-larsxschneider@gmail.com> <20160727000605.49982-6-larsxschneider@gmail.com> <20160727013251.GA12159@sigill.intra.peff.net> <5FE50D2C-5D97-4523-9BE2-88745B3F83EA@gmail.com> <20160727181148.GC32219@sigill.intra.peff.net>
To:	Jeff King <peff@peff.net>
X-Mailer: Apple Mail (2.3124)
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org


> On 27 Jul 2016, at 20:11, Jeff King <peff@peff.net> wrote:
> 
> On Wed, Jul 27, 2016 at 07:31:26PM +0200, Lars Schneider wrote:
> 
>>>> +	strbuf_grow(sb, size + 1);	// we need one extra byte for the packet flush
>>> 
>>> What happens if size is the maximum for size_t here (i.e., 4GB-1 on a
>>> 32-bit system)?
>> 
>> Would that be an acceptable solution?
>> 
>> if (size + 1 > SIZE_MAX)
>> 	return die("unrepresentable length for filter buffer");
> 
> No, because by definition "size" will wrap to 0. :)
> 
> You have to do:
> 
>  if (size > SIZE_MAX - 1)
> 	die("whoops");
> 
>> Can you point me to an example in the Git source how this kind of thing should
>> be handled?
> 
> The strbuf code itself checks for overflows. So you could do:
> 
>  strbuf_grow(sb, size);
>  ... fill up with size bytes ...
>  strbuf_addch(sb, ...); /* extra byte for whatever */
> 
> That does mean _possibly_ making a second allocation just to add the
> extra byte, but in practice it's not likely (unless the input exactly
> matches the strbuf's growth pattern).
> 
> If you want to do it yourself, I think:
> 
>  strbuf_grow(sb, st_add(size, 1));

I like that solution! Thanks!


> would work.
> 
>>>> +	while (
>>>> +		bytes_read > 0 && 					// the last packet was no flush
>>>> +		sb->len - total_bytes_read - 1 > 0 	// we still have space left in the buffer
>>>> +	);
>>> 
>>> And I'm not sure if you need to distinguish between "0" and "-1" when
>>> checking byte_read here.
>> 
>> We want to finish reading in both cases, no?
> 
> If we get "-1", that's from an unexpected EOF during the packet_read(),
> because you set GENTLE_ON_EOF. So there's nothing left to read, and we
> should break and return an error.

Right.


> I guess "0" would come from a flush packet? Why would the filter send
> back a flush packet (unless you were using them to signal end-of-input,
> but then why does the filter have to send back the number of bytes ahead
> of time?).

Sending the bytes ahead of time (if available) might be nice for efficient
buffer allocation. I am changing the code so that both cases can be handled
(size ahead of time and no size ahead of time).


>>> Why 8K? The pkt-line format naturally restricts us to just under 64K, so
>>> why not take advantage of that and minimize the framing overhead for
>>> large data?
>> 
>> I took inspiration from here for 8K MAX_IO_SIZE:
>> https://github.com/git/git/blob/master/copy.c#L6
>> 
>> Is this read limit correct? Should I read 8 times to fill a pkt-line?
> 
> MAX_IO_SIZE is generally 8 _megabytes_, not 8K. The loop in copy.c just
> haad to pick an arbitrary size for doing its read/write proxying.  I
> think in practice you are not likely to get much benefit from going
> beyond 8K or so there, just because operating systems tend to do things
> in page-sizes anyway, which are usually 4K.
> 
> But since you are formatting the result into a form that has framing
> overhead, anything up to LARGE_PACKET_MAX will see benefits (though
> admittedly even 4 bytes per 8K is not much).
> 
> I don't think it's worth the complexity of reading 8 times, but just
> using a buffer size of LARGE_PACKET_MAX-4 would be the most efficient.
> 
> I doubt it matters _that much_ in practice, but any time I see a magic
> number I have to wonder at the "why". At least basing it on
> LARGE_PACKET_MAX has some basis, whereas 8K is largely just made-up. :)

Sounds good. I will use LARGE_PACKET_MAX-4 !

> 
>>> We do sometimes do "ret |= something()" but that is in cases where
>>> "ret" is zero for success, and non-zero (usually -1) otherwise. Perhaps
>>> your function's error-reporting is inverted from our usual style?
>> 
>> I thought it makes the code easier to read and the filter doesn't care
>> at what point the error happens anyways. The filter either succeeds
>> or fails. What style would you suggest?
> 
> I think that's orthogonal. I just mean that using zero for success puts
> you in our usual style, and then accumulating errors can be done with
> "|=".

Ah. I guess I was misguided by the way errors are currently handled
in `apply_filter` (success = 1; failure = 0):
https://github.com/git/git/blob/8c6d1f9807c67532e7fb545a944b064faff0f70b/convert.c#L437-L479

I wouldn't like if the different filter protocols would use different
error exit codes. Would it be OK to adjust the existing `apply_filter`
function in a cleanup patch?


> I didn't look carefully at whether the accumulating style you're using
> makes sense or not. But something like:
> 
>>>> +		ret &= write_in_full(out, &header, sizeof(header)) == sizeof(header);
>>>> +		ret &= write_in_full(out, src, bytes_to_write) == bytes_to_write;
> 
> does mean that we call the second write() even if the first one failed.
> That's a waste of time (albeit a minor one), but it also means you could
> potentially cover up the value of "errno" from the first one (though in
> practice I'd expect the second one to fail for the same reason).

Oh. You're right. For some reason I thought the second operator would
never be evaluated if the first operator is 0. Apparently that is not
the case for bit-wise & ... only for logical & ... thanks for the lesson!

- Lars