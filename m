Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0BD691FBB0
	for <e@80x24.org>; Wed,  7 Dec 2016 11:09:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752867AbcLGLJQ (ORCPT <rfc822;e@80x24.org>);
        Wed, 7 Dec 2016 06:09:16 -0500
Received: from mail-qk0-f180.google.com ([209.85.220.180]:36422 "EHLO
        mail-qk0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752630AbcLGLJP (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Dec 2016 06:09:15 -0500
Received: by mail-qk0-f180.google.com with SMTP id n21so409760953qka.3
        for <git@vger.kernel.org>; Wed, 07 Dec 2016 03:09:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=diamand.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=wQYzuTExgi8wgA3lTHR0N4+JTdtxWGjpK1XGYLtE0kY=;
        b=IIOykrl9DgMr9tcJzlIuKb96PxL/1JE13ZbyUt/WkA4XdJovjyp3wEnQh4EvHg8Nn/
         uGkx/y2dBnUQNl//oNuFlsy9yazGKLyzsbLiFI7aZp/rviQoPahlg0SOCBkSopGH09KB
         hIbqav975ywX4UIGZZq2VSqQLGJvqzX0O8VLk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=wQYzuTExgi8wgA3lTHR0N4+JTdtxWGjpK1XGYLtE0kY=;
        b=R2O2kF8o0LWx+Fhq3TuU5DNO6wIAD7hU14x2d9jqz8M7MQvy0F5mt+iEy+zbVKx75E
         hcl+Z+u0uNHUhhOYlmLOcPC6zPl479j23SlCDeRCyC0D9wRpt2H3Hhtjqh5SRzry/Dgg
         OH9bwipl6lJoEN2rurxdpSTEd/CBrLiAgbmLVjOgZiLf4nu04rx2E06s6YS4ULfZHKm/
         UTtgAzMJMXudK2fXA/x4q16m8amdnVgvl87OGDyyChZd/snVnEgHwhK4BlrFtHG4PXFg
         xaIRBGPO7A9/n0yvoHvWqcRC8pDpbFP7Z7tsWpwEsijE4h1YMbjPGulkSCF3+MI/nFvn
         jaAQ==
X-Gm-Message-State: AKaTC01aGlEoYiZRzo/lNVRJpAgvYjxdlW1HozRiueWMXRCK85FXicDM6vM2wBBJsyKmwT7clxHDNhO6289vFg==
X-Received: by 10.55.74.21 with SMTP id x21mr56864147qka.46.1481108954537;
 Wed, 07 Dec 2016 03:09:14 -0800 (PST)
MIME-Version: 1.0
Received: by 10.200.47.111 with HTTP; Wed, 7 Dec 2016 03:09:14 -0800 (PST)
In-Reply-To: <CALdXDfdXtc+FpePnGmE6_YDQ+8=wUZRqh4Xb65NJXUXaZnmELA@mail.gmail.com>
References: <01020158d1de0e71-ac079bb9-bc7d-4fb7-9ff7-60fd6955116b-000000@eu-west-1.amazonses.com>
 <CAE5ih79S+SFt-fsQ_2c4eXMankoXvoSE3zhxw39Y4XeQqQ9nMg@mail.gmail.com> <CALdXDfdXtc+FpePnGmE6_YDQ+8=wUZRqh4Xb65NJXUXaZnmELA@mail.gmail.com>
From:   Luke Diamand <luke@diamand.org>
Date:   Wed, 7 Dec 2016 11:09:14 +0000
Message-ID: <CAE5ih79cW8DwtEJz_TWLS=xcGgE9ZjdMzfCs9HVoMkgVFMwiPg@mail.gmail.com>
Subject: Re: [PATCH] git-p4: add p4 shelf support
To:     Nuno Subtil <subtil@gmail.com>
Cc:     Git Users <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Vinicius Kursancew <viniciusalexandre@gmail.com>,
        Lars Schneider <larsxschneider@gmail.com>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 6 December 2016 at 16:12, Nuno Subtil <subtil@gmail.com> wrote:
> Yeah, it looks similar. This change can be ignored if those have already
> been accepted.

Thanks, that's appreciated!

Luke
