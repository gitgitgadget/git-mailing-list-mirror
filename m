Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.9 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 73F1F1FCA5
	for <e@80x24.org>; Thu, 29 Dec 2016 13:54:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752752AbcL2NyL (ORCPT <rfc822;e@80x24.org>);
        Thu, 29 Dec 2016 08:54:11 -0500
Received: from mout.web.de ([212.227.17.12]:63459 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752311AbcL2NyK (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 29 Dec 2016 08:54:10 -0500
Received: from [192.168.178.36] ([79.213.118.247]) by smtp.web.de (mrweb101
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0MVLj0-1c2LEZ3sNi-00YlGM; Thu, 29
 Dec 2016 14:53:58 +0100
Subject: Re: [PATCH] string-list: make compare function compatible with
 qsort(3)
To:     Jeff King <peff@peff.net>
References: <c7bac0b7-c555-162f-7880-0355831cee48@web.de>
 <20161221161220.x3qkcwmuangcdc2l@sigill.intra.peff.net>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <43c3d83e-80f1-64ea-2ba5-7540b8dd4910@web.de>
Date:   Thu, 29 Dec 2016 14:53:54 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.5.1
MIME-Version: 1.0
In-Reply-To: <20161221161220.x3qkcwmuangcdc2l@sigill.intra.peff.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K0:ypQ5DJh23Noab1TwKHz2E6UJWYNVxsLHWyoTRF1sUxU8DRtLiUc
 AP2QAgDDVp0UM8vacafAzmHaqALxeEGFzgtVA8tDNwchxblQbzjITwAb3YWKSP+WNnAg6lH
 6lgf89BFypuhkADlzvFWuZdlf3tALKC9h55xrWVF+hTTj+PrM1G7HNb2VM1rE3qgsFl0qlv
 5KJX3SligmRX5iCtimWzQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:A0/MjraT62c=:XA2sAqd8y1kQPdnQgqSfoy
 BtrcIb2RHr3P6t1qB1xZvf7qc44oNL0O7AheoE2rWUsNWPAxM/1N+xaDj4++UdafZm/NC7tcM
 c6rbQiqU1NRDt9Wff+f1koNdZ/Gdu9vsAc7X0J8jrBywvysyHOQ1JiGgHjiW2B7CD0T51NzeL
 rjH9rmDZvBgM87U80FwiMU/3a4vY5V8nfdFyn0y5ssrdJyLT/qudnt9Q3WCEU9FWD3zBft4jH
 Wd0sdrLe2wX0Ru2hq0mCzB1Z99uSuIX2ESS4dVMzaqJoG2NTSw0Ql365bKzGNNCw72L3RiFT0
 YgvM0E/mv3OMXzCKQx+PDdVFlWiDPSVF+gPYCgN75KMeUxHOWF6PAR9UUO97oAMhqaUUvjkzu
 Uh5UJ2BVlc9Pzv+HnqjRvpm0cnAe7WKi2fDL+T/tb5bdSlueEja2nva03A8eygdh1QdG36kjz
 2S6hFf+TBjaI/O5U3K1P8M+xlsU4DVfoY7a0khB0DIT59XkPszd2h8To/bHU+Mq6YKN12k13+
 CnO7jNNAXpoUQT+sQjRSozIFECo3CAmCeXe02x+JZh9XWgwcX4BiUIHhuwOSlIxr8ztzwYCz2
 6XuSGcxaFPh2PjqXYR82u+H9oEl9AhHfrpFH10TAmyOE/B9QzTYsigdczSANOugNmioUXmEnX
 Y1DH20wkT631GCjBvUq+jDocFV9cSrzlurhyj2aruip/YUEVqpFYHbkS5TJ76x5k3IhGT0al7
 d65V2XTfEUtPIpHnP2QLYoQtb64+N4xdK5XXuj/WCPnUO7F2D7xwTXilDsSZjRMy5QKHXK/Je
 pZ2tN30
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 21.12.2016 um 17:12 schrieb Jeff King:
> On Wed, Dec 21, 2016 at 10:36:41AM +0100, René Scharfe wrote:
>
>> One shortcoming is that the comparison function is restricted to working
>> with the string members of items; util is inaccessible to it.  Another
>> one is that the value of cmp is passed in a global variable to
>> cmp_items(), making string_list_sort() non-reentrant.
>
> I think this approach is OK for string_list, but it doesn't help the
> general case that wants qsort_s() to actually access global data. I
> don't know how common that is in our codebase, though.
>
> So I'm fine with it, but I think we might eventually need to revisit the
> qsort_s() thing anyway.

I have to admit I didn't even consider the possibility that the pattern 
of accessing global variables in qsort(1) compare functions could have 
spread.

And indeed, at least ref-filter.c::compare_refs() and 
worktree.c::compare_worktree() so that as well.  The latter uses 
fspathcmp(), which is OK as ignore_case is only set once when reading 
the config, but the first one looks, well, interesting.  Perhaps a 
single ref filter per program is enough?

Anyway, that's a good enough argument for me for adding that newfangled 
C11 function after all..

Btw.: Found with

   git grep 'QSORT.*;$' |
   sed 's/.* /int /; s/);//' |
   sort -u |
   git grep -Ww -f-

and

   git grep -A1 'QSORT.*,$'

>> Remove the intermediate layer, i.e. cmp_items(), make the comparison
>> functions compatible with qsort(3) and pass them pointers to full items.
>> This allows comparisons to also take the util member into account, and
>> avoids the need to pass the real comparison function to an intermediate
>> function, removing the need for a global function.
>
> I'm not sure if access to the util field is really of any value, after
> looking at it in:
>
>   http://public-inbox.org/git/20161125171546.fa3zpapbjngjcl26@sigill.intra.peff.net/
>
> Though note that if we do take this patch, there are probably one or two
> spots that could switch from QSORT() to string_list_sort().

Yes, but as you noted in that thread there is not much point in doing 
that; the only net win is that we can pass a list as a single pointer 
instead of as base pointer and element count -- the special compare 
function needs to be specified anyway (once), somehow.

René
