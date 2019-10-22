Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-9.1 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7875F1F4C0
	for <e@80x24.org>; Tue, 22 Oct 2019 21:05:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732360AbfJVVFE (ORCPT <rfc822;e@80x24.org>);
        Tue, 22 Oct 2019 17:05:04 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:33332 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725874AbfJVVFE (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Oct 2019 17:05:04 -0400
Received: by mail-pg1-f195.google.com with SMTP id u23so8667pgo.0
        for <git@vger.kernel.org>; Tue, 22 Oct 2019 14:05:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Cw0WBu18s+GIN4haQtiFtpQd2zZmJDCofc5x0cJ/Wv4=;
        b=aAdGnaC4eSaZo7CCliCT34glUTWlpOAItinrYg1Ntzhlw/FCnyRR+NlwwSvjJb7Ekt
         pKbCpJVq999cifN7IDzz50xs677Gd2xQFo7jUUTzzaxhefySuJf20J38F1hNokSVK0lm
         +j7yT6Ohs84gRUsC2EwFePN9VO7+dIdlwXIjTDYoRAGB3rNNhhqAvxbdKes8cCxcxCi2
         K4XdJvFBFfNuihF7ekgqmBB16ne6emeLt57Bo2sPzE/fMoEyAFahkce9Px4iU/Yd10Aa
         a6WItVVQUpZ+wNkKxIvDXdrljiA/n3xFBdeLS3andTmqlTpLoPZCYHV5Ul9jwvfscyG1
         dJuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Cw0WBu18s+GIN4haQtiFtpQd2zZmJDCofc5x0cJ/Wv4=;
        b=cZDB3sR2ZD1kzSBRMMFPQQx4Nn46b/BiHEyixtoz0MMXguOA7XIHux9b2cUOUfrfhC
         trQcd07VFVCVsPtIsJefLeUGzRFhmyUiAZGl4/APFDK293FIanCgpUZ1Zi8WTGxOQ2Qi
         41xEHz+/qYOsXL2h+qcKEhEWgoh1jZXV/orMxvZx0YJb735Ey71sItdBZ2Uw3+nYMk8U
         gEpVAcFxIM3wTTDxPvrJGczCd3gjtelrpgtTp/Ru6nOVyNDhy7r/VI2wnxdahsNirhtw
         flFvcqyAI+nrNHxl0y1GkHqrKMjznnGJZZSCxTrinAtZzwQHOnkut8hXUM3aSUy6/U6d
         ZLng==
X-Gm-Message-State: APjAAAU242EvQa/S7Hq9iFUcYWYZxPDqkTZlMre2SUvqsuuy9MRJaMWG
        d+ffLgp91BDESmBy47b9qFtyJw==
X-Google-Smtp-Source: APXvYqzQ31FvQYXIENP7CFVCndevVnPos30ev8H4rKthBV75mVtEjvGrcEYsIUGx/Nl7bkanI4QW5Q==
X-Received: by 2002:a17:90a:17ad:: with SMTP id q42mr7298096pja.100.1571778303267;
        Tue, 22 Oct 2019 14:05:03 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:0:231c:11cc:aa0a:6dc5])
        by smtp.gmail.com with ESMTPSA id b24sm4402513pfo.4.2019.10.22.14.05.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Oct 2019 14:05:02 -0700 (PDT)
Date:   Tue, 22 Oct 2019 14:04:58 -0700
From:   Emily Shaffer <emilyshaffer@google.com>
To:     Heba Waly via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Heba Waly <heba.waly@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/1] documentation: remove empty doc files
Message-ID: <20191022210458.GE9323@google.com>
References: <pull.412.git.1571768375.gitgitgadget@gmail.com>
 <ffdde613d8ea2dc57719594aa0f89b6d6177b636.1571768375.git.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ffdde613d8ea2dc57719594aa0f89b6d6177b636.1571768375.git.gitgitgadget@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Oct 22, 2019 at 06:19:35PM +0000, Heba Waly via GitGitGadget wrote:
> From: Heba Waly <heba.waly@gmail.com>
> 
> Remove empty and redundant documentation files from the
> Documentation/technical/ directory.
> 
> As part of moving the documentation from Documentation/technical/api-* to
> header files, the following files are deleted because they include only
> TODO messages with no documentation to be moved:
> Documentation/technical/api-grep.txt
> Documentation/technical/api-object-access.txt
> Documentation/technical/api-quote.txt
> Documentation/technical/api-xdiff-interface.txt

Same thing as I mentioned in your other review; what you've added to
your commit message now doesn't say anything you didn't say with the
diff. I can see that you removed empty documentation files; I can see
that those files include only TODO.

Maybe you can explain why it's a bad developer experience to stumble
across these, and that those files sat untouched for years in the
TODO(contributor-name) state.

> 
> Signed-off-by: Heba Waly <heba.waly@gmail.com>
> ---
>  Documentation/technical/api-grep.txt            |  8 --------
>  Documentation/technical/api-object-access.txt   | 15 ---------------
>  Documentation/technical/api-quote.txt           | 10 ----------
>  Documentation/technical/api-xdiff-interface.txt |  7 -------
>  4 files changed, 40 deletions(-)
>  delete mode 100644 Documentation/technical/api-grep.txt
>  delete mode 100644 Documentation/technical/api-object-access.txt
>  delete mode 100644 Documentation/technical/api-quote.txt
>  delete mode 100644 Documentation/technical/api-xdiff-interface.txt

As for the content of this change, I absolutely approve. I've stumbled
across some of these empty docs while looking for answers before and
found it really demoralizing - the community is so interested in
teaching me how to contribute that they've sat on a TODO for 12 years?
:( I even held up api-grep.txt as a (bad) example in a talk I gave this
year. I'm happy to see these files go.

 - Emily
