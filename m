Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 090C41F404
	for <e@80x24.org>; Fri, 14 Sep 2018 21:09:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728247AbeIOCZw (ORCPT <rfc822;e@80x24.org>);
        Fri, 14 Sep 2018 22:25:52 -0400
Received: from sender-of-o53.zoho.com ([135.84.80.218]:21806 "EHLO
        sender-of-o53.zoho.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728050AbeIOCZv (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Sep 2018 22:25:51 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1536959378; cv=none; 
        d=zoho.com; s=zohoarc; 
        b=nrdJQLjVlIV9AtmnG/v1nUlXOf29RR2HLPnwYgLTuYupeN2AdXsXV3uqKixM+7hqTdaczEmTqRbsIvJrwbUdwYnN2uq7lFGWis3diRAdVdCmOiU/Tai3C2MZArhjTQMJmo9dNyjPsakUjESjTR1fYkzQ5PvTJ+RewkrowqOTQ7w=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zoho.com; s=zohoarc; 
        t=1536959378; h=Content-Type:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To:ARC-Authentication-Results; 
        bh=wKL7YORHGIpEZp8JhxGTW5P+HSDDODxdD3QJxkyGPYA=; 
        b=fNhoZBThkxSbchWd79SU9ZwefWHlc/NkC+AKVSaD++YCn2vkC2cpP9rVxUw/pX4tXRbkLTPnwwqX5Pll89mQ4mEQaIt1YZxURGaHMQu1gb/ENM1nj3zk8G4je2rIXGr/jb2FMOlhUDJDRVX/Ydt85R7qXPmlmMiva+H9Dnkn558=
ARC-Authentication-Results: i=1; mx.zoho.com;
        dkim=pass  header.i=astrangergravity.com;
        spf=pass  smtp.mailfrom=john@astrangergravity.com;
        dmarc=pass header.from=<john@astrangergravity.com> header.from=<john@astrangergravity.com>
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45]) by mx.zohomail.com
        with SMTPS id 1536959377643226.6837639926316; Fri, 14 Sep 2018 14:09:37 -0700 (PDT)
Received: by mail-lf1-f45.google.com with SMTP id m26-v6so9035259lfb.0
        for <git@vger.kernel.org>; Fri, 14 Sep 2018 14:09:37 -0700 (PDT)
X-Gm-Message-State: APzg51AucaBdLLlnknU7HM5A8S5/7uWF507tTu5WfbL2LiTbEX5HzZg2
        OkmpuksGflg8u34/SyhElCIb3/ypzusymoDHsuo=
X-Google-Smtp-Source: ANB0VdbiiyZZHJR2mhh+sVl8iz7ADG6GGcUm5KOS/ZbgPP8XfiD5VUv6tJW+HXgYqET2LS1C47pVI5i0S+DNSM3f9SI=
X-Received: by 2002:a19:1586:: with SMTP id 6-v6mr3873583lfv.72.1536959375887;
 Fri, 14 Sep 2018 14:09:35 -0700 (PDT)
MIME-Version: 1.0
References: <CA+AhR6fWpzL1ozt2H=y8TaQrgT-6dvkkK_K_P-pXniXT+xcMuQ@mail.gmail.com>
 <20180914190025.GJ55140@syl>
In-Reply-To: <20180914190025.GJ55140@syl>
From:   John Austin <john@astrangergravity.com>
Date:   Fri, 14 Sep 2018 14:09:12 -0700
X-Gmail-Original-Message-ID: <CA+AhR6fH4=VbuMPasbaH9u52Y=tgJJzhgxosPOb3819ivCVJOg@mail.gmail.com>
Message-ID: <CA+AhR6fH4=VbuMPasbaH9u52Y=tgJJzhgxosPOb3819ivCVJOg@mail.gmail.com>
Subject: Re: Git for games working group
To:     me@ttaylorr.com
Cc:     git@vger.kernel.org, sandals@crustytoothpaste.net,
        larsxschneider@gmail.com, pastelmobilesuit@github.com
Content-Type: text/plain; charset="UTF-8"
X-ZohoMailClient: External
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hey Taylor,

Great to have your support! I think LFS has done a great job so far
solving the large file issue. I've been working myself on strategies
for handling binary conflicts, and particularly how to do it in a
git-friendly way (ie. avoiding as much centralization as possible and
playing into the commit/branching model of git). I've got to a loose
design that I like, but it'd be good to get some feedback, as well as
hearing what other game devs would want in a binary conflict system.

- John


On Fri, Sep 14, 2018 at 12:00 PM Taylor Blau <me@ttaylorr.com> wrote:
>
> Hi John,
>
> On Fri, Sep 14, 2018 at 10:55:39AM -0700, John Austin wrote:
> > Is anyone interested in contributing/offering insights? I suspect most
> > folks here are git users as is, but if you know someone stuck on
> > Perforce, I'd love to chat with them!
>
> I'm thrilled that other folks are interested in this, too. I'm not a
> video game developer myself, but I am the maintainer of Git LFS. If
> there's a capacity in which I could be useful to this group, I'd be more
> than happy to offer myself in that capacity.
>
> I'm cc-ing in brian carlson, Lars Schneider, and Preben Ingvaldsen on
> this email, too, since they all server on the core team of the project.
>
> Thanks,
> Taylor
>

