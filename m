Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 318502023D
	for <e@80x24.org>; Mon, 22 May 2017 19:52:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1761814AbdEVTwo (ORCPT <rfc822;e@80x24.org>);
        Mon, 22 May 2017 15:52:44 -0400
Received: from mout.web.de ([212.227.17.12]:57889 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750885AbdEVTwm (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 May 2017 15:52:42 -0400
Received: from macce.local ([195.198.252.176]) by smtp.web.de (mrweb103
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0MddJY-1dc9SR1yA8-00PO2d; Mon, 22
 May 2017 21:52:27 +0200
Subject: Re: [PATCH v4 4/4] convert: add "status=delayed" to filter process
 protocol
To:     Lars Schneider <larsxschneider@gmail.com>, git@vger.kernel.org
Cc:     gitster@pobox.com, peff@peff.net, e@80x24.org, ttaylorr@github.com
References: <20170522135001.54506-1-larsxschneider@gmail.com>
 <20170522135001.54506-5-larsxschneider@gmail.com>
From:   =?UTF-8?Q?Torsten_B=c3=b6gershausen?= <tboegi@web.de>
Message-ID: <0e2eb0e4-6efd-349e-21be-ae1133a6047b@web.de>
Date:   Mon, 22 May 2017 21:52:21 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.11; rv:52.0)
 Gecko/20100101 Thunderbird/52.1.1
MIME-Version: 1.0
In-Reply-To: <20170522135001.54506-5-larsxschneider@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K0:OA+2m1SpyqjCmExgmld8JOsVu0aa21Sgjv1RVoTONJxqL8R9drV
 9Hjb/DIdU1xDq2nuYzBdNPaAiZ+kN42SYq01SJ7cYwAkDAO1u/ZPYur2CxcTDx3iOSGRr9v
 SMIQU2Rbuoa6wYtzuI+wPev6w2SJHmC4dZp8IW94Zh+WiBHM9Cz78tHJNzVnzkeyZrJI4X1
 hLsCHNguQHct+LYJSzgsA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:sWRA+76lycc=:yZfZCJNZd2SoljChctdV2p
 UJDX7/92OXc7u8Rt2hI8aid/RLhdxJne9Qg0caklvMVetgD3MwlM4qqC/YnNd1O1dN3yF6Obs
 MsIT8DHcZpfkNuH+VYEQBrYkSMJR4sdojGGX+FmE0dvn2xxPWV1r6FlAXmrmKlM7aBUOS5wRB
 7Sh/6t7BKty3bCqTSkg5uXyzTP1j7GZmyph4InPmuPw4L2Uk1tcP2I6eJqY98FQZ4E5zUgP/6
 AizWCRI0qrXy+tBy2WXRY5sfEiEVxdUQLbKETPyc4vJMFsv0Kybx4CPO7n+bC/czjyJ4WpRsp
 X+UsPZdngrShOOrONIM/gQ6ESKSEVUIjsDIw9lFBiGsE/9z0HpvkJuV+1Po6SI/1g5vzRX/+U
 aSrHxNUEqCYiwS4HPbSTyKYTm3dcVczrJ3mfW2uy2TkshE4OG6PW8pLYQ72gsPD8u1pXK+3eo
 0gqT4ehRJ8bMfH76+xytzLlDMNRPRotJtQRGCLlTqTSK8yKxqTQIeAfpM/mCJvrnEjYBtKVuV
 l1zvVeJRX2GbQmqo7vHzFrwgTOiPic8dxvP9X6gFXR/zKpce31l66kyO3Obhz//8GBZBZ/RcK
 WliVNo3FV7bzPBkYIHqFWelcj+97MZ9U/PniE/SOzYDWzFnlo5u0SZ+ts6Pdo7sUknwVmWlEA
 Gm/iq54S1FyF1P91gff6VTEJq7VQmt2KLkDTgC9bi7Pi6ho42UMjnMdlxKhnQ3x7VxGP2tFgJ
 uLE9fycm40OvEKRvPe07SOB49OAsDrfq2WIYxmfiz65uxOfdKEagYHaVo1DiE2X4ofl8RbaTu
 znAj970
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2017-05-22 15:50, Lars Schneider wrote:
> +After Git received the pathnames, it will request the corresponding
> +blobs again. These requests contain a pathname and an empty content
> +section. The filter is expected to respond with the smudged content
> +in the usual way as explained above.
> +------------------------
> +packet:          git> command=smudge
> +packet:          git> pathname=path/testfile.dat
> +packet:          git> 0000
> +packet:          git> 0000  # empty content!
> +packet:          git< status=success
> +packet:          git< 0000
> +packet:          git< SMUDGED_CONTENT
> +packet:          git< 0000
> +packet:          git< 0000
> +------------------------

The documentation mentions "0000" 2 times.
Is this a bug in the docu ? Or a feature which may need a comment ?

