Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E1C741FAE2
	for <e@80x24.org>; Sat, 10 Mar 2018 10:54:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752030AbeCJKyi (ORCPT <rfc822;e@80x24.org>);
        Sat, 10 Mar 2018 05:54:38 -0500
Received: from forward104p.mail.yandex.net ([77.88.28.107]:49790 "EHLO
        forward104p.mail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751974AbeCJKyh (ORCPT
        <rfc822;git@vger.kernel.org>); Sat, 10 Mar 2018 05:54:37 -0500
Received: from mxback17j.mail.yandex.net (mxback17j.mail.yandex.net [IPv6:2a02:6b8:0:1619::93])
        by forward104p.mail.yandex.net (Yandex) with ESMTP id B4AB0181E9B
        for <git@vger.kernel.org>; Sat, 10 Mar 2018 13:54:35 +0300 (MSK)
Received: from localhost (localhost [::1])
        by mxback17j.mail.yandex.net (nwsmtp/Yandex) with ESMTP id 17LwI3ZlR6-sZvmURRt;
        Sat, 10 Mar 2018 13:54:35 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail; t=1520679275;
        bh=LWm5sKkRqTTE9/N/X7ka1CE28i7me1mcOw286i6bRfU=;
        h=From:To:In-Reply-To:References:Subject:Message-Id:Date;
        b=HAU14tBr/TVpYIV/VVOfqgtp8VYuk3QpNwrDOxOx/wkeM8RuE1YV/mQB/WQphAIBN
         WxS8BYqGVCuJCpUJl2nTUnJvQMKrl8/eYF6GUD4ZYi2xWe2Gj3VBtRcrEyNL7N4qjO
         0I7NqtI1mKJR/6ETSb6425Pcb/+s2st3KFoNhh94=
Authentication-Results: mxback17j.mail.yandex.net; dkim=pass header.i=@yandex.ru
Received: by web8j.yandex.ru with HTTP;
        Sat, 10 Mar 2018 13:54:35 +0300
From:   KES <kes-kes@yandex.ru>
Envelope-From: kes-kes@yandex.com
To:     git <git@vger.kernel.org>
In-Reply-To: <2051651520351198@web40j.yandex.ru>
References: <2051651520351198@web40j.yandex.ru>
Subject: Re: Improve `git log -L` functionality
MIME-Version: 1.0
Message-Id: <3857311520679275@web8j.yandex.ru>
X-Mailer: Yamail [ http://yandex.ru ] 5.0
Date:   Sat, 10 Mar 2018 12:54:35 +0200
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=utf-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

uh... seems nobody is interested in this functionality (

06.03.2018, 17:46, "KES" <kes-kes@yandex.ru>:
> Hi.
>  I want to `Trace the evolution of the line range`.
> And not committed change is sort of evolution and should be taken into account by -L option.
>
> Currently I MUST `stash save` change,
> look actual line number,
> trace evolution,
> `stash pop` to bring back current change.
>
> EXPECTED:
> Allow to use those line numbers which I see in my editor
> without excess `stash save/stash pop` commands
>
> If file has not committed change then this change maybe shown by `-L` as commit NOT COMMITTED YET
> If file staged 'commit STAGED'
>
> More description what is comming on:
> https://stackoverflow.com/q/49130112/4632019
