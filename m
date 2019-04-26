Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4D60D1F453
	for <e@80x24.org>; Fri, 26 Apr 2019 05:05:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725995AbfDZFFf (ORCPT <rfc822;e@80x24.org>);
        Fri, 26 Apr 2019 01:05:35 -0400
Received: from mail-pf1-f174.google.com ([209.85.210.174]:38601 "EHLO
        mail-pf1-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725854AbfDZFFf (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 26 Apr 2019 01:05:35 -0400
Received: by mail-pf1-f174.google.com with SMTP id 10so1074484pfo.5
        for <git@vger.kernel.org>; Thu, 25 Apr 2019 22:05:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=KqAAtpUTAv7mzlufvpJSTqITfXiT8eqnVeQ3/baFfv4=;
        b=Xvr5Q7IZDxJE+RlZDFYKjjB/ReJf4vXregl+zGKJmaehFB5CzQHxFWK/gWd6tGRPYL
         I8+T34UHBNbsaIAO3ijHL2mp66WU8cOrf79Nzvt3iRSCbnZF29pasDD2YsLtZMzCTcyV
         2Ivl3/7TfO/TkSFLD6pxCZKOVRfE068gm1GH1XMx1n6KHO1XvOVceboctLxM05vuuYUj
         rY6foqNsqPBYiWa+gzFqD3Vr4Edhx9jjO92xi3NnJsEFXCwY/WWaROBzd/e9rZFgFNzH
         ogsWKYocl2Xkpss5PVMl0zXArk9lV2JLgykH+GkqViiXBxA8D+sd2TeID2i9nEI5rmes
         PoZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=KqAAtpUTAv7mzlufvpJSTqITfXiT8eqnVeQ3/baFfv4=;
        b=nrcn4FEAl/AL2Eu8xgvynEAOMhDH6Z2drBVHCBOEOlS+rtvYuunl53XFKEIl0N2wrZ
         hukttNMUsJXnc8dxjGbVdLwhduGINvL6oLyl1c/BRsj+vVpf7Hl/V2NpAaFAAf1kQQTT
         qBcKLwoOnV7phXmAB/I1WhtBl4nCkAGNh4b5ZUdykg1Ift7NdiluJxclERva6aF90/Kh
         dGFnM7S6p7SmLO5pnWXa9p1xg+KjHRo0Jrcij77YhGX7Y1RMKgEBy+gl/TnlWXOOub1/
         wRnE8MsFLylcxyrsR5ufyK5QajFxU8w6RlzUxBS8nYs0XLwW7riO1aQm0olOFgtlFFLs
         9ntg==
X-Gm-Message-State: APjAAAU67j+WGQz6fBdqdSXbj5EVtY95Ei4twMxSyULXgz0U8zU7lnCl
        2VTwPC7sWvaH1/h+AJ2M3XGMlQ==
X-Google-Smtp-Source: APXvYqz6CYuDfgHh/Cdl8xRRY2WOS7orXHROIlh+4m4IwjvuZfMmgXrH4JNKDEMVXEEODmoX8H/cdQ==
X-Received: by 2002:a63:f712:: with SMTP id x18mr10353472pgh.293.1556255133544;
        Thu, 25 Apr 2019 22:05:33 -0700 (PDT)
Received: from localhost ([2601:602:9200:32b0:588e:48c6:712:f2cf])
        by smtp.gmail.com with ESMTPSA id c25sm34824651pfo.69.2019.04.25.22.05.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 25 Apr 2019 22:05:32 -0700 (PDT)
From:   Taylor Blau <me@ttaylorr.com>
X-Google-Original-From: Taylor Blau <ttaylorr@github.com>
Date:   Thu, 25 Apr 2019 22:05:31 -0700
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: What's cooking in git.git (Apr 2019, #05; Thu, 25)
Message-ID: <20190426050531.GA7854@Taylors-MBP.hsd1.wa.comcast.net>
References: <xmqqsgu6wfv9.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqsgu6wfv9.fsf@gitster-ct.c.googlers.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Thu, Apr 25, 2019 at 07:15:06PM +0900, Junio C Hamano wrote:
> * tb/unexpected (2019-04-10) 7 commits
>   (merged to 'next' on 2019-04-25 at c49927fca0)
>  + rev-list: detect broken root trees
>  + rev-list: let traversal die when --missing is not in use
>  + get_commit_tree(): return NULL for broken tree
>  + list-objects.c: handle unexpected non-tree entries
>  + list-objects.c: handle unexpected non-blob entries
>  + t: introduce tests for unexpected object types
>  + t: move 'hex2oct' into test-lib-functions.sh
>
>  Code tightening against a "wrong" object appearing where an object
>  of a different type is expected, instead of blindly assuming that
>  the connection between objects are correctly made.
>
>  Will merge to 'master'.

Thanks for picking this up. Before you merge to master, I want to make
sure that the whole series was taken in.

I can see the first four of these landed on 'next' (in
5c07647d98...b49e74eac4), but I'm having some difficulty finding the
later three.

Did you pick these up as well?

Thanks,
Taylor
