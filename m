Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9A54E1F453
	for <e@80x24.org>; Thu, 27 Sep 2018 16:22:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728370AbeI0Wlj (ORCPT <rfc822;e@80x24.org>);
        Thu, 27 Sep 2018 18:41:39 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:39398 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728213AbeI0Wli (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Sep 2018 18:41:38 -0400
Received: by mail-wm1-f67.google.com with SMTP id q8-v6so6595220wmq.4
        for <git@vger.kernel.org>; Thu, 27 Sep 2018 09:22:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=WqlGKO4fJGG+vcy+dY/MvoXI61/9PygbZmE9I/QsFdc=;
        b=arVhoD22pFCNb4EwyD2NOypGVYFJBJtDmIyrgZxDTsBNvxQOyuzxO+r10bAqd2EGjo
         k+lnOKRPzEDza9FNkOtUn7oQno55BCZyUMNrZewhiFJ3st9f6/RC/hqhwBUHnmTDPPCt
         psrjuWKbDhNX1vrf7GG1Ov7fl3Wva/CKvA5MdgYrlV//c7qXQJ43B62bqwkfpAFfzGtf
         3bJeZ5l1aQOLtVHB4OUdkhy1vS6qm3CFmcpQ+QLeU69KRoq7bZhsCDbU72eiEwt6LTpY
         ZGBQaWOTdnc2btwaZpKw0fyROlRbrqNIgm2kSHjsRpxpoRt+kdxSm4p9uD6l1wN+9P3x
         50pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=WqlGKO4fJGG+vcy+dY/MvoXI61/9PygbZmE9I/QsFdc=;
        b=ktrxOQoxN43P7U5VzW3tl3wA+sQPpWqfdc05ry4EXgtdYiTH3RC+RHR3CEEvoC9pJY
         fqQRefHO9v3+7oHaiiVCuyisJ+suo3ybIzStleqzmSn53V40SqbhCB0vF5YKaQ1cHvBx
         3a2wP9Os9CmJhgzlZUDni9NCjq9UrHz9HtsD4N6pj4fkbnkEvlfjfRdyn4LjQ+r7D+mG
         2U7pNwILHAoLW7eObu15Epr9tP2cORuy/6j4Ki2opYgSvCDIcrjU2f4GJjv0f46dZYEj
         VDaKUaeRlMNLmXDAN0BpeHOvcbaTCUSdeyjiPv8guc4SqmOtZ8UB5xcA9JyanXPwvIi0
         2SQQ==
X-Gm-Message-State: ABuFfoiwJ6Ps6KDSx+Wtv2eVIg5kvQHHqIu56LJYKyCLJ3k9531q1bez
        C3st8DTpO/isKGWzAZI1yjw=
X-Google-Smtp-Source: ACcGV63zjg5oua+vVE5pYtGWmE5OLddedt9wIHU6UQIwX+jeeYxtgV14UCe7v0XnvXkBbHPGNf9/aw==
X-Received: by 2002:a1c:a401:: with SMTP id n1-v6mr8113092wme.125.1538065355362;
        Thu, 27 Sep 2018 09:22:35 -0700 (PDT)
Received: from evledraar (proxy-gw-l.booking.com. [5.57.20.8])
        by smtp.gmail.com with ESMTPSA id 75-v6sm4568775wml.21.2018.09.27.09.22.34
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 27 Sep 2018 09:22:34 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        git-packagers@googlegroups.com, Git List <git@vger.kernel.org>
Subject: Re: Git for Windows for Unix?
References: <87va6rhqup.fsf@evledraar.gmail.com> <20180927160523.GA112066@aiede.svl.corp.google.com>
User-agent: Debian GNU/Linux testing (buster); Emacs 25.2.2; mu4e 1.1.0
In-reply-to: <20180927160523.GA112066@aiede.svl.corp.google.com>
Date:   Thu, 27 Sep 2018 18:22:33 +0200
Message-ID: <87tvmaj4fq.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Sep 27 2018, Jonathan Nieder wrote:

> Ævar Arnfjörð Bjarmason wrote:
>
>> GFW is a "friendly fork", but a permanent one it seems. The diff between
>> it and 2.19.0 proper is ~10k lines, and e.g. this last release had
>> experimental stash/rebase in C that 2.19.0 didn't.
>>
>> So it would be great if this were packaged up by linux distro as some
>> "alterate" package of git. I'm putting Jonathan in the "To" line because
>> I'm mainly interested in this for Debian, but maybe there's wider
>> interest at git-packagers...
>
> Please coordinate with Dscho to get these patches into "next" upstream.

I understand that this happens at some trickle, but how up-to-date that
is goes back & forth, here's the history of differences for all major
releases since 2.0.0 to 2.19.0:

    $ for rel in {0..19} ; do echo 2.$rel.0 vanilla v.s. gfw: && git diff --stat v2.$rel.0..$(git tag -l | grep v2.$rel.0.windows) -- '*.[ch]' '*.txt' '*.sh' |grep 'files changed'; done
    2.0.0 vanilla v.s. gfw:
     1790 files changed, 242271 insertions(+), 76973 deletions(-)
    2.1.0 vanilla v.s. gfw:
     1757 files changed, 231844 insertions(+), 75560 deletions(-)
    2.2.0 vanilla v.s. gfw:
     1733 files changed, 222517 insertions(+), 74745 deletions(-)
    2.3.0 vanilla v.s. gfw:
     66 files changed, 1612 insertions(+), 234 deletions(-)
    2.4.0 vanilla v.s. gfw:
     83 files changed, 2483 insertions(+), 299 deletions(-)
    2.5.0 vanilla v.s. gfw:
     89 files changed, 3150 insertions(+), 512 deletions(-)
    2.6.0 vanilla v.s. gfw:
     94 files changed, 3327 insertions(+), 538 deletions(-)
    2.7.0 vanilla v.s. gfw:
     95 files changed, 3616 insertions(+), 590 deletions(-)
    2.8.0 vanilla v.s. gfw:
     60 files changed, 3091 insertions(+), 497 deletions(-)
    2.9.0 vanilla v.s. gfw:
     60 files changed, 2945 insertions(+), 482 deletions(-)
    2.10.0 vanilla v.s. gfw:
     79 files changed, 6053 insertions(+), 1271 deletions(-)
    2.11.0 vanilla v.s. gfw:
     113 files changed, 6337 insertions(+), 1051 deletions(-)
    2.12.0 vanilla v.s. gfw:
     110 files changed, 4509 insertions(+), 868 deletions(-)
    2.13.0 vanilla v.s. gfw:
     122 files changed, 4217 insertions(+), 919 deletions(-)
    2.14.0 vanilla v.s. gfw:
     151 files changed, 5237 insertions(+), 1093 deletions(-)
    2.15.0 vanilla v.s. gfw:
     178 files changed, 4903 insertions(+), 912 deletions(-)
    2.16.0 vanilla v.s. gfw:
     172 files changed, 4614 insertions(+), 940 deletions(-)
    2.17.0 vanilla v.s. gfw:
     163 files changed, 4574 insertions(+), 882 deletions(-)
    2.18.0 vanilla v.s. gfw:
     163 files changed, 4688 insertions(+), 883 deletions(-)
    2.19.0 vanilla v.s. gfw:
     184 files changed, 9197 insertions(+), 1271 deletions(-)

So it's similar to various packages that have "alternates" and are semi
or permanently forked, like emacs & xemacs, JDK etc., although I can't
recall one offhand that's quite similar to GFW v.s. git.git.

My only stake in this is I thought it would be neat to be able to "apt
install git-for-windows", but I understand there's a support burden, but
if some *nix packagers are interested, maybe never taking it out of the
Debian equivalent of "experimental" and saying "this is unsupported, go
to the GFW tracker..." when bugs are filed would cut down on the support
burden.
