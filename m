Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 91DAF20248
	for <e@80x24.org>; Sun, 10 Mar 2019 15:14:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726561AbfCJPOz (ORCPT <rfc822;e@80x24.org>);
        Sun, 10 Mar 2019 11:14:55 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:34195 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725885AbfCJPOz (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 10 Mar 2019 11:14:55 -0400
Received: by mail-lj1-f193.google.com with SMTP id l5so1871447lje.1
        for <git@vger.kernel.org>; Sun, 10 Mar 2019 08:14:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=FNuCJ2NiFtwrP8NR31eoNulss0vBlDyaaF99zSiiq8g=;
        b=CqCH/vD8sp/57tyR91PdUS9V8UnE1ca2+2LWU4Q/WskWsa6smvzU1vap2odr2S6e2o
         kd0124we/zeVyOXwpOmHogsdElLa0i9mS+MPVEZ8jXs/YH/BqB/M2FRI0z5g2QY0ypQh
         cqfsVAig/4ZzMsayENuXZ57dYZIErdOJWBA22Qtw3V26vJl7iEx75U7n5uUdW1eOWbv3
         ZUbNfVsqvARp9oQ6YzKjdNuRJmpum8KHaLqrjn3Nu521vlIGKnW7MlJ7X1yxtwuUv7MX
         8gKH538K6PsQKPCnDGCrySf6FUZ1yq5bspxHxRuk8pJZvu5KAvZouky/lEeKlA/Znb+U
         WNlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=FNuCJ2NiFtwrP8NR31eoNulss0vBlDyaaF99zSiiq8g=;
        b=Sb/zanasc/89ctgyCvkqRHR33sWmL3qcdZZYkhh4G05Naapi0YxFJsAPcsJMxSpd1X
         ICaueftP63BpjHP9dOaRYq34neEk5HJUGl/5bw6yZgskkrwEDgj1KEiKuQyYt+3S8G4Q
         t/CRYKOxsJ4rUqFyTPOwlqZPBo1DCWVYDpr/jp4mwA9r96IF2c9+ebqOSo8X/OU19Dha
         g3d7w3EEWo75bkvMNSCKarn7YaYUfjuVAAm0hTWzeiZsIt7CAC54Bga0ZIn3MNE52Esk
         740ro23HdmgeCW6jc3yjZfJFkQrkAeDHHYZWqLcAVoQ7bBcTkfjFTsZaTPYw8gbZithJ
         pIBA==
X-Gm-Message-State: APjAAAWp/F85u7SztgU884s20KlVPd9Nn8WfbW0yRN5K/wa7qa5s2Ia8
        EMbndo2Ey85v6rSe4VxVpWKHduJq
X-Google-Smtp-Source: APXvYqybrmGTF3H9kDT06mQ6u1kWgv3c4AP2uxbkRz9aVFiyatYM3ttH5GZKvtfFoLvnR8us0I/oZg==
X-Received: by 2002:a2e:80cd:: with SMTP id r13mr14073946ljg.34.1552230892570;
        Sun, 10 Mar 2019 08:14:52 -0700 (PDT)
Received: from localhost.localdomain (31-211-229-121.customers.ownit.se. [31.211.229.121])
        by smtp.gmail.com with ESMTPSA id v20sm568292ljv.83.2019.03.10.08.14.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 10 Mar 2019 08:14:51 -0700 (PDT)
From:   =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH 0/2] fix spurious space after linkgit, now in *.html
Date:   Sun, 10 Mar 2019 16:14:22 +0100
Message-Id: <cover.1552230490.git.martin.agren@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <xmqqmumc3g1h.fsf@gitster-ct.c.googlers.com>
References: <xmqqmumc3g1h.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, 3 Mar 2019 at 02:25, Junio C Hamano <gitster@pobox.com> wrote:
>
> "brian m. carlson" <sandals@crustytoothpaste.net> writes:
>
> > On Wed, Feb 27, 2019 at 07:17:51PM +0100, Martin Ågren wrote:
> >> Just like v1 [1], this v2 removes a spurious space which shows up in a
> >> large number of places in our manpages when Asciidoctor expands the
> >> linkgit:foo[bar] macro. [...]
> >
> > This version looks good to me. Thanks again for getting this cleaned up.
>
> Thanks, all.  Will queue.

Bleh. For some reason [1] I thought the html-files were exempt from this
"extra space after linkgit" problem. They're not, as I just noticed. To
add insult to injury, my original patch 2 which adds a missing
dependency to the xml targets fails to add the exact same dependency for
a few other targets. So of the three patches discussed above, at least
two were incomplete.

Since this has hit "next", here are two patches on top to address this.

Sorry about this.

Martin

[1] I could have sworn I checked the html docs and saw that they didn't
have this extra space. Looking at git-scm.com again reveals that it's
not there. Huh. Seems like the site's html-rendering doesn't go through our
Makefile at all and handles "linkgit:" on its own:
https://github.com/git/git-scm.com/blob/master/script/doc_importer

Martin Ågren (2):
  Documentation/Makefile: add missing dependencies on
    asciidoctor-extensions
  asciidoctor-extensions: fix spurious space after linkgit in *.html

 Documentation/Makefile                  | 6 +++---
 Documentation/asciidoctor-extensions.rb | 2 +-
 2 files changed, 4 insertions(+), 4 deletions(-)

-- 
2.21.0

