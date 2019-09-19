Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B406A1F463
	for <e@80x24.org>; Thu, 19 Sep 2019 14:34:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389474AbfISOe0 (ORCPT <rfc822;e@80x24.org>);
        Thu, 19 Sep 2019 10:34:26 -0400
Received: from mail-qk1-f182.google.com ([209.85.222.182]:42148 "EHLO
        mail-qk1-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388331AbfISOe0 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 Sep 2019 10:34:26 -0400
Received: by mail-qk1-f182.google.com with SMTP id f16so3567838qkl.9
        for <git@vger.kernel.org>; Thu, 19 Sep 2019 07:34:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ftfl.ca; s=google;
        h=from:to:subject:date:message-id:user-agent:mime-version;
        bh=GOmE2qG4Q4SKlrCP1dDDuNRixd8+I+tSJ5Acd+8Ylmo=;
        b=gZe4L6u5ieSCjdlIX5ey5LR/uU3CIZJ/JrPvdsNIGpcM166DI6cyTFuTRkpOYKunKy
         S3BKwMj8TNFDqo5Ii7OXoVTZIAjbH1i/OjLF1AY1gdow5/mws8U3tqKlL28y++wy1+/8
         IYutzZlg9shZklv7wMTzS+hdNclirDzX2rH5c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:user-agent
         :mime-version;
        bh=GOmE2qG4Q4SKlrCP1dDDuNRixd8+I+tSJ5Acd+8Ylmo=;
        b=VBGKE9ZSgMTd7xESkBjldV/oq+DCdBde2QPA4Oy6VVyyshASPAMGKkO+iNRXqB7CDp
         odknB0vgWvqWUkd77Ol3blPiN+IDUSpmuEscIZDCCk5D4DCk5wJdT9HRTSohhjfCOcKt
         kel5kW1Ejj3GJqHMet9KEiVluGLDh3yqUbmDLtqsP4Kkgqe7FHb8zM+IYhLQB3vWP1W9
         pxYoPgvNGy24agYdyZyoK1CEJ0K2VvsLyUmDdrYHvju5GclSFJ5SlQf7S8ld2MV3i2ga
         alBUpvcTmp8H56IpkcUV6ruqil7QIuyB7Lis0avLMx7tfAY5t7i7gtfDoLMQC1vB8gM4
         WIOg==
X-Gm-Message-State: APjAAAW4avTQiMYsBKmMoT2yuSJZdbG4+cWnRXgwaBYtZ0jWayZaaIOS
        Hg48cG0x80K/Y2w8MuZQMuKeL/VKfbY=
X-Google-Smtp-Source: APXvYqyqiSg5jEDTtu0f+inH37SLtNjJ7wzE+BCM6nbZM8ifD0MuDi8jiTsyIObZnyxtBiwyiDVwqw==
X-Received: by 2002:a37:4952:: with SMTP id w79mr3107176qka.59.1568903664216;
        Thu, 19 Sep 2019 07:34:24 -0700 (PDT)
Received: from phe.ftfl.ca.ftfl.ca (drmons0544w-156-57-171-174.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.57.171.174])
        by smtp.gmail.com with ESMTPSA id c20sm3919642qkm.11.2019.09.19.07.34.22
        for <git@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 19 Sep 2019 07:34:23 -0700 (PDT)
From:   Joseph Mingrone <jrm@ftfl.ca>
To:     git@vger.kernel.org
Subject: git-svn authors file in repo (Author: xxx not defined in
 .gitauthors file)
Date:   Thu, 19 Sep 2019 11:34:21 -0300
Message-ID: <86o8zgfj82.fsf@phe.ftfl.ca>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.0.50 (berkeley-unix)
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha512; protocol="application/pgp-signature"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

--=-=-=
Content-Type: text/plain

Hello,

We maintain a .gitauthors file for git-svn.  When a new committer is
added to our project, a new entry is added to the .gitauthors file,
but we sometimes see errors like this:

% git -C /usr/ports svn rebase
        M       .gitauthors
r512146 = 0c1f924ca984d53333beabb909ea53afb856c44b (refs/remotes/origin/trunk)
        M       math/py-pystan/Makefile
r512147 = acc387d4c8f3ebf904010bccc5679be06b184a9d (refs/remotes/origin/trunk)
        M       deskutils/gworkspace-gwmetadata/Makefile
...
...
...
r512184 = 442bd1025776d5e3171be8e497ef2056dc47ff06 (refs/remotes/origin/trunk)
        M       www/rubygem-passenger/Makefile
        M       www/rubygem-passenger/distinfo
        D       www/rubygem-passenger/files/patch-asio-libc++7
W: -empty_dir: head/www/rubygem-passenger/files/patch-asio-libc++7
r512185 = f1a1b447811ae84011288678136e185c83180b8e (refs/remotes/origin/trunk)
        M       astro/xearth/files/freebsd.committers.markers
Author: dmgk not defined in .gitauthors file

The new committer, dmgk, was added to .gitauthors in svn commit r512146,
then later he committed to the repository for the first time in r512185.
It seems that if these two commits are included in the same `git svn
rebase`, the error above will occur.

Is there a solution or workaround for this aside from each committer
having an updated .gitauthors before doing `git svn rebase`.  It's seems
to be a chicken/egg issue; they first need the updated .gitauthors file,
but the way to get the updated .gitauthors files is to do `git svn
rebase`.

Regards,

Joseph

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQKgBAEBCgCKFiEEVbCTpybDiFVxIrrVNqQMg7DW754FAl2Dke1fFIAAAAAALgAo
aXNzdWVyLWZwckBub3RhdGlvbnMub3BlbnBncC5maWZ0aGhvcnNlbWFuLm5ldDU1
QjA5M0E3MjZDMzg4NTU3MTIyQkFENTM2QTQwQzgzQjBENkVGOUUMHGpybUBmdGZs
LmNhAAoJEDakDIOw1u+ehTYP/13/x89CuGT7nEuCm9UjTWH2EJGK0UPwhrGKrWcd
V8Jy2ZlgGo3RIPIZlhbq44dPNI8NwCEmpGy7dXfmhcUs7EipRJKVQ9CRjRaVYGEz
/izn8nZoZP1S/BvlnpP7mW3COINUmjTeCgz0bFgr2iFaAd2RbvDTCi9IpRg+/nmo
wRSjaPO5Ozu0/gudEeBF5rD3+swK0H65LlDMKrOZQSNkEfnkuAt6TBUmZJZ0bu/5
3MtHlSpmom3OmUfaxmRiZyGXsGnF7e+jv5fNo0OwI0ocoP7TZJJpYunXRaFCWX7A
B7iaBPdA0lMdxMDi78vOGnTp1V3N+2BixxG8qi+H0yUGXOD63xaXAXvlPBKjXwD8
kaZyQOGQ1sCG7nA3t65kk+QgapS0NhgEv0Ug2tk/qruL6yYC7KyEbcAqCy8JUEuj
XY/UW1pn1ueuRG3TuRibkp5jRDmY7EExy/Is7NNRYSr8eq1JP2I4wNPloH4aLH8w
C1f/NP1xzb1IntYm2/EsR/UfVzuDv0KMryncv3JADMbMRm+qIbIleKc4GHU3CGSS
44N+MvqQQNE/WV8v5vBlTgf9n1uBSI2FDclTqjxCuh3SMRwX3BhHe6DksAI0JozQ
bLfdK25vfzve3hIEsi7MaEVQxiE8F33+neiIj0VRvV8iMfnopRsl7nEkmy22qh81
4wUW
=WLHm
-----END PGP SIGNATURE-----
--=-=-=--
