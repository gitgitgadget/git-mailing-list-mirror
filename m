Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CA82B20986
	for <e@80x24.org>; Tue, 27 Sep 2016 23:12:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753983AbcI0XMD (ORCPT <rfc822;e@80x24.org>);
        Tue, 27 Sep 2016 19:12:03 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:63408 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1753122AbcI0XMB (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Sep 2016 19:12:01 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 3A2E53F92C;
        Tue, 27 Sep 2016 19:12:00 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=ktLx9K5O4SHJ3yL0MoAMqq30njo=; b=vdDrqJ
        03ItoFAMOl9mjyC4QqDd25HkkpuO7oYfCeqyMC7TT2U7Nr4EKpzCXkyqrdgf5EIW
        FqAt/rAbBaaTKgzeAf5L8nOsqi+98VkiLmruP6ehaf+DkgTRUmswMjjCjZvx/e7R
        kPHWAKr1+EWFsaPPnN6zsFzzBwBWxVPZy25GE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=qZUO2bLRLz1YYhaE3jLY4jEO+XPQZzEl
        bqebt2aJkW+fNnYE6IJ8OerB3ei+hJihh5DOYFCDngSC+ghuRuRrKfpmIyZAVqnw
        o5XIZ1XaoLz9eq/9/K2b060bS147YkQ0B5lnBEpBAU1CNpVScUjQhS8qTxU8KK05
        MZaQZXC93vs=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 3153E3F92A;
        Tue, 27 Sep 2016 19:12:00 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 9C6183F929;
        Tue, 27 Sep 2016 19:11:59 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     git@vger.kernel.org
Subject: Re: What's cooking in git.git (Sep 2016, #07; Fri, 23)
References: <xmqqlgyiz0lr.fsf@gitster.mtv.corp.google.com>
        <alpine.DEB.2.20.1609242101100.129229@virtualbox>
Date:   Tue, 27 Sep 2016 16:11:57 -0700
In-Reply-To: <alpine.DEB.2.20.1609242101100.129229@virtualbox> (Johannes
        Schindelin's message of "Sat, 24 Sep 2016 21:05:32 +0200 (CEST)")
Message-ID: <xmqqd1jpkkea.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: CAE345A6-8507-11E6-97EC-EAAE7A1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> In your previous kitchen status ("What's cooking") you hinted at a
> possible v2.10.1 soon. I have a couple of bugfixes lined up for Git for
> Windows and would like to avoid unnecessarily frequent release
> engineering... Any more concrete ideas on a date for this version?

I scanned RelNotes for 2.11 and identified these topics that we'd
want to have in 'maint'.

    bw/pathspec-remove-unused-extern-decl # 1 (6 days ago) 
    rs/checkout-some-states-are-const # 1 (6 days ago) 
    rs/strbuf-remove-fix # 1 (6 days ago) 
    rs/unpack-trees-reduce-file-scope-global # 1 (6 days ago) 
    mr/vcs-svn-printf-ulong # 1 (6 days ago) 
    sy/git-gui-i18n-ja # 7 (12 days ago) 
    jk/fix-remote-curl-url-wo-proto # 1 (12 days ago) 
    js/git-gui-commit-gpgsign # 2 (12 days ago) 
    jk/patch-ids-no-merges # 2 (6 days ago) 
    ew/http-do-not-forget-to-call-curl-multi-remove-handle # 3 (6 days ago) 
    rs/xdiff-merge-overlapping-hunks-for-W-context # 1 (6 days ago) 
    ks/perf-build-with-autoconf # 1 (6 days ago) 
    jt/format-patch-base-info-above-sig # 1 (6 days ago) 
    jk/rebase-i-drop-ident-check # 1 (6 days ago) 
    jk/reduce-gc-aggressive-depth # 1 (6 days ago) 
    et/add-chmod-x # 1 (6 days ago) 
    tg/add-chmod+x-fix # 7 (24 hours ago) 

Most are internal clean-ups that I do not mind leaving out, but I
think we want to have that "add --chmod=+x" fix in.  As it hasn't
been enough time passed since the topic was merged to 'master', I'd
say either

 (1) 2.10.1 with everything other than the last two in a few days
     and 2.10.2 late next week with "add --chmod=+x" fix, or

 (2) just a single 2.10.1 with everything late next week.

I can go either way and welcome suggestions.  I'd start merging
older topics in the above list to 'maint' soonish, but not today.

Thanks.



