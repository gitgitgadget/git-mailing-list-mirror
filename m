Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AC66C1F461
	for <e@80x24.org>; Wed, 15 May 2019 11:57:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730587AbfEOLQ5 (ORCPT <rfc822;e@80x24.org>);
        Wed, 15 May 2019 07:16:57 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:37765 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730130AbfEOLQy (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 May 2019 07:16:54 -0400
Received: by mail-pg1-f193.google.com with SMTP id e6so1219662pgc.4
        for <git@vger.kernel.org>; Wed, 15 May 2019 04:16:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=FtDNDnUMFiZqNtkJtjC1bn28DEDaajwprerB/XPL47I=;
        b=i4utq+hApAJdatE18xFj6XJrlEuaFHEw/dz+eTcsQ307zKUL9vCeXEqVy3WwLnLAm6
         BH8me8XNYB+16JvWUFjQJOAXgByaH+2u6d6Pmq2dlxQ0uH/Wu5Z/UVCD/+3eAsvsAKvT
         J2U/kJ+cnUfkjEiwB0pR3TxwrIFFxlq9NsiXVaMHXkcGX6jlHCuOb61oSTzrMy/N6jjC
         qrc2V/S8kHDIN6PvSku7No5yS8JqvUD0cWPbJM2PQLQ5ef7FLWIMl1TFc8EHxpxkQHGs
         m5VNQCoocJeAJFmhdKcTYP8ntEQycbjQCvyQadOHR/Vvijx+LOiTn+o/uLvS4uJ9ouFp
         /qBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=FtDNDnUMFiZqNtkJtjC1bn28DEDaajwprerB/XPL47I=;
        b=NSmtEDzx41dl9q7LXKmlgo0WLpWq3pWMI8q0pLclh95UxL0vFqN/6fXVZO8s7UUpOz
         izX7MrouQjhWHq93FGP6zRcpqJOMFKOy0pwEtLxOYAXQ7pqGfhxzdDT5HPTvxitz6f5J
         mZkC3U7ZU2vczJZsyyKNmtp4jW+qQv1dWkFZ8VDxa/kiPpBLz3BkdKXsWdlqULiw5CYW
         7YRASpl9FLCYbWo2NtUobF2jTMnt/YjWZOjCYVWdqVN/xN56WbFQzqsVP7jRu/KuuTXy
         xX9D0tdpkAuCSLFL0PtaoveeI3Mp3ws6jPG3ZuVE5Nv8ViDeS33rqh2l0vV7PMokBq9X
         2NXQ==
X-Gm-Message-State: APjAAAVHxs/4S4mdZZ5I3Rjr5JM++xcmfx1tHJu/6myZcTday9QbR1xt
        8hpe830/wPDlMiEvBiSJ87Q=
X-Google-Smtp-Source: APXvYqyilWW3SMiN65AVaCsqApBpgHmjJ8qa48PVqTvkGbfE8iITiV04JGuW1qmGbfWw2MM37Y08Bg==
X-Received: by 2002:a63:1316:: with SMTP id i22mr43430351pgl.274.1557919013466;
        Wed, 15 May 2019 04:16:53 -0700 (PDT)
Received: from ash ([115.72.28.243])
        by smtp.gmail.com with ESMTPSA id u1sm2951589pfh.85.2019.05.15.04.16.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 15 May 2019 04:16:52 -0700 (PDT)
Received: by ash (sSMTP sendmail emulation); Wed, 15 May 2019 18:16:48 +0700
Date:   Wed, 15 May 2019 18:16:48 +0700
From:   Duy Nguyen <pclouds@gmail.com>
To:     =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>
Cc:     Poughon Victor <Victor.Poughon@cnes.fr>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: Feedback on git-restore
Message-ID: <20190515111647.GA31209@ash>
References: <3E55146A6A81B44A9CB69CAB65908CEA6B91353C@TW-MBX-P01.cnesnet.ad.cnes.fr>
 <20190515103031.GA29149@ash>
 <87d0kkvv96.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87d0kkvv96.fsf@evledraar.gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, May 15, 2019 at 12:59:17PM +0200, Ævar Arnfjörð Bjarmason wrote:
> One thing that would be really useful (and maybe it even exists, I just
> haven't seen it in the mails) is some abbreviated cheatsheet style doc
> of before/after in the UI. Similar to cheatsheets like e.g.:
> 
>     https://git.wiki.kernel.org/images-git/7/78/Git-svn-cheatsheet.pdf
>     http://unix4admins.blogspot.com/2013/03/unix-commands-comparison-sheet.html
> 
> As far as I can tell the best examples are your changes to
> s/checkout/[reset|switch]/ in various existing docs, that's great, but
> isn't so easy to understand at a glance.

OK the cheatsheet would be like this (I'm dropping "git" prefix to
keep it short)

checkout <branch>          -> switch <branch> (same "dwim" behavior)
checkout <revision>        -> switch --detach <revision>
checkout -b <branch> <rev> -> switch -c <branch> <rev>
checkout <path>            -> restore [--worktree] <path>
checkout <rev> -- <path>   -> restore --source=<rev> --worktree --staged <path>
reset <path>               -> restore --staged <path>
reset <rev> -- <path>      -> restore --source=<rev> --staged <path>
reset --hard               -> restore --source=HEAD --staged --worktree :/
(not available now)        -> restore --source=<rev> [--worktree] <path>

There are other behavior changes to improve things, e.g. --no-overlay
is the default in "git restore". But those can't be shown in a cheatsheet.
--
Duy
