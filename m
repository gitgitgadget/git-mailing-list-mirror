Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6E2F01FD99
	for <e@80x24.org>; Fri, 26 Aug 2016 20:39:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752161AbcHZUjx (ORCPT <rfc822;e@80x24.org>);
        Fri, 26 Aug 2016 16:39:53 -0400
Received: from mail-wm0-f45.google.com ([74.125.82.45]:34989 "EHLO
        mail-wm0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751671AbcHZUjw (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 26 Aug 2016 16:39:52 -0400
Received: by mail-wm0-f45.google.com with SMTP id f65so7048073wmi.0
        for <git@vger.kernel.org>; Fri, 26 Aug 2016 13:39:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=+3yfBORpuEg+PjXRm91t5QdKuYT+K+YWiDSH5MOKadU=;
        b=Q0RgDQ13cydWCEenBsSlYYo4QkfPahis6HATycfLmF4ZwxCgKTXETXjGS9TpvKmMZx
         sEZTmPIw1rPL05Sly83DhtPGvkx1XRN+yR1CKIQQ6vlTmAZqhVYU1g3ZDSrOpRc3W7NS
         iaAwo5dQH39BASzV9YUK5bfpXgqPmjm3wrP0+a9NStk2QmHN0Kxq4jNAbfijpeZ/5uBy
         ok72DtdvpuAbtVXCVMeyKx2GtfLhqYTk+A8ibIBRHsTJvjoot0PgHv6dHL7W0eto3nIk
         EedNGaYzupT2JOgPjUWBrFRyfQEF83newRC59Pj4dtfunBYEK5kCskHl1MLOkk4LVp00
         ZO9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=+3yfBORpuEg+PjXRm91t5QdKuYT+K+YWiDSH5MOKadU=;
        b=ZSgPi/c0hjRyjcQwtp/lBbofko3lj4/sYSxiZBc8bh6npzxVEOAtVWw9pfrV88iXRX
         sc+RV23DLyvvCHd2OwWYGhumX6hwDBOH5uMtJxsQ4Ao1P9FrwvsASwEs9M68RCX3Vm0z
         OwJ2In+WAphn5hm8ZTXWcEvc/HH+paht09oEOEsAphToMwLia809jHz1Fw40O28k9m1S
         IUKosXEJxP8tZJpoQNJdgqcdM+wAcQc+Dqi8lOYq8jxpcOx0YJpp9ERvkFGnQfTAua+2
         NMo37NZBg/8XuLm5k0AgPvqlDHOhKJ3WnQSh6Mlbt6yukPL3ZYX4o9Dbq4a5B7gvPDqW
         Z5kQ==
X-Gm-Message-State: AE9vXwPWrgdb+SuD7IkiTAgUupxlu9PMTR8kczqqNE9ebFuti3NtsVsVL3BgaSxlgOm5LXfDHcGpSgLUW9zLqw==
X-Received: by 10.194.235.166 with SMTP id un6mr5765537wjc.169.1472243991215;
 Fri, 26 Aug 2016 13:39:51 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.28.230.154 with HTTP; Fri, 26 Aug 2016 13:39:50 -0700 (PDT)
In-Reply-To: <xmqqfuprffiu.fsf@gitster.mtv.corp.google.com>
References: <20160818185719.4909-1-ralf.thielow@gmail.com> <20160826175836.14073-1-ralf.thielow@gmail.com>
 <20160826175836.14073-3-ralf.thielow@gmail.com> <xmqq8tvjgxiy.fsf@gitster.mtv.corp.google.com>
 <CAN0XMOKo0VXPZF8ve2e1N5f591Kkz-Gmxt4wJKsev2zj4ubj9w@mail.gmail.com> <xmqqfuprffiu.fsf@gitster.mtv.corp.google.com>
From:   Ralf Thielow <ralf.thielow@gmail.com>
Date:   Fri, 26 Aug 2016 22:39:50 +0200
Message-ID: <CAN0XMO+1o0fHNeemN0JAHnRZY4O1xh1xkSQHAPPdEGJPxiMkBQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] help: introduce option --exclude-guides
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git <git@vger.kernel.org>,
        Lars Schneider <larsxschneider@gmail.com>,
        Joseph Musser <me@jnm2.com>,
        Philip Oakley <philipoakley@iee.org>,
        John Keeping <john@keeping.me.uk>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

2016-08-26 22:20 GMT+02:00 Junio C Hamano <gitster@pobox.com>:
>
> Because the whole thing is inside a double-quote pair, $() and $name
> are all interpolated even before test_expect_success is called.
> So the above becomes equivalent to
>
>>> test_expect_success "two commits do not have the same ID" '
>>>         git commit --allow-empty -m first &&
>>>         one=5cb0d5ad05e027cbddcb0a3c7518ddeea0f7c286 &&
>>>         test_tick &&
>>>         git commit --allow-empty -m second &&
>>>         two=5cb0d5ad05e027cbddcb0a3c7518ddeea0f7c286 &&
>>>         test !=
>>> '
>

I got it, thanks.  My understanding in when a part is being interpreted
was obviously very wrong.  Thanks again!
