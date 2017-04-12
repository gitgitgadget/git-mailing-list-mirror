Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EEEDC20970
	for <e@80x24.org>; Wed, 12 Apr 2017 04:37:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750908AbdDLEhf (ORCPT <rfc822;e@80x24.org>);
        Wed, 12 Apr 2017 00:37:35 -0400
Received: from mout.web.de ([212.227.15.4]:54332 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750731AbdDLEhf (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Apr 2017 00:37:35 -0400
Received: from macce.local ([79.223.105.252]) by smtp.web.de (mrweb002
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0MIeGu-1cvx6Q3Ti4-002JK5; Wed, 12
 Apr 2017 06:37:15 +0200
From:   =?UTF-8?Q?Torsten_B=c3=b6gershausen?= <tboegi@web.de>
Subject: Re: [PATCH v3 4/4] convert: add "status=delayed" to filter process
 protocol
To:     Lars Schneider <larsxschneider@gmail.com>
References: <20170409191107.20547-1-larsxschneider@gmail.com>
 <20170409191107.20547-5-larsxschneider@gmail.com>
 <a7fd3bef-49b2-0b0a-8ca4-89e41a402661@web.de>
 <388C3F2A-AC77-499F-9C74-216F5DC00FD8@gmail.com>
Cc:     git@vger.kernel.org, gitster@pobox.com, peff@peff.net, e@80x24.org,
        ttaylorr@github.com
Message-ID: <106c2be9-c558-edcc-2d97-5091c15010d1@web.de>
Date:   Wed, 12 Apr 2017 06:37:11 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.11; rv:45.0)
 Gecko/20100101 Thunderbird/45.8.0
MIME-Version: 1.0
In-Reply-To: <388C3F2A-AC77-499F-9C74-216F5DC00FD8@gmail.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K0:Qcbm8NEvilg28ja1fxyZRSVyW3CWZKl+2Fq6mzWCkAtlFUIeut5
 hht7P1ZV3rEYYCd0mVx/EN7at1o6B6TEJVsmkaicH48yOXNa8uRrGX2LPs1PuRsKsz5rBJt
 t8CRcOnNrLOoJRuSz5KVqZiWeX5ioBc6Kq0H5pcpT1tJ18rsxZpQj1sub2/tz+yb+dgHnOP
 51awmBTN9uU7ufciESQcg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:KKKPRBV0auI=:3NY0Hdj8WZp8d/NNiDHKKM
 OS1EZsTSmnda/w0PTkvL1d8VLOEmu8XCtHurbmH7eT0ZJ1LwLZggd7XCWIWVHT0HFZ62yPjDD
 f6QeI2KN29LKG/kG7ZCjpEpZdXkAvxzjI9x7W4J/eIJCt4Xyq2hrP79PCNdIN9Y+MbgkZxXZv
 WFm/9YZo/aeq5wsXjqrGydc+3OwSp5/0kx/nDpSSUtL5NCX5i1vY3hiV2/k5P3PRnkXLdtgav
 QlcgrqraBPr1UOAZ0mIoGMDOOHc64vcowyR7KUZRXrMLQ3i4pGMa8v0/SNPry2hKbZyr5doPE
 xAkgqvThfu+BSF5nMOjXI18VJLYdHIsVkHyvXqCaWg14Cjq2adKW7FpNJjL+5EKVTsvCCoTfK
 zSobrgh3/98fNoB3L9yjVKqWGhAkzKJO6iQ6dbXqhOyYP/zb1QbEOLQsirSmgpqQ18ipYHdYq
 PGpPARmAFw/4SmUHxVm5gbal50LZ9pcIKIjc3QbYrWQTAcuN09fPKB/w7pCTPz4KokZDiXYZh
 HFiAhjdaKdmMPshP6Io9xwxj7MmLOEf6OX6QgjsH/Wuo5pmIfcp5A+EFrnCD42HRDYEA919uk
 Dvh1bdeJmi2kKCjuX66xfbI3bDFXBUpmr0/pky/umaYSAaDTuAKDHPteUwoNcEWBZkHBqkuwO
 pjzPwIdcUWtL+FiKp98ycRdUprLheL85JlRWZOFPEzh6ko+EJE8bWis3MmGujDnqIzIDG+eSK
 L3NJ8pksjajVFfsGWfbjkkPi0ucLS1u8fuM4m/Tg9JM6o20Tf5nt+784eZLqzkkROgF/q1MNX
 vrvxzVu
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2017-04-11 21:50, Lars Schneider wrote:

[]
>> packet:          git> command=smudge
>> packet:          git> pathname=path/testfile.dat
>> packet:          git> delay-id=1
>> packet:          git> 0000
>> packet:          git> CONTENT
>> packet:          git> 0000
>> packet:          git< status=delayed # this means: Git, please feed more
>> packet:          git> 0000
> Actually, this is how I implemented it first.
> 
> However, I didn't like that because we associate a
> pathname with a delay-id. If the filter does not
> delay the item then we associate a different
> pathname with the same delay-id in the next request. 
> Therefore I think it is better to present the delay-id 
> *only* to the filter if the item is actually delayed.
> 
> I would be surprised if the extra round trip does impact
> the performance in any meaningful way.
> 

2 spontanous remarks:

- Git can simply use a counter which is incremented by each blob
  that is send to the filter.
  Regardless what the filter answers (delayed or not), simply increment a
  counter. (or is this too simple and I miss something?)

- I was thinking that the filter code is written as either "never delay" or
  "always delay".
  "Never delay" is the existing code.
  What is your idea, when should a filter respond with delayed ?
  My thinking was "always", silently assuming the more than one core can be
  used, so that blobs can be filtered in parallel.

>We could do this but I think this would only complicate
>the protocol. I expect the filter to spool results to the
>disk or something.
  Spooling things to disk was not part of my picture, to be honest.
  This means additional execution time when a SSD is used, the chips
  are more worn out...
  There may be situations, where this is OK for some users (but not for others)
  How can we prevent Git from (over-) flooding the filter?
  The protocol response from the filter would be just "delayed", and the filter
  would block Git, right ?
  But, in any case, it would still be nice if Git would collect converted blobs
  from the filter, to free resource here.
  This is more like the "streaming model", but on a higher level:
  Send 4 blobs to the filter, collect the ready one, send the 5th blob to
  the filter, collect the ready one, send the 6th blob to the filter, collect
  ready one....


(Back to the roots)
Which criteria do you have in mind: When should a filter process the blob
and return it immediately, and when would it respond "delayed" ?




