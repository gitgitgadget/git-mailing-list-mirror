Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AA914202A0
	for <e@80x24.org>; Thu, 16 Nov 2017 20:46:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935042AbdKPUqw convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Thu, 16 Nov 2017 15:46:52 -0500
Received: from ikke.info ([178.21.113.177]:40968 "EHLO vps892.directvps.nl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934240AbdKPUqj (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Nov 2017 15:46:39 -0500
Received: from mail-it0-f41.google.com (mail-it0-f41.google.com [209.85.214.41])
        by vps892.directvps.nl (Postfix) with ESMTPSA id 7FBBE44038F
        for <git@vger.kernel.org>; Thu, 16 Nov 2017 21:46:37 +0100 (CET)
Received: by mail-it0-f41.google.com with SMTP id n134so1623517itg.3
        for <git@vger.kernel.org>; Thu, 16 Nov 2017 12:46:37 -0800 (PST)
X-Gm-Message-State: AJaThX6RobaEaJQqRmqnU1kge3CpLsHzo10wAb+3bDnP1uPdon5S6L03
        8VEPuhYNF6PAfndl4qYDEp/TSb4YRuwHFivt2ao=
X-Google-Smtp-Source: AGs4zMZMN9IlkMT62lKgmPGnNSqEkz+8xM2503apCFq+ENy6Tsc5NhvHmXlHIVyPTOmh8AdA4GTV+0q5ErISgxfE3gU=
X-Received: by 10.36.124.197 with SMTP id a188mr3763536itd.63.1510865196349;
 Thu, 16 Nov 2017 12:46:36 -0800 (PST)
MIME-Version: 1.0
Received: by 10.2.183.19 with HTTP; Thu, 16 Nov 2017 12:46:15 -0800 (PST)
In-Reply-To: <831D8663-01D7-4F08-9EFA-8752C85DD695@burkitt.com>
References: <CAHY2EeuCUh3bzdZxtmvC3H=j=QchLgvkuHaW_KWcVsD=-fJUFw@mail.gmail.com>
 <20171116203442.GA16181@alpha.vpn.ikke.info> <831D8663-01D7-4F08-9EFA-8752C85DD695@burkitt.com>
From:   Kevin <me@ikke.info>
Date:   Thu, 16 Nov 2017 21:46:15 +0100
X-Gmail-Original-Message-ID: <CAO54GHBz-Bxqa9J5_BiGOCtitXHHgmefUvJQUmBRxkwFmyN7eA@mail.gmail.com>
Message-ID: <CAO54GHBz-Bxqa9J5_BiGOCtitXHHgmefUvJQUmBRxkwFmyN7eA@mail.gmail.com>
Subject: Re: Git on Mac - Segmentation fault:11
To:     fburkitt@burkitt.com
Cc:     git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

cc: mailinglist

On Thu, Nov 16, 2017 at 9:40 PM, Frank Burkitt <fburkitt@burkitt.com> wrote:
> Kevin -
>
> Thank you for getting back to me.
>
> The version of Git is 2.15.0
> I used Brew to install it
> I am not getting any segfaults from other apps
> When I do a ‘git init’ I get a Segmentation fault: 11 whether I do it in or
> outside of a virtualenv
>
> Is there any additional info that would help?
>
> Frank
>
>
> Frank Burkitt
> Mobile: 307-699-1321
> Email: fburkitt@burkitt.com
>
>
> "If you can't explain it simply, you don't understand it well enough" -
> Albert Einstein
>
>
>
>
>
> On Nov 16, 2017, at 1:34 PM, Kevin Daudt <me@ikke.info> wrote:
>
> On Wed, Nov 15, 2017 at 05:30:23PM -0700, Frank Burkitt wrote:
>
> I am using Git on a Macbook pro with MacOS High Sierra version 10.13.1
> (17B48).  I have been using it in a virtualenv with python 3.  I have
> begun to get "Segmentation fault: 11" with every git command.  I have
> been searching for a reason why this is occurring but have not been
> able to find a solution.  I have reinstalled the operating system,
> uninstalled and reinstalled Git, and a variety of other attempts at
> finding a solution.  Is this a know issue? Any suggestions would be
> appreciated.
>
>
> Hello Frank,
>
> Could you provide a bit more information?
>
> - What version of git are you using?
> - how did you install git,
> - Do you also get segfaults outside of the virtualenv?
>
> This sounds perhaps like it's a copattibility issue with a library.
>
> Kind regards, Kevin.
>
>
