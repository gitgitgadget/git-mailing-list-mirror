Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7F8F920248
	for <e@80x24.org>; Sat, 16 Mar 2019 18:45:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727189AbfCPSpU (ORCPT <rfc822;e@80x24.org>);
        Sat, 16 Mar 2019 14:45:20 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:35519 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726493AbfCPSpU (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 16 Mar 2019 14:45:20 -0400
Received: by mail-wm1-f67.google.com with SMTP id 81so1645992wme.0
        for <git@vger.kernel.org>; Sat, 16 Mar 2019 11:45:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Dcqq9hvkokQ7UBiNQeOBdCkMm6dOXPcILSVeuGHE8d4=;
        b=Zcsl+cGnvQKkC+XmlNlY6/1JXb8OLsy5hZKk4ijWlRw7i0IQvps85iOBm+pEfXSbYS
         ax0Xz2HGroXaLN6vUVVI+wvSwbjKrEJyxCda6n/P0QIz05DaurR1NXzQ7wDNCXsJHFoK
         V1dlpD5e6o4gSk+6sM1KxHUCJVve10wmq5brQrZRkm/kUoCFDJcC0xxJCVT/rB4AZrW0
         QxUu5AfZQeUS++xDFngxjU2fXIS2zr85r1QAxRotB1L1Av638oDTtRMrUFeiPjfhdO6t
         0bacHRwFuZcBhVKhRPD5mrIuhJ5o/3HcRyPxNnIvW8il4SaURffj1J3V/AEy/29HNjOo
         HxqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Dcqq9hvkokQ7UBiNQeOBdCkMm6dOXPcILSVeuGHE8d4=;
        b=WIAamXtXh/nrwb7CVPXGY8F4xOPYSfYbsYrTR//w74SxjyCdtTBwdtO1OymtmlJ5mF
         JjYOxnVICDHHh9zkvI6T/e2AYfn83SPb6m25GHDG6tr24R8BIh2RNe7Qwl4Q1mQjH8b0
         NfQKjZm//dqfxIoYR56q978zLTPmE3dl8aKbMn8slotugLvZEDyaaa36o9HLLvJo5DYW
         89gytW2Z2o64gV4cbHYAWbkFhzywB50t4w3RpbY95qkpbP+/XbxMn5gA/+OqEM7+W0fI
         r77jj1d8XkeYIlcB8khJu0s5QilDpePwRPQaT//rv2WT56LEUK00JKQF8copYK4uXjfi
         MXpQ==
X-Gm-Message-State: APjAAAWW5CGn5FRwi2l2EfMxwfE3Hq5LJUElEwafGoaOqPJ/ANcvEo8B
        7ZVoaBVLGIiGZ7Z99arPrQnaDtEC
X-Google-Smtp-Source: APXvYqwCHQm/MSl9PGfZ10j+IAQxAgb6XUf9TJ2A050kpsi6z6a9DmmVEM/p+p8pQYrp3VA6uO5Sgw==
X-Received: by 2002:a1c:dc0a:: with SMTP id t10mr5975647wmg.101.1552761919113;
        Sat, 16 Mar 2019 11:45:19 -0700 (PDT)
Received: from localhost ([95.148.214.107])
        by smtp.gmail.com with ESMTPSA id w12sm4973017wrt.97.2019.03.16.11.45.16
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 16 Mar 2019 11:45:17 -0700 (PDT)
Date:   Sat, 16 Mar 2019 18:45:16 +0000
From:   Thomas Gummerer <t.gummerer@gmail.com>
To:     Kapil Jain <jkapil.cs@gmail.com>
Cc:     git@vger.kernel.org, alban.gruin@gmail.com, avarab@gmail.com
Subject: Re: [GSoC][RFC/PATCH 1/1] userdiff - support shell script
Message-ID: <20190316184516.GL16414@hank.intra.tgummerer.com>
References: <20190315150142.20672-1-jkapil.cs@gmail.com>
 <20190315150142.20672-2-jkapil.cs@gmail.com>
 <20190315230515.GJ16414@hank.intra.tgummerer.com>
 <CAMknYEP3dp0a9B4ZW5F8kt+rrRZagWaVYBMhYRWj68UgYrF-GA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMknYEP3dp0a9B4ZW5F8kt+rrRZagWaVYBMhYRWj68UgYrF-GA@mail.gmail.com>
User-Agent: Mutt/1.11.2 (2019-01-07)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

[please keep everyone in Cc, especially the mailing list if you are
responding to review comments.  I added the Cc's back]

On 03/16, Kapil Jain wrote:
> On Sat, Mar 16, 2019 at 4:35 AM Thomas Gummerer <t.gummerer@gmail.com> wrote:
> >
> > For testing you could have a look how other userdiff drivers are
> > tested in t4034.  The easiest way is probably to have a look at a
> > patch for a userdiff pattern that was added previously.  For example
> > have a look at 0719f3eecd ("userdiff: add built-in pattern for CSS",
> > 2016-06-03).  (I found this commit by looking at the git blame output
> > for t4034.)
> > *1*: https://public-inbox.org/git/20170329165331.17742-1-pickfire@riseup.net/#t
> 
> Thanks, this helped in understanding testing process.
> 
> > Both the two lines above and the line below should go below the ---
> > line, as they should not be part of the history in the git project,
> > but serve only as additional commentary for reviewers looking at this
> > patch.
> 
> I looked at other patches like
> (https://public-inbox.org/git/CAC05386q2iGoiJ_fRgwoOTF23exEN2D1+oh4VjajEvYQ58O1TQ@mail.gmail.com/)
> The patch has the email body above --- line. did i missed to
> understanding something here ?

Right, what I was trying but failed to explain is that everything
above the --- line is part of the commit message, that gets recorded
in the history of the project.

However the lines I referred to, should not go in the commit message,
as they are just commentary that helps reviewers, but don't actually
explain the patch itself.  That additional commentary should go below
the --- line, similar to the

    Notes:
        Travis CI results: https://travis-ci.org/nbelakovski/git/builds/432320949

lines in the email you mentioned.
