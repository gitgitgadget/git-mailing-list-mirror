Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4333F20372
	for <e@80x24.org>; Fri,  6 Oct 2017 22:50:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752155AbdJFWuy (ORCPT <rfc822;e@80x24.org>);
        Fri, 6 Oct 2017 18:50:54 -0400
Received: from mail-pg0-f44.google.com ([74.125.83.44]:45085 "EHLO
        mail-pg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751485AbdJFWux (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 6 Oct 2017 18:50:53 -0400
Received: by mail-pg0-f44.google.com with SMTP id b192so7532380pga.2
        for <git@vger.kernel.org>; Fri, 06 Oct 2017 15:50:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=wdR186deMwCHHdPfZs5YfbF3la3Rn4wUAdfx+GMXxhQ=;
        b=VlSBQDsskcK7z187QNZsGd9aNusSgxXDYzHTRb37OtRu727RZiBoZ3NpU/f7G6OqTA
         TuOnciqsbYsJw2oAhqUDFFuggaq6uCLny+t3QgxOnPD+4DsEZ66KWfYlO4ISK/a1h3SY
         T9DumObvS2rkiSjGkz/eArMG8jYrZtrbj/IdgjO/5QVubUmew8sg9lhe1DYDi19B8jdp
         yeTZxGM+lhzl7nasLfjsAmAPrBgNBMAFylMnjn/6TM9GA2q0rLXeEq+U1qdH0qVjuWCx
         AB7MEZofhkA2o517RbjbuWMZrw0xD8M4ULJitXnYGyt7MX/23NGItp9yALI6yLo546GN
         ROGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=wdR186deMwCHHdPfZs5YfbF3la3Rn4wUAdfx+GMXxhQ=;
        b=J5bT37AZsGxcOJgnTVY4Igllx2jKZ863TYjX/4Q+tQPwiCDrFNCWuYFlVWolsCSl2Q
         wJoOqMVLXq+nJM2fUPsF+fdRd/fJPVD3NvhYGCVK3h75/mSp5Upwqc5hvH0eQqU8BOI2
         6ETEURR+DszM87MoAkXKryvr24ByZIzlGJ/sBz+23YAhr5XL1YjsfO31ocge8B0R8MpG
         nFeohFO472dbmbAL96tEoYipqwQTxkHtCkhChVpMjNgANElmcOcDq75GItMBRPgqtjIc
         GLpSKQYzS+wVfSBr35sxMd+hBdUcvsx0Mrq4myRfhNjYLb4Mwd6QsqrWq097XeMVJ6e2
         F7mw==
X-Gm-Message-State: AMCzsaV4uI3m2ccBpKGFTNSa3mh5qSeLIGWja+byfBmD/QVfOy+1ome8
        Xnqh38rUaRoJaa6/g2HyFaGUyPC3
X-Google-Smtp-Source: AOwi7QDcbZqlz1f3nOZSI5lVPtSo/CbohnNG4JMNabbf+0VIv6DM7BTAH8d+1nE078a3J/+uDIvrcw==
X-Received: by 10.99.168.13 with SMTP id o13mr3217667pgf.435.1507330252562;
        Fri, 06 Oct 2017 15:50:52 -0700 (PDT)
Received: from aiede.mtv.corp.google.com ([2620:0:100e:422:78c3:3d0d:a9b5:4320])
        by smtp.gmail.com with ESMTPSA id k8sm4339183pgt.22.2017.10.06.15.50.51
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 06 Oct 2017 15:50:52 -0700 (PDT)
Date:   Fri, 6 Oct 2017 15:50:49 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     "Randall S. Becker" <rsbecker@nexbridge.com>
Cc:     git@vger.kernel.org
Subject: Re: [Question] Documenting platform implications on CVE to git
Message-ID: <20171006225049.GA19555@aiede.mtv.corp.google.com>
References: <000801d33ea7$04a7c240$0df746c0$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <000801d33ea7$04a7c240$0df746c0$@nexbridge.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Randall,

Randall S. Becker wrote:

> I wonder whether there is some mechanism for providing official responses
> from platform ports relating to security CVE reports, like CVE-2017-14867.

This question is too abstract for me.  Can you say more concretely
what you are trying to do?

E.g. are you asking how you would communicate to users of your port
that CVE-2017-14867 does not apply to them?  Or are you asking where
to start a conversation about who a bug applies to?  Or something
else?

Thanks,
Jonathan

> For example, the Perl implementation on HPE NonStop does not include the SCM
> module so commands relating cvsserver may not be available - one thing to be
> verified so is a question #1. But the real question (#2) is: where would one
> most appropriately document issues like this to be consistent with other
> platform responses relating to git?
>
> Thanks,
> Randall
>
> -- Brief whoami: NonStop&UNIX developer since approximately
> UNIX(421664400)/NonStop(211288444200000000)
> -- In my real life, I talk too much.
