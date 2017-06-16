Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F008520401
	for <e@80x24.org>; Fri, 16 Jun 2017 00:12:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751673AbdFPAMj (ORCPT <rfc822;e@80x24.org>);
        Thu, 15 Jun 2017 20:12:39 -0400
Received: from mail-pg0-f46.google.com ([74.125.83.46]:32876 "EHLO
        mail-pg0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750835AbdFPAMj (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Jun 2017 20:12:39 -0400
Received: by mail-pg0-f46.google.com with SMTP id f185so13307481pgc.0
        for <git@vger.kernel.org>; Thu, 15 Jun 2017 17:12:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=kAnyWISQcR6aC/JHomlGGkURxyaWdxk3TooAjOCAREg=;
        b=qXjxSrKastXcG1g7n3Kw5TYEefqSCXXUkaAKymL5vXmq1MkR6p362N6TjmH55Ek9Fa
         sCyk70KesM9p43PleqD1BKC+WygnpZzZhk48S/6h1xNzCvyMlzeY5vfDR0wRQV2NSFvG
         qcAf7I/yV3IyCE9/sF+Ez/DleWspEL2rGb60BfnV/IIpu2zeVfrVCLHdgdCBYmcmMpZk
         lk5cFM7WCRjelBIoYT/5oz2BrP4zOfR+RmWdEG+ZqbhKJ1AGq1ckGDfrqBVBOIXvicHQ
         NAP1WX6Ifbq8vu/D7j8BLwiSAPWg3YDF902mfhKdfPCNE8awPSp51880LJNYgmIWWMqV
         wV7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=kAnyWISQcR6aC/JHomlGGkURxyaWdxk3TooAjOCAREg=;
        b=Jws4HT4xnXxQgPIRdp2M9VrFvYOVlOldlMiUoQlMxL2+fhBN+eyP3jK4dnMHBCWlbx
         HVZ1KVBGuyXVjtH/mxITqWgGBS/3WnPNL6wK8aPRV2T2PYS3o9CsId5Oyo8TZDi2NGrn
         jy52Hsg5/1qFV1/+tDoVrzpbf5KUVm+2WU2tzsYqs5xbOOrkTgOpWaDzvswnZ4xnkx/m
         emcaaee5WZ887r+tB5ChVsHtZ8X85hj2Dg0o62AENyhwlKQrV80ReHEJLlb/U+uUhZts
         kYZD6T02stXbWPegMynSaTe6fnUmbpAACDCs+/7791i/wjAVV3eFIqJ64nWM1qceD3fH
         5StQ==
X-Gm-Message-State: AKS2vOzc11iTxbDlHzODx2aWFjpu08cvNCYvFCEHxZ7dmwWCkXG+8cF8
        JJQZlKFzsGSpahu8
X-Received: by 10.84.143.70 with SMTP id 64mr9278485ply.36.1497571958288;
        Thu, 15 Jun 2017 17:12:38 -0700 (PDT)
Received: from google.com ([2620:0:100e:422:2d7f:7526:8947:80f4])
        by smtp.gmail.com with ESMTPSA id a84sm730854pfe.19.2017.06.15.17.12.36
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 15 Jun 2017 17:12:37 -0700 (PDT)
Date:   Thu, 15 Jun 2017 17:12:35 -0700
From:   Brandon Williams <bmwill@google.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, peff@peff.net, jrnieder@gmail.com,
        Johannes.Schindelin@gmx.de
Subject: Re: [PATCH v3 0/6] config.h
Message-ID: <20170616001235.GD176947@google.com>
References: <20170613210321.152978-1-bmwill@google.com>
 <20170614180739.72193-1-bmwill@google.com>
 <xmqq8tkt10pt.fsf@gitster.mtv.corp.google.com>
 <20170615203332.GB176947@google.com>
 <xmqqzid9yn4a.fsf@gitster.mtv.corp.google.com>
 <20170615211850.GC176947@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170615211850.GC176947@google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 06/15, Brandon Williams wrote:
> On 06/15, Junio C Hamano wrote:
> > Brandon Williams <bmwill@google.com> writes:
> > 
> > > On 06/15, Junio C Hamano wrote:
> > >
> > >> ... so please eyeball the resulting 12 patches carefully when
> > >> they are pushed out.

I just took a look at what you pushed out and they look good to me.

-- 
Brandon Williams
