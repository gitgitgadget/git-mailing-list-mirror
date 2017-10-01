Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AF16420A10
	for <e@80x24.org>; Sun,  1 Oct 2017 19:29:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751649AbdJAT3S (ORCPT <rfc822;e@80x24.org>);
        Sun, 1 Oct 2017 15:29:18 -0400
Received: from mail-ua0-f182.google.com ([209.85.217.182]:48942 "EHLO
        mail-ua0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751587AbdJAT3R (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 1 Oct 2017 15:29:17 -0400
Received: by mail-ua0-f182.google.com with SMTP id v12so2209403uaf.5
        for <git@vger.kernel.org>; Sun, 01 Oct 2017 12:29:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=atlassian-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=GfsC7TYiySgDZKT/ZxkSIyK1+9wGLII14lZjH72kjwk=;
        b=Blabu8dF9i7X2jAQiLHBaC+VH1PYTzC3s34aDxOpIRr5YLqj5DnkKG/zWXfw9oyIYf
         rylhqx5w3czGYZ/Aj4uvKvaOs6PK8KciCTsMRnMnsUBU5iVo0pHAlSHROrULqrfYymRA
         kA1LJGEy8dXKQA99N/mWRHRZ+wBOzLgnMPdM4Z178UvaLS/WBZOn1HAc4LrNXxj20oE3
         Jg+ypJuIQbn/aspnbJ53siBOqxiaMmcOz9374q1d3pQPf7cl7mA3duFDgfQu/XNqwzXY
         nuOPcxryHAu0UBRPklIKcDdpXWuMu2ckRic3EO9tYpMQ1QFhJ/AE4Gpa6UG0miYeSfHb
         UpxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=GfsC7TYiySgDZKT/ZxkSIyK1+9wGLII14lZjH72kjwk=;
        b=Yw1XKjqz/Biwo4q5JGSJJxE/knnf9hhAWtey5ZddmcGZ5oFx3ALJu53XsQAY//0/Ri
         TiOBOvUyT2/Amt3IhlBNqY+DRp3aCZs1QPf+lCgyE56WrFy65hInvCL17oQfhCUYCllq
         Zn8d0jyO3y+jN6J59BSfehtkghVVXddXOLvO+4X4ES/nFitW+QZH+nbFSFcxrZnFoG8I
         HfpsLmmREiCJoJhwaMqaiRDrPxALbIZQ9F4ZGCnEgGr4YinBcPJVoHc1hgiI5VNxgQf5
         YgsaJ0XGPXv/tCWhx9xdpVfg8uEsDVQQT0eRFMeFhruHJuNMWRIyE/CH54q8b0f+OVwu
         CTNA==
X-Gm-Message-State: AHPjjUhYLEqXmru0glIFb6X3Rnc6f89mfK6iIZl5YESC5hC2yPAvVQt/
        w/VAEfBfZ7xBYtZXwgKwzKvgGqMoSPvBXzc1MAh99WSq
X-Google-Smtp-Source: AOwi7QBXV3g2AvMP7xHetiYMUIpElvatbK0Y4zq3EQ4PCJkHNB/URazILpdICLr1WkLvdAuiTvC1Tpohqx+QHsryWdY=
X-Received: by 10.159.37.201 with SMTP id 67mr7768009uaf.59.1506886156535;
 Sun, 01 Oct 2017 12:29:16 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.176.7.211 with HTTP; Sun, 1 Oct 2017 12:29:16 -0700 (PDT)
In-Reply-To: <alpine.LFD.2.21.1710011349560.23227@localhost.localdomain>
References: <alpine.LFD.2.21.1710011349560.23227@localhost.localdomain>
From:   Bryan Turner <bturner@atlassian.com>
Date:   Sun, 1 Oct 2017 12:29:16 -0700
Message-ID: <CAGyf7-H+1Djb_dmzfOO3qqM9+2VKvbqVedn4mof9Hq4huDTsqw@mail.gmail.com>
Subject: Re: what is git's position on "classic" mac <CR>-only end of lines?
To:     "Robert P. J. Day" <rpjday@crashcourse.ca>
Cc:     Git Mailing list <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Oct 1, 2017 at 10:52 AM, Robert P. J. Day <rpjday@crashcourse.ca> wrote:
>
>   sorry for more pedantic nitpickery, but i'm trying to write a
> section on how to properly process mixtures of EOLs in git, and when i
> read "man git-config", everything seems to refer to Mac OS X and macOS
> (and linux, of course) using <LF> for EOL, with very little mention of
> what one does if faced with "classic" mac EOL of just <CR>.

 No command in Git that I'm aware of considers a standalone <CR> to be
a line ending. A file containing only <CR>s is treated as a single
line by every Git command I've used. I'm not sure whether that
behavior is configurable. For files with standalone <CR>s mixed with
other line endings (<CRLF> or <LF>, either or both), the <CRLF> and
<LF> endings are both considered line endings while the standalone
<CR>s are not.

That's just based on my experience with them, though. In general, `git
blame` and `git diff`, for example, don't seem honor them. Perhaps
someone else knows of some useful knows of which I'm not aware.

Best regards,
Bryan Turner
