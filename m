Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 485B41FF76
	for <e@80x24.org>; Thu, 22 Dec 2016 07:08:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756611AbcLVHIq (ORCPT <rfc822;e@80x24.org>);
        Thu, 22 Dec 2016 02:08:46 -0500
Received: from mail-it0-f54.google.com ([209.85.214.54]:38094 "EHLO
        mail-it0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751800AbcLVHIp (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Dec 2016 02:08:45 -0500
Received: by mail-it0-f54.google.com with SMTP id x2so72214838itf.1
        for <git@vger.kernel.org>; Wed, 21 Dec 2016 23:08:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=Mn7+6Mak8OsmPLJbU/w6UncaTg7wygHZdUZB0TfibjY=;
        b=oQ1+vFpRZYH1ph83HKYOeZxWMgIeUhK3airV+IbSo0T62+hgALCRmecQHKtmBkSPX2
         bOHvM5EdMqyTQsWNbftuflc9Jdse4yCVcO3L7eWfGxqH0tECpWxhJaMkXctWzurJxPBo
         YpKq/JXUNh5WqEKUL9jbdGOROgYdSD7q5BOTwURLpmRnOTVhEVnvwDZwkk7Lp0VNn5hw
         eE+Fby/Bpcb5m7nfzzY7ehdFDlUl6wQBffO1+U7u864rkJrw+02VsZzNn0wYufz2rpXX
         F1q43B3kkPHzI+ymKkGN4CGA+9AA+2xw94wBGm+3dYvYHJGta6eZ9WZFIH7cc2oxJoQW
         Q+rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=Mn7+6Mak8OsmPLJbU/w6UncaTg7wygHZdUZB0TfibjY=;
        b=CQyOkMwYGWsU/UdqlaqCM6zte/hoNUo1q2EICpU+hAA6z6+2Q6nabOY7EwuNnCIe/w
         8BUt4SLtwaTw7mwmF1uizDdywGjS+MJ5rNVwLae3t361EWYVhg+lccWxNGgVEetdt4f0
         eBWx1ge8Xl8lZC1LFZ6aZSjDBdU8nX0xEpm9oYDkEKk0F9gu8VV7CV4n5EfbjOIpKYRk
         PAw8E9RYvC+ogqiPIOsL6NUdZ8Q+BzPBfwcfI5RYLdjCJ5/ZCHjyXSSxSiTNawN5dF17
         d7/SbDQCzqDx/pUkWwjke1zPhlqdPFzci6BeqCipUqMSU1kwMmbWrk1Kwg3Tsstx2NOs
         BAMg==
X-Gm-Message-State: AIkVDXKmkuwDH7eYcmTXHJEUsbCzUdkE+MajiOqunpdUxmMnilhX+71497+rdWWXhD21ntRHTL6CG+/Du1QQYQ==
X-Received: by 10.36.57.75 with SMTP id l72mr11288075ita.11.1482390524616;
 Wed, 21 Dec 2016 23:08:44 -0800 (PST)
MIME-Version: 1.0
Received: by 10.107.6.163 with HTTP; Wed, 21 Dec 2016 23:08:44 -0800 (PST)
From:   Norbert Kiesel <nkiesel@gmail.com>
Date:   Wed, 21 Dec 2016 23:08:44 -0800
Message-ID: <CAM+g_NsvLUFD4hvCtFTCEeMSV9W5+kJeN2A3qZKWPhypoJmSXQ@mail.gmail.com>
Subject: Re: config for `format-patch --notes`?
To:     johan@herland.net
Cc:     git@vger.kernel.org, nkiesel@gmail.com
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thanks for the reply.  I did not knew that branch descriptions
automatically make it in the cover letter.
Learned something new!

Unfortunately this would still mean I have to manually add the branch
name to the branch description.

I will try to create a patch for adding a config option for the
--notes command line option over the upcoming
free days.
