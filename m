Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0D1071F428
	for <e@80x24.org>; Fri,  5 Jan 2018 21:26:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752944AbeAEV0x (ORCPT <rfc822;e@80x24.org>);
        Fri, 5 Jan 2018 16:26:53 -0500
Received: from mout.gmx.net ([212.227.15.19]:63058 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752261AbeAEV0x (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 5 Jan 2018 16:26:53 -0500
Received: from ggw-xinxiao-xx.fareast.corp.microsoft.com ([37.201.193.20]) by
 mail.gmx.com (mrgmx003 [212.227.17.190]) with ESMTPSA (Nemesis) id
 0LgISa-1fIi2W0hXA-00njZe; Fri, 05 Jan 2018 22:26:48 +0100
Date:   Fri, 5 Jan 2018 22:26:47 +0100 (STD)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@johannes-schindelin.gitforwindows.org
To:     Elijah Newren <newren@gmail.com>
cc:     gitster@pobox.com, git@vger.kernel.org, sbeller@google.com
Subject: Re: [PATCH 3/3] merge-recursive: add explanation for src_entry and
 dst_entry
In-Reply-To: <20180105202001.24218-4-newren@gmail.com>
Message-ID: <nycvar.QRO.7.76.6.1801052226200.1337@wbunaarf-fpuvaqryva.tvgsbejvaqbjf.bet>
References: <20180105202001.24218-1-newren@gmail.com> <20180105202001.24218-4-newren@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:EOF/qKnautrdNKCm6mYGk9WU9uQcLFahVo4Pk8R0JjBxRIavasl
 HWE9UZLd4gMZZHe6zbcg+n2ijA3+RaA3hegc08gCZKH99VluGCPPxFZU9GmfGV3+EL4iv+X
 sgD0ly4/RTM55gm5Rt+1eOQbW54I8ox8/d8ZAw2TKY5hH1XcBLnZlh4Xoqvemn7BZsexjBj
 rr355Xhel6zHHDP4dTebQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:m+zDv3MPbYY=:hYH8Jpry0D1iJk71BEyncF
 6PCqnjjO27X65lxTgQ+1Gs5O4Axm3957tFFqrcQZxc8TrFdHCtGYQeVXCQl4jRlarcTTCggam
 yUypOeXNdt2CLKYinKhL21NPbzaKPDy39NpAAoTYd0RBnZcZ6COLQqYFxvoK/KfCOHJwghu11
 ld88JpG+3ZJRKpi3TJhqVQiyxF08a2zeG4GXn5pmn8bRdwbdY64JMOQ6HKTYVRcg4WgBwehR0
 BktydW3eV/RTG3jkLM3AvTsG75WRWDjG4bqnrXHRjvrGaK1QjYo+l5COB8qM+iEm4dwQcvuBu
 w6Hu13cq8E/WJvfNkU3vk70rFGJVwl0qNrUz4wJM8+J7gGO7OuZCM1GS4zVCOghUJDETapdRe
 HETVnADu7HVKPsqBO5lBEGa9VxnY4tXF+WRMHiR+ToJZvqkPSb6pXIkkR3X3HTazQNCEn/2Z2
 MmS2Busox4n3UDrdaN7ZyDvFCiN5s3KUx2YJHRqgRSgERZbVnjNFiw2/AtxasmQlFnIvlgyH/
 v/sLFpWy1l3zGN4/hw4/I3HBKjNTglrjPgDoXRdDnTGMbGz6W04PyfC7RoC89f074I+uVGT5O
 zV4Lpsxa09QTjsg5M+5hodOAmvKMCuZSSn88fZfHGjkUzcB4ip8vnY7idlXpeY5WBQfcZPIiW
 oTDIasGLO9afbOab/eyB1agkkbLXDltyuNavGyBnone3eNp47rYtIbwxJagZDc0sTans05Rde
 GWoxi7Bb4/BteoDZHJ6CuvLZflJxqfKiH2LJwuzDe2+mBjdZnSb7XsOGzMFX1Ronrkbkdjzlf
 X0sQBedHmydKa7AU2qJikd4FgD98Ccp9QWIWBHKtGM4uq7PFTECiffCGKvEKmMTgYfarZLI
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Elijah,

On Fri, 5 Jan 2018, Elijah Newren wrote:

> If I have to walk through the debugger and inspect the values found in
> here in order to figure out their meaning, despite having known these
> things inside and out some years back, then they probably need a comment
> for the casual reader to explain their purpose.

Makes sense.

Thanks,
Dscho
