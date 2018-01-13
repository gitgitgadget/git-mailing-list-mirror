Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BF7F61F404
	for <e@80x24.org>; Sat, 13 Jan 2018 17:13:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755323AbeAMRNa (ORCPT <rfc822;e@80x24.org>);
        Sat, 13 Jan 2018 12:13:30 -0500
Received: from mout.web.de ([212.227.17.11]:58383 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754978AbeAMRN3 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 13 Jan 2018 12:13:29 -0500
Received: from [192.168.178.36] ([91.20.48.24]) by smtp.web.de (mrweb102
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0LxfKp-1eu4sF3BSV-017El9; Sat, 13
 Jan 2018 18:13:12 +0100
Subject: unused variable in hashmap.h [was: Re: [PATCH] Fixed pervasive
 enumeration warning in convert.h.]
To:     "Randall S. Becker" <rsbecker@nexbridge.com>
Cc:     'Junio C Hamano' <gitster@pobox.com>, git@vger.kernel.org,
        =?UTF-8?Q?'Torsten_B=c3=b6gershausen'?= <tboegi@web.de>,
        'Lars Schneider' <larsxschneider@gmail.com>,
        Jeff Hostetler <jeffhost@microsoft.com>
References: <20180112163644.14108-1-randall.s.becker@rogers.com>
 <xmqqh8rqx4kz.fsf@gitster.mtv.corp.google.com>
 <004c01d38bde$f0e6bb50$d2b431f0$@nexbridge.com>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <f139ed79-1e12-d7b6-dd24-ce77000917ec@web.de>
Date:   Sat, 13 Jan 2018 18:13:11 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.2
MIME-Version: 1.0
In-Reply-To: <004c01d38bde$f0e6bb50$d2b431f0$@nexbridge.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K0:2Roj93XHIacGtQoDHZ+bYRyBWQJBEvzkrSsDpqL1yRO/PSqnd4V
 9BMwOzsyo7Jr0lnntAgExbCkZgOychvxhpWMSKRO9Gx2YjMpOZwD633NVMyfW3qyxzzZi6i
 MgtJ5pxac4LtSin+NXimReUZJAbnz9YRWzFjD9fTW4Ndp8QbJrMpoMpntoF65DXxdVbNFcC
 27n/dD3jen7EsSwU0gpog==
X-UI-Out-Filterresults: notjunk:1;V01:K0:JQeyNJ8UYiQ=:9VjKVNVciDcAWHTUEEWWYB
 0/H0INZ1jR/lvPKQ/HCAifDCn1zwxUF9sMFkGigq+dTIYPHer0iMTEZ0dBC/9FPLWdRRma5KM
 CbIa8UBqzfdxcIm7aXBwY6OaiZZK0TxcGzgQRbuLacbjOlnrjD8OxL9CSfHTsOA+ZgUYo3bEw
 CVc6Np4sJVl3nuyKnJwIKPNdWsCawU9CYvQLpRbUOQfpfwhhUZp3PZLfjX0NJYStcgyyk7178
 eize/3DsE0PlEQ7bwMRekAL1cgtThI21u9txy40LnnE+epF2im8tKrjyXPcxPm14wUhKIL/KQ
 EwpFXwDfg++GCbEZK0TsBHYaNphsYwDrjksI47F0dEnt9sEc/2AVHFx+vvgV9ph1Hd1Pl5WuA
 n7Acxqpw6b3vllOG47wDO65RbvXg4mGS9ojfINB//4Vq9VCsDMZI18+QQLie+1WhOl4o+Rplm
 ohdtYXag1+QT8Y385SBqH6i1fngq+Qx+hJUFw15q6Ha+VCeQkOgJIg/LHzowWKxX2Le3SVVJp
 EHpOnlTCn8ciEo2x3Pch3PTb7HykCW24a8iqHKabXkae1lPfJ9SbC4eB8RA9zFrnVI021HDf+
 6hfDmfmLNBV/sR+yIjtekdWxSt9N7dEwWa/5UStZIjWcZU3c3K1qHmKIyHrWFAs5tMBnACBkj
 EMmXpMB6BhcpY+SKjcHB4U9nbSlNXiokKEjmBvejVyXF/vl4tUr0AB2l1wW2gRyfafwtzGGYW
 4cKDummnq5FrMn6/PxblhnNRFTyuilPxLktAMZP5QI6L3A2bwhpb1b51BzIO+CKNAop3o/BoG
 1f3C8lYCRd817rvLeI+x1zV0+rT5G2Wc+iOa6aL5Icr7xqZR2I=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 12.01.2018 um 20:52 schrieb Randall S. Becker:
> On a related too many warnings subject, hashmap.h has a variable
> unused (void *item). Is that addressed soon? If not, I can deal with
> it.
Here are the code lines containing the variable in question:

        void *item;
        while ((item = hashmap_iter_next(&iter)))

Intriguing.  The variable "item" is set, but can be removed without
effect.  GCC 7.2 and Clang 5 don't warn about that.

The code was introduced by 8b604d1951 (hashmap: add API to disable item
counting when threaded) and there is no patch in pu that touches it
again, yet.

René
