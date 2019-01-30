Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2B8161F453
	for <e@80x24.org>; Wed, 30 Jan 2019 19:06:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733275AbfA3TGO (ORCPT <rfc822;e@80x24.org>);
        Wed, 30 Jan 2019 14:06:14 -0500
Received: from mut-mta1-se01a-zose1-rescue-fr.yulpa.io ([185.49.21.247]:41258
        "EHLO mut-mta1-se01a-zose1-rescue-fr.yulpa.io" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1733109AbfA3TGO (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 30 Jan 2019 14:06:14 -0500
X-Greylist: delayed 2594 seconds by postgrey-1.27 at vger.kernel.org; Wed, 30 Jan 2019 14:06:13 EST
Received: from mut-zose1-mta-hub-out01-fr.yulpa.io ([185.49.20.54] helo=mut-zose1-mta-hub-outweb01a-fr.yulpa.io)
        by mut-mta1-se01c-fr.yulpa.io with esmtps (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89)
        (envelope-from <matthieu.moy@matthieu-moy.fr>)
        id 1gouVg-000074-Vu; Wed, 30 Jan 2019 19:22:54 +0100
Received: from localhost (localhost [127.0.0.1])
        by mut-zose1-mta-hub-outweb01a-fr.yulpa.io (Postfix) with ESMTP id 02F42C1F35;
        Wed, 30 Jan 2019 19:22:51 +0100 (CET)
Received: from mut-zose1-mta-hub-outweb01a-fr.yulpa.io ([127.0.0.1])
        by localhost (mut-zose1-mta-hub-outweb01a-fr.yulpa.io [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id Zanh2R8uURAO; Wed, 30 Jan 2019 19:22:50 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by mut-zose1-mta-hub-outweb01a-fr.yulpa.io (Postfix) with ESMTP id 71EF3C20AC;
        Wed, 30 Jan 2019 19:22:50 +0100 (CET)
X-Virus-Scanned: amavisd-new at mut-zose1.yulpa.io
Received: from mut-zose1-mta-hub-outweb01a-fr.yulpa.io ([127.0.0.1])
        by localhost (mut-zose1-mta-hub-outweb01a-fr.yulpa.io [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id hv9u0lF8tvm5; Wed, 30 Jan 2019 19:22:50 +0100 (CET)
Received: from zose-store11.web4all.fr (zose-store11.web4all.fr [10.101.13.41])
        by mut-zose1-mta-hub-outweb01a-fr.yulpa.io (Postfix) with ESMTP id 498F9C1F35;
        Wed, 30 Jan 2019 19:22:50 +0100 (CET)
Date:   Wed, 30 Jan 2019 19:22:49 +0100 (CET)
From:   Matthieu Moy <git@matthieu-moy.fr>
To:     Roland Hieber <rhi@pengutronix.de>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Michael Haggerty <mhagger@alum.mit.edu>,
        Junio C Hamano <gitster@pobox.com>,
        Stefan Beller <stefanbeller@gmail.com>
Message-ID: <361643257.4118832.1548872569575.JavaMail.zimbra@matthieu-moy.fr>
In-Reply-To: <20190130144744.3248-1-rhi@pengutronix.de>
References: <20190130144744.3248-1-rhi@pengutronix.de>
Subject: Re: [PATCH] reflog: specify default pretty format in config
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Mailer: Zimbra 8.8.9_GA_3019 (ZimbraWebClient - FF64 (Linux)/8.8.9_GA_3019)
Thread-Topic: reflog: specify default pretty format in config
Thread-Index: DxJQEZwFa8JVbzcFAjwtB3UHJr3m4Q==
X-Originating-IP: 185.49.20.54
X-yulPa-Domain: mut-zose1.yulpa.io
X-yulPa-Username: 185.49.20.54
Authentication-Results: yulpa.io; auth=pass smtp.auth=185.49.20.54@mut-zose1.yulpa.io
X-yulPa-Outgoing-Class: ham
X-yulPa-Outgoing-Evidence: Combined (0.05)
X-Recommended-Action: accept
X-Filter-ID: EX5BVjFpneJeBchSMxfU5lOMEQZOR9YwrOkrPHtAgXt602E9L7XzfQH6nu9C/Fh9KJzpNe6xgvOx
 q3u0UDjvO971bSIN96NVv+IMZVam7SAWyseYcfH3v3iL4NvmtsB9TspD0gc4DUAkaLpanL8z4geM
 taMqExZvOhAgRMkwT5h1YlYo5Q9glUEb+8mZGTbmM+r198TnQQui2ak+CdgezoXqLKgBjkrvntGV
 Q6O0bSciXmvEIdRxC+YDnGz/Atg2CrHu4uxwKWvNtUWboSFA7STg127TqHZDxA/kZB41Rh//I6dV
 M9aCE3XwJtDzHS3TIi1Z2mQbKVoZ2bKIX/6KOEb8Lst3FHzlnH0GTT5lQi1sRgF0wcvPx91nK3EE
 +9D+1+b/pmGsG8weoZFFLbKqtKZomxhiP8N936zq/x0ZIOl+54iyUCc8aaknZho9naJYg0bolM7B
 /rBFul0ycjYHG4GdFKMQ35btrvek2M59SFaAgmbcJvQYeMBieS0HrfGPAZJIBkibED16fk98TtCX
 nmErPLbt0n54j3vHX4q9ucblgTl6fJxyntEfhZCKje4ZVqTkwLt6SYkAdzGktUDvjhcQ03UfPegz
 thIgE0bVKhnLgKffTIgl7nuGO/IJU1342OUMeHyTpNN0eXybX/w7/4a+Zyc1sUYlckMDbruAhxeL
 AMKmgwH2OI1KXZVCaM7UP+Qp6pRC9Pcsis6fWuGfbQLnYulzT14y3oQ5Luhto6uHBFcSd+lvwXfC
 dBBIQjd7L/rBRLo9sPZPsdPAPLGXijpz3xGRP5RGMOZQzwH+m4ITKgAQriuw1aTia+0Fz1FR/r/Q
 PJ+/KaZTRipxmiMbQ9r4VzmDcPRcss9l8U9uabmFtEawy5Au1J675PgjnC7uCNDWLsOBFdJXQ5JW
 RqtvfSVHXrKqomu3kyesbCQmUr5m4zuNRcgRKiGg7nXFaZTxtATkW6UpiwR56z2I56cmJS7WcVfv
 wPW+1tEygn0RV90PwhysWYA00ZxdcmkmNqICsn5LJSuUB2AE+3gYp8SKf98hdZ19I5VQ7yn/TD65
 0L2R27r9HYUzziTFhEVK8LUg7z2cei++OOuTORevI53bSU+MD7fzqSChs+4uwiFVOMJkQqHI0C/U
 3fmRhZoR2Au6S5TMxvd8NdRV1gKYQ/ojqkADbc/I6fiP72XzLwNVEQA=
X-Report-Abuse-To: spam@mut-mta1-se01a-fr.yulpa.io
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Roland Hieber <rhi@pengutronix.de> writes:

> The output of git-reflog is currently only customizable by calling
> reflog with --pretty=... or overriding the default "oneline" pretty
> format in the configuration.

Sounds like a good idea to me, but the patch needs a bit more work:

>  Documentation/git-reflog.txt |  2 ++

It's nice to refer to the config variable in git-reflog.txt, but you
should also document it in some Documentation/config/*.txt file,
included from Documentation/config.txt, so that it appears in man
git-config.

>  builtin/log.c                | 12 +++++++++---
>  2 files changed, 11 insertions(+), 3 deletions(-)

This lacks tests, too (t/*.sh).

> --- a/builtin/log.c
> +++ b/builtin/log.c
> @@ -667,6 +667,7 @@ int cmd_log_reflog(int argc, const char **argv, const char *prefix)
>  {
>  	struct rev_info rev;
>  	struct setup_revision_opt opt;
> +	int cfg_have_pretty;
>  
>  	init_log_defaults();
>  	git_config(git_log_config, NULL);
> @@ -676,11 +677,16 @@ int cmd_log_reflog(int argc, const char **argv, const char *prefix)
>  	rev.verbose_header = 1;
>  	memset(&opt, 0, sizeof(opt));
>  	opt.def = "HEAD";
> +
> +	cfg_have_pretty = git_config_get_string_const("reflog.pretty", &fmt_pretty);
>  	cmd_log_init_defaults(&rev);
> -	rev.abbrev_commit = 1;
> -	rev.commit_format = CMIT_FMT_ONELINE;
> -	rev.use_terminator = 1;
> +	if (cfg_have_pretty != 0) {

I'd write just "if (cfg_have_pretty)".

>  	rev.always_show_header = 1;
> +
>  	cmd_log_init_finish(argc, argv, prefix, &rev, &opt);

Avoid adding unrelated whitespace changes like this one.

Regards,

-- 
Matthieu Moy
https://matthieu-moy.fr/
