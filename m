Return-Path: <SRS0=H/u6=4H=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MALFORMED_FREEMAIL,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15B0EC34047
	for <git@archiver.kernel.org>; Wed, 19 Feb 2020 14:18:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF42520801
	for <git@archiver.kernel.org>; Wed, 19 Feb 2020 14:18:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="fggx1FeL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727898AbgBSOSO (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 19 Feb 2020 09:18:14 -0500
Received: from mout.gmx.net ([212.227.15.19]:46059 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726736AbgBSOSN (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 Feb 2020 09:18:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1582121891;
        bh=mu7KTVKR8JlRjOVrb4GmwWd1bDuJhUb6KeFJ6psebBU=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=fggx1FeLFnN9cn3YfXH4Mq5nRjw/7D9GWcEZD/18rLIfq8R0MiOCQkmCzyeLVZxj8
         L7ehUWtgXq9AqonzQqenMt0I0NLcAIhN8MbDMWI4aMaNW65o+L/SEEk4NliSnT3JsC
         VA12fVqJK6myVidX+9YMz3iup9qIn3pC66JyzX0I=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.213] ([37.201.195.86]) by mail.gmx.com (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MZkpR-1izBGG2Xnb-00Wnjz; Wed, 19
 Feb 2020 15:18:11 +0100
Date:   Wed, 19 Feb 2020 15:18:09 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Emily Shaffer <emilyshaffer@google.com>
cc:     git@vger.kernel.org
Subject: Re: [PATCH v7 03/15] bugreport: add tool to generate debugging
 info
In-Reply-To: <20200214015343.201946-4-emilyshaffer@google.com>
Message-ID: <nycvar.QRO.7.76.6.2002191515310.46@tvgsbejvaqbjf.bet>
References: <20200214015343.201946-1-emilyshaffer@google.com> <20200214015343.201946-4-emilyshaffer@google.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:FND5bfUt1KFXpAwfhPFcXB72cyJvvuUjeVcpdnpFSVnCR4wBUDD
 yX8aTpH+YVtEjGhIVQAV1eKgZ1zh6HAzWDEexOWh++EwZaUXmLZGWXYpcu/HIGVzC5cbcH9
 8t0VGKU8KWp6PJ5tgLaUEnWXE77CXDXI9wAEctr5vfG35YYkifwSA3Tr6VY7PNobAN+Um/Q
 hVjlrTAfFbjuYFt/uUmLg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:/RuJ3LWeAeA=:bUMtQX2Ntwj6v5sMbxV/HI
 qrshvat11Ptj9pA6Db3/M4tp2VY4bgTm738fdeSKN2ljuYTDTQRu/ZEMo6xcUOI027LxQOTdQ
 +MNjBfdRDFBLx8rAW4s2i1lQxVV4Jvf0zlooORF8zjvt4yibWtprRpajaDFlDXWgomztq2+4d
 FZ06tcWQtlFTEB7NJQG57SuP4fBngIfLPUb10uXo417vAYRgM7q2FhmRiK05H8IDTlJN2LvmV
 Z3nwpenoBXCeJXoxZr9rgroQqkQzeKuUVOdiMbn/JqnfYwchDyvFQjYyc4dk6MmI/xRxR6xYn
 ol2EAlSdM4NDv3PxkcFG2Bgf376FMX0lQlxCXGvAmTxLJoc2iMTY1k1Ud/839uVbiG+EN7Omn
 vizFj0prtDKe6/GJOspnbz9aD8AZ3tkB0KhGagrPVHNI0JQD7vAJqP1ayNCAIrfFHWQmC9E/n
 EV2cPqQSIVxopUqKKajaEOEhifldjUfWcb0qCdpa0ExL7fUfBO/oLgqFVx5pIBAiyN+goOTV5
 FxBcRzSZ0YNHEewdWLefaSXXffPIagQFRGo9VEfRa73S3WyAxn9EugUTxbpXVzsU6FJlRzOOG
 EjHAJpHFb0DK+6JrYZADu93P2U0g+hAz/+lvOxpROkfjGPW0BNh2Zx1NXgeajyJowjUCcqveA
 gDZXmlvQRTVwtCcp00xCZDmhZb7YmgiDt+b7hka9NOlUW4I/9fyLszJKTRSMnHyrzTT+T220W
 ReiZH9JY+xJJKHQOwUNfu41TZaKxqRHXh+A6XkqYbuC5IQaQCOUEeOYsKyq84psPBmTftNIlw
 HMsn9tmeiD5y/fIZl5txgm4uWsxy+5gk6osZAm6igSJByiwss5D6BqxN20aF2W1LAN/jSKgEO
 OGG4k4cnDVFf74AEJrdLaHNldMrSRV9Bi89O0DgXABw8RMHvyG9GPGoAglxSRi1oMo2ZuDDZ7
 B+07ALdFxJYlPdBlYSg/LC4QU3u8DzabV7K1I9bRRwFvY4pquD4FA8Q/Py465RqIWZw4XT5Dg
 /buo4Ch6iJhucbCPeEH1/2BBy2E92/3iw5o2+WcdKbfPaWj30jH7UHEXITm0VlWZN6KVTWmbk
 8VyRtqxEDVJcSDWwbVIDre6t7/W1y/7KByLLSPaKp/jsgZr0ab07uOEdZSoWLIivEDTb0DOzP
 obljyB3qVytRYpjrFSEF/pFd9YxBKs0vRWGCqt3LFIFOLvmHhYRY6LKKtpjdBNb6WLwrrj3Ti
 hdw1eGJvvUu8tFp9u
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Emily,

On Thu, 13 Feb 2020, Emily Shaffer wrote:

> diff --git a/bugreport.c b/bugreport.c
> new file mode 100644
> index 0000000000..a9398e6a2a
> --- /dev/null
> +++ b/bugreport.c
> @@ -0,0 +1,94 @@
> +#include "builtin.h"
> +#include "parse-options.h"
> +#include "stdio.h"
> +#include "strbuf.h"
> +#include "time.h"
> +
> +static const char * const bugreport_usage[] = {
> +	N_("git bugreport [-o|--output-directory <file>] [-s|--suffix <format>]"),
> +	NULL
> +};
> +
> +static int get_bug_template(struct strbuf *template)
> +{
> +	const char template_text[] = N_(
> +"Thank you for filling out a Git bug report!\n"
> +"Please answer the following questions to help us understand your issue.\n"
> +"\n"
> +"What did you do before the bug happened? (Steps to reproduce your issue)\n"
> +"\n"
> +"What did you expect to happen? (Expected behavior)\n"
> +"\n"
> +"What happened instead? (Actual behavior)\n"
> +"\n"
> +"What's different between what you expected and what actually happened?\n"
> +"\n"
> +"Anything else you want to add:\n"
> +"\n"
> +"Please review the rest of the bug report below.\n"
> +"You can delete any lines you don't wish to share.\n");
> +
> +	strbuf_addstr(template, template_text);
> +	return 0;
> +}
> +
> +int cmd_main(int argc, const char **argv)
> +{
> +	struct strbuf buffer = STRBUF_INIT;
> +	struct strbuf report_path = STRBUF_INIT;
> +	FILE *report;
> +	time_t now = time(NULL);
> +	char *option_output = NULL;
> +	char *option_suffix = "%F-%H%M";
> +	struct stat statbuf;
> +
> +	const struct option bugreport_options[] = {
> +		OPT_STRING('o', "output-directory", &option_output, N_("path"),
> +			   N_("specify a destination for the bugreport file")),
> +		OPT_STRING('s', "suffix", &option_suffix, N_("format"),
> +			   N_("specify a strftime format suffix for the filename")),
> +		OPT_END()
> +	};
> +	argc = parse_options(argc, argv, "", bugreport_options,
> +			     bugreport_usage, 0);
> +
> +	if (option_output) {
> +		strbuf_addstr(&report_path, option_output);
> +		strbuf_complete(&report_path, '/');
> +	}
> +
> +
> +	strbuf_addstr(&report_path, "git-bugreport-");
> +	strbuf_addftime(&report_path, option_suffix, localtime(&now), 0, 0);
> +	strbuf_addstr(&report_path, ".txt");
> +
> +	if (!stat(report_path.buf, &statbuf))
> +		die("'%s' already exists", report_path.buf);
> +
> +	switch (safe_create_leading_directories(report_path.buf)) {
> +	case SCLD_OK:
> +	case SCLD_EXISTS:
> +		break;
> +	default:
> +		die(_("could not create leading directories for '%s'"),
> +		    report_path.buf);
> +	}
> +
> +	get_bug_template(&buffer);
> +
> +	report = fopen_for_writing(report_path.buf);
> +
> +	if (report == NULL) {
> +		strbuf_release(&report_path);
> +		die("couldn't open '%s' for writing", report_path.buf);
> +	}
> +
> +	strbuf_write(&buffer, report);
> +	fclose(report);
> +
> +	fprintf(stderr, _("Created new report at '%s'.\n"), report_path.buf);
> +
> +	UNLEAK(buffer);
> +	UNLEAK(report_path);
> +	return -launch_editor(report_path.buf, NULL, NULL);

This would be the first time (at least that _I_ know of) that we use `-`
in this way. We seem to use `!!` a lot more often. And now I wonder
whether there is a reason for that `-` that I missed?

Ciao,
Dscho
