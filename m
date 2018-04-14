Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2C6EE1F404
	for <e@80x24.org>; Sat, 14 Apr 2018 20:02:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751617AbeDNUC4 (ORCPT <rfc822;e@80x24.org>);
        Sat, 14 Apr 2018 16:02:56 -0400
Received: from mail-wr0-f175.google.com ([209.85.128.175]:34698 "EHLO
        mail-wr0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751347AbeDNUCz (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 14 Apr 2018 16:02:55 -0400
Received: by mail-wr0-f175.google.com with SMTP id d19so15986586wre.1
        for <git@vger.kernel.org>; Sat, 14 Apr 2018 13:02:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:message-id:mail-followup-to:mime-version
         :content-disposition:user-agent;
        bh=gR8UEMdKIgTu4S7mFgeDTt7ryvqNTSuOEpgwdOelk1c=;
        b=U3tgXD9CEeQOVQ84IETnxOIu+nqySwMXboJxbFycIas5geoj+qCB/GgWTd3bSiHLBe
         j9KQKMFVSAhLW2VMPMZ/VL1opPs37Acx6/luFGdAR3KwLvvUCpBOHiiALBD9EjaL97Us
         wZX7Fs1deLM2NRPMUPGCs4zlYBMvU/vr3TsCH5B9vVO/SBDkyZDW5Mkz+CJrpAXM6gvP
         j2EbFL8oWEG4ivcfFclckn92ZUnhVi0v12yho8p/t40N0JTwZp93XMNOUV30k2faxiIM
         iLlpDGdyfOScoAoX5Fwio03OO7aqndzU1PxtkGw2d/PiUyJd4lNH6OC9rkygvtC2myUC
         LiYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:mail-followup-to
         :mime-version:content-disposition:user-agent;
        bh=gR8UEMdKIgTu4S7mFgeDTt7ryvqNTSuOEpgwdOelk1c=;
        b=NFriMpGE1NPBDBYXPT8kCL9NsXg9+MZjO1m2e3njqnD9EGTC/qRokCOpOYIhqNdMdt
         GTrRW2pbYvtt3T0VKVHvcylX6xQzdvbxq7RYBRwz2Up73D/INBADsIVmso5Bl4pJQUMd
         IsRr+dRk1flDsAlT+EOAjkXyrP0nL2/IErXtRODU0BfgRh5U/ckzYhKTiUVwnPHACfn5
         oNHfbUBgRvJ9akekOi5k8g//t3obwUhTDy4ijhYcMAwryWHHBiNpV/SgepxV/v3PKyyt
         OmOwUkXejfgwYUijmlmC83VLXwSkLh0G+tfhsxZVcPkcLV8Qjsfm6mJtUt48wLsh+QnQ
         MXRA==
X-Gm-Message-State: ALQs6tAyKLlVmuB4ul9znz00QRVOvbfJdmPyrXyGIKwA6inxVLgbDeQj
        QfwQ3DIRLRJs1CSTkKDta4QmNkJF
X-Google-Smtp-Source: AIpwx4/vltWzXZjBIiQr78335OEPKrBrZEOYnVNFUDRCtubVo0+YXKd5FgHHS+e/m3OO5YCFhr1eng==
X-Received: by 10.28.106.5 with SMTP id f5mr6635181wmc.84.1523736174548;
        Sat, 14 Apr 2018 13:02:54 -0700 (PDT)
Received: from localhost (bzq-109-64-19-173.red.bezeqint.net. [109.64.19.173])
        by smtp.gmail.com with ESMTPSA id t4sm2496442wrb.29.2018.04.14.13.02.53
        for <git@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 14 Apr 2018 13:02:53 -0700 (PDT)
Date:   Sat, 14 Apr 2018 23:02:27 +0300
From:   Doron Behar <doron.behar@gmail.com>
To:     git@vger.kernel.org
Subject: Feature Request: Add diff.word-diff <mode> and perhaps
 diff.word-diff-regex <regex> configuration options to enable always using
 word-diffs in git diff
Message-ID: <20180414200227.b35bdkir6ygio5is@NUC.doronbehar.com>
Mail-Followup-To: git@vger.kernel.org
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="rbqmxbb6blerimf4"
Content-Disposition: inline
User-Agent: NeoMutt/20180323
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--rbqmxbb6blerimf4
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

I've just came across the wonderful command line option for `git diff`:
`--word-diff`. It could be great to have a configuration option that
will enable this feature by default when running `git diff`.

--rbqmxbb6blerimf4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQHKBAEBCAA0FiEEl8KuRJYyNM8farE0MRjsiMS8FJQFAlrSXk8WHGRvcm9uLmJl
aGFyQGdtYWlsLmNvbQAKCRAxGOyIxLwUlI7NDACbETAO1UZExQdUlbHpQTcgT0UP
aHmt2sgLoMOmBInUZXC9LdY189TY6mRCJztI3M8qe4NtscZPegV6W3x4KPdm08v1
SpWG1VyRGBGlO7ovS/UoZV6db/LrNO23VkLw6GcbNSPWFx3nv7xZGX6F94sB9ygl
5P/LcquD4gqo0BWi4xkQPG38/WJlTMyprDN/GtuuKjpOZsR/cIE9dvonURvzJxJB
bMmDH1pKo2FbySwMIAWY94YtBq86GiWB4ZtGUropipvey6C1LN9t6qNF5ueo6ph5
XV5RpbbEsvJNv/EP6fIn3bJ8YEEEstQ7MIo71Kgr2SMAyFf4Yu/KCxBCxLVFdHzG
EUl7AODOywfFBGu+AWAOsdjgQoERXQSulPlV/IQzXZYZFsl0iyoHeeTha34sprE3
Vj0ydDkOowlweoz9TMjerCWJ/PEGdx/NocNEgodKQPe19xx1F4YgGUINYyfOz5MG
iiLLr97tnoEzsNsNuzMNVlggk6ajQI0NEFca7PQ=
=4IYU
-----END PGP SIGNATURE-----

--rbqmxbb6blerimf4--
