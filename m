Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIMWL_WL_MED shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E34F51F424
	for <e@80x24.org>; Sun, 22 Apr 2018 20:59:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753692AbeDVU7D (ORCPT <rfc822;e@80x24.org>);
        Sun, 22 Apr 2018 16:59:03 -0400
Received: from mail-pg0-f42.google.com ([74.125.83.42]:34134 "EHLO
        mail-pg0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753569AbeDVU7C (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 22 Apr 2018 16:59:02 -0400
Received: by mail-pg0-f42.google.com with SMTP id p10so6931126pgn.1
        for <git@vger.kernel.org>; Sun, 22 Apr 2018 13:59:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=YHtVd8Q6PVXkP9dISDgbTfXT/ruL1DmOplHx/27lJas=;
        b=ungBbbm3SKBQRC3zcmFuLa/7kJsWAQtEC7eIvjnb1GXhrVVrJ8HhbmIsgCMYx9y8We
         wcgXulxXRvV+TB0FrjXkqjULZIr5/smqnWE/qZdeXX3oI0dlTS57W76EmT8HXL2INE8q
         zoTxwb/JcvTmH6vHDh6x6BIdxuthlsWjzc6nK00+nthxJm/s8X8GOXgRViu8rljVfMWp
         fh5wLGvjzEfLKMSpzILtjO4IVdoC4N8VTmbJ26xmR210/S7OxnHdiqVgKnvOKFz5MDka
         XycK6qtZOJmc3TXsxhleUNgjkH5MD6RyVrH5F8qbcoLYboiJ2gYKq2rjeMyQyw16S4MZ
         zRhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=YHtVd8Q6PVXkP9dISDgbTfXT/ruL1DmOplHx/27lJas=;
        b=SkHD3dV/NVtU9uXBlnonRhT19scyFPxoC0WbLtScuQF2wEtmc3U432tob8M798k/Sp
         CyHx5NzfGjBfNwuWhWpqLyACmUK6CEIO3mxNjfME8syZg9Ae5jmOkuxvHxwvBc6+yIZx
         evKzj35m/Nttx+eiHhT6XM34Jwx/jpjhVumChgMdZOCHevfQcPPOXlBiG8hqoafCyLMy
         0zfwgSMzc2zBar4MCe7w2Ew1ME6EY22HcLsJjPVsj46l8fgo6QA195KBkPf8j++wHM8S
         bKbmLgNxTKlHcWC0gOFFdefwtC3fP+QYwLN+3XpKxbhDkOl8WOZBAmXrpwN1WMgGV5SK
         8Rxw==
X-Gm-Message-State: ALQs6tCYRvf1AbT3gSv4y++3kOFx5nd/BDwb6Z63Q4kJZxp6LLEgTWD7
        hu4w95wWenQSHzACGQ9EuJeijaZz6tg=
X-Google-Smtp-Source: AIpwx4+F2LaRIhcIDK9Cdf+BDyzhH8R1245sMRdyNicIjX4jwyZeEO8VyLC4oRPdvlq+2ywjtFLbKQ==
X-Received: by 10.101.83.8 with SMTP id m8mr14844662pgq.28.1524430741492;
        Sun, 22 Apr 2018 13:59:01 -0700 (PDT)
Received: from localhost ([2601:602:9500:1120:e8b3:eaad:c134:baec])
        by smtp.gmail.com with ESMTPSA id u28sm20819408pfl.15.2018.04.22.13.58.59
        for <git@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 22 Apr 2018 13:59:00 -0700 (PDT)
Date:   Sun, 22 Apr 2018 13:58:59 -0700
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Subject: Some mutt(1) patches and scripts
Message-ID: <20180422205859.GA16261@syl.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

I have spent more time contributing to the Git list lately, and as such
have grown a number of patches and scripts that have been useful for my
workflow. I am interested in sharing them here in the hopes that they
will be useful for others as well :-).

My workflow is as follows:

  1. Write some commits.

  2. Prepare them with 'git mail' (a wrapper over 'git-format-patch(1)').

  3. Edit the cover letter template, and look them over in Mutt before
     sending them to the list.

I suspect that (2) and (3) are somewhat unconventional. My 'git mail'
script, in particular, has been useful to me. The contents looks
(basically) as follows [1]:

  mbox=$(mktemp)
  git format-patch --stdout $@ >"$mbox" && mutt -f "$mbox"

This has been useful in not having to move around many *.patch files in
an out of a directory. I enjoy looking at a series as a thread in
mutt(1) rather than as individual files in $EDITOR.

Mutt is not particularly keen to resend email so I have had to teach it
a few tricks:

  1. Macros "b" and "B" to resend and force-resend the highlighted
     message. [2]

    macro index,pager b ":set edit_headers=yes<enter><resend-message>:set edit_headers=no<enter>"
    macro index,pager B ":set editor=true<enter><resend-message><send-message>:set editor=$EDITOR<enter>"

  2. A patch to not destroy the original Message-ID header when
     resending email. Mutt (sensibly) does this by default, but it is
     not suitable for my workflow, as when I edit the cover letter
     template the Message-ID changes and subsequent patches are sent in
     response to a non-existent message.

     I have patched Mutt to remove this behavior, and (since I work on
     macOS) set up a Homebrew tap to install mutt with
     `--with-retain-messageid'. [3]

Thanks,
Taylor

[1]: https://github.com/ttaylorr/dotfiles/blob/work-gh/bin/git-mail
[2]: https://github.com/ttaylorr/dotfiles/blob/work-gh/mutt/.muttrc#L43-L44
[3]: https://github.com/ttaylorr/homebrew-mutt
