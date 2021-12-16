Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE4E9C433EF
	for <git@archiver.kernel.org>; Thu, 16 Dec 2021 06:27:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234102AbhLPG1O (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 16 Dec 2021 01:27:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231650AbhLPG1O (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Dec 2021 01:27:14 -0500
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FC74C061574
        for <git@vger.kernel.org>; Wed, 15 Dec 2021 22:27:13 -0800 (PST)
Received: by mail-wr1-x434.google.com with SMTP id j9so10048457wrc.0
        for <git@vger.kernel.org>; Wed, 15 Dec 2021 22:27:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=+Tr5tYkHpAMLmB+tX613kcrxnuu7doShROU0GeJUmn4=;
        b=gbP8Px7clczif8f6tzCZHojMeYBGjaFz6UBM7bbs1CmFXhobc7QSKrJbNp058s1tmB
         gkWf589NHGHMpt1JtGS1j+cSQHqlvavNgq+2+lIOc7VefFqLY/FOmbcQNSKZx0d9TY2d
         LE/PgdgnoHek9o/dS7Vscr77plDtw2ju7544nGSKYSyuQvOMV/s71ZCW0C+dGiCD8gaq
         vMcu2xyuvunxkdl/sEckWXxA23ZlvWCoWLYEqbN+gp9nMQ7Ya4hnfr6rrUhGmJaKZpCO
         u2Re9hpcMxXHztN27PnCy4ecVs7vSMh1xtfxT0NKC1f6H9iidj/gFtn5pkr1puhF+G3J
         TQlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=+Tr5tYkHpAMLmB+tX613kcrxnuu7doShROU0GeJUmn4=;
        b=tRnud2BsNUsUwJ9M33fT+sIeFIWRGH91hbfnjYf69v2pBcuZ/2b4Fxnlz8O0jPSYX9
         pJfpca8RAhu9kRygl/ITUHejKt5lH9z+sxbaNcFgj/5hTSMjY200/CKPepIsaXNTC8Da
         lsCCEPGLAh9GP2dkN6Gc561KcIkMb6nP5dgm12zbQyOPVg0iDXXYdWMfTog0jzILHARy
         pRvDcbRtLBZkLEx7hcV2GInlMwb3jqAJcTemtmlCT8sDR/beXNLztojbmCj721Wd5X5P
         5YaXW31CF+/Lh2+14XvpPX54cN+lm4sbDjs43flWLXG8xlr9SINaVcbJrPPSqxsiYJG3
         FfWw==
X-Gm-Message-State: AOAM533IGnoJQdPpUdyxlBYcsxxqccq/GmE6253w48osr4IRBUnoZTXM
        zFk8Y72BonshgF1BILr/3cjAGd1CMF7Hvw==
X-Google-Smtp-Source: ABdhPJx2Sdri6WQa8v0fWv1izTJNHVeP2L9o1Vkf6MasCPFRcvTIvClvO9/nlz9D2M2hJ0Y4/df85Q==
X-Received: by 2002:adf:fb09:: with SMTP id c9mr7618123wrr.223.1639636032265;
        Wed, 15 Dec 2021 22:27:12 -0800 (PST)
Received: from gmail.com (91.141.72.246.wireless.dyn.drei.com. [91.141.72.246])
        by smtp.gmail.com with ESMTPSA id m3sm3759663wrv.95.2021.12.15.22.27.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Dec 2021 22:27:11 -0800 (PST)
Date:   Thu, 16 Dec 2021 07:27:09 +0100
From:   Johannes Altmanninger <aclopte@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     kashav madan via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, kashav madan <kshvmdn@gmail.com>
Subject: Re: [PATCH] help: add space after autocorrect prompt
Message-ID: <20211216062709.b4tcagi6qcqhasrh@gmail.com>
References: <pull.1166.git.git.1639604468498.gitgitgadget@gmail.com>
 <xmqqh7b933ej.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqh7b933ej.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Dec 15, 2021 at 02:32:36PM -0800, Junio C Hamano wrote:
> "kashav madan via GitGitGadget" <gitgitgadget@gmail.com> writes:
> 
> > From: Kashav Madan <kshvmdn@gmail.com>
> >
> > Signed-off-by: Kashav Madan <kshvmdn@gmail.com>
> > ---
> >     help: add space after autocorrect prompt
> 
> The patch looks OK-ish, but let's make sure.  We will find what we
> should write in the log message while doing so.
> 
> If you look at the output from
> 
>     $ git grep -C2 git_prompt \*.c
> 
> you'll notice that existing message given to git_prompt look like
> these:
> 
>     yesno = git_prompt(_("Are you sure [Y/n]? "), PROMPT_ECHO);
> 
>     yesno = git_prompt(_("Do you want me to do it for you "
>                          "[Y/n]? "), PROMPT_ECHO);
> 
>     strbuf_addf(&msg, _("Run '%s' instead? (y/N)"), assumed);
>     answer = git_prompt(msg.buf, PROMPT_ECHO);
> 
> The last one is what you are touching in this patch.
> 
> There is another one in credential.c that asks not just a single
> yes/no answer, so it is justifiably different from all the others,
> but the one you noticed is different from what we see above in three
> points:
> 
>  - It does not leave a SP before where the end-user input goes;
>  - It append (y/N) _after_ question mark;

I actually prefer this one;

	Run 'status' instead? [y/N] 

sounds better than

	Run 'status' instead [y/N]? 

but that's not a strong opinion.
