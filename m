Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 51FBF20248
	for <e@80x24.org>; Tue, 12 Mar 2019 23:19:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727313AbfCLXTj (ORCPT <rfc822;e@80x24.org>);
        Tue, 12 Mar 2019 19:19:39 -0400
Received: from mail-wm1-f50.google.com ([209.85.128.50]:55060 "EHLO
        mail-wm1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727092AbfCLXTi (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Mar 2019 19:19:38 -0400
Received: by mail-wm1-f50.google.com with SMTP id f3so11012wmj.4
        for <git@vger.kernel.org>; Tue, 12 Mar 2019 16:19:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=KDdKCFIKmH8fuztGlUnwdbS5hdRq+mCzKjeKDSp5qGE=;
        b=B+Cp5Yr396hMxXbnvjRINU4Sj+j9K3gKo1HAPoFEJPz6+1kJgFN8/ZvlX6xTf4NFaA
         FuGaq5ZlYhrX6x6BNcfFQOnAt+YxIuy3eC3e+RpYz5890iUngRrueB/WSDcRtpgpvYfO
         7JXslPU4CSECbsuYNFF57gNUOAmYN3pgqJqYNj0u3OQsyERZ6SGWbs72Fqs+po9zExE6
         AKioeJPwwEF0jVd9l/7GAbRZQSAs6SDx++TT0xpcPnxdRIzjmpiQHAWnE1EfCk1G3TYT
         iivjQnnsQa71VKUvS7syzy/PB+RwHkfaJeMo54rAjOxQcy8/GTDpk/SnPti5jbV55lNF
         SJNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=KDdKCFIKmH8fuztGlUnwdbS5hdRq+mCzKjeKDSp5qGE=;
        b=t9qGjTYMNKvlJXZRDKRXfZc69Hyz6fvs8uHLHW9nbFcmCDrBHmbeCIxPRFcvf8G0gs
         KDTOj0fIDMAVYSGhZHJt/ceN8WqpXvsTCVyWZAd0nRMk5+7/WX+3ngVt7QoL2tNnyMzZ
         rWIMW5vG38ltQD1tNmP4IzhSSrODhtM/dSZdfjnJqD9FugiR/X3NOm14+qbZ+ghTk6Rs
         37wFcAD33U13BxQPh4Dc3KdnceKbDO6VIZonl8AcRWFCbIpwajy8g+cLpB/3Em2ckvCh
         sWxYBcFWteg7GLUlqlvJBxIi/AsbRIBWItVMaFIY5EY9hfntMk4logenyT1zWaWvA7+c
         5mVA==
X-Gm-Message-State: APjAAAV2laIT0G9bEccohPqQFsILrdUAXXP+BHsrTiHO+XM++uYfOM7M
        BqTK8moNWsJhGOmH0RLvBw4=
X-Google-Smtp-Source: APXvYqyEjLCHYmfWeqAqN/oEPrVaROnG0uqkPM2Vd3qkYEgzV9WwySX4Yj/b538zbdzEjDRylch3ag==
X-Received: by 2002:a1c:2e85:: with SMTP id u127mr137791wmu.70.1552432775792;
        Tue, 12 Mar 2019 16:19:35 -0700 (PDT)
Received: from localhost ([95.148.214.107])
        by smtp.gmail.com with ESMTPSA id y140sm394955wmd.18.2019.03.12.16.19.34
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 12 Mar 2019 16:19:34 -0700 (PDT)
Date:   Tue, 12 Mar 2019 23:19:34 +0000
From:   Thomas Gummerer <t.gummerer@gmail.com>
To:     Sushma Unnibhavi <sushmaunnibhavi425@gmail.com>
Cc:     git@vger.kernel.org, Christian Couder <christian.couder@gmail.com>
Subject: Re: [GSOC]regarding project selection
Message-ID: <20190312231934.GD16414@hank.intra.tgummerer.com>
References: <20190312112404.GA5031@hacker-queen>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190312112404.GA5031@hacker-queen>
User-Agent: Mutt/1.11.2 (2019-01-07)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

please always Cc: the potential mentors of a microproject when you
want to discuss it.  That makes it much more likely for the mentors to
notice your email and discuss it for you.  I added Christian, who's
listed as possible mentor on the project page to Cc: here.

On 03/12, Sushma Unnibhavi wrote:

> I am interested to do a project on improving git log --oneline.I can
> program in C language,I have learnt how to send patches and I am
> also comfortable with using git.I wanted to know what are the
> prerequisites for doing the project.Can I get some help regarding
> this matter.

The prerequisites are stated on the project page.  The languages
you'll need to know are C and shell.  More importantly though, you
should get familiar enough with the project to discuss it here.

Did you read the links that are provided on the project page?  If
there is anything unclear about the project you should try to ask more
specific questions, that show that you have done your homework and
gave the proposed project a bit more thoughts.  That shows your
interest in the project, and we can give you much better answers.
Just asking for help in a very general manner makes it very hard for
us to give you a good response.

One of the criteria for choosing students is going to be how well
fleshed out the project proposal is going to be.

As an aside, the patches you sent for your microproject received a few
comments.  Apart from the project proposal, it's also important to try
and address those comments, to show how you interact with your
mentors and other people on the mailing list.
