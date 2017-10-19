Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6F09F202DD
	for <e@80x24.org>; Thu, 19 Oct 2017 22:29:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754407AbdJSW3Z (ORCPT <rfc822;e@80x24.org>);
        Thu, 19 Oct 2017 18:29:25 -0400
Received: from mail-wm0-f48.google.com ([74.125.82.48]:47013 "EHLO
        mail-wm0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752738AbdJSW3Y (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 Oct 2017 18:29:24 -0400
Received: by mail-wm0-f48.google.com with SMTP id m72so18672252wmc.1
        for <git@vger.kernel.org>; Thu, 19 Oct 2017 15:29:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=BxzLyR/lopOOcCsBv25jLLrPGNop7Z8yz2Q507ytBgM=;
        b=Eqy5ZkEINavlAv1C8DoUGGbBz72A/51tbh5N6U6Zuyk5jHwVNuPZ0IcaNP4x6ncYwV
         ODOzozOWOGeNl1WCmiaNa5ufqAESAv8Pvq9Bq0fTWvbwa+NGeli6NyjhekSof+A4vZSV
         glOA+ZedPaUMtnPOXMkNcYXXIr9nSaqWPYfD/fLde8iDdzQqFH0sFUL/0XDmTXWxW/Vd
         ZZ5jASiYBqKPzgG70g5G3uPJ3TQUHu5CXwrvqasBgVkyrxF3XwiU7njh76pOevags17b
         CiJDcJWmuCsoTzY1cz4V1mvaboqhM8fdSVAGnWJ9S7ATA5DmKRL51Mz7e5xTNUGkYEhT
         lzaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=BxzLyR/lopOOcCsBv25jLLrPGNop7Z8yz2Q507ytBgM=;
        b=Gh22aGuZslDtUWCKVNGPgkaHOPDY4YniW/S51R1fvlAydn5IA5zA2in3yBKRyqjEXz
         daPQmJt8V1oCZtOrTrwnKxVTEJHSP3jm6U5DYyIkeY42AyxoR10r0opwIO+TcHvGHQcw
         +7U0zoDYICEGmhOWrBMeLMxlxxu5SnWfTc9s8gzhO1rPcy28VoYqfgxhLVgyWPlIa6Vi
         hud7WLYcCWFJF9A4Iyeqb2B4lEbzyV/a0HqvwpiHlP7zLXo16Y4rrJLxg5xplnZYn0o0
         zswpKNhbCSa1A53Yyqm6aQfZJd8AXYP3+QuJlgMptVnH+pwqAhhg9AXsqdBJ9GHTNh+Z
         vmvQ==
X-Gm-Message-State: AMCzsaWe+nSfeHmtJE0wCzJSgfHLbPfLa6BdkCfRiz+5Pcqoy6L3Mc9p
        e+ihDhbqMDlEmVsJf9Cbk18=
X-Google-Smtp-Source: ABhQp+S0utlSpF8ybhbBUnNCelAfxrYWd5Mj34PqUNWXkks0aoFlOJ+6s4Q9jUt23bC7wYiYvNwheg==
X-Received: by 10.28.217.136 with SMTP id q130mr2735780wmg.89.1508452163325;
        Thu, 19 Oct 2017 15:29:23 -0700 (PDT)
Received: from neur90nellw.ads.autodesk.com (adsknateur.autodesk.com. [132.188.32.100])
        by smtp.gmail.com with ESMTPSA id r68sm2613385wmd.4.2017.10.19.15.29.22
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 19 Oct 2017 15:29:22 -0700 (PDT)
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: Minor man page weirdness?
From:   Lars Schneider <larsxschneider@gmail.com>
In-Reply-To: <20171018032103.p6bz7wciiedokiyy@sigill.intra.peff.net>
Date:   Fri, 20 Oct 2017 00:29:21 +0200
Cc:     Junio C Hamano <gitster@pobox.com>,
        Andreas Schwab <schwab@linux-m68k.org>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Content-Transfer-Encoding: 7bit
Message-Id: <A34B4C99-94FD-4EF2-AE60-0522D621BAE6@gmail.com>
References: <A4E5D8CC-19A7-442A-814C-FD5A46391982@gmail.com> <20171016225641.x76jwycb7mcpvrw3@sigill.intra.peff.net> <87zi8psli3.fsf@linux-m68k.org> <xmqq1sm1o5k5.fsf@gitster.mtv.corp.google.com> <xmqqfuahkwug.fsf@gitster.mtv.corp.google.com> <20171018032103.p6bz7wciiedokiyy@sigill.intra.peff.net>
To:     Jeff King <peff@peff.net>
X-Mailer: Apple Mail (2.3124)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


> On 18 Oct 2017, at 05:21, Jeff King <peff@peff.net> wrote:
> 
> On Wed, Oct 18, 2017 at 11:34:31AM +0900, Junio C Hamano wrote:
> 
>> -- >8 --
>> branch doc: sprinkle a few commas for readability
>> 
>> The "--force" option can also be used when the named branch does not
>> yet exist, and the point of the option is the user can (re)point the
>> branch to the named commit even if it does.  Add 'even' before 'if'
>> to clarify.  Also, insert another comma after "Without -f" before
>> "the command refuses..." to make the text easier to parse.
>> 
>> Incidentally, this change should help certain versions of
>> docbook-xsl-stylesheets that renders the original without any
>> whitespace between "-f" and "git".
> 
> Thanks, this looks good.

To me, too! Thanks for investigating and fixing the issue :-)

- Lars

