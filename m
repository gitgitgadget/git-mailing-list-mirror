Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 566301F42D
	for <e@80x24.org>; Thu, 17 May 2018 06:58:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751530AbeEQG6f (ORCPT <rfc822;e@80x24.org>);
        Thu, 17 May 2018 02:58:35 -0400
Received: from mail-pg0-f52.google.com ([74.125.83.52]:35621 "EHLO
        mail-pg0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751478AbeEQG6c (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 May 2018 02:58:32 -0400
Received: by mail-pg0-f52.google.com with SMTP id n1-v6so1409941pgs.2
        for <git@vger.kernel.org>; Wed, 16 May 2018 23:58:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:openpgp:autocrypt:message-id:date
         :user-agent:mime-version:in-reply-to;
        bh=/Aj0JoZKh/UvE9D7ZdwyphyUY3o9SfjBUKWg2+B7bsg=;
        b=aXsYMUbttrwZy8eesPPxe5gtgyRA5AyQl+h7+QUxpzR7/yVlglfCIoE6ZsONgwswFI
         UjHnrIpG72QZ0gTPul6172Usr1MRQ9eTtyOKilm3NaNUMqFI2Sy5nBo32YWU/NnqK3ct
         6Z29tZEYSw5q667Kn0FxEbnYNn8hYLDbAtVWsvd0KLTYByXYO31a0I0Iv3r90pbzvH8c
         wt331c+rvVVEhI8egGyaYbG3ehZV++qWt0LqSKoIwDlDfj6l9ybKYQRPLEne5q7q3HU7
         RYBkaSeYFxuq0rJhRpaMBFMa1I8ta6xroljjtyYSa5TQZkPMQ1O9TjLGR7q4aO59k9GG
         dKqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to;
        bh=/Aj0JoZKh/UvE9D7ZdwyphyUY3o9SfjBUKWg2+B7bsg=;
        b=qbrm1Y+olLxgoR7SNt3kLP9a24jBYdeF+uROXHft5OeDjx7Bk16qWx5JbrhoHq1uhw
         WfSwjsKmhGF2QU7YfeOj2walQnD1qKClvm0vtIQAvfYo6HQO3vpADEhJWYVGCeAH3d7r
         g18CJaEWG0uIgmxQqBEwsPaJXM/ed8RPX5BXE988Ril3UkQMmLlMwB7k0EIUOz5QL0Hw
         KkIvtZ4n1lNFmi4HdWQ/eoZmDkDltjHMdTzvvw9JeDBVaxYxIjIsRKSXmsjc5K94UZ9V
         7stjz64a5Tp34fkT5AgbHGdQKql62yDGV1P6LbEXIR4Ur0reqMNH0QuiDbPcUD1Cxyf0
         t2uQ==
X-Gm-Message-State: ALKqPwfj3h4mqALhXaDARYh07H8xEoDOBJLW3sUljQFx21YHjOcpmwJc
        JOMbIjtemrAOh9Rx1ZSkF7k=
X-Google-Smtp-Source: AB8JxZrlCoIh9wzNWTbenLoRZu9p/3WBSQv1ogLPpOim5vaDeFlHKjz3bkgdLciJ9PIEhwIwcWb3Bw==
X-Received: by 2002:a62:e53:: with SMTP id w80-v6mr4149288pfi.236.1526540312281;
        Wed, 16 May 2018 23:58:32 -0700 (PDT)
Received: from [192.168.206.100] ([117.249.233.154])
        by smtp.gmail.com with ESMTPSA id e6-v6sm10938203pff.185.2018.05.16.23.58.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 16 May 2018 23:58:31 -0700 (PDT)
Subject: Re: [GSoC] A blog about 'git stash' project
To:     Paul-Sebastian Ungureanu <ungureanupaulsebastian@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
References: <67e6d306-0885-9340-13c8-3e3d4333dc20@gmail.com>
 <ef15b063-c0e3-a5e9-7418-35d2d6b954f3@gmail.com>
 <e8a81d38-57d7-2974-b5c7-3489e8ceb1fc@gmail.com>
From:   Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
Openpgp: preference=signencrypt
Autocrypt: addr=kaartic.sivaraam@gmail.com; prefer-encrypt=mutual; keydata=
 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
 IZ7P/DJ/
Message-ID: <68b913de-8f4a-9203-1d63-32104a35628b@gmail.com>
Date:   Thu, 17 May 2018 12:28:23 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <e8a81d38-57d7-2974-b5c7-3489e8ceb1fc@gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="VwximYy8KZv4fvpPrnjmuf7JIrmSVO3s5"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--VwximYy8KZv4fvpPrnjmuf7JIrmSVO3s5
Content-Type: multipart/mixed; boundary="KfJjZ3VVZRl2yjMhylyBq285fEVB0mNbO";
 protected-headers="v1"
From: Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
To: Paul-Sebastian Ungureanu <ungureanupaulsebastian@gmail.com>,
 Git Mailing List <git@vger.kernel.org>
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Message-ID: <68b913de-8f4a-9203-1d63-32104a35628b@gmail.com>
Subject: Re: [GSoC] A blog about 'git stash' project
References: <67e6d306-0885-9340-13c8-3e3d4333dc20@gmail.com>
 <ef15b063-c0e3-a5e9-7418-35d2d6b954f3@gmail.com>
 <e8a81d38-57d7-2974-b5c7-3489e8ceb1fc@gmail.com>
In-Reply-To: <e8a81d38-57d7-2974-b5c7-3489e8ceb1fc@gmail.com>

--KfJjZ3VVZRl2yjMhylyBq285fEVB0mNbO
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

Hi Sebi,

I thought of pointing you to one of the issues with the current
implementation of 'git stash' which you could probably fix while porting
it to C. It's about stashing untracked files.

You could find more information about it in the following mailing list
thread:
	https://public-inbox.org/git/1505626069.9625.6.camel@gmail.com/


--=20
Sivaraam

QUOTE:

=E2=80=9CThe most valuable person on any team is the person who makes eve=
ryone
else on the team more valuable, not the person who knows the most.=E2=80=9D=


      - John Sonmez


Sivaraam?

You possibly might have noticed that my signature recently changed from
'Kaartic' to 'Sivaraam' both of which are parts of my name. I find the
new signature to be better for several reasons one of which is that the
former signature has a lot of ambiguities in the place I live as it is a
common name (NOTE: it's not a common spelling, just a common name). So,
I switched signatures before it's too late.

That said, I won't mind you calling me 'Kaartic' if you like it [of
course ;-)]. You can always call me using either of the names.


KIND NOTE TO THE NATIVE ENGLISH SPEAKER:

As I'm not a native English speaker myself, there might be mistaeks in
my usage of English. I apologise for any mistakes that I make.

It would be "helpful" if you take the time to point out the mistakes.

It would be "super helpful" if you could provide suggestions about how
to correct those mistakes.

Thanks in advance!


--KfJjZ3VVZRl2yjMhylyBq285fEVB0mNbO--

--VwximYy8KZv4fvpPrnjmuf7JIrmSVO3s5
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEmrp5T6QugsbUnN0Nveda2sPWGWkFAlr9KA8ACgkQveda2sPW
GWm4SA/+L+hbBznkiSHr3W1fVq7p4lg2NFib2/be28faMbyb6DEOFfccAXDnijMu
UoVR+7u1ODVxMAyVC4gUEEibLLDIBK8uzhifmS1wHbsuC0mqih9w0Hpzfa1h9ukm
CT6L3CBH/s1DBQku9SWOU1pZrkINqS7brqQfpZIbZ+a0DA4TufaWoymfq3FJlCZF
W2tv3Ra9nr1cQyrOZtZc/NpemDgMq0oP5YrbXwS8n/LPlMNeWRVYI/2+qzGK/78E
UlYBDRWGQboTBT870r7WODOxZAZr+INfLZAKz3wi5kT0urKkU6t3fVn/aXwBrmbQ
AgMURU3AHeFi9tYnhc2Qqmvl3v65gWWMh2KC2iw8ckGQvrg6lG9lRQnDGLhUrz3B
A1JlwwqfCN7Ke0FMulQ43qJ90mdkvmN7/2muh5aPZh9HbFvPWdkiE7/EAq6bU/mF
L+dakegjfKLVRlEvlw/I+Vn9w+f9MlBzFmji6zt/neQK8g0z/kQC5LuHc58FOBLo
yNwTkowHTi3NLv00554/WsPC60HOKcS9a1GK1AcMgHKTZrkadP9EYGmajaQvjYV6
LeWIA4bU590ETgVw12smIEP2ZRbXIE7faHQ1ybns62jVD9Vx24LYl/6v3hkwZAcd
c2wE+bB51OUAYswb37VBCTtsQ6SAeVYy35jn2os75Px+a1A9Los=
=Ro0M
-----END PGP SIGNATURE-----

--VwximYy8KZv4fvpPrnjmuf7JIrmSVO3s5--
