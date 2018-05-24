Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 27D941F42D
	for <e@80x24.org>; Thu, 24 May 2018 19:42:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S968977AbeEXTmO (ORCPT <rfc822;e@80x24.org>);
        Thu, 24 May 2018 15:42:14 -0400
Received: from mail-wm0-f54.google.com ([74.125.82.54]:34908 "EHLO
        mail-wm0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S967421AbeEXTmO (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 May 2018 15:42:14 -0400
Received: by mail-wm0-f54.google.com with SMTP id o78-v6so8545182wmg.0
        for <git@vger.kernel.org>; Thu, 24 May 2018 12:42:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=0OTYsJLsmYHYdwG+wE8e3D6gIY55o6J2T92HndTJkoU=;
        b=g9XuHAgO37yn3AWKZpDa6XzG9twZ7AXW4IDuLHOU8lJGnHJyV78TPG1/TFr24fIkf3
         3uGRfvoKKBQC6fxpPZaFwcL+CBt2mtNYpXXOKiQnSyuWNlqtZvW8hRrXOX9xh1fiGxRE
         TqlnhmSZ53qtjEnVbKcKz5PwnhSvILujnvCYbGMLiPf7U5DJxS/obyjEuob0ZOal//x7
         l9LEDgeL5IZRViagXfz9CMN6vl38X9Gi6vqtfk41QabA0aR5L/HotKz3WTXd9rzQWgf6
         IgckbaJvSyL6A0kG+BTbNeRUkrtpFKi8IZl8GBqtoIe+cA+2m/IjIPLjiuI77CsJbvmO
         MOIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=0OTYsJLsmYHYdwG+wE8e3D6gIY55o6J2T92HndTJkoU=;
        b=slXMrgiE3fhJUQbp/ZixoRx4bjW+yL0sDK35jnMkkp1WsnlLFCYxEnOXdku0XnAl2v
         wyMKjhL7YgmLEt5J0rthEbM8pcP82xknV/xkyRehzA2fTvpX8V4un/Xh0Evf9wQR8L3X
         /FlSHRu+pRhe4tiEbRtJPP0xvIoTEeL1w1DnOH8maUEATMIqYU9DtZslb+SaauGLA8m1
         9+rnxDkdTaBRneaIxH1Us0zoPXHZjXR8VDt0lfYgRhEhmL1cISjGAUpzKdmmt9WESrqS
         9GiZ4TpVyy24ocnWXnFwrByxmHo9DpzzJYLw/5LX8el5NUUqhOeG49YFv9o64uBbmuo8
         6Djw==
X-Gm-Message-State: ALKqPwc6magNizu6pn1zTmdywzw80NLuvWq2rmo73Q3r2y0v7LCIWPN+
        C1I+rP6Of7AoYejyV1Q6kUB/zjDv
X-Google-Smtp-Source: AB8JxZrBhccg8EcS8DA8UHh/oNxjUHI470akE/syR9IJv409qChbIbSA5bB0+8PlZEuJLYjEqifQaw==
X-Received: by 2002:a50:cd0b:: with SMTP id z11-v6mr13629632edi.118.1527190932731;
        Thu, 24 May 2018 12:42:12 -0700 (PDT)
Received: from evledraar (dhcp-089-098-184-206.chello.nl. [89.98.184.206])
        by smtp.gmail.com with ESMTPSA id s14-v6sm11957590eds.10.2018.05.24.12.42.11
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 24 May 2018 12:42:11 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>
Subject: Re: What's cooking in git.git (May 2018, #03; Wed, 23)
References: <xmqqwovtudia.fsf@gitster-ct.c.googlers.com>
User-agent: Debian GNU/Linux testing (buster); Emacs 25.2.2; mu4e 1.1.0
In-reply-to: <xmqqwovtudia.fsf@gitster-ct.c.googlers.com>
Date:   Thu, 24 May 2018 21:42:10 +0200
Message-ID: <87sh6g7sdp.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, May 24 2018, Junio C Hamano wrote:

> * ab/fetch-tags-noclobber (2018-05-16) 9 commits
>  - fixup! push tests: assert re-pushing annotated tags
>  - fetch: stop clobbering existing tags without --force
>  - fetch tests: add a test clobbering tag behavior
>  - fetch tests: correct a comment "remove it" -> "remove them"
>  - push doc: correct lies about how push refspecs work
>  - push tests: assert re-pushing annotated tags
>  - push tests: add more testing for forced tag pushing
>  - push tests: fix logic error in "push" test assertion
>  - push tests: remove redundant 'git push' invocation
>
>  Expecting a reboot of the discussion to take it to some conclusion
>  and then a reroll.
>  cf. <f3b891c3-381f-de42-51d8-24fdfbca91d2@gmail.com>
>  cf. <xmqq603yn50l.fsf@gitster-ct.c.googlers.com>
>  cf. <xmqqzi1alodz.fsf@gitster-ct.c.googlers.com>
>  cf. <xmqqvabylnbi.fsf@gitster-ct.c.googlers.com>

I hope to follow-up with this soon. Sorry for the delay.

> * ab/get-short-oid (2018-05-11) 5 commits
>   (merged to 'next' on 2018-05-23 at 07e1908439)
>  + get_short_oid: sort ambiguous objects by type, then SHA-1
>  + sha1-name.c: move around the collect_ambiguous() function
>  + git-p4: change "commitish" typo to "committish"
>  + sha1-array.h: align function arguments
>  + sha1-name.c: remove stray newline

Sweet. I'll follow-up with the rest of the patches revised once that
lands now that I'm fairly sure what you and Jeff mean by $sha1^{<type>}
:)
