Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6613C1FAFB
	for <e@80x24.org>; Sat,  1 Apr 2017 01:27:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755343AbdDAB1N (ORCPT <rfc822;e@80x24.org>);
        Fri, 31 Mar 2017 21:27:13 -0400
Received: from mail-oi0-f51.google.com ([209.85.218.51]:35885 "EHLO
        mail-oi0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754944AbdDAB1M (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 31 Mar 2017 21:27:12 -0400
Received: by mail-oi0-f51.google.com with SMTP id r203so78695453oib.3
        for <git@vger.kernel.org>; Fri, 31 Mar 2017 18:27:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:reply-to:from:date:message-id:subject:to;
        bh=myycnE/SgTJqsJ0szWUWV1UYihk0bTUNWrHapfu9xsE=;
        b=MiBrc+kjwaIoHumPJXMwJ5uDdSgJHEXWPvGujTfAyCKzQ6NdN1aFZOoCKQFtQzWHm2
         uIFIfNXTJ+TQd1y1N1L0AD7zQAcPuwOtLQZvA6AAC/dxZBaIT2jr3TzCjQo9AZWFPqzE
         lDCO7I+/V6n4K2Xklx0bCI3BvDqsAuD/JE8wsjqrXvjbcwC4zgkSJ8C+PZ3TDlTgaJSS
         EsA0imn7qO6tW7amfbxFvsaDuaRWTXVqIgi9sA/ca3BIoR/4cnFUt/Q+U4Y1Syp623as
         y41H/LMBbxyHijRnR+446bMjnj52nIw24DQD4O3rjr9EzENr6XopYs4HDmZ88M3zbY8r
         +z1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to;
        bh=myycnE/SgTJqsJ0szWUWV1UYihk0bTUNWrHapfu9xsE=;
        b=XlMMREHZ1klDhRo8USo0qLd6r8OYUmA7MM8hYXuYvoXyD9Huf520zOGNCC2GAvMYmC
         z9WQwu6nTw+D1X5DxcBFla9jc+sVqPGo/ffHsqVBtT2jMwRcGCMHaYC1ZegAIURKnbrH
         741eZRNA4TYEP/0pJeBDaegqV6xBngb6tbJ/spvfw6LJSRlR78F65FNrciWe7QYLQflC
         ZWjYqGEQF+y+G/eeyT27WB43G7NZR+5NnaoYP1SkcNkl9YdHvagSmNc8lTpdQgoetymB
         sTaeGB+odCdT/N6W1gWEUo+iWWp5865EF6h+RRZW8HhzjaSPM8ouQxXnr/cgY701NrvZ
         vz0Q==
X-Gm-Message-State: AFeK/H0QMFu2PNfuFVVumBc8Z8zGSkQowkyEnY0NP00UVifgRyIf619kLvHYr7QILEbiz6jXsNWzuXCnbQmZPw==
X-Received: by 10.202.183.5 with SMTP id h5mr3608685oif.195.1491010031481;
 Fri, 31 Mar 2017 18:27:11 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.74.31.131 with HTTP; Fri, 31 Mar 2017 18:27:11 -0700 (PDT)
Reply-To: noloader@gmail.com
From:   Jeffrey Walton <noloader@gmail.com>
Date:   Fri, 31 Mar 2017 21:27:11 -0400
Message-ID: <CAH8yC8nwCmPG+EoaTZwL8GEwvOS=0d2-VOQMWs-SR65wwBs36w@mail.gmail.com>
Subject: Preparing for the Upcoming Removal of UCB Utilities from the Next
 Version of Solaris
To:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Preparing for the Upcoming Removal of UCB Utilities from the Next
Version of Solaris,
https://blogs.oracle.com/partnertech/entry/preparing_for_the_upcoming_removal
.

Sorry to keep beating the Solaris horse. Oracle charges forks for
simple updates, like security bug fixes, and updates to cURL and Git.
I think its important that folks have alternatives available to them.

Jeff
