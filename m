Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4A76E1F403
	for <e@80x24.org>; Wed,  6 Jun 2018 11:08:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750896AbeFFLIo (ORCPT <rfc822;e@80x24.org>);
        Wed, 6 Jun 2018 07:08:44 -0400
Received: from mail-wm0-f50.google.com ([74.125.82.50]:54688 "EHLO
        mail-wm0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750785AbeFFLIn (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Jun 2018 07:08:43 -0400
Received: by mail-wm0-f50.google.com with SMTP id o13-v6so10681531wmf.4
        for <git@vger.kernel.org>; Wed, 06 Jun 2018 04:08:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=kIYy+dVo+wboPObuGBuyfGcFTVewgi2eAFLWrjA8YkI=;
        b=tfAzRiYCCZqnTDBqjmcSfe42BKtm+ZwhzAApq+ZibiV7QuiOI/WUqwrNEXksRC+iqR
         xGh4dNKs6mlZJLgyz80aEK4AY229tczzlp5DyN00zCBX/BXdy+h+RN6w+MtyYLedevm3
         qc93RtAw6wPEDEiNLU+jVue/gka+UFwwNLgrsrbgGyxbuGZerxsw7Lw8m9VReGg5zbve
         JV4fT2df1nCxyzzEdCHeCdyZWPNanfedYYEmVJA1iw5BXYEv0EoSA2y+m3x6N9S2Gk6I
         Cx85sFDLWBNoJDh/wKfvg+OfdA0qqeLh4Duo/aSNWFjYhmoBicZ9xWmhjfqH6XHpvjzN
         od5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=kIYy+dVo+wboPObuGBuyfGcFTVewgi2eAFLWrjA8YkI=;
        b=tzkWqzPUG6+gQTrmNkB95J2ro9SP6k2SeMcSWL1b23qUObOAy7GX3riVSUZ7itDWnf
         FL/vZhSZgTjpJ8BfoTsPnIm8WqNM/6Y3VB8XXbpDlxGvAnmc8EKqmImVjgl6GejkNfN0
         07v5Py2pbeDVxcpARnwDaGIIRBn/b1FWj2GvEFYUWyoM43GrPAJ5jrHDTOpAAlWnvAyS
         L6fkhflf2Ue6iJqBeWev+IFPb4XrzpvC+PSTC2StN4hurOFPutnLA63Nk6YXpp9MtT9j
         uV6YnxYEjkn30JlwSl5wdW1aa37i4P8m/ZYkkvbqm1zBKlZmukwZrzNSt4vROxeXjSws
         DMZg==
X-Gm-Message-State: APt69E2iXZnvEPhBc6rRfF7UJOZUz9OOLXjLEAGyc41G1lWYUs5SvtCe
        DbwXIV4GlF1SE0Gcvlkeq+4=
X-Google-Smtp-Source: ADUXVKKVJY9ocD++xbaSbewcWtXgpYfan0LRos6fi5P8kucnJhcKqNHKImkv4pJRbDvCiXfGyqYxcA==
X-Received: by 2002:a50:b1cb:: with SMTP id n11-v6mr3221237edd.197.1528283322101;
        Wed, 06 Jun 2018 04:08:42 -0700 (PDT)
Received: from evledraar (proxy-gw-a.booking.com. [5.57.21.8])
        by smtp.gmail.com with ESMTPSA id j16-v6sm6955018edp.22.2018.06.06.04.08.40
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 06 Jun 2018 04:08:41 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Derrick Stolee <dstolee@microsoft.com>
Cc:     "git\@vger.kernel.org" <git@vger.kernel.org>,
        "stolee\@gmail.com" <stolee@gmail.com>,
        "jnareb\@gmail.com" <jnareb@gmail.com>,
        "marten.agren\@gmail.com" <marten.agren@gmail.com>,
        "gitster\@pobox.com" <gitster@pobox.com>
Subject: Re: [PATCH v4 17/21] fsck: verify commit-graph
References: <20180604165200.29261-1-dstolee@microsoft.com> <20180604165200.29261-18-dstolee@microsoft.com>
User-agent: Debian GNU/Linux testing (buster); Emacs 25.2.2; mu4e 1.1.0
In-reply-to: <20180604165200.29261-18-dstolee@microsoft.com>
Date:   Wed, 06 Jun 2018 13:08:40 +0200
Message-ID: <87k1rcyxxj.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Jun 04 2018, Derrick Stolee wrote:

> +		prepare_alt_odb();
> +		for (alt = alt_odb_list; alt; alt = alt->next) {
> +			verify_argv[2] = "--object-dir";
> +			verify_argv[3] = alt->path;
> +			if (run_command(&commit_graph_verify))
> +				errors_found |= ERROR_COMMIT_GRAPH;
> +		}
> +	}
> +

This doesn't compile under clang on master. It needs to account for
0b20903405 ("sha1_file: add repository argument to prepare_alt_odb",
2018-03-23).

    builtin/fsck.c:837:19: error: too few arguments to function call, single argument 'r' was not specified
                    prepare_alt_odb();
                    ~~~~~~~~~~~~~~~ ^

Ditto this error due to a missing resolution with 031dc927f4
("object-store: move alt_odb_list and alt_odb_tail to object store",
2018-03-23):

    builtin/fsck.c:838:14: error: use of undeclared identifier 'alt_odb_list'
                for (alt = alt_odb_list; alt; alt = alt->next) {
