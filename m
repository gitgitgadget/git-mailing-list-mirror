Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4F8521F424
	for <e@80x24.org>; Sun,  8 Apr 2018 10:15:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751646AbeDHKPw (ORCPT <rfc822;e@80x24.org>);
        Sun, 8 Apr 2018 06:15:52 -0400
Received: from mail-qt0-f177.google.com ([209.85.216.177]:38507 "EHLO
        mail-qt0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750891AbeDHKPv (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 8 Apr 2018 06:15:51 -0400
Received: by mail-qt0-f177.google.com with SMTP id z23so6047116qti.5
        for <git@vger.kernel.org>; Sun, 08 Apr 2018 03:15:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=qp6I4Yu8oMHwCewx69WtvAP0nZugsMfj4LruGGqJvT0=;
        b=Z1QZniE+E9vdzqsw6vWxkskUl8DH6XeLxOZCizzFMMPqLPPu1+Jf+7y/zn+Lfoavrc
         jC/8cg2nVsR+S2Gp1PAteoNYvRVjN7ok90SO/gOuAFWfX/TaPTbltjqmAPo7qarNccW2
         FoeZar2xecWBo4qJ86at7vQ5DhunynbES332hVPmwZCMdbuCMCJxyVyRlf5x8vE1HBp0
         PinB4jz19dfysoLn9cg114PI3w6WPAUO0sfjCY5EhC59IS9bmnxsZ7OzB/lI8hG4OghZ
         WXW4SDxzrzsp6XbCmxlo0BcxDgZi6E23gXOZI777N+mJVSwZxXrdJtPshmSgsoP8KO3S
         Uk5g==
X-Gm-Message-State: ALQs6tA5nSEs5LzJi1G0buYYng0czjnpidU1xVvRWzyRtMjk1qW/VD4a
        pP/esdAfqt/PHIvHxTXScKlVlvemJr8m04JQeKBwWS6i
X-Google-Smtp-Source: AIpwx4/9xYIkqBY9+CFiu7HlZLJna21epJ1qhAMecuN/AMOxvizxg0RidIScFunacZghAA05nM6MA6z6zZ6kvPW2q6U=
X-Received: by 10.200.1.79 with SMTP id f15mr46668744qtg.177.1523182550763;
 Sun, 08 Apr 2018 03:15:50 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.237.43.67 with HTTP; Sun, 8 Apr 2018 03:15:50 -0700 (PDT)
From:   Michal Novotny <clime@redhat.com>
Date:   Sun, 8 Apr 2018 12:15:50 +0200
Message-ID: <CANT8FXS_vsXb5oyma+d7fgEaYBqFYjM2N=S6O6hksObHhN8gWw@mail.gmail.com>
Subject: getting pull and push URLs for the current branch
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello,

is there a way to get remote url  for the current branch? That is the
url that will be used when I call `git pull`. It doesn't seem to be a
particularly easy task.

Thank you!
clime
