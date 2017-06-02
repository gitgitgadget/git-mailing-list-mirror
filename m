Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AF21A20D0A
	for <e@80x24.org>; Fri,  2 Jun 2017 00:33:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751148AbdFBAdw (ORCPT <rfc822;e@80x24.org>);
        Thu, 1 Jun 2017 20:33:52 -0400
Received: from mail-pf0-f169.google.com ([209.85.192.169]:35873 "EHLO
        mail-pf0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751129AbdFBAdv (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Jun 2017 20:33:51 -0400
Received: by mail-pf0-f169.google.com with SMTP id m17so41130582pfg.3
        for <git@vger.kernel.org>; Thu, 01 Jun 2017 17:33:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=CvIEgdcfxckVcxAZg0bqnw88W7IgxNoDCS2ccHT1biM=;
        b=U3NjGOHV/PjRRNlqjWeR/y5O1GWDtJ8hjWJGTQAqubq7bMRjTMGVbti6nzMGDZYMRR
         D4iBTT8e6spNniOZU6ilm9bYOo7VdtVgaLW+tdbo6qeN9PvHwY5l3g2SjLQzjYJOOmRF
         /q+4NZ+VmVb4vNFfMxvCHWi3JD6uAYHcxtEAB5+h1qjI/y/1F0jiERe8iljocVBTJAS5
         ZYvcZnxltB2OZnF4xfBOC15Ppme8Pb3MJaKnVZ/Kx2rViDFsvtbAL+UBOQNkiaEhnPoG
         pYZ5VEHBSq+vGdf1KWt1CgKnlmEg7e5RkocKqR5dydK2LAVDLomHy1udv1J3HApq6um5
         Dpww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=CvIEgdcfxckVcxAZg0bqnw88W7IgxNoDCS2ccHT1biM=;
        b=ps6RDO2Wg5BnzyuAWp6cMR1dcymJsh9IbM1Mxn+a6LwtVpj4zCkdJXsXc+DuiZyVwm
         P5FP5ggvfk1qNgKNaHultTnn6sYaq9X+2+skAf3LXeIiV9yMs8KIUxOhYZ+x7IY0SSUC
         8F1tsrPG4qpyC/Rgio7ksPV4Zw1a5x9dCkY30T/X+8DNuWIwhcNmklyBf5eYkELIDDnk
         xYAN8MEEJi4i0+xn2W0z/qlk5f2RGnWd47xZfWhBDGUFxd97TFY/Noc3C1LZP68kZOhI
         tNUSTktEDKgrlozKcFewytr9/KjoHI9lX3vdginAX//F8rX0Qy1K2+hCAPMTQy8erSYk
         g72w==
X-Gm-Message-State: AODbwcC7DmPILe7SerKTE792PBPRtRtzM6R17q8ALuEZWdGF8USanti9
        835gzN4bWWoB/g==
X-Received: by 10.99.44.9 with SMTP id s9mr4033753pgs.72.1496363630588;
        Thu, 01 Jun 2017 17:33:50 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:ec2c:8ebb:3fc7:e0d4])
        by smtp.gmail.com with ESMTPSA id x18sm40035307pfe.13.2017.06.01.17.33.49
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 01 Jun 2017 17:33:49 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Rikard Falkeborn <rikard.falkeborn@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH 0/6] Some more git config completions
References: <20170527062552.13996-1-rikard.falkeborn@gmail.com>
        <CACBZZX6aGkBaQtjKNx09-XEbhXNubOnhJdVXYkNq419wetDvqg@mail.gmail.com>
Date:   Fri, 02 Jun 2017 09:33:49 +0900
In-Reply-To: <CACBZZX6aGkBaQtjKNx09-XEbhXNubOnhJdVXYkNq419wetDvqg@mail.gmail.com>
        (=?utf-8?B?IsOGdmFyIEFybmZqw7Zyw7A=?= Bjarmason"'s message of "Fri, 2 Jun
 2017 00:02:01
        +0200")
Message-ID: <xmqqy3tb2poy.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ævar Arnfjörð Bjarmason <avarab@gmail.com> writes:

> As an aside from this series, has anyone ever proposed some method of
> semi-automatically keeping this up-to-date? Seems we're in a continual
> cycle of adding flags/config, forgetting to update this, then updating
> it. At least the command-line flags should be easy to parse out in
> some test, ditto config variables from config.txt maybe...

In theory, yes, and if it is harder to automate it, at some point we
may want to see if we can devise a way to make it easier by
extending parse-options and config API.

Such an automation however needs to take into account the fact that
historically we tried not to blindly add everything under the sun to
completion (iow, there needs a way to allow us mark some things not
to be auto completed in the mechanism).
