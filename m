Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5292F20401
	for <e@80x24.org>; Sat, 24 Jun 2017 17:36:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754814AbdFXRgm (ORCPT <rfc822;e@80x24.org>);
        Sat, 24 Jun 2017 13:36:42 -0400
Received: from mail-wr0-f169.google.com ([209.85.128.169]:33036 "EHLO
        mail-wr0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751568AbdFXRgl (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 24 Jun 2017 13:36:41 -0400
Received: by mail-wr0-f169.google.com with SMTP id r103so103065009wrb.0
        for <git@vger.kernel.org>; Sat, 24 Jun 2017 10:36:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=vSACcd3M/rONobm8e1/5Zpziazf8+vruLzT6FhsAx8Y=;
        b=RBcH9Nu/r1wV0AXtsYk4/JryCny8GJzIgb2WZmR/wcMZ0hkVLQhLwDeJCJGAXqhmlI
         f7u2WZb4l1Nx+SX6dlv7IZxy50xfC/4suYQUdttJKMMoCSUWTP+Wb93Uls03Sfmz/KzD
         JU61PvkQhR7igVgRkBQ1yOj4mOjyWQT8+4mJe8hrqQiPEdfsnxclHTNUYoGY4dm42d+C
         bFtvHolsWrvkiH67jWJbj/NAhJlXwmTawMMQh7+10Es55MH7ZGdWKEDQKHtkCV53qSh3
         MLHUIaVfQ+XBmGDkhAnZ69l9cbMR8qfBYnrxvfXRR95o555spyn7Siwi7dxkoknvDAPc
         a0KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=vSACcd3M/rONobm8e1/5Zpziazf8+vruLzT6FhsAx8Y=;
        b=p+pTFpCDGoRC/n95LVVr65tOT3rLXpzbxokuFAGbizsQ9+w/Y0HHPDYa4DqDdoIw2s
         +lVsKMM14AHi7FikoQWGXodxKT9GJgpgxdMp2hMrisp014DFemRfjuG/Lhf0NLsBOPqC
         9ZFKagqTBzIqczYXv/V4TlIE5EQkppMUVjbYEpQy7aJeAOiODnmTsxyWhOW1wXl+Rt40
         N9lb3nsSrCYEQ8VYNJNTO9CTXsZyxGMt6Wv4EAoVychdgAJSKG+ISruKqGKCRKwYMAsO
         H23rSxPfLVxieSJCSPrGJytQWhhwZu7rr0Q9e7+iaayRcT/d+anPMA4p6j+XI1k8cv0U
         EXoQ==
X-Gm-Message-State: AKS2vOzf7rwrwWmd/nptgm3l1q78xtb2lpuPDGgucmJ0c4QStELCyaxZ
        xHMQKTANa7sODA==
X-Received: by 10.223.166.148 with SMTP id t20mr257590wrc.52.1498325800424;
        Sat, 24 Jun 2017 10:36:40 -0700 (PDT)
Received: from slxbook4.fritz.box (p5DDB763B.dip0.t-ipconnect.de. [93.219.118.59])
        by smtp.gmail.com with ESMTPSA id y5sm2603884wrd.52.2017.06.24.10.36.39
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 24 Jun 2017 10:36:39 -0700 (PDT)
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [PATCH] git-p4: changelist template with p4 -G change -o
From:   Lars Schneider <larsxschneider@gmail.com>
In-Reply-To: <CAE5ih78YFSjcn6RNGzdxsjvn6B7xvHMgKKRqirjW00=9hWpDYA@mail.gmail.com>
Date:   Sat, 24 Jun 2017 19:36:38 +0200
Cc:     Junio C Hamano <gitster@pobox.com>,
        Git Users <git@vger.kernel.org>,
        Miguel Torroja <miguel.torroja@gmail.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <DCC54592-4010-46D5-98A9-B7B4D1467169@gmail.com>
References: <1497961141-3144-1-git-send-email-miguel.torroja@gmail.com> <xmqq4lv8kjxo.fsf@gitster.mtv.corp.google.com> <CAE5ih78YFSjcn6RNGzdxsjvn6B7xvHMgKKRqirjW00=9hWpDYA@mail.gmail.com>
To:     Luke Diamand <luke@diamand.org>
X-Mailer: Apple Mail (2.3124)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


> On 24 Jun 2017, at 13:49, Luke Diamand <luke@diamand.org> wrote:
>=20
> On 22 June 2017 at 18:32, Junio C Hamano <gitster@pobox.com> wrote:
>> Miguel Torroja <miguel.torroja@gmail.com> writes:
>>=20
>>> The option -G of p4 (python marshal output) gives more context about =
the
>>> data being output. That's useful when using the command "change -o" =
as
>>> we can distinguish between warning/error line and real change =
description.
>>>=20
>>> Some p4 plugin/hooks in the server side generates some warnings when
>>> executed. Unfortunately those messages are mixed with the output of
>>> "p4 change -o". Those extra warning lines are reported as =
{'code':'info'}
>>> in python marshal output (-G). The real change output is reported as
>>> {'code':'stat'}
>=20
> I think this seems like a reasonable thing to do if "p4 change -o" is
> jumbling up output.
>=20
> One thing I notice trying it out by hand is that we seem to have lost
> the annotation of the Perforce per-file modification type (is there a
> proper name for this?).
>=20
> For example, if I add a file called "baz", then the original version
> creates a template which looks like this:
>=20
>   //depot/baz    # add
>=20
> But the new one creates a template which looks like:
>=20
>   //depot/baz

@Miguel: You wrote that p4 plugins/hooks generate these warnings.
I wonder if you see a way to replicate that in a test case. Either
in t9800 or a new t98XX test case file?

- Lars

