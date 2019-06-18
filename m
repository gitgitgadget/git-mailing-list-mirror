Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 976571F462
	for <e@80x24.org>; Tue, 18 Jun 2019 17:20:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729491AbfFRRUD (ORCPT <rfc822;e@80x24.org>);
        Tue, 18 Jun 2019 13:20:03 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:46791 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728572AbfFRRUD (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 Jun 2019 13:20:03 -0400
Received: by mail-wr1-f66.google.com with SMTP id n4so317490wrw.13
        for <git@vger.kernel.org>; Tue, 18 Jun 2019 10:20:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umich.edu; s=google-2016-06-03;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4kb/2Xl9Q85x7DnPBiv2/RXFW2CGInuFJr9sIGOoJzw=;
        b=DIm/kRN4wKOJAjZf9bAOdKYpd/uYbmIxiYc5rfdpVzPMUw1ut3T/G5mZm5swTa+64Q
         p2+v7q8TQjdG4aQlBA5IlnuLhoZFa6+anTJYBWmZOyNT5AE89MrFr9yj2sIw0JbJL479
         IjVYJ6HcrAY3K1wSffZR/qst7n3OTsT9j3b4U34nlLrXI8k8lcux/uykMjdfMZ2E9VL2
         PA7kVyhsIdLPD6L0D5Y2HIVpaFcP3Mp6ZHGPq6bf5UsoO2g63/3D+VrmbillhKmzCYqE
         sFeKvP02bjYc5OpxP8MGiHk4Jaq2/1M1WoIdc6KY8YcBAYspnLykcCd1mvEuRFUeb0Zk
         Yxsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4kb/2Xl9Q85x7DnPBiv2/RXFW2CGInuFJr9sIGOoJzw=;
        b=gowZWzH1T/8Aey9J+O1wNijHVhY3uMoeoiJTMql+XdL5vJ9xf4P9EKDfE0TNOWytKP
         D1ViBNeH3Pr6q6c8roBgCrtTf39aLLgHicF35QsmK1TikP1KGuakMS+vGu9tmiW4pqPz
         V6UsuZ7kNLscAGHYEkjkXlzvlEb1ftFoxrHx8GCIDeFxo2uJUAU+g9WqR4bt3/6i+rgD
         +Bp9sOb+gZosRmLA66ytBJKRVFRJmXgvU6NFGTmzK3PBIKcKnUsEf+5OZcDsDbRkUnnA
         /Vtj2to05TbtUVDjHYlohrTg3DU+nWb0Hu9wyLeQAjb75mxedLSRYP9fJ1bhliQxuYSz
         0XMQ==
X-Gm-Message-State: APjAAAUe5hYtyI9ODY1Lak2RQsZP9Zes45qSRbGnTHdfwFqUdHlNnGoz
        gKmnCWH8GqhFiJowKFRg5vbtFaTtlwlKBb0z7iUpsw==
X-Google-Smtp-Source: APXvYqyRnqAUz8ve4IWOlk1yoGLzue2hRW3vPVBw+RSUInbyRv9y1Ev0PN8wjjCbb+2Mh0MvOXz6vOC0e0PcLhvJ7Hc=
X-Received: by 2002:a5d:508a:: with SMTP id a10mr13130831wrt.59.1560878402073;
 Tue, 18 Jun 2019 10:20:02 -0700 (PDT)
MIME-Version: 1.0
References: <CA+dzEB=iOsfuZQ5Z8uXO+k6E3WczkLX64yWUpTm1NZBjdd47kg@mail.gmail.com>
 <CAPig+cTFfhBz+xiq6VAMNOW4OTvByHJ1g5oF=RTTh_buA+nUQA@mail.gmail.com>
In-Reply-To: <CAPig+cTFfhBz+xiq6VAMNOW4OTvByHJ1g5oF=RTTh_buA+nUQA@mail.gmail.com>
From:   Anthony Sottile <asottile@umich.edu>
Date:   Tue, 18 Jun 2019 10:19:50 -0700
Message-ID: <CA+dzEBk5GbkuDde6nDw+nx1wL50zoswNE74EFvYJvrxPs7OZmA@mail.gmail.com>
Subject: Re: windows: error cannot lock ref ... unable to create lock
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jun 18, 2019 at 10:01 AM Eric Sunshine <sunshine@sunshineco.com> wrote:
>
> On Tue, Jun 18, 2019 at 12:39 PM Anthony Sottile <asottile@umich.edu> wrote:
> > + git fetch origin --tags
> > Unpacking objects: 100% (10/10), done.
> > From https://github.com/asottile-archive/git-windows-branch-test
> >  * [new branch]      master     -> origin/master
> > error: cannot lock ref 'refs/remotes/origin/pr/aux': Unable to create
> > 'C:/Users/IEUser/x/x/.git/refs/remotes/origin/pr/aux.lock': No such
> > file or directory
> >  ! [new branch]      pr/aux     -> origin/pr/aux  (unable to update local ref)
>
> AUX is a reserved[1] filename on Windows. Quoting from that source:
>
>     Do not use the following reserved names for the name of a file:
>     CON, PRN, AUX, NUL, COM1, COM2, COM3, COM4, COM5, COM6, COM7,
>     COM8, COM9, LPT1, LPT2, LPT3, LPT4, LPT5, LPT6, LPT7, LPT8, and
>     LPT9. Also avoid these names followed immediately by an
>     extension...
>
> The default Git "ref store" is filesystem-based, so a branch named
> "aux" is problematic. Other ref store implementations would not be
> subject to this limitation (though I'm not sure what the state of the
> others is -- someone with more knowledge can probably answer that).
>
> [1]: https://docs.microsoft.com/en-us/windows/desktop/FileIO/naming-a-file#naming-conventions

Oh of course, totally forgot about the special files on windows.

Thanks for the quick response and helpful link!

Anthony
