Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B7BDA1F404
	for <e@80x24.org>; Tue,  6 Feb 2018 18:28:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753074AbeBFS22 (ORCPT <rfc822;e@80x24.org>);
        Tue, 6 Feb 2018 13:28:28 -0500
Received: from mail-it0-f49.google.com ([209.85.214.49]:51043 "EHLO
        mail-it0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753252AbeBFS17 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Feb 2018 13:27:59 -0500
Received: by mail-it0-f49.google.com with SMTP id x128so3688241ite.0
        for <git@vger.kernel.org>; Tue, 06 Feb 2018 10:27:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=kz6jmf2d5S/CZxHZA5s39U3WKlGHoXtYnRNZ3Be3WHc=;
        b=HDRVG8v7J25e7F8Akxltdytg/u6NT3DCY5i/j0qhrPD09vGWLn6t6bvSXppASLba7R
         C3V39eYbxim68vyTnthEvSGcD2RjCZ2stRX20eevDXOlWm+uXsQN0WtMtZpaLXAZVGEk
         Ie4UeJbXd1Vl5Qu+QmE+Eu/bkAkecfPRcLMn5nWWM+v1/ucF7RqCm/24aUhwDGxdg+FM
         87aHk0ggCG6kdd3dnqox5qu6Ka/HNWOcqAKlStK8vlopisMYNVz8X0+0atgur93okFtD
         I2slxhnuWF8tQQ/R6QbyeuEPnrGmFevrLP/HrgGGXDe18JeWStWkkEqlkOYoFgBa4oSn
         PAnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=kz6jmf2d5S/CZxHZA5s39U3WKlGHoXtYnRNZ3Be3WHc=;
        b=YdbDGkF7QkP1kJGF3MkVdDScDIMgtc6pw/dr0S9izN1LmI8C5k6mlZUtIQ/MjTzl/+
         CkOSvtrfrxhLuSNiQsNZ0YM59GR3aMvI2VFjcv3tc7ieiBS19Pdp+KUXhygKvN9MHrJO
         4CazjgDrKXMbt8iZejI2/X94bMTzW54l15Gh40KIdSz6xHO0HKzl+TUaecHsxj3evHy3
         YtkaNxQrPOA6bw/MParZ5AicnDIJKmS4wFRh4rAbDkFLw6tqYX/649C5fzPKxWlPq68j
         JL10Eqc+PGQcp24CK2jvkc/n4bZ3Kr+YwcEAmnUYncGLFyntiJyGP7YPBc31DsymHXRF
         w9iw==
X-Gm-Message-State: APf1xPCMEKDEEpIVcQJ+enyFuIHJjReQxNLikNngv+oTUIDvARSzHB3y
        D39wINSIvL54IH49kIogTP4qSOEQ
X-Google-Smtp-Source: AH8x224fG5prrqmHAgxapyKYneBQtvEdQkAfcoI/tz5DCfxlU7Uy9/7c1kv1HUESlBu9Jxh/nAFaMg==
X-Received: by 10.36.228.200 with SMTP id o191mr4265503ith.143.1517941678460;
        Tue, 06 Feb 2018 10:27:58 -0800 (PST)
Received: from aiede.svl.corp.google.com ([2620:0:100e:422:4187:1d6c:d3d6:9ce6])
        by smtp.gmail.com with ESMTPSA id i22sm7261054ioo.39.2018.02.06.10.27.56
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 06 Feb 2018 10:27:57 -0800 (PST)
Date:   Tue, 6 Feb 2018 10:27:55 -0800
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Martin =?iso-8859-1?Q?H=E4cker?= <mhaecker@schwarz-online.org>
Cc:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        git@vger.kernel.org
Subject: Re: Missing git options
Message-ID: <20180206182755.GD104086@aiede.svl.corp.google.com>
References: <AD196D8E-04DB-4274-ADEB-D914A79628B3@schwarz-online.org>
 <20180206004313.GC7904@genre.crustytoothpaste.net>
 <C6AF93BC-048F-4944-AB87-36AC2A5C5466@schwarz-online.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <C6AF93BC-048F-4944-AB87-36AC2A5C5466@schwarz-online.org>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Martin Häcker wrote:
>> Am 06.02.2018 um 01:43 schrieb brian m. carlson <sandals@crustytoothpaste.net>:

>> I think this is likely to cause problems.  Many people use git log with
>> --pretty to format commit hashes or messages into other programs.  I'm
>> aware of multiple tools that will simply break if --graph or --patch
>> become the default.  Requiring people to retrofit their tools to use
>> --no-graph or --no-patch is likely to be a burden.
>
> While I share your concern, this is something that will completely
> freeze development of the git tui which I cannot imagine is wanted.

On the contrary, we take things on a case by case basis.  Brian
described a cost to your proposed change and you described a benefit;
the next step would be to figure out a way to accomplish what you're
aiming to do in a way that maximizes the benefit and minimizes the
cost.

In other words, it is not that we never change default output formats,
but we do care a lot about helping existing users.  One way of doing
that is to provide more convenient machine-readable versions of some
commands so that it is obvious to script writers what to use.

As Stefan Beller mentioned, "git log" is in interesting case, in that
the scripting commands exist:

 - "git rev-list" to list commits satisfying some criteria
 - "git diff-tree --stdin" to show information about those commits

But these commands were not sufficiently discoverable and easy to use,
so people end up using "git log" for scripting anyway.  We provide

 - "git log --format" to produce log output with a fixed format, and
   in particular

 - "git log --format=raw" to print raw objects

It's perfectly normal and common to change what "git log
--format=medium" (the default format) prints, as long as we take into
account the effect on existing users.  In particular:

 - Some scripts do not care about the *exact* format from "git log"
   but are using the output for a particular purpose (e.g. to generate
   release notes that they distribute along with compiler output).
   If these scripts start _sometimes_ using --graph instead based on
   configuration, this would be disruptive to some users.

 - Making --format suppress `log.graph` configuration feels confusing
   and hard to explain to me.  --graph --format=<x> would mean something
   different from -c log.graph=true --format=<x>, except when <x> =
   medium, or "--format=medium" would mean something different from not
   specifying --format at all even though medium is the default format.

In that context, it feels simpler to me to use aliases:

	[alias]
		l = log --oneline --graph --patch

That way, it does not confuse scripts, and even better, it is easier
to type, as "git l".

I would be happy to see some documentation pointing users to the
alias feature for this purpose.

As an example of changing the default "git log" format, see the
history in "git log --grep=decorate".  I am all for that kind of
change, but I don't think --graph or --patch falls into this category.

Thanks and hope that helps,
Jonathan
