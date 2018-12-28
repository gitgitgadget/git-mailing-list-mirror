Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D154A1F45B
	for <e@80x24.org>; Fri, 28 Dec 2018 08:46:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727814AbeL1IqY (ORCPT <rfc822;e@80x24.org>);
        Fri, 28 Dec 2018 03:46:24 -0500
Received: from mail-ed1-f66.google.com ([209.85.208.66]:46052 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726700AbeL1IqX (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 Dec 2018 03:46:23 -0500
Received: by mail-ed1-f66.google.com with SMTP id d39so16976231edb.12
        for <git@vger.kernel.org>; Fri, 28 Dec 2018 00:46:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=rJHiB81GdxaK7zOeRY//Trze8fvg6ttIHAPtPPhelC0=;
        b=jXht44LgoBptf2tWOaWIBE6nXY59G+jHc1QDK132K68YuzTMsFDbuGnxbK3WfnsoT6
         TBKk4Irq11FgU9soNt0Nt8+jaGSOaSRO+jJY7YpPXmixUTcfRmuVJ1EN2fPY+DBK4Ulu
         9aohkYQBC47mT2hzO4mPAuybKbBoGAIQqsfcrOW8ckUYwVqrwVYoooxc1OOC+CxAO3f5
         n90JI0SRobXn9Pd00fn0HRcN3gg81nCsLsPnyWdNTfhP5HCWqLfd0QbpM/yf/ffWxtgA
         ZkAnMhez3U19ylAZt88QH2lrZ+Wx1tDR/lEAYBuLAexayjkcL3lFeJDzS0nbeW3dPGu7
         WKeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=rJHiB81GdxaK7zOeRY//Trze8fvg6ttIHAPtPPhelC0=;
        b=Xa0yU+dG6/BJYGUqc/CMS7IwFzN3/cRolItxrXw5kUpBF8cZTjyYsHCIz60NVW9nqS
         POVmmZp6CYywnCxeSM/6zprJXLxCZQpsb0tselV1I2sHpYZepUtLQttyqo7znKnFZSeM
         e9SHBHjg0P79Ctuou26WeerVqt7lArffhAAAWQD8ojUpDN8ECk4Mu6QNZNvfT9YhGdax
         qh/Vjvx/esqBo0RAPUI13nZjzUP1S9SVVG2B+nqd6NzfIXKqMyGmSu8XN1IDRbk2+g4g
         H1uzFACJwjrlyRgwwu5KfZZ+hqn2z2AWB0bjBEM7jMIeFS09ESpOuPHkUfG7BMgis3pr
         At7A==
X-Gm-Message-State: AA+aEWYTE+Zg8X7ld86J0rd66tskvl7sI3ohF4bFRUlGHe6hquyf3K7W
        JS2TX6/Wbx01Tmax+Tr4v70=
X-Google-Smtp-Source: AFSGD/WVLr4yxlskBG7/0NANlj3OuSkOsBnNxWTBDL6sJ2N6bWiTuhqPx6jlD9wb3mrQ9fSdAgql2g==
X-Received: by 2002:a50:fb03:: with SMTP id d3mr20835349edq.183.1545986782070;
        Fri, 28 Dec 2018 00:46:22 -0800 (PST)
Received: from evledraar (i40217.upc-i.chello.nl. [62.195.40.217])
        by smtp.gmail.com with ESMTPSA id m44sm11969330edm.54.2018.12.28.00.46.21
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 28 Dec 2018 00:46:21 -0800 (PST)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     git@vger.kernel.org, Lars Schneider <larsxschneider@gmail.com>,
        Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>
Subject: Re: [PATCH 0/2] Improve documentation on UTF-16
References: <20181227021734.528629-1-sandals@crustytoothpaste.net>
User-agent: Debian GNU/Linux buster/sid; Emacs 25.2.2; mu4e 1.1.0
In-reply-to: <20181227021734.528629-1-sandals@crustytoothpaste.net>
Date:   Fri, 28 Dec 2018 09:46:18 +0100
Message-ID: <87lg4adoo5.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Dec 27 2018, brian m. carlson wrote:

> We've recently fielded several reports from unhappy Windows users about
> our handling of UTF-16, UTF-16LE, and UTF-16BE, none of which seem to be
> suitable for certain Windows programs.

Just for context, is "we" here $DAYJOB or a reference to some previous
ML thread(s) on this list, or something else?
