Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 560282022C
	for <e@80x24.org>; Sat,  5 Nov 2016 12:17:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754131AbcKEMRw (ORCPT <rfc822;e@80x24.org>);
        Sat, 5 Nov 2016 08:17:52 -0400
Received: from mail-lf0-f48.google.com ([209.85.215.48]:35697 "EHLO
        mail-lf0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753822AbcKEMRw (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 5 Nov 2016 08:17:52 -0400
Received: by mail-lf0-f48.google.com with SMTP id b14so82271794lfg.2
        for <git@vger.kernel.org>; Sat, 05 Nov 2016 05:17:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=fMfRJxVJ0+kEUT6n2qJJT5ejfWNFrylES0vC+RmM1rk=;
        b=N7c1WJeK9HmrEVcoaBZ6icFF3Wr7hb93+7whzLvUTTu0FBWXHbeHEad/Oot3SrTxf2
         6MS8acqeNQXRNhN0DUTwUKdzjIkV2nTtRPIzkhH8O9HEcjVX8/S01EiJmZWczUDyxSoL
         EOkYNblvSREzGVpJORBP72kPfxeSktah8vyAPZnlBvFEKepZ0J+z6C8lNJsqlqa6dpL1
         MkZsNvcsokRVjze42QsZ1wsAt9t309snR2ntcbkgnP8ZwVyNGUICfp4srj8JEp1Z+083
         dwvBLQDfOB5VXrnk4VqiBk+ARXJTYc7eLUAZmOLN4+M+9nSQwz/5gVLMaukxwFIZEeH7
         kBPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=fMfRJxVJ0+kEUT6n2qJJT5ejfWNFrylES0vC+RmM1rk=;
        b=Gip01QcW6AV6Ah4q6wBGqcagLBW16EOfgDmKVOq6KhqXl28UQGFpdV4fBKchB8cnI+
         msZF7+QNqj1qkY6RGO/YPxwHSEgVII2umApbUEy6sUCBLuTFVJnUsB1ChGodIL3PJ/+D
         fhnS6+6bU5g5WV0Doy9endm9kwHR7nDZ0WhoZ4iBol0O0bS0rbCsIQVuiZyf12Nd/av3
         GvUDhUwkyM8kUKEP4iJqbRYyCXtiCP13jr7pjRoG9PhJAyBPHwkYmeEbXTwYoI3x10Yb
         YXzVOJ/aMkKeLEqAe3aW3lj1kpnY8DatEAkHuYfbR6gC17QFR/DTAocnWuhvg6D7WJyJ
         7Lzg==
X-Gm-Message-State: ABUngvfB4LMzmNI1QQq0QD/o3v2vus5nORIpJhQMCNamHDBIOHGor5PZMP+NEi6LRkxTksgVqX2YkKSAHs9mZg==
X-Received: by 10.25.74.85 with SMTP id x82mr8390650lfa.154.1478348270241;
 Sat, 05 Nov 2016 05:17:50 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.25.163.84 with HTTP; Sat, 5 Nov 2016 05:17:49 -0700 (PDT)
In-Reply-To: <xmqq1syqedv4.fsf@gitster.mtv.corp.google.com>
References: <xmqqa8dfdt6y.fsf@gitster.mtv.corp.google.com> <CAP8UFD2+A0MUKazAfSwCvv61TJRPuoOzH5EkqcrBOUi4TcuoDw@mail.gmail.com>
 <xmqq1syqedv4.fsf@gitster.mtv.corp.google.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Sat, 5 Nov 2016 13:17:49 +0100
Message-ID: <CAP8UFD0bqNQZ3nuGUDX0qrSo44hf1NL9LeZB_FQcXg3j0mD38A@mail.gmail.com>
Subject: Re: Regarding "git log" on "git series" metadata
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Josh Triplett <josh@joshtriplett.org>, git <git@vger.kernel.org>,
        "Shawn O. Pierce" <spearce@spearce.org>, Jeff King <peff@peff.net>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Nov 5, 2016 at 5:42 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Christian Couder <christian.couder@gmail.com> writes:
>
>> Couldn't a RefTree be used to store refs that point to the base
>> commit,
>
> I think it is the other way around.  With the new "gitref" thing
> that is a pointer to an in-repository commit, RefTree can be
> naturally implemented.

Yeah, I should have read Shawn's RefTree email thread again before
posting and especially before replying to Josh.
