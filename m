Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 72AD8208CD
	for <e@80x24.org>; Thu, 31 Aug 2017 14:33:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751457AbdHaOdW (ORCPT <rfc822;e@80x24.org>);
        Thu, 31 Aug 2017 10:33:22 -0400
Received: from mout.web.de ([212.227.15.3]:64972 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751382AbdHaOdV (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 31 Aug 2017 10:33:21 -0400
Received: from macce.local ([195.198.252.176]) by smtp.web.de (mrweb002
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0MPY1p-1ds5Mo1AnJ-004oLk; Thu, 31
 Aug 2017 16:33:15 +0200
Subject: Re: [PATCH v3] Documentation: mention that `eol` can change the dirty
 status of paths
To:     Ben Boeckel <mathstuf@gmail.com>, gitster@pobox.com
Cc:     git@vger.kernel.org
References: <20170822174918.GA1005@megas.kitware.com>
 <20170831131936.26226-1-mathstuf@gmail.com>
From:   =?UTF-8?Q?Torsten_B=c3=b6gershausen?= <tboegi@web.de>
Message-ID: <78c1a85a-70c1-ff35-466e-f6c363a0c632@web.de>
Date:   Thu, 31 Aug 2017 16:33:14 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.11; rv:52.0)
 Gecko/20100101 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <20170831131936.26226-1-mathstuf@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K0:qANXO/wQG9JZXZ+I7af0HHE5r/lmT9k+77snEcy9TSvb3OE9alA
 0DR3Ch2MR2q+w01IqrmUotJRKk5vhtBCWe7KppsitwoPYEBthpMo0IdiFJ9zr04RlumXPmf
 YjBCo/mIdeR/FjPg/f03L7ucsfcfjov6xadzCMovkv8ZGbBaqGffBM29Z4t743WhjR/yGEp
 sWUu+XyKLgAwu2mvudMbQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:X6saWJSjghk=:7n1EUsaqE7M4mwxEEZaRVE
 ebTNmIBxxSy8eAebVaJcj2dMgjiRIm/NRjgFf9r0Vke2sp+Pwiibu4Wqbekh2wWnMero329Gq
 1sJKsO4CnxQmeBKl5XMqgAlgY3Cl81+YtwQYyL7ARIAbnVVF4ixYWLaFkETQYTnUhO3SXag7H
 LuDJkMCZZc9xA4u+gKoHQPEWNKe4AjuPQ+snPQ8nUXFN8WqguyLAcuf6vEGHxLN87QncINQYa
 +1dzEcVEl6Y7ND6uILB+vF8GYrFHohZGiUZQOcFElRmc4565DTGNm0nrYmshZ5Acy7gK0EfIj
 y3CTRio1FR9sMuo3Ihv5W+oVPileK+UKI9eK5YjGRLtJA6bcWz33ImoSCv7hL6SpgTkPNm/ij
 Z6MC64zYZQzc2xvfD8UWtaj8nvdGlSjFe4ekD38BqSen2DTDGHjTKc6IKWaAZRTpIz9y9+XP4
 KB118pH3KUqVN8tW6aaqaKSL1nBmKCXRyzs80lHdIHzUJFdos5qY/ShUqElYD0JQKtED7dGQE
 +BVnBezvBkip+5AhTTwACUPoIw71Lktgik82hf3XJjQ1KDdLXrEd0X7JV+ZqsLO2UJ4/ccXxL
 exFoctUNxCnstLh2LJppOhi3CdCsABHgLG3WL/q7jkmaoPDHWJ+j3QewBzaeFPC77F9Onoa5K
 QSx4hNbIuXDckM4I0KZup3B6BCQviKk+OsifELedvaKvQZqtt6g4tvqoSx0rKm/KlO+7CXxBj
 3ll9ZMN9bsWGXDIRfXp4wpAwiHeilihBIopAkIuKf6iPHW7kGpPDGgss+Bi6Mw/Gn/6lExJNe
 UV2YcnkZcmwP8UI2rL+xm+XAGbg+ZOp2yU/yJjcSHmG6GRcTjw=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2017-08-31 15:19, Ben Boeckel wrote:

>  This attribute sets a specific line-ending style to be used in the
>  working directory.  It enables end-of-line conversion without any
> -content checks, effectively setting the `text` attribute.
> +content checks, effectively setting the `text` attribute.  Note that
> +setting this attribute on paths which are in the index with CRLF line
> +endings may make the paths to be considered dirty.  Adding the path to

OK - and this leads to another question:

Would it make sense if we allow files with "text eol=CRLF" to continue
to be stored with CRLF in the index?

Skip the normalization for existing files, since the user asked
for CRLF in the working tree (and the internal storage is less interesting)

Should I consider a patch ?
