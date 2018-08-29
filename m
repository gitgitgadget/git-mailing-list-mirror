Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8F1C81F428
	for <e@80x24.org>; Wed, 29 Aug 2018 16:30:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727743AbeH2U2g (ORCPT <rfc822;e@80x24.org>);
        Wed, 29 Aug 2018 16:28:36 -0400
Received: from mail-ed1-f53.google.com ([209.85.208.53]:44896 "EHLO
        mail-ed1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727293AbeH2U2f (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 29 Aug 2018 16:28:35 -0400
Received: by mail-ed1-f53.google.com with SMTP id s10-v6so4379031edb.11
        for <git@vger.kernel.org>; Wed, 29 Aug 2018 09:30:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=cboHgH+gD+KDYUR90i6b+ZT+EkQ1h1fuX8+XfNYMlgQ=;
        b=EXOggD3ihCDZFsO/o/JYfkthNnrbJJeoQbAwZcJRP+2w5F8SLbHYoa+5eo3viJAOU5
         0VMVaCZ8cIiHQWxye0SIlkiYbJh19s8HzZkOKYCLCIgLX8QQKTBj75FBvlHPtSQB4xj9
         CTH9kwt5c5a+EFbfXP/QzcaSl2i0kdPyTWlbnptUooKFlz7XHQ8xGwzetOuZ6qnJ/Fv3
         tv3wxKx9kCFEQjAH58izHLFv+zYNG+BG5Kc+bvJrPvPARPjH4BlISBHZ0vHTkIuA/yP2
         B77D9rYTXZlGwD+JEIqnO9frzzZJpxyqwusoEHl7H8Gw1lv9hlGHMKNI6fYcvN/tZgK2
         0I8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=cboHgH+gD+KDYUR90i6b+ZT+EkQ1h1fuX8+XfNYMlgQ=;
        b=g+e9KCvpgUTKghMZ9RyrC9nmZj/jphU+jsgQgN0aOELwS2E/WSaPq2rFmb/5bCPg75
         ggNW8+FuUopEgg4sPNJQmKtfAa/Z2FduEGdH6t8hofoNy97E9IZP8Tp4Z6Qqiui+ZD7V
         Yz04dTztPiBLTbTNK2EcsiKFDGutmqC8Y9Mme37At+k8xAo3Uq4PudbRpbwmTk/8+D3o
         XLrRI5Wr0IMS7EGY240McMNuUGv6z5l6Q+2lRsnFbufxUR8GxVgqhrVw1ZPw5efEOAdM
         xocwdmqlveXGZTDgKowkHBAIwofDpu5svCuV69XWpnc2vvaUam3UzBFZpJFI9j2fWleq
         cWYQ==
X-Gm-Message-State: APzg51DgLUDSUkUqWsggWljYyboO1DjHSfyMar0+KiQvgisST3cYEXau
        ppfqIrFzC8f17WOZfUXc6eY=
X-Google-Smtp-Source: ANB0VdZtAuhyV+hiyNE9I5gDR3a3k9eHv8q6TpjgPqIdCwfstC5PACHhUioNZ6x0B3+ztvM7/k1qSg==
X-Received: by 2002:a50:95a8:: with SMTP id w37-v6mr8242340eda.33.1535560252250;
        Wed, 29 Aug 2018 09:30:52 -0700 (PDT)
Received: from evledraar (g74155.upc-g.chello.nl. [80.57.74.155])
        by smtp.gmail.com with ESMTPSA id o22-v6sm2292374edc.90.2018.08.29.09.30.51
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 29 Aug 2018 09:30:51 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Andrei Rybak <rybak.a.v@gmail.com>
Cc:     Eric Wong <e@80x24.org>, Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        git@vger.kernel.org
Subject: Re: Thank you for public-inbox!
References: <nycvar.QRO.7.76.6.1808271552580.73@tvgsbejvaqbjf.bet> <20180829050745.GD15274@sigill.intra.peff.net> <20180829100243.GA28180@dcvr> <3eb1c5e8-3e89-0d2e-30b1-339f38c4c703@gmail.com>
User-agent: Debian GNU/Linux testing (buster); Emacs 25.2.2; mu4e 1.1.0
In-reply-to: <3eb1c5e8-3e89-0d2e-30b1-339f38c4c703@gmail.com>
Date:   Wed, 29 Aug 2018 18:30:50 +0200
Message-ID: <871sahdtj9.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Aug 29 2018, Andrei Rybak wrote:

> On 2018-08-29 12:02, Eric Wong wrote:
>> Anyways I hope to teach public-inbox to auto-linkify Message-ID-looking
>> strings "<XXXXXXXXXXX@XXXXXXXX>" into URLs for domain-portability,
>> (but it's ambiguous with email addresses).  But yeah, I don't
>> like things being tied to domain names.
>
> This would be very useful for people who use MUAs without
> Message-ID lookup capabilities, even without domain-portability.

FWIW Many MUAs have some hidden way to do this, for example to find the
E-Mail I'm replying to (your E-Mail) on GMail:
https://mail.google.com/mail/u/0/#search/rfc822msgid%3A3eb1c5e8-3e89-0d2e-30b1-339f38c4c703%40gmail.com

I.e. rfc822msgid:<message-id>

Confusingly Google Groups accepts the same syntax, but will barf if you
include the <>'s, but that's from memory, maybe I misrecall or they've
fixed it.
