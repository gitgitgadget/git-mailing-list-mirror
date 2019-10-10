Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 609DD1F4BD
	for <e@80x24.org>; Thu, 10 Oct 2019 11:48:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727523AbfJJLsX (ORCPT <rfc822;e@80x24.org>);
        Thu, 10 Oct 2019 07:48:23 -0400
Received: from mail-wm1-f47.google.com ([209.85.128.47]:34044 "EHLO
        mail-wm1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726513AbfJJLsX (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Oct 2019 07:48:23 -0400
Received: by mail-wm1-f47.google.com with SMTP id y135so6959676wmc.1
        for <git@vger.kernel.org>; Thu, 10 Oct 2019 04:48:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=sKErULCvZgQWSepDigrLS1+RnSRakjdGJPfGHl3UQcc=;
        b=uzQMTO1cVZpX2l1T35wQMlzf0QJyYbH+cW3DXsWhv6gFh4t2yv//Zx25yQjCvN2l5z
         cdAwY7hVUmT/Gkw5wjO3MyoPhS6yu8deqCIzy/LztgTjlBTZb6+ey4XyQ/XW3tpvLscx
         DqGajZ8hv1z6QA4DRSWyGcUBgIr1tJeHzZxtUnOhPus2yoHQenHvKbb7D7eHvJRZM1un
         ZiIKOqXKZ6UcBriFGUBTkg3kN37Q5INzME0RAhkImstv5JEDUdmEhxDnxBgFcESp1XkG
         1gQNscsKHgRZfqYqUkmK9T5bX/9CHQXHqYwIe59+ixgnKzrSEyG/2LlZj0vNWmwzssQP
         bG3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=sKErULCvZgQWSepDigrLS1+RnSRakjdGJPfGHl3UQcc=;
        b=A48ljZDQwNec1OZJ9IWFwtkTSC/rJFwFAB8NKH3E7hPHc2c+s55upsmnzvJTYl+MAE
         XSq8/Yezlfq2DSUtR4dZLlgs1Z50PMzWLrlCGXagRzGC4qPUVTbQIRzOwucYzso/kg/y
         0tuptW/6EJecnFp8AZVxcObLB3aYmHgLqjoXQOpPOay3z1Zxobb64gPB7FBucyhyhrSf
         RK3MIOhfmw0zdWWAkvg/k77f2fsD+Ynbjad56B/MDMY/WWOeztrQiaxKE7fHv+Z3ckg/
         Ibx6F05aHmFq7R4AFJ0hia/pp8y3by0VuQcqU6U+qHEAttZUVXWd8Et/EhtVTRsJIWQn
         Y6Xg==
X-Gm-Message-State: APjAAAVS71SRFEmfaajPecfQBG9zTdRGlhxvKTox2oGSRFa1mTGjCjLS
        74TGDps7JCDFh4amQz5EMEM=
X-Google-Smtp-Source: APXvYqz1dkubHUB9KlAY6qnQZ5oaoZD3EjwbT3d7oPnnH8lmYLchmzBzfi0UTYJ4BAmtLSyO8l0E4A==
X-Received: by 2002:a7b:cb0b:: with SMTP id u11mr7243311wmj.125.1570708099384;
        Thu, 10 Oct 2019 04:48:19 -0700 (PDT)
Received: from wambui ([197.254.95.158])
        by smtp.gmail.com with ESMTPSA id o70sm7541028wme.29.2019.10.10.04.48.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Oct 2019 04:48:18 -0700 (PDT)
Date:   Thu, 10 Oct 2019 14:48:14 +0300
From:   Wambui Karuga <wambui.karugax@gmail.com>
To:     jonathantanmy@google.com
Cc:     git@vger.kernel.org
Subject: [Outreachy] Outreachy initial contact
Message-ID: <20191010114814.GA9876@wambui>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello Jonathan!
My name is Wambui and I'm one of the applicants in the current round of
Outreachy applications. I wanted to write an initial email to introduce
myself since I'm interested in working on your mentored projects!

I have been going through the mailing list threads about Outreachy and
I found a list of good first issues to begin with. I'm looking forward
to working on one of the most used system in open source!

Wambui Karuga
