Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9FDE320988
	for <e@80x24.org>; Tue, 18 Oct 2016 20:27:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753749AbcJRU1z (ORCPT <rfc822;e@80x24.org>);
        Tue, 18 Oct 2016 16:27:55 -0400
Received: from mail-pf0-f176.google.com ([209.85.192.176]:36661 "EHLO
        mail-pf0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752265AbcJRU1x (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 Oct 2016 16:27:53 -0400
Received: by mail-pf0-f176.google.com with SMTP id e6so2205244pfk.3
        for <git@vger.kernel.org>; Tue, 18 Oct 2016 13:27:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=5nIYTEYASExCcHF/plmECqoS8tYZtDAoPuNfNlKUIEY=;
        b=XKlokPn+YyfFb2hAK6y0lRGzOJZ6gSmaRit9k0VT6G/Af6CXXzQrsasZ41psEXIJMT
         svuDZXuJx5Q/BLIuTM0qv/ssgUaS2+mdjZzaba/PuhYvO2K7aritiJZPOiPgNV9rdTu9
         R6VqG41AUm3tAA3PCdOZPcdTJS0+FysVkgOi0iTKrYnmBkq+3TTcyIoP4SBizevJ06In
         u9Gb98+xzcQ7C+ns9QQDyvAfoYxaeXw2gwxe0Ks6R9xZLfV9S+nOg9ehI+gkcER7XxpA
         /DBCCJN6VhJOraWkLwi/0XaFydT1rMZhf4DrQIJzMl3VBFHcBqPaKWFItpOHSLsUwa6r
         iMhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=5nIYTEYASExCcHF/plmECqoS8tYZtDAoPuNfNlKUIEY=;
        b=MzbFxD8JmXYRNn+nnL2KUiIY/3HQUirWULIbIqF+rlVJ4q4TQseXAlisdHkqmxKml/
         0Y5XbSwldnPhEQ2cenGVt9Qv3NewAq9XQIeP16vgE9uY11hVoN1RVmXbUF/PiDGpSaWM
         TFUELOXUASxi9ZSSGEVEX14PaLyVFMWDFzs7EDmZbUlVWddwswJ86WuoFFhDHbU+RaFh
         bm/Ej+l1JdgJo6g9B83SqQ6VRckfjTPJlJkUJUf1tXAJyfYvjx+uXA0KjzfO2eXD870j
         J4J3nr+P0iCRBcKDwx+itTb96Y9JmHpYkxrG9rwsYgm8fpnQY64tDRmvef9mCOFqPY4h
         XBfg==
X-Gm-Message-State: AA6/9Rna6zYzimc5JQWEyWeEQdX3PU4uJwBBvSwJWFyJtZv3+lHEhZObQpJteDrOEpXmPQ==
X-Received: by 10.99.117.19 with SMTP id q19mr3134150pgc.162.1476822473160;
        Tue, 18 Oct 2016 13:27:53 -0700 (PDT)
Received: from rem308jnx1.ads.autodesk.com (adsk-nat-ip6.autodesk.com. [132.188.71.6])
        by smtp.gmail.com with ESMTPSA id wd11sm35427678pac.26.2016.10.18.13.27.49
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 18 Oct 2016 13:27:49 -0700 (PDT)
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: What's cooking in git.git (Oct 2016, #04; Mon, 17)
From:   Lars Schneider <larsxschneider@gmail.com>
In-Reply-To: <xmqqtwcasj8y.fsf@gitster.mtv.corp.google.com>
Date:   Tue, 18 Oct 2016 13:27:48 -0700
Cc:     git@vger.kernel.org
Content-Transfer-Encoding: 7bit
Message-Id: <9F780406-FC77-4B3E-AEEB-7F6215E6702C@gmail.com>
References: <xmqqtwcasj8y.fsf@gitster.mtv.corp.google.com>
To:     Junio C Hamano <gitster@pobox.com>
X-Mailer: Apple Mail (2.3124)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


> On 17 Oct 2016, at 15:28, Junio C Hamano <gitster@pobox.com> wrote:
> ...
> 
> * ls/filter-process (2016-10-17) 14 commits
> - contrib/long-running-filter: add long running filter example
> - convert: add filter.<driver>.process option
> - convert: prepare filter.<driver>.process option
> - convert: make apply_filter() adhere to standard Git error handling
> - pkt-line: add functions to read/write flush terminated packet streams
> - pkt-line: add packet_write_gently()
> - pkt-line: add packet_flush_gently()
> - pkt-line: add packet_write_fmt_gently()
> - pkt-line: extract set_packet_header()
> - pkt-line: rename packet_write() to packet_write_fmt()
> - run-command: add clean_on_exit_handler
> - run-command: move check_pipe() from write_or_die to run_command
> - convert: modernize tests
> - convert: quote filter names in error messages
> 
> The smudge/clean filter API expect an external process is spawned
> to filter the contents for each path that has a filter defined.  A
> new type of "process" filter API has been added to allow the first
> request to run the filter for a path to spawn a single process, and
> all filtering need is served by this single process for multiple
> paths, reducing the process creation overhead.

Hi Junio,

what do you think about v11? Do you feel the series is becoming mature
enough for `next`?

Thanks,
Lars
