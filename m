Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 50A8B202F2
	for <e@80x24.org>; Mon, 20 Nov 2017 17:29:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751813AbdKTR3F (ORCPT <rfc822;e@80x24.org>);
        Mon, 20 Nov 2017 12:29:05 -0500
Received: from mout.web.de ([212.227.17.11]:55605 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751781AbdKTR3E (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Nov 2017 12:29:04 -0500
Received: from [192.168.178.36] ([91.20.49.242]) by smtp.web.de (mrweb103
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0MVcZf-1efPXj045v-00Z30I; Mon, 20
 Nov 2017 18:28:56 +0100
Subject: Re: [PATCH 1/6] t4051: add test for comments preceding function lines
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Git List <git@vger.kernel.org>,
        Vegard Nossum <vegard.nossum@oracle.com>
References: <790c2344-a71e-7089-9000-f9b37a4a5cd9@web.de>
 <b5815f62-3ed4-58ea-6d32-b156e44cbe3f@web.de>
 <CAPig+cQTzBYLqHw5TRYFajTK2Uq2fE=q=h=b=VA43zdJs0_CMA@mail.gmail.com>
 <bde81d14-a955-4ea4-5799-2a95511d8215@web.de>
 <xmqqine5okeu.fsf@gitster.mtv.corp.google.com>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <88f46ab2-03ff-3607-c776-25f34715ceda@web.de>
Date:   Mon, 20 Nov 2017 18:28:54 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.4.0
MIME-Version: 1.0
In-Reply-To: <xmqqine5okeu.fsf@gitster.mtv.corp.google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K0:GbjRKuYNrcCoKp8BDS3jwz6X2QFrkvek3z5WmnEYbypmhRaaiEc
 ZbVqHGwNMzUlz/TF6f3TLSsEABDa9R5JL/mCjOYqZQjcrS84OPDbgWijCR+TIIanHy9pNz4
 sWkcDPyhja8n5Ay4tQamY/lRg/CWKMVD7ii1oPYgebW9+5oil0vbS31hAs4u+gDBt6NJvKe
 rewHSYT3mmZ9sI5kkXBog==
X-UI-Out-Filterresults: notjunk:1;V01:K0:edzyQnYuvVo=:F8zmuiUOqZWwCet+8o8bi6
 lTXlQJMbI/bCWGVLIohk4wxr7OiAfKOnQqWCuexhJGIc3+ixTLwsmUKhlXbfPDgvpZ+/mU/SJ
 SNa0MIbDHa6UNk2iQ+MBG052X3sdwggOvmjAnBRLM5ERlcJu2ccXKiROtcjMxE2/uMaXI9yMN
 Rj5gdbY6fpaG0P1TimhLs9/cNnzxfqgt0gtur6+9WXFlUM8+9gs1/02rCnCtl3SPTiqw4AD1A
 7BxzhFiO7KK0/9n9aF0WVBg8pXhcl+MwCYPRtuVvZTtM17Txz3y3Te967pQXHZJbJB/nGjtuA
 hmR0frwlJZvPurHYYRSmyhrMVmghwdRXw31nc3d/wGIYU4Ltk0/AiIi2D7Mi4aOt4q7kYOQa+
 /lgaw4pHjsge+IkPpf/cmuD/gU6A7AbBtpxDjJJL6H+5dzMkf/W5KZDf7WEPonVbW5dzG6eGP
 ojNOEtUMqTKLlI4bcCTAEVE5VRXBDuq/jlPphk+G4PO2PLBe43LUZr6VbikFT/Sv63z37gX7h
 R+hS0eDWgOL80SrvJsbZyMDCl/0qu3fQyzDrk4uZc8OW78CBoDqjolKzIgeEurTqiNoG/jlQj
 gs/n+8Br4skE6/b0pv3fFBpr0tZOcJ89qG1soRgJSE5NJ4uFH6Z/hnv5eSPkmv3MHwfNyO4C7
 0VkbcUmi2+i1KUe3EJznX8uAqAPPB0AvrYU0jxE34B3WZQ/z7aEER6sCFNvF0JyN1GLGxpxMv
 vG8cdjeAVD9n8Gm3RO7U8aQC8CbY6cADzIkcVCLwbUheWhOQoZea+twMXrbzOCay6svtSBorY
 wUMAcNttvKHKmcQnGUkpv+oeEUYKYeh1JaAHjEKKAFk5ymoiVg=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 20.11.2017 um 01:36 schrieb Junio C Hamano:
> René Scharfe <l.s.r@web.de> writes:
> 
>> your suggested full-comment metric, i.e. more than nothing.  But more
>> importantly it's the actual comment payload.  The leading "/*" line is
>> included as a consequence of the employed heuristic, but a more
>> refined one might omit it as it doesn't actually contain any comment.
> 
> I am slightly in favor of than against the above reasoning, but it
> probably deserves to be recorded somewhere more readily accessible
> than the mailing list archive.  The title of the test "context
> *includes* comment" can be read to hint it by not saying that the
> precontext shows the *entire* comment, but that is a very weak hint
> that will be missed by anybody unaware of the reasoning behind this
> decision.
> 
>      When showing function context it would be helpful to show comments
>      immediately before declarations, as they are most likely relevant.  Add
>      a test for that.
> 
> ... but without specifying the choice of lines too rigidly in the
> test---we may want to stop before and not include "/*" in the
> future, for example.
> 
> perhaps?

That's fine with me.

Thanks,
René
