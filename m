Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,
	USER_IN_DEF_DKIM_WL shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A155A1F45F
	for <e@80x24.org>; Tue,  7 May 2019 23:26:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726360AbfEGX0D (ORCPT <rfc822;e@80x24.org>);
        Tue, 7 May 2019 19:26:03 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:33115 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726276AbfEGX0D (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 May 2019 19:26:03 -0400
Received: by mail-pg1-f196.google.com with SMTP id h17so3094830pgv.0
        for <git@vger.kernel.org>; Tue, 07 May 2019 16:26:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=T/JAm4edHB8umQQtnwQ7XebTjK0Arbeh8Q0WYBTR83Y=;
        b=ImUyI9HLTUi9e+6497777P1wVlcTc+Qza10l5n99lbpmhhyrHuXG7rhN/DifsI7yrd
         HtNvC0RruavHLxadfTxN5acsuSQZqUrCThOXbPB8eCaWRt08Mt5m84Yz1sC43pJGh0V5
         XjFufgizPjJ3Whb5c445XvNJdyhoPNA/LykvF0Bjutec6xLxSPgpNWQAleh3xmCJ6fzp
         KMUv+P1Lgn05rFYXwCamOQWEqYaFPhkLwDvJez+LXJu51OVbeaYpxBMQEwdmitZrXdym
         4sJSWBwBjtwO1+b22CzLegN6W4kvfhoo7iqdIDCpbqP1NW04iSBahG3AfcCSgjfBYDIm
         0mKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=T/JAm4edHB8umQQtnwQ7XebTjK0Arbeh8Q0WYBTR83Y=;
        b=bV9q1EyLqwv7hnG9k+he/gn2rTiplDL7KW2QLFMmgi4ZrtfmfqHn5UbcBo+SbFNWb7
         mx3d03Yv5lTf3ZuBB5gnI1bDxAuZqWKv+4kwziqe/DjLObnA1SGoAF7Nt1STX+Vf9AdB
         5PpT3ga3dKP3imPM/Ypz6WKLAwKphgwRVvoDhE6sTpsh6B0LtdtGADAUaEylfI+bdZnP
         opJX79L6W7SkCs2J5eUJjH6/AkFPMEvYoya0iyV9fc5baaju8keixwXp3J30wXzcOBQp
         p0COP3D8Afn6/IcGbhXeGSpG/jVpksw8pdN8U29SBQSMjzzcMfsPOcd2k+bZV4567SxY
         7woQ==
X-Gm-Message-State: APjAAAUV6cuyLf0HAks5OvhCrEfmI/ZaZ3+N0EUjtYciav/77LLQRSH6
        3gX9h1HHQrCagYB5tySBo8Wpm6hlC74ePA==
X-Google-Smtp-Source: APXvYqzhEmLJjU4Dd+ywQiDOTu+WB+s3QLRPDvbPRXCOUGcMD+iy9bRLujHxGJqScs/0TfaY1bs+0g==
X-Received: by 2002:a63:6849:: with SMTP id d70mr41986635pgc.21.1557271561120;
        Tue, 07 May 2019 16:26:01 -0700 (PDT)
Received: from google.com ([2620:0:100e:903:92a9:af1c:1897:8241])
        by smtp.gmail.com with ESMTPSA id j14sm18050873pfa.57.2019.05.07.16.25.59
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 07 May 2019 16:26:00 -0700 (PDT)
Date:   Tue, 7 May 2019 16:25:55 -0700
From:   Emily Shaffer <emilyshaffer@google.com>
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        Jonathan Tan <jonathantanmy@google.com>
Subject: Re: [PATCH v5 1/2] documentation: add tutorial for first contribution
Message-ID: <20190507232555.GA188866@google.com>
References: <20190423193410.101803-1-emilyshaffer@google.com>
 <20190507213040.151799-1-emilyshaffer@google.com>
 <20190507213040.151799-2-emilyshaffer@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190507213040.151799-2-emilyshaffer@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> +Add a line to `#include "config.h"`. Then, add the following bits to the
> +function body:
> +
> +----
> +	const char *cfg_name;
> +
> +...
> +
> +	git_config(git_default_config, NULL)
> +	if (git_config_get_string_const("user.name", &cfg_name) > 0) {
> +		printf(_("No name is found in config\n"));
> +	} else {
> +		printf(_("Your name: %s\n"), cfg_name);
> +	}

Just noticed the braces here, too. I have removed them from my local
copy and will upload again if I hear other comments warranting a v6.

 - Emily
