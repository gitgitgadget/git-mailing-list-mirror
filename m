Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CC33520958
	for <e@80x24.org>; Thu, 23 Mar 2017 14:37:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934362AbdCWOh3 convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Thu, 23 Mar 2017 10:37:29 -0400
Received: from mail5.fer.hr ([161.53.72.235]:42560 "EHLO mail.fer.hr"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751309AbdCWOee (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Mar 2017 10:34:34 -0400
X-Greylist: delayed 387 seconds by postgrey-1.27 at vger.kernel.org; Thu, 23 Mar 2017 10:34:33 EDT
Received: from POSTAR.fer.hr (2001:b68:16:250::72:237) by MAIL5.fer.hr
 (2001:b68:16:250::72:235) with Microsoft SMTP Server (TLS) id 14.3.319.2;
 Thu, 23 Mar 2017 15:27:16 +0100
Received: from mail-lf0-f47.google.com (209.85.215.47) by POSTAR.fer.hr
 (161.53.72.237) with Microsoft SMTP Server (TLS) id 14.3.319.2; Thu, 23 Mar
 2017 15:27:15 +0100
Received: by mail-lf0-f47.google.com with SMTP id a6so82445298lfa.0        for
 <git@vger.kernel.org>; Thu, 23 Mar 2017 07:27:15 -0700 (PDT)
X-Gm-Message-State: AFeK/H2vbCkjGY+HicZaLJLh/5Y9oPg2svY08FVS1j+JRZl4YZSx3uYe3Y0mOuWTJL3mtHBnxzLXJJ7TW1pFYA==
X-Received: by 10.25.41.11 with SMTP id p11mr1567419lfp.154.1490279234841;
 Thu, 23 Mar 2017 07:27:14 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.25.19.69 with HTTP; Thu, 23 Mar 2017 07:26:34 -0700 (PDT)
In-Reply-To: <70bd7cfd05ae459dac94625bb78c26c3@MAIL.fer.hr>
References: <CAEPqvoxM9_Ku-1YgwNiqearUBaaYbAJcehuSwZYNNfJLQNH1_g@mail.gmail.com>
 <8a1179dfbb7743b6b8c23570306120b7@MAIL.fer.hr> <CAEPqvozCvFqOTNPw0c1ErKoOd+Mn1WCyJr9hj6CXiWWtL93Tqw@mail.gmail.com>
 <70bd7cfd05ae459dac94625bb78c26c3@MAIL.fer.hr>
From:   =?UTF-8?B?SnVyYWogT3LFoXVsacSH?= <juraj.orsulic@fer.hr>
Date:   Thu, 23 Mar 2017 15:26:34 +0100
X-Gmail-Original-Message-ID: <CAEPqvoz8s=CVLABuXx-zOzryrXwr_cb39G2TYJvvFXRYzpCBFQ@mail.gmail.com>
Message-ID: <CAEPqvoz8s=CVLABuXx-zOzryrXwr_cb39G2TYJvvFXRYzpCBFQ@mail.gmail.com>
Subject: Re: [git-gui] Amending doesn't preserve timestamp
To:     Igor Djordjevic BugA <igor.d.djordjevic@gmail.com>
CC:     "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Originating-IP: [209.85.215.47]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello Igor (and others), I have something else to report about the
commit amend functionality in git-gui, and I think it could be
related to my original question. It seems that git-gui messes up
international signs on amending.

E.g. I use git gui to make a commit, and all is OK:

commit ef24b133dda6c18b8ef01b1a38f9e049d87f2021
Author: Juraj Oršulić <juraj.orsulic@fer.hr>

I open git gui again, click "Amend Last Commit", press "Commit", and I
get this in git log:

commit 6e09ff9edcef863d92f02cf86e0307c27171aec0
Author: Juraj OrÅ¡uliÄ<U+0087> <juraj.orsulic@fer.hr>


Does anyone have any idea what could be the cause?

I tested this on Ubuntu 16.04 and HEAD vearsion of git-gui on
http://repo.or.cz/git-gui.git, currently 0.21.0.5.g5ab72.


Thanks,
Juraj
