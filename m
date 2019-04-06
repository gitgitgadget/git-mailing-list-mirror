Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B38A520248
	for <e@80x24.org>; Sat,  6 Apr 2019 12:14:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726427AbfDFMOI (ORCPT <rfc822;e@80x24.org>);
        Sat, 6 Apr 2019 08:14:08 -0400
Received: from mail-oi1-f193.google.com ([209.85.167.193]:36900 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726310AbfDFMOI (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 6 Apr 2019 08:14:08 -0400
Received: by mail-oi1-f193.google.com with SMTP id v84so7021511oif.4
        for <git@vger.kernel.org>; Sat, 06 Apr 2019 05:14:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PaGLj4luc2GViPS25Zs+aH3UelZTEYAWFTnEjJMJGP4=;
        b=GoxM3M2kmQO3SSqfQFU0bQ96o4SK9XFcYuBaKx47xC/PnMMOfDFGBhhbTEklGZ6b4B
         5YxKa78xDVpTo7x494B77R3NlOMdnzaEztro/u03T1Rr7UA1f7i6tcFeMPZi2khf9smL
         aahL/Vlss2VdVXNK/HPMSM5kf/xu8C2GXWqQvVIGLQEtUlwf0YY6Q04IClQIhGA8IjVu
         +t9ikbugGXeGtMCpvscYEN6SJbi+wKvT/fHUsq/SMjQi+r7jke4rWWReScevCMM6yzkV
         BJpdef1he17QfnH1cghW5cdyhLevK0H4t5ZfbFekD+JK9EHvUCTpBCtMOnyasEwPhbx7
         z0KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PaGLj4luc2GViPS25Zs+aH3UelZTEYAWFTnEjJMJGP4=;
        b=W7kpQmwJe6Rbe2nnF53CzKj6eez/CO/29emq7oKYm8gVHYZn4Zfqo4L6plHoVm1FYN
         LXiNRmzs2YdjT5BcJ//zAiV4sfdU3uoBzvceqGlMIoWoAx2cplksM9Fp7U1u/xBjjxJT
         4AQ7Iq9XVfI/cuI2YMSaiTGTs+ZjG9brfXZubC+XNaUXTnOoGK/hkfKGlvDAEU+9nA5K
         wxioaZCx6u39boSd2KTIvKFStqS4lhupLBxHxF5rHrwcFtoFnU8939dRtEmBYfZ7H9qF
         756q5hREXueFpK9UOvk/ddZ5eQjImFb9NGSVc9+0RC5uxUxvphluZLCP5u0ZxE/BCrzE
         0kXg==
X-Gm-Message-State: APjAAAWwbJpFT6d0bW4dHitM08sq4GwpulDyXuztbnwjXcoNLmC6rmw/
        /TvCPbcGLEDmg6L4A3tHTTpKK3vMWW98DXWE2Lk=
X-Google-Smtp-Source: APXvYqzK/pO2JsGhTmXyuCy3R1mP3JGwo8p/BrUJKPSsbrO3U/eegdmEsnqctS1xl4zAVnWgcQ6pvE/uhh8JKLgfdMw=
X-Received: by 2002:aca:ba82:: with SMTP id k124mr10887710oif.110.1554552847833;
 Sat, 06 Apr 2019 05:14:07 -0700 (PDT)
MIME-Version: 1.0
References: <CAMknYEPS68VEkUbNxeKQvVDGjzVpBXKNAi3uA04pLwN9k4ZTfA@mail.gmail.com>
 <CACsJy8AnXawOgC0eWKpSF7iGXAvPdP9=SZX1HePRABVdkiKs8g@mail.gmail.com>
In-Reply-To: <CACsJy8AnXawOgC0eWKpSF7iGXAvPdP9=SZX1HePRABVdkiKs8g@mail.gmail.com>
From:   Kapil Jain <jkapil.cs@gmail.com>
Date:   Sat, 6 Apr 2019 17:43:56 +0530
Message-ID: <CAMknYENJogZ6vxs3zxivD3TPtDnfE9DFQDTwri+eLJmTwr4zxw@mail.gmail.com>
Subject: Re: [RFC] TODO in read-cache.c
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     git <git@vger.kernel.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Thomas Gummerer <t.gummerer@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Apr 6, 2019 at 5:33 PM Duy Nguyen <pclouds@gmail.com> wrote:
>
> trace2 API can already take 'struct repository' (the_repository is a
> pointer to 'struct repository'). I'm pretty sure the purpose is to
> _not_ pass the_repository (because it implies the default repo, which
> is not always true). Which means you read-cache.c's functions need to
> take 'struct repository *' as an argument and let the caller decide
> what repo they want to use.

right, i mistyped.

> In some cases, it will be simple. For example, if you have a look at
> repo_read_index(), it already knows what repo it handles, so you can
> just extend read_index_from() to take 'struct repository *' and pass
> 'repo' to it.
>
> Be careful though, repository and istate does not have one-to-one
> relationship (I'll leave it to you to find out why). So you cannot
> replace

should i run all the tests after making the changes, or are there some
specific ones.
