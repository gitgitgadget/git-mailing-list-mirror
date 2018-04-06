Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CF0761F404
	for <e@80x24.org>; Fri,  6 Apr 2018 12:32:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752466AbeDFMcV (ORCPT <rfc822;e@80x24.org>);
        Fri, 6 Apr 2018 08:32:21 -0400
Received: from mail-qk0-f176.google.com ([209.85.220.176]:44780 "EHLO
        mail-qk0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752423AbeDFMcU (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 6 Apr 2018 08:32:20 -0400
Received: by mail-qk0-f176.google.com with SMTP id n139so913346qke.11
        for <git@vger.kernel.org>; Fri, 06 Apr 2018 05:32:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ftfl.ca; s=google;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=krdA6nvvKRvVjAdg7Q31zTQkZs0cixnAnt0Sa9BtVKg=;
        b=dDZtEPMe5lRGnVelziBDOxelzqNETS1LhJL5M19eWD0Vd1Tm+YRiHQMg0dqLeP4wdU
         2K/7fbFy1IJHe8Ydkoh5MTuzOyu60yi+AZY5F5fqT1H20/u9GNxT4+bDcb+f0ImGg4p3
         EORF3YXXo7NX0m7UFpg9hB7P/3dwoYgjzIBjk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:date:in-reply-to
         :message-id:user-agent:mime-version;
        bh=krdA6nvvKRvVjAdg7Q31zTQkZs0cixnAnt0Sa9BtVKg=;
        b=XOEVGTnV/VCFjk6QYBBaPT/a19m69Dn/iJ7FDR4PRWF1EsjlGhnjyWE30DnCt93aAj
         WNBt/dQFVPJTdXLcY4FdLPgP7ytZ2OUQn+Rkr/Rmxj0M1b5h16A2jt/rcGBSLEZkR6dB
         NoNwNZ05Dr8ba5+codAbR1JvxEk3bJQDkWkdfOchVnNuT7w/7WO0TlYeg6dFX5ihfgz5
         P5Q0WrbkNVaiDIhSZ/e2ULvwp3Ez/TZhlhAGa2dyKeWtOhC158EMxoYXKwF7YASUuFY1
         FXOnoH+bTemOkFFX7JiEjVBNBzLIXLFjTtz6QRMCcGG5yaPJ7AZ2q8D4k315X54wGSXv
         3s6g==
X-Gm-Message-State: AElRT7EHphhJCqx+n/ru3HjLJZs7YabdaE//w61OaJD7BR4Eovko+sy4
        LODwityrN9p1iyDV4ZFuwLVlkDGCJzE=
X-Google-Smtp-Source: AIpwx4//XhxmpZQrEV80lzF9J2uJgJ6eGFAJ96lDcl7owzKQ7AEkxP2b9G+CplOCkLlAtjee15/T7A==
X-Received: by 10.55.25.134 with SMTP id 6mr34160817qkz.52.1523017940114;
        Fri, 06 Apr 2018 05:32:20 -0700 (PDT)
Received: from phe.ftfl.ca.ftfl.ca (hlfxns017vw-47-55-140-73.dhcp-dynamic.fibreop.ns.bellaliant.net. [47.55.140.73])
        by smtp.gmail.com with ESMTPSA id b31sm8208014qkb.83.2018.04.06.05.32.18
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 06 Apr 2018 05:32:19 -0700 (PDT)
From:   Joseph Mingrone <jrm@ftfl.ca>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     git@vger.kernel.org, garga@FreeBSD.org
Subject: Re: git 2.17.0: uninitialized value $rec in scalar chomp at ...Git.pm line 557
References: <86h8oobl36.fsf@phe.ftfl.ca>
        <nycvar.QRO.7.76.6.1804061420340.55@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
Date:   Fri, 06 Apr 2018 09:32:17 -0300
In-Reply-To: <nycvar.QRO.7.76.6.1804061420340.55@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
        (Johannes Schindelin's message of "Fri, 6 Apr 2018 14:21:31 +0200
        (DST)")
Message-ID: <86d0zcbjn2.fsf@phe.ftfl.ca>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.3 (berkeley-unix)
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha512; protocol="application/pgp-signature"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

--=-=-=
Content-Type: text/plain

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> Hi Joseph,

> On Fri, 6 Apr 2018, Joseph Mingrone wrote:

>> After upgrading to version 2.17.0, this message appears repeatedly when
>> running `git svn rebase`:

>> Use of uninitialized value $rec in scalar chomp at /usr/local/lib/perl5/site_perl/Git.pm line 557, <$fh> chunk 1.

>> The value of chunk varies.  For example the message above may end with
>> '...<$fh> chunk 5.'  This is with the FreeBSD packages git-2.17.0 and
>> perl 5.26.1.

> Does this stop the `rebase`?

> Also: could you publish the unrebased branch so that others can reproduce
> the error? (I am not claiming that I have enough time; I don't...)

> Thanks,
> Johannes

Hi Johannes,

No, this does not stop the `svn rebase`.  This is with the FreeBSD ports tree, svn.freebsd.org/ports, following the setup described at https://wiki.freebsd.org/GitWorkflow/GitSvn .

J.

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQKTBAEBCgB9FiEEVbCTpybDiFVxIrrVNqQMg7DW754FAlrHaNFfFIAAAAAALgAo
aXNzdWVyLWZwckBub3RhdGlvbnMub3BlbnBncC5maWZ0aGhvcnNlbWFuLm5ldDU1
QjA5M0E3MjZDMzg4NTU3MTIyQkFENTM2QTQwQzgzQjBENkVGOUUACgkQNqQMg7DW
756blQ/9GGWH/MKCiYV5p4Tw+sZgC/LGHkB7ADyt5UBgDL2GH9yhYwd4mZgqpqv1
bIElW9pgYNR9vFFtuwQjOkDPEWniKnA57j6KmLOeCCwj07mPuVPHbiHi6ymX2S1j
gzVXvlgeFw9D3uqmImr2tcW6KWe6kMykFp6ZZM4RW43XmlvvhrpCr+Ge64LdlvCk
IKWDwbLD0R4RPsUM/XVUsx1mUI6u/sEN4BYZe+D0fXtI/wFgP8OWsXIc5UfhTimy
nG4uuKiXEzKYZeSizXwg6gOBmi+MSlF8WwUaF+ZGVPBSD4cM8gq/BFd9ifTaYtZX
BjE8XoPF5HKrscGgDZPM9Znkczm5fRbenefjSvfK/ds+wmewh9Gl8ONddc+t/42A
ybtWH86M35u4wMC9bEY7Z5RhCktIkDtFBKdJnfp16bBLpjrGHpS/AjhPP11j21ST
2JH3ux01trBBk98cMLL3sV/nilKTcgGbzuEne/hy6q3Y3D5m96RG+D3cKy1Zqi3v
c7x1R+ETaOrZ2CooxA+7Z6BxmLq47QIljlXbsnO8lwubRhnMK7yDFmjrPOqZqN2j
NDrWIk8bBFNVfm8u+nzotNJqWvgop6sv+nIa+Xc9eCEkYi3Ibi8d9j6cjCf/KkDt
t8+bPpIA+gD6IJFG4k9JVmS0+hVj7pulkU5UGvF/XSNnXDFPS0s=
=i8bj
-----END PGP SIGNATURE-----
--=-=-=--
