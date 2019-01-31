Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 76DC31F453
	for <e@80x24.org>; Thu, 31 Jan 2019 11:29:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732258AbfAaL3M (ORCPT <rfc822;e@80x24.org>);
        Thu, 31 Jan 2019 06:29:12 -0500
Received: from mail-io1-f67.google.com ([209.85.166.67]:43408 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726221AbfAaL3L (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 31 Jan 2019 06:29:11 -0500
Received: by mail-io1-f67.google.com with SMTP id b23so2309677ios.10
        for <git@vger.kernel.org>; Thu, 31 Jan 2019 03:29:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TT13xjoyXbACYXsvUn4mf9eid5D0jrSdEEVlibVRQIw=;
        b=upWXeJ9cfthEcBrRG1QZ0r60bnZDiDkhf+zedjOLvGivLSMHpg0BV+bIthAo04Thlq
         RSUkCFVlCJh+8PMlNDSSGrKICWptKG/KA8XPS9xHBHXxRuMzSo9jTQ7XMdbCn4UBVYyB
         eY662G7+3W4+84eEo+4KYeXYO2LuIYuDgq55jFNFHSkZkHeSJL23u3i7aop3jrZ+Vhns
         fO5GywIqOBwFRqXdC4Hk1y5CdSfsaSy4k4TccoSzvtazj49C2Ft3mUlz/gG13CNBxgAO
         yK5Z/vv2CLnYJ3V0ssUy2pWgp3cmIPAh2tRnsaEX1V3jEPiqjUfr1MIUnbT+kmmcqPA6
         SA5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TT13xjoyXbACYXsvUn4mf9eid5D0jrSdEEVlibVRQIw=;
        b=oWRMS7+uFL0yfYcHiI19Raby3EZ2tSrFTG7boxICyLJ+krFW8HQSlgIf9SUpqxL9f3
         QBsIkTwZ2zqtFdT4i86LkLn4R+xu/Wi7oVMD2nhIcvhbBq/Lr9c9ERyLcvRf8XUVNu9V
         bK6+Mzu47+aha1AYr4d6a20kwtktX9qOxmCJUUKhbBJw7MUXW0FrnkzSStjixlF4ZMsB
         MG0DyRu9UFl5SoSPNVHoys6SpQeJMrtYD/VV/i7oIa0EAK8WCa4Pxd6cdl58PSQBl60R
         qohoUSfy9nxnTb0Zi1/fgM1RvxOaWqxHPSqum+wDpraNFxiLdQ6y1EZl2gSnjk7o+MlU
         j/Ig==
X-Gm-Message-State: AHQUAuZU/OrtSD81Od5+LMOzVxZxIbMyASPMWwRdRFNjhGPdXCESL6DS
        rIwZhFcQW1QvSlKZ+kW+ifAAIonpB8byDFN4Egc=
X-Google-Smtp-Source: AHgI3IZW9yeL/N95p4QyiKDqUeCsvxlvyjN4BK78LORyqQ83AZM+X04KOvcWJuOK/GV6Y2PTXVt3eZxi/k9tb625E/k=
X-Received: by 2002:a5d:9456:: with SMTP id x22mr16860008ior.282.1548934150962;
 Thu, 31 Jan 2019 03:29:10 -0800 (PST)
MIME-Version: 1.0
References: <20190130094831.10420-1-pclouds@gmail.com> <20190130094831.10420-20-pclouds@gmail.com>
 <CAPig+cRJJtZv0LcchXhV5FFOnbJTVio9Y_R8hyvGJEAGLsJ69A@mail.gmail.com>
In-Reply-To: <CAPig+cRJJtZv0LcchXhV5FFOnbJTVio9Y_R8hyvGJEAGLsJ69A@mail.gmail.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Thu, 31 Jan 2019 18:28:44 +0700
Message-ID: <CACsJy8DEeK7wbDJbk_mVkRjU2rFz7EvRyYRwf8N_8pt+sDKX3w@mail.gmail.com>
Subject: Re: [PATCH 19/19] doc: promote "git switch"
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jan 31, 2019 at 2:39 PM Eric Sunshine <sunshine@sunshineco.com> wrote:
> > diff --git a/builtin/clone.c b/builtin/clone.c
> > @@ -491,7 +491,7 @@ static enum {
> >  static const char junk_leave_repo_msg[] =
> >  N_("Clone succeeded, but checkout failed.\n"
> >     "You can inspect what was checked out with 'git status'\n"
> > -   "and retry the checkout with 'git checkout -f HEAD'\n");
> > +   "and retry the checkout with 'git switch -f HEAD'\n");
>
> Just wondering if these uses of "checkout" and "checked out" need
> adjustment. I don't have any good suggestions, though.

I think I'm going to leave this message alone for now. Technically
"git switch" can replace "git checkout" here but I feel this is more
about restoring files on worktree than switching branches. So when
"git restore" comes, I'll change it to say "git restore --from=HEAD
:/" or something like that instead.
-- 
Duy
