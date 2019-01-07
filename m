Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,UPPERCASE_50_75 shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D9A8C1F803
	for <e@80x24.org>; Mon,  7 Jan 2019 17:17:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727472AbfAGRRq (ORCPT <rfc822;e@80x24.org>);
        Mon, 7 Jan 2019 12:17:46 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:34332 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727184AbfAGRRq (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Jan 2019 12:17:46 -0500
Received: by mail-wm1-f68.google.com with SMTP id y185so6589113wmd.1
        for <git@vger.kernel.org>; Mon, 07 Jan 2019 09:17:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=f9kG8shmJpEcuROSRLLMJ25Elp8y1WmgVZlOPAIiX70=;
        b=j86I4sPS0Wkmu3zHFvtQ9CfS4Ff3I2d93mnRWq9Gd2DaeWsg6rbGGXYpTBi4wuyZrD
         ud2fibsgH83S6QOV+co61Q/35Lv+D7l7RWFoHavtvpnqos3C+i3lngAAfgccdw6xGw4N
         UeYjJeszK8bfw0TguNogzEc4AtA1/i5Ykzj3oMRd7ZWbDOh1+zjEts1PBZ59KTPDCiHs
         yGj1lNKmrt+yGxUATaGDTSP1SBfmTFVK/RUFv7SccE0S7QHZVbDDnCiPucdK6ZOhzhVS
         K7b0a7u/QSL27jpekpSoyJYa7fA5crsvjjqBp3Jacs8uBf7/04ZrLq7aXlowtik+XPXU
         Jd3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=f9kG8shmJpEcuROSRLLMJ25Elp8y1WmgVZlOPAIiX70=;
        b=OIJY/Y99Blw2aqPAUtKayxTKV0FCpNwCP6Zd26bA8iWHhKnQmTivQvNsQ94r+aatB9
         HW4asZc10TdBcfXFQe4yP60KxE/Ry/9CNHM6l8leDMPkwUZzB64YS4Ie9eIP0L0krAIG
         QNQfatknacLMk6LvX3TBNsox5SS+XwyIGrYLLy3hQuhZYe0OpivXAnMoK6adk1pa/t48
         YLxB4DAYHqQtnhbAm2FKzbBCwmXK2pfKSdljFc/klL2xNg191tT59goKT55rbcLEQE2i
         pNtBbbWDPX8fUghoSVkZAnN6kJ8r1Ss9aBuel9EkZVFsyh1btNaT4bXM24j6vmiUfrf1
         ZpOA==
X-Gm-Message-State: AJcUukdB8IVBGYuaHP9vAkL8OCZA6fKnc5LGB0r9cAscA1MjEkc/7yXN
        qtQL3uJXFhAdvWl9OsFdtj8=
X-Google-Smtp-Source: ALg8bN7WhWxJuGco7rUUWJbYU6jnK5vCYM4I/Ks7svN70v+iD6CHUx3qWimU4Q3WfnGPUWnFR6I9WQ==
X-Received: by 2002:a1c:2007:: with SMTP id g7mr9035160wmg.79.1546881464677;
        Mon, 07 Jan 2019 09:17:44 -0800 (PST)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id e17sm81717188wri.36.2019.01.07.09.17.43
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 07 Jan 2019 09:17:43 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?Q?Jean-No=C3=ABl?= Avila <jn.avila@free.fr>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v2] Add optional targets for documentation l10n
References: <20190104165406.22358-1-jn.avila@free.fr>
        <20190105134438.11271-1-jn.avila@free.fr>
Date:   Mon, 07 Jan 2019 09:17:43 -0800
In-Reply-To: <20190105134438.11271-1-jn.avila@free.fr> (=?utf-8?Q?=22Jean-?=
 =?utf-8?Q?No=C3=ABl?= Avila"'s
        message of "Sat, 5 Jan 2019 14:44:38 +0100")
Message-ID: <xmqqimz09yko.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jean-Noël Avila <jn.avila@free.fr> writes:

> +ifdef MAN_FILTER
> +MAN_TXT = $(filter $(MAN_FILTER),$(MAN1_TXT) $(MAN5_TXT) $(MAN7_TXT))
> +else
>  MAN_TXT = $(MAN1_TXT) $(MAN5_TXT) $(MAN7_TXT)
> +MAN_FILTER = $(MAN_TXT)
> +endif

OK.

>  OBSOLETE_HTML += everyday.html
>  OBSOLETE_HTML += git-remote-helpers.html
> -DOC_HTML = $(MAN_HTML) $(OBSOLETE_HTML)
>  
>  ARTICLES += howto-index
>  ARTICLES += git-tools
> @@ -81,11 +86,13 @@ TECH_DOCS += technical/trivial-merge
>  SP_ARTICLES += $(TECH_DOCS)
>  SP_ARTICLES += technical/api-index
>  
> -DOC_HTML += $(patsubst %,%.html,$(ARTICLES) $(SP_ARTICLES))

> +SP_ARTICLES_HTML += $(patsubst %,%.html,$(ARTICLES) $(SP_ARTICLES))

I'd call that $(ARTICLES_HTML); SP_ARTICLES are those pages that
want to become regular articles but singled out because they need
special handling to format.

> +HTML_FILTER ?= $(SP_ARTICLES_HTML) $(OBSOLETE_HTML)
> +DOC_HTML = $(MAN_HTML) $(filter $(HTML_FILTER),$(SP_ARTICLES_HTML) $(OBSOLETE_HTML))

> -DOC_MAN1 = $(patsubst %.txt,%.1,$(MAN1_TXT))
> -DOC_MAN5 = $(patsubst %.txt,%.5,$(MAN5_TXT))
> -DOC_MAN7 = $(patsubst %.txt,%.7,$(MAN7_TXT))
> +DOC_MAN1 = $(patsubst %.txt,%.1,$(filter $(MAN_FILTER), $(MAN1_TXT)))
> +DOC_MAN5 = $(patsubst %.txt,%.5,$(filter $(MAN_FILTER), $(MAN5_TXT)))
> +DOC_MAN7 = $(patsubst %.txt,%.7,$(filter $(MAN_FILTER), $(MAN7_TXT)))

Makes sense; s/, /,/, though.
