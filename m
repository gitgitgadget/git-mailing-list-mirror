Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-9.3 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 71C781FF40
	for <e@80x24.org>; Wed, 29 Jun 2016 15:18:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752871AbcF2PR4 (ORCPT <rfc822;e@80x24.org>);
	Wed, 29 Jun 2016 11:17:56 -0400
Received: from mout.gmx.net ([212.227.17.20]:62305 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752245AbcF2PRz (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Jun 2016 11:17:55 -0400
Received: from virtualbox ([37.24.143.100]) by mail.gmx.com (mrgmx103) with
 ESMTPSA (Nemesis) id 0MBnPX-1b9iJ41Rqh-00AkGj; Wed, 29 Jun 2016 17:11:13
 +0200
Date:	Wed, 29 Jun 2016 17:11:12 +0200 (CEST)
From:	Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:	git@vger.kernel.org
cc:	Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/9] Report bugs consistently
In-Reply-To: <8615dc276828a3f99a27ff2eda9909548a7d435e.1467199553.git.johannes.schindelin@gmx.de>
Message-ID: <alpine.DEB.2.20.1606291709270.12947@virtualbox>
References: <cover.1467199553.git.johannes.schindelin@gmx.de> <8615dc276828a3f99a27ff2eda9909548a7d435e.1467199553.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:mW6YpjBfu/dKjdAaUQh+TmGno3RfUlCNJqz1NsLNwdZRuHAgq4F
 cUGZARx+FD0QfQtmm0ocZPZHCY8zpAv3Sdb7I7VcgB5qzoeCxC/Ba3AFCUicSYIuF2rA1NJ
 2s/dZ3dLCjn0QoqiDGgV+IWagkh8tWEo/A799rh8xPNkG9v3yMCqgRTMaNg2l80S1INw4wz
 tkz5oimE6XNQKnK5h5YLg==
X-UI-Out-Filterresults:	notjunk:1;V01:K0://3VrRAbVzc=:5CW8rGXFrI7cKqqlN9oaNS
 x3xLkJlpK1HEgmcDLlT4Owf6/iq2JifMyxeaYAzMEZXdq/iH/11aKfZrujCks6btmJS3oPAqP
 VTzz+M3TELYfUmbMEdj9aFdhum6eocAJIiYQdZXRsob51SpiCQhRMoYP/qC+f3cmVe64F6rzb
 u/9RW88llPJB+k8W/paQnYDc6z5G9kIkT6CLv8sJ2o4c07n0ERB/S63ElP4KY2xKZJmWTfF6A
 h/DU68PQlfNjdAGKlikuksvtmvEMKDi9aenP1HNZdigs5E9d5AITyP2CvGL5q2+PKaGuyxCSR
 dJKtKuNoydYRAspSyULyF3BH7zyevJp1Pia4nPzBYIB18Yp9aJLJuuCEwCTwmz++GmVriapCg
 ax54bDGWyRNRBfKhv81OsbgiUX7dca70DxiYAj8vRLCcIFJKR8cWX8yHG/hfzSVJhuONSG27K
 wZ7sO8HFjK0WipwOzvZeiyQIfdKnNI2KMifrWrebndmij/YFMbAcP0sY6xUfO5YFRbmdC9QBc
 /fgPfZko2UPZ5ruCiJlXmXaTPNbYo7wEmz+mrqd4Ev/HKRjX2eBnd3MhhcdXGbiD0wN9EPX7S
 WGm0XEX6SfqsmhmtY+r/4thCJtQqsf4UkB6GXR5b2wNITHEgMnLvKXjg+8K9vJMwmADYXqbV5
 a9WODvvxL2oE3pROL1v84JProm/fs9Ry0zrXsCf/uEBKpV9Qcc62oFeqnOIl205LBiUkVGn7p
 vo8qzto92O1OhefxIAQgw70FpEhqFvpDzXJRQs3ZlQnQ9CTFETzGuFxxENUELeINsA0vWoJH9
 iifbmpj
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Hi,

On Wed, 29 Jun 2016, Johannes Schindelin wrote:

> diff --git a/imap-send.c b/imap-send.c
> index 938c691..cd39805 100644
> --- a/imap-send.c
> +++ b/imap-send.c
> @@ -511,7 +511,7 @@ static int nfsnprintf(char *buf, int blen, const char *fmt, ...)
>  
>  	va_start(va, fmt);
>  	if (blen <= 0 || (unsigned)(ret = vsnprintf(buf, blen, fmt, va)) >= (unsigned)blen)
> -		die("Fatal: buffer too small. Please report a bug.");
> +		die("BUG: buffer too small (%d < %d)", ret, blen);
>  	va_end(va);
>  	return ret;
>  }

Oy vey. Travis CI found a bug here, thanks to clang's quite smart
checking. This here fixup is needed (will make that part of v2, but wait
for comments):

-- snipsnap --
From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [PATCH] fixup! Report bugs consistently

---
 imap-send.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/imap-send.c b/imap-send.c
index cd39805..369f72a 100644
--- a/imap-send.c
+++ b/imap-send.c
@@ -506,7 +506,7 @@ static char *next_arg(char **s)
 
 static int nfsnprintf(char *buf, int blen, const char *fmt, ...)
 {
-	int ret;
+	int ret = -1;
 	va_list va;
 
 	va_start(va, fmt);
-- 
2.9.0.270.g810e421


