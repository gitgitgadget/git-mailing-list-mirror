Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8FC3D1F453
	for <e@80x24.org>; Thu, 27 Sep 2018 16:26:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728229AbeI0Wp3 (ORCPT <rfc822;e@80x24.org>);
        Thu, 27 Sep 2018 18:45:29 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:33946 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727320AbeI0Wp2 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Sep 2018 18:45:28 -0400
Received: by mail-pg1-f194.google.com with SMTP id d19-v6so2354663pgv.1
        for <git@vger.kernel.org>; Thu, 27 Sep 2018 09:26:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=xC2m1qhOjrZIxXHNAsnnVzjCQLW0V8wvGzM+hLLzE08=;
        b=mRVQr5/qf+vuee8e5yOAN+UWeVp7x+ZeM0hYFGlE+ly50JVvSUPwlARXgkXaSNs0D2
         sfNN7VP+whvFrf7098mMxn/UrkJe/GWLSPyV/byVHwglv9TL7HUfulKDU+C+ohWy1tWB
         PkPn8NHztbs7VJPT6D6b8XvSn39LNxd3q5xJR1NOpoIurE9mr5xtgS6eTlr0vfhN8ENc
         EOfiqmpKoN1r/qQ8jVwmnuuTmueXY/PR2C0uwv7lni8jdS6GTfJPfWQiawBRCvA0asza
         lny+HR3y5r2midSMQEvrlux+muXIf8erYgXvsnld5mwjwMy5QIUodCZNDuK/TM3zdHUM
         7Vow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=xC2m1qhOjrZIxXHNAsnnVzjCQLW0V8wvGzM+hLLzE08=;
        b=c0JIF5p6Fe6Da9diPwn0kIcqV4fHm0upxLV6oL42bGh3peVWo2F+KOFNtjjf2GQ1lK
         TVLyOpnsWe93vRZ6VQPV1U2oV7Nb2LrqBKO1Vtm84g007ECVW/Mix60gGIwDIwInScSa
         TY9jYPo+q07ooYWyu0jqgc8Qq42u5+B6FK6aK5IADgQyB0a7myxFP5nPDxvLufZkA7+L
         zWnFlJJH8hA8B7kBGFP8iWel0v4X6Vz6dglSYmmgWi/pjll3MFf3l/epn+9KvvEL/HUP
         LQ2DZek9mHrRdl0EEeWiMOSwTPNASQPoW+o9UGzIgr7/mR9Zxnyf+5jeHtoAxT5YhaWG
         jwfg==
X-Gm-Message-State: ABuFfojPmqMVcrmIjT2jOWbYkaxBOBHoDAMK6c2Ez22IjBH82GC0H9W0
        jursom+MsZg0Uh2OQqQ+7Tg=
X-Google-Smtp-Source: ACcGV60D6pd1JAhJKqzLBMObHFEfKnVux32qbQEtKW1KsgQpJu3hkdFERWeGpyCQiXuxpK2PMGN9KA==
X-Received: by 2002:a17:902:9005:: with SMTP id a5-v6mr9216101plp.86.1538065585670;
        Thu, 27 Sep 2018 09:26:25 -0700 (PDT)
Received: from aiede.svl.corp.google.com ([2620:0:100e:422:4187:1d6c:d3d6:9ce6])
        by smtp.gmail.com with ESMTPSA id 189-v6sm4023196pfe.121.2018.09.27.09.26.24
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 27 Sep 2018 09:26:24 -0700 (PDT)
Date:   Thu, 27 Sep 2018 09:26:23 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        git-packagers@googlegroups.com, Git List <git@vger.kernel.org>
Subject: Re: Git for Windows for Unix?
Message-ID: <20180927162623.GB112066@aiede.svl.corp.google.com>
References: <87va6rhqup.fsf@evledraar.gmail.com>
 <20180927160523.GA112066@aiede.svl.corp.google.com>
 <87tvmaj4fq.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87tvmaj4fq.fsf@evledraar.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Ævar Arnfjörð Bjarmason wrote:

> So it's similar to various packages that have "alternates" and are semi
> or permanently forked, like emacs & xemacs, JDK etc., although I can't
> recall one offhand that's quite similar to GFW v.s. git.git.
>
> My only stake in this is I thought it would be neat to be able to "apt
> install git-for-windows", but I understand there's a support burden, but
> if some *nix packagers are interested, maybe never taking it out of the
> Debian equivalent of "experimental" and saying "this is unsupported, go
> to the GFW tracker..." when bugs are filed would cut down on the support
> burden.

If someone else wants to package git-for-windows for Debian, I am
happy to offer them advice and will not stop them.

That said, that seems to me like a lot of work to avoid adding some
patches to "next" that belong in "next" anyway.  I understand why the
Git for Windows maintainer does not always have time to upstream
promptly, which is why I suggest working with him to find a way to
help with that.

If there's something I'm missing and Git is actually an uncooperative
upstream like the cases you've mentioned, then I'd be happy to learn
about that so we can fix it, too.

Sincerely,
Jonathan
