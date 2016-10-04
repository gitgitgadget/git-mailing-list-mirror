Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6749A20986
	for <e@80x24.org>; Tue,  4 Oct 2016 13:07:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752745AbcJDNH3 (ORCPT <rfc822;e@80x24.org>);
        Tue, 4 Oct 2016 09:07:29 -0400
Received: from mail-wm0-f41.google.com ([74.125.82.41]:38192 "EHLO
        mail-wm0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751498AbcJDNH2 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Oct 2016 09:07:28 -0400
Received: by mail-wm0-f41.google.com with SMTP id p138so211210622wmb.1
        for <git@vger.kernel.org>; Tue, 04 Oct 2016 06:07:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=R1za6VOCCJ31ZpOiFAsvu4WVeW+S4OKWVQwKODTmJ1w=;
        b=w9EVdmDhRtdYEA+9L8c5ZsL4f3broA1tLl2PizOWjFaUWnCRNRe94ieIFGjqVJf0Pk
         aLpq2/vZrj/IUGV4WP6f8hZFFWEyIJDm+Kp7yr2Iul+Fi+lBymfLudXJMSxE/pOIR2PU
         NNeM1e6Jk8RK/s7dJw/LopiIiPYp+hncKmqx1gyLMH59t6tLuABGS5cElz6My6LVqNHU
         hFCmcFN3lU1ORaMOIMHW6t87IYfXRzKUAkAjr08qtEjiXdS8szHzYrsO6EOCg58pj+Eu
         Jxzp0k08ZCI29jh2etbRolDq4CYVAIWC96aRqvVhC2YKj1pi3dRN4kmBleXDMdfz38El
         j84g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=R1za6VOCCJ31ZpOiFAsvu4WVeW+S4OKWVQwKODTmJ1w=;
        b=DhSbkK1Y80hgbMMZkZ0kMAiWIOfIOcOGYdROr/UNzjYw+xhc5P8ZYJMSHKPxpZtTO7
         CFUFuBm3UR920KJ34qvosnE47poX3ZZ1mQyaj1uvFJCinPIf83/iMNd2ZGsjrq9I33PI
         iRZHrdHg50uo6UZuVuan6CEwWeRMDHloW6JYsDUhiJxG96d7e51WQTMJY7rKACBqrCSR
         2QoYpeRF2Xk9rFq5KCTyv7CHRhOnU0hDgPWiCL9dDiC3mCXuDnslCt1izKcielek3j3H
         Pp5tEEFOjA9M+peEgDmnd8f7iZ5QWwcaZxybs4Vuu9rV0P2wDEGA7UrYuo7L6pL1GgjU
         3btQ==
X-Gm-Message-State: AA6/9RkNTXvAfEzMplMKwb/7fa38rDYBDj+pNm0TMZ0dZbXtwUWX4RiqAL2L5xTLinFGIA==
X-Received: by 10.28.14.21 with SMTP id 21mr16141185wmo.42.1475586447243;
        Tue, 04 Oct 2016 06:07:27 -0700 (PDT)
Received: from slxbook4.ads.autodesk.com ([62.159.156.210])
        by smtp.gmail.com with ESMTPSA id lz5sm3471199wjb.24.2016.10.04.06.07.26
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 04 Oct 2016 06:07:26 -0700 (PDT)
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: What's cooking in git.git (Oct 2016, #01; Mon, 3)
From:   Lars Schneider <larsxschneider@gmail.com>
In-Reply-To: <xmqqtwct3w0p.fsf@gitster.mtv.corp.google.com>
Date:   Tue, 4 Oct 2016 15:07:25 +0200
Cc:     git@vger.kernel.org
Content-Transfer-Encoding: 7bit
Message-Id: <20E4EE32-135D-49CB-B652-E034D56516E5@gmail.com>
References: <xmqqtwct3w0p.fsf@gitster.mtv.corp.google.com>
To:     Junio C Hamano <gitster@pobox.com>
X-Mailer: Apple Mail (2.3124)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


> On 04 Oct 2016, at 00:31, Junio C Hamano <gitster@pobox.com> wrote:
> 
> 
> * ls/filter-process (2016-09-23) 11 commits
> - convert: add filter.<driver>.process option
> - convert: make apply_filter() adhere to standard Git error handling
> - convert: modernize tests
> - convert: quote filter names in error messages
> - pkt-line: add functions to read/write flush terminated packet streams
> - pkt-line: add packet_write_gently()
> - pkt-line: add packet_flush_gently()
> - pkt-line: add packet_write_fmt_gently()
> - run-command: move check_pipe() from write_or_die to run_command
> - pkt-line: extract set_packet_header()
> - pkt-line: rename packet_write() to packet_write_fmt()
> 
> The smudge/clean filter API expect an external process is spawned
> to filter the contents for each path that has a filter defined.  A
> new type of "process" filter API has been added to allow the first
> request to run the filter for a path to spawn a single process, and
> all filtering need is served by this single process for multiple
> paths, reducing the process creation overhead.
> 
> Somehow I thought this was getting ready for 'next' but it seems
> at least another round of reroll is coming?

I thought so, too, but t0021 was flaky and Jakub had a number of good 
suggestions. I just posted v9:
http://public-inbox.org/git/20161004125947.67104-1-larsxschneider@gmail.com/

- Lars

