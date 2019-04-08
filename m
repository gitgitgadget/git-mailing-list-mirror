Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.7 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 89C4A20248
	for <e@80x24.org>; Mon,  8 Apr 2019 17:01:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729020AbfDHRB3 (ORCPT <rfc822;e@80x24.org>);
        Mon, 8 Apr 2019 13:01:29 -0400
Received: from mail-ot1-f73.google.com ([209.85.210.73]:34795 "EHLO
        mail-ot1-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726726AbfDHRB3 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 Apr 2019 13:01:29 -0400
Received: by mail-ot1-f73.google.com with SMTP id 7so8466435otj.1
        for <git@vger.kernel.org>; Mon, 08 Apr 2019 10:01:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=LGtKWDqmUNOkkyMIcZyJXAo9mf4EZ/DnoL7OhwY8PKk=;
        b=V2Vcj9rZBBnalDWT/8FMa0QAgU6BtiODRQVe4wa2dC1XdYKHl0u1md8nU8W7IKeYCp
         vphqem0DQJu4iRDkXMB4fTRsID++TWgVv6T+Nwyat4vd76KM4fjwOhJZMEc377Dme8hi
         lW7KMJPpB6/D1MzTpN8l54HJz2nrdM6r2xJbOf3RDKhuocBVXt9yX4L6ZMRjAMnD8Vx3
         tPP9ZBvqfmUyI3Q58yX4p5sxpxdc/PXgBlo7qamllyIVmKh8cAckwqQ844u1goHUN3Bj
         L92FGLXGPtqiDBMNNe4MPlFf4vfqsWD6V61Kc7Svgg/oLcBE/upXffSdQRRvlSZOGzZL
         9SSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=LGtKWDqmUNOkkyMIcZyJXAo9mf4EZ/DnoL7OhwY8PKk=;
        b=jXzU976hkGPpUqIEwe9aL/ZfGbkdYl/iJIlYPP7mDIBENunmya74e9u6Y9K+kigkze
         DvR7OD98Fbp2y6PwskQmQWBmAymQF2odqBY/o2B4b2UcJ9nCCaOBT9qi0+n8s0ui9XTs
         w5+8j8NtdxIU/1AEH88Kf/xDDO6cMimvnRuXlYL190FQMN4x014UmDwMOmX4uH5Yk5CM
         U7+TGDoydjU+5oHGiepOcCv4qEWnXIWbJkwLrD3pZIeotYEusr1fYq5ii5A1sSr/iZs/
         zmKFQbgJLMVFq10j1hUZWfDyr8/zb/rj/V/3lRlEPiIp/TDxbuLf16V3MrKAw5qGgQSl
         PxAA==
X-Gm-Message-State: APjAAAWL43zgsKW5UNwP6XNOd5wYnK1S8W41KPyfOdV3UiaHeZZDgC/H
        i8VcocDm76WbRBu0xNH1TfRhU/yAZ3CnpojVh8DP
X-Google-Smtp-Source: APXvYqxooxwImzefztdUtoC+IzNEeeayB+OQZnKEFfGTB8CikAX5VJiuWiAAUzTqFrZzrnYhoL5ugDs62dWzuwjczAbn
X-Received: by 2002:a05:6830:112:: with SMTP id i18mr2081054otp.50.1554742888175;
 Mon, 08 Apr 2019 10:01:28 -0700 (PDT)
Date:   Mon,  8 Apr 2019 10:01:25 -0700
In-Reply-To: <20190406113113.GA219876@google.com>
Message-Id: <20190408170125.124345-1-jonathantanmy@google.com>
Mime-Version: 1.0
References: <20190406113113.GA219876@google.com>
X-Mailer: git-send-email 2.21.0.392.gf8f6787159e-goog
Subject: Re: [PATCH v2] t5551: mark half-auth no-op fetch test as v0-only
From:   Jonathan Tan <jonathantanmy@google.com>
To:     jrnieder@gmail.com
Cc:     jonathantanmy@google.com, git@vger.kernel.org, peff@peff.net,
        gitster@pobox.com
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> > +	# NEEDSWORK: When using HTTP(S), protocol v0 supports a "half-auth"
> > +	# configuration with authentication required only when downloading
> > +	# objects and not refs, by having the HTTP server only require
> > +	# authentication for the "git-upload-pack" path and not "info/refs".
> > +	# This is not possible with protocol v2, since both objects and refs
> > +	# are obtained from the "git-upload-pack" path. A solution to this is
> > +	# to teach the server and client to be able to inline ls-refs requests
> > +	# as an Extra Parameter (see pack-protocol.txt), so that "info/refs"
> > +	# can serve refs, just like it does in protocol v0.
> > +	GIT_TEST_PROTOCOL_VERSION=0 git --git-dir=half-auth fetch &&
> >  	expect_askpass none
> 
> I suspect it's fine if protocol v2 never supports this.  Can we change
> the NEEDSWORK comment to say that the protocol v2 spec should document
> the lack of support for half-auth?
> 
> With or without such a change,
> Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>

Thanks for your review. Junio brought up a possible workflow that uses
this feature [1] and while I don't know if we will ever get around to
supporting half-auth in v2, it seems better to me to leave the
possibility open.

[1] https://public-inbox.org/git/xmqq36nfsl8t.fsf@gitster-ct.c.googlers.com/
