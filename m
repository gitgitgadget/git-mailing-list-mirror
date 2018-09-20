Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 688431F453
	for <e@80x24.org>; Thu, 20 Sep 2018 19:07:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388232AbeIUAwt (ORCPT <rfc822;e@80x24.org>);
        Thu, 20 Sep 2018 20:52:49 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:53582 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727241AbeIUAwt (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Sep 2018 20:52:49 -0400
Received: by mail-wm1-f65.google.com with SMTP id b19-v6so616426wme.3
        for <git@vger.kernel.org>; Thu, 20 Sep 2018 12:07:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=E3Ulg7bpn4mr9W+z7Gkvlxzf8UrNcVl493JA97LnSPk=;
        b=NxQf99aHmoqpAee6WXniq2IlyL8U4NrbzbJWSUiWT0gz9OMcggC9kncrq5Y2SYeoq6
         J9Mh/7B474+G12WkhpZbvpjszDf9qSlFsHklfGwaYR/45YvQABiJrbWSnNxfsVwLSupP
         mrwi0ODHAOaVtn90tF064OQqUVv/4IMsO0xLbivu+N8OiluOujXVwy4eLrgEt2f5mhF7
         pcTaZY5G8E13+VIvzNMlCVOL4UBxQhDmyJxgGTQBKlsMF298rK3TekeqgyhZdXuLhfyv
         ak6oQz16xwrkuXNPWp7Bgicb1KIr9PagBOxnSZaCY8VpIXD4SO6u0PCvjQbNAvTQdVbo
         nAag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=E3Ulg7bpn4mr9W+z7Gkvlxzf8UrNcVl493JA97LnSPk=;
        b=UozOnrDFycrPyqG95IEHjqzp5tZfctLn8B4yfrW+I3018ojXQDDIbJwd0XhGxOxFBg
         y3YgDMceoc+VBfdW/hCAtqIaLMYk6rqAVzxqs8xB8yZ47oaaDxqjr+y9DGgfNSlcmtZ3
         laXD6u3oxqsGKAibDDgslnRjN9uEqU5eEqu9ydZIVGavDR2iQkTvDaZKt/Xd4ssqB+KG
         nGbtqUaOmN42HBhjy/xghTuPol5PbcmRB4BzgSaEUYTpZCZMnQFPgvubTpMqnVN4jGYY
         9isUTZbioA+smqL+dPfJqC6SiUR1FFZmurXciZb0I9FS9lgm+zQKVeGzNAeH1Kw6+xAt
         O0NA==
X-Gm-Message-State: APzg51AjUVNcJrjMjSVWC+8xY6l6Zfl1VgB9gncWq1W97QToqtGyjEGX
        wmIxfv4DizlLYXDoWI8kzt183MzH
X-Google-Smtp-Source: ACcGV62Ul0c6ouQmWQJJ9dDzHXix8pre10pSIGiFJkn5PYLFxltIiJHopgIaFP7bDLpd7B0aSGz/iw==
X-Received: by 2002:a1c:e289:: with SMTP id z131-v6mr4301304wmg.32.1537470471067;
        Thu, 20 Sep 2018 12:07:51 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id 69-v6sm3500547wmb.27.2018.09.20.12.07.50
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 20 Sep 2018 12:07:50 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Martin =?utf-8?Q?=C3=85gren?= <martin.agren@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] git.txt: mention mailing list archive
References: <6319b34fc808ff6d8948e59f381cc5342b9ef17d.1537375332.git.martin.agren@gmail.com>
Date:   Thu, 20 Sep 2018 12:07:50 -0700
In-Reply-To: <6319b34fc808ff6d8948e59f381cc5342b9ef17d.1537375332.git.martin.agren@gmail.com>
        ("Martin =?utf-8?Q?=C3=85gren=22's?= message of "Wed, 19 Sep 2018 18:43:00
 +0200")
Message-ID: <xmqqlg7wyol5.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Martin Ågren <martin.agren@gmail.com> writes:

> In the "Reporting Bugs" section of git(1), we refer to the mailing list,
> but we do not give any hint about where the archives might be found.

And why is it a good idea to give that information in Reporting Bugs
section?  Are we asking the bug reporters to look for similar issues
in the archive before they send their message?  If so, I think that
we should be explicit about it, too.  Otherwise, the list archive
location would look like an irrelevant noise to those who wanted to
find the address to report bugs to.

For example, we can say something like this:

>  Report bugs to the Git mailing list <git@vger.kernel.org> where the
>  development and maintenance is primarily done.  You do not have to be
>  subscribed to the list to send a message there.
  +If you want to check to see if the issue has
  +been reported already, the list archive can be found at
  +<https://public-inbox.org/git/> and other places.
