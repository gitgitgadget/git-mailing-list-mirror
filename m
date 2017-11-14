Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 87B841F43C
	for <e@80x24.org>; Tue, 14 Nov 2017 16:15:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753087AbdKNQPP (ORCPT <rfc822;e@80x24.org>);
        Tue, 14 Nov 2017 11:15:15 -0500
Received: from mail-qt0-f175.google.com ([209.85.216.175]:53013 "EHLO
        mail-qt0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750714AbdKNQPN (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Nov 2017 11:15:13 -0500
Received: by mail-qt0-f175.google.com with SMTP id 31so26171433qtz.9
        for <git@vger.kernel.org>; Tue, 14 Nov 2017 08:15:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=klYoFzllSfOJMJb3L2+LmOj/KkdTXNiGn/iYao0KmBw=;
        b=AAP8UBbut6jW4IYC0fzEZCmYfRCxi8YNzliNlfes7RDNl1NLZew6CWfEktCU5Z+Vnu
         b4UG1MpUn5qoPYDnwRRAW89L5w0IyuB/PQyM0WuBrGqEgG+QOVzIrh577pJpxMM36oFr
         /Z7FZ9XfmtVt7HbydW2aks2ezeqmFgWIVRpeSR3qtBxoX/SqlLPB37Bmpsr5nJx5jMvq
         s7uhFbqJfVcYjANqdIAQBqV4h3t+MVYIrwxyzzIqPRElTvp0hdlAg/hDkBQIwyiIDMWP
         /IACTadVp+yIsUbnUVamDCA+adn8QnD8XKZ5V4dB4kRd9tvV3TrC3O+zuytcDoHvpA8i
         esNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=klYoFzllSfOJMJb3L2+LmOj/KkdTXNiGn/iYao0KmBw=;
        b=qkLCToqEyOqW3MO5C3+AxShOMdVfek2z4qSkwbvt+DdYCJya0RiqcHjA9vTHtnvkSr
         CPGcCKTso+nZqKD4aMT3E+0Rbhyj0WI5td+tV4zuaVj67tMkH4K7PkK+mtdRCy4csaWQ
         vOTxtg/D5lbKg6KXI9Su4sDbN+TkqyqPfIUJrI0SHOgwQQR3qa1EXEGsHkgOWK2IKQS4
         c4QUtk/Eq3Cu8O5GFSWE4xKtwxEEy5eovrB7DZ8u4VYUqqTuDIz3kGdNnau5FDm62zDJ
         DAzagFo9AUt0q3Lesmfc7jj3mhpmmMmHfFbpNAZ8apZIff1bynvKwL69gaSinBS9Fmit
         W7Wg==
X-Gm-Message-State: AJaThX4p34arYoc/LMz6f/iSl9T0fyjEDxrE+C0KCaUZtU+R3QKKH7s8
        Psp9rHbOAyWwZEsDLNSbjfWU+PAjDIROz9jbDQ+Suw==
X-Google-Smtp-Source: AGs4zMYrLGIebYFSvhxeQ4r/Sd4G4DvINHOJ20Gt6MNcLcaTkZ3f7ek4ijgLl4D75vGyK+ApfCajP9EWGS7VRPv8Ki8=
X-Received: by 10.129.90.8 with SMTP id o8mr8499065ywb.384.1510676112993; Tue,
 14 Nov 2017 08:15:12 -0800 (PST)
MIME-Version: 1.0
Received: by 10.13.203.85 with HTTP; Tue, 14 Nov 2017 08:15:12 -0800 (PST)
In-Reply-To: <CAJ_+vJ5J250CtzVg4QwEusddviDSYuJhubsbTJyv5Nc2conAfA@mail.gmail.com>
References: <CAJ_+vJ6FXXda4fe7=1YxtDGR2d8CqP4KXN+YR6+mdQ+5jQQXug@mail.gmail.com>
 <8b3225ce-a4aa-56ee-5296-6cc7528556d1@web.de> <CAJ_+vJ5J250CtzVg4QwEusddviDSYuJhubsbTJyv5Nc2conAfA@mail.gmail.com>
From:   Ashish Negi <ashishnegi33@gmail.com>
Date:   Tue, 14 Nov 2017 21:45:12 +0530
Message-ID: <CAJ_+vJ7Yfcpz5252M4XJnDmEDCANp+eJ7RLJJF8TCcTxexZEUA@mail.gmail.com>
Subject: Re: Changing encoding of a file : What should happen to CRLF in file ?
To:     =?UTF-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

After changing the encoding of file to utf-8, same command gives:

git ls-files --eol file_name
i/lf    w/crlf  attr/text=auto          ApplicationManifest.xml

On Tue, Nov 14, 2017 at 9:43 PM, Ashish Negi <ashishnegi33@gmail.com> wrote:
> Running the command gives me :
>
>       git ls-files --eol file_name
>       i/-text w/-text attr/text=auto          file_name
