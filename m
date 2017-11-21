Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 690E42036D
	for <e@80x24.org>; Tue, 21 Nov 2017 21:24:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751345AbdKUVY1 (ORCPT <rfc822;e@80x24.org>);
        Tue, 21 Nov 2017 16:24:27 -0500
Received: from mail-qt0-f177.google.com ([209.85.216.177]:36233 "EHLO
        mail-qt0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751145AbdKUVY0 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Nov 2017 16:24:26 -0500
Received: by mail-qt0-f177.google.com with SMTP id a19so21158703qtb.3
        for <git@vger.kernel.org>; Tue, 21 Nov 2017 13:24:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=w6TvRpv1lnUCUdK3dwc1ewh/9K3KYla9021zU+ycWmA=;
        b=kDzOMynY+51Imf1Icwz3+VHduNAyiqPazE5ivvutO3dGY6eFdXv/ADuSbt6q3+ORu7
         Pdy5Sa7RW5XD4yZ6KMXTmylBmofIfN6AhIv+1ct33J3+wY8YvLnzBVab/vtZtg+6rbTW
         k+HS7Pf3Rdw9bcbq1haO+3I5fny0hw70rwlVAkZroKr+DRRQ36MBNGUOFmlGOwagaEgT
         is3JWB3V9K9nW9IG6u6/614F2ufpfWBB9kV/auCP3OvN89AALZVwqOD2djw33RkSsXQq
         5MAQVq9ZImnvxE7PbiVctDfYJB0N9Abtw5SS8ciPc9Ba2LSrHon4VjAsnkDfCFm6N80Y
         0bVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=w6TvRpv1lnUCUdK3dwc1ewh/9K3KYla9021zU+ycWmA=;
        b=tgWD5dk/fA7rervWvhNQrh4sNnNg2HQXZ63ZMfqWxzd2wkyxRjUqWKZ0Sql3OOZmqG
         ytQBKKmuUdgRbUsxoUN9mTBiFtjnbqzpxxdm/3MfZElb3n7ewhi23jSqXuUEdFp9gEmi
         4CkdTzMVv6ysxmM1jUyAXmwtDNMytE9vv/mf/e6tDHtAZ4vTT2RtBehWgqQwNPTRJaPa
         FP9jvkTJQZP6z8p6kxpP7rMZWRvM8enGvY5NbnKLixglNvrbqqO3Yg8Sa3pNDvxdXkhG
         YBrp1Lt3lBBsExk/wQIw5dkcTqCbLXTp2Kketcb+gu5QXC3uSToHCED0Gyp2uOLQN6or
         D9pg==
X-Gm-Message-State: AJaThX5aQ/bCBzIQE10TLFZ1/ihpZfKgUK+U4uU4nyhLPS2j7gBqPH/f
        sCIzlLcHSepmylKelbBq71l5ZIqWF7cs10omd0Y=
X-Google-Smtp-Source: AGs4zMad0hNECjsjyz8WdusIb6dtOgvFVuu6QVcAumjEHmMl3kkbw/Gb0d4F1OKiU3OQWrPy8JBPciKlBcU4nuDMgL8=
X-Received: by 10.200.35.28 with SMTP id a28mr10563147qta.51.1511299465566;
 Tue, 21 Nov 2017 13:24:25 -0800 (PST)
MIME-Version: 1.0
Received: by 10.12.155.209 with HTTP; Tue, 21 Nov 2017 13:24:25 -0800 (PST)
In-Reply-To: <alpine.LFD.2.21.1711211551230.24935@localhost.localdomain>
References: <alpine.LFD.2.21.1711211551230.24935@localhost.localdomain>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Tue, 21 Nov 2017 16:24:25 -0500
X-Google-Sender-Auth: Ah4CgndDlYhIvKt0DopAfQYQM4g
Message-ID: <CAPig+cS2i1WOYg1d3fup0PPq_HzJE_XXXtkEMqxq=1Fc9E1sMQ@mail.gmail.com>
Subject: Re: [PATCH] gitcli: tweak "man gitcli" for clarity
To:     "Robert P. J. Day" <rpjday@crashcourse.ca>
Cc:     Git Mailing list <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Nov 21, 2017 at 3:53 PM, Robert P. J. Day <rpjday@crashcourse.ca> wrote:
> No major changes, just some rewording and showing some variations of
> general Git commands.
>
> Signed-off-by: Robert P. J. Day <rpjday@crashcourse.ca>
> ---
> diff --git a/Documentation/gitcli.txt b/Documentation/gitcli.txt
> @@ -13,7 +13,7 @@ gitcli
>  DESCRIPTION
>  -----------
>
> -This manual describes the convention used throughout Git CLI.
> +This manual describes the common conventions used throughout Git CLI.

The Department of Redundancy department...
