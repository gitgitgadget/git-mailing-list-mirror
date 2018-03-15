Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7EEB61F404
	for <e@80x24.org>; Thu, 15 Mar 2018 20:41:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932587AbeCOUls (ORCPT <rfc822;e@80x24.org>);
        Thu, 15 Mar 2018 16:41:48 -0400
Received: from mail-wr0-f193.google.com ([209.85.128.193]:32843 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932345AbeCOUlq (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Mar 2018 16:41:46 -0400
Received: by mail-wr0-f193.google.com with SMTP id z73so5379078wrb.0
        for <git@vger.kernel.org>; Thu, 15 Mar 2018 13:41:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=MbR6T5sc2rKIi+povrII6b1fhOy34Kbsbyq1SoIRAFE=;
        b=oPJm9VhFjfHJkg8tNUXG158Ox7dmR0p/ScxTfewHoSvhCVF0Y4GY7OGvxdRJxuh7EH
         9vqf7yfN5itqC/mQhQswVALfcNGjkYE3fQXeRM+ebrVdVAr4qCDTFY9b70TkhB+4qbtf
         l4SXWxnL1Wx1ygjoovVQi8zbBovqM8ShvsZRQLC2VPtLkgKR7Q1OVDFPA+Xn5sk2hB40
         khExH07/NsqLNUqVW63cVYyurpsNFiWPGtNDZeF6bB5jPdhGX8Gr3VXiWFj0/L5UWpKt
         57lDyWh5Fb8L8EaOtCSjsaoIV3WXKI8qZpKOXFqxX9zQOGlMiu5bAprRYmg5qHRyBghF
         SvPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=MbR6T5sc2rKIi+povrII6b1fhOy34Kbsbyq1SoIRAFE=;
        b=lsjVcbN6L2SdktArc1qc2A/MMZW7DLWMB7AcNUNfRidy+/0GxoCE99z9DYH+bpBESo
         F/QLc/IPL/H8krufCIHt2IaJbZW+sfR2ZfHMfIupckiWf0Hwh2OiIyE6MhjMhv0QsQ0T
         zexKqJk5caxODILJQIyDXW8nTtVXuTiCdRGb7eK00iWSM5c1uDZ+BjsVUj+jx4CJN4cl
         DARMA6exK1Zw+Tlkd26UQw7w0YOsUOchE0qI7nsyJNtKE6ZqllYuNIoxfg91nsqxdruq
         r1J7o1XJDQa2H2s3YQq8VfAv2TLf8x3P2pF12wEC/DpEntGkXO6Spxd09vtVoUf3hr2T
         IZFw==
X-Gm-Message-State: AElRT7Ey9V2SYmXCdNvgCwSJ7n7ICoBEiDoxwUCtun77kyrSshdMI1SN
        eFtb8z4Sakn/dL9wlsiGcEc=
X-Google-Smtp-Source: AG47ELsEeLdcuL1RFmN+aN0ioESOArVhWnYjIEUnEVLowg6PKl/wFxGWNfcVrCjdg1hEjlHRketfxA==
X-Received: by 10.223.175.99 with SMTP id z90mr8686361wrc.258.1521146505416;
        Thu, 15 Mar 2018 13:41:45 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id k130sm6079432wmg.9.2018.03.15.13.41.44
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 15 Mar 2018 13:41:44 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
Cc:     Git mailing list <git@vger.kernel.org>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v4 3/3] t/t3200: fix a typo in a test description
References: <20171102065407.25404-1-kaartic.sivaraam@gmail.com>
        <20180310155416.21802-1-kaartic.sivaraam@gmail.com>
        <20180310155416.21802-4-kaartic.sivaraam@gmail.com>
Date:   Thu, 15 Mar 2018 13:41:44 -0700
In-Reply-To: <20180310155416.21802-4-kaartic.sivaraam@gmail.com> (Kaartic
        Sivaraam's message of "Sat, 10 Mar 2018 21:24:16 +0530")
Message-ID: <xmqqh8ph3wc7.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Kaartic Sivaraam <kaartic.sivaraam@gmail.com> writes:

> Signed-off-by: Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
> ---
>  t/t3200-branch.sh | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Thanks.  It is very nice to see unrelated issues nearby found while
working on something else.  Will queue.

>
> diff --git a/t/t3200-branch.sh b/t/t3200-branch.sh
> index 503a88d02..6c0b7ea4a 100755
> --- a/t/t3200-branch.sh
> +++ b/t/t3200-branch.sh
> @@ -528,7 +528,7 @@ test_expect_success 'git branch -c -f o/q o/p should work when o/p exists' '
>  	git branch -c -f o/q o/p
>  '
>  
> -test_expect_success 'git branch -c qq rr/qq should fail when r exists' '
> +test_expect_success 'git branch -c qq rr/qq should fail when rr exists' '
>  	git branch qq &&
>  	git branch rr &&
>  	test_must_fail git branch -c qq rr/qq
