Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 54EC01F463
	for <e@80x24.org>; Thu, 26 Sep 2019 21:12:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728872AbfIZVMw (ORCPT <rfc822;e@80x24.org>);
        Thu, 26 Sep 2019 17:12:52 -0400
Received: from mail-lf1-f41.google.com ([209.85.167.41]:36492 "EHLO
        mail-lf1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725919AbfIZVMw (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 Sep 2019 17:12:52 -0400
Received: by mail-lf1-f41.google.com with SMTP id x80so277287lff.3
        for <git@vger.kernel.org>; Thu, 26 Sep 2019 14:12:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SPHKKBB5dcpWezu8E3YW/zXwuALX0GnBMENn2DiftX8=;
        b=BeEvta0PsNq6ElReFgYjTk9h+MWdo8ywoiULDNmQA/+Du0D4pmzp5KYaPxiKoZxoFS
         vqAlBMIbaF6aqY3PHwuCv/VyC5Db5ojJvTEkdRd3Q4cp06sMkVopzlAZtGN4pHXwW2i2
         A+7q2RxnG5uX/r1PGgwvM/v/JZl+XhNagifuKk7+MFcmcSecdp2pIgT8SRuHJNX3z2g0
         tAnSysx/qLHcLxDbZ1mhEtn6mZsBi1FKlp39nHZdfxIw6ajAsxDrcX0wujfJoxPArjai
         V6roKEPb6jZlEnnIXZdwaLD9xQA937UTogrhXJDajR4JCmrmCxd+45sgdz4NUuSl9fVk
         rcLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SPHKKBB5dcpWezu8E3YW/zXwuALX0GnBMENn2DiftX8=;
        b=bBMU/pgjzo3acjLsDdJQxDPwnfDDZsh0P+wIjXSVjvoXlbu3OQIfQUrH54zMTqCopj
         W8y5qII6mNOtKsqZFdoLrwGKEe/EdWEKbPGVQ95ddtIy+Gc8Gjsn+dlw/KnPrqxQPc4y
         ux72Un2chvWfwaNkFRJ5aJN879IrbiTOKZJ1DJXZZczYoK/GqZ56Tmku3m6RL1Y2oENe
         Srbr4eufNcdXXyC/rvy+ofHzFCakCWSP6RaTVh6xBJDwMXjxyajLNIs6NygQPHhJAUfw
         VEAOn4slCxwL1dnhCO8p04LScxPdhoAB7kfPZt+Qnmqj9L4IW8qKxepMylhDBX9ZJm2I
         dh9Q==
X-Gm-Message-State: APjAAAW7+9Xh5g+odX2qGqa9IKrdPXHH4gDnKG5dVQiPZTxgYAp0X95S
        rrivjmwqrE7wfMoRlaRq2ueKwtcKp3rbTDMSLTSZsJTq7Sw=
X-Google-Smtp-Source: APXvYqx513sAnMgMFiYU9DaJC2zHTjERUjY+qYegjve2x7UPgvyYBbuq3381eQVgGKrWzwbQ90w3EX3KeDvRY4vLAas=
X-Received: by 2002:ac2:43b8:: with SMTP id t24mr384454lfl.24.1569532370180;
 Thu, 26 Sep 2019 14:12:50 -0700 (PDT)
MIME-Version: 1.0
References: <CAGr--=K15nUcnsJWOP87uMMjeQmTgAeO_6hnr12k2zuNQjNyBw@mail.gmail.com>
 <91e5b3b0-08f9-66a8-ebdf-90effd34c888@kdbg.org> <20190926191545.ro7w6lbtlpbyxpk7@yadavpratyush.com>
In-Reply-To: <20190926191545.ro7w6lbtlpbyxpk7@yadavpratyush.com>
From:   Birger Skogeng Pedersen <birger.sp@gmail.com>
Date:   Thu, 26 Sep 2019 23:12:39 +0200
Message-ID: <CAGr--=KAv8PQMOUbAh=aAWQeMuvHHacXF=+Mc2-NougLYgr2_A@mail.gmail.com>
Subject: Re: git-gui: disable the "loose objects popup" dialog?
To:     Pratyush Yadav <me@yadavpratyush.com>
Cc:     Johannes Sixt <j6t@kdbg.org>, Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Sep 26, 2019 at 9:15 PM Pratyush Yadav <me@yadavpratyush.com> wrote:
> Talking about auto compression, would it be a better idea to let users
> disable the dialog, and then if they do want auto compression, they can
> just run a cron job (or the Windows equivalent) to do this on their
> repos?

Personally I would prefer that git-gui (silently) performs the check
and compression for me when I open it on a repo. But I can totally see
why some (propbably most) git users would not want that. So I don't
really mind if that part of my proposal gets denied.

> What reasons do people have to have this feature in git-gui,
> instead of running cron jobs?

I can't really think of a reason. But then again I can't really think
of a reason why users would want the "loose objects check" in git-gui
in the first place. Especially not enabled by default, popping up when
the user opens git-gui. A button (manual action) to perform this check
and (if necessary) perform the compression would be better IMO.

Birger
