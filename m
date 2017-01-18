Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C346E1F89C
	for <e@80x24.org>; Wed, 18 Jan 2017 12:14:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751949AbdARMOL (ORCPT <rfc822;e@80x24.org>);
        Wed, 18 Jan 2017 07:14:11 -0500
Received: from mout.gmx.net ([212.227.17.20]:58685 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751649AbdARMOK (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 Jan 2017 07:14:10 -0500
Received: from virtualbox ([37.24.141.236]) by mail.gmx.com (mrgmx102
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0M0bo2-1chdNR3X9q-00usWT; Wed, 18
 Jan 2017 13:13:51 +0100
Date:   Wed, 18 Jan 2017 13:13:49 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Jeff Hostetler <jeffhost@microsoft.com>,
        Junio C Hamano <gitster@pobox.com>,
        Pranit Bauva <pranit.bauva@gmail.com>,
        Johannes Sixt <j6t@kdbg.org>, Beat Bolli <dev+git@drbeat.li>
Subject: Re: [PATCH v3 3/3] mingw: replace isatty() hack
In-Reply-To: <2ce6060b891f8313cc63a95a9cba9064b7f82eb8.1482448531.git.johannes.schindelin@gmx.de>
Message-ID: <alpine.DEB.2.20.1701181304490.3469@virtualbox>
References: <cover.1482426497.git.johannes.schindelin@gmx.de> <cover.1482448531.git.johannes.schindelin@gmx.de> <2ce6060b891f8313cc63a95a9cba9064b7f82eb8.1482448531.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:wyboQ8I8ouvdfqdWpgAWaW2Uy05AqDjdk4QvOLk6s1Es+hZIwNN
 ECHW3P588myYd88SDQ2urp6jqjLrM+OZ75SXD7govUEJiqzTelvY03wvFOzfBfDHw9GUQnI
 sT1xs37puQl2tveKzOOGHOGACEkw0h1rMyaThoWh2fSD30U8ZSJfaLm27cFMrBDHnmuSbcU
 r0J5jN7ZJ5Et4JH0Ro9Pg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:61WH/BBxyN0=:BWCiBdfmPy19C97XX3FPZY
 yBhQfEsiael5ex/Rb+gHJOHjxB7YVMYmH/jwClIDOS97BbKAJa7a65XpjkYAWSbGJIFYuQuaC
 nS8VCxNkRAPqKepCTog2a6YmgZkj69p9krJ5GGhqouf5okaCvmQCSfGFD8UbOngv/2Be0f+Dr
 dEGlCn6MneLfcB1y7KvKlW+uc+t8bg2wHzNo4lPWsF/S5KN3PyNuilZAWRk3vA7M/nwtxlZNn
 /ZoqGD2fkFhLFIS/ydk6ciQWSfnjTRekNZuXksQpOBhRu4YKqGX16oTJCC3/QnjvU+RZiSYmq
 b2N2S0bkINdwPZ07R6kVocBUDabBDWhEt0rjsiBj03NIynOx+DjEKUBuDBiTCEBChNMpYEPIr
 5uStap9Md1sUxDQhAMdzWOQ7Zzu1D1+N7SKMlMgni1RsmmqMsWeCT0k6xITubnxKkP8h3AARF
 2nl13CJgWlVRfB8UHTbG1K2PAQctq1bzG8rqX0MaHH7SeDQx3oGj8md0gJ7u+7l/Ux/d9MkbZ
 3HwIH1P3moZ0Lj93a5YrHxw1KzalKgd+u2tdQCFGRmj5j/HtWafsl12FIRRzYZ9RbEt1TdI/6
 xzJ+mwOFh2cLc6wuCuCIA7RQzhyn8g9mV4ZtMeeJdWF2jSvPcJyEDoKe90dfNm6NPQ/gcMazE
 gm///AW+qZ14zDsuU4p8azKFSvTBKgvAfE9Y9hSIqyWebZM31zIhwY+sCWZNNy8Sc+5SHpv9g
 JBkWf+0f4W94ltw1WqGs2usiLC1+JhbLrq2TGpJ5wYZdab4vPrVhWO3CIwS1MCJg18dW5CYiK
 I9z0Q5A
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

On Fri, 23 Dec 2016, Johannes Schindelin wrote:

> +	/*
> +	 * Use stock dup2() to re-bind fd to the new handle.  Note that
> +	 * this will implicitly close(1) and close both fd=1 and the
> +	 * originally associated handle.  It will open a new fd=1 and
> +	 * call DuplicateHandle() on the handle associated with new_fd.
> +	 * It is because of this implicit close() that we created the
> +	 * copy of the original.
> +	 *
> +	 * Note that we need to update the cached console handle to the
> +	 * duplicated one because the dup2() call will implicitly close
> +	 * the original one.
> +	 *
> +	 * Note that dup2() when given target := {0,1,2} will also
> +	 * call SetStdHandle(), so we don't need to worry about that.
> +	 */
> +	if (console == handle)
> +		console = duplicate;
> +	dup2(new_fd, fd);

Sadly, v2 was applied to `maint` instead of this revision, so Hannes'
suggestions that I addressed in v3 were dropped silently.

I will send out a follow-up patch in a moment.

Ciao,
Johannes
