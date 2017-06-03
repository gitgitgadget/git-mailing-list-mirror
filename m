Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9455A202F8
	for <e@80x24.org>; Sat,  3 Jun 2017 00:46:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751508AbdFCAqi (ORCPT <rfc822;e@80x24.org>);
        Fri, 2 Jun 2017 20:46:38 -0400
Received: from mail-pf0-f170.google.com ([209.85.192.170]:33706 "EHLO
        mail-pf0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751061AbdFCAqg (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Jun 2017 20:46:36 -0400
Received: by mail-pf0-f170.google.com with SMTP id 83so914236pfr.0
        for <git@vger.kernel.org>; Fri, 02 Jun 2017 17:46:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=xJBZmPxk0tivzxG3pc2I1AeTHeCD2VYrd5LACn3LXTc=;
        b=oZEdxWN9jzRalREaIalBOOMYFU6iYahq7Y2OZRBk/2/oSculi+5UbYRFuhIYpMJJlw
         +ImoPHzQdJfWjWM7hXvTUPbg3ADRmF68hsv+uN9NlceVBdrcLNSS2WKUW7Qa7//v2RQy
         14sTF5Ec+TnaQZMLUoKINpdUHrjv9cc/uYjSnPq8EFm1iiS8XWRDPf/a4DuMHC+BJa7U
         onRItgNOuiPm84y0cscidlg5oJEgfKWilseM5MHFVeq59zF5KIoNS4/ua9iPN2cR/4Ok
         SU+grv9JuX/Qw09Xf0I4/Ez+dbX4P6Gj01C8QpD5lCEI1v9T950SrM68B7YP4boxEOzE
         vF2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=xJBZmPxk0tivzxG3pc2I1AeTHeCD2VYrd5LACn3LXTc=;
        b=sndBGj8e5bPRzHTZfYK9wLuyuxk7tedjiQCJjjAZwX6lcjSahelgczxYELo8l4pelM
         JKud8XxBsedu3tv1re+6Bman3xf0lpWa047584XpGmW2IW/jtFgn+MpOijueoxyE7bCj
         oIB+oBgJF4Xs9c+fD1NcZudGmwwSa5f3L06BZ4Kq4sfauBIb2EkV5J4oqxct5XsQZhBn
         Rl7Cy9Ig7gFMX3NvOKJbrOs9D4FD6qH1775pW6QQRvXamIFIGkNJ/xCqEfLjFX7nsP6K
         Yp9pty+pQlHB1Ys8M38nWkIO61/jGWqLNQ2bOuHgpIZraouyGPGIBinNX5PAEHP5W65n
         tctg==
X-Gm-Message-State: AODbwcDmdXAzN+b+1DDbGBxsdarTNkrBW1BjvFuBRc+GX7vTfUBXe+nF
        Ex/iHojyinBQtW2zvSEoAJQw1MW1E0yJ
X-Received: by 10.84.224.205 with SMTP id k13mr2573804pln.279.1496450795254;
 Fri, 02 Jun 2017 17:46:35 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.100.170.200 with HTTP; Fri, 2 Jun 2017 17:46:34 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
Date:   Fri, 2 Jun 2017 17:46:34 -0700
Message-ID: <CAGZ79kboxyUKy2j2GDZzWhOHeLHM17fYhQ0Wy=HxKaM-zXFC3A@mail.gmail.com>
Subject: public inbox links, was: Re: preserve untracked cache, was Re: What's
 cooking in git.git (Jun 2017, #01; Thu, 1)
To:     Junio C Hamano <gitster@pobox.com>, Eric Wong <e@80x24.org>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jun 2, 2017 at 5:26 PM, Junio C Hamano <gitster@pobox.com> wrote:
>
> Issue #06 of May marked it to be merged to 'next':
> https://public-inbox.org/git/<xmqqo9ulo1yn.fsf@gitster.mtv.corp.google.com>
>
> Issue #07 of May marked it for 'master':
> https://public-inbox.org/git/<xmqqwp98j8q2.fsf@gitster.mtv.corp.google.com>
>
> Issue #08 of May kept it (i.e. no issues discovered in the
> meantime):
> https://public-inbox.org/git/<xmqq1sr889lb.fsf@gitster.mtv.corp.google.com>
>
> Issue #01 of June reports it in 'master':
> https://public-inbox.org/git/<xmqqshjk5ezb.fsf@gitster.mtv.corp.google.com>
>

Today I learned again how public-inbox is awesome! Thanks Eric!

* You can just copy the message ID INCLUDING the surrounding < >
  and public inbox still just shows you the correct message. I had assumed
  you would need to strip off the < > and I did so since.

* However with the < > unstripped, the awesomeness is limited:
  Some tools (including my mail reader as well as public inbox itself[1])
  do not recognize the link when there are < > in there.

While the second point is not the end of the world, it's still
slightly annoying,
which is why I thought I'll point it out here.

[1] https://public-inbox.org/git/xmqqvaodx6g4.fsf@gitster.mtv.corp.google.com/

Thanks,
Stefan
