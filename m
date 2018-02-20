Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9021D1F404
	for <e@80x24.org>; Tue, 20 Feb 2018 14:48:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752035AbeBTOsO (ORCPT <rfc822;e@80x24.org>);
        Tue, 20 Feb 2018 09:48:14 -0500
Received: from mail-oi0-f50.google.com ([209.85.218.50]:40376 "EHLO
        mail-oi0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751000AbeBTOsN (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Feb 2018 09:48:13 -0500
Received: by mail-oi0-f50.google.com with SMTP id c12so2814890oic.7
        for <git@vger.kernel.org>; Tue, 20 Feb 2018 06:48:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=G5wOvVuC3WocG/oyyHXsI8p3dVDaNvnH2R9Y/u9wyms=;
        b=GGdFA2+UQllayzAIt0sC9dzsFFHrAxnTqRukezMpg6ZKez9OB7GyrNNH6SDGa5TmwI
         FXLP0H1VMJl/Pl0TUt5ZxGig5IGVkVpEEJByaIQXuhgJR/N/Tnnul7+k1Z2ExdHOUWsU
         LZU8aM+GldpB2gO7RIMB1t8vTyk3CljDJY+VrdRTrVskUuE5FxOZFQL8S1PV36VW/4+d
         p7HNPJ6sQsrxo+9f8P6mQWQcnOPGxyQ4C8UnEdKBuEkOp+c2aAFgW8r28XOdh9N5vdk6
         +4Zp8/HXrQHFZ1zKppdm5FuttaHuU6vYGNi+CCryfFso+wkiA0Y8VUup/jHbhGz6Gc96
         Pxag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=G5wOvVuC3WocG/oyyHXsI8p3dVDaNvnH2R9Y/u9wyms=;
        b=Ue3VCTo/qdlM+Y9y1BWHhcnexkjdVibZa8YD3GhsTRVCSbsYU2oF9LLsep/O+74FSp
         7APDdUG+sMMTR7xcVBBvYyjsvC/Q+VLt+kQOJ/Aaby2gIjD657qMfRfLPQgToTmrG0LA
         zdf66LZU4vbCwFA9s8HPP36wUB+7OQNUoy9+lh7lBAsnXq0/quZbqN2lE4PJ4T/NEc7E
         5iTaeNprCx3qUOhNmUGFA5Tgmz4Qn+DaSLnRXse7Uj6G0loBeFo4NKgM8Q/dw5spoNpD
         q9grWYGRpMDZjqjxEE86FXhUSu9aq1uJUdKUcZUOnmjbXqYb370SC605qnRB2XQ9V100
         EhgQ==
X-Gm-Message-State: APf1xPA484Lp2cboVPCaGXw1mfS756JMAQIwDtyWhgddDp0ij/ZE8PRG
        wX0jdPlsqflW+pij3zo0gBFcE31kio4k5akx21n6Wg==
X-Google-Smtp-Source: AH8x227WmF8LhMNl3f/rJ1wbzcTcisiSahBOKDEC7wha6yDq1MqoNb3A6vZOUB28dVynBsMCZts61gayDmp/eG2p6GQ=
X-Received: by 10.202.8.206 with SMTP id 197mr12029770oii.265.1519138092480;
 Tue, 20 Feb 2018 06:48:12 -0800 (PST)
MIME-Version: 1.0
Received: by 10.74.98.4 with HTTP; Tue, 20 Feb 2018 06:48:12 -0800 (PST)
From:   Birger Skogeng Pedersen <birger.sp@gmail.com>
Date:   Tue, 20 Feb 2018 15:48:12 +0100
Message-ID: <CAGr--=KeRQyJMk1vfx1hNWgo85cU8oNcm9WRVV=Um_Hf8341=w@mail.gmail.com>
Subject: git-gui, BUG: minimize/maximize buttons missing when repo is opened
 in gui
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

System: Ubuntu 17.10 Gnome

When opening git-gui from a directory which is a repository, minimize
and maximize buttons are showing and functional in git-gui.

However, if I open git-gui in a non-repo directory, git-gui opens a
dialog where I can "Create New Repository", "Clone Existing
Repository", etc. When a repository is opened from this dialog, the
git-gui window does not have minimize and maximize buttons visible.

Steps to reproduce:
1. Open git-gui in a non-repository directory
2. Click "Open Existing Repository"
3. Click "Browse" and select an existing repository directory
4. The repository is opened with git-gui, but without
minimize/maximize buttons visible
