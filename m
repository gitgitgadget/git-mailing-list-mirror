Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,FREEMAIL_FROM,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 27A8A1FA14
	for <e@80x24.org>; Fri, 23 Jun 2017 20:52:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755005AbdFWUv7 (ORCPT <rfc822;e@80x24.org>);
        Fri, 23 Jun 2017 16:51:59 -0400
Received: from mout.web.de ([217.72.192.78]:56337 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754937AbdFWUv7 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Jun 2017 16:51:59 -0400
Received: from [192.168.209.79] ([195.198.252.176]) by smtp.web.de (mrweb101
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0Lr2dj-1e2UwZ2TPX-00eeQW; Fri, 23
 Jun 2017 22:51:48 +0200
Subject: Re: [PATCH] pathspec: die on empty strings as pathspec
To:     Junio C Hamano <gitster@pobox.com>, Emily Xie <emilyxxie@gmail.com>
Cc:     git@vger.kernel.org, David Turner <novalis@novalis.org>
References: <20170607033308.33550-1-emilyxxie@gmail.com>
 <xmqqfuf82xr5.fsf@gitster.mtv.corp.google.com>
 <CAAin2ARfUCYM95L_k3fSQ--reQD3uMG72ah=Xg1xvvgKcU+QkQ@mail.gmail.com>
 <xmqqefubgxa3.fsf@gitster.mtv.corp.google.com>
 <xmqq60fngvky.fsf@gitster.mtv.corp.google.com>
 <xmqqzicyeg2p.fsf@gitster.mtv.corp.google.com>
From:   =?UTF-8?Q?Torsten_B=c3=b6gershausen?= <tboegi@web.de>
Message-ID: <802ccd37-c09a-8343-63fe-a42c682a8311@web.de>
Date:   Fri, 23 Jun 2017 22:52:44 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.11; rv:52.0)
 Gecko/20100101 Thunderbird/52.1.1
MIME-Version: 1.0
In-Reply-To: <xmqqzicyeg2p.fsf@gitster.mtv.corp.google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K0:7d0O19uO1LnQk5X3qu7r/Refr8qbZ0W/coFOMdzYI+DbABdB6mr
 bIV4XUVvaY8Cm43kDEtduJ6f9lHZyCXnpk5HnPjUd60Qnf9cae/iYD2/DWpbcm0q/ZkMf4B
 IVoS1tzD6JMYcDF3SGv5YmnFqzpXY30IszzYkMLcUal9bOq9XOuZ9aGjqPsG8kdTR0/1jXi
 D7ZDGI0OyWo5xLGDeEd3g==
X-UI-Out-Filterresults: notjunk:1;V01:K0:P9VOFygiZLU=:5um1vaBWCD7WJr1FRvB4Zz
 HbyN3NVy84T043NuO0zgR5Bwypy6iIlPtbD7VOtwzYCkPhmlt6CNoNx48eZZzZM/hBX8qkZKw
 gdNTSwx2w1UZR5SkEfwMCVlWXxy4+kGwcnILtbHNMOA+xSiMU5j26Fl86aeGNTYcpDq8EfNGV
 uSQC1FXbH1yMN6FAhZ6R1dc6nhtK5sZDLcTINZynx0EBkZbbf0dfPSmBauLR5FYIdduAiLSfP
 mDZiJ0MJLDd3w7v2PXayJ7rZOHWg96b1TFZTSo87TVW4Ypm2TwTnrNg96VTMJP2niWrEipgdJ
 uD3bU7R5jzXFvYn1Wz2P2VB/3DmY3xBv0f5sfUClPkLrNtCwfLzINKzyWKgTrezUt7XhLC4Ok
 ol5nKr6H9GK2bagyH+6BlgRSqlZUMgqxATIRZmEqbgKIqG6VezCE3qWpAPeHy2tQgOvciaiBO
 7x52MDE8skSVUV/y6oMs/E+slRUQFSSd1Q+ySbRIp7d5R+0jpn29OeuIzntBEY7H4lMMIVXo8
 f62IyFjqUIY5PW5m7zGj+fGpmQobs9n2jkeAwnHPIXixOpXNkyuYbAoLNlZBLxPFfIcRMePsD
 gRY0TRUFTm1CTJdaSBiI5ERYvrGla28/yRXpOtXynEEBxjJvBBufR3mSLbIFWGhGrL21aa3ja
 x4VKzumsghv6HqOF9Aub3Ud0p749biDYj6CLPJ7UsUzHf1wP6HNBFhtl20bJgiN28fP2rkGre
 b6pVg9ztfvEUo4rydV0zTdKtzJmnVwIFT7Fv6qy/v9MB2pulZEihfwNVG6suisCu9ISfcW32Q
 CCXgH0Y
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On 23/06/17 20:04, Junio C Hamano wrote:
> Junio C Hamano <gitster@pobox.com> writes:

Sorry for my mess, see below

> 
>> I am not sure if we even want the dot there, but at least that is
>> what the original author of the test intended to do when s/he
>> decided to pass an empty string as the pathspec.
>>
>>   t/t0027-auto-crlf.sh | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> I'll queue the following _before_ your "final step", so that the
> whole thing can be advanced to 'next' and hopefully to 'master' in
> some future releases.
> 
> Given that we ourselves did not even notice until now that one of
> our scripts get broken by this "final step", even though we kept
> issuing the warning message, we may want to re-think our overall
> strategy for deprecation.  We've assumed that "keep behaving as
> before but warn for a few years and then finally give a hard
> failure" would be sufficient, but depending on how the script that
> employ our programs hide the warnings from the end users, that may
> not be a good enough transition strategy.
> 
> At the same time we re-think the deprecation strategy, we also need
> to see if we can update our test framework to help us better.
> Ideally, we could have caught this existing breakage of passing ""
> as pathspec in the test soon after we went into "keep behaving as
> before but warn" stage.  We didn't and found it out only when we
> switched to "finally give a hard failure" stage.  That is very
> unsatisfactory.
> 
> Needless to say, neither of the above two comes from _your_ change.
> It's just something we need to improve in a larger scope of the
> whole project I realized.
> 
> Thanks.
> 
> -- >8 --
> Subject: [PATCH] t0027: do not use an empty string as a pathspec element
> 
> In an upcoming update, we will finally make an empty string illegal
> as an element in a pathspec; it traditionally meant the same as ".",
> i.e. include everything, so update this test that passes "" to pass
> a dot instead.
> 
> At this point in the test sequence, there is no modified path that
> need to be further added before committing; the working tree is
> empty except for .gitattributes which was just added to the index.
> So we could instead pass no pathspec, but this is a conversion more
> faithful to the original.
> 
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
>   t/t0027-auto-crlf.sh | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/t/t0027-auto-crlf.sh b/t/t0027-auto-crlf.sh
> index 93725895a4..e41c9b3bb2 100755
> --- a/t/t0027-auto-crlf.sh
> +++ b/t/t0027-auto-crlf.sh
> @@ -322,7 +322,7 @@ test_expect_success 'setup master' '
>   	echo >.gitattributes &&
>   	git checkout -b master &&
>   	git add .gitattributes &&
> -	git commit -m "add .gitattributes" "" &&
> +	git commit -m "add .gitattributes" . &&

Reading the context here, there shouldn't be a "pathspec" at all,
as .gitattributes had been added just one line above.

The line should have been from the very beginning:
	git commit -m "add .gitattributes"  &&

# What do you think ?


>   	printf "\$Id: 0000000000000000000000000000000000000000 \$\nLINEONE\nLINETWO\nLINETHREE"     >LF &&
>   	printf "\$Id: 0000000000000000000000000000000000000000 \$\r\nLINEONE\r\nLINETWO\r\nLINETHREE" >CRLF &&
>   	printf "\$Id: 0000000000000000000000000000000000000000 \$\nLINEONE\r\nLINETWO\nLINETHREE"   >CRLF_mix_LF &&
> 
