Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9B5FD207D6
	for <e@80x24.org>; Tue, 25 Apr 2017 00:37:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S979523AbdDYAhq (ORCPT <rfc822;e@80x24.org>);
        Mon, 24 Apr 2017 20:37:46 -0400
Received: from mail-lf0-f51.google.com ([209.85.215.51]:35213 "EHLO
        mail-lf0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S979519AbdDYAho (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Apr 2017 20:37:44 -0400
Received: by mail-lf0-f51.google.com with SMTP id 75so82536189lfs.2
        for <git@vger.kernel.org>; Mon, 24 Apr 2017 17:37:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to;
        bh=dVVzwkIGa2ClYcPBqNxRCPU7oWsZalc37tpamW/N9Ec=;
        b=JhUeAozHYljmqeGtpZuPn+k2uwya+ztc4/F0QHdilSgl5rqAW1PZnTrl/4r46GF/r+
         QLQjE/56Jk9vQIQA2vL6doCzb16p7dlPWlRx7t2fNt73pZXZ661N2QqojF3RXFC6c1RG
         WpWhArFhqqWw/HoX7rmLAwI7kJueQMTgvnTErtUbEWGu1e+ZEblwhK1gfhW0PX+QV+jn
         96lKUUMyGqbCY/aUQlILFOjFe+ABJs9o/0lMmMAoyCJj+4FYLn6PevpvUKzpeXvMCvy0
         I+3Bded7Z88nhNiSMJQGq5W7YqmwYln/Cj1msND+VWrbn2yJmDrjHy/4rI77M6l0OWEZ
         3fZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to;
        bh=dVVzwkIGa2ClYcPBqNxRCPU7oWsZalc37tpamW/N9Ec=;
        b=nvIVpi4aePDhu8ASIBUyWoLPJBUUoxBj6YZq502ebwUxZkuMza99bxQV71wdI0pLwm
         KQuS/ObdTOEf4psD1r6oQ0oFTgfRaGpLzEZ+zu+XfavoY2HiRgrshYfjkd295iOK1LhT
         6qRjuqtbeV2zY/mCnzfyPje2piyof4G3GmC+Cj7lXNKM+B942qnMbhpucY3YWUJuPsKL
         YmeJpowvXecDMsEGgq3PCztxlygUe7JlPfBR53DOiUz5P/e7q7hQz3mZu4eZCQL/4xlt
         EY6TQDSA+elzK3hrbVYy/Ljp+m+b3bwo8OULqP6Gj6QzalZokz0ipjkXj9nV1NlY6IAT
         s6jg==
X-Gm-Message-State: AN3rC/45xvx5S/yiwSPmbqaRKuP07toCBhrMJx5WXNIYHUQUUKypMOzv
        MGGE7ELSqMGORfh0LKE2r9IHcauIQQ==
X-Received: by 10.25.24.217 with SMTP id 86mr9366532lfy.12.1493080662196; Mon,
 24 Apr 2017 17:37:42 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.25.17.155 with HTTP; Mon, 24 Apr 2017 17:37:20 -0700 (PDT)
In-Reply-To: <CAA0fXPtvxGydnSQfuB6OtYArPN3kb=sJDb3dnJrjdE-=2Hp5pw@mail.gmail.com>
References: <CAA0fXPu7s1-UQ-RBxvmPq0kGSsdt1wp9VJp7wNMZ_uE02RvCbw@mail.gmail.com>
 <CA+P7+xppiCsco2RmP_KeKO=yVO1LPvTgvBaEuMf1yVBNPtmnGw@mail.gmail.com> <CAA0fXPtvxGydnSQfuB6OtYArPN3kb=sJDb3dnJrjdE-=2Hp5pw@mail.gmail.com>
From:   Jacob Keller <jacob.keller@gmail.com>
Date:   Mon, 24 Apr 2017 17:37:20 -0700
Message-ID: <CA+P7+xreyO2U3kbw67V5wKx5TVqjKXMww_FY5TUgRfKcQZ6PLg@mail.gmail.com>
Subject: Re: I suggest a new feature: One copy from files
To:     Rm Beer <rmbeer2@gmail.com>, Git mailing list <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Apr 24, 2017 at 4:47 PM, Rm Beer <rmbeer2@gmail.com> wrote:
> 2017-04-24 3:13 GMT-03:00 Jacob Keller <jacob.keller@gmail.com>:
>> So, clearly you haven't defined the request very well. It *sounds*
>> like what you want is the ability to say "git please store and
>> copy/send this file to other people, but only store it once, and don't
>> allow storing history of it". This pretty much defeats the entire
>> point of revision control and doesn't make sense to me as part of a
>> revision control system.
>
> Not have sense the save history of revision control system for any
> binary files datas, who need save a multiple files by change any bytes
> from a files? Where i change any pixel of image, a word of odt/doc, or
> sound, music, driver, etc. In this case you only need 1 copy in the
> repository of .git , you not need a 100 copys in the .git, one by each
> day of change. You need a old image with a wrong pixel? not have
> sense...
>

Please don't drop the list :)

If you're not interested in tracking the revision history of a file,
it doesn't need to be stored inside a revision control system.
Instead, you probably want an alternative method for sharing such a
file. Git is primarily about tracking changes over time to a
collection of files in a project. It's also somewhat about sharing
this history to other people, but I wouldn't say that is its primary
goal.

In either case, you could instead use an alternative mechanism for
sharing the large binary file and have people grab the file this way.
However, it is incredibly valuable to share the history of a file so
that the other users can see what changed or make sure that the
version they are using works with the version of the other sources
they have.

In the case of binary files, you might want to use alternative diff
drivers to compare changes more easily, or instead provide some
non-binary data that is used to generate the binary files (such as
source code).

The whole point of revision history is to show that "hey this used to
have a wrong pixel, and now we fixed it, and here's how we did it".
Maybe the "wrong" pixel was actually correct and you find out later
that you need to revert this change. But the "later" is many months
and you no longer have the exact change so you're using memory or
external data to determine what to change again instead of the actual
history of a file.

Thanks,
Jake
