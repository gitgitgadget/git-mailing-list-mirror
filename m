Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EF2CB20133
	for <e@80x24.org>; Fri,  3 Mar 2017 20:14:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752020AbdCCUOb (ORCPT <rfc822;e@80x24.org>);
        Fri, 3 Mar 2017 15:14:31 -0500
Received: from mail-wm0-f43.google.com ([74.125.82.43]:36346 "EHLO
        mail-wm0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751415AbdCCUO3 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Mar 2017 15:14:29 -0500
Received: by mail-wm0-f43.google.com with SMTP id n11so23649571wma.1
        for <git@vger.kernel.org>; Fri, 03 Mar 2017 12:13:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=XuFydx7OD0/JDAO1gav++4QQIoj35zuMHGhG85et998=;
        b=kbVR4Rhg6csSyUaMwUGk/7g9OejuH4WI/xi01mAzXqiGuJ6tDCM56Xbvgfy3hX/xWm
         eVAtJe+TrRppofO0O84k/xuXsUHkef+dD+oVG7G78nQ46PA2voZWseJh6Fl561I8Zx/4
         qwc4sia3n+c7Zg7qZK6D2e0AjpVUU2SVc1KBr3lRcZtBKq5iE9HJzWdMgJX2EG7YhAJ/
         R9PZyFJDD+jPajiTqLTEDwzQ26TDwMdVBDohoitrVppSvjF9SoVkRrsTgptA9nUw58hn
         IXg1400dONRB1/mj5uUtPVQyJlteyAWL/7RE2bM1KpJerwKhfvYmP3UYtCrRWuoTE/bL
         elCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=XuFydx7OD0/JDAO1gav++4QQIoj35zuMHGhG85et998=;
        b=EOERbwWR9moQGEc0+j9cyWBLqrvvt19n79zKywRepL1SW+bd1uS5ERgyZFAGjVSkVO
         86fTpTIbga87VHxnTvZzK6zG02By8RlZ0ZyGeOn26v67HqhNPRT4vr4/mg86iTv1F83k
         OxyRKCkM9ZIJJv1JRCgj2GSMrOIr4+MD+thNFuE+dl8O+ULCN8U+kkEZblDhqd0kI8rB
         ye0aNSMW2PmgjYJ94PW3APNS9y0ZbK7YK071Gn79M4soft9GuPGfD4YnzIbH6TNzJHCO
         M66ulPG9hggX1eCncvUhEpT4njXLa8WA7BYT2rHmhJqu/hhJjtOAv8CPSAKIrm0bj41h
         ItSg==
X-Gm-Message-State: AMke39kiFfqMsMcUmGK/NtwIW+5WBGw9kp/gqBMUtJTRuQ/kI+ggwzlYgHL92sPQ0S5TQb3SMvtjROOpRPiNYA==
X-Received: by 10.28.203.204 with SMTP id b195mr4669548wmg.51.1488571989218;
 Fri, 03 Mar 2017 12:13:09 -0800 (PST)
MIME-Version: 1.0
Received: by 10.28.126.201 with HTTP; Fri, 3 Mar 2017 12:13:08 -0800 (PST)
In-Reply-To: <xmqqtw7a89dg.fsf@gitster.mtv.corp.google.com>
References: <0102015a93d18443-c574aaf8-5656-49e8-8848-810e1fadc87a-000000@eu-west-1.amazonses.com>
 <a9273d37-388a-8c27-1cf1-51e9cb28ef55@xiplink.com> <xmqqtw7a89dg.fsf@gitster.mtv.corp.google.com>
From:   Sebastian Schuberth <sschuberth@gmail.com>
Date:   Fri, 3 Mar 2017 21:13:08 +0100
Message-ID: <CAHGBnuP8X3xOOwfkUrbnF8E9zPwkSGq2y0oQpdLZt-NTpGMuLg@mail.gmail.com>
Subject: Re: [PATCH] Do not require Python for the git-remote-{bzr,hg}
 placeholder scripts
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Marc Branchaud <marcnarc@xiplink.com>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Mar 3, 2017 at 8:10 PM, Junio C Hamano <gitster@pobox.com> wrote:

>> Just a niggle:  This change moves the warning message from stderr to stdout.
>
> Right.  Here is what I'll queue.

Indeed, thanks for the note, and also Junio for fixing while queuing.

-- 
Sebastian Schuberth
