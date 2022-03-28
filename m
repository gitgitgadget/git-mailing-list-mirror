Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32CCEC433F5
	for <git@archiver.kernel.org>; Mon, 28 Mar 2022 14:37:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243945AbiC1OjG (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 28 Mar 2022 10:39:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243940AbiC1OjF (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Mar 2022 10:39:05 -0400
Received: from mout.web.de (mout.web.de [212.227.17.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B1FF5DE53
        for <git@vger.kernel.org>; Mon, 28 Mar 2022 07:37:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1648478225;
        bh=6rmavl5tbX8EVU/hWv5yU+lj1lUDCF816LmrV7Nowmw=;
        h=X-UI-Sender-Class:Date:From:To:Cc:Subject:References:In-Reply-To;
        b=OlX0nqQr5XpHf0az9Zrw3BxKb0yIg3J3/zNAKuyAymMVh5Shp+jMaQPJu1QBqUmqq
         +Z4E8jX1l1XyVfy2mznS2NnbXu9w07Lf9ZZU+6JJuqOkoTtKduSLcorem2QUQkuSHn
         /O4oPXYkU5Qe9aktspK0pgb+C8CQSfTUIxT1vzd0=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from localhost ([62.20.115.19]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MIL4Y-1nnCVB2WJg-00EYM4; Mon, 28
 Mar 2022 16:37:05 +0200
Date:   Mon, 28 Mar 2022 16:37:04 +0200
From:   Torsten =?unknown-8bit?Q?B=C3=B6gershausen?= <tboegi@web.de>
To:     Jeff Hostetler via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Jeff Hostetler <git@jeffhostetler.com>,
        Derrick Stolee <derrickstolee@github.com>,
        ??var Arnfj??r?? Bjarmason <avarab@gmail.com>,
        rsbecker@nexbridge.com, Jeff Hostetler <jeffhost@microsoft.com>
Subject: Re: [PATCH v3 00/27] Builtin FSMonitor Part 3
Message-ID: <20220328143704.md3chsipj7iucook@tb-raspi4>
References: <pull.1143.v2.git.1646777727.gitgitgadget@gmail.com>
 <pull.1143.v3.git.1647973380.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <pull.1143.v3.git.1647973380.gitgitgadget@gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
X-Provags-ID: V03:K1:ZvHP/p4mxwpRZlt6gHiKoYhI3PN0XnJs3QHKn246rtYJMR+Y+OG
 VbOePBnX1d0E1brFxhEa5+BB2pMxMB2MDybFEnsk50mmXNpvvm1nMIlJFnZe9TJucLTAGTS
 mtJCFVxSm2Tm5CfTXvBHDBzk6HLHk3y1vHHUHCISxF5lpkYXo+St9H2pvexuRPPRt90sUqQ
 qiEK6yHi/4JkFDE8z0ULA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:j45DC4P82wg=:A+56uZ89jhF8kuwxbcMHUL
 PZAXRz0e5ty90pJ0Sj3U9UnvpLUjw8IOCCAAqcb4mt3DxtvaBVGTPah7p65zzh8Y9MhwbwtjZ
 mxkfDXEpckgpMPct9sRpZKGffpqubjXB8fc/Cxe/ayLk3E/dIL39jMl0FydsCQOPsRq8onhOE
 oxX/xJvaPfua3yCxy6b2ZH9PloUwPjPtwxmdum2Nd+/C1c9Jddr75vdd7gHlrQAd0g+1OWzwY
 EgsV0Du9Netz6UM+3HNFaxmcZYa/BFzw/FJ3nqSRWfRn6g7UHY7kRNewX+lZ6H+rXnrCPtqH/
 hIJI5TUII1dINxGYt6FzrMX/u6tVDDZ0Zd0aQmDvhonUpNc7nl0SObxkH6N8KC5PGp9dPUVL5
 HT5eomeyMlVG/ZjuJNDh0X0ncUYp/5j7JfbRDbhw3suG5BiGnCdZ+HbofCATbLMF33AhpCQ4C
 tNEnt8h9PFty8aO2X91pGIXBWZ5/YPcQUONXyYfxTHMxH/ygXiIRFxVRt4pxdaI+BXRTWcJNl
 FSCVrWbnPe30ozqABLH3gdT0EPD65c9yvU7qgTy3DzHG1210NoQusWRwVm9FD/Ng7nq640cGB
 D3twTxr4OwL5vQjtDqkNaULJ4J8GU4bEh+i1kqmFmA2GTe4XyDhxqPV2+H+yxRzxnbDk1ogbK
 7GVouub9KSA54wFlpl6+f7jjS4crijah2wJCoN8SsE32UHzWUwd4HGDLbGtnSBgBhbuHwJjg5
 3I+NbQcV0YQnPvDP93b5z+HL9WZIjm5t4sJKblNcFqurlYtkngi21vY99GoKl2XNBXU8+LsNg
 ktWG7p4RlFKGy1ln+ImzmD9sOoCxUk5CoAlDJqKwMvV7xsNZ26akO2asarJ4oztovwkeAL7R7
 krG7xdlZ7m2XtLTdlk6nZIZqEHE8G+v1qACsGif19pI3VF9yeiU6Y7R/gqfJuADMcKJnTsva1
 0UlLLeODO33SYf3jTLYXDFpAiuGRYUymNKSTeRTQwx7o8oBzJWjtycMqAYJx8pWQcGwxjtQdr
 BaSCxkx4iNt8njl8KGFFpQWdda+ON5RBOtLy+h4zPBRJlwXI/QVb+qUbUiC4FwqGqQ==
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Mar 22, 2022 at 06:22:33PM +0000, Jeff Hostetler via GitGitGadget =
wrote:
> Here is V3 of Part 3 of my builtin FSMonitor series.
>
> I have addressed all of the feedback from Part 3 V2 and the mess that wa=
s
> Part 2.5 (now obsolete). This version builds upon the new V7 of Part 2
> (which includes 2.5).

Thanks for the patches. I think that my feedback is included.
/Torsten
