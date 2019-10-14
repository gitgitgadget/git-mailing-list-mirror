Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.5 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE,
	USER_IN_DEF_DKIM_WL shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F00CA1F4C0
	for <e@80x24.org>; Mon, 14 Oct 2019 18:28:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731207AbfJNS2A (ORCPT <rfc822;e@80x24.org>);
        Mon, 14 Oct 2019 14:28:00 -0400
Received: from mail-pf1-f202.google.com ([209.85.210.202]:37756 "EHLO
        mail-pf1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729950AbfJNS2A (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 Oct 2019 14:28:00 -0400
Received: by mail-pf1-f202.google.com with SMTP id p2so13947683pff.4
        for <git@vger.kernel.org>; Mon, 14 Oct 2019 11:27:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=PyRe9gCMVsomFaXS9ieyXvWa+fz2hWWlnZsoyF54I5Y=;
        b=BmA1O/jJCpKaQarW1f2WfExmAOPcC+X9CjV8RwFkqY/io3t1zr8Eh+dx5qqfDQNvLJ
         gySYNc70tlEYLIkqmMcSlYkFAmKkCAHED3F4D93j2topUEhwqc/d5O92wEevov72yVJU
         3iDCALrPl7jbzgJNLehRWPh/PtHTDHOjHZskHArlnqPy9lxyhSnBgoxZzd+xaACyURHo
         CWo4vC3anyhgGZPJdVpGcssQsPdEIdBeRi/AvbUotZSE912gQS0F3MinzyV/BD21zqfS
         9IWDnHc4/Vf0bLutJfrqEqqUuoZ6qAOpfYNabCes/RNL61EBjkD2fAXMkxOxMv4tljA3
         G/9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=PyRe9gCMVsomFaXS9ieyXvWa+fz2hWWlnZsoyF54I5Y=;
        b=hO34+3XzTjAXh5HSx6GJxRzJUE8SX6+dUi/uEhLPUR7bM94z41PrTCwaUZFkcNPyYr
         wyr2VM1c4RJiaIySzR7DVKaV7z07KCJZvkaTuEPFHIhTLNM67XvVTAfjtH9iFDTh3NhL
         KvwBDnuhPJC/MYX89+aF2MLEdidmmry+K5bSZESsFyq0DgrzzoKVqk3K1g3xwSwLUoAt
         uA2yo/3oRXHDWqaxDMl6QuyhXgV1ePYpxDzGBf6VfMz4b49Gx5kISdZSnKLtLOaOjzOa
         K9v9Iyx/S8p+aBbrLjaUPJCl2uQLe8yXuBclOvR+tFgfJyUd1+iaHGnW3LlbsAqi9USP
         Q53g==
X-Gm-Message-State: APjAAAW3DQIdw7bh7fbuDp4RrNNcFqVbNLgRsca+67/J45pqJZ1eHGkN
        Af+oaJfU1IaNeCwKdxivO4QA8yQ8B9ZmMi8oI+6o
X-Google-Smtp-Source: APXvYqwYgyaJRnsi4H/ZHkF58pEYuBw8nWtbuG2m9sr0EpgM4Hof2m4BWAm7KoTN09J5CTelHwkRxfHraNFZQpWn+511
X-Received: by 2002:a63:78f:: with SMTP id 137mr16165234pgh.110.1571077677451;
 Mon, 14 Oct 2019 11:27:57 -0700 (PDT)
Date:   Mon, 14 Oct 2019 11:27:54 -0700
In-Reply-To: <xmqqk19ag60g.fsf@gitster-ct.c.googlers.com>
Message-Id: <20191014182754.82302-1-jonathantanmy@google.com>
Mime-Version: 1.0
References: <xmqqk19ag60g.fsf@gitster-ct.c.googlers.com>
X-Mailer: git-send-email 2.23.0.700.g56cf767bdb-goog
Subject: Re: [Outreachy] [PATCH] blame: Convert pickaxe_blame defined
 constants to enums
From:   Jonathan Tan <jonathantanmy@google.com>
To:     gitster@pobox.com
Cc:     jonathantanmy@google.com, wambui.karugax@gmail.com,
        git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> Jonathan Tan <jonathantanmy@google.com> writes:
> 
> >> > Also, I have a slight preference for putting "= 02" on the BLAME_COPY
> >> > line but that is not necessary.
> >> 
> >> That is absolutely necessary; it is not like "we do not care what
> >> exact value _COPY gets; it can be any value as long as it is _MOVE
> >> plus 1", as these are used in set of bits (and again, I do not think
> >> it is such a brilliant idea to use enum for such a purpose).
> >
> > Good point.
> 
> Doesn't that also show that enums are not quite a good fit for set
> of bits (i.e. 1<<n)?

Well, I agree that it could be better, but with the C language as we
have it now, I still slightly prefer an enum to a list of #define. Both
ways, we still have to manually enter values for each flag, but with
enum, we get better debugger display (at least in gdb) and in the
function declaration and definition, we can put a specific type (instead
of "unsigned" or "int"). gdb supports the notion that a few people use
enums this way too, but if we decide as a project to not use enums in
this way, that's fine too. For what it's worth, I tried doing a search
online, but most of the results I got was for C# (where it is
recommended - they have a "[Flags]" attribute for enums), so maybe I am
indeed in the minority.
