Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 099951F576
	for <e@80x24.org>; Sun,  4 Mar 2018 10:17:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752646AbeCDKRP (ORCPT <rfc822;e@80x24.org>);
        Sun, 4 Mar 2018 05:17:15 -0500
Received: from mout.web.de ([212.227.17.11]:54291 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751844AbeCDKRN (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 4 Mar 2018 05:17:13 -0500
Received: from macce.local ([195.198.252.176]) by smtp.web.de (mrweb103
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0MXYWA-1fExGK2niQ-00WV3D; Sun, 04
 Mar 2018 11:16:55 +0100
Subject: Re: [PATCH v7 0/7] convert: add support for different encodings
To:     Jeff King <peff@peff.net>
Cc:     Lars Schneider <larsxschneider@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Lars Schneider <lars.schneider@autodesk.com>,
        git <git@vger.kernel.org>, Johannes Sixt <j6t@kdbg.org>,
        Eric Sunshine <sunshine@sunshineco.com>,
        ramsay@ramsayjones.plus.com, Johannes.Schindelin@gmx.de
References: <19EDC192-0D83-4762-AC6A-81F7D693475A@gmail.com>
 <xmqqbmgfvf2y.fsf@gitster-ct.c.googlers.com>
 <xmqq7er3tqjq.fsf@gitster-ct.c.googlers.com>
 <FDF4DEB8-E71A-4BFC-9437-678C8F65BBDC@gmail.com>
 <20180226014445.GB8677@sigill.intra.peff.net> <20180226173533.GA7877@tor.lan>
 <20180226204635.GB12598@sigill.intra.peff.net>
 <20180227210517.GA17555@tor.lan>
 <20180227212537.GA6899@sigill.intra.peff.net>
 <20180228082005.GA16857@tor.lan>
 <20180228132116.GA32272@sigill.intra.peff.net>
From:   =?UTF-8?Q?Torsten_B=c3=b6gershausen?= <tboegi@web.de>
Message-ID: <567f22b7-4ac5-573e-4b41-d6dbba0d7610@web.de>
Date:   Sun, 4 Mar 2018 11:16:52 +0100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.11; rv:52.0)
 Gecko/20100101 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180228132116.GA32272@sigill.intra.peff.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K0:yUpAc8Cmiq3Qn2nzp4bsCJ/n5KmDJ6Gyqx/UyeRvUT1J7NWvEto
 Uo2NDZl7H0o62M1CqgouvHFXu45stl9cekNUHb33J8LrX3CyT7dztOPhB79azQK54DsF25N
 GuaOgv+yTNqshtJ8QelSltyBiRzqpx9V4143vXBWX0DaF8HXbk0P4L/CN6dh5jQKMwmjoWj
 BzO3Zx7AanqIQb7F49Rzg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:qA0spFFa/hU=:LUbqsbXsT5CaBSXld/kQR+
 Vv1lmdTIVTS+8fKPz9cRIYPbKRP09aerPlnkm7DZFQN/uknYkZwyiGDl4xuXxrgC70wpO5T9c
 L9iohngNba8Nf2BoogZDwYGZZSIfcq3raF2OpQFf27qcF37GZuah7gzMN/8laoCDCrCamyWN5
 L+lczGOOntP4Cf3B3+Kk4kK0iLHKOqd8TkiqibKUqkIi65LTzGwhH6ti8WK0pmZQ0k8SxqvIM
 DZ55KP9XI33CjzEQgsg3Bb8TkBivznio6UrWs8BycS8QLjJEM4DsAx5IVM8Vu/x5x1285W0fO
 vY+Sk+l964pfJULCpNMEy9KoJLttHzcINHRKQA/JHsgQ86JJum7GzeRLphqEkX8EBhXSG8xFx
 rb5CcLDfKGdP07LdIrDHrcstPbfA+XBAnUgiefSxR8je6wvoash+EsjSHYGKl9gWycIkNzFQY
 n0DAutL67iBYHfO7eyenS/YRPRcOSnmDcUtbLfRRZB8xjT8YcBigeqT32qBwPSGhnU/jKbwT4
 yMAJ0xKMeQvKm7j50b427wzja837kXGMj6BW3BM2O/eIEESZijGD9dVDZrDISpNOsx3sr1suv
 oJMbDfgotDmErK5Wr9wrxBrinhkh1VSy5sLAM0IxhzQJbuY1f77EntDg25obfCgdFtmXNnIry
 tb2A+wOAdcw2+TGmH2F1nhpXnmsptVBj0rPP58nAkM7/f8ASLS0dgk/CIXCNIYCcadWl4c7Wp
 eyFtaYJ6yZlF3gpF4jVR1zFEUin/wnRvKmcIlHC2rDxicdmEUGSTVxxsIxxvtnt8wg2H0siop
 uIny0iX0WHZ3E1cJeD2VvdbJ4KtHjclh3kV6+iAEYs5KHRzDzA=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2018-02-28 14:21, Jeff King wrote:
> On Wed, Feb 28, 2018 at 09:20:05AM +0100, Torsten Bögershausen wrote:
> 
>>>   2. auto-detect utf-16 (your patch)
>>>      - Just Works for existing repositories storing utf-16
>>>
>>>      - carries some risk of kicking in when people would like it not to
>>>        (e.g., when they really do want a binary patch that can be
>>>        applied).
>>
>> The binary patch is still supported, but that detail may need some more explanation
>> in the commit message. Please see  t4066-diff-encoding.sh
> 
> Yeah, but if you don't have binary-patches enabled we'd generate a bogus
> patch. Which, granted, without that you wouldn't be able to apply the
> patch either. But somehow it feels funny to me to generate something
> that _looks_ like a patch but you can't actually apply.
> 
> I also think we'd want a plan for this to be used consistently in other
> diff-like tools. E.g., "git blame" uses textconv for the starting file
> content, and it would be nice for this to kick in then, too. Ditto for
> things like grep, pickaxe, etc.
> 
> I have some patches that reuse some of the textconv infrastructure for
> this, which should mostly make it "just work" everywhere. They need a
> little more polishing before I post them, but you can take a look at:
> 
>   https://github.com/peff/git.git jk/textconv-utf16
> 
> if you want.
> 
> -Peff
> 

Thanks for your work (I actually found some time to take look)

I am looking at the code to put 2 or 3 things on top of it:
- test case(s)
- documentation
- teach diff to add a line "b is converted to UTF-8 from UTF-16"
- teach apply to reads & understands the encoding line and throws
  in a "reencode_string_len() like your patch does

This would keep "git diff | git apply" happy.
All in all the changes do not look too invasive, at least from my point of view.



