Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 90D7B1F404
	for <e@80x24.org>; Mon, 10 Sep 2018 21:30:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726402AbeIKC0J (ORCPT <rfc822;e@80x24.org>);
        Mon, 10 Sep 2018 22:26:09 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:44567 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726121AbeIKC0J (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Sep 2018 22:26:09 -0400
Received: by mail-pg1-f196.google.com with SMTP id r1-v6so11098600pgp.11
        for <git@vger.kernel.org>; Mon, 10 Sep 2018 14:30:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=HgyGGfYhbnua+AdEjqFQ0QvsVPeKbHVrXvsYmKwXrEg=;
        b=A/T9vAwjIOdvqL/zmRu6PbMi2yu79pZaY3rCEGQtuoSCXntZarvbrKPhS5eyY4phzu
         lKCqyPW+SS73Ov3mWVp3RlFaGknRKIOe4C9oxA7bLVpvuedaLUcHsq6CA795lDdvqUxL
         vkyIfn2QFuWSL5lT9m5Pzk1hqPDVRzQdvh79MalhHTYXVfGu2SjCLaMUwH6AFxJuPOXG
         aSCO+Iu1BPZk37AeJ24B8McFocfmXg3dbjseP89rPhRzFakeF+jEZx7pocm8rzSHHWzM
         regU7RlBtU7nwgy1RrDYFLx3ChDX/2x4dHI5R1XWzSHU18C5gx01aGBH6dXPSXluKDVx
         fA+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=HgyGGfYhbnua+AdEjqFQ0QvsVPeKbHVrXvsYmKwXrEg=;
        b=nWOxqt6kA5fiClqDpCWDiCVqdIdXa71Dies1u+BnNw3YH0asvmdBOD6QBZeKqIqg4m
         0O2nurlKOy/LOol+/yKejlGTnj+ZsUZ9whas+iykh1sK3aIaqwkYHG97TRlskmp2ccx7
         1qcuS6HwvAgduIRFBmwHjssc4QSO1inVQIaqmou6oziXQmCzsNheOTrn1yfAB2OryEmv
         NZ+5Uo6eyTBGLbi2hZH1NbYN+jm4OUedt0ARGWklZT1u4EpgLwJy7N37lKkMKZXUrY2j
         rikhzaXdKL6J13WdUeTyF9aSoJfrSV9t8l7kotCHHOxzTZdk5dzBQoDll6h35CV63+nq
         OzdA==
X-Gm-Message-State: APzg51A4uJWmkgH8cD24/MFJpt6ETglNcQYv90HUUlfbbX3VVipfV55i
        zT46Ct3hwyDFr7XrqJQylh4=
X-Google-Smtp-Source: ANB0VdZJXCYrhJXXgeBB2NeucjJ5svAzLLKn7bmdb7SXeXkt4EDEdplMR2WiKiO32lP6fxDclbov1Q==
X-Received: by 2002:a62:2983:: with SMTP id p125-v6mr25796972pfp.128.1536615009225;
        Mon, 10 Sep 2018 14:30:09 -0700 (PDT)
Received: from aiede.svl.corp.google.com ([2620:0:100e:422:4187:1d6c:d3d6:9ce6])
        by smtp.gmail.com with ESMTPSA id h10-v6sm32189824pfj.78.2018.09.10.14.30.08
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 10 Sep 2018 14:30:08 -0700 (PDT)
Date:   Mon, 10 Sep 2018 14:30:06 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Josh Steadmon <steadmon@google.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] config: document value 2 for protocol.version
Message-ID: <20180910213006.GH26356@aiede.svl.corp.google.com>
References: <20180522223208.GQ10623@aiede.svl.corp.google.com>
 <20180910212157.134291-1-steadmon@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180910212157.134291-1-steadmon@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Josh Steadmon wrote:

> From: Brandon Williams <bmwill@google.com>
>
> Update the config documentation to note the value `2` as an acceptable
> value for the protocol.version config.
>
> Signed-off-by: Brandon Williams <bmwill@google.com>
> Signed-off-by: Josh Steadmon <steadmon@google.com>
> ---
>  Documentation/config.txt | 2 ++
>  1 file changed, 2 insertions(+)

Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>

Thanks.
