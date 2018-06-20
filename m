Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_WEB shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8FA591F403
	for <e@80x24.org>; Wed, 20 Jun 2018 11:03:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754276AbeFTLDU (ORCPT <rfc822;e@80x24.org>);
        Wed, 20 Jun 2018 07:03:20 -0400
Received: from mout.gmx.net ([212.227.15.19]:44537 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754115AbeFTLDS (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 Jun 2018 07:03:18 -0400
Received: from [192.168.0.129] ([37.201.195.106]) by mail.gmx.com (mrgmx001
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0Lee2I-1fyppR2fsM-00qWFW; Wed, 20
 Jun 2018 13:03:11 +0200
Date:   Wed, 20 Jun 2018 13:03:21 +0200 (DST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     Todd Zullinger <tmz@pobox.com>,
        Phillip Wood <phillip.wood@talktalk.net>, git@vger.kernel.org
Subject: Re: [PATCH] t3404: check root commit in 'rebase -i --root reword
 root commit'
In-Reply-To: <xmqqin6ewyv2.fsf@gitster-ct.c.googlers.com>
Message-ID: <nycvar.QRO.7.76.6.1806201301530.11870@tvgsbejvaqbjf.bet>
References: <pull.3.git.gitgitgadget@gmail.com> <d59805a43ddaf4bbd4528a2b7afa9809eca9b86b.1529177176.git.gitgitgadget@gmail.com> <484fe825-0726-a027-1187-de00df6406d5@talktalk.net> <20180618164958.GO11827@zaya.teonanacatl.net> <nycvar.QRO.7.76.6.1806182343421.77@tvgsbejvaqbjf.bet>
 <20180618221942.GQ11827@zaya.teonanacatl.net> <xmqqin6ewyv2.fsf@gitster-ct.c.googlers.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:1u5VpGy4dL9HfppYEsg/Ex04QixPgExYbK0Qp91eHNwMEPNH740
 h/rzk8LJ0KpXk6StsFKu0a6MmairAHHFFKD0eY9FvEnvmX8ZdJNyrmX/NTWiftiDu7y0rov
 bbprpTRz4E6m4V9Z2xewd6YBNEPJBvcbKw+Jhyjd3ZTPX3Goqa/r2ej5PfOhnAwpU7gI0Mp
 EUmWd248JyCMSmP3FJf+A==
X-UI-Out-Filterresults: notjunk:1;V01:K0:hYp60zcPhiA=:hRp4N6a7hFunUmLlNujnEo
 c0hghY1rPNhzebaoIOt4YgFE9qb0d1k01ULuCIqJPTN8ERtE5v2fuqksN0tv3VybTfDM5FjQ2
 6z5IwTh/IfyYS8ts2qH5d1ET6Dw9oEEn3OQAQTweUbKsX19zBFMha0+VyUCVTfcetKU0CUwwI
 Fr+aX8M7zCLVlzaWfTEfDTjSEbS1tve/KA5MWaxVWbhi5oEwMkeMwuJvH+OQjcO6DVWdqbjyv
 WT/RrGZbTp+nkm8ZC9xRuA9nKHPJfU8Djj9AkChTVkzhLX/X23nSdc5f/GVLNE6X5ji8uLOAD
 bnZgpPWGoLLocmNtV5/5XbQ9w7j/JRhODFJLe9B5Cm8WGTSVtIWHvU2a0BZbXwJjCvtF2V89w
 6chLAUGvnsFdVuqdIhauJo6P1wj7SLh1OJZOkZyBWljJOVL3sEdDdTcMQARnmONkLbyAnJ7Pr
 GEXkuR8p8JPBg+c3aMqqwgnAZJXAewHgoEf940gHKDuYLm6fDryTUrWCr+U3oqWj7jXlN3wv7
 YR5AOWrPAjODgKfrADILBKg7yJug8LzWtWTmnGrL/PUI0N74NSpADHHUQ8m1pD8Ilidj5meFA
 amUr1P4nSBMJg1hrWdCIbgopM0KEhTmTwSUp6TfaJbtf7/BW8Xfw/8HrXldCUJU6c5B4MyUYE
 YzBMD0hrwrOnFATbkIoalthnCUrmCoSqn5M84BywwzIobihGDVkCqUvMQq22/myw7Uiim9SBD
 xCPgBy2HkkjEYI1oh66ZQRw86FIpwkCTCjW8OMC2XU29rz57hFxG30ikUfWRuhX0VoaS3xW7u
 iO2xVGW
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Tue, 19 Jun 2018, Junio C Hamano wrote:

> Todd Zullinger <tmz@pobox.com> writes:
> 
> > With luck, this will save you a few minutes, assuming the
> > commit message is reasonable (or can be improved with help
> > from Phillip and others). :)
> 
> OK.
> 
> > Or Junio may just squash this onto js/rebase-i-root-fix.
> 
> Nah, not for a hotfix on the last couple of days before the final.
> We'd need to build on top, not "squash".

Right. Can we take this on top, at a leisurely pace? I mean: we verified
that this works in the upcoming v2.18.0, and it would be nice to have that
extra regression test safety in the future, but it is not crucial to
include it in v2.18.0 itself.

Ciao,
Dscho
