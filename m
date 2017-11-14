Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F3FDC1F43C
	for <e@80x24.org>; Tue, 14 Nov 2017 16:45:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755615AbdKNQp5 (ORCPT <rfc822;e@80x24.org>);
        Tue, 14 Nov 2017 11:45:57 -0500
Received: from mout.web.de ([212.227.15.3]:65332 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755608AbdKNQpw (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Nov 2017 11:45:52 -0500
Received: from macce.local ([195.198.252.176]) by smtp.web.de (mrweb002
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0M7bhn-1fAJ463bQF-00xKor; Tue, 14
 Nov 2017 17:45:49 +0100
Subject: Re: Changing encoding of a file : What should happen to CRLF in file
 ?
To:     Ashish Negi <ashishnegi33@gmail.com>
Cc:     git@vger.kernel.org
References: <CAJ_+vJ6FXXda4fe7=1YxtDGR2d8CqP4KXN+YR6+mdQ+5jQQXug@mail.gmail.com>
 <8b3225ce-a4aa-56ee-5296-6cc7528556d1@web.de>
 <CAJ_+vJ5J250CtzVg4QwEusddviDSYuJhubsbTJyv5Nc2conAfA@mail.gmail.com>
From:   =?UTF-8?Q?Torsten_B=c3=b6gershausen?= <tboegi@web.de>
Message-ID: <9d1f6549-fcf7-e96f-a15d-ca19c51c7fbd@web.de>
Date:   Tue, 14 Nov 2017 17:45:49 +0100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.11; rv:52.0)
 Gecko/20100101 Thunderbird/52.4.0
MIME-Version: 1.0
In-Reply-To: <CAJ_+vJ5J250CtzVg4QwEusddviDSYuJhubsbTJyv5Nc2conAfA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K0:I0EXDJrSM52i5S63T1rL+UVIrcdJ07LrvRVQdV3tS+NPdy/jDGu
 Iu7vYT7qYSXEQgJSyCx3z6T5aApJ1vnxQH3cUTZXaj0whR6uW/0Zz5IaQHar8cijqKJApBy
 yN4noyKU34hxHAD4GjjI58hA6hg0gcmjIlhvcjBUwCqLgmWoLJt1Lf2wkF5wjyNThWUjUgT
 s+3/1NVnAeUYEXcl6ZzfA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:q/RhJJ89c2g=:Til4Hwxngnb3q60YWmOmxk
 h9t97ZvRWfraFrV/8If4Vu8NKM0hXjYkmVB36Vz13hhVgV4cNC+MNTYHlbcEFIPYHRj3opi50
 pw0CQ/+2iC2cekBujfU3SbywVDrdB+PXurnIe9JR9U1qaZCwc9jMiNt1J2Ipyja57cYdOVqMv
 UiQF3+fK7I10Zj2XHVpFnh8pYlxAo3WAtoQrESB4iRHNk+dkTa35GV00OyBqYFzPgeLlDkHpC
 +nN8F8xDBZcQ8+xSXDu4yC5Y3fWQikRVEOmrTATQDuzTWSZ/usbr1WsH4FucCwCCY3W9Z2U9w
 nVqoXpnZj2p6A2+qSW34gro9vrne4+JrBibnjmuthkuszgYLtFPNeLXlsoTtSpH3kulCsO9sV
 4nZOIPbOBcMW9E86CfFty5rGAj7PmikC+pjEclsiQ+USVNmdNOdGJ8WQTj7SO1DD2qKoymNlr
 pJaP05Vu19t5uB8SMd5LyE4F2E3kTcEAQz5rYqzFVfB+htxGC3xw+vYnJ7Ciz1CRWaKgkiEoE
 yeS+00CeFLVal0bBf22j101hD2Tl9s9jlfAY0+X4Bn4nD8u1nTfZ96p8sepdwuu6J2A2BsSFM
 7NoabotJBJyBlCMhLZoTzAnvPGl+/oq5WuJS91gFiBmOvByTcX4L5qt7MSb39PaSV1JeAGJ2B
 eOsYwdLwA5AG081GxavkxYwJawU9VIeKsqH6RtQYZ7HxZz4FKTaDpAzRZlXan8nG0ISF89doC
 5rY0qXqaEijxFJgQ1/Ft3CDVG0kXhDj1We/RPDMRQJI2KJ9SwWSrnwIZ4dS2DuoKbksyahOqn
 dGUPv4Q02MJu8zohUaV6wRWYCMl25uYbkhBi8FDLJlkGH9DnFo=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2017-11-14 17:13, Ashish Negi wrote:
> Running the command gives me :
> 
>       git ls-files --eol file_name
>       i/-text w/-text attr/text=auto          file_name
> 

That is strange to me:
According to that, Git would treat the file as text=auto.
And the content is "not next", so there is no need to convert.
Do you have configured any filters ?

Is this a public repo ?
if not: Is there any chance that you provide a public example,
so that we can have a look ?


