Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 87DB820305
	for <e@80x24.org>; Mon,  8 Apr 2019 01:10:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726457AbfDHBKQ (ORCPT <rfc822;e@80x24.org>);
        Sun, 7 Apr 2019 21:10:16 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:37400 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726349AbfDHBKQ (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 7 Apr 2019 21:10:16 -0400
Received: by mail-wm1-f65.google.com with SMTP id v14so12807341wmf.2
        for <git@vger.kernel.org>; Sun, 07 Apr 2019 18:10:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=3nPaTCpsOp24Y/PrzTmYERIRb+odI4MAAiUZAgMQoMc=;
        b=C73N9qaiYg7MyqDCamnFYjOq+p2/pOGyPMYOBkZDT2WLWHQ28zwTT2RKGtrT4nXbIV
         lxdvsuviXmb28LiCmqZaQp2mu8o1kUAlCqS1RpWOFl3WUSo9I3PEQHlknq7q/OL+COZi
         cV4ERrFCM+eSovA+qHAqBLxcdrT9PfLe9lRXTPj00TwJa8N4sxg/99gwU9MoSPi9wBQW
         pXvrSatY2WAwD6d5wYuYxqGfnZ0pNgjnptkHEIi4z6s4rQLh9raKAd1Quyv/OubRkIVc
         LbAp4JvJVPXxBP2aXsQ6ZjA8fNedsfxYZhkljsCuosUhmkuD+J0Utc/ThatRlciMUFc3
         COEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=3nPaTCpsOp24Y/PrzTmYERIRb+odI4MAAiUZAgMQoMc=;
        b=W5b1fYPNQzNDT+lAA5vkJUyT+bo6tJDwmDAZgU8QGfugCOd3cgTXkzznPAUxlNm08Y
         XTR5HYSzrH9h16pIY4dZNG8+8WvYjkC++m1+gPPOYvzyEjLo+wcrJhEK3W1boowvBfgw
         c/9lsaSnB/NpAhONUuIBE83lZaVCU4kPXpL9B9JPTsjzKrzhzwpSHUxip4Xb9PT3kHv4
         7QQNaSlqHvKRt6XumXuvo4A8iR9TbnWbEA+d6KQHxOFoTLhOrCWgudbY8sZIgXjX5Z6H
         XV6Klp1MraKLDDdg9hIlUIDjoHxc6buMQ1U+fGcGfSvJ/tp97nlkG1zX28OnYTBmRUbM
         EsWA==
X-Gm-Message-State: APjAAAWSe7Df6yS11+f8E9LgtiX9tbGFR4+JjKEMt3sD9JFzmAZzTTjg
        YsBzoBUm2ALke6p/i+YQ6KU=
X-Google-Smtp-Source: APXvYqyzq2KWgSF4GrpregWZon+0NB+uDKXhE5OOKeibB5tVra8m1lnKbCbJEM7YUtankzcoJaLdkA==
X-Received: by 2002:a1c:1d49:: with SMTP id d70mr15813751wmd.36.1554685814100;
        Sun, 07 Apr 2019 18:10:14 -0700 (PDT)
Received: from localhost (141.255.76.34.bc.googleusercontent.com. [34.76.255.141])
        by smtp.gmail.com with ESMTPSA id r9sm25467353wrv.82.2019.04.07.18.10.13
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 07 Apr 2019 18:10:13 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Philip Oakley <philipoakley@iee.org>
Cc:     GitList <git@vger.kernel.org>
Subject: Re: [PATCH 1/2] rerere doc: quote `rerere.enabled`
References: <20190406132747.16376-1-philipoakley@iee.org>
        <20190406132747.16376-2-philipoakley@iee.org>
Date:   Mon, 08 Apr 2019 10:10:13 +0900
In-Reply-To: <20190406132747.16376-2-philipoakley@iee.org> (Philip Oakley's
        message of "Sat, 6 Apr 2019 14:27:46 +0100")
Message-ID: <xmqq8swlcney.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Philip Oakley <philipoakley@iee.org> writes:

> Signed-off-by: Philip Oakley <philipoakley@iee.org>
> ---
> Noticed while attempting to train the Git-for-Windows rebasing-
> merge series.
> ---
>  Documentation/git-rerere.txt | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/Documentation/git-rerere.txt b/Documentation/git-rerere.txt
> index df310d2a58..95763d7581 100644
> --- a/Documentation/git-rerere.txt
> +++ b/Documentation/git-rerere.txt
> @@ -24,7 +24,7 @@ on the initial manual merge, and applying previously recorded
>  hand resolutions to their corresponding automerge results.
>  
>  [NOTE]
> -You need to set the configuration variable rerere.enabled in order to
> +You need to set the configuration variable `rerere.enabled` in order to
>  enable this command.

OK.  That sounds good.

Thanks.
