Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 560191F403
	for <e@80x24.org>; Wed, 13 Jun 2018 16:57:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934978AbeFMQ5o (ORCPT <rfc822;e@80x24.org>);
        Wed, 13 Jun 2018 12:57:44 -0400
Received: from mail-wr0-f179.google.com ([209.85.128.179]:42379 "EHLO
        mail-wr0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934747AbeFMQ5n (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Jun 2018 12:57:43 -0400
Received: by mail-wr0-f179.google.com with SMTP id w10-v6so3498667wrk.9
        for <git@vger.kernel.org>; Wed, 13 Jun 2018 09:57:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=NyVwinadW/i1c29cDNuMOIyawt+1m3/lT/vul3qE/+w=;
        b=UHSDsP3+ccbJxxnBB+ReEQfY/OnjIuDWo9M5b7K7T/oYZbWtJunzcp+pdcvNhHlILp
         o7JLO7MGin2HllEZbYc3+Co4YObV2N+pRmmFp221AnUop21QN23CH7503QKdrMkbmZvs
         +ReAnoDTiAlDL0cpClz9jrjro4ukUfCoIhCBQ+CRUKdZ18PkrXLW+QMTLmSLb4KWO44M
         mYYxrvs185TLsTxomRypHvcs6v8xwmks/7NIHlId3WAYuJuxFJAZlYJhWiahZxW+JGge
         4fmQ8aKmwOCE6k0cn5y3H1CVjBeQ2ogSykmmScrEMtvUWcWzNyzzK/alPSlq7bV6Lng6
         zZiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=NyVwinadW/i1c29cDNuMOIyawt+1m3/lT/vul3qE/+w=;
        b=L+ADGbRNs9mWJaQTYHUBMnIpv3/jBVsUo34O+L+mLIv/4VQW/KRt/7/Qw+7E4GANYs
         qcQQOaA0OnchfSGtK7QrxzAGBYuXWzx8rE96SmHG/PDPf2gNExmNgP2eN2UZbBbm19nV
         0QmOHdeKLSHU7Te+qalAH228wL+uGd81agRh4ffY8+FmN1ebciICF01190NsHBDkWlPj
         ESxOkZN4ZB7I6AeurTNyRa0JoR71GTWLzjONFDf0CZSY8Lpkel1ak4CeHY1FmogZVOZr
         Y0fUqneC7CXzfRh0Re1Gg6rxL7HfdMtqupMfCogRu18RwVKrvBWHpJJmgUWbtVHUfUMs
         m6lw==
X-Gm-Message-State: APt69E3fXBKzPYMxrAZlaGOG4viViOkYoWn/kcqmKAjniPXSCnvWjuKY
        rhoS1KyAsdV+4qIkdPPNN24=
X-Google-Smtp-Source: ADUXVKLmsyKFr3jj08XXQ/4QUfmwS+hM7+vrs5+a8xHpFZ43jtFT3bribcCMAOD2UoMEGoahDex2Fg==
X-Received: by 2002:adf:b445:: with SMTP id v5-v6mr4682088wrd.67.1528909062098;
        Wed, 13 Jun 2018 09:57:42 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id n71-v6sm5428163wmi.14.2018.06.13.09.57.41
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 13 Jun 2018 09:57:41 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Robert P. J. Day" <rpjday@crashcourse.ca>
Cc:     Git Mailing list <git@vger.kernel.org>
Subject: Re: [PATCH] Use hyphenated "remote-tracking branch" (docs and comments)
References: <alpine.LFD.2.21.1806070751020.10794@localhost.localdomain>
Date:   Wed, 13 Jun 2018 09:57:40 -0700
In-Reply-To: <alpine.LFD.2.21.1806070751020.10794@localhost.localdomain>
        (Robert P. J. Day's message of "Thu, 7 Jun 2018 07:53:36 -0400 (EDT)")
Message-ID: <xmqqlgbi7hff.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Robert P. J. Day" <rpjday@crashcourse.ca> writes:

> Use the obvious consensus of hyphenated "remote-tracking branch", and
> fix an obvious typo, all in documentation and comments.
>
> Signed-off-by: Robert P. J. Day <rpjday@crashcourse.ca>

Thanks.
