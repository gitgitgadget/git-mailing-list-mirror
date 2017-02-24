Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 80D0C201A9
	for <e@80x24.org>; Fri, 24 Feb 2017 20:38:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751315AbdBXUid (ORCPT <rfc822;e@80x24.org>);
        Fri, 24 Feb 2017 15:38:33 -0500
Received: from mail-wm0-f67.google.com ([74.125.82.67]:33325 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751297AbdBXUib (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Feb 2017 15:38:31 -0500
Received: by mail-wm0-f67.google.com with SMTP id v77so4713516wmv.0
        for <git@vger.kernel.org>; Fri, 24 Feb 2017 12:38:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Z59bU7/+TZ5LpK6p9J4oQJkeIQMWf4w+xhfNTQh5TE0=;
        b=PJIlW4CMnam+UYa8FgsJYXHbS43B+oDyELfjh/YhOh+dF+DiykYSy9cvt62mio2vXA
         4JShCHW29D+fs15Wy6CWxgW36U5MkPmc9oXiSLUquFG8Hza6QGH9I/PGZeTt6KEDckEt
         pd0LqbkJenixjfne+WeO+/aaE2RMjrrFn5MeWKcp+MxYcYM4h6DmYYyHXWWUaf3RyXNq
         +qQQeat7aP2S/y48InjInnvGJInwDL+gSW5pwltcsXPvDn1eXTqPVlJRd1fMXO9+6P7i
         G2GxCOhOnVnA5F7lIZY0oTNf3eMlmrgjBE3XJIcV3salRWRdIe1niQO3vU01Gxh1VSAZ
         ic0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Z59bU7/+TZ5LpK6p9J4oQJkeIQMWf4w+xhfNTQh5TE0=;
        b=mD4DYYGi/xvv3y4flOySVe2SOoZTuT5jPX9WGj3/eR5xP1Mxv+fgiFWCQ4wztbSYMJ
         rX1dP2UcNUnhTvSQOuKD5hPpVfZ30uRYiVQ/LLQVbJSXBG8QuHYNWEfGQPGg2CRnmQB9
         CQRPTHp9AOnh3a+riNTizo9AYti1zuM5BXuyepAUugtORLhV1SS/LGp90E2SixQtRmal
         LPU4IJA0SDyzEDPZ2oDc+cUUsl/5fBS1WXvQ7apSBXVmtXmXgM9xdChBAzGI6lXvqxTC
         ZfJRAIo88nNTtYgsUDv88V9TenslsaMVn0bvIDR5+sEt3maWlV8pFyesHeHI/KESU8h+
         ztyQ==
X-Gm-Message-State: AMke39mk+pfrcmIit85VxlqNNONZIXiF+QaFYsjJf2lkRJ0DF5R6uw4Z/WJdXvBpa+EPOg==
X-Received: by 10.28.66.221 with SMTP id k90mr4413152wmi.90.1487968701032;
        Fri, 24 Feb 2017 12:38:21 -0800 (PST)
Received: from arrakeen.fritz.box ([2001:a61:1087:f101:3062:f226:b4ec:5b6c])
        by smtp.gmail.com with ESMTPSA id j184sm3224550wmd.31.2017.02.24.12.38.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 24 Feb 2017 12:38:20 -0800 (PST)
From:   Andreas Heiduk <asheiduk@gmail.com>
To:     gitster@pobox.com
Cc:     Andreas Heiduk <asheiduk@gmail.com>, git@vger.kernel.org
Subject: [PATCH v2 0/2] Documentation: Link git-ls-files to core.quotePath variable.
Date:   Fri, 24 Feb 2017 21:37:54 +0100
Message-Id: <1487968676-6126-1-git-send-email-asheiduk@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <3c801e54-28c7-52d0-6915-ee7aaf1d89c9@gmail.com>
References: <3c801e54-28c7-52d0-6915-ee7aaf1d89c9@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

These two patches replace and extend the precious patches with the
same subject. Suggestions from Philip Oakley and Junio C Hamano are
included.

I tried to find and adjust all places where pathname quoting and "-z"
were described. I omitted these places:

* Here "-z" is for input only. Quoting is unclear to me.

-- git-mktree.txt
-- git-update-index.txt
-- git-checkout-index.txt

* Here pathname quoting is not mentioned:

-- git-check-ignore.txt
-- git-check-attr.txt

And last but not least: 

- git-grep.txt: The paths are always unquoted, `-z` toggles only the
delimiter. Perhaps some CAVEAT should be added.


Andreas Heiduk (2):
  Documentation: Improve description for core.quotePath
  Documentation: Link descriptions of -z to core.quotePath

 Documentation/config.txt              | 24 ++++++++++++++----------
 Documentation/diff-format.txt         |  7 ++++---
 Documentation/diff-generate-patch.txt |  7 +++----
 Documentation/diff-options.txt        |  7 +++----
 Documentation/git-apply.txt           |  7 +++----
 Documentation/git-commit.txt          |  9 ++++++---
 Documentation/git-ls-files.txt        | 10 ++++++----
 Documentation/git-ls-tree.txt         | 10 +++++++---
 Documentation/git-status.txt          |  7 +++----
 9 files changed, 49 insertions(+), 39 deletions(-)

