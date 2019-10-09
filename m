Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-1.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 899281F4BD
	for <e@80x24.org>; Wed,  9 Oct 2019 01:49:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729651AbfJIBs7 (ORCPT <rfc822;e@80x24.org>);
        Tue, 8 Oct 2019 21:48:59 -0400
Received: from mail-pl1-f181.google.com ([209.85.214.181]:37545 "EHLO
        mail-pl1-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726109AbfJIBs7 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Oct 2019 21:48:59 -0400
Received: by mail-pl1-f181.google.com with SMTP id u20so251010plq.4
        for <git@vger.kernel.org>; Tue, 08 Oct 2019 18:48:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=r7LJQPKzKLI44gs2sRlHJHn71CY4NsCWIVJR7gYj7Zg=;
        b=WZDTYEE/utoL+yShHW6yKUtnIQF133BFBk6Jp7ZyJhmZWiwxC+Y4fAgbk6n42XOXqn
         ommtyxgJ53ZSdLDXWhrkoAFKKA5VhL6PMswV8cICanO+VlCvFp+S+pgJpXvAWz4f54eS
         VJ2Km7UXlTw/DCnJYnKb/02uSzxjZTMSdFMh+GnsAEDNSn7pPNzJxi9qmcAV4Vd0noTz
         r8/Gf1JOhCER0AuSreiK2rqkC7shhoCedYv+42NYmC7ADC14WI7SL7vVGLtNzsJnps7x
         tn/kAghIMJHoPlRZPXjR3Yi6Z2fEq68E2MX35i9BpAyd+dz66e3mK/abIZt7RO0Y1P+v
         jwuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=r7LJQPKzKLI44gs2sRlHJHn71CY4NsCWIVJR7gYj7Zg=;
        b=QLj3FN90nBzbEYBkQXK7YTVVvw1MJm/5m2HDUi/BlyLQUmArW5Aja8NG1nWHEFJYgp
         Io3ZSh1PrSC424fg2UmFtPolPU1Noamt6UAICNzLZrzeuCTsdazo+Vp4/IE5R1X2ciFO
         FBOpA44Dw4I5DvZ+8D3txRYl8q0thl+TLDTeX0b79vb1vWrJr+n9I81zr9Q9cUKgieco
         8iq6+zR6hTaDx2qTOikKl16bTVSWX6MdXQrzToqXgDJ17yuhMJseU7zgLUWT+Uw2f0Aq
         jAQS9F/fOICGcfN4ylsJzE1130nyvpNI/Ns8G+U/wG4D8jN3kVDDjl3zPWMXNvuapB4t
         mmvQ==
X-Gm-Message-State: APjAAAWn3tQ5plp/aSl3cUBnYFnal3ks/DOO4a2JZVKQOFldf5eZYDNy
        qH01gxP/4Mh/CayzLv0Lh7A=
X-Google-Smtp-Source: APXvYqzOcQ7QFtkZ+HQBS34VL1U3Rz7lFeIpCk4FTq1oLb6YGs+F93duPgWP8E3qN7JH9rgR8c8KFQ==
X-Received: by 2002:a17:902:8d84:: with SMTP id v4mr706774plo.220.1570585738325;
        Tue, 08 Oct 2019 18:48:58 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:200:cf67:1de0:170f:be65])
        by smtp.gmail.com with ESMTPSA id b22sm384394pgg.2.2019.10.08.18.48.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Oct 2019 18:48:57 -0700 (PDT)
Date:   Tue, 8 Oct 2019 18:48:55 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Raise your hand to Ack jk/code-of-conduct if your Ack fell thru
 cracks
Message-ID: <20191009014855.GA73710@google.com>
References: <xmqq36g5444k.fsf@gitster-ct.c.googlers.com>
 <nycvar.QRO.7.76.6.1910082111220.46@tvgsbejvaqbjf.bet>
 <xmqqd0f6n5a4.fsf_-_@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqd0f6n5a4.fsf_-_@gitster-ct.c.googlers.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano wrote:

> For reference, here is the CoC the patch wants to add (there is no
> such topic yet locally, nor a single patch that can be made into
> such a topic, so there isn't exactly something people can Ack on
> yet. So here is a "preview" of what we would see once such a series
> lands).

Acked-by: Jonathan Nieder <jrnieder@gmail.com>

Thanks for your thoughtful work.
