Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 390BA1F454
	for <e@80x24.org>; Mon, 15 Oct 2018 12:09:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726571AbeJOTyD (ORCPT <rfc822;e@80x24.org>);
        Mon, 15 Oct 2018 15:54:03 -0400
Received: from forward100p.mail.yandex.net ([77.88.28.100]:50679 "EHLO
        forward100p.mail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726498AbeJOTyD (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 15 Oct 2018 15:54:03 -0400
X-Greylist: delayed 471 seconds by postgrey-1.27 at vger.kernel.org; Mon, 15 Oct 2018 15:54:00 EDT
Received: from mxback11j.mail.yandex.net (mxback11j.mail.yandex.net [IPv6:2a02:6b8:0:1619::84])
        by forward100p.mail.yandex.net (Yandex) with ESMTP id F1AF35101C9C
        for <git@vger.kernel.org>; Mon, 15 Oct 2018 15:01:09 +0300 (MSK)
Received: from localhost (localhost [::1])
        by mxback11j.mail.yandex.net (nwsmtp/Yandex) with ESMTP id 269O45DNsL-19BiIp4U;
        Mon, 15 Oct 2018 15:01:09 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail; t=1539604869;
        bh=KFmXU4gHTKBDgcgauQ1irPTgVtvhrVLm4XLVUXv6K9k=;
        h=From:To:Subject:Date:Message-Id;
        b=UHTR544yW6peVK4Pr+vT3S86hY83N6c/u+G57Cj9bL8R5WxikFUYJQ//xU4rxKb4t
         Nasyagdl3mwaE0NNDXHXBrZvoZO0EVih6wIHpvXD9XgSRnOHSze2pA6DHCcLoeBwFJ
         OIxgHhTtJwIHIGR2nnYT3cQj20Dc/xHc2nXfIWEo=
Authentication-Results: mxback11j.mail.yandex.net; dkim=pass header.i=@yandex.ru
Received: by myt5-c56023d17c6b.qloud-c.yandex.net with HTTP;
        Mon, 15 Oct 2018 15:01:09 +0300
From:   KES <kes-kes@yandex.ru>
Envelope-From: kes-kes@yandex.com
To:     git <git@vger.kernel.org>
Subject: stat displayed differently
MIME-Version: 1.0
X-Mailer: Yamail [ http://yandex.ru ] 5.0
Date:   Mon, 15 Oct 2018 15:01:09 +0300
Message-Id: <9607701539604869@myt5-c56023d17c6b.qloud-c.yandex.net>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi.

At next log:

$ git prb
POST git-upload-pack (948 bytes)
remote: Counting objects: 20, done.
remote: Compressing objects: 100% (19/19), done.
remote: Total 20 (delta 14), reused 0 (delta 0)
Unpacking objects: 100% (20/20), done.
From https://tracker.feel-safe.net/gitdev/main
   9eafff67..cf2226de  296_tos                    -> origin/296_tos
 = [up to date]        297-unification-of-buttons -> origin/297-unification-of-buttons
 = [up to date]        ToS-component              -> origin/ToS-component
 = [up to date]        authorization_pg           -> origin/authorization_pg
 = [up to date]        buy_dev                    -> origin/buy_dev
 = [up to date]        content_negotiation_fixes  -> origin/content_negotiation_fixes
 = [up to date]        dash_v2                    -> origin/dash_v2
 = [up to date]        design_master              -> origin/design_master
 = [up to date]        design_master_2            -> origin/design_master_2
 = [up to date]        fix_order_pg               -> origin/fix_order_pg
 = [up to date]        master                     -> origin/master
 = [up to date]        new_design_master          -> origin/new_design_master
 = [up to date]        new_error_pg               -> origin/new_error_pg
 = [up to date]        text-page-style            -> origin/text-page-style
Created autostash: 43c2c613
HEAD is now at 9eafff67 Create validator variable
Changes from 9eafff67776fd53ff61bb58bdd4f5cdd166ef476 to cf2226deb3b130348504ae393bede9e371fcb5d1:
 design/dash/decomp/templates/modals/modal_success.html |   2 +-
 lib/Mojolicious/Plugin/Control/Modal.pm                | 118 ++++++++++++++++++-------------------
 public/main/css/modal.css                              |  28 +++++++++
 templates/main/index.html.ep                           |   4 ++
 4 files changed, 92 insertions(+), 60 deletions(-)
 create mode 100644 public/main/css/modal.css
Note: checking out 'cf2226deb3b130348504ae393bede9e371fcb5d1'.

You are in 'detached HEAD' state. You can look around, make experimental
changes and commit them, and you can discard any commits you make in this
state without impacting any branches by performing another checkout.

If you want to create a new branch to retain commits you create, you may
do so (now or later) by using -b with the checkout command again. Example:

  git checkout -b <new-branch-name>

HEAD is now at cf2226de Fix modal window for reset password
Rebasing (1/1)
 .../decomp/templates/modals/modal_success.html     |   2 +-
 lib/Mojolicious/Plugin/Control/Modal.pm            | 118 ++++++++++-----------
 public/main/css/modal.css                          |  28 +++++
 templates/main/index.html.ep                       |   4 +
 4 files changed, 92 insertions(+), 60 deletions(-)
Successfully rebased and updated refs/heads/296_tos.
Applied autostash.


We have two output of stat. But it is displayed differently


How to force stat output be consistent between outputs?

 lib/Mojolicious/Plugin/Control/Modal.pm                | 118 ++++++++++++++++++-------------------
VS 
 lib/Mojolicious/Plugin/Control/Modal.pm            | 118 ++++++++++-----------

