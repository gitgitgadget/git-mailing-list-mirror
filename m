Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 947331FCA0
	for <e@80x24.org>; Mon, 27 Mar 2017 22:17:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752502AbdC0WR1 (ORCPT <rfc822;e@80x24.org>);
        Mon, 27 Mar 2017 18:17:27 -0400
Received: from mail-qk0-f175.google.com ([209.85.220.175]:34658 "EHLO
        mail-qk0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752229AbdC0WR0 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Mar 2017 18:17:26 -0400
Received: by mail-qk0-f175.google.com with SMTP id d10so45605868qke.1
        for <git@vger.kernel.org>; Mon, 27 Mar 2017 15:17:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=WZd9CNaZ5Xdcs5AgKrasl013VLZPg1Dg4VIisk3cIEk=;
        b=N57QgLijnAUqTBw3QyYfyQspBJ5mtpnVMCSFO9r3Sy1uucEVS+6uhpVB9WS8CdDbv0
         phZwbiC6TOokMGqoTZ7ByqvJ7WjeXAavgBJnVMN+mYw0v9qeNgqvpVnkZ51nYQLo89Ap
         ZiYO934mKpUdqr/dueT7VRFoPIgAC6aRHbCE1v+CUdqoVfaHDSP+R8fep0FTNDmA1yHP
         +rza3Em3yfuOeuSMWwipawCyk3TJHS/2fPMFTFLPLrrsHbC7wAqVwdnZc0ynIN0KmOFx
         5MtibJbO2Wu2KUcvGpK0E8Kh80itFRNSOoY5XdP9S2qHddfvqP+FJtuvOFDZ47bAoMZ1
         e91g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=WZd9CNaZ5Xdcs5AgKrasl013VLZPg1Dg4VIisk3cIEk=;
        b=Gvgdv7cdmgRrvDe0gQtwxMkYC0Aq8pvZA50JXMMqg+GHJpk8OSdHzWU7lXzfh6gT0H
         JzcUKFv3ShAqG1+3pi0dcltADxIUTtHatkBhauH6hNiyllJMvcUQNAG+mHvhYI2e5HVr
         NUH0GaKQGfhGuT+pPiiP1k3gGL/r3MpyUmpGOTCoJrhpVNGsVpxsZEjx+mS1QJHupyFq
         +ymyfYDViy22iCIJvrNo7FkWePfV8dflEL/9F3UrwdqkR1laHajV2916vYUhX5d2t0Wi
         HHsAAR3NtM3JiNhjwxKHo00A9pLui4Nbx4p5jkQ6I+sNZbkEVw/6mdcYvt4efnD5+NVF
         Jbpw==
X-Gm-Message-State: AFeK/H1SDt+1muM/IOPrmudubOFwHdrfI85SOJsA6heKVxHp4nAJWdB1L5OxpN7uZqqf+w==
X-Received: by 10.233.221.2 with SMTP id r2mr23204552qkf.159.1490653039476;
        Mon, 27 Mar 2017 15:17:19 -0700 (PDT)
Received: from mango1 (nat-128-84-124-0-45.cit.cornell.edu. [128.84.124.45])
        by smtp.googlemail.com with ESMTPSA id k30sm1302214qkh.50.2017.03.27.15.17.18
        for <git@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 27 Mar 2017 15:17:19 -0700 (PDT)
Date:   Mon, 27 Mar 2017 18:17:08 -0400
From:   Devin Lehmacher <lehmacdj@gmail.com>
To:     git@vger.kernel.org
Subject: [GSoC] Proposal Discussion
Message-ID: <20170327221707.GA34039@mango1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.8.0 (2017-02-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello everyone,

I am a student studying Computer Science at Cornell University. I
already completed a microproject, Move ~/.git-credential-cache/socket to
$XDG_CACHE_HOME/credential/socket a week and a half ago or so.

I am interested in 2 different projects and would like some advice on
them, to help me decide which one to submit a proposal for.

1. `git rebase -i` conversion. 
   I was initially the most interested in this project but realize that
   after having a very busy week last week that Ivan Tham started
   [discussion][1] about this project. Would it be appropriate to submit
   a proposal for a project that someone else also wants to work on?

2. formatting tool improvements. 
   There are four different git commands mentioned [here][2] as possible
   tools to improve as can be seen in the email. Of those I think it
   would make the most sense to extend `git name-rev`. It seems best
   suited to the desired behavior. It would need to be extended to
   understand rev's that refer to objects rather than just a commit-ish
   and also add formatting support similar to the information that log
   and for-each-ref can output. Since this doesn't seem like much work,
   would it be feasible to generalize and somewhat standardize all of
   the formatting commands?

[1]: https://public-inbox.org/git/20170320164154.xBcU6rG0C%25pickfire@riseup.net/
[2]: https://public-inbox.org/git/CA+P7+xr4ZNCCJkS0=yR-FNu+MrL60YX-+Wsz9L_5LCNhnY_d=A@mail.gmail.com/

Thanks for any feedback you may have,
Devin
