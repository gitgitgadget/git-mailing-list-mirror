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
	by dcvr.yhbt.net (Postfix) with ESMTP id 4FB211F4C0
	for <e@80x24.org>; Fri, 11 Oct 2019 08:52:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727470AbfJKIwZ (ORCPT <rfc822;e@80x24.org>);
        Fri, 11 Oct 2019 04:52:25 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:39085 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727032AbfJKIwZ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 Oct 2019 04:52:25 -0400
Received: by mail-wr1-f66.google.com with SMTP id r3so10952189wrj.6
        for <git@vger.kernel.org>; Fri, 11 Oct 2019 01:52:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:reply-to:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=9+4VjDUUMRqFUxo0WUycwaMCDArqJYT10+LqRYvkx/c=;
        b=UmmayxfpXyepqv1SVO4uXCXJZ+7KnrGivpIo7Etz7dFCfRdy2pCk7m+8Nmj3XgL9jM
         qsMFPhXxPPsXz4AqYb+Bx3wvImT79reXdsfDmM+ZTCIw9l6Ops3sCy2dxWZRJNiHPrx1
         pM3OBxdsqOOLEPx5NCj0H8Cp2CUg4jRy+jLvhwcWNbj/ZfUDs9C1eA3f71OPg6m8MEp4
         HE2oQOOgDknN/mxE+CF56HHJiwL8JeNStCQcw6zndJlihxP9Uop0MudQJgAKVBmE97w3
         AenxI7XlUTgbq0gTUWMVA3S0J2PCSIecb8OSZ1JuLK8EoYUetGlIlv87nK9IvBy1CdGC
         R9cQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:reply-to
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=9+4VjDUUMRqFUxo0WUycwaMCDArqJYT10+LqRYvkx/c=;
        b=J1zA24B4eL7D9FmBKL65PGTnXPJI2fkfOR3Ovop4Oka7arHazGWrvm1asEehZRL6Vl
         pWfMr9BMuhSE8f82FZUvvYTM4i2qnYYEWAvGVe2Ok3d1ezf2I/pSZgExC/Udbcy+vXvg
         0Uemg2lK6TPng4rTnLJ1ZaILJKbTxjGHaQMyk3jjOsISiJTu7H83JLL3WwXF96pboabr
         rzPmJT8vCjI0fwME7kRrJ+vAQS3CjveLDLgdAoQjLAksOeCIZ3SAGnJTgO/sFDjq00GO
         +nOH8jqyRHzjq+WVMeKu4skryZbGps5DMX8Cos2Q8DLfr8fPXwkRbkhLmnwcdM9Hbdil
         6gYA==
X-Gm-Message-State: APjAAAWYV8x2QpCeY9G6vwWwx/P7JZnsUqJaSVLwmpMNyvb8x9R2rLo7
        021OCgCaa6bAGvdtIO/n2Vs=
X-Google-Smtp-Source: APXvYqxjnB1tX5+79N2UozEnW3fJjXW63srH/6pdUwNMluj83H277sRjc41nJSupmwUjYRu8S7mszA==
X-Received: by 2002:a5d:540d:: with SMTP id g13mr8935786wrv.8.1570783942725;
        Fri, 11 Oct 2019 01:52:22 -0700 (PDT)
Received: from wambui ([197.237.61.225])
        by smtp.gmail.com with ESMTPSA id d15sm8843922wru.50.2019.10.11.01.52.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Oct 2019 01:52:22 -0700 (PDT)
Date:   Fri, 11 Oct 2019 11:52:17 +0300
From:   Wambui Karuga <wambui.karugax@gmail.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [Outreachy] [PATCH] blame: Convert pickaxe_blame defined
 constants to enums
Message-ID: <20191011085217.GA8481@wambui>
Reply-To: 20191010184439.94173-1-jonathantanmy@google.com
References: <20191010115230.10623-1-wambui.karugax@gmail.com>
 <20191010184439.94173-1-jonathantanmy@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191010184439.94173-1-jonathantanmy@google.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Oct 10, 2019 at 11:44:39AM -0700, Jonathan Tan wrote:
> > Convert pickaxe_blame preprocessor constants in blame.h to an enum.
> > Also replace previous instances of the constants with the new enum values.
> 
> First of all, thanks for your initiative in finding a microproject and
> making a patch for it!
> 
> About your commit message title, I know that 50 characters is a soft
> limit, but we should adhere to it if possible. Also, in Git, the letter
> following the colon is usually in lowercase. So I would write it like:
> 
>   blame: make PICKAXE_BLAME_* an enum
> 
> (Feel free to use that or think of a different one.)
Okay, thanks for the suggestion. I'll use it.
> 
> > -	if ((opt & PICKAXE_BLAME_COPY_HARDEST)
> > -	    || ((opt & PICKAXE_BLAME_COPY_HARDER)
> > +	if ((opt & BLAME_COPY_HARDEST)
> > +	    || ((opt & BLAME_COPY_HARDER)
> 
> Any reason why the names are renamed to omit "PICKAXE_"? In particular,
> these names are still global, so it is good to retain the extra context.
> 
> (This doesn't mean that you are wrong to remove them - I just gave my
> opinion, and a reason for my opinion. If you had a reason to remove
> them, you can mention that, and we can discuss this together. Or, if you
> read my reason and agree with it, you can say that and put the
> "PICKAXE_" back.)
> 
I wasn't really sure about omitting the "PICKAXE_" prefix, but I looked
at some of the other defined enums and it seemed like what would act as
the prefix in #defines was only used in the enum declaration. For
example I looked at:
	enum apply_ws_error_action {
		nowarn_ws_error,
		warn_on_ws_error,
		die_on_ws_error,
		correct_ws_error
	};

For comparison, I took "apply_" as the prefix that would translate to 
"#define APPLY_" which isn't included in the member variables.
I do agree about retaining the extra context though, so I can definitely put the
"PICKAXE_" back.

> > -#define PICKAXE_BLAME_MOVE		01
> > -#define PICKAXE_BLAME_COPY		02
> > -#define PICKAXE_BLAME_COPY_HARDER	04
> > -#define PICKAXE_BLAME_COPY_HARDEST	010
> > -
> >  #define BLAME_DEFAULT_MOVE_SCORE	20
> >  #define BLAME_DEFAULT_COPY_SCORE	40
> >  
> > +enum pickaxe_blame_action {
> > +	BLAME_MOVE = 01,
> > +	BLAME_COPY,
> > +	BLAME_COPY_HARDER = 04,
> > +	BLAME_COPY_HARDEST = 010,
> > +};
> 
> In Git, we often look at historical commits, so it is good to keep
> history as clean as possible. In particular, we shouldn't move things
> around unless we have another reason to. Here, for example, you are
> moving the constants from above BLAME_DEFAULT_* to below. You should
> move them back. (Or if you have a reason for moving, mention that and we
> can discuss it.)
> 
I'll move them back. I have experience with all the "#define" constants
being immediately after the "#includes" which is why I moved them, but I'll try to stick to the
convention from now on.

> Also, I have a slight preference for putting "= 02" on the BLAME_COPY
> line but that is not necessary.
> 
Noted.

> Apart from all that, one thing that I expected in this patch is the
> changing of the type of local variables and parameters. For example, in
> blame.c, I would have expected find_copy_in_parent() (for example) to
> have its "opt" parameter changed from "int" to "enum
> pickaxe_blame_option". One of the reasons why we want to use enums is
> for type safety, and that can only be done if we use the enum type when
> possible.
I overlooked this, sorry for that.
I'll send an updated patch with these corrections.

Thanks!
