Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4DB6920437
	for <e@80x24.org>; Fri, 13 Oct 2017 21:12:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752195AbdJMVM3 (ORCPT <rfc822;e@80x24.org>);
        Fri, 13 Oct 2017 17:12:29 -0400
Received: from mout.web.de ([217.72.192.78]:56484 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751509AbdJMVM3 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 13 Oct 2017 17:12:29 -0400
Received: from [192.168.178.36] ([91.20.63.142]) by smtp.web.de (mrweb101
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0MhDYL-1dpjGR3USf-00ML1u; Fri, 13
 Oct 2017 23:12:22 +0200
Subject: Re: [PATCH] sequencer.c: unify error messages
To:     Ralf Thielow <ralf.thielow@gmail.com>, git@vger.kernel.org
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>
References: <20171013175157.13634-1-ralf.thielow@gmail.com>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <58336f0d-366c-6636-1e94-22afbafdfe4c@web.de>
Date:   Fri, 13 Oct 2017 23:12:22 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.4.0
MIME-Version: 1.0
In-Reply-To: <20171013175157.13634-1-ralf.thielow@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K0:imh7YxGUeupZKTD9ALmrqqnq4KCTFLbQGx/4PjOKDPLvZ5cOrsr
 CRQvKBf+C59Q6e2AbZIZILpY43JshwO3L7IQuHOv5bP4Gjxf+AOD/Z5VMG4dhfQcI4OTvkz
 wMi3iu5peC+y9CoU9VkE9OCIpeegRCIcvCGUfvZDYGdY3jjr6TUontJJJPp5vlDUObn9CZu
 SwypmelKCWaE+hLBttOxA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:l3Gvj7MCz84=:oQ+ecs5ewqZ3h2GDlHc4wz
 hHU4Klf3f96/+xI2vb7kkTgZnzsnsJ9Q/sqiM/FKlFDC+rXA8lKd6ar0IR9pxyqLaGC1HMvGZ
 vWpAOmoZJLtefDFV/JHpTlwvyZIH/i1OhTo+9+D/ENyYCtfsFY4ZF9L5MwRa6TZBGeCK89qFw
 WQhDwCj/3Tc1JPPM+8z3AYhdUkMjJtaJzpOvwLbLD3P6g/dfrzgHC5wLXJhV21Z00zso79vPP
 XQKLtEF4xRJkB8VNfUADmBkIJowuR8uDR97Jqbhm+2oXwr0Cs9abeDhbHQJzCUg9W15Im/eEd
 Va0n4CkRA/MMJYoiNMOE0UXxJvP8ti8bxGpOhoZ2yEmJPtiZwAf7Xnnn5DSLUaHU3AQH3Jy5T
 WhAVIS9yMM5SGnXy7tEnm6YSret+EtDRJ7v8CL0ji2iYri8IiU7GVrVeZZN5LIrmFqG+ba8lh
 W74dejS9cH6nzrM032oM+flpB/iKMb0742r/HoWGgMfNmOpXmplldjQjy5Ip1EV8uVCoV83Sz
 DtKKz0tNqPsXYIt6N42HpYQtA+9zwMRp3ArZgwaCeE1IHMm1kjT2DRDIEdxnzn4rdBOaNzppx
 BizTswDwfrrVs5lhaZod0Bn2y4jaTXqZF+YKNTeKnJEwgPSX4bbFi0namjcInLZRJjHgso1dn
 DmywnLxbZNCEG6P8rgXlJYBMC/zp4UgddJJI6+9M/EyF3WhUe6Yqiyv5WL/EIqcvHf5w95fiw
 hshA0A6p7bmNUJBd/DlFDthCHooHdFZ954Qzj7m4JT1qXaLA/IXAg9oZevaaykKl7Not2yBzc
 ppwaPdUmQxjMIcw9cHgpr5F5Yv88Mzx0aet0jg16D+E+ngIwQo=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 13.10.2017 um 19:51 schrieb Ralf Thielow:
> When ftruncate() in rearrange_squash() fails, we write
> that we couldn't finish the operation on the todo file.
> It is more accurate to write that we couldn't truncate
> as we do in other calls of ftruncate().

Would it make sense to factor out rewriting the to-do file to avoid
code duplication in the first place?

> While at there, remove a full stop in another error message.
> 
> Signed-off-by: Ralf Thielow <ralf.thielow@gmail.com>
> ---
>   sequencer.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/sequencer.c b/sequencer.c
> index e258bb646..b0e6459a5 100644
> --- a/sequencer.c
> +++ b/sequencer.c
> @@ -2948,9 +2948,9 @@ int rearrange_squash(void)
>   		if (fd < 0)
>   			res = error_errno(_("could not open '%s'"), todo_file);
>   		else if (write(fd, buf.buf, buf.len) < 0)
> -			res = error_errno(_("could not read '%s'."), todo_file);
> +			res = error_errno(_("could not read '%s'"), todo_file);
                                                       ^^^^
That should read "write", right?

>   		else if (ftruncate(fd, buf.len) < 0)
> -			res = error_errno(_("could not finish '%s'"),
> +			res = error_errno(_("could not truncate '%s'"),
>   					   todo_file);

Hmm, why call ftruncate(2) instead of opening the file with O_TRUNC?

>   		close(fd);
>   		strbuf_release(&buf);
> 
