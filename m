Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 54B1D1F462
	for <e@80x24.org>; Tue, 28 May 2019 18:07:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727707AbfE1SHN (ORCPT <rfc822;e@80x24.org>);
        Tue, 28 May 2019 14:07:13 -0400
Received: from mout.gmx.net ([212.227.15.15]:43509 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726576AbfE1SHN (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 May 2019 14:07:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1559066818;
        bh=nddLeh192UtOMZshHcI2XCluuroj8+kckfXLTN0V0sY=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=MGovoT3W1R/G1Uib6cinj94IUDqzjoP2pzw3y8hpFUsg0xf1d6J/dlzgb+Kr1sR9S
         OHHfGZLUbFmz02Jy8XGKSQY2y4iQQ+bTDxjTxuBpZE8MYc2FKvIHGqMVpVp6cUagVm
         2Z+16Y9N/V7WRKKP/VWf0+BPDgXgYUoRD6HjNoTk=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.129] ([37.201.192.51]) by mail.gmx.com (mrgmx003
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0MIuSH-1hTCax15b7-002WfW; Tue, 28
 May 2019 20:06:58 +0200
Date:   Tue, 28 May 2019 20:06:42 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Philip Oakley <philipoakley@iee.org>
cc:     Jeff Hostetler <git@jeffhostetler.com>,
        GitList <git@vger.kernel.org>
Subject: Re: [PATCH] compat/vcbuild/README: clean/update 'vcpkg' env for
 Visual Studio updates
In-Reply-To: <dbf74f4d-b63c-53f2-dbce-009da34d1050@iee.org>
Message-ID: <nycvar.QRO.7.76.6.1905282004420.44@tvgsbejvaqbjf.bet>
References: <20190528120846.1056-1-philipoakley@iee.org> <a48d5f62-081a-de14-5dbb-4726908a4179@jeffhostetler.com> <dbf74f4d-b63c-53f2-dbce-009da34d1050@iee.org>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:6vWfQz3IJjzMsG08fgA4FDC6/dtnpuiVp6GuGpLHtr3aEv3beUy
 q8Qi/Z9UYpq9ct0fM1LqqSBjLeMRUB1zgXtjP5JKQjyaaWJadFUBOXbT5jM2EPHWw7Ma+fU
 8P9o1jcu9aa+EzQteYpAYy0IqDSIeKfPFZYkThH9qrAzr11c8xlDt2H7WlHliMGQT+BXnz7
 F4Onc7wUMloyZ91sHYUJw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:cfBMeXnCIpM=:GVPE21kfLcr6yXmWmmuB6m
 xJmf1H651w8fqVb+1w5/EGxoitoF8Tqzyg68+u6tiwphbimqmxGsN+3n1q6OrVeFkfI2c8z40
 uAx1razD21i7HBeaQFZ4RZNEiiA5kU2Q1lfSZWk2Jx7p1JuWuvzbu/1wmMdnCUl8XKDRMzeNP
 dFErb3884arsIu2snwa8jleHbAXf62pYCz8It6ytYqJ6VjANRX0bpQwQIrV9cavZBRkTcBt0I
 jzr+pqH5gfj8aEXbmiU0evH6EjJnxoALDjtm/5oKnC2kthwHKFw/QJdmz779S+EX//yZlPo3z
 mO78qWdYxGROwM6n4GbkIbuA3cCQjt6uxHRgJnzYX5w/3P+Snbo6LTMY7V79knkWP87gLQGVQ
 TAhtVkUjv/tdfcdx19CLShQxEfgChvVc1Xx0dxyc7ZNhYwrhQ207e579jV0+LeS3I1km/q5jc
 NIlIwjMPElYTVvp9ZO9BbVEJB4Ed4JD7ERJEa3t1XXs1dIqFD74QqNJ4vfY9AxYBPCCBFru+K
 PtfYnawsyLkAwVNO1rKqcd2uAjiS9PbgXzR1Unip+MWOprw/7w6iCXeVlClZDLbL2sEUQT6ST
 kGvi6ZEScFHJfqLqcmNtyEpKM6PGJVdlnFJUhAPKN63EHf9mmGERHaZRyfNlEHTL6si08yWYU
 LHIdcO7sCWfNjBmV5+rmCHPaw011u9l5hbTLX4MlTINubc1sfoOUtEmF3BI0ELyQwO3kFPwkT
 D1d314xmVTK8ScBGoUjhppn/dGkPH2VTXQ0otUyo9vTmFYMmK40DzBqBOeuNgCWMmgxj1NM2Q
 d86fYX1k7THbmaBEP4zURScaSZaoYJ3XG4sqcggBOUKfuhuPnptO+WZ6riILSb/MtUmcXQkPu
 qLmGfWz4e7dtCPrt0mzjXZyASTFy6j/TstWSqd/47CPErc0vSHH6t3eSuYo6ItGE17IAjWgEb
 S/JU/AU1cXffIDyGF4G/Qr39NZkAMUQb0CZaXTxzn97zoCiBY3KFc
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Philip,

On Tue, 28 May 2019, Philip Oakley wrote:

> On 28/05/2019 14:56, Jeff Hostetler wrote:
>
> > Did you mean to send this upstream or to Git for Windows?
> >
> > I didn't think that the VS2015/VS2017 vcpkg-aware version of
> > compat/vcbuild/* had made it upstream yet, so this patch might not
> > apply upstream.
>
> Ah, that would be my mistake.

An understandable one, as I had originally planned on trying to get the
MSVC/Visual Studio patches into git.git after the v2.21.0 release.

However, I deemed the built-in `add -p` a bit more pressing, as it
directly affects my workflow, and the MSVC patches already made it into
Git for Windows (and are continuously tested by our Azure Pipeline).

My current plan is to "upstream" the MSVC patches directly after v2.22.0
is out.

Ciao,
Dscho
