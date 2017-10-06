Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,PLING_QUERY,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 551991FC43
	for <e@80x24.org>; Fri,  6 Oct 2017 15:02:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751757AbdJFPCP (ORCPT <rfc822;e@80x24.org>);
        Fri, 6 Oct 2017 11:02:15 -0400
Received: from mail-io0-f174.google.com ([209.85.223.174]:50606 "EHLO
        mail-io0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751515AbdJFPCN (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 6 Oct 2017 11:02:13 -0400
Received: by mail-io0-f174.google.com with SMTP id 97so4022233iok.7
        for <git@vger.kernel.org>; Fri, 06 Oct 2017 08:02:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=Q9dxhvheRrreT4wrbRNEjTfd6vLpFA8PgwIb4KHd8vQ=;
        b=qdoPCkBKewNKEke+PeZNH4HHu4dX6G9P7c2UtsII+jqerZHL9lAfyboVYnjIlgvzLP
         Y1FpHZtlll6r623/C39XUrk3aGH9K1n6wEkCXRBaZ1GkOgfY8fiAWkF7JC4phoeiQbGD
         JJwya/YW57xBRZ4RCsZj9rEKxlcFr5vIeYgEyQrvjYZqO+pBakIzSrvrnI9Tcy4gbOBN
         oTdBYLnZ2PtHOGC6lwsY73jLlTx7q74xRwb+ZB3scFbcGeaKTOZPQNdAFrKDa2PArGpU
         WfrCUQp5fBOu2drBmPfzGeKCp1X//vywvo/bSztsuT1BamZdwCGubo3NZhhBqNmrO7Bm
         nMpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=Q9dxhvheRrreT4wrbRNEjTfd6vLpFA8PgwIb4KHd8vQ=;
        b=RMg5RFzcJPLK0FQPkkfzcvnc2gave7qCOYjd5iIGK2XnYpOGC0UmLX2Kgdh7XZYpcL
         1chtYqXbALVr6SS17ZlSsST32iaWvd3ZPUwO8GoA6Bxg3BUimYQCevqcX1BCrSkrn/hP
         qa6TgOE3GtiQZoNmTABj/gHDHTERZx7zpE3xmNhjNE6roodTfMHwrbmJgcWf7nL2+jkA
         I2jJ1AUa56QlO/wrY7/CP5GbYi3ViXTQxUaIMxsvO7nz0hM83+5Ssoj6wmaNOi0SizKl
         aAYO15z+8H3S3rlhO761G7mFYdS1DowSlBR93ZQGGfDydwv4gkkVZSytKK7SGDp7cg12
         AkXQ==
X-Gm-Message-State: AMCzsaXeh0+CXvWuIaAPiMFArsKSYrf0dlniLbQEw0iDzukdVBE73be+
        WWlR8O0Les0o218wRFrKNxBGkLH7OlhKuTCaex8=
X-Google-Smtp-Source: AOwi7QCjt7GtSDye1lEQQZ6xIi2Q+VDE5Oevlhl1y23MPPpY4zNflf6k73Utos1MJOFV0zhBDJvrJR88/X7ETjZNlZs=
X-Received: by 10.107.153.81 with SMTP id b78mr2781946ioe.231.1507302133111;
 Fri, 06 Oct 2017 08:02:13 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.79.115.198 with HTTP; Fri, 6 Oct 2017 08:02:12 -0700 (PDT)
In-Reply-To: <EC14D46D-61AB-4531-AE20-8C2B3F6B5A2A@gmail.com>
References: <EC14D46D-61AB-4531-AE20-8C2B3F6B5A2A@gmail.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Fri, 6 Oct 2017 17:02:12 +0200
Message-ID: <CAP8UFD1hTc0dXWmiF6aW6=_7DhB8zhvzOXy9hEXrfvgWwimJ7g@mail.gmail.com>
Subject: Re: git send-email does not work with Google anymore?!
To:     Lars Schneider <larsxschneider@gmail.com>
Cc:     Git Users <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

On Thu, Oct 5, 2017 at 12:52 PM, Lars Schneider
<larsxschneider@gmail.com> wrote:

> Of couse I tried to log in via web browser etc. Does anyone else use
> Google as SMTP server? If yes, does it work for you?

As I wrote at the top of:

https://public-inbox.org/git/CAP8UFD2j-UFh+9awz91gtZ-jusq7EUOExMgURO59vpf29jXS4A@mail.gmail.com/

I also got the same problem.
