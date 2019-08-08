Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5918B1F731
	for <e@80x24.org>; Thu,  8 Aug 2019 21:30:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390445AbfHHVaJ (ORCPT <rfc822;e@80x24.org>);
        Thu, 8 Aug 2019 17:30:09 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:41971 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390411AbfHHVaI (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Aug 2019 17:30:08 -0400
Received: by mail-wr1-f68.google.com with SMTP id c2so93073990wrm.8
        for <git@vger.kernel.org>; Thu, 08 Aug 2019 14:30:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=goCsHvy862ASuc01FWR0SaB195syqrJX8TSXMx4vDuA=;
        b=OT7SGlXpeyw3xpiVP7o9yvYH2U3WR5Y1QCKjs+UvNp+XPd4QPMBO92ik7vNmM/2RJ6
         uphQD+/+Q+3/AUkWrSQWRpqYnY0ItZ8VF9NYfBS5r7phv3onjm4nUvoSWHr0+gYLaDBX
         jKooREUwLZTZxlSCmfwUBxb9wxsDLDpb0EbYVXZZsZZ2gOtWdsDz4YVL4Qq64SzWsbqW
         GTJs6JtvFUZ0IEZXEG9k03DyPf8ng6qNogLG1HVul5eTRrXNYzjGvWeG4i/DyTv0vMN0
         6Z4vLFi4/+bEWzdSzjaMiczF3yag4VJ+pBUgHhhjVC7tHfwRnX2ol2Yv6CqTi4nRyr0g
         r7HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=goCsHvy862ASuc01FWR0SaB195syqrJX8TSXMx4vDuA=;
        b=i4s9JMHJT2AkIFKizP5rp8dkaQrhP9hzpPntv1b2tQkVQ1N7jvYbPG1RWTutOP00QC
         xFGRMpVxjMQp8s9+fqeaETBJ47dx6+tWWfNOrzIlIr4dWXWciK/g98fTFgxRpVbm9eb4
         5mMK+7bfnBnd07hrTyUrGQ9KFBmu3IyMrAB2jT9ho5kQWQZeXFp4bN2VM+EMU5On/Hp/
         UEVTYbcMNIQ7J5H/53CJCFcTXaMwg8q/ansIQO5kBdBYGMPnQvpls/AY7YACk19TGgrj
         CuU3EUpQsudgf5SAqyvj6Vt/zXG5vPLjjBn9ULjnwhmVMWLsbAsK7fJEFS0kZnGkHvq9
         XORw==
X-Gm-Message-State: APjAAAWwDcDbLUh88f5h9JpifWc33zzPD+EkPDDCmbvg2HN5zvenGNdy
        SbFwETNdKqSUWZBYN5blTv8=
X-Google-Smtp-Source: APXvYqzz6HwHexyECJtYY04wVvKU8SkGGEcbrXjov8cVbzkHDaf3Zab6PXR4uus14mpDCuQyeAlJsQ==
X-Received: by 2002:adf:f088:: with SMTP id n8mr19600073wro.58.1565299805399;
        Thu, 08 Aug 2019 14:30:05 -0700 (PDT)
Received: from szeder.dev (x4db35692.dyn.telefonica.de. [77.179.86.146])
        by smtp.gmail.com with ESMTPSA id t185sm3166987wma.11.2019.08.08.14.30.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 08 Aug 2019 14:30:04 -0700 (PDT)
Date:   Thu, 8 Aug 2019 23:30:02 +0200
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     jim.cromie@gmail.com
Cc:     git@vger.kernel.org
Subject: Re: $> git branch splat response considered harmful
Message-ID: <20190808213002.GI20404@szeder.dev>
References: <CAJfuBxx5R28cjUj1v+mB4J+uUpbTMWnYowrCc=iOAbOcqWX-_w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAJfuBxx5R28cjUj1v+mB4J+uUpbTMWnYowrCc=iOAbOcqWX-_w@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Aug 08, 2019 at 03:08:06PM -0600, jim.cromie@gmail.com wrote:
> fwiw,
> 
> jimc@frodo:~/prj-1/capnproto.git$ git branch -l
> * master
> 
> I find the splat in the response unhelpful
> when wrapped in shell for loop, the splat expands into everything in
> current directory
> 
> jimc@frodo:~/prj-1/capnproto.git$ for b in `git branch -l`; do echo $b; done
> appveyor.yml
> c++
> CMakeLists.txt
> CONTRIBUTORS
> ...
> 
> it would be nice if some flag combo would suppress that splat.
> save me from fugly brittle sh $IFS fiddlery and incomplete workarounds

'git branch' is not intended for scripting, try 'git for-each-ref'
instead.  The equivalent command should be:

  git for-each-ref --format='%(refname:strip=2)' refs/heads/

> also, I found no mention of the splat in the man page.

It's in the first sentence of the description :)

  If --list is given, or if there are no non-option arguments, existing
  branches are listed; the current branch will be highlighted in green
  and marked with an asterisk.

