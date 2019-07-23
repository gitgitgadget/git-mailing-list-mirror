Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MALFORMED_FREEMAIL,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 548121F461
	for <e@80x24.org>; Tue, 23 Jul 2019 19:19:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731962AbfGWTT1 (ORCPT <rfc822;e@80x24.org>);
        Tue, 23 Jul 2019 15:19:27 -0400
Received: from mout.gmx.net ([212.227.17.20]:46223 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728437AbfGWTT0 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Jul 2019 15:19:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1563909558;
        bh=w+QW95gAcrEHSqlnzj0cmT+aFX2XNLXVScyGTu5PGag=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=Av59lIyyPzA78PYTHYI6QAqz1fteEZsynmdJ89l1bQxmn8ixm2nHTNevfDYl8oa9o
         sslQNV440abUU7gqfMFZibsAhCWCJ79X/wC4tuwzgDQ7tTp1besobNHa8McfvPTItj
         Q+ixr9eh0naEivi9S9cS5x/7Pm951QKUt0CP/QgQ=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.213] ([37.201.192.51]) by mail.gmx.com (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1M1ps8-1hsCB40ccy-002G5U; Tue, 23
 Jul 2019 21:19:18 +0200
Date:   Tue, 23 Jul 2019 21:19:16 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Beat Bolli <dev+git@drbeat.li>
cc:     git@vger.kernel.org, gitster@pobox.com
Subject: Re: [PATCH] grep: print the pcre2_jit_on value
In-Reply-To: <20190722181923.21572-1-dev+git@drbeat.li>
Message-ID: <nycvar.QRO.7.76.6.1907232118460.21907@tvgsbejvaqbjf.bet>
References: <20190722181923.21572-1-dev+git@drbeat.li>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:jgbIzNC4dTKbw756kkwHrGvJogEEhHJ4y1ZIcxAjcrHfFYY2osz
 7M6nWSaYCAkbb42CgH7YCt+QQl0S7nCyrgioZ3BcYiXn8Fb1DOFZb3KOyhe7UQ7W2N+5pO5
 lQ6ZnyBUKqn9sVbbGQkwICxSU9S9pi5KPhzziugGyHW1VOPlEnCzwkLxjp7VdvQHmwXznn/
 nKYK2gDZOQsBlWG7Gx6lA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:mpNzTMzeQEg=:6a9qTmse0Z06+YP8I8qmL7
 FTs99WE5XCcsHekvz0mpzxv6irzlDUH9EafucOP6DMxhge6BONm1TisYP8shaaGot5ZcVsrRH
 QiQK+3jRK9k3XJPj7ci0VBDjcnlZvWvhDAdw8O6RD8p4s3uv0bkpGcPzTtaTh5GrCiBjpZ3qU
 IWsSMZ1GgQNZvOn6VQ3Y8Fo4BHJ8OT/nOjYTKgD0+a86HhAOC/wywa+7u8doAZVX72CLg12Wi
 gk2TqpjEAEAFZeT2OPqe8UkSC3pxKeP10k+2LdOFnfyf7PDJO95jCadTmq9uPEC17pZ/K1yPp
 GO6SZG1khS7SkQO0BpC43p3R0xvtYKKYBogJXpMzNE5ZK2xtSLtzQynHZQ9j+ePYgup0d5egb
 XAZJyHXsEZHdYz5Mgczaj2WvSjsBncg5nLpPbaM293uzFycslFgX/brgCDSxo3mjwdp/teRV6
 lzkh2RCLAnHz/wBPX0yGOzwEQ4lf8V1PSTEPGnDLmCDecAvQ1Jwjje43JgxeAUCvOgqTaEKrU
 2DbE/wY+5WboR+FypgO9V7Tm7qhLac++O6tqDhWUxP3oX8H6vTKNxXf0SRDAJjH0OcYw5wpYR
 /4PahvradSijFglcywJCcOiTdUjuRlZUn+F1RiPvmEIrpbLB3pdUGDTBMP8UydicBwspmlMoG
 7wT81YDuIpGoH3t2pjfxcLVza+49QH6qwaG3rkyl9oRiGX8LyxKp5M3k+0u9hFF+hTACECDsn
 5mcKG6OCewu9Z9y2+ktYq7tipjMQmQ973fzGTK2188iN0jAfdrXi2aFtn+bnX81z9jehnL2+D
 sBRvs8/aH2a50PkLnaAfew1BztnMaDiD9nz+19JxTGUSwFXKeVO4sk2QwNH3Bw46FPlpLu8Oq
 fRkbU0qx+8y0eTdcMCo9wwIDU/wetHU4lQRRfm5DJVvFLZtCRXzqhpGRC/RuUgrQfgP5Zl7Bi
 bXpVpejSp76ZinLh569SjNvNQeP86EbljoW/oGj0O/GGAtMCMckm687yxOo0CsGdEqPW4x8zr
 zfCpOpMRAz82vTf1J+vuk2hbDVX9iH00SRUclMQ1rQEQBaEfvp5zFwaQX4YAzrnqct76i6mR7
 zTcfFyhZVAqs0cBd/2j+P2Q/dqh2oIClC5R
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Beat,

On Mon, 22 Jul 2019, Beat Bolli wrote:

> When pcre2_jit_on is neither 1 nor 0, the BUG() call printed the value
> of pcre1_jit_on.
>
> Print the value of pcre2_jit_on instead.
>
> Signed-off-by: Beat Bolli <dev+git@drbeat.li>
> ---
>  grep.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/grep.c b/grep.c
> index f7c3a5803e..cd952ef5d3 100644
> --- a/grep.c
> +++ b/grep.c
> @@ -559,7 +559,7 @@ static void compile_pcre2_pattern(struct grep_pat *p=
, const struct grep_opt *opt
>  		pcre2_jit_stack_assign(p->pcre2_match_context, NULL, p->pcre2_jit_sta=
ck);
>  	} else if (p->pcre2_jit_on !=3D 0) {
>  		BUG("The pcre2_jit_on variable should be 0 or 1, not %d",
> -		    p->pcre1_jit_on);
> +		    p->pcre2_jit_on);

Seems obviously good.

Maybe while you're in the vicinity, you can add that information to the
`--debug` output?

Thanks,
Dscho

>  	}
>  }
>
> --
> 2.21.0.1020.gf2820cf01a
>
>
