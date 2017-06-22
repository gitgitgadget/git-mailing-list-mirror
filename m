Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 57F8A20802
	for <e@80x24.org>; Thu, 22 Jun 2017 21:03:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753587AbdFVVD1 (ORCPT <rfc822;e@80x24.org>);
        Thu, 22 Jun 2017 17:03:27 -0400
Received: from mail-pf0-f180.google.com ([209.85.192.180]:35969 "EHLO
        mail-pf0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753567AbdFVVD0 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Jun 2017 17:03:26 -0400
Received: by mail-pf0-f180.google.com with SMTP id q86so14026986pfl.3
        for <git@vger.kernel.org>; Thu, 22 Jun 2017 14:03:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=yRMRcfAL6f4OMpnHm6LNZ7tfhWr88jcw+MpLaTyaJnQ=;
        b=JfwD/7ikdK+C34IxvMb+u3FA3CMcxe0EVhdPfW6tvweM1syoj9vvf8mxhbQFQ2SVVR
         yDKDWqVvwEvu9g87ut3TQobXLtRSMUoIRRQhUEywjWX5ZW9EvFEY4drBpmzp2K5h2IEU
         GC4P+bmb5pnR86UUj3wFd1yKxGDHl3AohVmaFSjVlemGp25qmsvghX3RSLW46CpDJ46+
         cBkyp3CBLHrTbR4JGQrh4Hk1ZcUDPVCHuNT1Udq+2yj/nawdODQlwsLoG3BXZMcVURFd
         7e5zz8x4mxdE20TojNbdIXuhBInozJxozbFNOjI3RF51N1RZihp2uVKWithlSjAdVo1x
         ow9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=yRMRcfAL6f4OMpnHm6LNZ7tfhWr88jcw+MpLaTyaJnQ=;
        b=Mvhm63FZSI4xnhyBPZ2Z3YpsSyrlEL8Kt/yqFHftYSCxZIRpRbzuEEsR6oAvtK7DeF
         4EtzrL27vZvD4BeeKtDm1OexVcxLL92hWMKgOtnqRTmPIGlczx/adp9f9zRwwiY6fiG8
         RH99oh2wK1W4/eqORaMXQBwvSqRzuE2o6mtpbcCCl51jGX2iT8w/Yn1/gx7G7SARTDbd
         LEc5REbZ/jHeiUCyEN2Jn09E6Jd9lBjT1P/Ajlfy7a2rLLe73R0yeKc+Se/fwDH8QUK6
         nUAHZpBia7Xa7qVKi0weHPZr+OMNvvfiHT/KoOxZyC+OMVvSdfSbsUB/Sy4RglvEyuy1
         fyRQ==
X-Gm-Message-State: AKS2vOyFXeFdxiShODbbh362GwdcwazTds6p6cAh61alTh0qczwnaYUx
        e5kQSCafkzH7jsRM
X-Received: by 10.99.152.86 with SMTP id l22mr4521840pgo.93.1498165405818;
        Thu, 22 Jun 2017 14:03:25 -0700 (PDT)
Received: from google.com ([2620:0:100e:422:9474:9438:25ba:a969])
        by smtp.gmail.com with ESMTPSA id 189sm5456997pgj.67.2017.06.22.14.03.24
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 22 Jun 2017 14:03:24 -0700 (PDT)
Date:   Thu, 22 Jun 2017 14:03:23 -0700
From:   Brandon Williams <bmwill@google.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>
Subject: Re: [PATCHv2] submodules: overhaul documentation
Message-ID: <20170622210323.GC124061@google.com>
References: <20170607185354.10050-1-sbeller@google.com>
 <20170620225650.7573-1-sbeller@google.com>
 <20170622174659.GA124061@google.com>
 <xmqqlgojixjo.fsf@gitster.mtv.corp.google.com>
 <CAGZ79ka5MkpPSxR23Kz9DcxFkHNB-hz=n-teDXc6=eX4p473FQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGZ79ka5MkpPSxR23Kz9DcxFkHNB-hz=n-teDXc6=eX4p473FQ@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 06/22, Stefan Beller wrote:
> On Thu, Jun 22, 2017 at 1:20 PM, Junio C Hamano <gitster@pobox.com> wrote:
> > Brandon Williams <bmwill@google.com> writes:
> >
> >> On 06/20, Stefan Beller wrote:
> >> ...
> >>> +The configuration of submodules
> >>> +-------------------------------
> >>> +
> >>> +Submodule operations can be configured using the following mechanisms
> >>> +(from highest to lowest precedence):
> >>> +
> >>> + * the command line for those commands that support taking submodule specs.
> >>> +
> >>> + * the configuration file `$GIT_DIR/config` in the superproject.
> >>> +
> >>> + * the `.gitmodules` file inside the superproject. A project usually
> >>> +   includes this file to suggest defaults for the upstream collection
> >>> +   of repositories.
> >>
> >> I dislike this last point.  Realistically we don't want this right?  So
> >> perhaps we shouldn't include it?
> >
> > I am not sure if I follow.  Without .gitmodules, how would you, as a
> > downstream developer, bootstrap the whole thing?
> >
> 
> I think Brandon eludes to our long term vision of having a separate
> magic ref containing these informations instead of carrying it in tree.
> 
> As urls change over time, it is better to keep the urls out of the
> actual history, but still versioned so maybe we'll want to have
> a ref/submodule-config/master ref that contains all the bootstrapping
> information. The .gitmodules file would degenerate to a pure
> name<->path mapping.

I was more eluding to having fetch.recurse and the other similar bits
stored in the gitmodules file.

-- 
Brandon Williams
