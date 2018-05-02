Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-8.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 297BF200B9
	for <e@80x24.org>; Wed,  2 May 2018 23:17:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751741AbeEBXRV (ORCPT <rfc822;e@80x24.org>);
        Wed, 2 May 2018 19:17:21 -0400
Received: from mail-pf0-f177.google.com ([209.85.192.177]:46180 "EHLO
        mail-pf0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751562AbeEBXRU (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 May 2018 19:17:20 -0400
Received: by mail-pf0-f177.google.com with SMTP id p12so13057734pff.13
        for <git@vger.kernel.org>; Wed, 02 May 2018 16:17:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=7/90R7Lkz6raL0RrUxMmHmG+6sCEfv8cl65ZpSnBn48=;
        b=Mr4Zp2sRoIZJTeZbOqMNKtjdpPt5nkKYlebksJ8VuPJkd7dhumqkcEVc7ZoIMQuPXq
         d4yQ7EiZ6UzJf47zATNTQ1v8MNy52p9zE1Ca+6vDV8UJoZEUjk+oGgLFX+RXp2OSPUyQ
         ar+8Uw9sk6cTGpvcRRdPwg+S84ZYklDvM3Hn+Hb/n3cE1hZB5HNsHhFoIYoEZik2Dvmw
         PPf+Zv2irTFkmDiH2VDbLCKJGpYU5cba+bmn4L2nfiLIdwtHIPYG6CSS0Fxl4Wr8MD9G
         UrRIkodSgwiM4EUAy9Z0teIJC25hszhDNMDRQka3YvawZ4dICGbi0FaPsnB4NpQUIJOY
         Dvaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=7/90R7Lkz6raL0RrUxMmHmG+6sCEfv8cl65ZpSnBn48=;
        b=ElbmdI90fILnI2yV77sVbSk8k1RyaHjxrcCnjP2lSd84uYVNrr4f2TwfiDUya806q3
         gBibfKBNBMlW9tfoAKz2SRJx7D1kHQgVIIFQBAkFNhS0ih0zVy42l2pKgZ97Kq6oW2kq
         IFDF0GhC+0XnLxsY3aRE+aDQyukJR2zrUIxqtQhY1kuT2JAh1sZU/3zog8EEF3DY09pv
         J3ThKaCPJpRP9bQqsGcpUSuvGQzIHZNL06kibsww6FpFfgle6ZSzX8Sk2PgOSGGkVch9
         qaZxXTOLN5jpMBTSv7kkWYaoe0/EcMxQbXSAYVJKRFl1wCDH8kswhzntnWfPUx0oGIbM
         C2KQ==
X-Gm-Message-State: ALQs6tCbVTRw6Pw8oke0sfFsRllQjouqp7peg+x80y90vnv2xOxsPpd0
        VSlaYTOrqt6liOClJ1nK+X+YHw==
X-Google-Smtp-Source: AB8JxZoo0v2dRoiQ+TnASgCcF/AOGGAqvzz7fT8A/65hEmm4Cy5MThKU/LxmyFc1VigZHsAHoxnXiQ==
X-Received: by 2002:a63:7d13:: with SMTP id y19-v6mr17542618pgc.160.1525303039891;
        Wed, 02 May 2018 16:17:19 -0700 (PDT)
Received: from google.com ([2620:0:100e:422:ff43:9291:7eda:b712])
        by smtp.gmail.com with ESMTPSA id v16sm35383861pfk.164.2018.05.02.16.17.18
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 02 May 2018 16:17:19 -0700 (PDT)
Date:   Wed, 2 May 2018 16:17:16 -0700
From:   Brandon Williams <bmwill@google.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: What's cooking in git.git (Apr 2018, #04; Mon, 30)
Message-ID: <20180502231716.GB122314@google.com>
References: <xmqq4ljtz87g.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqq4ljtz87g.fsf@gitster-ct.c.googlers.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 04/30, Junio C Hamano wrote:
> * bw/protocol-v2 (2018-03-15) 35 commits
>   (merged to 'next' on 2018-04-11 at 23ee234a2c)
>  + remote-curl: don't request v2 when pushing
>  + remote-curl: implement stateless-connect command
>  + http: eliminate "# service" line when using protocol v2
>  + http: don't always add Git-Protocol header
>  + http: allow providing extra headers for http requests
>  + remote-curl: store the protocol version the server responded with
>  + remote-curl: create copy of the service name
>  + pkt-line: add packet_buf_write_len function
>  + transport-helper: introduce stateless-connect
>  + transport-helper: refactor process_connect_service
>  + transport-helper: remove name parameter
>  + connect: don't request v2 when pushing
>  + connect: refactor git_connect to only get the protocol version once
>  + fetch-pack: support shallow requests
>  + fetch-pack: perform a fetch using v2
>  + upload-pack: introduce fetch server command
>  + push: pass ref prefixes when pushing
>  + fetch: pass ref prefixes when fetching
>  + ls-remote: pass ref prefixes when requesting a remote's refs
>  + transport: convert transport_get_remote_refs to take a list of ref prefixes
>  + transport: convert get_refs_list to take a list of ref prefixes
>  + connect: request remote refs using v2
>  + ls-refs: introduce ls-refs server command
>  + serve: introduce git-serve
>  + test-pkt-line: introduce a packet-line test helper
>  + protocol: introduce enum protocol_version value protocol_v2
>  + transport: store protocol version
>  + connect: discover protocol version outside of get_remote_heads
>  + connect: convert get_remote_heads to use struct packet_reader
>  + transport: use get_refs_via_connect to get refs
>  + upload-pack: factor out processing lines
>  + upload-pack: convert to a builtin
>  + pkt-line: add delim packet support
>  + pkt-line: allow peeking a packet line without consuming it
>  + pkt-line: introduce packet_read_with_status
>  (this branch is used by bw/server-options.)
> 
>  The beginning of the next-gen transfer protocol.
> 
>  Will merge to 'master'.

Awesome, I see you're already planning on merging this!  I was just
going to drop by and saw that internal testing showed that this *should*
be ready to be merged to master :)  Thanks!

-- 
Brandon Williams
