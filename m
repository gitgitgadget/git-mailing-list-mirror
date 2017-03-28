Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6FF0F1FAFB
	for <e@80x24.org>; Tue, 28 Mar 2017 18:11:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754438AbdC1SLX (ORCPT <rfc822;e@80x24.org>);
        Tue, 28 Mar 2017 14:11:23 -0400
Received: from mail-pg0-f51.google.com ([74.125.83.51]:35965 "EHLO
        mail-pg0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753027AbdC1SLW (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Mar 2017 14:11:22 -0400
Received: by mail-pg0-f51.google.com with SMTP id g2so79218424pge.3
        for <git@vger.kernel.org>; Tue, 28 Mar 2017 11:11:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to;
        bh=Yl1oyCIJkjCZ5acrlkdQSULJfVPlD/I/tLreHJtYdaY=;
        b=YSWbCbPtN0ftQXOIjAAIOFvSbz4gPEOE2EgczK1Hc224GwRkUe4usivhpBrAirxWXS
         zKr/yqb2L97VDQVgjIIXyGqesky8khr4kbfCeDr1Y1Pj461l1Dus4FaHwXO8gwPx36Nb
         HsJ2/ctNSIYVg/DUbHZs9o8aHp3lEsSY91Hub6wodptgehuv98aMK0Go7leamMgTDEA8
         NXEq2O7iuZ339d+7hM6wDsyBWxQ55ilX+6l5q8tsQ3AHuI6VUXGCpdn7KqYptTo9Bjpi
         /H2DmX0yPPNDsXoewEOv5a7GZxF7c8gZq+6NP98TtXWvRxkODfj7+bYTvEUH7vcbe1tn
         uMZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to;
        bh=Yl1oyCIJkjCZ5acrlkdQSULJfVPlD/I/tLreHJtYdaY=;
        b=GQpMQFibWIR8P14N6b34CCtrONb7V+HWDXfJQsapm45nscaeDqjrltq7DlgGhkijuK
         eXVoA/9FjruD/JvkTX1kBwVF+HkLPvWyZfUQQcd/oywvVg/TE0B8uiQt92V7txfWY7ZZ
         xlt9oLn9DlQl6N2KDjmNL+b8AnOZ6kPAO0fFV+X1stwTdIBLOoAU5rX6KfApABXys2wh
         ORRn/TxNkKaQ4ist5KxhE/ncT6JNVwA3YwuNTet73gV1SrYgbid7RqKts5HtZ75XVaCz
         SvAClrptu0QA68mZq7pkRoYPABgn8OsJZE5MqUuG1mPTqpJclgkPiwFu7SJwcwUcdolg
         BgQw==
X-Gm-Message-State: AFeK/H3cf1Owy32zMsRvbhyTnxeheHe3DEomRbY7hlOABh+0wKjwwTldZP+rRWLQgciP2S4ouZ6GpIHOL+9/6P8Y
X-Received: by 10.99.247.69 with SMTP id f5mr32206992pgk.63.1490724676338;
 Tue, 28 Mar 2017 11:11:16 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.100.186.196 with HTTP; Tue, 28 Mar 2017 11:11:15 -0700 (PDT)
In-Reply-To: <20170328104652.XsS8a6ysu%pickfire@riseup.net>
References: <20170328104652.XsS8a6ysu%pickfire@riseup.net>
From:   Stefan Beller <sbeller@google.com>
Date:   Tue, 28 Mar 2017 11:11:15 -0700
Message-ID: <CAGZ79kaLB3w1dkr-_+zTPTJ8Zs2POOVFcnuJ_CDT6sJi1TxMHg@mail.gmail.com>
Subject: Re: Microproject | Add more builtin patterns for userdiff
To:     git <git@vger.kernel.org>, Ivan Tham <pickfire@riseup.net>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Mar 28, 2017 at 3:46 AM, Pickfire <pickfire@riseup.net> wrote:

>     EOF
>
>     echo '* diff="cpp"' > .gitmodules

Did you mean .gitattributes?
