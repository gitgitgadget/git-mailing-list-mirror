Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 51A2F1F790
	for <e@80x24.org>; Tue,  2 May 2017 15:35:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750740AbdEBPfI (ORCPT <rfc822;e@80x24.org>);
        Tue, 2 May 2017 11:35:08 -0400
Received: from mout.gmx.net ([212.227.17.20]:61592 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750710AbdEBPfH (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 May 2017 11:35:07 -0400
Received: from virtualbox ([37.201.193.73]) by mail.gmx.com (mrgmx102
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0LcVOE-1dp2uq0uz0-00jqN1; Tue, 02
 May 2017 17:34:58 +0200
Date:   Tue, 2 May 2017 17:34:57 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Liam Beguin <liambeguin@gmail.com>
cc:     git@vger.kernel.org, peff@peff.net
Subject: Re: [PATCH v3 3/6] rebase -i: add short command-name in
 --autosquash
In-Reply-To: <20170502040048.9065-4-liambeguin@gmail.com>
Message-ID: <alpine.DEB.2.20.1705021732570.3480@virtualbox>
References: <20170502040048.9065-1-liambeguin@gmail.com> <20170502040048.9065-4-liambeguin@gmail.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:kOUkQ9GzNMDkJ4NapCEfuiregFEzBO9WfVVdkkNQgzcpH1viNxY
 /Eeuw2OUpVjD4ziOWXDlT/Kq5FQLgamdq1rh6O2ILHPWBLiMQZYQEKOV5zfKPb1y3Rpe5MG
 eir91+0dDHPGCya2IQefwWEPfFxdD8LnIO0VEl7IXOuxXy9Qz6XWzLbMqDmJFy5dyo2tH1r
 LIdPrUowP33exLSETzwag==
X-UI-Out-Filterresults: notjunk:1;V01:K0:ebtAMiY57Zo=:LdQutfdIqrU31DZnLtYgjd
 8sI+gpWFwN+iPvBT1uEcYbOVU8g/v18e5AArjfhgElyoAnieIUMdNViibQnjtWn7UQMQSkZ5z
 sg5mJlgfZfgMRb6aC3d7ENn/NOJzZ2wxpZ7B8+mXDb/HxxPlUYAalZDC7Q5afsWoS9Wfhr4Sv
 8m60hT/uj2lv+dtcKGanO04MT+gNwhOuznuXAxkmeP83Rk3plN0rzukjSstam9ENFePnSWozC
 rkRvm2unXUQS65u/NsnNivHbCuAjnlu3ABO9lnCzZcoYjYqV1tTEIhILafzUDaWcZZZVQ9Zt8
 rimjihew9n3eimrgx/BbTlxIdipIN2vp45xb/oTnFeHof+jY9jfoyd+Pfo686F/jVm5jmRvQ/
 NyXh0u33tNwP3L2qOwMqDbfksVtSgaaz01+QkmSkjJf39y3+U0e8465pNbpGIGd6QQGNXTrrb
 ZTVeX8bjCsxBIG4bhO7e039zhbSdxAJyuPL+uIPhgzEPKahSHMgfUOdhSL/dP4frYClCvLDGg
 ub4UHH+4trTt0fKj6RNCr5OJHLyk0NG/EubmXtw+Wo4EJXUs3XGEyb/P0BY/wBOVTlaPNRdLZ
 qkRWJfupYI0L1DXHxq3t+SiyrsVQq2KqF6tl/LcucXPfol26ckT32CNJOwaxHXCRrNHmiGX73
 yjvdltX8Ru/IFvzt5WRgzczf1NScK+zmM1qPiNWwJDmbUKeqxibK6CaKMyf1K3c89jjhPRKdv
 jz+1MX10jIYLzYmtjE0n6PD2KUq2sQCvlCO13r0QT3MtuKFLOdL0vadOR/nzGeHalBSxdRWO8
 n4ZUM2R
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Liam,

On Tue, 2 May 2017, Liam Beguin wrote:

> teach `git rebase -i` to recognise short command-names when using the
> '--autosquash' option. This allows commit with titles beginning with
> "s! ..." and "f! ..." to be treated the same way as "squash! ..." and
> "fixup! ..." respectively.

As the recommended way to generate those commits is by using the
--fixup/--squash options of git-commit, and as there is *a much higher*
chance of false positives when using a very short tell-tale such as `f!`
(which could be an abbreviation for an expletive, likewise `s!`), I do not
think we will want this change.

Let's keep handling just fixup!/squash!

Ciao,
Johannes
