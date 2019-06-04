Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE,T_HK_NAME_DR shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 350FF1F462
	for <e@80x24.org>; Tue,  4 Jun 2019 17:22:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726490AbfFDRWq (ORCPT <rfc822;e@80x24.org>);
        Tue, 4 Jun 2019 13:22:46 -0400
Received: from vwp8955.webpack.hosteurope.de ([176.28.35.119]:60438 "EHLO
        vwp8955.webpack.hosteurope.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726092AbfFDRWq (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 4 Jun 2019 13:22:46 -0400
Received: from [2001:16b8:5c3d:e200:60e9:7113:1875:fbb2]; authenticated
        by vwp8955.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1hYD91-0006Bg-Kg; Tue, 04 Jun 2019 19:22:43 +0200
Subject: Re: [PATCH] make slash-rules more readable
To:     git@vger.kernel.org
References: <20190531074426.6810-1-admin@in-ici.net>
 <0c9f79f3-b43b-5f32-d217-ff92531c5da7@iee.org>
From:   "Dr. Adam Nielsen" <admin@in-ici.net>
Message-ID: <8984a44f-b80c-9d04-3094-c17bb4e17d20@in-ici.net>
Date:   Tue, 4 Jun 2019 19:22:43 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <0c9f79f3-b43b-5f32-d217-ff92531c5da7@iee.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-bounce-key: webpack.hosteurope.de;admin@in-ici.net;1559668965;626dc056;
X-HE-SMSGID: 1hYD91-0006Bg-Kg
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Philip

On 04.06.19 14:34, Philip Oakley wrote:
> I think the rules end up being difficult because we describe them from a 
> coders implementation viewpoint, rather than a users descriptive 
> viewpoint. Thus we avoided things like the difficult to code slashes in 
> the front/middle, and we get caught on the equivalent of neither/nor 
> phrases, which can even be difficult for native English speakers.
> 
> Later on there is a recursively/respectively issue (latter not 
> explicitly mentioned).  There is also an "Except if" not-a-proper 
> sentence. (mentioned off-line)
> 
> After sleeping on it, I came up with:
> 
>     The slash '/' is used as the directory separator. Separators may
>     occur at the beginning, middle or end of the .gitignore search pattern.
> 
>     If there is a separator at the beginning or middle (or both) of the
>     pattern, then the pattern is relative to the directory level of the
>     particular .gitignore file itself. Otherwise the pattern may also
>     match at any level below the .gitignore level.
> 
>     If there is a separator at the end of the pattern then the pattern
>     will only match directories, otherwise the pattern can match both
>     files and directories.
> 
>     Examples text..
> 
>     The special '*' ...
> 
>     The special '**' ...
> 

I am really happy about this improvement (or rather this new creation). 
In my opinion it is really easy to understand now, and it solves a ton 
of other issues we had with the preceding proposals.

I will create a new patch.

All the best,
Adam

