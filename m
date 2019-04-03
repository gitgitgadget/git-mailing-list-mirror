Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BABE020248
	for <e@80x24.org>; Wed,  3 Apr 2019 08:12:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726724AbfDCIMC (ORCPT <rfc822;e@80x24.org>);
        Wed, 3 Apr 2019 04:12:02 -0400
Received: from mail-it1-f195.google.com ([209.85.166.195]:38966 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726004AbfDCIMC (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 Apr 2019 04:12:02 -0400
Received: by mail-it1-f195.google.com with SMTP id 139so9846783ita.4
        for <git@vger.kernel.org>; Wed, 03 Apr 2019 01:12:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=atlassian-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QxSajtiH8JWjJbAtBbr1cYOs7TEGOhiJN2hrlwr1meM=;
        b=CSD/+w+wmY0TPLb5ANFY7hLrkIim+ByOO5JhOPifbKAuFbrCb9qG2xVutfLu+2rSTO
         EdgKvsCOkKGwPfSDN+K7GwZLP+YDokQur/Kt37poGvaZdBDNKHp24SYJ9Rn0rgrpfWBb
         ZhnzdUNtYfTKEri5JWfG04y+L74h5dam7MA9vEUt475th/kmmXszrsyAjJLJjIZXCkvj
         HGCeO8v6OfezYiLnA+CkhtP/6brgg7TD8I0a4FRLipUyc/6RcU9y76cA2GJ0DLKhyT3z
         O6vuqiRCvoeTsDsevV+g6zWQwY3IMq5FKDofBNLk5dRzRwRp8AGeEjzI7JfNrd8lTxrE
         77Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QxSajtiH8JWjJbAtBbr1cYOs7TEGOhiJN2hrlwr1meM=;
        b=K/fXnDMxYlD/T9vFljw764XtrQpuPFhp1W0/eeQVFKHLAyUMufIBi6PRD3PEOLzxX0
         dgToH5GD+E1J7AlGE84fvBu2gsGtCdJlfy6TMzkqDYqjMwvlpenD6Wi6GTY/c4J2/gpk
         ApoZr4gBTYQireuPvN1PzVY90CAzwS3OuCCFS5fmV+G0OvxKJjJAjotFZQZpf+TFqyFD
         OVuCQuLgi2rhhDr+Cyk1yS5/TBv29OzEDSo/QlA4MMLZyMetVOShO9GRpmcyP3kHDSzU
         xaq8rbD541wqHt2N94UAiyOWE+jUMyIFm+9svqY86ZEtB/AzVkQWasUgVxasNCwFV9W0
         Wyew==
X-Gm-Message-State: APjAAAUfdDKeo0mKeg0b9h57Gtku2swkqFeSRMliMXw6xanwjHll6GKp
        kzqlHynuVak6W7C/8b06B+JY6UsUMIKPovX3exyAMA==
X-Google-Smtp-Source: APXvYqz4tRZ6pwkXTpWVEK7bX2YTX4wgdpLivJQHWtpNETpXsmarCU/IhpnaL5s43Nj6F9Nmx8ZB94QZ8SCgd7m/e84=
X-Received: by 2002:a02:9042:: with SMTP id y2mr45779830jaf.113.1554279121257;
 Wed, 03 Apr 2019 01:12:01 -0700 (PDT)
MIME-Version: 1.0
References: <AM6PR08MB41993844F57794DDF4B33B8F8D570@AM6PR08MB4199.eurprd08.prod.outlook.com>
 <AM6PR08MB4199B076CB886AE814AFF4528D570@AM6PR08MB4199.eurprd08.prod.outlook.com>
 <CAGyf7-HUAoYURDnnp+nq+4EQkysoTE+f_WK8cEVPCHP065rv6A@mail.gmail.com> <AM6PR08MB4199EE3834CBF84D28244D9E8D570@AM6PR08MB4199.eurprd08.prod.outlook.com>
In-Reply-To: <AM6PR08MB4199EE3834CBF84D28244D9E8D570@AM6PR08MB4199.eurprd08.prod.outlook.com>
From:   Bryan Turner <bturner@atlassian.com>
Date:   Wed, 3 Apr 2019 01:11:50 -0700
Message-ID: <CAGyf7-GcrWX-TRP89a1SqKu4h74Mbezq0ifHpS305epfmKxJvw@mail.gmail.com>
Subject: Re: Fw: git describe issue
To:     Amiel Elboim <amielel@matrix.co.il>
Cc:     Git Users <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Apr 3, 2019 at 1:00 AM Amiel Elboim <amielel@matrix.co.il> wrote:
>
> Very helpful!  annotated tag is good solution for us.
>
> However fix of this issue is important, because it's confusing when you want to track on your version using git tags.

Lightweight tags have no metadata to allow for ordering, so I'm not
sure there's something to "fix" here. Given the tags have identical
timestamps, Git simply displays the one that's first alphabetically.

Git does have some ability to parse versions and sort them, on newer
versions, but there's no way to activate that via "git describe
--tags", at least as far as I'm aware (and I'm not sure how reliable
it can be, given tag names are essentially free-form text).

You can try Git's version sorting with a command like "git tag
--sort=-v:refname" (The "-" before "v:refname" sorts in descending
order)

incom@Jael MINGW64 /c/Temp/fourth.git (BARE:master)
$ git tag
v1
v2
incom@Jael MINGW64 /c/Temp/fourth.git (BARE:master)
$ git tag --sort=-v:refname
v2
v1

Since you can't enable that for "git describe --tags", though, I'm not
sure it's helpful. (Someone else can correct me if there is a way to
make "git describe" do that.)

Bryan

(Re-added the list on CC)
