Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 611931F453
	for <e@80x24.org>; Fri,  2 Nov 2018 01:33:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726362AbeKBKiU (ORCPT <rfc822;e@80x24.org>);
        Fri, 2 Nov 2018 06:38:20 -0400
Received: from mail-wm1-f54.google.com ([209.85.128.54]:34689 "EHLO
        mail-wm1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726016AbeKBKiU (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Nov 2018 06:38:20 -0400
Received: by mail-wm1-f54.google.com with SMTP id f1-v6so238082wmg.1
        for <git@vger.kernel.org>; Thu, 01 Nov 2018 18:32:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:mime-version:subject:message-id:date:to;
        bh=piWjpdkfJI+5YTBQIdMmIPh3AaeJe5SpUdD6SugWBxM=;
        b=BGCGVTY0fbjiZrSPDHuVcJ0FpRoeKkrK1yXCdtuRPe30rUg/AnQe/x8QJOH9b5h0Qf
         CIDa1ZTqN+3zm5TlIO2mVUeDjpxj1wrVMIc0Kk2DY2cKUeJ12mj9L2LE9sCsTtZboqrh
         wmkyHHAVuYHa2YgQwwdGSZJW/YNuTI5qglhS3w3uQWf6ebuxmxgMFh/Q9G6jg86FesEq
         FSBCraDFWf1zNOExt88C+/AFczqszktW64Q4ZGwmLoEtbh1S33nIoYqYYfgpVkrCM7Gx
         B34nIbOitfsLyDqzTQXhfmyEUFJSOkvn7KXuTp7nNDtiynX51L6ecEguEu8181pgLYak
         U+mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:mime-version:subject:message-id:date:to;
        bh=piWjpdkfJI+5YTBQIdMmIPh3AaeJe5SpUdD6SugWBxM=;
        b=rsaNyul3H8kWbAmfsc/Q9fceD01LNGlWRgX234/AINzWYZrrII6PV/q1bJ+046/ImL
         zzJH/pf82Go5RYhmJVDolqNWg80ShUl5hZhBuKuYXV93mDJfGEfm161a8+ajFwZl03MT
         agih8pFX6+v8de5SmAfLNNICvsQy0rH6jYVcyhJvgNR7jV1NjkgHuqZZIUO1wHJiEshM
         3pUTkNDEiypXBn0t9SNDDsz4MN297RtIOQJnZfkGR7eLHBU2kpNfG1jQtwQ8xkRBbjQe
         KbBLTmyELwI7yWRFzJnvZRunafI5PmDY5atluEijaLZQNPyuSaOKXF9OWHD8tQI3Gi+5
         XTtQ==
X-Gm-Message-State: AGRZ1gJab3F6Rh0IGYQQYaORz/YaJOCFHs+IqPtC0nQHFCyZpVwV2AKQ
        UZYiK2yONaZTxM2v4UScTr+bDZrbiO4=
X-Google-Smtp-Source: AJdET5eZ48fEOvqnbGXtovcD1hoa04RvYoBVtUhx7o+iiGVc1x31qsdGfjn+DBOyCBq97FZFJVU83Q==
X-Received: by 2002:a1c:f712:: with SMTP id v18-v6mr7015361wmh.48.1541122377515;
        Thu, 01 Nov 2018 18:32:57 -0700 (PDT)
Received: from [172.20.2.23] ([193.240.15.16])
        by smtp.gmail.com with ESMTPSA id l9-v6sm14237773wrf.4.2018.11.01.18.32.56
        for <git@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 01 Nov 2018 18:32:56 -0700 (PDT)
From:   Sirio Balmelli <sirio.bm@gmail.com>
Content-Type: multipart/signed;
 boundary="Apple-Mail=_F66DF5B2-CC66-4C82-926D-EF4135974B46";
 protocol="application/pgp-signature"; micalg=pgp-sha512
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: git appears to ignore GIT_CONFIG environment variable
Message-Id: <3389BCF7-6170-4242-82D3-0FE7FB2EA5F2@gmail.com>
Date:   Fri, 2 Nov 2018 02:32:52 +0100
To:     git@vger.kernel.org
X-Mailer: Apple Mail (2.3273)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--Apple-Mail=_F66DF5B2-CC66-4C82-926D-EF4135974B46
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=utf-8

It appears that git ignores the GIT_CONFIG environment variable, while =
git-config *does* consider it.

I have written a short script that shows this in detail and reproduces, =
it is included below and also posted on github at =
https://github.com/siriobalmelli/toolbench/blob/master/git/git-env-check.s=
h
This behavior is confirmed in 2.17.1, 2.18.0 and 2.19.1

I have tried to google this but don=E2=80=99t see any references to =
GIT_CONFIG outside of the git-config manual.
Is it intended behavior that this environment variable is only valid =
with git-config?

Thank you very much,

Sirio

=E2=80=94

#!/bin/bash
# this script demonstrates that the GIT_CONFIG is used by 'git-config'
# but *not* by 'git' itself.
# 2018 Sirio Balmelli

cleanup()
{
rm -rf ~/.gitconfig git-env-check
}

fail()
{
	echo "$*" >&2
	cleanup
	exit 1
}

# don't break the user's config
if [[ -e ~/.gitconfig ]]; then
	# don't fail, deleting ~/.gitconfig, for obvious reasons
	echo "this script would break your existing ~/.gitconfig - =
please remove it and run again" >&2
	exit 1
fi

unset GIT_CONFIG
git config -l | grep -q alias.he=3Dhelp \
	&& fail "alias 'he' already set, can't use it for this test" \
	|| echo "1. the alias 'he' is unset by default"

echo "2. write a gitconfig in a non-standard location; export to =
GIT_CONFIG:"
mkdir git-env-check
cat <<EOF | tee git-env-check/gitconfig
[alias]
  he =3D help
EOF
export GIT_CONFIG=3D$(realpath git-env-check/gitconfig)
env | grep GIT_CONFIG

git config -l | grep -q alias.he=3Dhelp \
	|| fail "unexpected: git-config doesn't see GIT_CONFIG" \
	&& echo "3. git-config DID see 'he' from GIT_CONFIG"

git he \
	&& fail "git does see GIT_CONFIG: please ignore this report" \
	|| echo "4. git, however, did NOT see 'he'"

ln -s $GIT_CONFIG ~/.gitconfig
git he >/dev/null \
	|| fail "unexpected: git also ignores ~/.gitconfig" \
	&& echo "5. git DOES see 'he' if conf is linked to =
'~/.gitconfig'"

echo "6. this was $(git --version)"
cleanup


--Apple-Mail=_F66DF5B2-CC66-4C82-926D-EF4135974B46
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----
Comment: GPGTools - https://gpgtools.org

iQIzBAEBCgAdFiEEg12XAEksYqKi4XIsxM76bLJSdLMFAlvbqUQACgkQxM76bLJS
dLMqzQ//bcYqeYqpJ4QuHQhTYVGXrEFwqNcqB5yDl4pZETvJUEf+cjSJ4X7nCSvW
S+PCeaPDZp0GyPZNR+10rN0JkOXSnjuMscc+vTOjmUMdnc0wGq1TAmMSHfiu4gAL
YB7tn2BQUatqpAM5S9H4AzlqtH0EextBZcna7Kxl4qaLk8fcLYAV4L8yXTjMH2zS
WTy48dH75BKUj178SsvVGDHK3i9sGEqd9o40b/IPPkeywJ7yb2FOyq9DNWO9nzOL
D6r9sv9uYuoSaSlGIthcoRA78KxbAVt3U0R5rRbY9aYYE6U0oHJII34QovDn0q+5
oFe+yY2fwm36VLcT/fWpTq2qzcIzDBS+hOdyJqLzRfR5+zJM1vdwU2Z0FVv0ksFf
Wu4wOnNxorII58g6014uuvYMHJIVTkjGa/UozALB3gxVIfhbfZeA6tdvfNLVdbpW
0fRedZVyOZlTqmzo+pGPhV7Yoq7Y+knZr7muing8QWkE+DaW+mxPSjM4QTJ+2h9G
nVf0u9nrHd/6k0lv9T0PsxeDvFPIL6KbHzQtot2yJrnrXAAHqRZdPgimecKxDVWb
mcVy/WrqjnQ/aZqJ0yQe95deH3l8qScMZ54O8xdovLTq5Ke7YNvUXsA6tpe72bEB
C4DdAmpEcELre8cAL0UTU5smBTRHqdMURkIEENUrJ7ln7q/7KRw=
=INyU
-----END PGP SIGNATURE-----

--Apple-Mail=_F66DF5B2-CC66-4C82-926D-EF4135974B46--
