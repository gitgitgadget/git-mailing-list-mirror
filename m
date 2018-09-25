Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 85C701F453
	for <e@80x24.org>; Tue, 25 Sep 2018 20:36:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726417AbeIZCqN (ORCPT <rfc822;e@80x24.org>);
        Tue, 25 Sep 2018 22:46:13 -0400
Received: from mail-wm1-f41.google.com ([209.85.128.41]:39848 "EHLO
        mail-wm1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726095AbeIZCqN (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Sep 2018 22:46:13 -0400
Received: by mail-wm1-f41.google.com with SMTP id q8-v6so15031742wmq.4
        for <git@vger.kernel.org>; Tue, 25 Sep 2018 13:36:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=cl6easS5nWGjmiyUOGRX9/U7dI9RCclGmQErcQSetYU=;
        b=lWeACouURrrQMYmk90a5PAsJmnSnizwWvonh+gW4r+o6tcYofji65ZombqGmo/dc1h
         VYMZqQEkFudKCl0+FnBkp060V4AH1jumJ1DYSRbomOG2lXt1RLTdD+QDySFol7OtdDpN
         yMuScptGuFw/EDoNRSYhBnm7ecxvf3fGLc/3O5QfrF8mA4U9DcmNo5XWofuOLdDWfh2s
         XE7QIDBaGkHS4gkkwLV4/hJ9NRwe5FtQsw2PQyHiMjEXqmTeYQiZ87eNxtkHtLf6W6+U
         mlI2dl03qySHT/xHdlgctXaxdgvwvZiZPqelfNmradqpsyF7SrnnSmTHvCtW8i+yhZF2
         9w/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=cl6easS5nWGjmiyUOGRX9/U7dI9RCclGmQErcQSetYU=;
        b=AG5rqqH2ZIEB7o+Gg5PopwnlrNm4kBg9ZmZZcU9ajNZgDPNSrg20RTW9xjYuVjxV4c
         R6W1Ca6IPcJArOHh5YFNJhPWPPy9u3JlPhmUAf5gGH2DCaGCnZ/NDsIRAwn+YxGNRxHi
         zh9VkC35HcduA7CLcy+ayN3YX+ZSPid66KA2l0au/0GRRygU6a2t33GeAjfzTIBZnFLs
         EqXr5ZmNxpP+6Pe9/S3CbWdNu6qUT06aKNf7YqLb+gbXdCgkcwKv0pcW4Y0PIl20wSAk
         w1Byvc3DYIyrzgIB8R8ijaWbZKDHxqTtsGKKT7JFKSF7P2fBph5d8+UwvK8SLfN587Y0
         79VA==
X-Gm-Message-State: ABuFfoivo0L/Jh+M9yzkNUYmkHtlS9HkRJwB/ei8qA1LteNo015ZP+2L
        ka2u1Ph+eLAYJ/BYuIIZVPZ9/BA3
X-Google-Smtp-Source: ACcGV60llnkyG9nAjNd0bMpDxtME0UAIpUXjq+tUdBGYYqqqrBxp/x6fQ0DH+3WbXXm8idvFr6Fkyw==
X-Received: by 2002:a1c:7411:: with SMTP id p17-v6mr2173447wmc.77.1537907811840;
        Tue, 25 Sep 2018 13:36:51 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id l40-v6sm2001505wre.38.2018.09.25.13.36.50
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 25 Sep 2018 13:36:51 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     Derrick Stolee <stolee@gmail.com>, git <git@vger.kernel.org>
Subject: Re: [PATCH 1/3] t7001: reformat to newer style
References: <20180921235833.99045-1-sbeller@google.com>
        <20180921235833.99045-2-sbeller@google.com>
        <7f77be2b-a084-5b8d-df65-1bb4b9c5da82@gmail.com>
        <CAGZ79kaeWa5PRregdoJp82sSsY1-GF7kk33fxf1kbTPcZWu-bg@mail.gmail.com>
Date:   Tue, 25 Sep 2018 13:36:50 -0700
In-Reply-To: <CAGZ79kaeWa5PRregdoJp82sSsY1-GF7kk33fxf1kbTPcZWu-bg@mail.gmail.com>
        (Stefan Beller's message of "Mon, 24 Sep 2018 11:51:27 -0700")
Message-ID: <xmqqd0t1pb4t.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Beller <sbeller@google.com> writes:

> Heh, thanks for calling that out. So we're looking at a full formatter
> instead of a partial formatter that helps moving in the right direction now. :-/

The parts left out of these patches (e.g. use subshell when working
in a subdirectory) need human decision and a bit of good taste, and
I think it was a good design decision to keep these three patches
all mechanical.  There do need a follow-up [PATCH {4,5,6}/3] that
cannot be done mechanically, though, before the result can be called
"this script has been cleaned up and new people are encouraged to
mimick the way it does things".  

That way, we can keep the mechanically good bits that are early in
the series while polishing the later bits that need human judgement.


