Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AA4121F453
	for <e@80x24.org>; Tue,  5 Feb 2019 11:26:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728708AbfBEL0a (ORCPT <rfc822;e@80x24.org>);
        Tue, 5 Feb 2019 06:26:30 -0500
Received: from mout.gmx.net ([212.227.17.22]:37585 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727385AbfBEL0a (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Feb 2019 06:26:30 -0500
Received: from [192.168.0.129] ([37.201.193.149]) by mail.gmx.com (mrgmx103
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0M0hT0-1h86mD47mo-00ur7Z; Tue, 05
 Feb 2019 12:26:20 +0100
Date:   Tue, 5 Feb 2019 12:26:22 +0100 (STD)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Ramsay Jones <ramsay@ramsayjones.plus.com>
cc:     Junio C Hamano <gitster@pobox.com>,
        GIT Mailing-list <git@vger.kernel.org>,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: [PATCH v2 1/2] config.mak.uname: remove obsolete SPARSE_FLAGS
 setting
In-Reply-To: <41d4bf8a-dea9-5ccd-9fad-e4604017661d@ramsayjones.plus.com>
Message-ID: <nycvar.QRO.7.76.6.1902051226130.41@tvgsbejvaqbjf.bet>
References: <41d4bf8a-dea9-5ccd-9fad-e4604017661d@ramsayjones.plus.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:QwO1SQX2Fp/9gGjf567Fe/+GgqQG8juRk9gbc7rRBY94S4nmeUk
 SlD+eiswNqKUjA8MPJT4w/i+6Qwu7T3HgvbWw04pxpwTpW7L0XGP1+Fn147WzFq6JzUytlr
 VpW0aUajfxhxlyHwORf8Ee0lRVYY5B4QS8dVpD8dO/8w+I1NqtnuIGjpVMjT+9TmbQtGbBh
 rt3XUyjlzNarmp+/An5dA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:4eMUj94Md8M=:GYeFo5g9IFNLybbQAIBUss
 c7tgHYp7SemPMhrofxOp2+/PC9F3Ap2nOdO/YY5wXp9NUmVK+ls/x+4vAud1CZ6eLZ/y9SAuQ
 pj9XVfB3eBJbqMkLan3ZSYRPVf55HR7KfwBkSr0OL63CDXD3AN75XQfYT7NzV4EWxDEDef+JX
 208SiI71oc2nfSHQatzLixRebfCbYMBEmtp0s81xGtrom2k2GW/x4X3Mx1l4iGtLH1quI0ZWA
 HbyXvA6DJUmFfwxZaM/Z75w6WaVMv4yxuQaVfi39O7nHKGnqjjv2iAsVHEJB0HYiISJ82hHxb
 mjhgeYd0OIUNuKAYliAbKL7s0izTr62NLeudoo55vXvqLuET19PsaQnko7ohq1PQpTcZWxhqY
 XTsz8GT6wOUyZ2usoo64eXhrMiDr1I0sHKBwVRQOCOyn+AqQ90nvSx62c+qeaU6g5plI/UdSK
 4O1/hIK7e8bMeAaObakQbsOlrt6/2B1qcOwWZ0VgCBnSYMWUKu9pVJnTgAeHXsbUUvSO4rphE
 dMWJgl5KgOawEzSh7MDgWLyg59AeR1MqGFd3uTBPFksSjfvkZlmJaeJQ1c6TFmZgcCCWxiC95
 94FZaCuozKv7/8spDkUvvxJ/zNGUKVGg5UJe0Cg/K+omz98Zx3CSL9Y7fZXcAXP0xyJaK2325
 EF3UYT1UWTXuLkPgqwbhRotQWmmME+ICKr048JiaMrgbe0GBIB6Q0LQZpuzIQRfzNaQkg7EKy
 z1jcyiPcPh3gEG/ZHpm3x2JuP4jRrmFqo6QpZH6oam9yDaKG+AMw6s5RMDILsRKAZVzfl+XJx
 Fx7r7kcq2Cog5Av63fS47eli14ymw8a5wDgPF89RjWfduwC0t6oN4zGLo+8TCFwFecJg4JvaH
 uxA2QJIqgbgbx8ZzZsAmqtrCe2JMquU61iZkRyj5cJrGfzdfvs/3s5OO1dgCER956AFozVy4U
 wKbtZXUNXOA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Ramsay,

On Tue, 5 Feb 2019, Ramsay Jones wrote:

> 
> An upcoming commit will change the semantics of the SPARSE_FLAGS
> variable from an internal to a user only customisation variable.
> The MinGW configuration section contains an obsolete setting for
> this variable which was used (some years ago) to cater to an error
> in the Win32 system header files. Since 'sparse' does not currently
> support the MinGW platform, nobody on that platform can be relying
> on this setting today. Remove this use of the SPARSE_FLAGS variable.

ACK,
Dscho

> 
> Signed-off-by: Ramsay Jones <ramsay@ramsayjones.plus.com>
> ---
>  config.mak.uname | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/config.mak.uname b/config.mak.uname
> index 7b36a1dfe7..786bb2f913 100644
> --- a/config.mak.uname
> +++ b/config.mak.uname
> @@ -555,7 +555,6 @@ ifneq (,$(findstring MINGW,$(uname_S)))
>  	RC = windres -O coff
>  	NATIVE_CRLF = YesPlease
>  	X = .exe
> -	SPARSE_FLAGS = -Wno-one-bit-signed-bitfield
>  ifneq (,$(wildcard ../THIS_IS_MSYSGIT))
>  	htmldir = doc/git/html/
>  	prefix =
> -- 
> 2.20.0
> 
