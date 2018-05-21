Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 50C6F1F51C
	for <e@80x24.org>; Mon, 21 May 2018 18:15:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753331AbeEUSPO (ORCPT <rfc822;e@80x24.org>);
        Mon, 21 May 2018 14:15:14 -0400
Received: from mail-pf0-f194.google.com ([209.85.192.194]:44176 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753238AbeEUSPO (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 May 2018 14:15:14 -0400
Received: by mail-pf0-f194.google.com with SMTP id q22-v6so7466822pff.11
        for <git@vger.kernel.org>; Mon, 21 May 2018 11:15:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=RxbQG0biahCH2XVpJcVj3vRTHKMbyMXwKrBIW94cDv4=;
        b=Urzl/bl2J+Zr0HDziShv3hp5x9W1msf0orHb2HbThdekBH7fv0QSwy5DVI7+mJtJCX
         X1hcwH4EaE7qDTQ6cNjTbJP5EVEB0DT+NjsHOHh0d2DrxRGuGjt7Lc6+OA2Oj90XJOvw
         N0m0QKS+mfijWSoHQZ0wyV6DDH5dkf32xAu2jQflrCs3aCNxizHWNiIxqYcBPWygMC+B
         2S1L7OCSUsjHNnXVHwJik/KMCCVYOGcK1UGwKcBcFJ6oYM2RpOEycx2JlpmHE4CqfRx3
         kty3v1YRkGGEKUaMnfDOaPgKskiJaKlVMvO+mgVq/wrfpMqX7IL7q/WAFcZIR2T2CVJ7
         AIJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=RxbQG0biahCH2XVpJcVj3vRTHKMbyMXwKrBIW94cDv4=;
        b=XrX0lwZrfce2kTxxIKJEKp/SrJ76pPEN4+9TzgooQw0Vl5lTNGA03PpvhibpyccdSv
         jf7dB4g+u4dalBKUVQnYQ69zZbc/wkGvyKmpA6bNMwMTgF5LRnAgX5GVlwqn3BC2K6W5
         dzyZitNdxTiPi2+NyIWUaNpb0GGUtbDHiNDxCAkTs0wbsvJ/qWx7mh2HyUR+mofFqXUN
         +nlDyFrBTCBxvVQiAK/gbACswCQzxDyIDZ/1KSKbYl8z5xsB49qT8dPGlD0Ldb2uQ2am
         OA3dtCXrHot8zEFqfzDI5gHTI2i6fTZKPSgYeMYgCdJTTez3WaWaFAoB1uVXhJGD0FrI
         MRSA==
X-Gm-Message-State: ALKqPweuQa9E+puLy7xpnuoi4qIEnEnoCOG8pwJoZnbg51Cd/82MfJg8
        KOXO41Fw9vZf4F5vsuDg10I=
X-Google-Smtp-Source: AB8JxZpSQOVnVX/K1tpHUtvLpA23DGoagWwI5vIRUzvhwOg+ZWM/Uj/rPYcA4MebU6Z6va5685walg==
X-Received: by 2002:a65:4306:: with SMTP id j6-v6mr16638054pgq.341.1526926513357;
        Mon, 21 May 2018 11:15:13 -0700 (PDT)
Received: from aiede.svl.corp.google.com ([2620:0:100e:422:4187:1d6c:d3d6:9ce6])
        by smtp.gmail.com with ESMTPSA id s2-v6sm25810882pfb.127.2018.05.21.11.15.12
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 21 May 2018 11:15:13 -0700 (PDT)
Date:   Mon, 21 May 2018 11:15:11 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     "Robert P. J. Day" <rpjday@crashcourse.ca>
Cc:     Elijah Newren <newren@gmail.com>,
        Git Mailing list <git@vger.kernel.org>
Subject: Re: which files are "known to git"?
Message-ID: <20180521181511.GD10623@aiede.svl.corp.google.com>
References: <alpine.LFD.2.21.1805210717040.9926@localhost.localdomain>
 <CABPp-BH0bw3m5Ubz2+-XyFGwoHD96sAaSen9-SHQSBqMS-9u5w@mail.gmail.com>
 <alpine.LFD.2.21.1805211335250.21160@localhost.localdomain>
 <20180521175335.GC10623@aiede.svl.corp.google.com>
 <alpine.LFD.2.21.1805211405410.21888@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.LFD.2.21.1805211405410.21888@localhost.localdomain>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Robert P. J. Day wrote:

>   i did a quick search for that phrase in the current code base and
> came up with:
>
> builtin/difftool.c:		/* The symlink is unknown to Git so read from the filesystem */
> dir.c:		error("pathspec '%s' did not match any file(s) known to git.",
> Documentation/git-rm.txt:removes only the paths that are known to Git.  Giving the name of
> Documentation/git-commit.txt:   be known to Git);
> Documentation/user-manual.txt:error: pathspec '261dfac35cb99d380eb966e102c1197139f7fa24' did not match any file(s) known to git.
> Documentation/gitattributes.txt:	Notice all types of potential whitespace errors known to Git.
> Documentation/git-clean.txt:Normally, only files unknown to Git are removed, but if the `-x`
> Documentation/RelNotes/1.8.2.1.txt: * The code to keep track of what directory names are known to Git on
> Documentation/RelNotes/1.8.1.6.txt: * The code to keep track of what directory names are known to Git on
> Documentation/RelNotes/2.9.0.txt:   known to Git.  They have been taught to do the normalization.
> Documentation/RelNotes/2.8.4.txt:   known to Git.  They have been taught to do the normalization.
> Documentation/RelNotes/1.8.3.txt: * The code to keep track of what directory names are known to Git on
> t/t3005-ls-files-relative.sh:			echo "error: pathspec $sq$f$sq did not match any file(s) known to git."
> t/t3005-ls-files-relative.sh:			echo "error: pathspec $sq$f$sq did not match any file(s) known to git."
>
> so it's not like there's a *ton* of that, but still enough to want to
> get it right. should there be a precise definition for the phrase
> "known to git", or should that phrase simply be banned/replaced?

In my opinion: the latter.

It's not like the phrase represents some concept that we don't have
any other name for.  They're also known as "tracked files" and that
name is more intuitive.

Thanks,
Jonathan
