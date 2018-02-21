Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 44E251F404
	for <e@80x24.org>; Wed, 21 Feb 2018 23:57:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751000AbeBUX5J (ORCPT <rfc822;e@80x24.org>);
        Wed, 21 Feb 2018 18:57:09 -0500
Received: from mail-ot0-f181.google.com ([74.125.82.181]:41417 "EHLO
        mail-ot0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750752AbeBUX5I (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Feb 2018 18:57:08 -0500
Received: by mail-ot0-f181.google.com with SMTP id w38so3076557ota.8
        for <git@vger.kernel.org>; Wed, 21 Feb 2018 15:57:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=clarifai.com; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to;
        bh=+RxITBcHry8HfBqDaSH0bHDvkOajS3ZP0LzKMt87sKk=;
        b=lDqEq3kxjcQ6W73z2A38twxLSZ68BRgAw4EzOLlCYGyuKtC+b1XviZCWY+4Q5jsoK7
         URy9hsL1baqLpaF39MPnBUrSb7aRspZTQd2OZfrpNs21dFUK6u7OC+TCvzs2qZu3kwo/
         k1oPuR2GMSVY/D9aq5MRZL7ItUw+0KFxKmB78=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to;
        bh=+RxITBcHry8HfBqDaSH0bHDvkOajS3ZP0LzKMt87sKk=;
        b=GHVguNgxJJJHiP1OwFicVQ9KMH/YphcnDiUBa9wgnGIsfeODwHk8ClaG13AAlu+oE6
         YQulr9UhmH/Z+z6Slaiw+QrOY2tQqqY4bJsoitNkV3E9fqu9stXPDt3QeJDJR8+EME2z
         989mubHXsByn+eTj5qacSl7t5CuMxTyogaZ1NBlESL2S+cZz54k9rmtE6Mt0N1CSbvBL
         GUQWgm1PseO8MW7opwgInu1YCk/CWBb6KHODB3ZKaM3usSs0QulSctwpOevjYbZVvqIi
         ilQsXFYsjFSiEv00Btdibv1dKHwwTuTMX+W8OGmBkziY1paBZQiUq9WV0OGe0xqtCHNg
         L6LA==
X-Gm-Message-State: APf1xPDzGlv6TEhge7RhkGkDghoDz2ctOV5DJ2HeOZ/N5McarDNd5pk/
        Z44UBH849XkBGOCKMe6iQQJkSVQFX9zlW0TZN/10M+/cVVc=
X-Google-Smtp-Source: AH8x227oeYjKmTwbJzpLAjpLd9GDaovXQSJMSeE9FaLveP7ewRhp2HpHbsFKypq0YQXnH8TKjFaGBu8gNWsQtJdoW+M=
X-Received: by 10.157.1.75 with SMTP id 69mr1443464otu.9.1519257427635; Wed,
 21 Feb 2018 15:57:07 -0800 (PST)
MIME-Version: 1.0
Received: by 10.74.138.221 with HTTP; Wed, 21 Feb 2018 15:56:47 -0800 (PST)
In-Reply-To: <CAPFeJUA=7NyZZxkjpYjoRiXTb1WA1cQ-dYsn_XykMYt=iWGKOA@mail.gmail.com>
References: <CAPFeJUA=7NyZZxkjpYjoRiXTb1WA1cQ-dYsn_XykMYt=iWGKOA@mail.gmail.com>
From:   Josh Tepper <josh@clarifai.com>
Date:   Wed, 21 Feb 2018 18:56:47 -0500
Message-ID: <CAPFeJUBZCZ2RxzZrF3Nd+rBBRhERpQV3ka6a6r+yMfk=gEg8gQ@mail.gmail.com>
Subject: Re: Bug: git log: boundary commits do not respect order (e.g.
 date-order, topo-order)
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

TYPO IN EXPECTED OUTPUT.

To avoid inevitable confusion, creating new thread "Bug: git log:
boundary commits do not respect order (e.g. date-order, topo-order)
2".

DON'T REPLY TO THIS MESSAGE.  Instead reply to the new message

On Wed, Feb 21, 2018 at 6:28 PM, Josh Tepper <josh@clarifai.com> wrote:
> When using git log, boundary commits (ie, those commits added by
> specifying --boundary) do not respect the order (e.g., --date-order,
> --topo-order).  Consider the following commit history, where number
> indicates the order of the commit timestamps:
>
> <view with a fixed with font! 3's ancestor is 1, 6's ancestors are 4,5>
> 0----1----2----5  <--A
>        \         \
>          3----4----6  <--B
>
>
> Executing the following command:
>
> $ git log --boundary --date-order ^A B
>
> Should produce the following order (boundary commits shown with dashes):
> 6 -5 4 3 -1
>
> However, it in fact produces:
> 6 4 3 -7 -1
>
> Please advise.
>
> Best,
> ~Josh
