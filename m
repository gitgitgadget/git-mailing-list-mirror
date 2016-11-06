Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 299A22022D
	for <e@80x24.org>; Sun,  6 Nov 2016 15:31:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752134AbcKFPbu (ORCPT <rfc822;e@80x24.org>);
        Sun, 6 Nov 2016 10:31:50 -0500
Received: from mail-wm0-f68.google.com ([74.125.82.68]:35351 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752031AbcKFPbt (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 6 Nov 2016 10:31:49 -0500
Received: by mail-wm0-f68.google.com with SMTP id a20so1406868wme.2
        for <git@vger.kernel.org>; Sun, 06 Nov 2016 07:31:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=/RK7keQyj3b0HsWkkc3Wbn0+c8kGo9Ul4Utn6BXEv1A=;
        b=ZbXDNDIvtEeSEZk7SfL5MNnWJfzvX0QS5uxj/S0/r0tJ2VvrkJUTh9aR2gI6d1CGS3
         8k35QUw0fny4SwsNonqYf0xxcRC99UeGWLFwNn80TK2oBS+F0aGJuLUmbYnjN0/YFa35
         owk4/ghCaB8Jn8cSkhGBPJIms5b7INvknn1/rTIwk0l8qPr+262x+E0lYoDWa9tWPW/2
         W7Xch24FrbLT1NKt7n37Q7sDMTEjzEXNa9Zyg3KR7f0LweBLkYkfZ3RCHXwpcqSSoRVy
         elwmsWtGstpzX2qBPqISPx/zosGgFuRCZ9XPNtMLk+PBJ1jmmx8o79lSbK0VWhyMRDeF
         MLrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=/RK7keQyj3b0HsWkkc3Wbn0+c8kGo9Ul4Utn6BXEv1A=;
        b=fTVvq0RWIchXjlpHaT5tKg/qWJsx+ydIWeZ5xz+EiDIMAh9MdXYWUOQdQajNw+ULUg
         2ybkZ8L8RMbD8d4rrkXrBvkCd1mi8OiN2O9sZKdAT1/xLdU+vxuug1NLpMZGtTphv/i7
         sSY1ehDQhU4PaBopQj7HPaVpyisLeiHjpJfylBkZYsrC0JPW2+RjVRbhDvkCH3ZEdZg1
         Jjy486gK6zo1sUcDHaiSEqV6OZmpsfgdPYI4g//Ve9eIt6iMSV+4chzmwTcsUvlAYm75
         4YfpGb4ulX/0cVL5F0shhuNDs9cV6/wgMFy6FOYZdYWSHl3y64aiTlGNakeNRdvDFahQ
         yDrg==
X-Gm-Message-State: ABUngvdaTxCxK9VMjHoRUyKUiFOq5duSWCjC/gNPev/NRd8FNygv7I1ysqQu/4h3LhMeQg==
X-Received: by 10.28.209.67 with SMTP id i64mr3495618wmg.48.1478446307958;
        Sun, 06 Nov 2016 07:31:47 -0800 (PST)
Received: from slxbook4.fritz.box (p5DDB5D74.dip0.t-ipconnect.de. [93.219.93.116])
        by smtp.gmail.com with ESMTPSA id b184sm8212185wma.0.2016.11.06.07.31.46
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 06 Nov 2016 07:31:47 -0800 (PST)
Content-Type: text/plain; charset=windows-1252
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [PATCH] t0021: expect more variations in the output of uniq -c
From:   Lars Schneider <larsxschneider@gmail.com>
In-Reply-To: <fb4d62de-fbb5-a2b4-8eba-b135125dafa9@kdbg.org>
Date:   Sun, 6 Nov 2016 16:31:45 +0100
Cc:     git@vger.kernel.org, gitster@pobox.com, jnareb@gmail.com,
        peff@peff.net, ramsay@ramsayjones.plus.com, tboegi@web.de
Content-Transfer-Encoding: 7bit
Message-Id: <0B7DE8F1-34DF-4271-8936-B9B596EF5F9E@gmail.com>
References: <20161016232038.84951-1-larsxschneider@gmail.com> <20161016232038.84951-14-larsxschneider@gmail.com> <3b09d218-33bd-dc7c-235c-8954a46afc41@kdbg.org> <3763DDDB-9D53-4877-8399-32DF1780CAB7@gmail.com> <fb4d62de-fbb5-a2b4-8eba-b135125dafa9@kdbg.org>
To:     Johannes Sixt <j6t@kdbg.org>
X-Mailer: Apple Mail (2.3124)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


> On 03 Nov 2016, at 21:12, Johannes Sixt <j6t@kdbg.org> wrote:
> 
> Some versions of uniq -c write the count left-justified, other version
> write it right-justified. Be prepared for both kinds.
> 
> Signed-off-by: Johannes Sixt <j6t@kdbg.org>
> ---
> Here it is as a proper patch.
> 
> Am 03.11.2016 um 01:41 schrieb Lars Schneider:
>>> On 2 Nov 2016, at 18:03, Johannes Sixt <j6t@kdbg.org> wrote:
>>> +        sort "$FILE" | uniq -c |
>>> +        sed -e "s/^ *[0-9][0-9]* *IN: /x IN: /" >"$FILE.tmp" &&
>> 
>> This looks good (thanks for cleaning up the redundant clean/smudge
>> stuff - that was a refactoring artifact!). One minor nit: doesn't sed
>> understand '[0-9]+' ?
> 
> I don't think so.
> 
>>> +        mv "$FILE.tmp" "$FILE" || return
>> 
>> Why '|| return' here?
> 
> If there is an error in the pipeline or in the mv command, the for loop
> would not exit otherwise. The subsequent test_cmp most likely fails,
> but the || return is more correct.
> 
> t/t0021-conversion.sh | 7 +++----
> 1 file changed, 3 insertions(+), 4 deletions(-)
> 
> diff --git a/t/t0021-conversion.sh b/t/t0021-conversion.sh
> index a20b9f58e3..db71acacb3 100755
> --- a/t/t0021-conversion.sh
> +++ b/t/t0021-conversion.sh
> @@ -40,10 +40,9 @@ test_cmp_count () {
> 	actual=$2
> 	for FILE in "$expect" "$actual"
> 	do
> -		sort "$FILE" | uniq -c | sed "s/^[ ]*//" |
> -			sed "s/^\([0-9]\) IN: clean/x IN: clean/" |
> -			sed "s/^\([0-9]\) IN: smudge/x IN: smudge/" >"$FILE.tmp" &&
> -		mv "$FILE.tmp" "$FILE"
> +		sort "$FILE" | uniq -c |
> +		sed -e "s/^ *[0-9][0-9]*[ 	]*IN: /x IN: /" >"$FILE.tmp" &&
> +		mv "$FILE.tmp" "$FILE" || return
> 	done &&
> 	test_cmp "$expect" "$actual"
> }
> -- 
> 2.11.0.rc0.55.gd967357
> 

This looks good to me. I wonder if I should post a patch 
to add the "|| return" trick to the following function
"test_cmp_exclude_clean", too?!

Thanks,
Lars

