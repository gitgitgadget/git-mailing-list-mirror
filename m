Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 99A4E201B0
	for <e@80x24.org>; Mon, 27 Feb 2017 07:49:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751510AbdB0HsT (ORCPT <rfc822;e@80x24.org>);
        Mon, 27 Feb 2017 02:48:19 -0500
Received: from mail-wr0-f177.google.com ([209.85.128.177]:35627 "EHLO
        mail-wr0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751540AbdB0Hq7 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Feb 2017 02:46:59 -0500
Received: by mail-wr0-f177.google.com with SMTP id g10so46112579wrg.2
        for <git@vger.kernel.org>; Sun, 26 Feb 2017 23:45:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=FXqhjFjSY3ihzgNR3dVy2+GvJXH7hJ24d7KB0OMbnMI=;
        b=lEyipBR82FsIFW4F02hRFf9052zuhLkR3KqBZHbnI1l4dFY+ttYG5L5FyTg0rwUv15
         dazM9asNi+4vC5ND4PLrWmks8m6nkPMyXSb2Y/j1o1xAcLjHbA/sSWV7er63s8L0OKQm
         mQ/Y0YRCrmAyrXQFD5jW9zedNibIuB2RLllDyJF4WyvT1eVxiiyjU4PFROHwck2I/DFE
         7n4Ch00tZbZ7lgSqbUND2LO2c14WSEFpeRrqbNWrNoLpnSq4D1zZDmwmDTZnYDefwjNc
         iUFUxuvTrFU2yEgOnF3M1EvRiFvHsAD/jLfkEKM2mdUnMHIPCkMfTO3hkqJ1cEfUOtKb
         0wKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=FXqhjFjSY3ihzgNR3dVy2+GvJXH7hJ24d7KB0OMbnMI=;
        b=X7Da51nCdXQh7axUjd8552oGBn50L69EmwEtLJJsh3bJnAxalnAgnJ6Dgkfi31+hS3
         ZUt20qTa7K/KgQUxTCkN55Gv5DVAZy2plwO2f7l6eUfG+A803Bd7lxskN/aGGPUGGzFw
         JBrLEKObM7bH1QHpbgxp4KdineBowkCrFeFYBA5AR+KtwXHkmB89uMWhBwwoHuvp+eXB
         M1aF2g/d+pGXI9UJw3S9h6ybCAcwejpY8CiBhjgPTLsMz7rB1OP1N7SQ4ppEAo5IMVYs
         mdQ7y8lfoUuionZxfP35eTUlV/MMc2USCh5L5Uz4/4otQ5FszRzmgckiQCqEYJYnwce0
         dA/g==
X-Gm-Message-State: AMke39kw1VKKUFxmksHpJUPhXl01VFnp1TpzvDE5NTP7ug+LyUXlmcTFVvoKb8ctS5rDhw==
X-Received: by 10.223.179.15 with SMTP id j15mr11966557wrd.159.1488178048086;
        Sun, 26 Feb 2017 22:47:28 -0800 (PST)
Received: from macbook.local ([2a02:a03f:85e:d600:dc96:b6f1:625c:99f0])
        by smtp.gmail.com with ESMTPSA id w204sm12891287wmd.17.2017.02.26.22.47.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 26 Feb 2017 22:47:27 -0800 (PST)
Date:   Mon, 27 Feb 2017 07:47:25 +0100
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     Karthik Nayak <karthik.188@gmail.com>
Cc:     Git List <git@vger.kernel.org>
Subject: Re: [BUG] branch renamed to 'HEAD'
Message-ID: <20170227064724.fx246w4fn2morhb4@macbook.local>
References: <20170227045257.yazqlrqlnggosi5t@macbook.local>
 <CAOLa=ZSyQg9uoZWADOMYc90U-5AR9Lfii9mjLre0m0FQCSqfxg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOLa=ZSyQg9uoZWADOMYc90U-5AR9Lfii9mjLre0m0FQCSqfxg@mail.gmail.com>
User-Agent: NeoMutt/20161126 (1.7.1)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Feb 27, 2017 at 11:43:46AM +0530, Karthik Nayak wrote:
> Hello,
> 
> Thanks for reporting, but I don't think it is a bug.
> 
> On Mon, Feb 27, 2017 at 10:22 AM, Luc Van Oostenryck
> <luc.vanoostenryck@gmail.com> wrote:
> > Hi,
> >
> > I just discover something which very much seems a bug to me
> > while making an error in renaming a branch.
> > The scenario is the following:
> > - I have a branch named 'orig'
> > - I want to make some experimental changes on it:
> >         $ git checkout -b temp orig
> >         $ ... edit some files ...
> >         $ ... make some tests & commits ...
> > - I'm happy with my changes, so I want to have my original
> >   branch to now points to the head of this temp branch
> >   but did it wrongly:
> >         $ git branch -m -f orig @
> 
> Here you are using the '-m' flag, which is to rename a branch. So what
> you're essentially
> doing is:
>     $ git branch -m -f orig HEAD
> Do note that this won't reset 'orig' to point to 'HEAD', rather this
> renames 'orig' to 'HEAD'.
> 
> What you actually want to do (to reset 'orig' to 'HEAD') is:
>     $ git branch -f orig @
> This would make orig point to the current HEAD.

Sure. I said it the description that I made an error in the renaming.

What I consider as a bug is that '@', which stands for refs/HEAD,
have been interpreted as a branch named 'HEAD' and thus created a
reference refs/heads/HEAD.

Luc
