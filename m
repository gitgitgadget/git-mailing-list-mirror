Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 35CB220248
	for <e@80x24.org>; Wed, 27 Mar 2019 10:49:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729489AbfC0Ktk (ORCPT <rfc822;e@80x24.org>);
        Wed, 27 Mar 2019 06:49:40 -0400
Received: from mail-wr1-f42.google.com ([209.85.221.42]:44374 "EHLO
        mail-wr1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726241AbfC0Ktk (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Mar 2019 06:49:40 -0400
Received: by mail-wr1-f42.google.com with SMTP id y7so13822205wrn.11
        for <git@vger.kernel.org>; Wed, 27 Mar 2019 03:49:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=egnt6oVXEZNMn0Dt2wlm88/qQTZbyS44pUl4H82741s=;
        b=K2LOC4eaUQzVsyvrNevuKTMNgWwTEDcrnT1R5XKCNa4mZw8esM7WRse2ra1Tj2jnY7
         /fGabtw/2H2Hq05DWb5NLtu3a740ZlRyZSiaBbi96pj3nOtFw4gnNWORvrNcrrU0bCC6
         ju008hpMYWupyxYX5/uNTizhYFKCkxRuj/bQJLoPz8uSe9kHB+dhL/NY+mGJCBPYAm+A
         RaWWNCwTGLIi05WNQb25arUoaRF/aJW0tEPPuz7ZjSla2TpZ0qaVuqDfe+2NuN3L0Kgm
         ZvRWmscfyZfWl21M/5MtCgRu14tIn6hxOBYc5J7ipVgx4SNcXlTK/hOSMhDorHY15ekq
         3egg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=egnt6oVXEZNMn0Dt2wlm88/qQTZbyS44pUl4H82741s=;
        b=TuvxHSGQzno1BnVQyDqJESBrkBHaktvyUI8q9ZCqBs3JpHvDsaDfNXbzoMLGgGbOs4
         CWKBvyeiUZq47edO+XzWYT9Gzxc/U2+x48ZKSIgnksa5y/rGyvNKh1gePynjYjV0ysHp
         NRRcsl3PPL9OspShFDw0RryHqelJAMN1Vl7peo+NFGMDsEFLAE9YoiHGdz0JyhIi2/h9
         Vw1GK8yGA8bIACX6mo8LGaRJLz50deAyWd1BfPo1u7Dx+JbgWYrYPI/CbjP65KNsc2Mf
         YeNDKtXB5PlRWgyVdX2fyHoEXZND8qb4Z135B+8gHp/DyKnkzHAFOaTs8l2csKTD5dYL
         RErw==
X-Gm-Message-State: APjAAAV4kFBIz6AYwIPwjkUP9oJc8YQrdGMsKsxZVSKT/Lwcfy52Ypxj
        wNzVUY7F1VHH1eIyntaIE9wueFxp
X-Google-Smtp-Source: APXvYqxR3XuHrrxevU9MJDcdCUVwyFjpPZFqsi/aQy+OyHsTTCHFHmGxEfxihV0aXaLQA6D3ULCVDg==
X-Received: by 2002:adf:f80c:: with SMTP id s12mr23930039wrp.72.1553683778642;
        Wed, 27 Mar 2019 03:49:38 -0700 (PDT)
Received: from szeder.dev (x4d0c7b09.dyn.telefonica.de. [77.12.123.9])
        by smtp.gmail.com with ESMTPSA id k9sm25763077wru.55.2019.03.27.03.49.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 27 Mar 2019 03:49:37 -0700 (PDT)
Date:   Wed, 27 Mar 2019 11:49:35 +0100
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Elijah Newren <newren@gmail.com>, Mooga <contact@m-mooga.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: [GSoC] microporject test_path_is_*
Message-ID: <20190327104935.GD32732@szeder.dev>
References: <38B8E527-2338-485E-8840-29121F259687@m-mooga.com>
 <CABPp-BHwUoqk79Kf=ynna5x+mCJyOLz66v6pDieyEeM7YCRS+g@mail.gmail.com>
 <877eckbpdd.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <877eckbpdd.fsf@evledraar.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Mar 27, 2019 at 11:09:18AM +0100, Ævar Arnfjörð Bjarmason wrote:
> > There are likewise several that use one of
> >    ! test -e path/to/filename
> > or
> >    ! test -f path/to/filename
> > or
> >   test ! -f path/to/filename
> > which could be replaced by
> >   test_path_is_missing path/to/filename
> 
> Interesting that for some we use the 'test_is_there/test_is_not_there'
> pattern and for others 'test_is_there [!]'. E.g
> test_path_exist/test_path_is_missing v.s. test_i18ngrep.

It's unclear what the '!' should negate in case of 'test_path_is_file
! file'.  What if 'file' does exists, but it's not a file but a
directory, socket, fifo, or symlink?  'test ! -f file' returns success
in these cases as well.

OTOH, it's quite clear what the negation should mean in case of
'test_i18ngrep'.

