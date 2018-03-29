Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1E49A1F404
	for <e@80x24.org>; Thu, 29 Mar 2018 15:03:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752173AbeC2PDN (ORCPT <rfc822;e@80x24.org>);
        Thu, 29 Mar 2018 11:03:13 -0400
Received: from mout.gmx.net ([212.227.17.21]:36839 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752131AbeC2PDM (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 29 Mar 2018 11:03:12 -0400
Received: from [192.168.0.129] ([37.201.195.115]) by mail.gmx.com (mrgmx102
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0LqF9o-1eO7fJ3Jp2-00djaK; Thu, 29
 Mar 2018 17:03:09 +0200
Date:   Thu, 29 Mar 2018 17:03:08 +0200 (DST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@dscho.gitforwindows.org
To:     Loganaden Velvindron <logan@hackers.mu>
cc:     git@vger.kernel.org
Subject: Re: [PATCH v4] Allow use of TLS 1.3
In-Reply-To: <20180329101418.GA7736@voidlinux>
Message-ID: <nycvar.QRO.7.76.6.1803291702580.5026@qfpub.tvgsbejvaqbjf.bet>
References: <20180329101418.GA7736@voidlinux>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:IwZKtYxCYexyXBLdRZqorQN9MPA+RB49s2QYwX+qJdJY/OUbVny
 dSdogFKZKofHkCZgWYyDL9VisAcC/1VTtdkYJSDbDK7ksJSVbeI3N/HVeyjuVgsZvvjwZPJ
 ecQ1lV3cuFyuoaz1E1e8XQu4SORz8diVFV/lNHZZvTIN3+zboEhmWRPyxPUKCkHMPLFrXm5
 YXC6xjrY1BWIj2GzLhcag==
X-UI-Out-Filterresults: notjunk:1;V01:K0:dxaoDLQlAMc=:YpOF3EKVM+ge86flnoz10C
 vm/Hmo68wPFqPtJ0pDvvF2i5bKZJDWfmFOlFYuajOKjK7xoKmsPB7VLL94h26geUeMzqTUM5P
 OHdDiQpaa03zEaQlcC691qQbROnSvKSEEFJcUXZxnlQqTFn5t2Jd3D0JYWammFR2OOrIZYAUl
 0by6BiE3xk9W1Fjy9CLc2h+VyE9KwbK7RTxFyQ6ScGh0f/dA+oaLWVYswo6m5NDd/cKji5Tza
 en6+i0pMkJWEcAcyDnRh3rUaxBAkM4z85jSg0Rts5UoX5juEGoF3ZAFO1bMSAQi4Az1hf/uZq
 LKCQEfu3+pBlskUhEZLceYtmNjVF5bhujvJCqzDsBjVeseu/6CUNsL64IbRnv4RtV8ZqdN5AL
 jAQiKXV62Ba97EuJKNtfKRHpPwqQZq5ZqRh2bg8dhrKA3n8WEc5Fp1nkiPhYDWRPQvZuBY6Ol
 r3YK8i6opa4a70uhyx+XvjSrtrwe+KsX7XYDgjzqETNngG8nn9E0EFuTH6N4hrRJ2w3gxtoVG
 0rHpPEcj7VY7IBNP2AzUAIuBxknTSpQyscqzINGXg46+452hsKiFKuY0IyqMCPxfCvApT7+yk
 Ud66dXOHo1hfZ9P1hkSKJGcpwsplvM0GL8j6qlbH6JuFwpKfetmU2dwI5wgqQvTJq6vbVasQC
 BVdI+3vHTrWdzaXShrh0HqxAEEl+W0Gm2ua86FtJ/syumDg5QLGKFALI1i2K3vkezVnaigO/r
 zlZ5HrABVTR9h5ct8wVvmdZyVuu9xODsWGBwht3PRxsZAkv+zxvN7Q/d6Gp3htKmJ5v/AShOA
 YhezD57D0F1lXde5inV3WxUlKVKAaN8xH2dnIIS/4RK0yAPcp4GPsZ6aK0FmQ+mJpymLllw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Logan,

On Thu, 29 Mar 2018, Loganaden Velvindron wrote:

> Add a tlsv1.3 option to http.sslVersion in addition to the existing
> tlsv1.[012] options. libcurl has supported this since 7.52.0.
> 
> This requires OpenSSL 1.1.1 with TLS 1.3 enabled or curl built with
> recent versions of NSS or BoringSSL as the TLS backend.

Thank you,
Johannes
