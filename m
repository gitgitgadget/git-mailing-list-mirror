Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 56D9A207EC
	for <e@80x24.org>; Fri, 23 Sep 2016 18:56:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1034361AbcIWS4j (ORCPT <rfc822;e@80x24.org>);
        Fri, 23 Sep 2016 14:56:39 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:36644 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1758823AbcIWS4i (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Sep 2016 14:56:38 -0400
Received: by mail-wm0-f65.google.com with SMTP id b184so4134275wma.3
        for <git@vger.kernel.org>; Fri, 23 Sep 2016 11:56:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=references:mime-version:in-reply-to:content-transfer-encoding
         :message-id:cc:from:subject:date:to;
        bh=kiWsqpnuGowAMs7TTeahyG0R0I0OiAys9JEdK3VSA7U=;
        b=u6SNmULq962AH7YpneFG5jnWZBI+24qHpOc7JRpgulPJj45Bart+zDbhtHaU8dzVbd
         bpcDMCzHRA13OelCS8zbrcehuiztsw6eOpompvG+yLxNmeaww8+EAzwPiFer6p1iQBdW
         bPLE/IowprE9R+KOLe+criJAO0wDHbE1DZhIdJmODk4/ufpGZHvQlxyHJLFoOqNJE83e
         QUHrwh+mx8YcAeyjeN5b4CHsb0bBmhtfJ6eS6Bf3+NZ3ik4/AFn87rjwI5Hy6C4/63f8
         BU2JcRj+v3Npcq4i7K3Yu/fxwc4lrGu6nWiXU2CFF87D7vZBbnV1b48LeANeAS4VNeuv
         InCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:references:mime-version:in-reply-to
         :content-transfer-encoding:message-id:cc:from:subject:date:to;
        bh=kiWsqpnuGowAMs7TTeahyG0R0I0OiAys9JEdK3VSA7U=;
        b=P2aZLQzMjABWCJo7Be4kBzTcNI5+RjVjvWkPC80uJokchKk8ac68FfJAE8Tw0+c4IB
         GoJDkmo32lZqNx5wS+ldJ7ksZoZb13r0LKcG/8/gN1+tQmddN/6snSsPPKAgcd/COrZP
         6jnuobt5Y/ZhugxgYxe8N55fDxhVJkRkgKFV/DfuamxrBChZE7BovIfkTIVN/Cq3rVoY
         SkkJLlw9cXILJweYtifELeGi16Vf2o5o8/i8I2kdHlixb38FtodvuVjOwlQdvaCIySw0
         cpMzLqvfHLFWTp/M8pv/Fw/2Yu4eAjmwQFGUGKIFNNVYzNAPdNmF7rymwAunqlbdFuBL
         pCPA==
X-Gm-Message-State: AA6/9RmMrI2qwcgJMk+oRarK4NIMrn4Xs1PwrUjSjYcE++6ul8jR+P2w7lS+L4rqVfREog==
X-Received: by 10.28.185.71 with SMTP id j68mr3937815wmf.116.1474656997117;
        Fri, 23 Sep 2016 11:56:37 -0700 (PDT)
Received: from [10.207.88.212] (tmo-105-67.customers.d1-online.com. [80.187.105.67])
        by smtp.gmail.com with ESMTPSA id n7sm8508106wjs.34.2016.09.23.11.56.36
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 23 Sep 2016 11:56:36 -0700 (PDT)
References: <78f2bdd0-f6ad-db5c-f9f2-f90528bc4f77@ramsayjones.plus.com> <58164A5E-AC93-48A9-9139-B69CFB854CA8@gmail.com> <xmqqmviy1qux.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0 (1.0)
In-Reply-To: <xmqqmviy1qux.fsf@gitster.mtv.corp.google.com>
Content-Type: text/plain;
        charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Message-Id: <6DE6D03D-F496-4FAB-866A-BC6802312B43@gmail.com>
Cc:     Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Jeff King <peff@peff.net>,
        GIT Mailing-list <git@vger.kernel.org>
X-Mailer: iPhone Mail (13G36)
From:   Lars Schneider <larsxschneider@gmail.com>
Subject: Re: [PATCH] run-command: async_exit no longer needs to be public
Date:   Fri, 23 Sep 2016 20:56:34 +0200
To:     Junio C Hamano <gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


> On 23 Sep 2016, at 19:13, Junio C Hamano <gitster@pobox.com> wrote:
>=20
> Lars Schneider <larsxschneider@gmail.com> writes:
>=20
>>> If you need to re-roll your 'ls/filter-process' branch, could you please=

>>> squash this into the relevant commit c42a4cbc ("run-command: move check_=
pipe()
>>> from write_or_die to run_command", 20-09-2016).
>>>=20
>>> [Note that commit 9658846c ("write_or_die: handle EPIPE in async threads=
",
>>> 24-02-2016) introduced async_exit() specifically for use in the implemen=
tation
>>> of check_pipe(). Now that you have moved check_pipe() into run-command.c=
,
>>> it no longer needs to be public.]
>>=20
>> Hi Ramsay,
>>=20
>> thanks for noticing this. I actually hope that I don't need another re-ro=
ll :-)
>> If I don't re-roll. Should I make a patch with this cleanup or do you
>> take care of it?
>=20
> I can just squash the the patch you are responding to into c42a4cbc,
> with an additional paragraph "While at it, retire async_exit() as a
> public function as it no longer is called outside run-command API
> implementation", or something like that.
>=20
> I do not offhand know if the topic is otherwise ready as-is, or
> needs further work.  When you need to reroll, you'd also need to
> fetch from the result of the above from me first and then start your
> work from it, though, if we go that route.

Sounds good to me!

Thank you, Junio!=
