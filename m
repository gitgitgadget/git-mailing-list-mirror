Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7DBA0211B3
	for <e@80x24.org>; Fri, 30 Nov 2018 13:32:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726340AbeLAAlV (ORCPT <rfc822;e@80x24.org>);
        Fri, 30 Nov 2018 19:41:21 -0500
Received: from mout.gmx.net ([212.227.17.21]:38135 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726070AbeLAAlV (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 30 Nov 2018 19:41:21 -0500
Received: from [192.168.0.129] ([37.201.193.149]) by mail.gmx.com (mrgmx101
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MFxwA-1ghWUC01Ti-00Ewi5; Fri, 30
 Nov 2018 14:31:58 +0100
Date:   Fri, 30 Nov 2018 14:31:57 +0100 (STD)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     git@vger.kernel.org
Subject: en/rebase-merge-on-sequencer, was Re: What's cooking in git.git (Nov
 2018, #07; Fri, 30)
In-Reply-To: <xmqqva4fj62k.fsf@gitster-ct.c.googlers.com>
Message-ID: <nycvar.QRO.7.76.6.1811301429220.41@tvgsbejvaqbjf.bet>
References: <xmqqva4fj62k.fsf@gitster-ct.c.googlers.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:J3SiJ7ypOSEiFZoYOzWrjnCi+Ufe+ZQ/DVVz2dtgHwXf2Lm1z3+
 6OWmyLsN9vfoejZBTKKO5nHGHUxq/p/Hee2FFjXJWVbCKjlyhkgs04ZF2RUbnAUdAA2W77L
 AU0eWXLvTTQ8+JY6bIv6zpgE/zFNlxbsILPoVPmtXs3MXeBG5MeH3pNi5tC1HDgMpfLz1bK
 XY9dWbq50fNSUv/F/qZjw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:wMMCKjahvL4=:vLoEmc6OxkN3e5toyfp82e
 SN0yxTW35CiepIGSRi7JAb6upvgFGRZMuKAv1mPHDhKMevKgAbS3SGK1pXpoH4MC3TSCO8iG+
 TMDnpH6Clfoq0OnNYg83X4WIgEJBdd67GZJ/gNMIp/vpy1EK853GkwdcHl0vPg34P65LVGgRx
 DBH3bS6nVROMKKjwZSLT9ZrFnYuDC0ch2DT0T3NugijmGbDpzK8MFQ5BwDhnaNGgafJs0GxFk
 U+TzlIllc7vB6fWcbyecRT5A3Y7w8CUbX+3gJ6yoQnV93peTXdr8jYsC/2ovduomM9XLTtOH0
 sGEBM8kS/68FeexwlEYz4U5dxKI9SpJyaWvI0XStj9KV1R60es8bRAANmDJz+1UONv4X5rAHG
 6XNOUIcAr4Djtl6kYQQDYs2dCU93vbo67qad+gkDIfeMhX3bAqdNLQN3HBFu5abpnydwE0jKA
 +uyXh37yqg8IIQqlXZxdm1wvVftPOTxrnQGJo6YC46LoO7Pczj5Dyol5p3lamUHcrCMyi6XbJ
 DasXXXEL4poh/sFzweJT8LlgPNGv9Z98755bF0UlPxNWol3CrM/kQ1FQ2EwdSKu6jakdKqu0E
 8FPcDuPaTap6lwFB3JY24R6Kr8pHnfWMglm91MoHAH91AIBWgttTWnoHIcB+WlJixhiwPz3tR
 sneuVUTruQET9WC0Q29iBAuOx8PFfu6rbvyDvKpk9n5/Y0gCuSKq+ak+O1ck09xcT3QVWMyeB
 LbjO74InsYAY4RyxbtErpuCn/bQZnNZbLx87qrgqIVFnBmkTQjpd4uoD4V14w+NoGzBXSDxvV
 jZ7jgL1yr8tVfQxpjxlQsj2pDR6S45+OKPp00eqoZ3gmH2SiUDdM1+/YJXi4Eha0e1gb0/GyB
 cC60WtK0C5a6VVFZO9ixzhcm6+Rrr3rWjN6ls3sGxe+DZhjtRwFudU3VhhYWsPN4+TT+iyPq1
 IhCXzjOIOkg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Fri, 30 Nov 2018, Junio C Hamano wrote:

> * en/rebase-merge-on-sequencer (2018-11-08) 2 commits
>  - rebase: implement --merge via git-rebase--interactive
>  - git-rebase, sequencer: extend --quiet option for the interactive machinery
> 
>  "git rebase --merge" as been reimplemented by reusing the internal
>  machinery used for "git rebase -i".

I *think* a new iteration has landed (which has 7 instead of 2 commits):
https://public-inbox.org/git/20181122044841.20993-1-newren@gmail.com/

Assuming that the -rc2 work has been interfering, I guess you wanted to
pick that up some time after -rc2 or even after -final?

Ciao,
Dscho
