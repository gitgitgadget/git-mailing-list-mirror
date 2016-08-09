Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C00621FD99
	for <e@80x24.org>; Tue,  9 Aug 2016 06:59:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752511AbcHIG7V (ORCPT <rfc822;e@80x24.org>);
	Tue, 9 Aug 2016 02:59:21 -0400
Received: from mail-it0-f66.google.com ([209.85.214.66]:34516 "EHLO
	mail-it0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752209AbcHIG7T (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Aug 2016 02:59:19 -0400
Received: by mail-it0-f66.google.com with SMTP id u186so447359ita.1
        for <git@vger.kernel.org>; Mon, 08 Aug 2016 23:59:19 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=hnKC3RfdWT0nQgWrLXxiQS5MOERySNe9XjbPk/3Ct+M=;
        b=iCU8aTvWtz7SDuybS8BbAD8Ei/7VASHwa9sO6wlMtqZcRI5udP2fKFpAP0dA+MPUjh
         hbw468HlvhAN1nZsLYLnwmyPdSYzSAY5MgkQ1d3vyo37d0keheHbCzO3xJ+E6GTIhZ7v
         mZ0geaF720CcIvG1SJ9ClMYCLn0epypBFb5IZOvOIrgciBFVM8PZxPQfGQOWHkW7Zjma
         GT3yEkHi/5ny8LaonFDTX9i7+N9sRMVxRoGO8CiYvgNNDdWMZK3NJIrpy2Ht4t4vwcoW
         iKBEXBDDQw4mhWfRJE41y0sNpipABADGbusip7GRjP6XJPvjGtP8axpKviM9fOXgWnU/
         HHJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=hnKC3RfdWT0nQgWrLXxiQS5MOERySNe9XjbPk/3Ct+M=;
        b=MywuKgWql7Q2EBLSy4dyx7+t+vlE4Gi+OIc6SEeb7nb4iMX6I5T7a0EhHG2m41OhQb
         uJ+xTwUzfs0XBsTdFzpRaZjTMUBe9NPmH0QzZ3miO/iDs2Z0/pQdTHCju/u1Q+wsmh63
         OhSrJnA7FXw+09WwuoMlwNrZ/i63pFB3WPJ9mEzjt/IH6VLI78qqc+rKsuy8QqeGFXCG
         hkwQl2P5UDTs5UjLeiqtG5ohwaqJDnw/+zxj16APltapzv0Oz1c4XShe1URZjzBroUyb
         957fviNU9CJaX7VC4rA9aD3tbqppRnkT+XnDQMrjzH/OjNMn7pHIUBmJ6u5yleIhUzNy
         MIdg==
X-Gm-Message-State: AEkoout7Eh8Iv2jYTRy64S4/IFmH109KoiEB6HtTsPjLTRDaoXprdjpp6xYtXHyiS982LBAEmGAPWieMmrCPjg==
X-Received: by 10.36.159.196 with SMTP id c187mr22439115ite.84.1470725959129;
 Mon, 08 Aug 2016 23:59:19 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.79.130.1 with HTTP; Mon, 8 Aug 2016 23:59:18 -0700 (PDT)
In-Reply-To: <20160809040811.21408-2-sbeller@google.com>
References: <20160809040811.21408-1-sbeller@google.com> <20160809040811.21408-2-sbeller@google.com>
From:	Eric Sunshine <sunshine@sunshineco.com>
Date:	Tue, 9 Aug 2016 02:59:18 -0400
X-Google-Sender-Auth: 220b2g04XPKo7YlAn4t4gX8tLqc
Message-ID: <CAPig+cRnDVMBZzKOOS-fW+hNaCHhYRVLM+d_akZcB4H5iyqfKA@mail.gmail.com>
Subject: Re: [PATCHv3 1/9] t7408: modernize style
To:	Stefan Beller <sbeller@google.com>
Cc:	Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	"Michael S. Tsirkin" <mst@redhat.com>
Content-Type: text/plain; charset=UTF-8
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Tue, Aug 9, 2016 at 12:08 AM, Stefan Beller <sbeller@google.com> wrote:
> t7408: modernize style
>
> Signed-off-by: Stefan Beller <sbeller@google.com>
> ---
> diff --git a/t/t7408-submodule-reference.sh b/t/t7408-submodule-reference.sh
> @@ -8,74 +8,76 @@ test_description='test clone --reference'
> +test_expect_success 'that reference gets used with add' '
> +       (
> +               cd super/sub &&
> +               echo "0 objects, 0 kilobytes" > expected &&

Since you're modernizing the style, perhaps drop the space after '>'
here and elsewhere.

> +               git count-objects > current &&
> +               diff expected current

Modern practice is to call this 'actual' rather than 'current', but
perhaps that's outside the scope of this patch(?).

> +       )
> +'
