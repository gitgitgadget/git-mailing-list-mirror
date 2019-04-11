Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B6D7620305
	for <e@80x24.org>; Thu, 11 Apr 2019 02:36:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726630AbfDKCgI (ORCPT <rfc822;e@80x24.org>);
        Wed, 10 Apr 2019 22:36:08 -0400
Received: from mail-40130.protonmail.ch ([185.70.40.130]:36982 "EHLO
        mail-40130.protonmail.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725981AbfDKCgI (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 Apr 2019 22:36:08 -0400
Date:   Thu, 11 Apr 2019 02:36:01 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=default; t=1554950166;
        bh=HN9zCZsAM5eObm0BbVlxVfinGJgPrQ+sryG31pjNhEY=;
        h=Date:To:From:Reply-To:Subject:Feedback-ID:From;
        b=ZP4UD5cWOAdY9pnA4X0Ds2AtQ/Ei/UVqx32IO6IMwu+/PHDBjSnsnON/9s2SI5Vjv
         JCuyl3BYkCHPrforsbdz8e8fLMxVWLa6tM+7sdOizIUv0smDl5ppagfrxzXFujzREp
         XdVcD7iBQ7ZXg5bJXmK0sstMgvdsCLgNLRc+5QEg=
To:     "git@vger.kernel.org" <git@vger.kernel.org>
From:   ron <ronazek@protonmail.com>
Reply-To: ron <ronazek@protonmail.com>
Subject: Local Config File: Submodule initialization looks broken with the --recurse-submodules option when cloning a repository
Message-ID: <Otial29UjnjP-PuGN9Mwnd8k4q8Alof6wWOxFqYv_mXpNbumrljWGN44RvNZYIkC-in7KSXzjFjbceYglTW4iACRcven7CyHUUSUcPCWbL4=@protonmail.com>
Feedback-ID: RMis9b9KHKlvsb8KKkeurfBt3UTu5TN-1L1t5jXjkqXfFdr8BIyQs5Ws7O_ywm8jXx2U-EI3XDzu_Y-JlzMpfw==:Ext:ProtonMail
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Initially reported for GFW on version 2.20.1, I have tested with Linux Mint=
 Mate 19.1 Tessa which by default uses git version 2.17.1

It produces a config file with the relevant submodule entries looking like =
this:

----------------
[submodule]
=09active =3D .

[submodule "Submodule/Path"]
=09url =3D https://github.com/organization/submodule.git
----------------

Instead of that, which is produced by manually initializing a submodule any=
time after cloning:

----------------
 [submodule "Submodule/Path"]
=09active =3D true
=09url =3D https://github.com/organization/submodule.git
----------------

Sent with ProtonMail Secure Email.


