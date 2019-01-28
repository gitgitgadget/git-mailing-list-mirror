Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E15521F453
	for <e@80x24.org>; Mon, 28 Jan 2019 20:16:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726823AbfA1UQ5 (ORCPT <rfc822;e@80x24.org>);
        Mon, 28 Jan 2019 15:16:57 -0500
Received: from forward500j.mail.yandex.net ([5.45.198.250]:54137 "EHLO
        forward500j.mail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726719AbfA1UQ5 (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 28 Jan 2019 15:16:57 -0500
Received: from mxback22g.mail.yandex.net (mxback22g.mail.yandex.net [IPv6:2a02:6b8:0:1472:2741:0:8b7:322])
        by forward500j.mail.yandex.net (Yandex) with ESMTP id 5E6FA11C145B;
        Mon, 28 Jan 2019 23:16:55 +0300 (MSK)
Received: from localhost (localhost [::1])
        by mxback22g.mail.yandex.net (nwsmtp/Yandex) with ESMTP id zQtioKE1Rr-GsMqieo5;
        Mon, 28 Jan 2019 23:16:54 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ya.ru; s=mail; t=1548706614;
        bh=tIaACVT8SfIO22U/VKERL6fg6k+oFcFfziVKogbPu30=;
        h=From:To:Cc:References:Subject:Date:Message-Id;
        b=cjpkoPUJpb0e3daIFUH6X0z9Rlcdo5YXOzIQyiou6Tb0ZyfomFYqP0MrO0/n0Rm5v
         uWM9YkNck8E3T4xFr7yIpSr0TqYnWBirdLu7NS1KinC01OnhYKoTKqphcHCzJWorPY
         vgoQKMYuwwS2IqZ59nAA5hLncexlLVVS4v2D9N78=
Authentication-Results: mxback22g.mail.yandex.net; dkim=pass header.i=@ya.ru
Received: by myt1-06117f29c1ea.qloud-c.yandex.net with HTTP;
        Mon, 28 Jan 2019 23:16:54 +0300
From:   Sergey Lukashev <lukashev.s@ya.ru>
Envelope-From: lukashev-s@yandex.ru
To:     Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>
References: <57362151548583138@iva8-37fc2ad204cd.qloud-c.yandex.net>
         <20190128160620.GA23588@sigill.intra.peff.net>
         <xmqqzhrkab3s.fsf@gitster-ct.c.googlers.com> <20190128183253.GB13165@sigill.intra.peff.net>
Subject: Re: unclear docs
MIME-Version: 1.0
X-Mailer: Yamail [ http://yandex.ru ] 5.0
Date:   Mon, 28 Jan 2019 23:16:54 +0300
Message-Id: <1811741548706614@myt1-06117f29c1ea.qloud-c.yandex.net>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=utf-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

autocrlf can be "input" as well.

28.01.2019, 21:32, "Jeff King" <peff@peff.net>:
> On Mon, Jan 28, 2019 at 10:30:31AM -0800, Junio C Hamano wrote:
>
>>  Jeff King <peff@peff.net> writes:
>>
>>  > I think it means:
>>  >
>>  > - if core.autocrlf is false (the default), then the text attribute and
>>  > core.eol are used
>>  >
>>  > - if core.autocrlf is true, then that overrides the whole
>>  > attribute/eol system
>>
>>  I think that matches my understanding.
>>
>>  > Subject: [PATCH] doc/gitattributes: clarify "autocrlf overrides eol"
>>  >
>>  > We only override core.eol with core.autocrlf when the latter is set to
>>  > "true" (otherwise, core.eol would never do anything!). Let's make this
>>
>>  I fail to understand what "otherwise..." wants to say. When
>>  core.autocrlf is not "true", core.eol would not do anything?
>
> I meant that if core.autocrlf overrides core.eol also when it is not set
> to true, then there would be no way to use core.eol, because the former
> must be either true or false.
>


