Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EBB791F42D
	for <e@80x24.org>; Fri, 16 Mar 2018 11:14:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753872AbeCPLOL (ORCPT <rfc822;e@80x24.org>);
        Fri, 16 Mar 2018 07:14:11 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:55026 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753865AbeCPLOK (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 16 Mar 2018 07:14:10 -0400
Received: by mail-wm0-f67.google.com with SMTP id h76so2333427wme.4;
        Fri, 16 Mar 2018 04:14:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=G5GAnkjqtc7EkL/tXIHVNRyjzwa3RDtsWa6aMYd6kCQ=;
        b=jtfnuaCAfRfl1+UnG26pXrkr6xeKLEkI0TfaA2KhB5hTDG1ZgupolbfpWBeOj2Zxhz
         0rGeLMd0GlUUdoB3rJ9P9oJ3DGoWrzHLlvRWl36XePUZkdU7kZIjLArZt7P5LAKEx0Bg
         bwhOuSeU3FSk5xaY2Ethx+sG6MZSd7SgsdRBF6PJV9jCTaqQpCv2Otu5fdN8w9QGLs+U
         zB8aNyC8jhljFQX5yTOox2AfXZMfHYTYdA3TQv+sq3Rnp7vB+z1hvTRh7ai+iPStV80l
         y9aNLQ1qpqtQrufjRE7knC7LElACC/D6rV1gTTQmHwWAZ8EDZbqoBNgbcbVXXE6QglHO
         h2Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=G5GAnkjqtc7EkL/tXIHVNRyjzwa3RDtsWa6aMYd6kCQ=;
        b=LFflvc/BpdwQSbJ470vwQJQqxQcaqW4mbcanrTGQEwhA+bxUINkXg4bQfE3fQwR0Eb
         KfMPZSahijtMyJ8Co6CcOF/pfMhoTPIZjux4dqjPkLWBuv66TcJ0I3lw2zyBM2B7EUHf
         Gk1uQM3l9zbJPHVrB/O5/dsxJ0phZo2BnKcIdfgApO7GTfQLRihHcGT3YSD/7pEtaZSj
         GccAoMCirpDnkKtw7qKD9Z+hYPvQg7D0hO1MZKGj470AsAKSJZL0ouOi+Uqbxb5yDHKZ
         /6r3cH88OGEKdfegH4BZcgRfu6Yue8EsjB577A3hfSfbX6KPdtMeN/wl5Zq090hSD/Zm
         VyVA==
X-Gm-Message-State: AElRT7Ho0aRv0VBn3Nrx4OxVhko1vVy4pbZCE1gBXs4fW3cdmE3aXqXn
        Oh3qi7zwCI/4YEXKhnJOxAQ=
X-Google-Smtp-Source: AG47ELsepo94XVYBZQmMFpAWXSuXnfUPAKGP4oKx74hOGtoTCLzvFscdVE4v7deumUCj3DLKlwGFQA==
X-Received: by 10.80.137.80 with SMTP id f16mr1946011edf.206.1521198849280;
        Fri, 16 Mar 2018 04:14:09 -0700 (PDT)
Received: from evledraar (proxy-gw-a.booking.com. [5.57.21.8])
        by smtp.gmail.com with ESMTPSA id h13sm3361136edi.91.2018.03.16.04.14.07
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 16 Mar 2018 04:14:07 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Linux Kernel <linux-kernel@vger.kernel.org>,
        git-packagers@googlegroups.com
Subject: Re: [ANNOUNCE] Git v2.17.0-rc0
References: <xmqqwoyc3kir.fsf@gitster-ct.c.googlers.com>
User-agent: Debian GNU/Linux 9.3 (stretch); Emacs 25.1.1; mu4e 1.1.0
In-reply-to: <xmqqwoyc3kir.fsf@gitster-ct.c.googlers.com>
Date:   Fri, 16 Mar 2018 12:14:06 +0100
Message-ID: <87fu50e0ht.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, Mar 16 2018, Junio C. Hamano jotted:

>       gitweb: hard-depend on the Digest::MD5 5.8 module

I've just noticed this now, but while this module is in 5.8 RedHat's
butchered perl doesn't have it in the base system, thus this introduces
the do-we-even-care regression that git's full test suite won't pass on
a RedHat (or CentOS) base system, because the gitweb tests will fail to
"use" Digest::MD5.

I'm slightly leaning towards not caring about it, since there's no other
perl distributor that does this sort of split-out of the core, and if
you're on a RedHat system they're solving your package problems, so this
really only impacts the edge case of git developers and redhat
packagers, both of whom can just do "yum install -y perl-Digest-MD5" to
fix it.
