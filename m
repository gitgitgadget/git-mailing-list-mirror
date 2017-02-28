Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 64114201B0
	for <e@80x24.org>; Tue, 28 Feb 2017 17:47:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751332AbdB1RrI (ORCPT <rfc822;e@80x24.org>);
        Tue, 28 Feb 2017 12:47:08 -0500
Received: from mail-pf0-f196.google.com ([209.85.192.196]:35955 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751154AbdB1RrG (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Feb 2017 12:47:06 -0500
Received: by mail-pf0-f196.google.com with SMTP id j5so1638648pfb.3
        for <git@vger.kernel.org>; Tue, 28 Feb 2017 09:45:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=0P+74oYkGyVglI2Up6MkG/SffLgWiqcdLziWYUPfu6o=;
        b=nGikPDBjzbeU4txAeLqHSZvI4/6x33p8rfaPsSLSWUuA58DUJdMj+qKER07HAPalJm
         oxm8/5woMf6nUrGWGGI20bAqqAfWS/okxDaD+361rJ49gERYhEZNB/GDnkBLhfTwTnlu
         Jq5zyyiumxcUzX/i1pDEuawNA5cxNwLh2GsYzVCCmh7FW2Oy1FiuoPoACY8LQ7xIZVXc
         lFPi1fs/i8oXbYD2ZcxBfAVORV7zxlggdMM7McUMgs8mxSL4F5d/LVidsd+mklfCCWcW
         AS3nmqkG6BwdT/8RC05KQZCZ66eCcR4i6DuLe7+3xFkmWrSQeBCxVeBoEGkkVzY7BIK4
         3zng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=0P+74oYkGyVglI2Up6MkG/SffLgWiqcdLziWYUPfu6o=;
        b=GmIj7PweWWMqpy/aVYhHRX1dsZT5hZ3+sJYwIZYLid20gz1qtO9zFIKBgBLe/PFPGt
         zEjd6RzvLgPODnyK6QFQQ7QwY8JEGLkt1+DHCAw19PlPRfN75vSH21CHrTMsDjmaL79l
         0K3sYiji2owRfTEbRNZHMTecrvgrKJXq99f9MUV+tLVuZVclVsJ7PwZEnGYB+LT6wu+C
         6+uhL5emsu6/9eaVpbEgWplw6u2adJtMVjFfzU6yBGTpyNuIbzEMyeCyThWBeATvtZmX
         jGa9djvmjFD0/OLvo3cMV4aXxZQvwY0JBzOgMWlTcPknQbzVGeWLTAa2sfSMGhF7HzEo
         Tc4Q==
X-Gm-Message-State: AMke39nm1D7DVY0uT4r2Esx9SP67/rtwYPsEj3qNAMWNKpimWoYarBAL8KPmGEs5jDkUJw==
X-Received: by 10.84.133.193 with SMTP id f59mr4484675plf.64.1488303364895;
        Tue, 28 Feb 2017 09:36:04 -0800 (PST)
Received: from localhost ([2620:0:1000:8622:e0d7:55f8:67f2:62dd])
        by smtp.gmail.com with ESMTPSA id b70sm5456778pfc.100.2017.02.28.09.36.04
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 28 Feb 2017 09:36:04 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Patrick Schleizer <patrick-mailinglists@whonix.org>
Cc:     git@vger.kernel.org, Whonix-devel <whonix-devel@whonix.org>
Subject: Re: gpg verify git sub modules useful?
References: <a9da4416-6437-a491-f461-c5e61d805b2d@riseup.net>
Date:   Tue, 28 Feb 2017 09:36:03 -0800
In-Reply-To: <a9da4416-6437-a491-f461-c5e61d805b2d@riseup.net> (Patrick
        Schleizer's message of "Tue, 28 Feb 2017 15:50:00 +0000")
Message-ID: <xmqqmvd6kykc.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Patrick Schleizer <patrick-mailinglists@whonix.org> writes:

> When using git submodules, is there value in iterating about the git
> submodules running "git verfiy-commit HEAD" or would that be already
> covered by the git submodule verification?

That depends on what you are referring to with the "git submodule
verification" and more importantly what threat you are guarding
against.  "git -C <submodule-dir> verify-commit HEAD" may make sure
that the contents of that commit object is GPG signed by whoever you
trust--is that what you want to make sure?  Or do you want all
commits in the submodule history to be similarly signed because the
tree of the superproject can switch to some other commit there?
