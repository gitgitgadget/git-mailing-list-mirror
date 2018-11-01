Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 756551F453
	for <e@80x24.org>; Thu,  1 Nov 2018 13:10:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728473AbeKAWNW (ORCPT <rfc822;e@80x24.org>);
        Thu, 1 Nov 2018 18:13:22 -0400
Received: from mail-wr1-f49.google.com ([209.85.221.49]:44849 "EHLO
        mail-wr1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727644AbeKAWNW (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Nov 2018 18:13:22 -0400
Received: by mail-wr1-f49.google.com with SMTP id d17-v6so19713126wre.11
        for <git@vger.kernel.org>; Thu, 01 Nov 2018 06:10:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=zyXVk47RKIX2+QJMaBu6emp3ta5PxsqOTZHA2iltbk4=;
        b=nMOBsDLqnqXudvlIh0IrLJCKylfHO//7VgBAqSb24KAAObJEO9dy22DWin5WMsbduf
         FdVPRseZ5g6vfHvPPuBlf6ZZvkl6YugtP5lhFwtp0vaDuN6x6V4W1gt+EMnrBJhOrsYc
         lCDHjKkLX/XpPXhtt4K4iYmmItQEu40AyGQAnDqbP8zvt/4uhDmumGJ3VbU7ums0qMNr
         XTBLRQfTeR2ktSQZzG5kAe33jBAuz/fUgUtSpcVUUEHeLRGiHU36wowo1QkfDzUNhw+R
         GsLGTFCYyA3vk7ksc71fx3IULHWIk9xOzHMbkCcOj1GMqiiSsRTN9CcrZ5hodBBr0G7F
         HNzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=zyXVk47RKIX2+QJMaBu6emp3ta5PxsqOTZHA2iltbk4=;
        b=KZjU8UAw78tgNOWFHftjzi3sGrSKOlpHzQ2uQNdxg4ND9w1zI+Su2kYX4c1z7uNdKr
         Ee6jvxxms3EgBhKwVO5v/XaReFZl050duFSkNYlTEw2Mf7wIwH43krS++bItMaXygHQK
         C2ddLz6YOd18AlRN8yKsIxS/Y+uMHtKs7iGz6DxITxNDXWXS/G95UrNYsxeqbFB53hZs
         LFEzBFhGBDX3Deh0H42WhJgO2x4PLgK06Wmx5B6r/YAaBCTz17YrIQdDUIr2Rpsw+Wi3
         IwVfqtkj4upPoZoAbyI1tMxulbriR8bN9v9grrEIbTwgRkiPQUVnmprmdd/zDFp+BgiK
         s4HQ==
X-Gm-Message-State: AGRZ1gJscRfw8f7thcMWpKp67mdB9ovH+5l15DJ08C/IncCnSHsi47/x
        zbBesl8o24UWU1roYE2YfP4=
X-Google-Smtp-Source: AJdET5dHZj14rK+EQLqgRXRvH+0vtTHF4RvbYLyE4rbmdKy1vmdL87cji8ZoIg2NECjA18mOSmeupA==
X-Received: by 2002:adf:f4c5:: with SMTP id h5-v6mr6474896wrp.21.1541077826402;
        Thu, 01 Nov 2018 06:10:26 -0700 (PDT)
Received: from szeder.dev (x4db12d59.dyn.telefonica.de. [77.177.45.89])
        by smtp.gmail.com with ESMTPSA id o130-v6sm22110058wmd.11.2018.11.01.06.10.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 01 Nov 2018 06:10:25 -0700 (PDT)
Date:   Thu, 1 Nov 2018 14:10:22 +0100
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: ab/* topics (was: Re: What's cooking in git.git (Nov 2018, #01;
 Thu, 1))
Message-ID: <20181101131022.GU30222@szeder.dev>
References: <xmqqd0rpt8wy.fsf@gitster-ct.c.googlers.com>
 <8736slkqmu.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8736slkqmu.fsf@evledraar.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Nov 01, 2018 at 12:02:01PM +0100, Ævar Arnfjörð Bjarmason wrote:
> Could you please pick up
> https://public-inbox.org/git/20181024114725.3927-1-avarab@gmail.com/ ?
> It seems to have fallen between the cracks and addressed the feedback on
> v1, and looks good to me (and nobody's objected so far...).

I didn't object, because in

  https://public-inbox.org/git/87muqzllh0.fsf@evledraar.gmail.com/

you asked for "a more general review than just the problem of how
we turn an env variable into a boolean".

However, if you push that patch with 'sh-i18n--helper' as-is, then I
do object now: parsing a boolean in shell is not at all that difficult
to justify this new command.

