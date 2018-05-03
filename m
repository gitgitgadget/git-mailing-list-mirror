Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9AB892023F
	for <e@80x24.org>; Thu,  3 May 2018 18:48:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751195AbeECSsp (ORCPT <rfc822;e@80x24.org>);
        Thu, 3 May 2018 14:48:45 -0400
Received: from mail-wm0-f54.google.com ([74.125.82.54]:37332 "EHLO
        mail-wm0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750969AbeECSso (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 May 2018 14:48:44 -0400
Received: by mail-wm0-f54.google.com with SMTP id l1-v6so628717wmb.2
        for <git@vger.kernel.org>; Thu, 03 May 2018 11:48:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=dodTb/Bv3FpU8IBLDToj16bcEUvelbDbm0M5fwz+NY8=;
        b=TfulElGMPI/5CU4AHyw7ajPTlr7918kI1d9+cpM16Tb7jLl+WyxMV3T2av6nNRjE0c
         ++jU38cHURmYOsYw0yYUeqSdwRgvw8eNgsh6BbyJe483CW4Tte0pL4HQfCaJ+1yEAsy7
         9PVaZFzagtF3MoIh2DGRRV4DrZ3FdFNwDuS1kVYJYqNUikoQtZltmaDAW3KXGJZPfB3q
         LJrugtU0m+MJYqk5V05Du/gug9UFDjJ7Nyji9++8rZJ5ERztZF/eNorlFuFDxLxCd5Iw
         tAquB/YQyU8RgwepzIvwyW37ZIQidRb6dtNy+e9AWCD96G743ryywlIoxbNRIwMJIkkU
         n2xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=dodTb/Bv3FpU8IBLDToj16bcEUvelbDbm0M5fwz+NY8=;
        b=lIWBYVWIzk2XahaSV5Uvm36yZ3GHs61F4yURjTIhPQDl0/g0wjXMQZ0/sT+D1D7u71
         95eKG1tTh6U/HbKv0Oxhksa1e9bBQgXmOWkyhMy6AxmJTvMfIgtb9HK/eMKbLGK9bwyW
         0d30rk99s+b6gr1SSijm4OoFkjaYY3oFa3T39ER7IkDMk4eeJtJq0mWyhaAcEc/X3fr2
         Qg/dXKcPWedTgK+gQPP02DJTrnaVeCygAarEKBh9X9ceagEoKdbE7J3HXJERKmV5K3Lb
         e7xcgDNTilQX/kd9Jf7p+9huQwcHEM79JyiUMY8NExrGDPvwlEoa3cxjtqYI0igwlUsK
         qtYQ==
X-Gm-Message-State: ALQs6tC9fAUwkc+M8rM8pZmGLt70XC/4fwKI+tY4lBMCNFU4574YJPxj
        HI99y7woVFllC/DL/zw0v1GpUA==
X-Google-Smtp-Source: AB8JxZpZA8pqoESO6lHefCWjQfVR2yUt1Sx8lIEE2B42PwPl2UdOzBiQEY2phbEI8643rb0F4CvoEw==
X-Received: by 10.28.170.1 with SMTP id t1mr7400767wme.10.1525373323115;
        Thu, 03 May 2018 11:48:43 -0700 (PDT)
Received: from arrakeen.fritz.box ([2001:a62:81d:ab01:a521:6b31:5c87:9e4b])
        by smtp.gmail.com with ESMTPSA id f83-v6sm198322wmh.32.2018.05.03.11.48.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 03 May 2018 11:48:42 -0700 (PDT)
From:   Andreas Heiduk <asheiduk@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Andreas Heiduk <asheiduk@gmail.com>,
        Junio C Hamano <gitster@pobox.com>, Eric Wong <e@80x24.org>,
        =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>
Subject: [PATCH v3 0/7] Some doc-fixes
Date:   Thu,  3 May 2018 20:48:23 +0200
Message-Id: <20180503184830.11889-1-asheiduk@gmail.com>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180427170440.30418-1-asheiduk@gmail.com>
References: <20180427170440.30418-1-asheiduk@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Changes since the last reroll:

- Better commit comment for "doc: align 'diff --no-index' in text and synopsis"
  This includes Martin's `s/with/and/` comment.
- Eric's typo fix in "doc: add note about shell quoting to revision.txt"
- Added new patch for git-diff.txt with s/--options/options/.
  This addresses Eric's and Martin's comments.
  

Andreas Heiduk (7):
  doc: improve formatting in githooks.txt
  doc: align 'diff --no-index' in text and synopsis
  doc: clarify ignore rules for git ls-files
  doc: add '-d' and '-o' for 'git push'
  git-svn: remove ''--add-author-from' for 'commit-diff'
  doc: add note about shell quoting to revision.txt
  doc: normalize [--options] to [options] in git-diff

 Documentation/git-diff.txt     |  16 +++---
 Documentation/git-ls-files.txt |   3 +-
 Documentation/git-push.txt     |   3 +-
 Documentation/git-svn.txt      |   2 +-
 Documentation/githooks.txt     | 115 +++++++++++++++++++++--------------------
 Documentation/revisions.txt    |   6 +++
 6 files changed, 77 insertions(+), 68 deletions(-)

-- 
2.16.2

