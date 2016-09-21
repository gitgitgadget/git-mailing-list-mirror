Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EA4421F935
	for <e@80x24.org>; Wed, 21 Sep 2016 13:34:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933872AbcIUNeM (ORCPT <rfc822;e@80x24.org>);
        Wed, 21 Sep 2016 09:34:12 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:34079 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933829AbcIUNeL (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Sep 2016 09:34:11 -0400
Received: by mail-wm0-f67.google.com with SMTP id l132so8616562wmf.1
        for <git@vger.kernel.org>; Wed, 21 Sep 2016 06:34:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=c4B6LezIkYrJwyKaFSjKl5bkemPrWySf3F69MCSeNPA=;
        b=vGmaALM6atu5/HjMctO/icbBa06h8LQih6IK03ZLPycOWr/k5GhT30YvJHGNvvmZza
         v2Q/7JdoQrWIA9JhQPdCbk2N+5NOnVy/ohzT7JSLXwO1dR9cuMR5+2Q2WlnGHkgWwRfK
         zN/n04jMCHNGkjz2x5J8ofL0GJco1UTNHKZQ8RBAeFAHnU1MbF6Ct/Mz6lApcMqeUspv
         vLGGIvzwW8rV0XMpk6hB0bcdPHOgwMY624mhTWVKiRfhZ8k8W79WBLN7FLJ40fLAhMR0
         zw0v9H92zS/CuRr11D1oj2hEnMjUqZwmfuEX0/VO48wGi4+cfnULCEEjiSNBHPEhEt7d
         Ba1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=c4B6LezIkYrJwyKaFSjKl5bkemPrWySf3F69MCSeNPA=;
        b=fcDhahA+uVWfTI0ysZ0VYdpjuQTXewYKY3o0AwYtdX0kt1rfw9JdttDwthXQ5EXuFH
         JjMgqKOV0t9kiiI9Jj+6B6NQGc+tA2EVeSYn8QM5vVMtVZuu4yK7Eh1yN4qcB7zms/F0
         KqEuK/Xt6WBwEL88PBQK9j7TBeSx64tDoROGQrd20zjZPL+pKx05ZQ1U9TbMHgsL6PI+
         zBQP8f12ZRt9fBoGwNrPajROjulqCrbdrJms62LZDwuwPezIgqM6Ejh9itpwO+we9MB0
         9h5vuWraI73bc1C+yfIVFJPAoymGWCu8vanEx2deF1ZGe6shaIZ4UxshpeqXT3Pz4D/D
         6ahA==
X-Gm-Message-State: AE9vXwN9tye7Df0NoKBlMXuM5hPhSdWTXH7/46gR5SDi0Cs1F10XyigdovHZkCRUXJsGcA==
X-Received: by 10.194.232.200 with SMTP id tq8mr32571345wjc.63.1474464850552;
        Wed, 21 Sep 2016 06:34:10 -0700 (PDT)
Received: from [192.168.1.26] (enn40.neoplus.adsl.tpnet.pl. [83.20.3.40])
        by smtp.googlemail.com with ESMTPSA id b128sm32697213wmb.21.2016.09.21.06.34.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 21 Sep 2016 06:34:09 -0700 (PDT)
Subject: Re: [PATCH 1/3] gitweb: Fix an ancient typo in v1.7.7-rc1-1-g0866786
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        git@vger.kernel.org
References: <20160921114428.28664-1-avarab@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Kay Sievers <kay.sievers@suse.de>
From:   =?UTF-8?Q?Jakub_Nar=c4=99bski?= <jnareb@gmail.com>
Message-ID: <d047a76d-8f13-5c90-3946-6821957d9278@gmail.com>
Date:   Wed, 21 Sep 2016 15:33:53 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.2.0
MIME-Version: 1.0
In-Reply-To: <20160921114428.28664-1-avarab@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

W dniu 21.09.2016 o 13:44, Ævar Arnfjörð Bjarmason napisał:

> Subject: [PATCH 1/3] gitweb: Fix an ancient typo in v1.7.7-rc1-1-g0866786

It is more "ancient typo from v1.7.7-rc1-1-g0866786", but perhaps more
important is "ancient typo in a comment"

>
> The Content-Type is application/xhtml+xml, not application/xhtm+xml.

Right.  Thanks for the patch.

Signoff?

> ---
>  gitweb/gitweb.perl | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
> index 33d701d..9473daf 100755
> --- a/gitweb/gitweb.perl
> +++ b/gitweb/gitweb.perl
> @@ -1616,7 +1616,7 @@ sub esc_path {
>  	return $str;
>  }
>  
> -# Sanitize for use in XHTML + application/xml+xhtm (valid XML 1.0)
> +# Sanitize for use in XHTML + application/xml+xhtml (valid XML 1.0)

Nb. I wonder how common is use of XHTML nowadays, with HTML5 as standard...

>  sub sanitize {
>  	my $str = shift;
>  
> 

