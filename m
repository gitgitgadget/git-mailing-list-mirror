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
	by dcvr.yhbt.net (Postfix) with ESMTP id 2FE951F4C0
	for <e@80x24.org>; Tue, 15 Oct 2019 18:48:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728965AbfJOSsT (ORCPT <rfc822;e@80x24.org>);
        Tue, 15 Oct 2019 14:48:19 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:44059 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728258AbfJOSsS (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Oct 2019 14:48:18 -0400
Received: by mail-wr1-f65.google.com with SMTP id z9so25109240wrl.11
        for <git@vger.kernel.org>; Tue, 15 Oct 2019 11:48:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:mime-version
         :content-transfer-encoding:fcc:to:cc;
        bh=E/MYZTeMbrot2G5/y1m7G/c0mnD/iFN7fhJLd/8LHOA=;
        b=DFAoPScTqbhq1pqYfFVGYdPkzcsnXl9+W/kUcKjSh1U/dN+oJUskvSBG8WoT4bUo99
         bI20OK+VpPDGUjZ4vGt/aNTDkwTLWZysmgfh9/zKA3q2YgAuJXlYRJ5gh3PsYPfl7Rn4
         /8zEb5tiTHovrlR3oNhwCfy04nFesMJ9/5fYOmNcw7mSQ5wcJMt6hEfBR14QcYzA+RL3
         jYt6eO8GjNgCU4MTXIeuyTQvCWaqFvq7jkp9nktevUqwP9AnnPfTNj5P4AW4w2vMe4Cm
         6lhLFGxSa8jfrXooMB4XDGXSon0lz4N4PkRdYD3Ir0/fcvdICzreJF+AMgYLJolKYwxR
         gUlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:mime-version:content-transfer-encoding:fcc:to:cc;
        bh=E/MYZTeMbrot2G5/y1m7G/c0mnD/iFN7fhJLd/8LHOA=;
        b=D830XNdz7l5Lv5GQKN5kA1zhZjvchMxBCdAZtDfdRxKIBgKzDAiVxuYkMC2+GIzd3L
         WV3k9lJLCTXNKtofTqgw5Cm92iDJJO0NW3iJvoUdTx08uMJUAfrHwORtjePZkV7HZk/h
         kB1Fk7SaPvp9EBfIb87bh/x5VvhPaqk/zImC+skPt/HC6c4swOITwQygn+LCvdZzGtHx
         4En3feArsO03S87whpS9kIPd1eLygrf0bf/YcCx+aZUV23hWcCOkv5QljDET86aHx8C/
         o060spdJCOXNKkzZP0v7ZDVsNAnigR69MAvNfNxWLTmfvZ78w8J6X6n1kjgmNqeNmjgo
         XrBw==
X-Gm-Message-State: APjAAAUH67d8Iuwh1RyM5FSsA5nJWuMgYx8cJEYbhMHhMGrkEPdMkeMp
        aUtUm2hGfVDOMfQbB1pQsb6bu7GQ
X-Google-Smtp-Source: APXvYqywU59Ah9HgIIiz7ElelR6HFIgzWUmx0nfsa1znkxgauBlx7ynQgSgzYPcg0vCA5j+n46oxJw==
X-Received: by 2002:adf:f50b:: with SMTP id q11mr2294770wro.310.1571165295499;
        Tue, 15 Oct 2019 11:48:15 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id g185sm150754wme.10.2019.10.15.11.48.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 15 Oct 2019 11:48:14 -0700 (PDT)
Message-Id: <pull.367.v3.git.1571165293.gitgitgadget@gmail.com>
In-Reply-To: <pull.367.v2.git.gitgitgadget@gmail.com>
References: <pull.367.v2.git.gitgitgadget@gmail.com>
From:   "Max Belsky via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 15 Oct 2019 18:48:12 +0000
Subject: [PATCH v3 0/1] doc: Add a note about ~/.zsh/_git file
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc:    Sent
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


base-commit: 108b97dc372828f0e72e56bbb40cae8e1e83ece6
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-367%2Fmbelsky%2Fpatch-1-v3
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-367/mbelsky/patch-1-v3
Pull-Request: https://github.com/gitgitgadget/git/pull/367

Range-diff vs v2:

 1:  3f994f3b9a ! 1:  7919addea8 doc: Change zsh git completion file name
     @@ -8,9 +8,10 @@
      
          There is a small update to clarify it.
      
     -    Signed-off-by: Maxim Belsky <public.belsky@gmail.com>
          Helped-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
          Helped-by: Junio C Hamano <gitster@pobox.com>
     +    Helped-by: SZEDER Gábor <szeder.dev@gmail.com>
     +    Signed-off-by: Maxim Belsky <public.belsky@gmail.com>
      
       diff --git a/contrib/completion/git-completion.zsh b/contrib/completion/git-completion.zsh
       --- a/contrib/completion/git-completion.zsh
     @@ -22,8 +23,8 @@
      -# The recommended way to install this script is to copy to '~/.zsh/_git', and
      -# then add the following to your ~/.zshrc file:
      +# The recommended way to install this script is to make a copy of it in
     -+# ~/.zsh/ directory as ~/.zsh/git-completion.zsh and then add the following
     -+# to your ~/.zshrc file:
     ++# '~/.zsh/' directory as '~/.zsh/_git' and then add the following to your
     ++# ~/.zshrc file:
       #
       #  fpath=(~/.zsh $fpath)
       

-- 
gitgitgadget
