Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D19A01F404
	for <e@80x24.org>; Mon, 17 Sep 2018 01:02:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726889AbeIQG1l (ORCPT <rfc822;e@80x24.org>);
        Mon, 17 Sep 2018 02:27:41 -0400
Received: from mail-ed1-f41.google.com ([209.85.208.41]:45979 "EHLO
        mail-ed1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725872AbeIQG1l (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 Sep 2018 02:27:41 -0400
Received: by mail-ed1-f41.google.com with SMTP id p52-v6so11462465eda.12
        for <git@vger.kernel.org>; Sun, 16 Sep 2018 18:02:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=tDGCVa/ZIZr9FBLq/5u9yvNNiFDVA9Upuc+LIGg2zUM=;
        b=ne7mJXaTURq+Ie6tJ1PZTMb2uOb3TWDpQDIFXwuKcMEllmO/XzOr3N+MX5GQvdf4ub
         iaH2qgWXeTcgqOVaQ8YTCKT1e+ogRQyPLn6C0xube4ZG4mWAgaBzK3TNUdivgOEaLrkv
         TffJ8lRztUFsbNluyZa8h5zlGC3Ah2xbNovfBln5+zl34lHVgEB24APnDqDrRDAJ5Ig7
         YkxA3dOOwnAynRQ95yYNqvwUNRjG8PcoCHRUvnEmma3L2NDfXsuYe4sH3084W3X8XS1I
         m1VN47B9nyXe5G3PPElKgRlNnnLgNoWXJaKkkW9/RNv8dImKMnScHcnWCVnMEgYAf5iB
         HOMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=tDGCVa/ZIZr9FBLq/5u9yvNNiFDVA9Upuc+LIGg2zUM=;
        b=Ygu3HLJGycfE/NfJpaqSLmOcu+1IjH25Vnf1UYXJfXNeWZ+nvsilONkJDmnEmAtAz9
         AO3qrScS+wN1hBbNfQNY7VAYLH+s/5Pa0XQfA4cvB4GGe2SSfT4GDStcwR32LNjSICZ0
         YvaqsGN9QnEa40o58Xhc0vBYxaEACft58PXTYUDj2GAE8N9cSSRFjHy50ZbfPem8ykzS
         iuX3IbTrxZbmZs+zFzbPWqhJtCEL2QENsCay8zublJ2kx7z6vpcVZEGWd3Yz4tkoybki
         oO/CpSH5RtJa9mls0oHGQYc0XykHwT49RM/AQkfOLBcaaTm4JOZSFmqDyYTnN+uNa7bM
         4CtA==
X-Gm-Message-State: APzg51DFiV1hE6ifIr9JU5Wa51c8fsqtlzaJSkHS7fiQJOsq5XQbt7Br
        ocOLd8B9aFJqT2wjeva5zy/LIFSq2sg=
X-Google-Smtp-Source: ANB0VdbaFVX3IoBtu90bRX1HGSGIYUPSQdaNfvaATsCBR113RinNxwmR4AnJdfkdj/FWI7CigSWqpA==
X-Received: by 2002:a50:8141:: with SMTP id 59-v6mr39116401edc.61.1537146165739;
        Sun, 16 Sep 2018 18:02:45 -0700 (PDT)
Received: from localhost (92-109-79-134.cable.dynamic.v4.ziggo.nl. [92.109.79.134])
        by smtp.gmail.com with ESMTPSA id f26-v6sm5785034edb.28.2018.09.16.18.02.44
        for <git@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 16 Sep 2018 18:02:44 -0700 (PDT)
Date:   Mon, 17 Sep 2018 03:02:44 +0200
From:   Chris Coutinho <chrisbcoutinho@gmail.com>
To:     git@vger.kernel.org
Subject: Question - no space in smtp-server-option
Message-ID: <20180917010244.btmlczam5m75rmto@tumbleweed>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="wawtu7bkkzzyf52e"
Content-Disposition: inline
User-Agent: NeoMutt/20180716
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--wawtu7bkkzzyf52e
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Git community,

To send a formatted git patch as an email using git I use `git=20
send-email`. Using another email address than my default one requires=20
the 'smtp-server-option' to be set, and currently this flag doesn't care=20
much for spaces. Is this desired?

Currently my gitconfig contains the following line:

	sendemail.smtpserveroption=3D-a<myaccount>

Whereas, the following results in an 'account' not found error:

	sendemail.smtpserveroption=3D-a <myaccount>

Further, the full account flag (--account) is not recognized by=20
`send-email`. Could someone expand a bit on the reasoning behind this?

Regards,
Chris

--wawtu7bkkzzyf52e
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEgByWpgIJZOpMvgTGINFyBbymYXQFAlue/TMACgkQINFyBbym
YXSyMA/+OYupkrh+Icsm94osMYXGocsHtuRhhAWNBu411qGaFcisr3qqJlClxwk1
+E/CXlbCpYUVz/E+SdMzN1U+i9DCWIkE6ZbZdkCTHcSF4tNUW26YwzTDh3tvY2TN
F0MoY05sSoDV0KBVs7SWGfbbgeg3JLR5JbC41FPNfbyCP/gL862PJbAX6KI21S3n
rTGgL/ssPDykb/ZCgQozyWyZUZxii8G9rQydzWqhqCrnnI6IrEAEf6QsZDSctE5G
ibaXrzTbPcq2BnKoUss/HGDRboT1mz9TNaMe+TF72V9p+ubQdqbg55PHHSWVENyR
EY7UFySrYDSlC4ikr4uSnRKGgzgsFQjNJGpdccuQdf3UYMW4KydIOeyz0kx6dNGe
ky1jNx1P3Qpkr9LceZMTJZpd09AnkpFCReFteNKEYd9Y9NfmhB9SWBSN0LTidN+b
zS1lcWQodfjOZHs33oQ7spy0IS5XD0o8o6rHZvQtcS3GKBiqgER39HTc6RR4qmDL
xgpJzTx5IYhNX4758jTytgjTrS24VMYXHFxPvTvd4EMUR1ltczKS9P4WmBcVPuBV
fhyrUsPUplDM+P4WIdJ2kQkO9/IT4gf/ssVo6AfCNp3RjVIaQBBuIIpaVHVeG/rb
iHiXSh3LUOy4V1Gctl1gOD5yjJT+thTwQ5QjR8OIEk9Mc3EWftM=
=5ReV
-----END PGP SIGNATURE-----

--wawtu7bkkzzyf52e--
