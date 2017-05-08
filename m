Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F12E920188
	for <e@80x24.org>; Mon,  8 May 2017 05:12:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752125AbdEHFMd (ORCPT <rfc822;e@80x24.org>);
        Mon, 8 May 2017 01:12:33 -0400
Received: from mail-pf0-f196.google.com ([209.85.192.196]:34149 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751885AbdEHFMc (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 May 2017 01:12:32 -0400
Received: by mail-pf0-f196.google.com with SMTP id w69so2612077pfk.1
        for <git@vger.kernel.org>; Sun, 07 May 2017 22:12:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=8H1cD+HFslycRrcR0MyjUI8bnTXT/0oJGc7o7W/bnCE=;
        b=UxnUhuzbkidZKwjk4J8p8+rXyDzSfidmxHHj8iS2tnWe4hDhGLnKq5j1yvcHJNTt/K
         BYE2Uddm4ilhWLSAAgP//EXMoonb0bBmPq36GQhuqqc0GgjhKdJP3dl7iuCtRpM1JOG4
         oNxVcz1iVOXy3NyO+XF3wu/a7GbtWMiaia52BM0wCVloPEK6jaIhTijLy85e5cpeHOvD
         Ao+cnTsOhj11YRtSaS8N2KAmlG1OujNx0nb9HCnVyW0DQ4R5Diuf9fovgbElHLiGH0Gk
         bmoyPa0NsozL+iZGwIxgAv2jXp/S/f0AuxN1SwThE7L4tKe9iD3AEC++ACm55tiWeESR
         wQHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=8H1cD+HFslycRrcR0MyjUI8bnTXT/0oJGc7o7W/bnCE=;
        b=cmfjjgb3FelkSjOZ3d+Xg+wGZdzDYQGPu54CShNRtjpMXeP2+9wApptJ+77rJkfQxj
         xjE5FMTJwqIXHULIySm9xhQfbNGavxC+dNwkFIVdi+t2g/C/Fqd8QFJ64XoKrGDzbWgI
         GEMSv/kL1+xp0pZf9pbeT+NqLLe7cugPC9W8zFq7t7qYuOXJuWJxqgqXvHzi6XQD6y6r
         h32y1X0FOXzfRhSTdqD6Bu+u8WmCcIIXoozrI6gdT7vR1vf6Dd+I+iHCjkQKqw0+4Qfp
         MCJA1lEFWhFXK+/mZrlfoYluT5yJy0txpvKetSX0RbvDGKlaKmGqmziH9dH0dMAj6aje
         ItUQ==
X-Gm-Message-State: AODbwcDFHIVIhesYTQP8Ruld8bpWbixXwxxHR1JULTrOGmZSGpclvKgS
        VQbBXhGN1oq8EA==
X-Received: by 10.99.51.74 with SMTP id z71mr9963772pgz.137.1494220352159;
        Sun, 07 May 2017 22:12:32 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:2823:d4da:fd9a:464a])
        by smtp.gmail.com with ESMTPSA id n22sm13086152pfj.27.2017.05.07.22.12.31
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Sun, 07 May 2017 22:12:31 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <johannes.schindelin@gmx.de>
Cc:     git@vger.kernel.org, Jonathan Nieder <jrnieder@gmail.com>,
        Jeff Hostetler <jeffhost@microsoft.com>
Subject: Re: [PATCH v2 4/7] t3901: move supporting files into t/t3901/
References: <cover.1493728172.git.johannes.schindelin@gmx.de>
        <cover.1493891336.git.johannes.schindelin@gmx.de>
        <f63ec7ce151febfc7bc64cfbf424d93b56a92ef5.1493891336.git.johannes.schindelin@gmx.de>
Date:   Mon, 08 May 2017 14:12:30 +0900
In-Reply-To: <f63ec7ce151febfc7bc64cfbf424d93b56a92ef5.1493891336.git.johannes.schindelin@gmx.de>
        (Johannes Schindelin's message of "Thu, 4 May 2017 11:49:58 +0200
        (CEST)")
Message-ID: <xmqqr3007wzl.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <johannes.schindelin@gmx.de> writes:

> The current convention is to either generate files on the fly in tests,
> or to use supporting files taken from a t/tNNNN/ directory (where NNNN
> matches the test's number, or the number of the test from which we
> borrow supporting files).
>
> The test t3901-i18n-patch.sh was obviously introduced before that
> convention was in full swing, hence its supporting files still lived in
> t/t3901-8859-1.txt and t/t3901-utf8.txt, respectively.
>
> Let's adjust to the current convention.

Thanks for a clean-up.  This obviously is a good change ;-)
