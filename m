Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1B7471F87F
	for <e@80x24.org>; Tue, 13 Nov 2018 21:55:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730998AbeKNHzo (ORCPT <rfc822;e@80x24.org>);
        Wed, 14 Nov 2018 02:55:44 -0500
Received: from mail-ed1-f49.google.com ([209.85.208.49]:39369 "EHLO
        mail-ed1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726022AbeKNHzo (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Nov 2018 02:55:44 -0500
Received: by mail-ed1-f49.google.com with SMTP id b14so9350916edt.6
        for <git@vger.kernel.org>; Tue, 13 Nov 2018 13:55:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=TzFANmxW+qc9j69bKfy0iS7vSOyq4vS4MmE5dnEP33k=;
        b=jgwQY0Ijd664kKuH+NYyj+FEixMpzR6uSpVo3W5iAVv8gtGCYJ61tA2Cil8q2B15Y3
         L6iB151JNyT9Pcq0s2XWh9ccgFHXCeZirXJQafxXniGYm2n1CTPGFLlqiMIzJHRYXuyQ
         1nRLkxXLCHA8qRfS3K1jZL4JM/oOBh4b5GuVYE3ka9yUhZAp6TIz+0UyMpnv33mFIsXP
         RevnuilWf6rAgW7D6GSad9kUXM4+7BQIA+Y0q0sozC3A/aRTI3oHHkBo72raB9sgRaf4
         Jmc38Id41ZC9i4GhzOwqLSoXDYRFgzJlCcOOFErS30l1L7hhETYNU3Rjql1b5FvORRIJ
         Uehw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=TzFANmxW+qc9j69bKfy0iS7vSOyq4vS4MmE5dnEP33k=;
        b=KRGcrFXdkIA0vlRKfLQX0gu9vk3vKL+TOz8S3R+cQjygKKby8tlH8vaZv/kxNryZu/
         lEoH8JDbjchQIPmgHilpn1gw/wq1sj+4EO+o8HHfZjvDwVFaOZDmSKJ67ggAv86Cd3QX
         60co7w5GaQpOu73eCE59Xe1M//1Kx+JSkh1fV4W6iSVKEDsz62P/ilWRvZhbG8v/d+/4
         edXmnZRGjRycZBah5VVCccGcql97PYaIReV/TcdUDPkUg52H8QXNMz4P+0wJDVr1CSlV
         6rAsfSZEdeDiglfI6ufz5Xk9GfI25JrKzHCW4LHOESYr0aB41EuMIJqoOMgxL65e+Jgf
         9U0A==
X-Gm-Message-State: AGRZ1gLyOAlDkmOEssEkvAOB6ZGjW00KW+gAed2T7gFkVbw6DCrMP63H
        kGiFuLXqB3lMJF9wOZ+ZztQ=
X-Google-Smtp-Source: AJdET5eHnHX4QWfv24t2jrOXwGmwfMqgTE/6nVGtk3fIhgUK+OT5tG+VKrW2D1cEfmDUzDCM75Begw==
X-Received: by 2002:a50:afa3:: with SMTP id h32-v6mr17549982edd.254.1542146134766;
        Tue, 13 Nov 2018 13:55:34 -0800 (PST)
Received: from evledraar (ip545586d2.adsl-surfen.hetnet.nl. [84.85.134.210])
        by smtp.gmail.com with ESMTPSA id gk8-v6sm3265673ejb.42.2018.11.13.13.55.33
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 13 Nov 2018 13:55:33 -0800 (PST)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Matthieu Moy <git@matthieu-moy.fr>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] push: change needlessly ambiguous example in error
References: <20181113203909.30740-1-avarab@gmail.com> <1615698920.2718456.1542145071499.JavaMail.zimbra@matthieu-moy.fr>
User-agent: Debian GNU/Linux testing (buster); Emacs 25.2.2; mu4e 1.1.0
In-reply-to: <1615698920.2718456.1542145071499.JavaMail.zimbra@matthieu-moy.fr>
Date:   Tue, 13 Nov 2018 22:55:32 +0100
Message-ID: <87wopg1w2z.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Nov 13 2018, Matthieu Moy wrote:

> Ævar Arnfjörð Bjarmason" <avarab@gmail.com> wrote:
>
>> Let's use "git push <remote> HEAD" which always means push the current
>> branch name to that remote, instead of "git push <remote>
>> <current-branch-name>" which will do that under "simple", but is not
>> guaranteed to do under "upstream".
>
> Probably a good idea indeed.
>
> One potential objection though: I think many people know
>
>   git push origin master
>
> (not that they necessarily understand it, but I've seen many people talking
> or asking questions about what "origin master" is)
>
> This "git push origin HEAD" is IMHO less common. It may confuse users.
> Or users may learn it and be happy thanks to your message. I don't know.

I was hoping for the latter. I'm slightly embarrassed to say that for
the entire time I've been using git I've been doing:

    # on branch 'topic'
    git push origin topic:topic

Where 'topic' is a tracking branch of 'origin/master' (I use
push.default=upstream). I only recently discovered that I could push to
'HEAD" to do the same thing. So one ulterior motive is to make that more
prominent.

I was going to add a hint on such invocations saying "you can just use
HEAD", but have not found the relevant code yet after some brief
searching...
