Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9120120209
	for <e@80x24.org>; Sat,  1 Jul 2017 12:49:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751826AbdGAMto (ORCPT <rfc822;e@80x24.org>);
        Sat, 1 Jul 2017 08:49:44 -0400
Received: from mout.web.de ([212.227.17.12]:55191 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751805AbdGAMtn (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 1 Jul 2017 08:49:43 -0400
Received: from [192.168.209.79] ([195.198.252.176]) by smtp.web.de (mrweb102
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0MKrPw-1dRHqB3d68-0005Za; Sat, 01
 Jul 2017 14:49:35 +0200
Subject: Re: [PATCH] status: suppress additional warning output in plumbing
 modes
To:     Stefan Beller <sbeller@google.com>, s_shestakov@playrix.com,
        kostix+git@007spb.ru, Matthieu.Moy@grenoble-inp.fr
Cc:     git@vger.kernel.org
References: <70c9a162-ac2f-c347-d13b-f24ac24d1133@web.de>
 <20170630162826.27711-1-sbeller@google.com>
From:   =?UTF-8?Q?Torsten_B=c3=b6gershausen?= <tboegi@web.de>
Message-ID: <d401dcc7-cb4c-e895-e52a-cd54c8130a65@web.de>
Date:   Sat, 1 Jul 2017 14:49:29 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.11; rv:52.0)
 Gecko/20100101 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <20170630162826.27711-1-sbeller@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K0:GoU4Sczb/mD85NdqH20qV7s+99poUwb8M2jmc2e/sb2eA0i0bLr
 IiRu6X71czUidT2A8wiMyZ+rEUx4+IUrZhQMoCbC7faR9L392RjjO/OlA4FX1zxy4Ww4akR
 diKYsrzXv1ic+zLdE31E/j+4HHiASEa2Nz8Q5TAJw8vKXhuhAuNutB0rne/kwbZln+crMhe
 eSo9GrvOCjmEh1uA5KswA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:Fi1/rCEgdkg=:FchsfWA7THesvEBR9Jx68n
 Ch6A90ECOwC8LAAtCkWGYU8KlltLtJ3Yan05VGyDCGoaVEox8Tk2pJI0sc16ZDKY46wTLHiGF
 SqlgfXiqj3rQV4gqFtzEz4nNfiXee1ukFVyQWjSmHpIXiyX5ifM2YofAk350jP1kS/qP1Q9ER
 DRb7BR2a20FeyXR4fGqp8GJrFI+i9abXtPMUpCAhcqtKVrAph36AjG0fXVg1z0wFAvcPMlPu6
 lhGzQMeeyBtOr4g0E2z3c0hz3YdnlujAw4HVrD8aw9k4hvczUvHCkGjWLBJm3iP9fRAXyaM7i
 acbMghTD/KzWYjAExYbHsruG3V+iFb/tXwQgm8Qwa7vU+lrLbPX0/ARZDZnqGX9GbRzKo+nTN
 nyogJtBVUbXNcEBErS2DVeq3oD2eRyAy6VYE/SdlVyYcgQHusfeXPF7SM8Ft1idLipLVGPiyZ
 6VaTgw8fP4uLJa/269Z1N1fU5VKAsE7/glrRQAQimb7u+Ds1Uc9WWsZW3dQ7QaMzWKMlZFilf
 wv9DczH8M6F11Bpz9hgSrNRulTMJKnZL8DVfvuAD6F7/TFifNF1TAlzB0DaipIRxzBCIaGW2y
 A3V5GTMj6Ajp1aDWphYTdYkEJIcP3h0/E3uvGSopRs104Hp7tQhEj9SOjT06xAWo0kC13IVam
 /DBDbFsC7WSk4zzMzrpxaFXvK8of+rpCU2zZUoheEkvhVsaRULSfNC03ihOEi44qcqSJ9i5vx
 sQuCzEthcpvb7GlF/Knn+t0Au2V2lf7G18ZZgdwv7HZJd7O7N40aMEr9EGwc98dCRKWil9wCh
 qsOuk1V
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



 >On 30/06/17 18:28, Stefan Beller wrote:

The patch makes a lot of sense - thanks for the fast reply.
A question: does the header correspond to the patch ?

< [PATCH] status: suppress additional warning output in plumbing modes
 > [PATCH] status: suppress CRLF warnings in porcelain modes

(And may be the comment in the code:)

< / * suppress all additional output in porcelain mode */
 > / * suppress CRLF conversion warnings in porcelain mode */

> When status is called with '--porcelain' (as implied by '-z'), we promise
> to output only messages as described in the man page.
> 
> Suppress CRLF warnings.
> 
> Signed-off-by: Stefan Beller <sbeller@google.com>
> ---
> 
> Maybe something like this?
> 
>   builtin/commit.c | 5 +++++
>   1 file changed, 5 insertions(+)
> 
> diff --git a/builtin/commit.c b/builtin/commit.c
> index 00a01f07c3..3705d5ec6f 100644
> --- a/builtin/commit.c
> +++ b/builtin/commit.c
> @@ -1126,6 +1126,11 @@ static void finalize_deferred_config(struct wt_status *s)
>   			die(_("--long and -z are incompatible"));
>   	}
>   
> +	/* suppress all additional output in porcelain mode */
> +	if (status_format == STATUS_FORMAT_PORCELAIN ||
> +	    status_format == STATUS_FORMAT_PORCELAIN_V2)
> +		safe_crlf = SAFE_CRLF_FALSE;
> +
>   	if (use_deferred_config && status_format == STATUS_FORMAT_UNSPECIFIED)
>   		status_format = status_deferred_config.status_format;
>   	if (status_format == STATUS_FORMAT_UNSPECIFIED)
> 
