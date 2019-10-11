Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E69B31F4C0
	for <e@80x24.org>; Fri, 11 Oct 2019 17:54:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728713AbfJKRyb (ORCPT <rfc822;e@80x24.org>);
        Fri, 11 Oct 2019 13:54:31 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:40790 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728470AbfJKRya (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 Oct 2019 13:54:30 -0400
Received: by mail-wm1-f65.google.com with SMTP id b24so11022765wmj.5
        for <git@vger.kernel.org>; Fri, 11 Oct 2019 10:54:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=7iXaPCZrjswMs/XzOOMmQfiyMR9iiYOTzaPd+QtvjsE=;
        b=rYi4UTd16ltq5dCFTnfHp2Kq7PHhxMxD3tn0RpMsZUIhtQmo2aesn7aI81+87CzJZj
         Cjv6jk1GiLWQ2IV6Q8kRmNx3Aul2MuuptKQKEAEgMTaYE7IHuI5Mh7Og9fzeuNMds5Hk
         1w/C4fhS7UxE56hOzApoQD6clph7M/Rftmh+bL5o5ZqyT0iLS94zf7XtbPjniAQlL3C4
         aMeqs9TiEMxwRj8+6ar+5ZpJjgbt3b5SNclDjp27b/7ZiQ08/RkaY+48/R9VtD1eS2Em
         q9QKrsJDCiwV6sFn0O48kRNXj+xC7V5gv0l6XoLJstknPRye/zPE7yYMxMqricZvRl++
         H99g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=7iXaPCZrjswMs/XzOOMmQfiyMR9iiYOTzaPd+QtvjsE=;
        b=pKgwYJVB3yC2Nst67da7ZhbJzOIqgtC+Nt4uEn9kqVZiPFDcc0MMv+QBQ9WzH683f+
         y+9GTgri3M3aZMgUkKlom2cNbzUUn7p9u8KHLwp/LaX2YNm05NlbLkKNR7lrtIjxCjA6
         RIx5UfNpDye0XIf4q9oVbhahwYzpkQM7Oyna335NF8IiTOuIE+RfG8688DPGIbwZR8jw
         2uWJF5gVMLZTYYgfuC8FfeE55gKEoURExmHtJI0Nh9SUD6WGsfPEwGNgBCXSehHZI2Ug
         hRHpxaSGfVGYSRPMAN0jwC6kRqMqU+B4RlHzBQM98tE5seZMCh5tkWDKokWnmmPKYnh6
         5COQ==
X-Gm-Message-State: APjAAAXhJBKOlkg2EYMhqeb6RzROLtJpM6wocgJ/gxt8mUbfdoAosAG2
        i+toXRv1NUvB70LH39ynTvyBAGft
X-Google-Smtp-Source: APXvYqyWeLbuTKMSG2ehbB7ThfinO+qH0ylw4P0mrdeRGFYJGaRRK97xQcEQIZJMn9RpwOWFkNRtfQ==
X-Received: by 2002:a05:600c:2201:: with SMTP id z1mr4306957wml.169.1570816468363;
        Fri, 11 Oct 2019 10:54:28 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id j11sm11990741wrw.86.2019.10.11.10.54.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 11 Oct 2019 10:54:27 -0700 (PDT)
Date:   Fri, 11 Oct 2019 10:54:27 -0700 (PDT)
X-Google-Original-Date: Fri, 11 Oct 2019 17:54:26 GMT
Message-Id: <pull.367.v2.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.367.git.gitgitgadget@gmail.com>
References: <pull.367.git.gitgitgadget@gmail.com>
From:   "Max Belsky via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v2 0/1] doc: Add a note about ~/.zsh/_git file
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Max Belsky <public.belsky@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hey,

Today I've spent a few hours to understand why git-completion doesn't work
in my zsh shell. It was because I thought ~/.zsh/_git should be a dictionary
with git-completion.zsh file. 

I think this change may save some hours for someone else.

Maxim Belsky (1):
  doc: Change zsh git completion file name

 contrib/completion/git-completion.zsh | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)


base-commit: 4c86140027f4a0d2caaa3ab4bd8bfc5ce3c11c8a
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-367%2Fmbelsky%2Fpatch-1-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-367/mbelsky/patch-1-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/367

Range-diff vs v1:

 1:  ae00e1e393 ! 1:  3f994f3b9a doc: Change zsh git completion file name
     @@ -2,7 +2,15 @@
      
          doc: Change zsh git completion file name
      
     +    The original comment does not describe type of ~/.zsh/_git explicitly
     +    and zsh does not warn or fail if a user create it as a dictionary.
     +    So unexperienced users could be misled by the original comment.
     +
     +    There is a small update to clarify it.
     +
          Signed-off-by: Maxim Belsky <public.belsky@gmail.com>
     +    Helped-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
     +    Helped-by: Junio C Hamano <gitster@pobox.com>
      
       diff --git a/contrib/completion/git-completion.zsh b/contrib/completion/git-completion.zsh
       --- a/contrib/completion/git-completion.zsh
     @@ -13,9 +21,9 @@
       #
      -# The recommended way to install this script is to copy to '~/.zsh/_git', and
      -# then add the following to your ~/.zshrc file:
     -+# The recommended way to install this script is to copy to
     -+# '~/.zsh/.git-completion.zsh', and then add the following to your ~/.zshrc
     -+# file:
     ++# The recommended way to install this script is to make a copy of it in
     ++# ~/.zsh/ directory as ~/.zsh/git-completion.zsh and then add the following
     ++# to your ~/.zshrc file:
       #
       #  fpath=(~/.zsh $fpath)
       

-- 
gitgitgadget
