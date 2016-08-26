Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DF0361FD99
	for <e@80x24.org>; Fri, 26 Aug 2016 23:47:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754662AbcHZXrk (ORCPT <rfc822;e@80x24.org>);
        Fri, 26 Aug 2016 19:47:40 -0400
Received: from mail-wm0-f46.google.com ([74.125.82.46]:34945 "EHLO
        mail-wm0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753133AbcHZXrj (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 26 Aug 2016 19:47:39 -0400
Received: by mail-wm0-f46.google.com with SMTP id f65so10873453wmi.0
        for <git@vger.kernel.org>; Fri, 26 Aug 2016 16:47:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=PurgpFx05rfGLpICGFn80hRqlvetG1emT08mixBBuoo=;
        b=U4R3BxAg7HAWG1PZiPyF48FQf+KPT+oQb1soCfCJ1lJZrha8SYgWAdxxpTgpGEMDWm
         hrFWPBo7hbxo/7fccihiMgeDCGUgqDwA1Zk+6aUd8nzHSYNQNm+O361/l0A28gcYncyz
         4Fmt/HAUKPjcQbtxi61Evi+qH7yEoWwLNPc02et+pFamYYXdVySxqiTG3Mucun0NqIZ1
         b4U3EIpYrMvLbjyRJK8qWRBvPHG0HHkn4r40lL52Vk//LhNEjSUknYPEuKtmfG92mCim
         oCV0JyHapLpkOSCvzzX7mxCwKB8B1q1gYknbaIHJssfhX0jGb5nVcs55jitZzanWAULi
         2qkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=PurgpFx05rfGLpICGFn80hRqlvetG1emT08mixBBuoo=;
        b=mgVZyRM5JibG/0mKfhWNM2lPaeBSS9Ku9RpaExUfu1bsFJu+HcTL6n46WAQik/bTWL
         kAsUd1FVUukuL1djngIpA/v81drt+fmibsjlFsPXule79RtmZ1ZBvZE/12mf0/9BJdDB
         Rtq+TdjJ52zqlQK98twGGbWHp6MlOQftvBrMkJ50XtQtPEzavlFkC4lvQ92VoKDmiMUe
         RF0kCzBCbX+8NOcRrN9wL8mn0esxabMiu36/rF8djul4t+ix6R98JkVH0eP8PyeavFX8
         6bOFqNgIukkKMLTRAA2rebiCTMhMsOPHwzrCWv/YC2Q2bcM7ZlkxrUyEwI2pSTmKhOSX
         GPxQ==
X-Gm-Message-State: AE9vXwNQTKZ/DUBcnXxwclu7KFedj+9ICn+5AqGgm8k12x2tpeOQ1ATHFezWJoKi61AgPv7b8l49Jb4ke7/rig==
X-Received: by 10.28.51.210 with SMTP id z201mr1040965wmz.98.1472255257455;
 Fri, 26 Aug 2016 16:47:37 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.194.102.70 with HTTP; Fri, 26 Aug 2016 16:46:56 -0700 (PDT)
In-Reply-To: <CAFO0PHfy_teFFMiuFdjKYohCgRZHNT+Cc8hXOjsPeRTi9gAHPQ@mail.gmail.com>
References: <91a2ffbe-a73b-fbb9-96da-9aea4d439e5a@gmail.com>
 <20160826061500.GA22213@dcvr> <6d171c23-65f6-5f67-7d80-051f2dfe8678@gmail.com>
 <CAFO0PHfy_teFFMiuFdjKYohCgRZHNT+Cc8hXOjsPeRTi9gAHPQ@mail.gmail.com>
From:   =?UTF-8?Q?Jakub_Nar=C4=99bski?= <jnareb@gmail.com>
Date:   Sat, 27 Aug 2016 01:46:56 +0200
Message-ID: <CANQwDwf7pWRh1PWizDZ4aFCcppbJCQcHj_qyNs0kCfK4NYddVg@mail.gmail.com>
Subject: Re: [RFC] Proposed questions for "Git User's Survey 2016"
To:     David Bainbridge <david.bainbridge@gmail.com>
Cc:     Eric Wong <e@80x24.org>, git <git@vger.kernel.org>,
        Doug Rathbone <doug@dougrathbone.com>,
        Stefan Beller <sbeller@google.com>,
        Patrick Renaud <patrick.renaud@ericsson.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

[for some reason this email is not yet present on GMane NNTP interface]

On 26 August 2016 at 21:12, David Bainbridge <david.bainbridge@gmail.com> w=
rote:
> Hi Jakub,
>
> This is excellent news!
>
> As when you last performed the survey it would be useful for us to be abl=
e
> to see what the users in our organization (Ericsson) think of Git, and th=
ere
> are many more than when the survey was last performed.
>
> Do any other organizations of any type have this need?

Yes, I will offer separate channels (that can be separately analyzed,
and that you can get anonymous data for specific channel) for every
organization and/or company that want's it (within reason)... this time
with names anonymized from start (unless requested not to).

> As for the questions, it might be useful to have a question related to re=
po
> management systems being used.
> Gerrit
> Kallithea
> Rhodecode
> Atlassian Bitbucket
> GitHub Enterprise
> GitHub.com
> GitLab
> Deveo
> etc.
>
> This is not directly about Git of course but seeing the extent to which
> these are used, and the proportion of users using them might be useful.

This is somewhat present in current version of survey, namely
there is question about *types* of tools (with git repository management,
git hosting tools and code review tools included), and there is free-form
question asking to enumerate tools one uses.  That is, as above, but
more generic, and not multiple choice.

I will think about adding such question.

Regards
--=20
Jakub Nar=C4=99bski
