Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4113F1FA14
	for <e@80x24.org>; Thu, 25 May 2017 09:53:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S967500AbdEYJxO (ORCPT <rfc822;e@80x24.org>);
        Thu, 25 May 2017 05:53:14 -0400
Received: from mail-io0-f174.google.com ([209.85.223.174]:32858 "EHLO
        mail-io0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S964907AbdEYJxN (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 May 2017 05:53:13 -0400
Received: by mail-io0-f174.google.com with SMTP id p24so133504276ioi.0
        for <git@vger.kernel.org>; Thu, 25 May 2017 02:53:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=C54znu2j65YOJKHx47GUcqQy2yp2jZoi2C+W/BGq2to=;
        b=R68LLPsDspg1+kE56ZTe49ree1VLCz+Gma+YLzEblKlGgbr4eK4gaXQRNp6x6Ijee8
         UvkG3J+NC80uePNVEZxIs0PMikP665vddtxjEp5cbtWC7FsNTQmnV9tBa5fX1MiMLmY6
         U5R6csBLEM6BN9dFGerxknq5jywFnJD0hg5xMiiebRvNbOjiG3INchTOHneIn0umva6T
         rxPmOU6fzlPB8ZPAwWotbxviuSPVl8NWOppLZl+GUoLCIWWdsco/4boM5Dg9+nHl3o3W
         NvzCTlw7GfKK39aT8e6CJc74LD6Bao9waDUGDuCWFQqMBYXW0puKCVbTEAZtV7+t12mg
         Lsxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=C54znu2j65YOJKHx47GUcqQy2yp2jZoi2C+W/BGq2to=;
        b=U7g2pRaDM9QLgz27FDTmfbZNlr2mUB8YayP+GQdpZtS0vse1cZCUXDhseC199AKWUr
         f3VVVlZqa5ZuBlF8DuftykbJ2qDLq2MqtZWM+2OdUJ66t7phV+vpXynDJPpBq1rW9guw
         hsUKLcH+25tkyICklCcG3MvWLeUj2k8qPjiMgbOPflD3KnRTSKbIbe7V4m/EizWdCxaO
         CCAIJ7zhl/f7sTJmc1/qpXVxYCAa3AL9Mp8IZsxQvp1e3KNey/Ek8UmEQao824d4jCr0
         kerGsZC+T3qTlGvJJiWYN/5pdpCAoccjt/u6jDa3ZxwHxuyvL5Sp+wCxmVdRAyhb+1NX
         ssMg==
X-Gm-Message-State: AODbwcACTsom2nMByAUmlLmd7YbuyVKaDKFOIE65df+2g08BxemhL096
        ls6+C229qhqabpMls/X27pchIDt3bgOu
X-Received: by 10.107.13.5 with SMTP id 5mr34330761ion.221.1495705992581; Thu,
 25 May 2017 02:53:12 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.50.117.161 with HTTP; Thu, 25 May 2017 02:52:42 -0700 (PDT)
From:   Adrian Forbes <forbesa06@gmail.com>
Date:   Thu, 25 May 2017 21:52:42 +1200
Message-ID: <CAOJu4w-4eCkt9Co19BmyTQ7NF+rf23LU8ANCTCcmPP84efdjeA@mail.gmail.com>
Subject: Documentation issue: git-stash examples
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Some of the example commands in git-stash documentation should be
written as comments rather than actual commands:
https://cloud.githubusercontent.com/assets/24915363/26444394/5cf6a754-4190-11e7-845e-135288c8916e.png

For example, `$ edit emergency fix` should be `# ... edit emergency
fix ...` like the other comments in the section.

It could be misleading for novices.


Adrian (github: @Solder-Soldier)
