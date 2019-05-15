Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 30F891F461
	for <e@80x24.org>; Wed, 15 May 2019 07:13:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725933AbfEOHNU (ORCPT <rfc822;e@80x24.org>);
        Wed, 15 May 2019 03:13:20 -0400
Received: from smtp-out-3.talktalk.net ([62.24.135.67]:41739 "EHLO
        smtp-out-3.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725902AbfEOHNT (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 May 2019 03:13:19 -0400
Received: from [192.168.1.22] ([92.1.197.142])
        by smtp.talktalk.net with SMTP
        id Qo6IhxGmKdraxQo6Ih00Ii; Wed, 15 May 2019 08:13:18 +0100
X-Originating-IP: [92.1.197.142]
X-Spam: 0
X-OAuthority: v=2.3 cv=QfUYQfTv c=1 sm=1 tr=0 a=gH7h/AuSNjzKVpz8AWYPeg==:117
 a=gH7h/AuSNjzKVpz8AWYPeg==:17 a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19
 a=IkcTkHD0fZMA:10 a=xtxXYLxNAAAA:8 a=kspQJiOlhAF2Xo9PEWgA:9 a=QEXdDO2ut3YA:10
 a=xts0dhWdiJbonKbuqhAr:22
Subject: Re: Missing branches after clone
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Duy Nguyen <pclouds@gmail.com>,
        Ulrich Windl <Ulrich.Windl@rz.uni-regensburg.de>,
        Git Mailing List <git@vger.kernel.org>
References: <5CDA8D37020000A100031319@gwsmtp.uni-regensburg.de>
 <CACsJy8AX9Wp3W=d1=ozF9nZXGE1muooMf7fKCtdOOi1g8QRmig@mail.gmail.com>
 <0c9ec78a-9245-e1df-7ec6-a5d77d1a5261@iee.org>
 <xmqq5zqc8ozn.fsf@gitster-ct.c.googlers.com>
From:   Philip Oakley <philipoakley@iee.org>
Message-ID: <a05fb45a-69d7-a12b-e76c-f11e985f4a65@iee.org>
Date:   Wed, 15 May 2019 08:13:19 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <xmqq5zqc8ozn.fsf@gitster-ct.c.googlers.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-GB
X-CMAE-Envelope: MS4wfOC0bQe6sxOk+oQnsOekeR8oEnegWeZPpJW3VfI3WZ+KhGQjVYOO6LBeOMRwj5r5F4V2PGrDxkIEZNyIf8E2FgXuP6NLmG0v8/IG/4FKZ/VdnrGGGidu
 Mj3cDD76yL3u0abxNhPxIIGyS7CDGNQfUzdnsgzWl4OCf710HkQd6gf+W1Q4HL1nwjMDPRIJTpMrXX3Ign5epRNxECfEJxoWs8COOpreFyejF/BnVnQV8r+J
 pEdH4Nz6PXNEksfVNEHPrLT6NkTvG4WiOZCdQkHwAE0=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 15/05/2019 02:50, Junio C Hamano wrote:
> Philip Oakley <philipoakley@iee.org> writes:
>
>> It is a 'branch which tracks a remote', and it is has the 'last time I
>> looked' state of the branch that is on the remote server, which may
>> have, by now, advanced or changed.
> Yup, I thought we long time ago decided to discourage use of "remote
> branch(es)" in our documentation to help unconfuse users and stick
> to the term "a remote-tracking branch" (the "remote-tracking" is a
> hyphenated one word)?
I believe we are consistent in using the 'rtb' phrase (I've not checked 
the hyphen), but for those uninitiated in the duplicitous ways of 
distributed versioning systems, they can still think that the phrase is 
simply saying that local branch A will be updated to the state of remote 
branch B when do a fetch from that remote.

I.e. they think tracking is a direct linkage via fetch, rather than an 
indirect linkage via a local rtb (a concept that has not yet entered 
their head, and if if they are aware of the possibility, they haven't 
joined the dots). Hence my spelling it out the 'French' way.
>> So you need to have the three distinct views in your head of 'My
>> branch, held locally', 'my copy of Their branch, from when I last
>> looked', and 'Their branch, on a remote server, in a state I haven't
>> seen recently'.
> Yup.  FWIW, when I need to refer to the last one, I'd always say "a
> branch at the remote" to avoid the confusing term "remote branch".
>
yes, it's tricky. I've shot my foot off a number of times.
Thanks
Philip
