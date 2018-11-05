Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 21DE61F454
	for <e@80x24.org>; Mon,  5 Nov 2018 01:25:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726444AbeKEKmR (ORCPT <rfc822;e@80x24.org>);
        Mon, 5 Nov 2018 05:42:17 -0500
Received: from mail-wr1-f50.google.com ([209.85.221.50]:41979 "EHLO
        mail-wr1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726368AbeKEKmR (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Nov 2018 05:42:17 -0500
Received: by mail-wr1-f50.google.com with SMTP id x12-v6so7630567wrw.8
        for <git@vger.kernel.org>; Sun, 04 Nov 2018 17:25:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=fjmmHnBdPrZ3g6npQpPsl2eiyp78sK9YA9YO31NSX3M=;
        b=K+fnkUzzsrBY1WTZJ8KD5bDP4vyQVJI9Cb4XbnkeaJQtFDKF47Jz3GKF7lD3Y786Xo
         uFnTxXrVDBSDAjuC4L6y0E68GoArLyE5fgQQL5/f6by2uyAdt1s0ozzbJ9V80fbt058C
         O6aAOmwW+zPhxONL4WJredpEXa7azPHDPFejAP8wS3HIcLLg4CD8MS4xDnUPNQm/TFcc
         0r5wgg7b+fwH0Whwy/1vGWMSO7aWebQORDnZFtjOhprYpgtYg53T29DeKcsRz7EjJCzg
         UvyEwBZimVyWUoosyawUag8oo58yaA7Kx3PaELhWuXAh0gWK3/avRobYTa1lfZntCgB9
         R39A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=fjmmHnBdPrZ3g6npQpPsl2eiyp78sK9YA9YO31NSX3M=;
        b=oEbsV7dLXwnI3bCe36V9i4ousMue5CuuTOyHP35Z/Njz268AJwFeZdMN/53tq9T9V2
         /EXDhumYYQAb1e1TrBQ4oWh5rv+PIKkf2ShZTXLUeOS2YWJG6uymITzVxIqC0jcv+L65
         lzwMqBIwLI8J6NyM5XSik8cW0XeiBdB3XAA5Wypjh4uUMnEA4JOoRBPvE1CcfZWuxoa+
         /B1izCS6Q9k7/QcpZYMhsnkShm/+lArj7eSMotosqKho46UvXf0TDjKf6XY90AHSIOSQ
         HZbq6n+w30jq85P36gvjCqxjR+7m7z8ki6lrHpv43NzfnbFsOGm8lHIn8RVNrvJxjaQ8
         GfSA==
X-Gm-Message-State: AGRZ1gLln4e1IeKf3WYBGrjhBXD+YpQveKG0uHVsitpAFLvB8kdueFNr
        o+IvZbhIhsniP+/UPfLKCio=
X-Google-Smtp-Source: AJdET5fbe/dM+xvo/9uMaW51NXVnLZO4DckPA2yOhwGJL3wLccY7nkuo3cCCFn7MkXd7Nl56dUiiVg==
X-Received: by 2002:a5d:498f:: with SMTP id r15-v6mr2347637wrq.317.1541381110260;
        Sun, 04 Nov 2018 17:25:10 -0800 (PST)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id e5-v6sm27134932wru.88.2018.11.04.17.25.09
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 04 Nov 2018 17:25:09 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] sequencer.c: remove a stray semicolon
References: <20181103143229.8829-1-pclouds@gmail.com>
Date:   Mon, 05 Nov 2018 10:25:08 +0900
In-Reply-To: <20181103143229.8829-1-pclouds@gmail.com> (=?utf-8?B?Ik5ndXk=?=
 =?utf-8?B?4buFbiBUaMOhaSBOZ+G7jWM=?=
        Duy"'s message of "Sat, 3 Nov 2018 15:32:29 +0100")
Message-ID: <xmqq7ehsl3ij.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Nguyễn Thái Ngọc Duy  <pclouds@gmail.com> writes:

> Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
> ---
>  On top of ag/rebase-i-in-c

Thanks.
