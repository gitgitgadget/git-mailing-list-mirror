Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6B9B51F404
	for <e@80x24.org>; Tue, 27 Feb 2018 20:52:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751848AbeB0UwK (ORCPT <rfc822;e@80x24.org>);
        Tue, 27 Feb 2018 15:52:10 -0500
Received: from mail-io0-f172.google.com ([209.85.223.172]:44064 "EHLO
        mail-io0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751754AbeB0UwJ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Feb 2018 15:52:09 -0500
Received: by mail-io0-f172.google.com with SMTP id h23so728984iob.11
        for <git@vger.kernel.org>; Tue, 27 Feb 2018 12:52:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=to:from:subject:organization:message-id:date:user-agent
         :mime-version;
        bh=Q9lGOkcgd6va3cpheRDinNm/jqsQFCpKXZwfhDtOjGQ=;
        b=OnEKBnqaNCIoppSgq7mdvvJ+BTt493IvxsxaWjvq4hFNGaHsCJBIVeAO2nE1MbszL8
         a5GfyEyLFFjn9brAEB2+X9CAEzxHqMw430b5FEJreE82BU8ACuwbXsh+QUA/SiXD04Uo
         h0cbchkS9MDxMGit8xmamR5SntcT4Sw4gcFMg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:from:subject:organization:message-id:date
         :user-agent:mime-version;
        bh=Q9lGOkcgd6va3cpheRDinNm/jqsQFCpKXZwfhDtOjGQ=;
        b=uRM2HGbgmIKooEuNkILn7YvAasHdBqINgJsA26kdeTnhGO755YSIQF9AV2SHXmRoxu
         isK/IYSGgei+TfW2hOOupsV23ryKcUwlAb25gxZprAcw3yRbgrEK1qAJY2dT/1krwrvz
         O1OqIBsEq3UaVYaM2neVLR6EPD5rc5u03J4jP7kfuUw45dJb6iHQC9FS0EoQjWFkA7b8
         xvRomVrSfNxCKYPXrtcUCr/U9jvO6gzv19Km9Q5PXFE3Gc31msqYrP8CB2fy+ynOV1jM
         NLYxBPWMoMP/KKGpKlxNFuJP3jtK74DAwpSwI9iUwDTA6xpXFZQzwDltQM1dHzc8Ro0k
         MTlQ==
X-Gm-Message-State: APf1xPDPbl2e4ICUoZpnwg0tIByueCY9nT9qrjjEdYZmZ7rxSSyMd6Xp
        jhzA+7HtVvnZ7G4natTC+jBjxIOvD6A=
X-Google-Smtp-Source: AG47ELtPLa0jkwlr5LBAJkaSSiqDT+5JxtSDAGBXqgpFSiRzZNEv2Ok3+v64TscyejC+2eAGPpYeow==
X-Received: by 10.107.180.196 with SMTP id d187mr17799259iof.187.1519764728227;
        Tue, 27 Feb 2018 12:52:08 -0800 (PST)
Received: from [10.137.0.22] ([199.66.90.113])
        by smtp.gmail.com with ESMTPSA id g1sm250885itg.10.2018.02.27.12.52.07
        for <git@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 27 Feb 2018 12:52:07 -0800 (PST)
To:     git@vger.kernel.org
From:   Konstantin Ryabitsev <konstantin@linuxfoundation.org>
Subject: Is offloading to GPU a worthwhile feature?
Organization: The Linux Foundation
Message-ID: <efc4af6b-53c9-bd02-65f6-9de517f6868e@linuxfoundation.org>
Date:   Tue, 27 Feb 2018 15:52:12 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.2
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="5OwWWMOeocwxuEwj9ukJr9wctAvXG0hRR"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--5OwWWMOeocwxuEwj9ukJr9wctAvXG0hRR
Content-Type: multipart/mixed; boundary="dJeNRmNMbucX24X1VqFC1ZUHPOjTOyybK";
 protected-headers="v1"
From: Konstantin Ryabitsev <konstantin@linuxfoundation.org>
To: git@vger.kernel.org
Message-ID: <efc4af6b-53c9-bd02-65f6-9de517f6868e@linuxfoundation.org>
Subject: Is offloading to GPU a worthwhile feature?

--dJeNRmNMbucX24X1VqFC1ZUHPOjTOyybK
Content-Type: text/plain; charset=utf-8
Content-Language: en-CA
Content-Transfer-Encoding: quoted-printable

Hi, all:

This is an entirely idle pondering kind of question, but I wanted to
ask. I recently discovered that some edge providers are starting to
offer systems with GPU cards in them -- primarily for clients that need
to provide streaming video content, I guess. As someone who needs to run
a distributed network of edge nodes for a fairly popular git server, I
wondered if git could at all benefit from utilizing a GPU card for
something like delta calculations or compression offload, or if benefits
would be negligible.

I realize this would be silly amounts of work. But, if it's worth it,
perhaps we can benefit from all the GPU computation libs written for
cryptocoin mining and use them for something good. :)

Best,
--=20
Konstantin Ryabitsev


--dJeNRmNMbucX24X1VqFC1ZUHPOjTOyybK--

--5OwWWMOeocwxuEwj9ukJr9wctAvXG0hRR
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYIAB0WIQR2vl2yUnHhSB5njDW2xBzjVmSZbAUCWpXE/AAKCRC2xBzjVmSZ
bCcbAP4yKdoQOPNB+lowUG5DdT9jXJxx5WpfrxRlXdDhzR7DCwEArl5pK8OzfqJ4
UkZY7tWxlfrRZHEeLlnYoVg1rUq5nw0=
=FLXK
-----END PGP SIGNATURE-----

--5OwWWMOeocwxuEwj9ukJr9wctAvXG0hRR--
