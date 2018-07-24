Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 85D4F1F597
	for <e@80x24.org>; Tue, 24 Jul 2018 04:52:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388285AbeGXF5K (ORCPT <rfc822;e@80x24.org>);
        Tue, 24 Jul 2018 01:57:10 -0400
Received: from mail-pl0-f65.google.com ([209.85.160.65]:38922 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388251AbeGXF5K (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Jul 2018 01:57:10 -0400
Received: by mail-pl0-f65.google.com with SMTP id m1-v6so1182413plt.6
        for <git@vger.kernel.org>; Mon, 23 Jul 2018 21:52:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ObAn0oKTLvfjV4rZdXxemZ92crZ/8GuQ88i6/6Eyb6A=;
        b=KO+sIuqhsyMBXD3qWJP9BvHznuh0JwUmQI4r+fFIAUC/7xOd/n59jWNxgEmQ1FPxto
         fP8usauXEKKI0zB6mULPe3hwQmAKWBfqOQoQoCalFjg8aYI8pS2WNa439ZKKfC17rwpS
         LAaa3/wRzxOtgBQryUy5tqJ0D/gZT1q+G9bJGcrTDAGtb9Umf6zPgpauHZwyOniGnIMM
         OnN/jaUJ1z/Wv+8aiOxZkQ6xGCgRgC+eTVy3Myfp45pHaa40lO61dX3yBuuxTdkSWE53
         qdVJIcS6rVtlFnfVV7I+cFLo15R0ZnIq2W7XVM9RgJ5bRKD/pvqn82onuGnEUEh0fysJ
         vyBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ObAn0oKTLvfjV4rZdXxemZ92crZ/8GuQ88i6/6Eyb6A=;
        b=Uny8P3hUlL5P0rBLA5qGH4/KqvScktg8IET3jn5Vxl44HSZGiy2TcPr0YMr7+5Pk0F
         vOq156j0ul6lOVoZdtkH2abP2j/VMh7SP/8oUK0FLj3E1Rf6Bz1TxrN/4n5DTAQxdO7g
         GN74e3Z/l/IQav07GATkcxSwZN2mt0HgC7QhyUuSPaKuBm5Hd0OSHZACIsuh93yC8sZ0
         WpSgLZhG4IIG/cb0zs89/7rgARYfLsYe7KfiVz40Y36XuDzHAp4ndCYr7iiLFjX4qcCj
         bVvFwrQanlh+LSSorgsaJifeMDVkvFBHmfjuCVv5ecipSCBHFPZhVDgHvYVIChSKihXu
         8lVQ==
X-Gm-Message-State: AOUpUlGV0gJbC9HE+Rb+XZ6/qneFM9sL7jpcIwwAS6/uten6u5Gq9+GQ
        kO5hTICyTvK2PXUXQHVzJzA=
X-Google-Smtp-Source: AAOMgpftGNmdxT8Ba4z8PVmtyaQrQOiKgf2E9ABqzUmp8sLkAom5x3FmfEPOnR6DcFXfso/wzzC7GQ==
X-Received: by 2002:a17:902:6bc8:: with SMTP id m8-v6mr15853350plt.162.1532407955350;
        Mon, 23 Jul 2018 21:52:35 -0700 (PDT)
Received: from aiede.svl.corp.google.com ([2620:0:100e:422:4187:1d6c:d3d6:9ce6])
        by smtp.gmail.com with ESMTPSA id o3-v6sm12191866pgp.3.2018.07.23.21.52.34
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 23 Jul 2018 21:52:34 -0700 (PDT)
Date:   Mon, 23 Jul 2018 21:52:33 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Brandon Williams <bmwill@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] pack-protocol: mention and point to docs for protocol v2
Message-ID: <20180724045233.GB208393@aiede.svl.corp.google.com>
References: <20180723174807.28903-1-bmwill@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180723174807.28903-1-bmwill@google.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Brandon Williams wrote:

> --- a/Documentation/technical/pack-protocol.txt
> +++ b/Documentation/technical/pack-protocol.txt
> @@ -50,7 +50,8 @@ Each Extra Parameter takes the form of `<key>=<value>` or `<key>`.
>  
>  Servers that receive any such Extra Parameters MUST ignore all
>  unrecognized keys. Currently, the only Extra Parameter recognized is
> -"version=1".
> +"version" with a vlue of '1' or '2'.  See protocol-v2.txt for more

value?

> +information on protocol version 2.

Thanks.  Some thoughts on other parts of this document that may need
updating:

- the whole document assumes that 0 and 1 are the only protocol
  versions.  E.g. the discussion of the version number line in the
  response when "version=1" is sent as an Extra Paramter should probably
  apply to version 2, too.

- because the document was written before protocol v2, it describes the
  more complicated v1 that many readers shouldn't have to care about

- there is no one document that describes v2 in a self contained way,
  since protocol-v2.txt makes reference to protocol v1.

- the description of pkt-line format in protocol-common.txt is missing
  a discussion of delim-pkt.

Not about this patch, but I wonder if an organization along the
following lines would make sense?

 1. Rename pack-protocol.txt to protocol-v1.txt.  Rename
    protocol-v2.txt to pack-protocol.txt.

 2. Make pack-protocol.txt self-contained, and remove any redundant
    sections from protocol-v1.txt.

 3. Add a new protocol-v2.txt that briefly describes the benefits and
    highlights of protocol v2, referring to pack-protocol.txt for
    details.

That way, newcomers of the future could read pack-protocol.txt and
quickly glean the main protocol in (then) current use.

What do you think?

Thanks,
Jonathan
