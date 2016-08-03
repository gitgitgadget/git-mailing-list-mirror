Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 36BE61F40E
	for <e@80x24.org>; Wed,  3 Aug 2016 22:37:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932301AbcHCWhQ (ORCPT <rfc822;e@80x24.org>);
	Wed, 3 Aug 2016 18:37:16 -0400
Received: from alum-mailsec-scanner-4.mit.edu ([18.7.68.15]:51517 "EHLO
	alum-mailsec-scanner-4.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752710AbcHCWhO (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 3 Aug 2016 18:37:14 -0400
X-AuditID: 1207440f-e2bff70000000955-4c-57a27209c720
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by  (Symantec Messaging Gateway) with SMTP id 70.16.02389.90272A75; Wed,  3 Aug 2016 18:36:59 -0400 (EDT)
Received: from [192.168.69.130] (p57907C5F.dip0.t-ipconnect.de [87.144.124.95])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id u73MatGY025513
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
	Wed, 3 Aug 2016 18:36:56 -0400
Subject: Re: [PATCH 8/8] diff: improve positioning of add/delete blocks in
 diffs
To:	Jacob Keller <jacob.keller@gmail.com>
References: <cover.1470259583.git.mhagger@alum.mit.edu>
 <7b0680ed7a10fc13acd8d7816a75ed05a5f9e28c.1470259583.git.mhagger@alum.mit.edu>
 <CA+P7+xo6q0pveVQdt1mynfsWq75DzBXsbPcgVYdd5s8rpO+97A@mail.gmail.com>
Cc:	Git mailing list <git@vger.kernel.org>,
	Stefan Beller <sbeller@google.com>,
	Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>,
	=?UTF-8?Q?Jakub_Nar=c4=99bski?= <jnareb@gmail.com>
From:	Michael Haggerty <mhagger@alum.mit.edu>
Message-ID: <f7f35993-39a8-b788-d2a7-d030ac442b9b@alum.mit.edu>
Date:	Thu, 4 Aug 2016 00:36:54 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Icedove/45.1.0
MIME-Version: 1.0
In-Reply-To: <CA+P7+xo6q0pveVQdt1mynfsWq75DzBXsbPcgVYdd5s8rpO+97A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpmleLIzCtJLcpLzFFi42IRYndR1OUuWhRusPYBm0XXlW4mi4beK8wW
	uxf3M1usuDqH2eJHSw+zxebN7SwObB47Z91l91iwqdTjWe8eRo+Ll5Q9Pm+SC2CN4rJJSc3J
	LEst0rdL4MrY1N/CUjBTpOL63ma2BsZuvi5GTg4JAROJlqvLmLoYuTiEBLYySnzuvATlnGOS
	mNlwgA2kSlggSGL3pv2MILaIgKbEvuc97BBF5xklLv16D9bBLHCPUaLxyjt2kCo2AV2JRT3N
	TCA2r4C9xLrL91hBbBYBFYklz6+ATRUVCJHYdrOBDaJGUOLkzCcsIDanQKDEkwerwLYxC6hL
	/Jl3iRnClpfY/nYO8wRG/llIWmYhKZuFpGwBI/MqRrnEnNJc3dzEzJzi1GTd4uTEvLzUIl0T
	vdzMEr3UlNJNjJCw5t/B2LVe5hCjAAejEg/vBslF4UKsiWXFlbmHGCU5mJREeXNSgUJ8Sfkp
	lRmJxRnxRaU5qcWHGCU4mJVEeJnygXK8KYmVValF+TApaQ4WJXFe9SXqfkIC6YklqdmpqQWp
	RTBZGQ4OJQneRQVAjYJFqempFWmZOSUIaSYOTpDhPEDDX4PU8BYXJOYWZ6ZD5E8xKkqJ8x4B
	2SoAksgozYPrhaWdV4ziQK8I8+4FaecBpiy47ldAg5mABp8wWAAyuCQRISXVwLijedPKrhVr
	Ms25fK8/WNL5WbSusM7u33K1E6HdYkkHfCaKlN80k/oQGufqtljr0RaO7wVL3hjvk8nudl7A
	eLDu3e3omluNE1pazS/LGDcfuWtoscb9Nv+5mW1cR31Elj5YZ/06s4tR/nv1/suOYQ0OpxlK
	JftMpWQtc/n+G35YWs27N/xmrhJLcUaioRZzUXEiAJasKw4WAwAA
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On 08/04/2016 12:29 AM, Jacob Keller wrote:
> On Wed, Aug 3, 2016 at 3:00 PM, Michael Haggerty <mhagger@alum.mit.edu> wrote:
>> +/*
>> + * If a line is indented more than this, get_indent() just returns this value.
>> + * This avoids having to do absurd amounts of work for data that are not
>> + * human-readable text, and also ensures that the output of get_indent fits within
>> + * an int.
>> + */
>> +#define MAX_INDENT 200
>> +
>> +/*
>> + * Return the amount of indentation of the specified line, treating TAB as 8
>> + * columns. Return -1 if line is empty or contains only whitespace. Clamp the
>> + * output value at MAX_INDENT.
>> + */
>> +static int get_indent(xrecord_t *rec)
>> +{
>> +       long i;
>> +       int ret = 0;
>> +
>> +       for (i = 0; i < rec->size; i++) {
>> +               char c = rec->ptr[i];
>> +
>> +               if (!XDL_ISSPACE(c))
>> +                       return ret;
>> +               else if (c == ' ')
>> +                       ret += 1;
>> +               else if (c == '\t')
>> +                       ret += 8 - ret % 8;
>> +               /* ignore other whitespace characters */
>> +
>> +               if (ret >= MAX_INDENT)
>> +                       return MAX_INDENT;
> 
> Should we return -1 here?
> 
>> +       }
>> +       /*
>> +        * We have reached the end of the line without finding any non-space
>> +        * characters; i.e., the whole line consists of trailing spaces, which we
>> +        * are not interested in.
>> +        */
>> +       return -1;
> 
> It seems odd to be that a line with "199" spaces and nothing else will
> return "-1" but a line with 200 spaces and nothing else will return
> 200..? Would it be safe to just return -1 in both cases (if a line is
> all spaces or starts with more than 200 spaces just return -1)?
> 
>> +}
>> +

Thanks for your feedback.

I was implicitly assuming that such lines would have text somewhere
after those 200 spaces (or 25 TABs or whatever). But you're right, the
line could consist only of whitespace. Unfortunately, the only way to
distinguish these two cases is to read the rest of the line, which is
exactly what we *don't* want to do.

But I think it doesn't matter anyway. Such "text" will likely never be
read by a human, so it's not a big deal if the slider position is not
picked perfectly. And remember, this whole saga is just to improve the
aesthetics of the diff. The diff is *correct* (e.g., in the sense of
applicable) regardless of where we position the sliders.

Michael

