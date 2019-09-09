Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 312CC1F463
	for <e@80x24.org>; Mon,  9 Sep 2019 18:58:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732576AbfIIS6d (ORCPT <rfc822;e@80x24.org>);
        Mon, 9 Sep 2019 14:58:33 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:39885 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732524AbfIIS6d (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Sep 2019 14:58:33 -0400
Received: by mail-pg1-f193.google.com with SMTP id u17so8310108pgi.6
        for <git@vger.kernel.org>; Mon, 09 Sep 2019 11:58:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=PXTQP5muCox3w39joPNeyNExCTTwGY16f4vARlqPrNg=;
        b=FxtlDHn4KCEhqWllpI3+vQKFwqx7+OxADlE2gnyMKpsU+3hzgrFIs8LC7QJGiavwpG
         A9CEwueZrcYmQmRVWtl7HEQi1sxb+RDLq3IBkFA+vzLWcMqhfTiajCBBu6rEa19hqGB7
         4bMJL5wRBDFeKlufyhAUhXy9dQSVwAvmRdkKtTM693TTtxIOwXy8LQIMzVFGD1M75AL+
         hzXia8zN4kc7SSxGOmXNEIPWLfChoojN2sBwzN82InzpaQ31nLvn09GYNGN5FXHRuuGd
         8KpvvUu4bMwinarfZD+OQzeGbucnKl8MJD/2XrT8On7ddZRF36iYhYgol2QDuGIM/qwj
         V+wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=PXTQP5muCox3w39joPNeyNExCTTwGY16f4vARlqPrNg=;
        b=jv8nZLWk+358pdVNY1aUOnTz7x00K/GVCiir7zrZR5LDjKVqgJgMIQlDtJl7JXF+5M
         gyAS0FJf+CnUsOFDX/L8lU8KIeB5uEoBwdrFyWVpGZWuPwGuojZP5kaKbk6w4Svj6dFp
         v2cj18FsWXSGgJsq+5i80Jv1xmf8ipaQULMTRzEhrYEadJad8+XeFIW6sqjeoL9NVM+7
         pHfE88FE+6c8peevT7MweKSBkcQM6P/mQgpPMcLFkY+nNnvcYuh3f1uXnjU3rZzWjUlP
         kvi1TAR84CZhszibkMBwjalwmFyZ34r6qKvEXBkLjLQ7u/nmr+AcR/2pQIuQXeAa6jVQ
         c20Q==
X-Gm-Message-State: APjAAAVKuBY5r0dOw+xaGq9FT86Ow65jS6scUdATpob4SQ/QxBV6Bh2H
        jbivoYcssBkgvcqJO1TnzMk=
X-Google-Smtp-Source: APXvYqxRcxbavVFTsmUNETXjP/cmFZORdKUR3CJBGaUjux0QmH0oGUcARXgPe/sIw05eOKqxEyPfyw==
X-Received: by 2002:a63:ec13:: with SMTP id j19mr22864327pgh.369.1568055512279;
        Mon, 09 Sep 2019 11:58:32 -0700 (PDT)
Received: from dentonliu-ltm.internal.salesforce.com ([204.14.239.137])
        by smtp.gmail.com with ESMTPSA id 20sm18185028pfh.72.2019.09.09.11.58.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 09 Sep 2019 11:58:31 -0700 (PDT)
Date:   Mon, 9 Sep 2019 11:58:29 -0700
From:   Denton Liu <liu.denton@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: What's cooking in git.git (Sep 2019, #01; Sat, 7)
Message-ID: <20190909185829.GA88988@dentonliu-ltm.internal.salesforce.com>
References: <xmqqd0gcm2zm.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqd0gcm2zm.fsf@gitster-ct.c.googlers.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Sat, Sep 07, 2019 at 10:26:53AM -0700, Junio C Hamano wrote:
> * dl/complete-cherry-pick-revert-skip (2019-08-27) 3 commits
>  - status: mention --skip for revert and cherry-pick
>  - completion: add --skip for cherry-pick and revert
>  - completion: merge options for cherry-pick and revert
> 
>  The command line completion support (in contrib/) learned about the
>  "--skip" option of "git revert" and "git cherry-pick".
> 
>  Will merge to 'next'.

Did we end up deciding whether or not we were going to drop "status:
mention --skip for revert and cherry-pick"?

> 
> * dl/use-sq-from-test-lib (2019-09-06) 1 commit
>  - t: use common $SQ variable
> 
>  Code cleanup.
> 
>  Will merge to 'next'.

This needs a tiny update to its commit message: we should change 
`git grep =\\\\\'` to `git grep =\\\\\' t/`.

> * dl/format-patch-cover-letter-subject (2019-09-05) 1 commit
>  - format-patch: learn --infer-cover-subject option
>  (this branch uses dl/format-patch-doc-test-cleanup.)
> 
>  "git format-patch --cover-letter" learned to optionally use the
>  first paragraph (typically a single-liner) of branch.*.description
>  as the subject of the cover letter.
> 
>  Reroll with a redesign with less emphasis on "subject" coming?

Correct, I'll wait for the format-patch cleanup stuff to settle down
before sending the reroll in.

> * dl/remote-save-to-push (2018-12-11) 1 commit
>  - remote: add --save-to-push option to git remote set-url
> 
>  "git remote set-url" learned a new option that moves existing value
>  of the URL field to pushURL field of the remote before replacing
>  the URL field with a new value.
> 
>  Anybody who wants to champion this topic?
>  I am personally not yet quite convinced if this is worth pursuing.

Perhaps it's time to drop this topic?

Thanks,

Denton
