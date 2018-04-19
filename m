Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,FAKE_REPLY_C,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 73AAF1F404
	for <e@80x24.org>; Thu, 19 Apr 2018 19:07:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753273AbeDSTHe (ORCPT <rfc822;e@80x24.org>);
        Thu, 19 Apr 2018 15:07:34 -0400
Received: from mout.kundenserver.de ([212.227.17.24]:47357 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753117AbeDSTHd (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 Apr 2018 15:07:33 -0400
Received: from furore ([82.194.150.97]) by mrelayeu.kundenserver.de (mreue104
 [212.227.15.183]) with ESMTPSA (Nemesis) id 0M8hRj-1eEgJA0rvn-00wHqP; Thu, 19
 Apr 2018 21:07:27 +0200
Date:   Thu, 19 Apr 2018 21:07:25 +0200
From:   Florian =?utf-8?Q?Gamb=C3=B6ck?= <mail@floga.de>
To:     SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
Cc:     Git mailing list <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH v2 1/1] completion: load completion file for external
 subcommand
Message-ID: <20180419190725.GA8555@furore>
Mail-Followup-To: SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>,
        Git mailing list <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Stefan Beller <sbeller@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAM0VKj=pDVxfJtUZx7c6uCmPxwQFPBOQYdd7NH=YnVG86iK0Pw@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Provags-ID: V03:K1:DLVT6g7rlFsQLQZIqD8SAl0hSTWABYGWP1Y7ALqthXIKpEu7Kk8
 37o+RhqsaQIMgsUY4MC+mU1nhfnH+0AFkrtR4CqMzEnCUiIMXftBM5XriULj5A8OVSxJITg
 2YHGrwliyUBGW4Lif/bkNa/MW1xLkPTRHXMWtUkL+LpdEctXS4Jl9H2OQ1H32/nBiCTdxhV
 DbMx2tESdpzka56dx7JgA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:9z1wyfZnCcw=:A1mfAiZZ0iCFixXxhiN+ZB
 R9gWmegJgKkO40ORTOgg93eAk3Bvq9dQl2bMv/v0dJmRo2rVCUAqrV9dIIJwV8DwJiXYIF3+E
 s4RxAkllIxfjTm1QtN/3vCuw5JGPqBAFoney07UhoFSSBEhCYE66krKwW0jS6YAE4e4hF6RRF
 gWwWTmzfwWziCt2v0Akt5AVZnLxJTC9TBVkkvR8lW77mn9xhO0mgMVqg5/uIc/2si2pVK3WSf
 IMVpp8oLcz+fLny1MT2qrUR1Iq9Y2Yy+P2Jbr9gm8qxHbNWwmRwb8zMQbq4OThRZqkOAmfxXV
 CxmtOVnw6PIKe+3eoOef3Qh8f0uVfnA2z7HHG4k+XVESk9C4nD9neyjlnpY2053smqannUkus
 VcCjxtywFL0CbODeJEFAHftemRtkfIU1N2d+Qu65AEM+9vBJkK8zXrQLxIPS75vCDfcp75aPw
 mqaaiTajnm7byDoJug10FoT1DVfH60gHp7luH7gFoKi9qyO05G+WdAP1bjNJatxXG2YbHdBxv
 uaK13n3mcpS3b5htKllOzoD7MMKtXL9o/dLVRTDTA6R5a6Yueu81rITRFsnYnnjemmkqv1zZR
 E/o4h3o/wtcNd7MVxDaEIC8UMoHRmVESI+w1QBJTn07AB4Rteddulum87PbyqcNlQaFc/t+Jt
 pRyJTSS2v5oXvIr8XLsI5VGarUFPZy+dzGKd9VP5viYYdA8su73562Zstg9jfAlB/6+JdNu5m
 iX94DNDJ7UHcPLWnurcP4Wx8ng0n+ITqCmMXFQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2018-04-18 21:51, SZEDER Gábor wrote:
> On Tue, Apr 10, 2018 at 10:28 PM, Florian Gamböck <mail@floga.de> 
> wrote:
>> Adding external subcommands to Git is as easy as to put an executable 
>> file git-foo into PATH. Packaging such subcommands for a Linux 
>> distribution can be achieved by unpacking the executable into 
>> /usr/bin of the user's system. Adding system-wide completion scripts 
>> for new subcommands, however, can be a bit tricky.
>>
>> Since bash-completion started to use dynamical loading of completion 
>> scripts since v1.90 (preview of v2.0),
>
> I believe the main bash-completion repository can be found at:
>
>  https://github.com/scop/bash-completion.git
>
> This repository still contains the branch 'dynamic-loading'; for the 
> record it points to 3b029892f6f9db3b7210a7f66d636be3e5ec5fa2.
>
> Two commits on that branch are worth mentioning:
>
>   20c05b43 (Load completions in separate files dynamically, get rid of
>             have()., 2011-10-12)
>   5baebf81 (Add _xfunc for loading and calling functions on demand,
>             use it in apt-get, cvsps, rsync, and sshfs., 2011-10-13)

Nice, thanks for the pointers!

>> (...)
>>
>> I think the easiest method is to use a function that is defined by 
>> bash-completion v2.0+, namely __load_completion.
>
> This is wrong, __load_completion() was introduced in cad3abfc 
> (__load_completion: New function, use in _completion_loader and 
> _xfunc, 2015-07-15), and the first release tag containg it is '2.2' 
> from 2016-03-03.

Dang, I thought it was introduced at the same time. Sorry for that. I 
guess, 2016 is a bit too young to take it for granted then?

> The release tags '1.90' and '2.0' are from 2011-11-03 and 2012-06-17, 
> respectively.  This leaves a couple of years long hole where 
> completions were already loaded dynamically but there was no 
> __load_completion() function.
>
> Would it be possible to use _xfunc() instead to plug that hole?  It 
> seems the be tricky, because that function not only sources but also 
> _calls_ the completion function.

But isn't this exactly what we want? Lucky us, we can replace the whole 
if-fi block with a simpler:

    _xfunc git-$command $completion_func 2>/dev/null && return

If _xfunc is not defined -- as in, bashcomp is not installed / loaded -- 
then the return will not get called and the original completion will 
continue:

    declare -f $completion_func >/dev/null 2>/dev/null &&
        $completion_func && return

Since this would be redundant, we could define a fall-back for _xfunc 
like so:

    declare -f _xfunc || _xfunc() {
        declare -f $completion_func >/dev/null 2>/dev/null &&
            $completion_func && return
    }

This way, we retain the "old" behavior and get dynamic loading if 
bashcomp is available. The actual call to get the completions would just 
be _xfunc like in my first example above.

What do you think?

-- 
Regards

Florian
