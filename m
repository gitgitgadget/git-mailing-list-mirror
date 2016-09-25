Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BDD541F4F8
	for <e@80x24.org>; Sun, 25 Sep 2016 18:04:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1034310AbcIYSEh (ORCPT <rfc822;e@80x24.org>);
        Sun, 25 Sep 2016 14:04:37 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:34918 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965935AbcIYSEg (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 25 Sep 2016 14:04:36 -0400
Received: by mail-wm0-f66.google.com with SMTP id 133so10785817wmq.2
        for <git@vger.kernel.org>; Sun, 25 Sep 2016 11:04:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-transfer-encoding;
        bh=zrMJVDWDMGXMMwei2JB20QJ7vQuJ5lnXrXWRD2e6jXI=;
        b=JAiIqOSIyeJH6zPLDf2ERhP0REkIVvXsOSatLOc39JUmDEHT2oQdoqh9hxGJwy8Wz1
         LchDCmXDXf8obI0FKlBj6BcGgMC1C/vihWG+LmHB6o0JGL5JPdujItlQ0aBkucDFf4pm
         89thfJiPwFvtTgZy8M66Zk3/CKuL4D/NiDbbZL3fCMhcV/BCWCl2Ge3AgGUvt1irq5T0
         Nk50yD8o7PirmTl0TTHw1hfIZZGFEYoXfu8GL4qus80wKGcAo7n5Yw6yslRyQkfbLKn9
         cfMHglG8xhPZ1HwCMduhVs2YlPytESL2cMtgdpi33ZC0bmzZf71aXNTASBTocNV+/X45
         qaHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=zrMJVDWDMGXMMwei2JB20QJ7vQuJ5lnXrXWRD2e6jXI=;
        b=VF/QPrSTEU89wr0ylvKdbQrZUVj3BY7SEEw1ZDtObrbcZeBYnVoJhHmcalt6IZf7YQ
         JMEtvIU674uDxU22KgIPCx77IeiVj2L5U63AVqHxrcU3Mw8w9bfUS00A+6b/tw1JTgIe
         JtYiSJpbTfh5kw1oJy/emci7qnn3k+b/Fhb04bpCfPHLfbU0O6bmSXbJCsaNMLUZpNbt
         RnlUsvyPamt0z4lepUJNe7ry4LxDNZu+1fPdijuTlyvsth3V54BRn0UNYaCK9kISTP7y
         CLZRKypeCPon+w7/mbkRckOo124dB9Rmklt4x2xzh7+x196VQcnoVBn4nxfsoMa6Bw+X
         rbPg==
X-Gm-Message-State: AA6/9Rk84EDEHXVKeavSCM4IOiVc3g6wHLcGiR/9JQRJNrf1BLGWEY6BkfCZ0nhSVfuCvg==
X-Received: by 10.194.3.45 with SMTP id 13mr14788999wjz.103.1474826674744;
        Sun, 25 Sep 2016 11:04:34 -0700 (PDT)
Received: from [192.168.1.26] (dbd108.neoplus.adsl.tpnet.pl. [83.23.29.108])
        by smtp.googlemail.com with ESMTPSA id ya1sm18218022wjb.23.2016.09.25.11.04.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 25 Sep 2016 11:04:33 -0700 (PDT)
Subject: Re: [PATCH v4 2/2] gitweb: use highlight's shebang detection
To:     Ian Kelling <ian@iankelling.org>, git@vger.kernel.org
References: <20160923090846.3086-2-ian@iankelling.org>
 <20160924223258.9449-1-ian@iankelling.org>
 <20160924223258.9449-2-ian@iankelling.org>
From:   =?UTF-8?Q?Jakub_Nar=c4=99bski?= <jnareb@gmail.com>
Message-ID: <c35fc760-ae64-5df3-5985-7eecd06d937f@gmail.com>
Date:   Sun, 25 Sep 2016 20:04:30 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.3.0
MIME-Version: 1.0
In-Reply-To: <20160924223258.9449-2-ian@iankelling.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

W dniu 25.09.2016 o 00:32, Ian Kelling pisze:
> The "highlight" binary can, in some cases, determine the language type
> by the means of file contents, for example the shebang in the first line
> for some scripting languages.  Make use of this autodetection for files
> which syntax is not known by gitweb.  In that case, pass the blob
> contents to "highlight --force"; the parameter is needed to make it
> always generate HTML output (which includes HTML-escaping).
> 
> Although we now run highlight on files which do not end up highlighted,
> performance is virtually unaffected because when we call highlight, it
> is used for escaping HTML.  In the case that highlight is used, gitweb
> calls sanitize() instead of esc_html(), and the latter is significantly
> slower (it does more, being roughly a superset of sanitize()).  Simple
> benchmark comparing performance of 'blob' view of files without syntax
> highlighting in gitweb before and after this change indicates ±1%
> difference in request time for all file types.  Benchmark was performed
> on local instance on Debian, using Apache/2.4.23 web server and CGI.
> 
> Document the feature and improve syntax highlight documentation, add
> test to ensure gitweb doesn't crash when language detection is used.
> 
> Signed-off-by: Ian Kelling <ian@iankelling.org>

For what it is worth it:

Acked-by: Jakub Narębski <jnareb@gmail.com>

(but unfortunately *not* tested by).

> ---
> 
> Notes:
>     The only change from v3 is the commit message as suggested by Jakub
>     Narębski
> 
>  Documentation/gitweb.conf.txt          | 21 ++++++++++++++-------
>  gitweb/gitweb.perl                     | 10 +++++-----
>  t/t9500-gitweb-standalone-no-errors.sh |  8 ++++++++
>  3 files changed, 27 insertions(+), 12 deletions(-)

