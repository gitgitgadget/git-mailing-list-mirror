Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9AD991F462
	for <e@80x24.org>; Mon, 29 Jul 2019 07:58:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726930AbfG2H6z (ORCPT <rfc822;e@80x24.org>);
        Mon, 29 Jul 2019 03:58:55 -0400
Received: from mail-ed1-f49.google.com ([209.85.208.49]:43421 "EHLO
        mail-ed1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726586AbfG2H6z (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Jul 2019 03:58:55 -0400
Received: by mail-ed1-f49.google.com with SMTP id e3so58477446edr.10
        for <git@vger.kernel.org>; Mon, 29 Jul 2019 00:58:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=puck-ch.20150623.gappssmtp.com; s=20150623;
        h=from:mime-version:subject:message-id:date:cc:to;
        bh=bTDFoC7HHsmYWrOB2yVm5ZQfLeOnErXUotHWvqlTsO8=;
        b=cH+sy2ZqvqCNLALD5VYSjxebLues6RRyj8bHd2wwf31NZZ+Sm/Rm+qIkoqJ8wq196Y
         SDWaXgsVMI3F1yxQKYh9Xf2Cm+gT4adiayEssQpFPB7LtlKDY5mj8pLezyzMoZzSVmsZ
         wOlGIBCF8bsGRv6jL5qac7hMbmIbQAoWSpSRL0asyhuP4aW3RQnCAmMQg1PwlAskIdy/
         o+MM7kf7LpeM552risyTxWxWq6pQXLnhKuda4Sb11Xlqjn7tC+J0mkBL1LdiLSMVgc2I
         ZVb7wKYXOKQ9/FI4CqYBVxaaQgmUxq+Wlexjbit5fqNgMC8fKJUD33SH537H7v687qyy
         YqfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:mime-version:subject:message-id:date:cc:to;
        bh=bTDFoC7HHsmYWrOB2yVm5ZQfLeOnErXUotHWvqlTsO8=;
        b=F2BO64fw0laZCOrqDM3q/bLlVE9AaIQglNNkN5V4fJnvVfcvnui2Ud3Olno8CKxEp+
         axcxi23yx/A6sdHXttu0Zs6lQNs0lONtVJpc0Ry9J6ERND41SoJsI5HCO5Y4KxfbvfLF
         LtytC9af9HgQM8/wCGz+AJ/UHf4I2DMEVXrBikjiY3jF7pqzfB0sZCPY/mvC8Y9e9QDO
         sq7ztyZdfHwSQFyVbZGJidaVWUl6SUEIFfD3SrJCRuquhu08fYxkKqrtYZyzpcR5MPFd
         A6bqctgcagcvlHmd/z5lzNjyHL0QL0o2Sy8WSDy0R23LG7zrEEOkY11KopBDdpIrsgcb
         cAgg==
X-Gm-Message-State: APjAAAX3cxFGGCjSP7/NRP1/3zXxp94zd/13Iz5qhoMtQcxjMJVE7aUH
        WdLDokFCDlRSXRsw8VVCm131fY8=
X-Google-Smtp-Source: APXvYqwE3IjJ1mV3+ijB9Fj8hvfndjstdKS0FQS0oA8YVSIywFoNKheC8SemDpA3jsOolpekAkWv+w==
X-Received: by 2002:a50:eb0b:: with SMTP id y11mr94771058edp.224.1564387133710;
        Mon, 29 Jul 2019 00:58:53 -0700 (PDT)
Received: from ?IPv6:2001:620:7a3:701::acff:fe1d:13fd? ([2001:620:7a3:701:0:acff:fe1d:13fd])
        by smtp.gmail.com with ESMTPSA id g7sm15549633eda.52.2019.07.29.00.58.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 29 Jul 2019 00:58:53 -0700 (PDT)
From:   Olivier Bornet <olivier.bornet@puck.ch>
X-Google-Original-From: Olivier Bornet <Olivier.Bornet@puck.ch>
Content-Type: multipart/signed;
        boundary="Apple-Mail=_BD6A03FD-D20F-433E-AEDF-36EEA69F84D5";
        protocol="application/pgp-signature";
        micalg=pgp-sha1
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: Problem with fsck and invalid submodule path in history
Message-Id: <9C668779-15AC-4099-AAFA-7FFF519D426F@puck.ch>
Date:   Mon, 29 Jul 2019 09:58:52 +0200
Cc:     Olivier Bornet <Olivier.Bornet@puck.ch>
To:     git@vger.kernel.org
X-Mailer: Apple Mail (2.3445.104.11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--Apple-Mail=_BD6A03FD-D20F-433E-AEDF-36EEA69F84D5
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=utf-8

Hello,

I have a git repository with an error in a submodule path in the =
history.
The submodule path is =E2=80=9C-f=E2=80=9D, which is not allowed. But =
for some reason, it=E2=80=99s in the history of the git, and I=E2=80=99m =
trying to find a way to manage it without having to rewrite the full =
history on the main gitlab (if possible)...

To reproduce this unwanted history:

    mkdir test-bad-history
    cd test-bad-history
    echo "Test git submodule problems" > README.md
    git init
    git add README.md
    git commit --message=3D"Start test"
    git submodule add https://github.com/leachim6/hello-world.git
    git commit --message=3D"Commit new submodule with correct path"
    # the bad part...
    git mv hello-world -- -f
    git commit --message=3D"Move submodule to an invalid path"
    # correct it...
    git mv -- -f valid-path
    sed -i.bak 's/-f/valid-path/' .gitmodules
    git add .gitmodules
    git commit --message=3D"Back to a valid path"

After that, even if the git is working correctly, we have a =E2=80=9Cbad=E2=
=80=9D history if we check with fsck:

    $ git fsck
    Checking object directories: 100% (256/256), done.
    error in blob 19a97d3b70760c74b780c8134e33f5392292c2e6: =
gitmodulesPath: disallowed submodule path: -f

Is it possible to correct it? Must git handle this kind of errors?

Thanks in advance for any help.

--
Olivier Bornet
Olivier.Bornet@puck.ch


--Apple-Mail=_BD6A03FD-D20F-433E-AEDF-36EEA69F84D5
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----
Comment: GPGTools - http://gpgtools.org

iF0EARECAB0WIQTQBq6Ke3j78UKE67h2PdH8xT2SGAUCXT6nPAAKCRB2PdH8xT2S
GEkyAKDa1ZIZjJbp10UkCAjwRhbS8brtZACgi4pCWcFaeh2E1RJWLC3rQINkbAQ=
=bPnx
-----END PGP SIGNATURE-----

--Apple-Mail=_BD6A03FD-D20F-433E-AEDF-36EEA69F84D5--
