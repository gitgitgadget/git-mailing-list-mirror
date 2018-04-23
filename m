Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 30B8B1F424
	for <e@80x24.org>; Mon, 23 Apr 2018 21:01:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932225AbeDWVBN (ORCPT <rfc822;e@80x24.org>);
        Mon, 23 Apr 2018 17:01:13 -0400
Received: from mail-yw0-f174.google.com ([209.85.161.174]:44536 "EHLO
        mail-yw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932157AbeDWVBN (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Apr 2018 17:01:13 -0400
Received: by mail-yw0-f174.google.com with SMTP id u10-v6so5078633ywl.11
        for <git@vger.kernel.org>; Mon, 23 Apr 2018 14:01:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=5Z4voRzrI8YRYppuR3RaySq725gaFPdYqRhGVp/RT+Q=;
        b=ADlddcWWR1KfP19NU85uf0hZFQQfVkFeiXT95WTW79VeNPB6LABPbq7hKXfMhalXWj
         QruDKqyhK95GvUpJonOpxcGzfeFL1hHZmUA3OAWesuGb2/ObD0HZl5xN1cXjxJDiYUnV
         kE5N1GUJc2Z3tDUQsVIzrZPbDMm3KkxllceA0Cd5sP5Y5uvztjdpOI4XdY6/31REJ3sy
         haNg3Iri8VMEAgGTBszhkGOuxWr1QxLjO96Lwn5YBel9Ldg0I4oeQZsPyw8SmN33K+Qq
         ejj/rh+lA0F5NhJiFG465urEr95dG78xVL4vROVWW6s+Prs+Po8UpCkGxw7BERGgpsO3
         wM3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=5Z4voRzrI8YRYppuR3RaySq725gaFPdYqRhGVp/RT+Q=;
        b=dj+ekIXODqa35gUtSfGnKzHTqsipldz02RWEFn8PWLhtxJ7O70wVGaQSCUDMrs2upV
         BBCoaIIjtFEWuCOVfNdRqBEzXN+dCOMsbzidNLYkilo6UYqvPGdoGsHRdO1NPXXspQg9
         9a7X96LnGSdEgGOpj4n8dxg+GuPaBE21v2FPM0Er1gk56zEHvmvgb8IqtEnLF4kUZJR6
         YmIEgBI0c8k8Zrx5ELhYIggD/OmB69Tjbr5MZxpzquz2Jn+ypL5jW5cvDNjerVkxfNfF
         FWWdtkVvrX0AIbr0RROe+XRLF2jhO5UCccwKUu4PpjMdo6gad7YmVP/+1nu2/Lhr82O5
         cyVw==
X-Gm-Message-State: ALQs6tCj6kL6osZZdTt8EEcGklrNFhnPPb49rIKssNYP1ENflT4+Llqc
        ma3jf8FfIiR8wOmaulZD1a169j2HWrNaK3NCOfViUAPdsJg=
X-Google-Smtp-Source: AIpwx4+fTF8exFhnc0d9cfRpU/5qvyUAZKrhAfCRYrN1Kq4dYj0V4z9tnAaXIeDBRZvQ9N1sErOFnD5jyK4K7SyCJ4o=
X-Received: by 2002:a0d:e28e:: with SMTP id l136-v6mr11561314ywe.500.1524517271890;
 Mon, 23 Apr 2018 14:01:11 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:cf90:0:0:0:0:0 with HTTP; Mon, 23 Apr 2018 14:01:11
 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
Date:   Mon, 23 Apr 2018 14:01:11 -0700
Message-ID: <CAGZ79kbzFGn2-xcrWFi1+ZUgSGGHdUPEQOexu8Lan796LCsvBg@mail.gmail.com>
Subject: GSoC students and mentors in 2018
To:     git <git@vger.kernel.org>
Cc:     Pratik Karki <predatoramigo@gmail.com>,
        Christian Couder <christian.couder@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Paul-Sebastian Ungureanu <ungureanupaulsebastian@gmail.com>,
        alban.gruin@gmail.com
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Git community,

This year we'll participate once again in Google Summer or Code!
We'll have 3 students and 3 mentors, which is more than in recent years.

Paul-Sebastian Ungureanu mentored by DScho, wants to convert git-stash
into a builtin.

Alban Gruin and Pratik Karki want to convert parts of git-rebase into
a builtin. Both are mentored by Christian and myself.

The slots were just announced today, please join me in welcoming them
to the Git mailing list! (Although you may remember them from the
micro projects[1,2,3])

[1] https://public-inbox.org/git/20180319155929.7000-1-ungureanupaulsebastian@gmail.com/
[2] https://public-inbox.org/git/20180301111907.17607-1-alban.gruin@gmail.com/
[3] https://public-inbox.org/git/20180327173137.5970-1-predatoramigo@gmail.com/

Thanks,
Stefan
