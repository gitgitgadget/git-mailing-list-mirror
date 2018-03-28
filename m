Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-1.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3AC4C1F404
	for <e@80x24.org>; Wed, 28 Mar 2018 20:27:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753282AbeC1U1q (ORCPT <rfc822;e@80x24.org>);
        Wed, 28 Mar 2018 16:27:46 -0400
Received: from mail-pf0-f171.google.com ([209.85.192.171]:32946 "EHLO
        mail-pf0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753074AbeC1U1p (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Mar 2018 16:27:45 -0400
Received: by mail-pf0-f171.google.com with SMTP id f15so1605163pfn.0
        for <git@vger.kernel.org>; Wed, 28 Mar 2018 13:27:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=luWSK4OXvEA4M+VxwN5gn4baMRr/lY8ORgmlVDk3730=;
        b=XjGf5hO2WQ32+8eASAfyPpAnGm8CzN3BdoN3TkkuQtZubfHiLBsL/uhPz5yMLbVWjA
         YxdfbqNS3NWzlhm0yean+e1F9xK4tEKb8Xpz+vlQradkX1U34FHBZO3T9l5ESQeIwBzX
         63Hl0hdUDRUPSN9fWBlvQ3yJoU723eONmYIn7IH4LSA1eeDrUXR4+alEpmu+CJ8vZAcM
         nSrDT4Fzcwaqv+scRTR5BJamS3D9elf8fX0smAnn4+BiObtkJ5jEWInuuN4ZK16en9ZE
         Oi+dW2UWL5/CK9rmwABHepi/uz00LIoO8/8xQuwU5PIBq9FRK0Y0ekn7CZ/85p9lv6bk
         DAvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=luWSK4OXvEA4M+VxwN5gn4baMRr/lY8ORgmlVDk3730=;
        b=Yzqow16wWcxBu2IcDtSmC1CUX+9MLtB5tzMqYFNOhYfc34xr9CNSETjbcVdNXX2gC7
         OUPI8Oi0uEUUMkTNnESMEixmE10PtGb+ifVjH2u4YH1rmqdk6pVZ8p+CnZfYG2XlqIRf
         gm2aT76JOvK2y5dYwY+lcr7yNh44MXhkcCVN+AFnfD8cvgg08u11gK3PD2XWEpR7EtRl
         pm4zQ5LNahc2ivw1ypG04t/vxFKJUaIUjCymtRU/MRN7g1DRH8CRUl6H+DkzXhy2PwqH
         NGUywPXsJYZJJQcKVL5R+Q7S29uP73dcVgjAu5ZL17kQnr8YiczUbK2915aN0iwCz0+t
         oIEg==
X-Gm-Message-State: AElRT7HxG9IOu7qG3RDEybGuw1gq+mYqyt8ERlcTvt6jIMDkU21R24k3
        YkLFsdrfnE+1DnfXmyD/vv2n0w==
X-Google-Smtp-Source: AIpwx4/Q+hwD9w4NJgZUlhi47nOOHSpNnWTWS8+DjpH+1qmZa8kc1d0nzCCgOJcVU5DIYhCnyRtVrw==
X-Received: by 10.101.99.213 with SMTP id n21mr3537458pgv.202.1522268864289;
        Wed, 28 Mar 2018 13:27:44 -0700 (PDT)
Received: from google.com ([2620:0:100e:422:ff43:9291:7eda:b712])
        by smtp.gmail.com with ESMTPSA id a3sm7920703pgv.14.2018.03.28.13.27.42
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 28 Mar 2018 13:27:43 -0700 (PDT)
Date:   Wed, 28 Mar 2018 13:27:42 -0700
From:   Brandon Williams <bmwill@google.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: What's cooking in git.git (Mar 2018, #05; Wed, 28)
Message-ID: <20180328202742.GA171603@google.com>
References: <xmqqsh8k6khj.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqsh8k6khj.fsf@gitster-ct.c.googlers.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 03/28, Junio C Hamano wrote:
> * bw/protocol-v2 (2018-03-15) 35 commits
>  - remote-curl: don't request v2 when pushing
>  - remote-curl: implement stateless-connect command
>  - http: eliminate "# service" line when using protocol v2
>  - http: don't always add Git-Protocol header
>  - http: allow providing extra headers for http requests
>  - remote-curl: store the protocol version the server responded with
>  - remote-curl: create copy of the service name
>  - pkt-line: add packet_buf_write_len function
>  - transport-helper: introduce stateless-connect
>  - transport-helper: refactor process_connect_service
>  - transport-helper: remove name parameter
>  - connect: don't request v2 when pushing
>  - connect: refactor git_connect to only get the protocol version once
>  - fetch-pack: support shallow requests
>  - fetch-pack: perform a fetch using v2
>  - upload-pack: introduce fetch server command
>  - push: pass ref prefixes when pushing
>  - fetch: pass ref prefixes when fetching
>  - ls-remote: pass ref prefixes when requesting a remote's refs
>  - transport: convert transport_get_remote_refs to take a list of ref prefixes
>  - transport: convert get_refs_list to take a list of ref prefixes
>  - connect: request remote refs using v2
>  - ls-refs: introduce ls-refs server command
>  - serve: introduce git-serve
>  - test-pkt-line: introduce a packet-line test helper
>  - protocol: introduce enum protocol_version value protocol_v2
>  - transport: store protocol version
>  - connect: discover protocol version outside of get_remote_heads
>  - connect: convert get_remote_heads to use struct packet_reader
>  - transport: use get_refs_via_connect to get refs
>  - upload-pack: factor out processing lines
>  - upload-pack: convert to a builtin
>  - pkt-line: add delim packet support
>  - pkt-line: allow peeking a packet line without consuming it
>  - pkt-line: introduce packet_read_with_status
> 
>  The beginning of the next-gen transfer protocol.
> 
>  Is everybody happy with this version?  One design decision with
>  larger consequence "to or not to build in?" has been settled in
>  favor of status quo, IIRC.

I haven't heard anymore complaints with this version so I *think* it
should be good.

-- 
Brandon Williams
