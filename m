Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C9F121F461
	for <e@80x24.org>; Sun, 18 Aug 2019 19:01:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726952AbfHRTBP (ORCPT <rfc822;e@80x24.org>);
        Sun, 18 Aug 2019 15:01:15 -0400
Received: from mail-wm1-f49.google.com ([209.85.128.49]:35355 "EHLO
        mail-wm1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726926AbfHRTBP (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 18 Aug 2019 15:01:15 -0400
Received: by mail-wm1-f49.google.com with SMTP id l2so1137867wmg.0
        for <git@vger.kernel.org>; Sun, 18 Aug 2019 12:01:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=YiHoG0XxHqRbe9Q6FGvIcH04lICLQGzqkdeaTAV8JTk=;
        b=A1jMGM+v46yb/JHM1Bi+GXIsaWqyz0ffYSaLloiu7V5AK5DuxQiK+L666t/4XLzGYU
         kXoykuIc0FxGeaD8e8pXaftBHg9soZZBJX5W9Vn2Yj0hUR35cikZPcTR3LNfW6WrBS08
         mpfHzXP0GqR/Gp+0YjYZJ1TeDnjdgiAJPaANidZxbc9KxPww8ISq21BjpdcY3JtqIXyj
         SIjH18BG3zlJeFFTkVLsAxiSR4GgvNPFuH7vhV0BI3Ph/PpEBZY6yegSbDhwCuCT740x
         zjRCuK5ZdcBpq22Fr4xkLjEs8zfdOeW0Gbxhwgztn2Ca3d5Phcnc9HcTlKjlkAhNySAw
         odOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=YiHoG0XxHqRbe9Q6FGvIcH04lICLQGzqkdeaTAV8JTk=;
        b=QJP8ELzaV0TKMJCju8NeTRB/rw4NZFkZ4xhfifcJoNQaB21bk3EOVBB3uFL49lwQY5
         EdPAeyB/IM8yqL93gZc2NzDj17j+H05zFPLBDm+nCtazy7lRECvTiYpXvK6H+kK3bqN9
         3tDqYGVALfkosJq4j/m/Qviv5qts7kbxVbaCH9mFknW7yW28v6ZlwC1HaSSSp44KiL8c
         WQ5DfDPz2DkseTvb+xsJztEfPzwjmHcTUzfdoS7xDCqqNcuaeg9PYbV6whgXGfxN5Aoo
         KwBybs5SnRICQoTHcF0vY0jueqFSjg9uO5pzv/1RlOSgvCznbl9ezNcRcIQroYQOZPyK
         k7Eg==
X-Gm-Message-State: APjAAAXYbBpEf89bF1RmdX0QCDJ7C6KZH04+VAdiiYayH6rt8zr1oCvr
        qeNzHxohLf3tx425pYWprCM=
X-Google-Smtp-Source: APXvYqwaug1g4cBtApqNtuyCGQzogULMv/YTz39zdh0nsGXbWrdjIMXSXgnC3EZ+49Atc7mE4rX+yw==
X-Received: by 2002:a7b:cbcf:: with SMTP id n15mr17024832wmi.48.1566154873543;
        Sun, 18 Aug 2019 12:01:13 -0700 (PDT)
Received: from rigel (167.207.63.94.rev.vodafone.pt. [94.63.207.167])
        by smtp.gmail.com with ESMTPSA id 2sm12890700wrg.83.2019.08.18.12.01.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Aug 2019 12:01:12 -0700 (PDT)
Date:   Sun, 18 Aug 2019 20:00:32 +0100
From:   Rafael =?utf-8?B?QXNjZW5zw6Nv?= <rafa.almas@gmail.com>
To:     Uwe Brauer <oub@mat.ucm.es>
Cc:     git@vger.kernel.org, Alban Gruin <alban.gruin@gmail.com>
Subject: Re: git log --graph with a sort of local revision number
Message-ID: <20190818190032.GA11185@rigel>
References: <87blwq7rn5.fsf@mat.ucm.es>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87blwq7rn5.fsf@mat.ucm.es>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

You can achieve something close (on small repos, more on that later) with:

$ git log --graph --color \
  --format='%C(auto)changeset: %h:%H%nuser:      %an%ndate:      %ad%nsummary:   %s%n' \
  | git name-rev --refs=$(git rev-parse --abbrev-ref HEAD) --name-only --stdin


    * changeset: 5fa0f52:master
    | user:      Junio C Hamano
    | date:      Fri Aug 16 10:28:23 2019 -0700
    | summary:   Git 2.23
    |
    *   changeset: 8e0fa0e:master~1
    |\  user:      Junio C Hamano
    | | date:      Fri Aug 16 10:22:51 2019 -0700
    | | summary:   Merge tag 'l10n-2.23.0-rnd2' of git://github.com/git-l10n/git-po
    | | 
    | * changeset: a6cd2cc:master~1^2
    | | user:      Jiang Xin
    | | date:      Tue Jul 30 10:02:22 2019 +0800
    | | summary:   l10n: zh_CN: for git v2.23.0 l10n round 1~2

And in this case, since we are using HEAD to describe the commits by
using --refs=$(git rev-parse --abbrev-ref HEAD), you can refer to
a6cd2cc either as master~1^2 or HEAD~1^2.

Now, git-name-rev has some memory/performance problems in repos with a
high number of references. Alban Gruin was working on this issue[1], but
I don't know what's the status of it.

[1]:https://github.com/agrn/git/tree/ag/fix-name-rev-leak
