Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 58B571F4F8
	for <e@80x24.org>; Fri, 14 Oct 2016 17:34:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754010AbcJNReS (ORCPT <rfc822;e@80x24.org>);
        Fri, 14 Oct 2016 13:34:18 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:35197 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753679AbcJNReR (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Oct 2016 13:34:17 -0400
Received: by mail-wm0-f66.google.com with SMTP id b80so710263wme.2
        for <git@vger.kernel.org>; Fri, 14 Oct 2016 10:34:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=hrsop6ckJQk7Tmh9bZHF/WWAUMjV30NfRx5XJvovoQE=;
        b=dhxeofPQjOroGXLoqznRIt/DLwcif6xmU7TChhAKAJEi36R9jxZWbfgRLikTYHnqyc
         idld58hiYX4xuCwejxqq7SSp1t68MoAOBd6NyjtWeiEgpbnxjJERvzoTXksfojoOhZOB
         +BkEnSF1dL6c7Q/dMR//f+JM4bJWhA/oyCWLWA8qIFfSj/UT57Xlb01EZ/fsxN7h8fJr
         fhBFIDZfriL0x6sEQBjmnjQnu03o7FvOMAiAxaGN15uRRKTOXnYI57yTjysz3E8qsicw
         wwxa913yJP9Hgcd0UwQMJ44DISzPox3mVgIVn0sHUGHRMPFd84YDg9zw3HrFjNKC1SeI
         cQgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=hrsop6ckJQk7Tmh9bZHF/WWAUMjV30NfRx5XJvovoQE=;
        b=NjK4qyzPcwrpJ4XPuCfs6h3shNWafci62nA775E44PaE1ZTbLdZYQIva6rvcar/L8q
         Oj0Tt8Ukwutl8huRihB3eoNwBLdSWOBjVVbT2uSktqnUfa7O/GA6hlsYQKHB/O01CFi2
         IY9VzGzv08HlaRIOwYQ+ZAHOxFUheXQ2ZHhW+dk5smr5eD6I63Joz2t8KPy18xSoKz+A
         5k8Z6w4E+wwj+TDCUFV7Im65erTLC0sSeRjkxxomhA424YJB0Z4EPv2wlI8Xq/bLlPzZ
         cCK2GVNvV74LYmjtzvwkOfqGonoUO7FBWVN3MDKokRfFMdWgZbctKtyRCOBOQDwRub+D
         DoPQ==
X-Gm-Message-State: AA6/9Rl74cjHdgbPAh6+9PQa7a/KnbvyHZZWDRyVvYOZ1o1qwvJN0FS7nwEPqOGU+PM6UA==
X-Received: by 10.194.108.230 with SMTP id hn6mr3009416wjb.122.1476466455297;
        Fri, 14 Oct 2016 10:34:15 -0700 (PDT)
Received: from [192.168.1.26] (agd104.neoplus.adsl.tpnet.pl. [83.25.159.104])
        by smtp.googlemail.com with ESMTPSA id s195sm848980wmb.10.2016.10.14.10.34.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 14 Oct 2016 10:34:14 -0700 (PDT)
Subject: Re: [PATCH v2 1/3] gitweb: Fix a typo in a comment
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        git@vger.kernel.org
References: <20161006091135.29590-1-avarab@gmail.com>
 <20161006091135.29590-2-avarab@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>
From:   =?UTF-8?Q?Jakub_Nar=c4=99bski?= <jnareb@gmail.com>
Message-ID: <51eb6aba-9cd2-47f4-a26e-6dbbabdaa282@gmail.com>
Date:   Fri, 14 Oct 2016 19:34:04 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.4.0
MIME-Version: 1.0
In-Reply-To: <20161006091135.29590-2-avarab@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

W dniu 06.10.2016 o 11:11, Ævar Arnfjörð Bjarmason napisał:

> Change a typo'd MIME type in a comment. The Content-Type is
> application/xhtml+xml, not application/xhtm+xml.
> 
> Fixes up code originally added in 53c4031 ("gitweb: Strip
> non-printable characters from syntax highlighter output", 2011-09-16).
> 
> Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>

Good.  Thanks for taking care of this.
For what is worth for such a trivial patch:

Acked-by: Jakub Narębski <jnareb@gmail.com>

> ---
>  gitweb/gitweb.perl | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
> index 44094f4..cba7405 100755
> --- a/gitweb/gitweb.perl
> +++ b/gitweb/gitweb.perl
> @@ -1616,7 +1616,7 @@ sub esc_path {
>  	return $str;
>  }
>  
> -# Sanitize for use in XHTML + application/xml+xhtm (valid XML 1.0)
> +# Sanitize for use in XHTML + application/xml+xhtml (valid XML 1.0)
>  sub sanitize {
>  	my $str = shift;
>  
> 

