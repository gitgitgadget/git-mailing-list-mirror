Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E353E1F404
	for <e@80x24.org>; Mon, 17 Sep 2018 01:17:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727193AbeIQGl6 (ORCPT <rfc822;e@80x24.org>);
        Mon, 17 Sep 2018 02:41:58 -0400
Received: from mail-pg1-f170.google.com ([209.85.215.170]:41878 "EHLO
        mail-pg1-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727147AbeIQGl5 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 Sep 2018 02:41:57 -0400
Received: by mail-pg1-f170.google.com with SMTP id s15-v6so6836752pgv.8
        for <git@vger.kernel.org>; Sun, 16 Sep 2018 18:17:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=OOpJerbjerNN54d954+/1GD+HYV28NuRHaS/SWEOgrQ=;
        b=KUeYIA0ehFQEwei6zJwXEwyb4oYPzFxH5tctHg6pGBgrYtG5520YrWC+HST9+wkPOE
         9F5Vg87NgmwwdSugRTxb5XI+kkfuj4wZLt+2AualRcsOUpur9cr3YR5nskz3HtNpse4g
         Vdo7Tue+LwOKpxNHiY7dv1ts4oH+fquph8WMKrfKivhH1vHVTcXRtHhswKrBsm/pIckH
         mE7DAt5NE3Rqm5h8oZg3zm4nd747DBf46aIQZ+dzJjkQCK273d2OyXKhyzlNhpJ/LKBw
         pkiS/Lpx0RjMXws+2fFQ7t7uEydNdLSRZdiUxIYFNRpkVpWIK3eLVe8IKIQIsD2K4FP7
         3qzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=OOpJerbjerNN54d954+/1GD+HYV28NuRHaS/SWEOgrQ=;
        b=LRTkypjKVtgENtFfoavQChwxWV+JyOwCLHb4nKLNvP8h4l+IJP1bQiKU2IL+rfSwKQ
         /MikZwx+jHvNzRbyz9GuzbI6izKvKCy0uwaerSu1V8H5h9swFe8jTYkG65XHoLw+GK/t
         WSY12kIDW4bEoNzcAWEBlKe/qmFXZYSEm45v6sCxQ9HdLwQfYCotoreJ2uRFWeYYDKlh
         cO5UGCNwXHZQo7BiqPGlkuiHeSnRSDtfosnZ07PP5EJr4RoHw2k8Er3Y33ZYRskfg/4O
         36NPAt4d5iIX+vi9isFPy+O6ttOb2Xfg6U12zSQ8NsTHu+w5/eNrZjm+UHjaLVYpwF16
         LUCw==
X-Gm-Message-State: APzg51CxFr6KCu4E15eGuyX8Ai35em1eFNNysQbExIvcAu+xVoEIcRiw
        vQGO4e5TPfLtqlP4EuvJmOOBGU0j
X-Google-Smtp-Source: ANB0VdZqov7cOCAKa6LjfOVkDJIgDCu5XsGCEb3Re9/Dh4SrTFHYIqC7EoMELOmy8nHeBOQs+6LPdw==
X-Received: by 2002:a65:5581:: with SMTP id j1-v6mr21037313pgs.203.1537147020333;
        Sun, 16 Sep 2018 18:17:00 -0700 (PDT)
Received: from aiede.svl.corp.google.com ([2620:0:100e:422:4187:1d6c:d3d6:9ce6])
        by smtp.gmail.com with ESMTPSA id z11-v6sm20662672pfi.4.2018.09.16.18.16.59
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 16 Sep 2018 18:16:59 -0700 (PDT)
Date:   Sun, 16 Sep 2018 18:16:57 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Chris Coutinho <chrisbcoutinho@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: Question - no space in smtp-server-option
Message-ID: <20180917011657.GD154643@aiede.svl.corp.google.com>
References: <20180917010244.btmlczam5m75rmto@tumbleweed>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180917010244.btmlczam5m75rmto@tumbleweed>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Chris Coutinho wrote:

> Currently my gitconfig contains the following line:
>
> 	sendemail.smtpserveroption=-a<myaccount>
>
> Whereas, the following results in an 'account' not found error:
>
> 	sendemail.smtpserveroption=-a <myaccount>

Do you mean that your ~/.gitconfig literally contains that exact line?
I would be surprised to hear that syntax works --- see [1] for the
syntax I would expect to work.

If you have more details, that would help.

Thanks,
Jonathan

[1] https://www.kernel.org/pub/software/scm/git/docs/git-config.html
