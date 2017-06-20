Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FROM,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID,T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id ABB3520282
	for <e@80x24.org>; Tue, 20 Jun 2017 18:28:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751131AbdFTS2a (ORCPT <rfc822;e@80x24.org>);
        Tue, 20 Jun 2017 14:28:30 -0400
Received: from mail-pf0-f178.google.com ([209.85.192.178]:34261 "EHLO
        mail-pf0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750927AbdFTS23 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Jun 2017 14:28:29 -0400
Received: by mail-pf0-f178.google.com with SMTP id s66so73070541pfs.1
        for <git@vger.kernel.org>; Tue, 20 Jun 2017 11:28:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :disposition-notification-to:mime-version:content-transfer-encoding;
        bh=jkzkF0TCFsTJGoFTLJGy77faHlem3W4ZUlVzJCXXFOA=;
        b=VcSJcVbPyhCbFHhhQJ/H5dVrGx+7bVDGxYK5Jh61JDOOGs6yd804iTgRo5gRxm9Dg+
         yYU1k84aO5K8kippOV2ev6xkBzzDYOQdPVKI0xeX3ynf8e4WBXLwSpTgVEnmFn+Jan9g
         KuTDaOAJcyT5kPSPwivYu9qyghCHzGhJqaHySMZljVVzbHISp0+imCjO4/49qTTUVXmz
         f6IhQIwFtF7xq2t82N2+fNkREEc0y9DIk7h21GdDrv11U47RRMq3b/UF3SEnQy+6kxFY
         XXB7uqcI6+F6e/CoM0g06LSqH/m1nEUTaXic7xPNFdMGmWcjfLsQ3AEI/1N4bSeCCASt
         jTUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:disposition-notification-to:mime-version
         :content-transfer-encoding;
        bh=jkzkF0TCFsTJGoFTLJGy77faHlem3W4ZUlVzJCXXFOA=;
        b=a/4NhCVm3ed4qhdWsIIJy3Fgd+irXXpKG+OHY7sJ/gY4ZM1TpzVYFaSiWiba/m9qeR
         vHWAiAORNj5wytTFGQn7Ggi85X4KaI1q6pjkycIm7CfNin5Z8oiybySz3KAFKBq8cqid
         H+/xUKu1VNI1nTbqT26G/7GZNlyO2k6Ngr80hnBYP4j2kwam1Da9uaOwJOpjsXIA/IBG
         wXsLyYJmqUIH7iTyvHwTxmnrl52iMzXR/ul53lc3ssx4s0YtCvH+7WvS6GdyW3m+o31j
         sGq7GHsoLh7Fu2i8LpyBPmw9zH8pNvKQqQnpUxznzAA3Nf0TqPYr1yQxDMC6NKuuuur0
         usbw==
X-Gm-Message-State: AKS2vOwhWLVhRFAOYtUpRdsULCOEK7KZy86Mohh6Zqe+X0vH0GKm7pq1
        0j+zz3gmQFS9SQ==
X-Received: by 10.101.88.67 with SMTP id s3mr32199317pgr.75.1497983308585;
        Tue, 20 Jun 2017 11:28:28 -0700 (PDT)
Received: from unique-pc ([218.248.21.162])
        by smtp.googlemail.com with ESMTPSA id z71sm29631506pfd.45.2017.06.20.11.28.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 20 Jun 2017 11:28:28 -0700 (PDT)
Message-ID: <1497983273.28187.9.camel@gmail.com>
Subject: Re: [PATCH/RFC] Cleanup Documentation
From:   Kaartic Sivaraam <kaarticsivaraam91196@gmail.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Date:   Tue, 20 Jun 2017 23:57:53 +0530
In-Reply-To: <CAGZ79kbJx4p2y6Vjp3dVBP2pd=MYa_j3Mxfv=zUygHY-bHj0wQ@mail.gmail.com>
References: <CAGZ79kbMhQpxUa5TXK=WCzzKUCZ5vx3oC+fFTTozpgQihsUjTA@mail.gmail.com>
         <20170620031214.7616-1-kaarticsivaraam91196@gmail.com>
         <CAGZ79kbJx4p2y6Vjp3dVBP2pd=MYa_j3Mxfv=zUygHY-bHj0wQ@mail.gmail.com>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.22.6-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Cyberoam-smtpxy-version: 1.0.6.3
X-Cyberoam-AV-Policy: default
X-CTCH-Error: Unable to connect local ctasd
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, 2017-06-20 at 09:57 -0700, Stefan Beller wrote:
> canonical: "according to recognized rules or scientific laws."
> sounds about right. :)
> 
I actually used as I found it to have the meaning of "conforming to
orthodox or recognized rules" :)


> While this was just reflowed and not newly introduced, I am still
> left wondering what a changeset is in Git terms. Our
> Documentation/glossary says:
> 
>   [[def_changeset]]changeset::
>   BitKeeper/cvsps speak for "<<def_commit,commit>>". Since Git does
> not store changes, but states, it really does not make sense to use
> the term "changesets" with Git.
> 
> Maybe we should say instead:
> 
>     If <path>exists and is already a valid Git repository,
>     then this is staged for commit without cloning.
> 
Does seem to be a good change to make. Done.

On Tue, 2017-06-20 at 10:05 -0700, Stefan Beller wrote:
> > On Tue, Jun 20, 2017 at 9:57 AM, Stefan Beller <sbeller@google.com>
> > wrote:
> > > 
> > > With or without this nit addressed, this patch looks good to me,
> > > 
> > 
> > Well actually not quite. The subject (and commit message) is very
> > vague,
> > maybe:
> 
> >     Documentation/git-submodule: cleanup "add" section
> > 
> >     The "add" section for 'git-submodule' is redundant in its
> > description and
> >     the short synopsis line. Remove the redundant mentioning of the
> >     'repository' argument being mandatory.
> > 
> >     The text is hard to read because of back-references, so remove
> > those.
> > 
> >     Replace the word "humanish" by "canonical" as that conveys
> better
> > what
> >     we do to guess the path.
> > 
> >     While at it, quote all occurrences of '.gitmodules' as that is
> an
> > important
> >     file in the submodule context, also link to it on its first
> > mention.
> >     (This paragraph is not exactly what happens in the commit, but
> I
> > wrote it
> >     as a way how I would write commit messages. It shows the reader
> > how
> >     you addressed the given problem, with the quantifiers "all"
> "the
> > first" showing
> >     what you think is important, and that you deliberately omitted
> > others)
> 
Made this change too.


-- 
Regards,
Kaartic Sivaraam <kaarticsivaraam91196@gmail.com>
