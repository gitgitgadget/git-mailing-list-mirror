Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 176DB20756
	for <e@80x24.org>; Fri, 13 Jan 2017 14:59:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751830AbdAMO7P (ORCPT <rfc822;e@80x24.org>);
        Fri, 13 Jan 2017 09:59:15 -0500
Received: from mail-qk0-f194.google.com ([209.85.220.194]:33058 "EHLO
        mail-qk0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751739AbdAMO7O (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 13 Jan 2017 09:59:14 -0500
Received: by mail-qk0-f194.google.com with SMTP id 11so7419777qkl.0
        for <git@vger.kernel.org>; Fri, 13 Jan 2017 06:59:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=QupDKtxx95lIkx1Ez0w+73ORw9ivN0tTwZX9n+LAcgY=;
        b=pkCAHoYgDU4E0BlklIiwjp5p9DPNDDhFV+XTR5XDnqWYQtr2cT+eJFsOaGDmyb/eUE
         uLnirir8ZEOJJ+wO6O+kxiblRVJR1iRN8O4rGB6y3tIZCYx+f+Ry58DPs9MqTbHAZNR8
         JTtgykOLMrqWFNnFKq3zm1OzQ/gqNLGJK6OoKL4/jeHjLOb9i6nYmYhyTYilzwd35eTN
         9L72tHigUHGHE8G8tpFE+B9i7NpdbpDUB6kRFf9Z/3DQfQm0XkHDXngGztiF44DyDwlu
         HcQtrQORmVHO5geAer2Bm0jIaQcitm5cr/oXdg+jGGXVL7JoBMyZ5/Y2OuR7iFxloBr3
         e5uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:mime-version:subject:from:in-reply-to
         :date:cc:content-transfer-encoding:message-id:references:to;
        bh=QupDKtxx95lIkx1Ez0w+73ORw9ivN0tTwZX9n+LAcgY=;
        b=ExZ1E9dzz33c5bVe+O3mb5Wh9WS8s9kyhy3XJKoA3EG/EkaWosufTtI4pfkdGBTD/c
         wYsI0men/YGM503iB7sJqURe85KmLcvyM1SN9gPhO9Upe2bt5z5Mi6hjtQ58PZTOfl81
         kGHx6XDY979b+YpBkE3l/iC1uSEBSoJRPaogN4/aqKPQhwgk1v4D4+25HOzfQuDqiM6M
         ICsyzCKlQ8XzfsOUPWLeh2p5iy1GU3vs0xbez83wZ9L9e2YwuSHNboKQKPCX/1nwDkIp
         Y8fr/isDSdyuCpsmIvqAF6fucE36jNYs+7mG7FTyP37mqosL7GlVW5LiwMpN04QKSkAT
         2Abw==
X-Gm-Message-State: AIkVDXLcdZ26uWnCPZzQ5dDE2AQMCISKXJyXNA6vz0zECtl68ioh9/huB74ISh1ZQESICg==
X-Received: by 10.55.74.134 with SMTP id x128mr10467462qka.120.1484319553949;
        Fri, 13 Jan 2017 06:59:13 -0800 (PST)
Received: from mbp.home (179-125-204-138.desktop.com.br. [179.125.204.138])
        by smtp.gmail.com with ESMTPSA id r188sm9345460qkb.6.2017.01.13.06.59.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 13 Jan 2017 06:59:13 -0800 (PST)
Content-Type: text/plain; charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 10.2 \(3259\))
Subject: Re: [PATCH] Remove dependency on deprecated Net::SMTP::SSL
From:   Renato Botelho <garga@FreeBSD.org>
In-Reply-To: <20161120215344.jaqt4owlhovig3hz@genre.crustytoothpaste.net>
Date:   Fri, 13 Jan 2017 12:59:15 -0200
Cc:     Mike Fisher <mfisher@csh.rit.edu>, git@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <9D9E7BB6-9AAD-4356-A500-A86DA7C958EF@FreeBSD.org>
References: <451E4A46-BA43-41A5-9E68-DE0D89BE676A@csh.rit.edu>
 <20161120215344.jaqt4owlhovig3hz@genre.crustytoothpaste.net>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
X-Mailer: Apple Mail (2.3259)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> On 20 Nov 2016, at 19:53, brian m. carlson =
<sandals@crustytoothpaste.net> wrote:
>=20
> On Sun, Nov 20, 2016 at 04:18:16PM -0500, Mike Fisher wrote:
>> Refactor send_message() to remove dependency on deprecated
>> Net::SMTP::SSL:
>>=20
>> =
<http://search.cpan.org/~rjbs/Net-SMTP-SSL-1.04/lib/Net/SMTP/SSL.pm#DEPREC=
ATED>
>=20
> As much as I hate to say this, I think this is going to cause
> compatibility problems.  Net::SMTP is part of core Perl (as of =
v5.7.3),
> but the version you want to rely on (which you did not provide an
> explicit dependency on) is from October 2014.
>=20
> That basically means that no Perl on a Red Hat or CentOS system is =
going
> to provide that support, since RHEL 7 was released in June 2014.
> Providing an updated Git on those platforms would require replacing =
the
> system Perl or parts of it, which would be undesirable.  This would
> affect Debian 7 as well.
>=20
> We currently support Perl 5.8 [0], so if you want to remove support =
for
> Net::SMTP::SSL, I'd recommend a solution that works with that version.
>=20
> [0] I personally believe we should drop support for Perl older than
> 5.10.1 (if not newer), but that's my opinion and it isn't shared by
> other list regulars.
> --=20
> brian m. carlson / brian with sandals: Houston, Texas, US
> +1 832 623 2791 | https://www.crustytoothpaste.net/~bmc | My opinion =
only
> OpenPGP: https://keybase.io/bk2204

Net::SMTP::SSL is marked as DEPRECATED on FreeBSD ports tree and will be =
removed in 2017-03-31. When it happens users will not be able to run =
git-send-email anymore. I=E2=80=99m considering to add Mike=E2=80=99s =
patch to FreeBSD ports tree as an alternative but it would be good to =
have a official solution for this problem.

FreeBSD bug report can be found at =
https://bugs.freebsd.org/bugzilla/show_bug.cgi?id=3D214335

--
Renato Botelho

