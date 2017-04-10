Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D1CBB20960
	for <e@80x24.org>; Mon, 10 Apr 2017 20:54:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752746AbdDJUyg (ORCPT <rfc822;e@80x24.org>);
        Mon, 10 Apr 2017 16:54:36 -0400
Received: from mout.web.de ([217.72.192.78]:61655 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752155AbdDJUyf (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Apr 2017 16:54:35 -0400
Received: from macce.local ([79.223.125.21]) by smtp.web.de (mrweb102
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0LilNJ-1cMz7x3QDN-00cvep; Mon, 10
 Apr 2017 22:54:21 +0200
Subject: Re: [PATCH v3 4/4] convert: add "status=delayed" to filter process
 protocol
To:     Lars Schneider <larsxschneider@gmail.com>, git@vger.kernel.org
References: <20170409191107.20547-1-larsxschneider@gmail.com>
 <20170409191107.20547-5-larsxschneider@gmail.com>
Cc:     gitster@pobox.com, peff@peff.net, e@80x24.org, ttaylorr@github.com
From:   =?UTF-8?Q?Torsten_B=c3=b6gershausen?= <tboegi@web.de>
Message-ID: <a7fd3bef-49b2-0b0a-8ca4-89e41a402661@web.de>
Date:   Mon, 10 Apr 2017 22:54:19 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.11; rv:45.0)
 Gecko/20100101 Thunderbird/45.8.0
MIME-Version: 1.0
In-Reply-To: <20170409191107.20547-5-larsxschneider@gmail.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K0:ahbfmaUzl+G3uTkSabJUv4OBIqZeaZEZJxw6SsHA2F5sFXltgDT
 0J7Iy+ClehTD+aguPDDtT3EtZKh1VBjs8qibAPeJ8RlwDuTyk/ISPfWM2gPocdIk+P1qPAQ
 K+mDB/3LxkxWyhLwyx27SAwRdzIJrgyGu2ZDKHDe1qVSefjBic0+2YSt9dKW8R9Cad319Mr
 8LpdScXQI/iorbdxqxF5A==
X-UI-Out-Filterresults: notjunk:1;V01:K0:pceBZ27907w=:8yi6I8WHa9jOUDIZ7/qLgz
 tylt2V40kdUuSvuGB2ZgFK2iYHLbshLBOl8CDtaTmFs9xYHk37SROEH1CTwxDOciQXsPUUypF
 IJbJuPs2JolAjEBA1hpCXaGunq9xuWDNFMUdS9jU9jkL9Khl6h+Q8YlROvBYwP2tpF6txi3Za
 0R4unaN+++AIywiLUojWMSI9vVky5gmsfEI7w/6QUWkvr8+QmnLx/gTzfKSxxqHs7Fiyf4RpF
 RbpdCUibXh4jHKEn90OLs9njWsaRqUsUfruEyxVpOOtxhM6tGl+8qgjk30tqOtg5Ks5/RU3Dj
 CBYBYvl00Icb4KtOkqBgYIdzPaXImPdurw1znflz1i2Ux/PeOI/H2lx3X/iYt2LP6zie/LywR
 dqjto7zPT1rjBIrPqHfrKfUgpkEo7tbrKwM8sNidEIb5A1Ynca/WfRGRem7/rMireoWTQse9l
 INWqFOXhiR0AzKX0excfqco/V7rJdvbCaizrFOygr7ei0LO1civwkXOzoubgp1rboPNwbLUDl
 L0O7DPn5aRld+j+VZt3OhjRU++mp+X/Y6ZG7bTcuOrs7eScN9McTUtJ3C4HslCnlEpp9gc/uw
 pcvxIuBIW/QSF+/S6hykaWxZype1JQeBxpZ6O57iG34wx2BFnyakMxAa42sEdS4ZQYaB7EuM9
 RZhS++D3xndUekzf4ahOgv5kdCtGyQEvCUAX6ErVq0yTlGctpU9xrht/bJ+11K19j/FgIbblf
 wmlgjF7JInU/VuQxyNw4u2xlyVepVMqaYMmjF4qi97lzYfwW/jqysWcDPfLwjPyjhGlk1F3vh
 s+kjZ6d
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2017-04-09 21:11, Lars Schneider wrote:
[]
> +------------------------
> +packet:          git> command=smudge
> +packet:          git> pathname=path/testfile.dat
> +packet:          git> delay-able=1
> +packet:          git> 0000
> +packet:          git> CONTENT
> +packet:          git> 0000
> +packet:          git< status=delayed
> +packet:          git< 0000
> +packet:          git> delay-id=1
> +packet:          git> 0000
> +packet:          git< status=success
> +packet:          git< 0000

(not sure if this was mentioned before)
If a filter uses the delayed feature, I would read it as
a response from the filter in the style:
"Hallo Git, I need some time to process it, but as I have
CPU capacity available, please send another blob,
so I can chew them in parallel."

Can we save one round trip ?

packet:          git> command=smudge
packet:          git> pathname=path/testfile.dat
packet:          git> delay-id=1
packet:          git> 0000
packet:          git> CONTENT
packet:          git> 0000
packet:          git< status=delayed # this means: Git, please feed more
packet:          git> 0000

# Git feeds the next blob.
# This may be repeated some rounds.
# (We may want to restrict the number of rounds for Git, see below)
# After these some rounds, the filter needs to signal:
# no more fresh blobs please, collect some data and I can free memory
# and after that I am able to get a fresh blob.
packet:          git> command=smudge
packet:          git> pathname=path/testfile.dat
packet:          git> delay-id=2
packet:          git> 0000
packet:          git> CONTENT
packet:          git> 0000
packet:          git< status=pleaseWait
packet:          git> 0000

# Now Git needs to ask for ready blobs.

> +------------------------
> +
> +If the filter supports the "delay" capability then it must support the
> +"list_available_blobs" command. If Git sends this command, then the
> +filter is expected to return a list of "delay_ids" of blobs that are
> +available. The list must be terminated with a flush packet followed
> +by a "success" status that is also terminated with a flush packet. If
> +no blobs for the delayed paths are available, yet, then the filter is
> +expected to block the response until at least one blob becomes
> +available. The filter can tell Git that it has no more delayed blobs
> +by sending an empty list.
> +------------------------
> +packet:          git> command=list_available_blobs
> +packet:          git> 0000
> +packet:          git< 7

Is the "7" the same as the "delay-id=1" from above?
It may be easier to understand, even if it costs some bytes, to answer instead
packet:          git< delay-id=1
(And at this point, may I suggest to change "delay-id" into "request-id=1" ?

> +packet:          git< 13

Same question here: is this the delay-id ?

> +packet:          git< 0000
> +packet:          git< status=success
> +packet:          git< 0000
> +------------------------
> +
> +After Git received the "delay_ids", it will request the corresponding
> +blobs again. These requests contain a "delay-id" and an empty content
> +section. The filter is expected to respond with the smudged content
> +in the usual way as explained above.
> +------------------------
> +packet:          git> command=smudge
> +packet:          git> pathname=test-delay10.a
> +packet:          git> delay-id=0

Minor question: Where does the "id=0" come from ?

> +packet:          git> 0000
> +packet:          git> 0000  # empty content!
> +packet:          git< status=success
> +packet:          git< 0000
> +packet:          git< SMUDGED_CONTENT
> +packet:          git< 0000
> +packet:          git< 0000

OK, good.

The quest is: what happens next ?

2 things, kind of in parallel, but we need to prioritize and serialize:
- Send the next blob
- Fetch ready blobs
- And of course: ask for more ready blobs.
(it looks as if Peff and Jakub had useful comments already,
  so I can stop here?)


In general, Git should not have a unlimited number of blobs outstanding,
as memory constraints may apply.
There may be a config variable for the number of outstanding blobs,
(similar to the window size in other protocols) and a variable
for the number of "send bytes in outstanding blobs"
(similar to window size (again!) in e.g TCP)

The number of outstanding blobs is may be less important, and it is more
important to monitor the number of bytes we keep in memory in some way.

Something like "we set a limit to 500K of out standng data", once we are
above the limit, don't send any new blobs.



(No, I didn't look at the code at all, this protocol discussion
is much more interesting)


