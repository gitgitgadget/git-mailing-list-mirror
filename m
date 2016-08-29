Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C17B61FD99
	for <e@80x24.org>; Mon, 29 Aug 2016 20:15:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754532AbcH2UPG (ORCPT <rfc822;e@80x24.org>);
        Mon, 29 Aug 2016 16:15:06 -0400
Received: from mail-qk0-f170.google.com ([209.85.220.170]:33849 "EHLO
        mail-qk0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754185AbcH2UPG (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Aug 2016 16:15:06 -0400
Received: by mail-qk0-f170.google.com with SMTP id t7so149964188qkh.1
        for <git@vger.kernel.org>; Mon, 29 Aug 2016 13:15:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=RqdDLE7iAo9aL9GqzbBf1LVGhcLVOtnUuc2FBHUb38g=;
        b=YOHWk+zxeqRBhoJyzHTy0Kyppxb0T1YC98BDt3JZieJJhvi8jO2budLxa/P03hvZIe
         sSJfqUqramAiwoKJG2lH7ix8N76F8kSowXniA3grp7gFpCNqJ4OBwqEy4pVuc+8oQYLG
         VW6SHUpSOAs2+R1YCHOIZAQC+8Phtde3Krg6rtNwj9IkT0ITRPOFvi7ScXjKVozTyjQg
         8BZcP/ifXHv/eqAu1Rh8un8dSiJQxzIOcISYDEZHEEkF9XW4zaK5hbGXKegavowkSjR1
         4/+CuxC/KAHLx8owRdfgfnE70+EWPo928L321eG7UCDTMYaX4x9DmBDSDrAdp+TQbvud
         zT/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=RqdDLE7iAo9aL9GqzbBf1LVGhcLVOtnUuc2FBHUb38g=;
        b=CqIk66eVCltJtNP7AxgFCzVlR3g6TP5imazxyFuqwzdZKA/S92YNQT6Mb+LSqrRVu7
         bIRM/TSuGftA2+z7cXv3qhOqRXV8R+rNsiXGMov037RjD5Mu22kN00RUVUZc8f4GcGl5
         yJ/7fxEUv9ey05EhUjiSCgjUzblzcvGehw2cK4Yg6PMndABIE15VDdCtgsmwsfl0pf+w
         UFMSL5McFq/b7n1mc2fJn2a8XSzg5hlZtHxTc/FrehNAUlVv6O6mAPg/CDob6XGbVIGS
         BiDwkJKdXmMa55dU5mNSsmz1T8Th8cPyUTp64hAsDfEqpxU+nhinp69ldoibuTVgYMLc
         Z33w==
X-Gm-Message-State: AE9vXwMl9mUu+O/5hCJYupJmKg8InDUzfwU4jh5qKUBbCxwmyHu5kxzl8esVSSmjX4K0Yb4Taq5SIj4xhuuGbA==
X-Received: by 10.55.8.2 with SMTP id 2mr15803571qki.198.1472501705118; Mon,
 29 Aug 2016 13:15:05 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.55.87.193 with HTTP; Mon, 29 Aug 2016 13:14:44 -0700 (PDT)
In-Reply-To: <CAFMAO9y3LsrAb_jp8XVq2mexaA4bBqmWFwJu55r4S6Dxd2-zxw@mail.gmail.com>
References: <CAFMAO9y3LsrAb_jp8XVq2mexaA4bBqmWFwJu55r4S6Dxd2-zxw@mail.gmail.com>
From:   =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Date:   Mon, 29 Aug 2016 22:14:44 +0200
Message-ID: <CACBZZX63DAmFt_ZiUHj-bs9dtwRd4MOxoLfM8r1uRi3q4Mwnkw@mail.gmail.com>
Subject: Re: Reducing CPU load on git server
To:     "W. David Jarvis" <william.d.jarvis@gmail.com>
Cc:     Git <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Aug 28, 2016 at 9:42 PM, W. David Jarvis
<william.d.jarvis@gmail.com> wrote:
> I've run into a problem that I'm looking for some help with. Let me
> describe the situation, and then some thoughts.

Just a few points that you may not have considered, and I didn't see
mentioned in this thread:

 * Consider having that queue of yours just send the pushed payload
instead of "pull this", see git-bundle. This can turn this sync entire
thing into a static file distribution problem.

 * It's not clear from your post why you have to worry about all these
branches, surely your Chef instances just need the "master" branch,
just push that around.

 * If you do need branches consider archiving stale tags/branches
after some time. I implemented this where I work, we just have a
$REPO-archive.git with every tag/branch ever created for a given
$REPO.git, and delete refs after a certain time.

 * If your problem is that you're CPU bound on the master have you
considered maybe solving this with something like NFS, i.e. replace
your ad-hoc replication with just a bunch of "slave" boxes that mount
the remote filesystem.

 * Or, if you're willing to deal with occasional transitory repo
corruption (just retry?): rsync.

 * Theres's no reason for why your replication chain needs to be
single-level if master CPU is really the issue. You could have master
-> N slaves -> N*X slaves, or some combination thereof.

 * Does it really even matter that your "slave" machines are all
up-to-date? We have something similar at work but it's just a minutely
cronjob that does "git fetch" on some repos, since the downstream
thing (e.g. the chef run) doesn't run more than once every 30m or
whatever anyway.
