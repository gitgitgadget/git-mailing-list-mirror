Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B0BBA1F407
	for <e@80x24.org>; Fri, 15 Dec 2017 19:23:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756036AbdLOTXT (ORCPT <rfc822;e@80x24.org>);
        Fri, 15 Dec 2017 14:23:19 -0500
Received: from mail-ua0-f172.google.com ([209.85.217.172]:42142 "EHLO
        mail-ua0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755725AbdLOTXS (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 15 Dec 2017 14:23:18 -0500
Received: by mail-ua0-f172.google.com with SMTP id p33so6904410uag.9
        for <git@vger.kernel.org>; Fri, 15 Dec 2017 11:23:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=atlassian-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=QPzy3NAg0uS0gyv4nAUqVD8Tj8hGjKDNmg1qc+H7q/E=;
        b=rAVau3BKIw1eQudHXvZ/4ZrqUBsR9HlH8X+M16G02qHYREA1ZvEcxRgXNK5nxkrdbn
         DJ58IVRqfyNcRGohocPEmhhSTap6OET6LhuRwQp0RpCOfnxu83PdIPEypbf9/xzI5Ehh
         p/XVOoKDXfLosnNT4o0B4WkBGoy1HCynchW9YbvIP69y3WYgBlES8cBO01tHRszzAACL
         rgr0ArfJFamsjGmsc/0BjRIapYGCt5JRJXxAu6wX21INVWdzcPkDQ/HiXnLZQGxgWgsO
         lLomBsMixbun8V3yLGfprsffcEOYE5Qh6+AWL8mdil9dxO1Gmmaa8oIWqDiYHLHm0Cqv
         HxGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=QPzy3NAg0uS0gyv4nAUqVD8Tj8hGjKDNmg1qc+H7q/E=;
        b=PC+2rCOwPReiuEwA4XG1+2DKWcW+M7/XmufUFKb8FJFhsNCYd7syfsBWqpfKfMWiSK
         9DpRJkMPFJmCKm6O1y02Gb7MPnILnmBICkcBksO0UdOzhj5fqolTnE69f97n2TSDzsYn
         /8LohTZS3SPhmkgWLesuXH8nV3i2TL5cLyVSxIoVnOwr1vJvQMaTVkCo4E9OkMI59mL2
         jrmCPg52w3Ot4K++GEGj/utmNbSmb7u3nRnC7xmJ+NnLXlgyUS5Rs3gVhb1ge/yst5QN
         NRJGe4959gwqXxuEaDEUVp+QCeq5w+Tt6CNVbDRvNKVq2pYsf39XRPL5g5d07lPlMv8q
         Ewmw==
X-Gm-Message-State: AKGB3mJ81Q+OvBrtvb1s8r7vaO3Qy0CAS/e/rmItz/3nj9r5o58RLQMN
        QF0Jw1UXWPDYqQJjONwJLsuSwPXHRAt+KRTRRW2J6w==
X-Google-Smtp-Source: ACJfBovtARCZ8DDqQzGiZwIV1kLB+qvdKX0eZFIZSbr8fIMVe5uAMhBcCJ2QaZ3z3R2Tyggu/mV2X8uPotvGNjpSIHk=
X-Received: by 10.159.61.196 with SMTP id e4mr16448971uaj.156.1513365797702;
 Fri, 15 Dec 2017 11:23:17 -0800 (PST)
MIME-Version: 1.0
Received: by 10.176.21.194 with HTTP; Fri, 15 Dec 2017 11:23:16 -0800 (PST)
In-Reply-To: <CAMZug24WGWS3TaNPOVWPufGZ+67EbLggr4W3pxJtis9X375mag@mail.gmail.com>
References: <CAMZug24WGWS3TaNPOVWPufGZ+67EbLggr4W3pxJtis9X375mag@mail.gmail.com>
From:   Bryan Turner <bturner@atlassian.com>
Date:   Fri, 15 Dec 2017 11:23:16 -0800
Message-ID: <CAGyf7-F8cCprvK-e2S0kO0Wo+6n4m_gigpSQjCjSj-dhozMsMw@mail.gmail.com>
Subject: Re: Git Hooks
To:     Satyakiran Duggina <satya0521@gmail.com>
Cc:     Git Users <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Dec 15, 2017 at 11:12 AM, Satyakiran Duggina
<satya0521@gmail.com> wrote:
> I see that `git init` creates a .git directory and hooks are to be
> placed in that directory and these hooks are not tracked by version
> control. To achieve tracked hooks, either each developer has to copy
> the hooks or use tools like overcommit, pre-commit, husky etc.
>
> I'm wondering why hooks are not made external like .gitignore. I guess
> it would be better to have two git configuration directories in a
> repo, one hosting all the metadata managed by git and the other with
> user configured data (hooks, ignore/exclude, repo config etc).

Hooks are not external because they're not trusted. It essentially
amounts to allowing someone to download an arbitrary script or program
onto your computer which you then execute. It's extremely unsafe, and
is intentionally not possible. To get hooks in your instance, you have
to _manually_ install them. This gives you a chance to _review_ them
before they start executing on your system. Any other approach and the
hooks become an attack vector.

>
> Kindly let me know why the current design choice is made and if the
> proposed change would introduce unseen issues.
>
>
> Thanks,
> Satya

Hope this helps!
Bryan Turner
