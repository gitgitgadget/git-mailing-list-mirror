Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIMWL_WL_MED shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5ACFF1F404
	for <e@80x24.org>; Fri, 14 Sep 2018 18:35:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727128AbeINXvJ (ORCPT <rfc822;e@80x24.org>);
        Fri, 14 Sep 2018 19:51:09 -0400
Received: from mail-io1-f53.google.com ([209.85.166.53]:32870 "EHLO
        mail-io1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726748AbeINXvJ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Sep 2018 19:51:09 -0400
Received: by mail-io1-f53.google.com with SMTP id r196-v6so6842802iod.0
        for <git@vger.kernel.org>; Fri, 14 Sep 2018 11:35:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=5gdkkXxVd7Vgq4qoSahlS17flH3xWf/9cGFBH/X3D7E=;
        b=1U//CdZwxSmA0QMGvcV6PMJt2DcOY8jWiEvsQld/RFqfhNho6l0euJsuYR+qBG7ATr
         Ri+6UBsqjfS919g5wm9uH2JvODrq/A7sOWAf165A/1Fwxj9IxU0/CKjeLYW9vwjwVXOO
         W5V3DQbyzzinr6mpptqTofbEHiRui2cHg92FoOP+/J081VBnhXlG9EhxGkghqgNoneO5
         eqP/+PCIHSKX/6ZHuBNEh76MqQWfVFxtstJD0SJGULxrohfwxfvAJTrEx9rGglQeH271
         jMPDNXoXtMB8bSuaNWDRPg/ti83N5eMqeEKnWzRZLfFoPUDDwxCVjjCDj7yW2/GGvkav
         qjrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=5gdkkXxVd7Vgq4qoSahlS17flH3xWf/9cGFBH/X3D7E=;
        b=TWjcBnJLSGEGc5DMmD44myHc9uZjvFZ9CEdwyipG/N42Iaz+Y9Ca82zJvL8FR9HyiP
         r+U7a81Irb9Z94CIW/dnRqbPykCtt8iFXJN/e58ZvBtkKkhMrnl+n+j/6aSwWInu2Ekp
         NDkI+uXIWjxfdSqcE73evjJsyhLOSEX5f0ZRu3CoqsvUyjKUMxF3SYJdBOvCvBrWKQMc
         6GR9dQ30TVsCIhhHglesdto7lo8UQOGUUJVEUm6MXEYGTNJRNrbZVxPOCl4R4/6BBxEa
         YLXy/XQYyJWtaNh7vspyRjdtszo9Ivpy2kcFl1H6+YX/2Bb+4Xf0OFzDt3CLItkyPbkD
         8yuA==
X-Gm-Message-State: APzg51BkAi1bQe0NYN5OMTGkNXC6J5tLt1rWct83heUROHAduyAyiHj0
        qKLgpapIR6cv9dHWZoohGsQl9g==
X-Google-Smtp-Source: ANB0VdYgYjfAueIviwEqYGn/GrCAtDolllPZip6K582kMx087vHh81hFPtG6/XRv0bux2Nycb5C8mQ==
X-Received: by 2002:a6b:d819:: with SMTP id y25-v6mr12062914iob.247.1536950125916;
        Fri, 14 Sep 2018 11:35:25 -0700 (PDT)
Received: from localhost ([173.225.52.218])
        by smtp.gmail.com with ESMTPSA id m47-v6sm1070790iti.1.2018.09.14.11.35.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 14 Sep 2018 11:35:24 -0700 (PDT)
Date:   Fri, 14 Sep 2018 14:35:23 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Zachary Bryant <Zachary@admiralfeb.net>
Cc:     git@vger.kernel.org, johannes.schindelin@gmx.de
Subject: Re: v2.19.0 Git install doesn't allow VS Code as an editor
Message-ID: <20180914183523.GG55140@syl>
References: <CANrLuF4aTda+WDEZSc1MmTM0u9M04ZsWruXD-GDW6wXVVX2EJA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANrLuF4aTda+WDEZSc1MmTM0u9M04ZsWruXD-GDW6wXVVX2EJA@mail.gmail.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Zachary,

On Fri, Sep 14, 2018 at 09:43:43AM -0500, Zachary Bryant wrote:
> When the installer asks for a default editor, it defaults to vim and
> when I select either VS Code option, it won't allow me to proceed.

It sounds like this is an issue pertaining to Git for Windows, which
uses an issue tracker that is separate from the mailing list here. Their
tracker is at [1], but I'm cc-ing the maintainer here to let him know.

Thanks,
Taylor

[1]: https://github.com/git-for-windows/git/issues
