Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 462711F453
	for <e@80x24.org>; Sat, 27 Oct 2018 01:45:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726296AbeJ0KYt (ORCPT <rfc822;e@80x24.org>);
        Sat, 27 Oct 2018 06:24:49 -0400
Received: from avasout03.plus.net ([84.93.230.244]:54789 "EHLO
        avasout03.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725828AbeJ0KYt (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 27 Oct 2018 06:24:49 -0400
Received: from [10.0.2.15] ([80.189.70.193])
        by smtp with ESMTPA
        id GDfNgYdh6fmQQGDfOgjE3i; Sat, 27 Oct 2018 02:45:30 +0100
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.3 cv=Acuf4UfG c=1 sm=1 tr=0
 a=wSR+GDtF+fsrIzE5OYgxVg==:117 a=wSR+GDtF+fsrIzE5OYgxVg==:17
 a=IkcTkHD0fZMA:10 a=EBOSESyhAAAA:8 a=cGtvwGrD9bXoUPXvagQA:9 a=QEXdDO2ut3YA:10
 a=yJM6EZoI5SlJf8ks9Ge_:22
X-AUTH: ramsayjones@:2500
Subject: Re: [PATCH v3 3/3] commit-slab: missing definitions and forward
 declarations (hdr-check)
To:     Carlo Arenas <carenas@gmail.com>
Cc:     git@vger.kernel.org, pclouds@gmail.com, peff@peff.net,
        chriscool@tuxfamily.org, l.s.r@web.de
References: <20181025110427.13655-1-carenas@gmail.com>
 <20181025110427.13655-4-carenas@gmail.com>
 <b6fe7e58-5b3f-f139-be8d-210526a26767@ramsayjones.plus.com>
 <d5b54ed8-689b-6f12-5888-fb598db8f083@ramsayjones.plus.com>
 <CAPUEspiFDX8280qezkQ0WvJ5-9cp2eG3p+zX4F6HZNgLBACoHw@mail.gmail.com>
From:   Ramsay Jones <ramsay@ramsayjones.plus.com>
Message-ID: <de120e07-0b26-295e-3128-e8b3891577e2@ramsayjones.plus.com>
Date:   Sat, 27 Oct 2018 02:45:28 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <CAPUEspiFDX8280qezkQ0WvJ5-9cp2eG3p+zX4F6HZNgLBACoHw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfMvUiBee38Vb+CcgbOpzRJDQ1Ngk86Oyc83vbO5Hz+mqLYv5sV5ajbvj6I6TGmXq9SgjuHQTyKv1+f2iy9BAs5DT/ZY0scFHSBmNXdgJvP88IRap7ALA
 l7cDU+Lj/Yk1dA8K2pykG6Fa9AF60MCjcaCPVp1t4iPjr8XaaBCadnsE
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 26/10/2018 04:15, Carlo Arenas wrote:
> On Thu, Oct 25, 2018 at 2:09 PM Ramsay Jones
> <ramsay@ramsayjones.plus.com> wrote:
>> Yes, this will 'fix' the 'commit-reach.h' header (not surprising),
>> but I prefer my patch. ;-)
> 
> I apologize, I joined the list recently and so might had missed a
> reroll; the merged series in pu doesn't seem to include it and the
> error was around the code I changed, so wanted to make sure it would
> be addressed sooner rather than later.
> 
> eitherway, I agree with you my patch (or something better) would fit
> better in your topic branch than on mine and while I haven't seen your
> patch I am sure is most likely better.

Hmm, I don't know about that!

Since the original series has progressed, any additions will now
result in a new set of patches, rather than a re-roll.

The original 'commit-reach.h' patch was not applied as part of the
last series, since the commit message was felt to be lacking (well,
it was actually non-existent!). ;-)

I have been making some additional changes to the 'hdr-check' target
in the Makefile, but I haven't quite finished. I will send the other
(non-Makefile) changes soon. [These patches will make the 'master'
and 'next' branches 'hdr-check' clean for me].

ATB,
Ramsay Jones
