Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B26C720209
	for <e@80x24.org>; Wed, 28 Jun 2017 06:00:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751527AbdF1GAr (ORCPT <rfc822;e@80x24.org>);
        Wed, 28 Jun 2017 02:00:47 -0400
Received: from mail-vk0-f42.google.com ([209.85.213.42]:33701 "EHLO
        mail-vk0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750842AbdF1GAq (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Jun 2017 02:00:46 -0400
Received: by mail-vk0-f42.google.com with SMTP id r126so27606020vkg.0
        for <git@vger.kernel.org>; Tue, 27 Jun 2017 23:00:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=Gz4oOAapssPyWlVcgj6XoBH/Ly75t/nV7nuSzz/Yx5Q=;
        b=hvOKGlWtdb7svydX3/RsEZmHc4Rhmo9nk/A9Ql5xUChgiMZPHZJeHw+sLXxKUySnh6
         p1TZbuMro1ipSZ1nR/mfwVHURiDhBSzyE3Ol2KNR0Fd1hoPdsxcKaHYWz82zrcxTYm/e
         jW4iDbzrZj/AA/PvKkR1VD+z1kE4zFdAhmftv2x+CkEEPUM1wt81ggyx//GqeA5zMCW/
         gVHqYiWdG6bcPcPZAGpZmRY5MQToQXL3BYsqqcOxIQ4KIU0ZPPuvSzpROS1BQeqq+zy5
         eXWKUMSfwbmuLDny1ZhAZMfLORFpcsc6Xq70DWAAg8qdRVdNw7pYErgci38G+y3MTQlQ
         Ms+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=Gz4oOAapssPyWlVcgj6XoBH/Ly75t/nV7nuSzz/Yx5Q=;
        b=m05yKgZqDlL4VayD7KrOVS3ywb9A+F3s9VCfXabH0yAmF2ZNn6ZPZro2yZOftXqN80
         6kG1OszTdxmiFaYfZYM2VBrTxXsfeA8x0HBRfBUSW1JYsBVGFS56j4kll2kID9QEJAJN
         zvhwwMChCiHIO41aosfxLxJ48PSjHa3xV/MlwKY/hBK8XJq3mz6qGo0vzisyPezUYyO9
         f/DPeHF7bsDiCiOPfDenVH34kzSRJX9kJzlN+CDybdRkDAp75MgtMdRhoT0EtWQCt1TR
         0mYIlqoEHYdkRCUJJYuu/3TI6KDBxTWOSGkJwkmnm7+oAPrgkOxQyWmRUofH6+j4v6Of
         eI3Q==
X-Gm-Message-State: AKS2vOyLaxgZdjF4Cp9whzj9Z6oxl1psfszS0PxfMJSzwYlsYFiJKCPa
        ORpPHAxUGNadumBUMcDREP+sUfqsyobt
X-Received: by 10.31.3.17 with SMTP id 17mr5115698vkd.51.1498629645162; Tue,
 27 Jun 2017 23:00:45 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.176.23.13 with HTTP; Tue, 27 Jun 2017 23:00:24 -0700 (PDT)
In-Reply-To: <xmqqa84t2yaa.fsf@gitster.mtv.corp.google.com>
References: <CAKKM46uJLu+w-UUFZc1HRar3apAD6Db2KD+GjiNL5v+Q2Ni7hA@mail.gmail.com>
 <xmqqa84t2yaa.fsf@gitster.mtv.corp.google.com>
From:   Michael Kebe <michael.kebe@gmail.com>
Date:   Wed, 28 Jun 2017 08:00:24 +0200
Message-ID: <CAKKM46ureAZNB-YjOrmi+H-_tf3hXGS7dA7o=dj8bnHc+8ABng@mail.gmail.com>
Subject: Re: Solaris 11.3 SPARC grep problem with t1450-fsck.sh
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

2017-06-27 18:25 GMT+02:00 Junio C Hamano <gitster@pobox.com>:
> Ah, wait, that particular grep may have GNUism.  If you changed it
> to
>
>     egrep "$tree \((refs/heads/master|HEAD)@{[0-9]*}:" out
>
> does it make it pass for you?

Yes, this is working.

Greetings
Michael
