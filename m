Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 844D4202AC
	for <e@80x24.org>; Wed, 12 Jul 2017 07:29:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933286AbdGLH3G (ORCPT <rfc822;e@80x24.org>);
        Wed, 12 Jul 2017 03:29:06 -0400
Received: from mail-pf0-f177.google.com ([209.85.192.177]:32867 "EHLO
        mail-pf0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933210AbdGLH3G (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Jul 2017 03:29:06 -0400
Received: by mail-pf0-f177.google.com with SMTP id e7so8700426pfk.0
        for <git@vger.kernel.org>; Wed, 12 Jul 2017 00:29:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=G/1Q+3a2Fu11ZfNtANoudMIW+kzr4em7nrZ6s72wqqg=;
        b=Zeb64IXlYO0MWFA62rrBdmnR9sme0m2UPbQNhhqu8r6BswPkZz3GBFvCsuTaa4lO5K
         owoIxjnDJHdh8T9H8cmRDoM51AIROhqOr+n4XhFhAJ5Q3wQSinAzz7j1emHA4B7E3+w1
         ugzLD30xSxUUN0iOvTTJxHrgMhXLp0dPc479vAfY1yJLibXHapQUkrR23qeI/yYDDE3H
         WrxCcCQHrP+Emoj1UM6gC/99Cyd64VHpHEwnN8pKTVNdi8dxYhVVPfFR9AO1+6BvNiU1
         BpSx3YuvsopWJpOmWsh2NCB9pvWkWzOy+YpkxQAiZkmapezTChkQzEVkfzASkMUudhwW
         Pj2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=G/1Q+3a2Fu11ZfNtANoudMIW+kzr4em7nrZ6s72wqqg=;
        b=seAlFFE47c2G0wSn4P4TRUPJRNcp/vgrJOb5ChGqkIDt9ufH8ridlklGKSzXXKdhHe
         SCkS2BacI2GuUjTfGiTF+VRbDaBTOMpFtXyI7ZuYwv03JjEt8tQl67uSDcRretPTDEse
         +fjJX7XkN1wQh+gKW3atc5NhgLFWFhqigUEIO2U0FcifkO6K52eAvzdASNJE44vC1pjk
         QT1/bYSgykJCC7GMGkIGCI3CCT8ZG6SivSRC++0eKl5cmmerhQsP9j7kEP5nSzooLNCe
         oUxe9zuMToyu8a27229CN3y7m9bKVunXl9cZ9HqnXHZt0qVygkePYtERk+cXaeTQglGz
         Xm/Q==
X-Gm-Message-State: AIVw110aQpEUbpXropFHCjB//ehjqJq8ByMr50oYoXTqoeOBo0/lZeX1
        6/+baKlH6kFMXLG4FXg+OcRG+OCVlQ==
X-Received: by 10.99.36.198 with SMTP id k189mr2479208pgk.230.1499844545304;
 Wed, 12 Jul 2017 00:29:05 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.100.163.102 with HTTP; Wed, 12 Jul 2017 00:29:04 -0700 (PDT)
In-Reply-To: <xmqqpod752yh.fsf@gitster.mtv.corp.google.com>
References: <cover.1499723297.git.martin.agren@gmail.com> <xmqqpod752yh.fsf@gitster.mtv.corp.google.com>
From:   =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Date:   Wed, 12 Jul 2017 09:29:04 +0200
Message-ID: <CAN0heSq-HHsW5Cd_VvshNS_qHW3nVz-yzwSfFQin8Dyr2hhksA@mail.gmail.com>
Subject: Re: [PATCH 0/7] tag: more fine-grained pager-configuration
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git Mailing List <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        Jonathan Nieder <jrnieder@gmail.com>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>, Brandon Williams <bmwill@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 11 July 2017 at 00:42, Junio C Hamano <gitster@pobox.com> wrote:
> Martin =C3=85gren <martin.agren@gmail.com> writes:
>> I am not moving all builtins to handling the pager on their own,
>> but instead introduce a flag IGNORE_PAGER_CONFIG and use it only
>> with the tag builtin. That means there's another flag to reason
>> about, but it avoids moving all builtins to handling the paging
>> themselves just to make one of them do something more "clever".
...
> Even though it is purely internal thing, IGNORE_PAGER_CONFIG
> probably is a bit confusion-inducing name.  After all, the
> subcommand specific configuration is not being ignored---we are
> merely delaying our reaction to it---instead of acting on it inside
> git.c without giving the subcommand a chance to make a decision, we
> are still letting (and we do expect) the subcommand to react to it.

Thank you for your comments. I'm working on v2 with the input from
you, Peff and Brandon. I'll make this DELAY_PAGER_CONFIG.

Martin
