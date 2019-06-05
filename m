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
	by dcvr.yhbt.net (Postfix) with ESMTP id E86521F462
	for <e@80x24.org>; Wed,  5 Jun 2019 15:06:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728471AbfFEPGI (ORCPT <rfc822;e@80x24.org>);
        Wed, 5 Jun 2019 11:06:08 -0400
Received: from mail-ed1-f50.google.com ([209.85.208.50]:34732 "EHLO
        mail-ed1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726442AbfFEPGI (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Jun 2019 11:06:08 -0400
Received: by mail-ed1-f50.google.com with SMTP id c26so6309785edt.1
        for <git@vger.kernel.org>; Wed, 05 Jun 2019 08:06:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:from:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=2UTPE/AdRsSJMAgXNqfFaqeTEYB9pQF/yivsGVUC8Eg=;
        b=aRq5NIdVaDXhKWQSsj35fPAeC8x/MCRMnvYsVhLczDuKi3WZOHPDVRrYC1vXG0A4Il
         9h7UY6lJhmTvSzw//+ia4f2eRCVTOMkxIYKmr8FSrgaYh2zcdwY05vVwx22Mc8NU2ds0
         //hg1uOdoeiDa/jhgSlFHOlEMgxmgSMsYI4jPAYa9cJmTi+7Z4dxiRa88gLA7gqkiKT+
         3YFOLVAcUcNT1Ja3YJr+H3j6LkH+wRIIEKBA7DCTzWIOQsHQOXNqD6+6V6PfbP/B3vIz
         kTHqVIOx3v3Ixvds2BREXV6V9RGlR+5UE9294y5xMQFl7IPXopZpUUCg8uwUp8FVuwqr
         f3CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=2UTPE/AdRsSJMAgXNqfFaqeTEYB9pQF/yivsGVUC8Eg=;
        b=KddOFRHR1yagGId3tiE7p5ZYvlMw5V6kHxLEEul1oUlcSSdzog7m3Q9yqcQ17XqF5S
         0n8bDgVz+1ei3eyR+bwRPfnCHzDFpgKR45vlIWhkN1zwanmQm4AqZ240lZxG8tvZbT2V
         N8JDHHnikB3RqFRmFtGdThJNlojawxdB2OxgHJX6ntBISs+D5nTxOZOQ25nt57hzUxjX
         Cw2bUzrJbIqKnmHiPwlTSucCKENIQr8RHeWHVFSBl7fmgoIzO9k8K3bIoOr/Vto39ZBT
         spT2HX9Zrn/KOBQAZg4XoTYqkU/AYDzlgMIj6fisucpe1MC5fwrzLYaLdjo+d+UoY5f7
         qJPQ==
X-Gm-Message-State: APjAAAVi1DYnjhRd0SDcixnarU/faD+syqeR8rsW4iHQ8e99oM6Za9Mt
        lzDvxBre4zKQFaIUqRjWVQojez89
X-Google-Smtp-Source: APXvYqxEbiPKGByysSZe9rDSYkaEvdYcPxpai4Yrsfq6qdYfK7OxsdXfRAphpUXWYyqB+yszw+ADIQ==
X-Received: by 2002:a50:b7bc:: with SMTP id h57mr44081676ede.77.1559747166793;
        Wed, 05 Jun 2019 08:06:06 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id c16sm1746090edc.58.2019.06.05.08.06.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 05 Jun 2019 08:06:06 -0700 (PDT)
Date:   Wed, 05 Jun 2019 08:06:06 -0700 (PDT)
X-Google-Original-Date: Wed, 05 Jun 2019 15:06:03 GMT
Message-Id: <pull.255.git.gitgitgadget@gmail.com>
From:   "Edward D'Souza via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH 0/1] Improve instructions around how to set git-prompt preference variables.
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When I first tried to use the git-prompt.sh script, I followed the
instructions at the top of the file and everything worked, except for the
"GIT_PS1_SHOWDIRTYSTATE" preference. Even though I had it set to true, I
wasn't seeing the "()" and "(+)" in my shell prompt. After a few hours of
poking around, I finally discovered what I had done wrong: I was setting the
variable *after the "source ~/.git-prompt.sh" line, and it has to be set 
before.

I moved the lines around my .bashrc script and got everything working, but I
thought the instructions could be a bit more explicit about how to set these
preference variables, especially because this is a silent failure situation;
the preference doesn't work if you get the order wrong and there are no
warnings or errors to guide you.

This patch started as a PR on the official Github project two years ago (
https://github.com/git/git/pull/425), back when I didn't know the official
process for submitting patches. Luckily, a kind user (@dscho) saw it and
pointed me in the right direction to get it submitted.

This will be my first time submitting a patch, so hopefully I've figured out
the process.

Edward D'Souza (1):
  git-prompt.sh: update shell variable instructions.

 contrib/completion/git-prompt.sh | 5 +++++
 1 file changed, 5 insertions(+)


base-commit: cb5918aa0d50f50e83787f65c2ddc3dcb10159fe
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-255%2Fghedsouza%2Fpatch-1-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-255/ghedsouza/patch-1-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/255
-- 
gitgitgadget
