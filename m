Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 324F3C433B4
	for <git@archiver.kernel.org>; Tue, 11 May 2021 22:19:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EAEF96191E
	for <git@archiver.kernel.org>; Tue, 11 May 2021 22:19:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230002AbhEKWU5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 11 May 2021 18:20:57 -0400
Received: from relay2-d.mail.gandi.net ([217.70.183.194]:54713 "EHLO
        relay2-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229994AbhEKWU4 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 May 2021 18:20:56 -0400
X-Originating-IP: 73.26.133.58
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gpanders.com;
        s=gm1; t=1620771589;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=2sOEx57M0m2t0ns39O/gDH5fMpa9tvHJI5ekrPZQri8=;
        b=K1ITvJLMXgRha69wGsNV07PuGjQGAoNMR0RD3Kh35aYc81Z4kra3rp41h7+UQg8E4MiIsr
        QUFKbju4YEU7NwYNUUxO0uR190NeeG4CJQU842OJumiOZTzMqSXwwqwQjk+tqcqqx81Qiu
        E0ocC0jnT8dKrQRspRnJjwiitUsHcGNlQtzlBwquX7THTzby7yQ5JyaGxIBWtcBpPhpXay
        DHsPGdZn3OmMFYMZsoTWE0TJazICpTXEnHKCzMW7ZMmw72FT2x16X5c9vwUY71cibJo3n+
        HkD233DcKu5TIKeFepQfkdf6q3tpKQWX2NQtMoFOLwLxWoatWey5dnY8wTvSEg==
Received: from localhost (c-73-26-133-58.hsd1.nm.comcast.net [73.26.133.58])
        (Authenticated sender: greg@gpanders.com)
        by relay2-d.mail.gandi.net (Postfix) with ESMTPSA id B6C7F40004;
        Tue, 11 May 2021 22:19:48 +0000 (UTC)
Date:   Tue, 11 May 2021 16:19:46 -0600
From:   Gregory Anders <greg@gpanders.com>
To:     Felipe Contreras <felipe.contreras@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v3] git-send-email: use ! to indicate relative path to
 command
Message-ID: <YJsDAnHcnro6Gfk4@gpanders.com>
References: <20210511191510.25888-1-greg@gpanders.com>
 <609ae32e3b9f_60649208e0@natae.notmuch>
 <YJrsTu5YtGNpQvZh@gpanders.com>
 <609b0017a323b_6064920888@natae.notmuch>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
In-Reply-To: <609b0017a323b_6064920888@natae.notmuch>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, 11 May 2021 17:07 -0500, Felipe Contreras wrote:
>It would be much better to have sendemail.program, and then we wouldn't
>need to deal with these workarounds.

Frankly I agree. Should I modify my patch to add this new option instead 
of modifying the behavior of smtpServer? Obviously the smtpServer option 
would need to preserve its current behavior for backward compatibility.
