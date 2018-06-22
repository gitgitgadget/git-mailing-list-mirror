Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DAE8D1F516
	for <e@80x24.org>; Fri, 22 Jun 2018 19:38:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934266AbeFVTiB (ORCPT <rfc822;e@80x24.org>);
        Fri, 22 Jun 2018 15:38:01 -0400
Received: from mail-pg0-f67.google.com ([74.125.83.67]:33837 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934088AbeFVTiA (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Jun 2018 15:38:00 -0400
Received: by mail-pg0-f67.google.com with SMTP id q4-v6so3400089pgr.1
        for <git@vger.kernel.org>; Fri, 22 Jun 2018 12:38:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=2zagzr3tKTRyo0Z476HgWnwradnJSeyF/wYKsZ4m+ks=;
        b=d+7iYAxde2ZwhjsP74F89OwKp7NEAOyH/WiUUJSxf0QcAhzzZe2a3x45P2L0kXZ+7S
         1iSzbK+zxHqBnrH6mhgy7iQNKzrY7ZmUyPLLTGfRvucVx9YyNqPt+5Rw8f49u9YBU9dU
         mD+ZVtOxR7hSaiB9xj4TKM4OoN9wdOVmIzna2gLlEx3EmXtgyYwtdxoIXmvMYhf/3r4n
         V+/p7nWPkMxgvLFmQgBZbWsBc3Ymzvg2AQpgRUJF37xTYuFOl483cFzYOgbR6BuHh2FE
         EhKnB/5XpTbe0oMR6RUqKfmIs2JC+4fMzm8KLAKYPNtAt8XBqjjqVBplB0jDSylTeVas
         8lWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=2zagzr3tKTRyo0Z476HgWnwradnJSeyF/wYKsZ4m+ks=;
        b=bhjUPgv1KDHKgeDx/rJD9dOdWcuP49iUkSCzdYHzw7xWUdOp7XWsIi5iIAfLpE/qUy
         3FaaG52aXB1sdFzCLyWhgWGMyGpF4eoAi00EzOHtnRKAL4CQVbxaG15goJe5cGLyTdKV
         n+WT8D0kIWQE67MCOlUDpsBRhet5zgYWWqhVDDXVEJJZ8SQbsc5c4Ib8QUjJWQiv22k6
         zwokg4O3YS9VWBSnnPHhporagzFXHhjpI0D0G02l6vTBKWQJEvSDPcy1GxH1GdSOG1XQ
         CPeA6fVISzX9mDR98WX+lZMAlEFy/oNMNMsBV8/4mjkcmLCflmAVQ77TdmsN9MTLOQnG
         oN6Q==
X-Gm-Message-State: APt69E1z1a3WetAOiVajq6zWcnFuKnmrl9ZjsrcH7RDvGNpCPNPDqH7l
        m7c0/9NWRvT6GKolJJM8wNk=
X-Google-Smtp-Source: ADUXVKIY7gS7kBgirqcDjXNVPjX/mL2nZi/qCgTm9Kpd1JDDZeOtmzIqLryDMFmTwfI1rtBuaNNwgA==
X-Received: by 2002:a62:1282:: with SMTP id 2-v6mr3084255pfs.243.1529696279915;
        Fri, 22 Jun 2018 12:37:59 -0700 (PDT)
Received: from aiede.svl.corp.google.com ([2620:0:100e:422:4187:1d6c:d3d6:9ce6])
        by smtp.gmail.com with ESMTPSA id l85-v6sm16213997pfk.79.2018.06.22.12.37.58
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 22 Jun 2018 12:37:59 -0700 (PDT)
Date:   Fri, 22 Jun 2018 12:37:57 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Josh Steadmon <steadmon@google.com>
Cc:     git@vger.kernel.org, bmwill@google.com
Subject: Re: [PATCH] protocol-v2 doc: put HTTP headers after request
Message-ID: <20180622193757.GF12013@aiede.svl.corp.google.com>
References: <20180622190112.7559-1-steadmon@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180622190112.7559-1-steadmon@google.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Josh Steadmon wrote:

> HTTP servers return 400 if you send headers before the GET request.
>
> Signed-off-by: Josh Steadmon <steadmon@google.com>
> ---
>  Documentation/technical/protocol-v2.txt | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)

Thanks.  Congrats on your first patch! ;-)

Tested using

  openssl s_client -connect github.com:443

with input

  GET /git/git/info/refs?service=git-upload-pack HTTP/1.0
  Host: github.com
  Git-Protocol: version=2

which produces a 404 instead of the 400 that putting Git-Protocol
in front would produce.

Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>
