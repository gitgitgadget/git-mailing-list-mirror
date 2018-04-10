Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DE29D1F404
	for <e@80x24.org>; Tue, 10 Apr 2018 19:18:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752641AbeDJTR6 (ORCPT <rfc822;e@80x24.org>);
        Tue, 10 Apr 2018 15:17:58 -0400
Received: from mail-pl0-f52.google.com ([209.85.160.52]:46833 "EHLO
        mail-pl0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752435AbeDJTRq (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Apr 2018 15:17:46 -0400
Received: by mail-pl0-f52.google.com with SMTP id 59-v6so8127184plc.13
        for <git@vger.kernel.org>; Tue, 10 Apr 2018 12:17:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=4K+lVNNlSl4K6Fj5NU4VeZSk8gysxw9ilNQm4Wb0/nY=;
        b=PcUU+5uBYW4z8KJeXNnR9koVWBHc4oFs1dWLG6mZfUIEXgBxYH3n8RFpnOYLgvqghA
         +6TUf5Fmd8TOBUmHtMVrsVBroNnjwrvPFD9nFpIKm2JXtGGrrvSHzcFFTBT3EfS6Uzm1
         eLnUzidy4x25/+pZaRXyGc8RJVbrnYz434yfrtIUwoUmWd0/DRQrRN1YHRnVhCEfOJtY
         KcRCfIkEk1qMUHX7gprhyddhXmj8YrR29zePNiaVXgpzBVs3ZSV4ETAW5e803Z5L/SSo
         /etUY6y4W/JadwZsbV1lht5uikvOEObv3gykhRz+xC2sqpr4Jx00Gwp7cEsR/Bw8S8zZ
         L0bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=4K+lVNNlSl4K6Fj5NU4VeZSk8gysxw9ilNQm4Wb0/nY=;
        b=PZi/fbgG6DohgRpIN2xZi0iWeLgHKriGNErAWqQ6kZlm4g659sEehW3+48xAFhBvs3
         14kp0136uCW89p3EBlc5C1nqCKvULGhrLH3T79ynT0CWTwPb2j+djZ0ZTAr2quxYNGj+
         7um/0ZZ8K09H61AhN6bbRJQICO1YXhC88p2W6EPSosxUhnfrpWn7I8N2yu76mG4duWV/
         K6yDgaVLrJS9Bmimm1Oy/sw/+lOgV21S+0T56Gob06wTydMeAaE89Qn+n9VcOZelsWRC
         qQ8//zritHv7tG6n7sEzeo1iJ5s5EfUUzPZ7KOiO8aai2dgD2itbw0wKR5yWCXppw5PY
         cTYA==
X-Gm-Message-State: ALQs6tAkC4DXxust1U7Oqm8MHTeEbSICDTbxUvIHFL0eVo1JtQV1AsTP
        bIXRyI85QWwk6wp9HHPFon3rKihqmRZmrVvYlf60MA==
X-Google-Smtp-Source: AIpwx4+MbsXn84BdKGu/pNxjOz+TyfX4QyPOIKpYHt1L9BZzlsdfGOFnd4Hjugx6vz5gXXjlx07BnoPJkrnCdgPl3RQ=
X-Received: by 2002:a17:902:2863:: with SMTP id e90-v6mr1753712plb.58.1523387866238;
 Tue, 10 Apr 2018 12:17:46 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.100.178.66 with HTTP; Tue, 10 Apr 2018 12:17:45 -0700 (PDT)
In-Reply-To: <20180410183224.10780-5-asheiduk@gmail.com>
References: <20180410183224.10780-1-asheiduk@gmail.com> <20180410183224.10780-5-asheiduk@gmail.com>
From:   =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Date:   Tue, 10 Apr 2018 21:17:45 +0200
Message-ID: <CAN0heSrrPa5-ckjsonUh+3JpoAnaAT=efJT4Rp7uEn=UfWpC_g@mail.gmail.com>
Subject: Re: [PATCH 4/6] doc: added '-d' and '-q' for 'git push'
To:     Andreas Heiduk <asheiduk@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 10 April 2018 at 20:32, Andreas Heiduk <asheiduk@gmail.com> wrote:
> Add the missing `-o` shortcut for `--push-option` to the synposis.
> Add the missing `-d` shortcut for `--delete` in the main section.

s/synposis/synopsis/

The subject of this patch says -q, which should be -o. The subject
could also be in imperative ("doc: add ...", or "doc: add missing ...").
The diff LGTM.

Martin
