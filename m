Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C19D0201A9
	for <e@80x24.org>; Fri, 24 Feb 2017 16:29:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751246AbdBXQ3i (ORCPT <rfc822;e@80x24.org>);
        Fri, 24 Feb 2017 11:29:38 -0500
Received: from mail-qk0-f171.google.com ([209.85.220.171]:36323 "EHLO
        mail-qk0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751163AbdBXQ3h (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Feb 2017 11:29:37 -0500
Received: by mail-qk0-f171.google.com with SMTP id x71so22777072qkb.3
        for <git@vger.kernel.org>; Fri, 24 Feb 2017 08:29:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc
         :content-transfer-encoding;
        bh=O8v5bQhQZ+KIqwnP9pkIZgBUMAkaxlSO4gJl32EGeK0=;
        b=cqHApme4VycEPhUZI0d1VEQG6C7DVZFpk6kRStkhqD7UPbGAW2RzF/J/pwzn9YCiCk
         YX6Mzr6vzq7DG6oS9z10Q3p+RpqeElD8OKmsAPhgWkpxJanj6y6AAjqyyZoWjB9I4heX
         wIlpSqoakQqFuU1Q8Oo+v0KumB9Owd3unrp1YMDuj09lbjQqWa9eYxgOsQHBA4/rLvv0
         w7tvI/5cWsdcsGRWMUgZZYEBJU27EqiW73xFAlR/Wd6GSi7hGFwwfEmH8SwreFORRYxU
         QyUkkCAPvcejmwxuRcFDg2AmK0u5R2R0W1wlGLVelSAqgGLJrF8g9iqNOhJzW3hcoOYZ
         AAXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc
         :content-transfer-encoding;
        bh=O8v5bQhQZ+KIqwnP9pkIZgBUMAkaxlSO4gJl32EGeK0=;
        b=d49YM5pPEvKbTwNMh/hNNcKVGLkpXjrVePrPpN3uBPf4LnxyF7ULboo9zFTBQgoOZm
         5PJuxysUnkHoGjT8oNXIJcs0bTcEufE6o7MohwnePLIcdkwCV6bXqoPiALpmhkZ8463o
         GlePxlR7Ujvpv15xqdFydqZnYrkzsnoN+riigLcXbVU42xomEzxFgalig12KXlDrUfcc
         akvFTI6mnmkQIkfGNWc4RXmkmOT+HTuQYWOpwV1og3hd87UCUxwtiPlT51di23xhoEcQ
         ZGKDoqpfohDlIc2Rtlsp1CSBtFku+7UYz2dxHV9q3OXa2rs4QmZZNFdzA0JKqD5jx4cA
         yxPw==
X-Gm-Message-State: AMke39k3Dz8iIFCqJPY/cv768y3qSpWU2WZNErormvLSK6VGqWSBDRQzp0ezD7SuMwn3hkDGQH5p4On8m+KDHw==
X-Received: by 10.55.65.70 with SMTP id o67mr3427573qka.254.1487953775811;
 Fri, 24 Feb 2017 08:29:35 -0800 (PST)
MIME-Version: 1.0
Received: by 10.12.147.40 with HTTP; Fri, 24 Feb 2017 08:29:34 -0800 (PST)
From:   Jiang Xin <worldhello.net@gmail.com>
Date:   Sat, 25 Feb 2017 00:29:34 +0800
Message-ID: <CANYiYbHPahB6CAUMWTRL19SfG2eYqEq7vqH8SzAPjUSV_qiNiw@mail.gmail.com>
Subject: [GIT PULL] l10n updates for 2.12.0
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Alexander Shopov <ash@kambanaria.org>,
        Jordi Mas <jmas@softcatala.org>,
        Ralf Thielow <ralf.thielow@gmail.com>,
        =?UTF-8?Q?Jean=2DNo=C3=ABl_Avila?= <jn.avila@free.fr>,
        Marco Paolone <marcopaolone@gmail.com>,
        Changwoo Ryu <cwryu@debian.org>,
        Vasco Almeida <vascomalmeida@sapo.pt>,
        Dimitriy Ryazantcev <DJm00n@mail.ru>,
        Peter Krefting <peter@softwolves.pp.se>,
        =?UTF-8?B?VHLhuqduIE5n4buNYyBRdcOibg==?= <vnwildman@gmail.com>,
        Jiang Xin <worldhello.net@gmail.com>,
        Git List <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

Please pull l10n updates for Git 2.12.0:

The following changes since commit 076c05393a047247ea723896289b48d6549ed7d0=
:

  Hopefully the final batch of mini-topics before the final
(2017-02-16 14:46:35 -0800)

are available in the git repository at:

  git://github.com/git-l10n/git-po tags/l10n-2.12.0-rnd2

for you to fetch changes up to 1a79b2f1795a6ec4c70674ce930843aa59bff859:

  l10n: zh_CN: for git v2.12.0 l10n round 2 (2017-02-25 00:19:14 +0800)

----------------------------------------------------------------
l10n-2.12.0-rnd2

----------------------------------------------------------------
Alexander Shopov (1):
      l10n: bg:  Updated Bulgarian translation (2913t+0f+0u)

Anthony Ramine (1):
      l10n: fr.po: Fix a typo in the French translation

Changwoo Ryu (2):
      l10n: ko.po: Update Korean translation
      l10n: ko.po: Update Korean translation

Jean-Noel Avila (2):
      l10n: fr.po: v2.11-rc0 first round
      l10n: fr.po: v2.12.0 round 2 3139t

Jiang Xin (14):
      Merge branch 'master' of https://github.com/Softcatala/git-po
      Merge branch 'master' of https://github.com/Softcatala/git-po
      Merge branch 'master' of git://github.com/git-l10n/git-po
      l10n: git.pot: v2.12.0 round 1 (239 new, 15 removed)
      Merge branch 'fr_v2.11.0_rnd1' of git://github.com/jnavila/git
      Merge branch 'master' of git://github.com/nafmo/git-l10n-sv
      Merge branch 'master' of https://github.com/Softcatala/git-po
      Merge branch 'master' of https://github.com/vnwildman/git
      Merge branch 'master' of git://github.com/git-l10n/git-po
      l10n: git.pot: v2.12.0 round 2 (2 new)
      Merge branch 'master' of https://github.com/vnwildman/git
      Merge branch 'ko/merge-l10n' of https://github.com/changwoo/git-l10n-=
ko
      Merge branch 'master' of git://github.com/nafmo/git-l10n-sv
      l10n: zh_CN: for git v2.12.0 l10n round 2

Joachim Jablon (2):
      l10n: fr.po: Fix typos
      l10n: fr.po: Remove gender specific adjectives

Jordi Mas (4):
      l10n: New Catalan translation maintainer
      l10n: fixes to Catalan translation
      l10n: update Catalan translation
      l10n: Update Catalan translation

Peter Krefting (2):
      l10n: sv.po: Update Swedish translation (3137t0f0u)
      l10n: sv.po: Update Swedish translation (3139t0f0u)

Ralf Thielow (1):
      l10n: de.po: translate 241 messages

Ray Chen (1):
      l10n: zh_CN: review for git v2.11.0 l10n

Tr=E1=BA=A7n Ng=E1=BB=8Dc Qu=C3=A2n (2):
      l10n: vi.po: Updated Vietnamese translation (3137t)
      l10n: vi.po (3139t): Updated 2 new messages for rc1

Vasco Almeida (1):
      l10n: pt_PT: update Portuguese tranlation

 po/TEAMS    |     5 +-
 po/bg.po    | 10422 ++++++++++++++++++++++++++++++++++--------------------=
----
 po/ca.po    |  4894 +++++++++++++++++----------
 po/de.po    |  4331 +++++++++++++++---------
 po/fr.po    |  4293 +++++++++++++++---------
 po/git.pot  |  3997 ++++++++++++++--------
 po/ko.po    |  4221 ++++++++++++++++--------
 po/pt_PT.po |  4562 ++++++++++++++++---------
 po/sv.po    |  4275 +++++++++++++++---------
 po/vi.po    |  4275 +++++++++++++++---------
 po/zh_CN.po |  4258 +++++++++++++++---------
 11 files changed, 31663 insertions(+), 17870 deletions(-)
