Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9C2962018D
	for <e@80x24.org>; Wed, 10 May 2017 00:38:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750986AbdEJAi2 (ORCPT <rfc822;e@80x24.org>);
        Tue, 9 May 2017 20:38:28 -0400
Received: from mail-pf0-f195.google.com ([209.85.192.195]:35721 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750780AbdEJAi1 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 May 2017 20:38:27 -0400
Received: by mail-pf0-f195.google.com with SMTP id u26so1819222pfd.2;
        Tue, 09 May 2017 17:38:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Trejml7wmnM+d/InyieqBSptPjCpGpyj6D6KZsvdAj4=;
        b=Heq+mhRjXbNdtDk7p6GPYt6T0zswDzEF/7DrWzF+mozhNu7X3WcV/hIb69coI9B0zI
         DdpsD+EpGv7daUgwaISZGAQGQ4Dsw4/AN1S/ihgOqlgdFRLgehiOObKc4xrOkCdEMbp6
         3HYuCWLd+vaorT8vW7TPLmbMTzYtEPvCJeT6T5jkRAyQzCZMX2tFZsXNZhfasXJ9coDv
         LsyDLFSDVzhBSRR6aYPcaANe2P+FklhjfmDHg64ZtyAeirrXBfNZFhj6t8UsZWeYnKQL
         Vqz0j5fPn/yf19KqKrLLY/bGeukh4dH8Iq1oaAN1fZCfcFtGr9StLhok7Pa6fnS6b17e
         mCEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Trejml7wmnM+d/InyieqBSptPjCpGpyj6D6KZsvdAj4=;
        b=Guk7hbnHpEUnByacKirp4LXHL3IrX/6DirXgXkmhUs9fQVg3fvZrm69eSjJK2ge1E8
         6NSHuWX/r/tDbBiELH3hoV/mQWjIyaHnx8V1eEPz6zRHHFnVbeSBNL3DsCS1+sWHOy/8
         k5MKQ5GkYD3pSHHuiAkqrrgF1E4dfPoe60wI2BRN7oUt/ljb9QZtYxsK6NevETQRM84Y
         neQUl7Ojv/0AsoR9BbHm/aremWSQz0IIsygrtzzhyDL7+qEDoDk0aOpW9Sucrkv/IFWi
         RnhVt3lpwljOWmrXRLNQ/U2Q07ZJb0noble/8yGAfwNspuBY6+EVrVyiPZO4gsZ16QN3
         yoUg==
X-Gm-Message-State: AODbwcBtbASpoZOIBU/GcRF59zogn3EFeysUM92OjYOkpCDZPX2s1HtT
        63IIQ5tnuM695g==
X-Received: by 10.84.174.197 with SMTP id r63mr4127907plb.67.1494376706197;
        Tue, 09 May 2017 17:38:26 -0700 (PDT)
Received: from aiede.svl.corp.google.com ([2620:0:100e:422:f544:5084:1b3:b1c1])
        by smtp.gmail.com with ESMTPSA id x198sm1792788pgx.28.2017.05.09.17.38.25
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 09 May 2017 17:38:25 -0700 (PDT)
Date:   Tue, 9 May 2017 17:38:23 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Linux Kernel <linux-kernel@vger.kernel.org>,
        Timo Schmid <tschmid@ernw.de>
Subject: Re: [ANNOUNCE] Git v2.12.3 and others
Message-ID: <20170510003823.GT28740@aiede.svl.corp.google.com>
References: <xmqq8tm5ziat.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqq8tm5ziat.fsf@gitster.mtv.corp.google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano wrote:

> Maintenance releases Git v2.4.12, v2.5.6, v2.6.7, v2.7.5, v2.8.5,
> v2.9.4, v2.10.3, v2.11.2, and v2.12.3 have been tagged and are now
> available at the usual places.
>
> These are primarily to fix a recently disclosed problem with "git
> shell", which may allow a user who comes over SSH to run an
> interactive pager by causing it to spawn "git upload-pack --help"
> (CVE-2017-8386).  Some (like v2.12.3) have other fixes that have
> been accumulating included as well.
>
> "git-shell" is a restricted login shell that can be used on a server
> to prevent SSH clients from running any programs except those needed
> for git fetches and pushes. If you are not running a server, or if
> your server has not been explicitly configured to use git-shell as a
> login shell, you are not affected.  Also note that sites running "git
> shell" behind gitolite are NOT vulnerable.

Thanks.  Credit for discovering this bug goes to Timo Schmid, ERNW GmbH.
They will probably have a blog post soon with more details.

1.6.1 is the earliest git version affected (so this goes back pretty
far).

> The tarballs are found at:
>
>     https://www.kernel.org/pub/software/scm/git/
>
> The following public repositories all have a copy of these tags:
>
>   url = https://kernel.googlesource.com/pub/scm/git/git
>   url = git://repo.or.cz/alt-git.git
>   url = git://git.sourceforge.jp/gitroot/git-core/git.git
>   url = git://git-core.git.sourceforge.net/gitroot/git-core/git-core
>   url = https://github.com/gitster/git

Sincerely,
Jonathan
