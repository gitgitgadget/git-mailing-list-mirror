Return-Path: <SRS0=PG55=2K=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_2 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9D45C43603
	for <git@archiver.kernel.org>; Fri, 20 Dec 2019 09:43:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 454BB2146E
	for <git@archiver.kernel.org>; Fri, 20 Dec 2019 09:43:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b="nShzScx6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727169AbfLTJnH (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 20 Dec 2019 04:43:07 -0500
Received: from lb2-smtp-cloud8.xs4all.net ([194.109.24.25]:54977 "EHLO
        lb2-smtp-cloud8.xs4all.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726111AbfLTJnH (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 20 Dec 2019 04:43:07 -0500
Received: from pc09.procura.nl ([37.74.132.97])
        by smtp-cloud8.xs4all.net with ESMTPSA
        id iEoKilANVTsDeiEoLiHJjS; Fri, 20 Dec 2019 10:43:05 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xs4all.nl; s=s1;
        t=1576834985; bh=nwzZHhWQ1VKOiuYZHkM4Zjcajt6FbZmsgcQbwBdfa/w=;
        h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:From:
         Subject;
        b=nShzScx6Bqy6ccrwJQSu7tQU3tbI3MRgf5tjJNYhyd7vDW2pnUkjtvqjtQw1WNbfG
         ZgZwSMvL1AzD3giciKfsn18pwxmSoHe74ctrPvpjCoxFQgM98nQPetETzT4Drmbo56
         AgmDo3Rk6DfXUjPkc3bCL411PTK9JFo7uYP/+OFaHj8+Mf+cZYYc3sQq5zm13vQI/y
         Iq6mf2g+Ueq+j766znzDgsNKJ0+Awvto1ejnand7D9Y3RPtUezE4/ovj2pvzeQpf2l
         MLmpDiE0pOpLL9aZXTy9Bb976hVWJ+0MMiV1IKSWaitSK6AkIcyPAx3vCo4kNdczs9
         0/1waAnooxhnA==
Date:   Fri, 20 Dec 2019 10:42:58 +0100
From:   "H.Merijn Brand" <h.m.brand@xs4all.nl>
To:     git@vger.kernel.org
Subject: Low prio: feature requests for git-gui
Message-ID: <20191220104258.1110d00e@pc09.procura.nl>
X-Mailer: Claws Mail 3.17.4git65 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Face:   iVBORw0KGgoAAAANSUhEUgAAADAAAAAwEAIAAACI8LKTAAAACXBIWXMAAABIAAAASABGyWs+AAAC
 JElEQVRo3u2aMY4CMQxFczZ6RItEzRm4DBINDbRUSPRInIRbsNK6+dJfezN4kokn48IaCSjysL8d
 e9Knoj2fr9f9/gllqQ6U9/vxWK3EdwdIEGjRIVCu18NhuxUfK46SH81+fzrdbuKPx/P5ctHQdAdI
 TKAgpvV6s9ntBEfXEYSGgMQzIHnuFBBjkshCNJ2KtJZ04hHNAugP8bZr3NIHhbcF0AKoK0CoaHXU
 LUWBIs1n+jV+Fl8CVqOApEXAwyMO/DSR4XVntoAYDR7eBjQupuYAYTMph8Rj21D4m7MChN02tpqs
 NSnb/KqU2oHCXu5xDCgflj/RAgBiKBIXnICzAsSjWBsTz5K4/HeXYvb8yK5lY3VGEwPi2aONKT+5
 AlcxrTPOwcTiraGRChgMEKJh0bVVifGVTq6qgBiNVl8QE29EsK6VE+YJAOG2wz5AvsqUS6uqgHCA
 n4NGvBYpnJ64Jgg27sCtxtBk1CJIA4S/GhdWKh07QxUB48jWGhZ4jKamRRr/T8/M0AaEyctry6YB
 4dTGj9iWZNs3DahES5kPCJOu0RQbF/fQOBprsB9gaO9JtPDzII9U5ySXX7AnuIt91y54AAW7rPpT
 LCe5gt3F+CLqr2UarGB3MXvMylWGq4+9RCx3TW1oJq1t3HPQlFs6N1fFNEB4s8dn7Ne7ACSm7TPQ
 I5quAWmw6qBpulHM33B0Csge4Nd8JTTYG2b1XyRe3lH8x34ABJ6aePuQ2N4AAAAASUVORK5CYII=
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_//y8A6MzVX5tk/cs169Q6/S4"; protocol="application/pgp-signature"
X-CMAE-Envelope: MS4wfKydJaHqK5Y1v9rlqYFETgGPyo72/eokL+HUt96Gm79A7XIAIdRIlXK+Oy3OckZtqEcRq7MMBV6IGrCrJ0WSjgJ8KaH9FwtW6baittSQHmxAmiYNuqV0
 twjji/K2NGUu8DrXS16vjWeUylkob7oL6A7NYi3LtJGrnKRt/7sjhg5e
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

--Sig_//y8A6MzVX5tk/cs169Q6/S4
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

=E2=80=A2 Right click context menu on file-entry in Unstaged Changes list

  - Reset changes =E2=86=92 git checkout this file
    I see the current changes need to be reversed, are bogus or
    invalid
  - Restore this file =E2=86=92 git checkout this file
    it was accidentally removed. Like the first option
  - Remove this file from disk
    Somehow an invalid restore, a misplaced output or other reason
    (core dump, debug output from other tools) made this file appear
    and I don't want to add it to .gitignore
  - Add to .gitignore
    Like above, but this file will re-appear more often

Does this sound reasonable enough to make it a ticket/issue?

--=20
H.Merijn Brand  http://tux.nl   Perl Monger  http://amsterdam.pm.org/
using perl5.00307 .. 5.31      porting perl5 on HP-UX, AIX, and Linux
https://useplaintext.email  https://tux.nl  http://www.test-smoke.org
http://qa.perl.org   http://www.goldmark.org/jeff/stupid-disclaimers/

--Sig_//y8A6MzVX5tk/cs169Q6/S4
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEGolmczWuFi3lJEbAA6FHoT5dwJgFAl38l6IACgkQA6FHoT5d
wJgYfAf/f/Tyc+3YkntLbnNg6xPGsDgIrta/R1UIORso8XhrUaS1DTg9SyJVQtsc
BY2xMXJ3bRd7/lCFPCapYgcpmfydepr/qHxomSTyksEmbxGRODMvX8ZYgmFLsE4y
RNtHuntnVX+iZAl+S6PlxWFuAPbMf+QLBGBNhT7wyhIeVc2Yb56NGq7olGW20ITK
y9cpM97qtEiBO4HyS7iJQFcswMnAc9Gp5QnYADhGk41SgZ6pO0Xyz7+E4d37mR3T
M4Ch5opWQ5lnO5PQy6c4ZO5841tY2rjncmm/UCuSQzfA5UvaEGV/L5JjFCsxkyv+
6rAfVFQnkQzakIeYPlB8O2fTDkt2iA==
=q8/l
-----END PGP SIGNATURE-----

--Sig_//y8A6MzVX5tk/cs169Q6/S4--
