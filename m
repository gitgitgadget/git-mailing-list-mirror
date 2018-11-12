Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-1.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 65AEB1F87F
	for <e@80x24.org>; Mon, 12 Nov 2018 18:39:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729173AbeKMEeJ (ORCPT <rfc822;e@80x24.org>);
        Mon, 12 Nov 2018 23:34:09 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:34768 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727247AbeKMEeJ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Nov 2018 23:34:09 -0500
Received: by mail-pf1-f193.google.com with SMTP id y18-v6so4731473pfn.1
        for <git@vger.kernel.org>; Mon, 12 Nov 2018 10:39:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=DriQIm+05JiQ8Vc4cfSQXYViwrVbYJXX+uSPY4HfL2Y=;
        b=YHqBgc1u7NpFSLsCx2ezH3iY8CEY3k9HptyTgFZyKunuWnOoFtUaxSUMpU7bju3hei
         9Yx9k9YZBpWDp1pK+TosF1X+mqdwoCX6+BERwCrKexDKHSAg362l1lKoJpLy1QWwcTCq
         emb6m0ml+cUhxYyPeDxqthOQHk1Mq2oaGbdTQKyqZ7m4Vz+iRUTmL+Xkn1PnDi1bpvDf
         bI/WbFqE+smzOZw+cm+MNifMAf3xTaziowOZyOGUQpFuToX3W491q+andwQBHqJ38lBq
         Up06nRlss6FCG2dOegFx6pC5dRIPbvppig1OrE7iDPlWsBv5n+vpp5yYwLF42jOITsdf
         NL5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=DriQIm+05JiQ8Vc4cfSQXYViwrVbYJXX+uSPY4HfL2Y=;
        b=V0LdHphC3XZZ8RHZD1ajLws/z02OrG7k9zQKc+j+YHOrQ7qLGcAnwfSmY/vT/x+Dp8
         nAYIBgDCGnIzaakqJQVNfRLFROgWkVq/Vwb8rKRQYwM7kY3XC5b6Hmq/MbPkmh7WgnBa
         H9a35A67HgbY8zDiih3qnPmRo/Unq9ro0qkfDM4uObNJdle7KDrCMfnBrkP/Y2wJQT2X
         9LcnO1AladwGKDe8GJ4gSMt/SVY6C8EhkeeTUDAj4f1okOk9TJQngd05J4EIaZ6BZdo1
         gWf4fkZdXBcdDX3t5jAGyYDk5rmNIAPnqKSGMT6UGN9iaz3iPDEVqgj5hez9kqufATCf
         Mj2A==
X-Gm-Message-State: AGRZ1gJZTvRnpcZlkc+ZaFt/c+WOya6f/zql1cDBQj4HvtmuSNn3Lc1n
        PjZm2X6LgNANanN7Nc8xqm4=
X-Google-Smtp-Source: AJdET5fJNECO6ARQKgseOyey/J7UYQ7CnfCuWvPmr2rUnLxTv/upPWcl0tJWjUVxPRGMDrnZAwpp2Q==
X-Received: by 2002:a63:d005:: with SMTP id z5mr1109967pgf.64.1542047981467;
        Mon, 12 Nov 2018 10:39:41 -0800 (PST)
Received: from google.com ([2620:0:100e:913:3fb0:1473:cdbf:42])
        by smtp.gmail.com with ESMTPSA id f22-v6sm16021860pfn.177.2018.11.12.10.39.40
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 12 Nov 2018 10:39:40 -0800 (PST)
Date:   Mon, 12 Nov 2018 10:39:39 -0800
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Fredi Fowler <inredikawb@gmail.com>
Cc:     git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: Git Reference Manual enhance
Message-ID: <20181112183939.GA44368@google.com>
References: <CAEv5rCuQM_6ch3KX1ji9nY0hW9eFVomO3svg79D67PqR1uY1tg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEv5rCuQM_6ch3KX1ji9nY0hW9eFVomO3svg79D67PqR1uY1tg@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Fredi,

Fredi Fowler wrote:

> Is there any way to create pull request to git man (https://git-scm.com/docs)?
>
> I found there some inconsistencies. For example, almost in all pages
> are using [no-], but at https://git-scm.com/docs/git-merge each
> command (with [no-] or without) write separately.
>
> There are some same inconsistencies that a easy to fix. So, if I can
> sent a pull-request for such fix – inform me.

Welcome!  Yes, feel free to make improvements to the manual.  First,
you'll want to clone the repo:

 git clone https://kernel.googlesource.com/pub/scm/git/git

Then make changes.  You can test using "make":

 make -C Documentation git-merge.html
 open Documentation/git-merges.html

Once you're happy with the patch, it's time to send it out for review.
The Git project uses a decentralized review process using email.  See
https://www.kernel.org/pub/software/scm/git/docs/SubmittingPatches.html
for details about how it works.

If you are used to the GitHub pull request process, you may enjoy
GitGitGadget, which acts as a sort of bridge.  See [1] for
instructions.  Please do also keep in mind the hints from
SubmittingPatches e.g.  about how to describe your changes and how to
certify your work.

Thanks, and looking forward to seeing your contributions,
Jonathan

[1] https://github.com/gitgitgadget/gitgitgadget/blob/master/README.md#a-bot-to-serve-as-glue-between-github-pull-requests-and-the-git-mailing-list
