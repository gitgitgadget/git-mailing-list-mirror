Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D4E771F403
	for <e@80x24.org>; Wed,  6 Jun 2018 19:32:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752112AbeFFTcj (ORCPT <rfc822;e@80x24.org>);
        Wed, 6 Jun 2018 15:32:39 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:51625 "EHLO
        out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752000AbeFFTci (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 6 Jun 2018 15:32:38 -0400
Received: from compute2.internal (compute2.nyi.internal [10.202.2.42])
        by mailout.nyi.internal (Postfix) with ESMTP id 3006121D02
        for <git@vger.kernel.org>; Wed,  6 Jun 2018 15:32:38 -0400 (EDT)
Received: from web6 ([10.202.2.216])
  by compute2.internal (MEProxy); Wed, 06 Jun 2018 15:32:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
        content-transfer-encoding:content-type:date:from:message-id
        :mime-version:subject:to:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; bh=wLKoyYpT9S8GOyzg89LnyPxHtaCNPDzoqytPM8DOya0=; b=sBPdSwzE
        0zTmh5GSHOajAybmNVJuIIP+wyydlB85mnsOy7Ri18Kn1mvU3vhLDgeqbxb32Jau
        iKZYRlSygE3xrTuYAfGORJGGJ7Yyv6bhxhgSki/v0Z3P8NUPSfDhmUOWeMSFzhpU
        arrub+SnLOU+ADOKwV4jwetBxoMS2AN3LzpAKJWJ3V4bURYwU2R4+4nfN7z2gTUf
        Pgxwjuw4bwU2TIL4btP/ZRZlE+O7E2KGQVZrd5izXY5PXYqSHRzWPvlgoMnyJ0DC
        fAUgs8YE3epsEhfQNEN+0cTK/8hFSeM0E/EpHrw3gTbEUZcBjFItItCvS56y0esV
        huvLBj6kMc2dTA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=content-transfer-encoding:content-type
        :date:from:message-id:mime-version:subject:to:x-me-sender
        :x-me-sender:x-sasl-enc; s=fm2; bh=wLKoyYpT9S8GOyzg89LnyPxHtaCNP
        DzoqytPM8DOya0=; b=KmqRnCfhljGGWdu6jMXVtNQIgW+gnZ+Wf7NXZqbVcPvR0
        gHsLnwCLC4bg8U/rSAiciI9G15C077/P/IMdBM97wyXp2WW0XT5U/leOkqVghJpS
        nQXs0ZNLNKSnbO97wPUZzK/iTb7D6z7iyb66iEz8wWak8SO4DyRbC/GHwkB88g39
        18NTytXkTOdCNE/ae+SHJYNltMulRwmZmPEwmsaw98ozZ9Jee/UT2mMwPyy7zJaq
        EMzSTT6pajrawplpWiLgPwZpymEdt4IvL/tgy790GnBxoODDAVhiBWEPRnDVmCuR
        mR1KE8LpWPgHVx4D3ZVjnBONezFvjANdQbt6AAZMg==
X-ME-Proxy: <xmx:1jYYW3HP2KWQi4SULpa-w5vjANSGrJ4SedNTQZ4jbP08X46HPxrSZA>
X-ME-Proxy: <xmx:1jYYWyt09PiH943WXxQLkf3L0QGFM4XsPXLknDP1gr2WhTcWro3VJg>
X-ME-Proxy: <xmx:1jYYWxMkKFW45uk_oCWVeHRl6zM72ZIfbnEi_kpndehct2iHKhpuUA>
X-ME-Proxy: <xmx:1jYYW6Tu5QXjYtch571WCVgZqP3STJHxXCPr9MfZy1UJls4giU4AlQ>
X-ME-Proxy: <xmx:1jYYWxAJIGoJ1JpxRBzw-DEyj0vUrqsMq0t4DAI7TdhnKlQ5txqXaQ>
X-ME-Proxy: <xmx:1jYYW1m4KTVDwF0oJy5uWAJafVq2spLGqxkPfsAjdWAxaGdcpVrhuQ>
X-ME-Sender: <xms:1jYYW_2J3aqAzqMnB1B3-_EVd_vp8zothLcuad1LMUrWGKAxRVsRHA>
Received: by mailuser.nyi.internal (Postfix, from userid 99)
        id 0863F42A1; Wed,  6 Jun 2018 15:32:38 -0400 (EDT)
Message-Id: <1528313557.2662346.1398855328.3E0F8023@webmail.messagingengine.com>
From:   Thomas Fischer <thomasfischer@fastmail.com>
To:     git@vger.kernel.org
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="utf-8"
X-Mailer: MessagingEngine.com Webmail Interface - ajax-fb4a77ea
Subject: git rm bug
Date:   Wed, 06 Jun 2018 14:32:37 -0500
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

OVERVIEW

"git rm" will remove more files than specified. This is either a bug or undocumented behavior (not in the man pages).

SETUP

1. In a git repository, create an empty directory OR a chain of empty directories

$ mkdir -p path/to/some/

2. Create a file in the deepest directory and add it to tracking

$ touch path/to/some/file
$ git add path/to/some/file
$ git commit -m 'add path/to/some/file'

THE BUG

Run 'git rm' on the tracked file. 

EXPECTED BEHAVIOR

$ git rm path/to/some/file
rm 'path/to/some/file'
$ ls path
to/
$ ls path/to
some/

Note that path/, path/to/, and path/to/some/ still exist.

ACTUAL BEHAVIOR

$ git rm path/to/some/file
rm 'path/to/some/file'
$ ls path
ls: cannot access 'path': No such file or directory

The entire chain of empty directories is removed, despite the fact the git outputs only "rm 'path/to/some/file'".

This ONLY occurs when all the directories in the chain are empty after the tracked file has been removed.

This behavior is NOT documented in the man pages.

I propose that 'rmdir' statements are added to 'git rm' output, or that the man pages be updated to reflect this behavior.

Best,
Thomas Fischer
