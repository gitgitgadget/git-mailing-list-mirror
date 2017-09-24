Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.1 required=3.0 tests=AWL,BAYES_00,
	DATE_IN_PAST_06_12,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DCB12202A5
	for <e@80x24.org>; Sun, 24 Sep 2017 11:31:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752047AbdIXLbS (ORCPT <rfc822;e@80x24.org>);
        Sun, 24 Sep 2017 07:31:18 -0400
Received: from mail-pf0-f196.google.com ([209.85.192.196]:33785 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751799AbdIXLbR (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 24 Sep 2017 07:31:17 -0400
Received: by mail-pf0-f196.google.com with SMTP id h4so2449403pfk.0
        for <git@vger.kernel.org>; Sun, 24 Sep 2017 04:31:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:subject:from:to:cc:in-reply-to:references:date
         :mime-version:content-transfer-encoding;
        bh=mEkxzr5EVVtWSRvUN2eNKiKprR9EudvuSjS0gw8LD5Q=;
        b=JR03z9yPXPmTh0MTSrxyh0Tsd8xIcTm2WkMAOAG0e1qeVD6quq2hjmw7hxoiK/+Mi+
         9j7MEpHlHWhIsD8ckh+oo8yBlZ79EKkMVacbEsBXXGUAb6eqvSH+QouBINA4g6YK5t0E
         cxONsBnadq6UsmBhXtr59hJY7LajobanR3WbNKm43oN2YyXwtDsLGqNe3pQmM9+q3epE
         xylK/zkq604pwxqFcCKPU+lYAh/f70mKnqCDyfSYOqWUSmd2GTEhoLoS2qqZ5yOEPAQY
         i/o569dYt6z/My55mruadaXCBS8tZRh+7gQGLu6VMXoIiqHKpK2XlrBGuvwxmgm1cVUQ
         XzVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:in-reply-to
         :references:date:mime-version:content-transfer-encoding;
        bh=mEkxzr5EVVtWSRvUN2eNKiKprR9EudvuSjS0gw8LD5Q=;
        b=YPRxgYp1TgI+rb0A9+OTu+u3TBOfAcTwzjfkkVCXKWLQ5XrWQMK053m3Tj6nejfOnf
         rDn0YdQuKRkxvJAM44qefG8nl/Qb2tNTkqlAXeCF5p9AhwSVcMy6pqi995GuiYib877v
         CHtgo6+I8MyIT2zpdlZvGMaa3r9JEKr9iJurY/8T0hW7mm3NSYMZSupQFTi8IktE1k8+
         KkgfJOCUmUbcohQnCGI1B2/ebp0RfxGV4rGdhv3mrLCDmuaPpCf0lvVb4Lu2KXsF7oXV
         ISTBu0EvetMYmbNo2XYiNA5zD9fL4BvZSIYVeWY5n9r9FYSxDqllzFxZ3i/KJfnacgNq
         qXAA==
X-Gm-Message-State: AHPjjUi3dXCl7pwgxuo4o5uJIptjYF8aT81ocm50cMKf2xUnAUscvM41
        kaR6I9oEB0K3e6f0btv/OrM=
X-Google-Smtp-Source: AOwi7QD11SkIQlWiPE2xHNCxfuBiLKgT/eOEkZuapE59gBmNmf6KcmNKVOYYAJn8ApToqysEZCkDEw==
X-Received: by 10.99.109.8 with SMTP id i8mr4584961pgc.412.1506252677120;
        Sun, 24 Sep 2017 04:31:17 -0700 (PDT)
Received: from unique-pc ([14.102.72.146])
        by smtp.gmail.com with ESMTPSA id p70sm7111156pfk.130.2017.09.24.04.31.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 24 Sep 2017 04:31:16 -0700 (PDT)
Message-ID: <1506230463.2425.2.camel@gmail.com>
Subject: Re: [PATCH v2] doc: camelCase the config variables to improve
 readability
From:   Kaartic Sivaraam <kaarticsivaraam91196@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Jonathan Nieder <jrnieder@gmail.com>
In-Reply-To: <xmqqmv5lhre2.fsf@gitster.mtv.corp.google.com>
References: <20170919202201.GD75068@aiede.mtv.corp.google.com>
         <20170923045617.3782-1-kaarticsivaraam91196@gmail.com>
         <xmqqmv5lhre2.fsf@gitster.mtv.corp.google.com>
Content-Type: text/plain; charset="ISO-8859-15"
Date:   Sun, 24 Sep 2017 10:51:03 +0530
Mime-Version: 1.0
X-Mailer: Evolution 3.22.6-1 
Content-Transfer-Encoding: 7bit
X-Cyberoam-smtpxy-version: 1.0.6.3
X-Cyberoam-AV-Policy: default
X-CTCH-Error: Unable to connect local ctasd
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, 2017-09-24 at 09:28 +0900, Junio C Hamano wrote:
> Kaartic Sivaraam <kaarticsivaraam91196@gmail.com> writes:
> 
> > A few configuration variable names of Git are composite words. References
> > to such variables in manpages are hard to read because they use all-lowercase
> > names, without indicating where each word ends and begins.
> > 
> > Improve its readability by using camelCase instead.  Git treats these
> > names case-insensitively so this does not affect functionality. This
> > also ensures consistency with other parts of the docs that use camelCase
> > fo refer to configuration variable names.
> 
> s/fo/to/ (or s/fo/in order to/)?  
> 

Yeah, a typo that I missed.

> Perhaps
> 
> 	References to multi-word configuration variable names in our
> 	documentation must consistently use camelCase to highlight
> 	where the word boundaries are, even though these are treated
> 	case insensitively.
> 
> 	Fix a few places that spell them in all lowercase, which
> 	makes them harder to read.
> 
> may be a more succinct way to say the same thing.  We state the rule
> upfront, explain what the rule is for, and tell the codebase to
> apply the rule.  That should cover everything your version and
> Jonathan's version wanted to convey, I'd think.
> 

Much better, thanks. Will resend with this updated message.

---
Kaartic
