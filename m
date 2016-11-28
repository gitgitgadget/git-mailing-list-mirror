Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 03EBA1FBB0
	for <e@80x24.org>; Mon, 28 Nov 2016 21:56:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755864AbcK1V4d (ORCPT <rfc822;e@80x24.org>);
        Mon, 28 Nov 2016 16:56:33 -0500
Received: from mail-qt0-f195.google.com ([209.85.216.195]:34492 "EHLO
        mail-qt0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755553AbcK1V4c (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Nov 2016 16:56:32 -0500
Received: by mail-qt0-f195.google.com with SMTP id l20so13297005qta.1
        for <git@vger.kernel.org>; Mon, 28 Nov 2016 13:56:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=Fst3YEleJc7L9mosgL1L5xqVXyo/DDAsYOOeXhmRJ3g=;
        b=cI09ta0591RDky3W+lv9XqyPRnTMLN6TX5E9j4vr0fyGzdBoT0m8bUfS77ZLMxHnHv
         WQHkwUfyn9WcLl4jYxclliZ3oMvd/bhR55rrOztIRN6mhGvBPikdfar0PimJNLfMtFDI
         9GK6TMQELT0oEKHR8q+pjhzCvmHAYoNLLNGpyHX+I0NSISx+df+ybhnc+QjtesXOwyng
         Ftx+zl508Zi6Iij8scXo9rMw7BQPdBIOik9iocYgVzIvgW3kmN2P5VcGS88e1VoiYfcE
         4+HXmx0+oOBfi+7gPTdDqhQ1L3ZG9ooVY5CDEMTgA2hX6FLVJFuPkASp3GjV9eV7zSI6
         s59g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=Fst3YEleJc7L9mosgL1L5xqVXyo/DDAsYOOeXhmRJ3g=;
        b=FGmI0vlMixZWVDoD6jpgfrtXeXolHAT003Y9rS8TS9ZF+4wYXP1EsN4eiI20j47UNs
         M2L+mT9s76XiJms+LvcJPNj3SZO2+NYNXTC0ctwKMB1jzN+PoMv/tYqVOIVFVwi41Mb2
         mouKOC0jSETbnMHM5UocOz90fqzes8EqAPDCsXfzV6OPR335RJ8H1WVjFKnNqA0eum3A
         9uHO62i6nnL0o33Y9dIRS3onVrOEVgDQOZS3A2/VoS+ukcbtHq+U5R8Vmdtwljsvva0v
         33wg8PrYTpSuEbRUf+OhZZvUJ0YX5rb2nDeeHZdtN04gZkMJ5gXBWu3R1Q11dSJNNOMl
         UyEA==
X-Gm-Message-State: AKaTC001/eEh6Q9WyAXmqAJAFZY4BR4QByqylYxh3MnltqB7a0ocDI1JhcOg3FakKt5X7mXxrDDATzCrQ87H1w==
X-Received: by 10.237.35.140 with SMTP id j12mr21120888qtc.5.1480370191017;
 Mon, 28 Nov 2016 13:56:31 -0800 (PST)
MIME-Version: 1.0
Received: by 10.12.129.65 with HTTP; Mon, 28 Nov 2016 13:56:30 -0800 (PST)
From:   Jiang Xin <worldhello.net@gmail.com>
Date:   Tue, 29 Nov 2016 05:56:30 +0800
Message-ID: <CANYiYbHetS-3zY1kO=EkgCG0R_hR-QyHdetTiJMaqyoyiZCBJg@mail.gmail.com>
Subject: [GIT PULL] l10n updates for 2.11.0 round 3
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git List <git@vger.kernel.org>, Changwoo Ryu <cwryu@debian.org>,
        Dimitriy Ryazantcev <dimitriy.ryazantcev@gmail.com>,
        Jean-Noel Avila <jn.avila@free.fr>,
        Jiang Xin <worldhello.net@gmail.com>,
        Peter Krefting <peter@softwolves.pp.se>,
        Ralf Thielow <ralf.thielow@gmail.com>,
        Tran Ngoc Quan <vnwildman@gmail.com>,
        Vasco Almeida <vascomalmeida@sapo.pt>, jfbu <jfbu@free.fr>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

The following changes since commit e2b2d6a172b76d44cb7b1ddb12ea5bfac9613a44:

  Git 2.11-rc3 (2016-11-23 11:24:59 -0800)

are available in the git repository at:

  git://github.com/git-l10n/git-po tags/l10n-2.11.0-rnd3

for you to fetch changes up to 6366c34b895613482fa32f1abe1c3ca043905ad2:

  l10n: de.po: translate 210 new messages (2016-11-28 18:49:25 +0100)

----------------------------------------------------------------
l10n-2.11.0-rnd3

----------------------------------------------------------------
Jiang Xin (1):
      l10n: fix unmatched single quote in error message

Ralf Thielow (1):
      l10n: de.po: translate 210 new messages

 po/de.po    | 9112 +++++++++++++++++++++++++++++++++--------------------------
 po/fr.po    |    6 +-
 po/git.pot  |  128 +-
 po/ko.po    |    6 +-
 po/pt_PT.po |    6 +-
 po/sv.po    |    6 +-
 po/vi.po    |    6 +-
 po/zh_CN.po |    6 +-
 8 files changed, 5125 insertions(+), 4151 deletions(-)

--
Jiang Xin
