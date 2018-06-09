Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5A08C1F403
	for <e@80x24.org>; Sat,  9 Jun 2018 20:25:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932195AbeFIUZy (ORCPT <rfc822;e@80x24.org>);
        Sat, 9 Jun 2018 16:25:54 -0400
Received: from zimbra.linuxprofi.at ([93.83.54.199]:36410 "EHLO
        zimbra.linuxprofi.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753971AbeFIUZy (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 9 Jun 2018 16:25:54 -0400
Received: from localhost (localhost [127.0.0.1])
        by zimbra.linuxprofi.at (Postfix) with ESMTP id 044C02A384E;
        Sat,  9 Jun 2018 22:25:59 +0200 (CEST)
Received: from zimbra.linuxprofi.at ([127.0.0.1])
        by localhost (zimbra.linuxprofi.at [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id D_oxg6fdMwWG; Sat,  9 Jun 2018 22:25:58 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by zimbra.linuxprofi.at (Postfix) with ESMTP id 9CBFB2A3862;
        Sat,  9 Jun 2018 22:25:58 +0200 (CEST)
X-Virus-Scanned: amavisd-new at zimbra.linuxprofi.at
Received: from zimbra.linuxprofi.at ([127.0.0.1])
        by localhost (zimbra.linuxprofi.at [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 5lQmk6WtTRLe; Sat,  9 Jun 2018 22:25:58 +0200 (CEST)
Received: from localhost (178.165.129.234.wireless.dyn.drei.com [178.165.129.234])
        by zimbra.linuxprofi.at (Postfix) with ESMTPSA id 58C732A384E;
        Sat,  9 Jun 2018 22:25:58 +0200 (CEST)
Date:   Sat, 9 Jun 2018 22:25:53 +0200
From:   Christoph =?utf-8?Q?B=C3=B6hmwalder?= <christoph@boehmwalder.at>
To:     Elijah Newren <newren@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Subject: Re: Why is there no force pull?
Message-ID: <20180609202553.dvoirez5mi2r4ctk@christoph-lap>
Mail-Followup-To: Elijah Newren <newren@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
References: <20180609190154.yl4ig6dxfihgm5qi@christoph-lap>
 <CABPp-BG9HQ4O8h7-b4oL7KLu+boe6-QV1fvcfW_4O3Rax3W_Hw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CABPp-BG9HQ4O8h7-b4oL7KLu+boe6-QV1fvcfW_4O3Rax3W_Hw@mail.gmail.com>
User-Agent: NeoMutt/20180512
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Jun 09, 2018 at 01:04:30PM -0700, Elijah Newren wrote:
> Upon reading the subject and before reading the body, I assumed you
> were going to ask for a 'git pull --force' that would throw away
> *uncommitted* changes (i.e. do a 'git reset --hard HEAD' before the
> rest of the pull).  But then you asked for both uncommitted and
> committed changes to be thrown away.  That difference isn't something
> you have to consider with a push.
> 
> That might be a reason such an option would be confusing, or it might
> just be a warning to document the option carefully.  Anyway, thought
> I'd mention it.

Interesting, I hadn't taken that first scenario into consideration at
all. So I guess two very aptly named flags would be necessary to
implement this kind of feature...

--
Regards,
Christoph
