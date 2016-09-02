Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 65BDE1FBB0
	for <e@80x24.org>; Fri,  2 Sep 2016 22:40:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754039AbcIBWkW (ORCPT <rfc822;e@80x24.org>);
        Fri, 2 Sep 2016 18:40:22 -0400
Received: from mail-pf0-f194.google.com ([209.85.192.194]:35220 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752864AbcIBWkV (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Sep 2016 18:40:21 -0400
Received: by mail-pf0-f194.google.com with SMTP id h186so6269631pfg.2
        for <git@vger.kernel.org>; Fri, 02 Sep 2016 15:40:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=RWuxvvlgc+W/JjUZIs+3s3ohuiaDZTIugjj3xbT0XHU=;
        b=dUDi72leFwp+VhP/wvSrHqHc/H/D2vkG1cJCrMyKJUcpz0lY13wC98+MgR8aNytGTs
         r+6vIRb4ckr56hutP/rN2LK/vvpLWSlLwhfMZ0429RMXh6S+lvqQrVeh9UWxQEkaqfm+
         vQfQnlV+eY8UN7t7hbD71BpKs+QHvZqlKQ1AfZ0OM/IfbE/Twit5XNRynzDROQVEGPuH
         JBpyH8zkVaRFLI+PiqrWudfI2lPScTf2Ee3ikjqWH1mPGsb0x/cUFA370KWcGMFPGMvx
         pSJBWQVWqc4LCb1KJWxkcm9jADRJwYy4uDpLjRQ/jUjqVFvJChhCUiv8AzIqTtXHxuGP
         C/1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=RWuxvvlgc+W/JjUZIs+3s3ohuiaDZTIugjj3xbT0XHU=;
        b=IV8WUCTxPt8WzSQR7qop/vlRKFyaiLmkiaTkQq1ze3BlDb77J/XR6MZmy6m/9Yl2jG
         zaUa/7n5MYnpJw7iowqCMzQeKY4V7UDyFMIWfwyth2u2utqR8PcoC5u8eMZ/hIqDb1Jv
         OgRQPiz7S1qQD6ShBqpQTm7HfZGZfEAsMEIj76t8862rc8KvAcJadNQnxdSTEMu1lfGP
         gRh7xKtzT+ZcOjJ4K3hhXZJduXTmgNwS6YCe7a1EGEq211/ra0CqqYMPy61lWgLMB5xM
         nvWxCLxbzp93a8DB61xPsLxusFwtlnq3rgJTGxauIG8X2gCeEnIh8vpg8GsQkYLsn0QD
         Cmhg==
X-Gm-Message-State: AE9vXwPMb34/6mK7oIfFpDGB0tTvTPhIrDOsXbkg6feTohbZ2Z9Zq9gmrSPwBTpRj1R9tw==
X-Received: by 10.98.95.129 with SMTP id t123mr40578112pfb.148.1472856021109;
        Fri, 02 Sep 2016 15:40:21 -0700 (PDT)
Received: from google.com ([2620:0:1000:5b10:34:ec2f:e9e8:7f87])
        by smtp.gmail.com with ESMTPSA id a20sm17105846pfa.27.2016.09.02.15.40.19
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 02 Sep 2016 15:40:20 -0700 (PDT)
Date:   Fri, 2 Sep 2016 15:40:18 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org, spearce@spearce.org, sbeller@google.com,
        peff@peff.net
Subject: Re: [PATCH v2 2/2] connect: advertized capability is not a ref
Message-ID: <20160902224018.GH14758@google.com>
References: <cover.1472836026.git.jonathantanmy@google.com>
 <cover.1472853827.git.jonathantanmy@google.com>
 <174c8ca6638f1cd3145a628925e65655b56af366.1472853827.git.jonathantanmy@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <174c8ca6638f1cd3145a628925e65655b56af366.1472853827.git.jonathantanmy@google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Tan wrote:

> Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
> ---
>  connect.c            |  3 +++
>  t/t5512-ls-remote.sh | 39 +++++++++++++++++++++++++++++++++++++++
>  2 files changed, 42 insertions(+)

Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>

Thanks.
