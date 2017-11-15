Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DE95C201C8
	for <e@80x24.org>; Wed, 15 Nov 2017 13:13:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757392AbdKONNN (ORCPT <rfc822;e@80x24.org>);
        Wed, 15 Nov 2017 08:13:13 -0500
Received: from locusts.copyleft.no ([188.94.218.116]:53034 "EHLO
        mail.mailgateway.no" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755891AbdKONNM (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Nov 2017 08:13:12 -0500
Received: from mail-qt0-f181.google.com ([209.85.216.181])
        by mail.mailgateway.no with esmtpsa (TLSv1:AES128-SHA:128)
        (Exim 4.72 (FreeBSD))
        (envelope-from <johan@herland.net>)
        id 1eExV7-0009Ol-M7
        for git@vger.kernel.org; Wed, 15 Nov 2017 14:13:09 +0100
Received: by mail-qt0-f181.google.com with SMTP id v41so34087209qtv.12
        for <git@vger.kernel.org>; Wed, 15 Nov 2017 05:13:09 -0800 (PST)
X-Gm-Message-State: AJaThX60OnHQcyLU51jvdXqY/mvq1QOuKe/wY4KUFSd8tWI1Y6dlXFrb
        icXdEgxTgE49RGj93kaZKF+cI3c7hQnhpvOdo7o=
X-Google-Smtp-Source: AGs4zMbmB4pxVErO4M3YXOIR9nX8UHrEX3TRizGVVrpkESKIjIQKD1DbeQIPFvSdnBgY/acbuhPZDpVEYcspllArP6o=
X-Received: by 10.55.187.193 with SMTP id l184mr1224255qkf.326.1510751583588;
 Wed, 15 Nov 2017 05:13:03 -0800 (PST)
MIME-Version: 1.0
Received: by 10.12.140.207 with HTTP; Wed, 15 Nov 2017 05:13:03 -0800 (PST)
In-Reply-To: <20171114161752.13204-1-tmz@pobox.com>
References: <CALKQrgc427=JNkkH+k+EohgKYuJSBPbDNR3uUcmGuf_ZyQ0X4Q@mail.gmail.com>
 <20171114161752.13204-1-tmz@pobox.com>
From:   Johan Herland <johan@herland.net>
Date:   Wed, 15 Nov 2017 14:13:03 +0100
X-Gmail-Original-Message-ID: <CALKQrgfs9QNg9AcQ_CGq43XkSpAAgS4L0KokpCj2qnhPa9+-=w@mail.gmail.com>
Message-ID: <CALKQrgfs9QNg9AcQ_CGq43XkSpAAgS4L0KokpCj2qnhPa9+-=w@mail.gmail.com>
Subject: Re: [PATCH] notes: send "Automatic notes merge failed" messages to stderr
To:     Todd Zullinger <tmz@pobox.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Santiago Torres <santiago@nyu.edu>,
        Git mailing list <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Nov 14, 2017 at 5:17 PM, Todd Zullinger <tmz@pobox.com> wrote:
> All other error messages from notes use stderr.  Do the same when
> alerting users of an unresolved notes merge.
>
> Fix the output redirection in t3310 and t3320 as well.  Previously, the
> tests directed output to a file, but stderr was either not captured or
> not sent to the file due to the order of the redirection operators.
>
> Signed-off-by: Todd Zullinger <tmz@pobox.com>

Looks good to me.

...Johan
