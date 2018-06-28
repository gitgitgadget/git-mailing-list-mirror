Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0E50C1F516
	for <e@80x24.org>; Thu, 28 Jun 2018 09:18:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935054AbeF1JSD (ORCPT <rfc822;e@80x24.org>);
        Thu, 28 Jun 2018 05:18:03 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:33944 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935046AbeF1JSC (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 28 Jun 2018 05:18:02 -0400
Received: by mail-wm0-f67.google.com with SMTP id l15-v6so20172633wmc.1
        for <git@vger.kernel.org>; Thu, 28 Jun 2018 02:18:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=iHr+cw+RcCtYkY8FZdGBxQ6oMxiN9rYUN+pef/QEk70=;
        b=RZUJvnoTgPRTaPpaooA3ZG3yNSbSCLUyE7FN9IeIP5MC7oT8hZlm/WLG4OrVl6rfkD
         EzOgkLp0s1VfKTW9nwLT+dAIaMu+0lKoTO+tmrnyAVIIKMK67SOCu+D+2DOmTYKHlUX+
         zBMKjNykwfoqeDWGzMIGrzeMAIbyPo7coa01KogDGRN5MzsooyBbI/pP3nnCgHmcu8z2
         CuM6RUljPp2iZ5pkVeZqg2cz/15J3cFbrUjVVbGIeaX+ATpSlTFMzUL07gV9U0vkFGem
         TWuceBzKRPbV990sRdF9b71dAwktBJYVif8TP0G+MBEXPEV+HbOis25EUqt5BL40mHam
         omLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=iHr+cw+RcCtYkY8FZdGBxQ6oMxiN9rYUN+pef/QEk70=;
        b=qYd/B8jVkGVv8e3fq22oWG4Ucr+PrLP4BPoUxym4zqBNnVIiW/sngTXNkDi8dFWbPt
         4w7nccjOhBlwpXmxHl4ISzthu+DJt1YDTUpGN4nYdP/0el3ETCpWGAa8GsmgkdIsyCy3
         Ku0V9Gocw+nc5HnSMe4EE2lOxe8iB7LMfI/Wb8kl7wh8PGKjYttL/UhvV3LTOADht9v7
         oWRBWM4np7y4cebpdryrUP26PS4XxR+Izq86Ua2JLwHQm95Lep98VRlyL9KzyG5S79tO
         Jji8z6kMKdv45E164u3rAvzt8W/BP9SImkC373exwIH4TH5/0BtAyfjPZVuQBX5SAmZ6
         t2Sg==
X-Gm-Message-State: APt69E3RPefw8jjkraxuhXQirm8MnbFMHG4fc01Ov7aW1lDhHVbeQTGt
        3d6VqHU5MrnNjqVzJAmfNVJVMwyj0Kr3OsBYELqQb3sFuVk=
X-Google-Smtp-Source: AAOMgpdMCoy6/mhuY318WMairwy6vvydT6gMqD58Z8JVzb4+hTa23muwEEvQ6+wUPZG5SbBWmWE/IKKzfA6B0Jct8Cc=
X-Received: by 2002:a1c:204c:: with SMTP id g73-v6mr1603013wmg.4.1530177480842;
 Thu, 28 Jun 2018 02:18:00 -0700 (PDT)
MIME-Version: 1.0
References: <20180628074655.5756-1-predatoramigo@gmail.com> <20180628074655.5756-2-predatoramigo@gmail.com>
In-Reply-To: <20180628074655.5756-2-predatoramigo@gmail.com>
From:   Pratik Karki <predatoramigo@gmail.com>
Date:   Thu, 28 Jun 2018 15:02:49 +0545
Message-ID: <CAOZc8M8u4RPsqRfy1nuuWgjPSAhjbO5ZTtZbR6HY1n3fH5-Q6g@mail.gmail.com>
Subject: Re: [PATCH 1/5] Start TODO-rebase.sh
To:     git <git@vger.kernel.org>
Cc:     Christian Couder <christian.couder@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Stefan Beller <sbeller@google.com>,
        Alban Gruin <alban.gruin@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

This is a patch I keep in wip-rebase branch[1][2].
It shouldn't be applied to `pu`.

This main objective of this file in the branch is to keep track of
the converted shell scripts of `git-rebase.sh` and plan on the
conversion of other remaining parts.

[1]: https://github.com/prertik/git/tree/wip-rebase
[2]: https://github.com/git/git/pull/505

Thanks,
Pratik
