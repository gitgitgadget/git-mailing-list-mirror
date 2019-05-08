Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4FBDB1F45F
	for <e@80x24.org>; Wed,  8 May 2019 11:31:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728219AbfEHLbB (ORCPT <rfc822;e@80x24.org>);
        Wed, 8 May 2019 07:31:01 -0400
Received: from mail-ed1-f41.google.com ([209.85.208.41]:41506 "EHLO
        mail-ed1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728208AbfEHLbA (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 May 2019 07:31:00 -0400
Received: by mail-ed1-f41.google.com with SMTP id m4so21745068edd.8
        for <git@vger.kernel.org>; Wed, 08 May 2019 04:30:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:mime-version
         :content-transfer-encoding:fcc:content-transfer-encoding:to:cc;
        bh=++0yCHsE/WTprSlxmP/vfxbwY1Nqqky/Kxg4+fK3L+4=;
        b=OeUEvbLhuC53usXKkegGlizcv+XuAgNVcK9pHKWu3hYh64tF0od1IgUeu6suSCQHdp
         PxPzI6BwWvDCosJdS4rbLSp7iqO55DIfITNq+V0yzVFcoHMaMSBjL/Unvp8KIgPvALzp
         3pV21Pa0QtPyH6HsaL/q8Bjr1oCIooiM/h55Ks+Fkz8ktYCvBqbh7hjI//ziKfyKa/1o
         dsWgE5jY7zQqwaHUnbjDG1Kq4fFnfEoOX6l/LxJgzQbBqvQtSlJuCklGwJ8N7ngJcHBs
         seyzXfTk0QFeVMVQYuIV+rfEV1o0mKnNMBzsC5c7oOcNdib7q1q8iyJUpwwr1W9SRrnp
         zYHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:mime-version:content-transfer-encoding:fcc
         :content-transfer-encoding:to:cc;
        bh=++0yCHsE/WTprSlxmP/vfxbwY1Nqqky/Kxg4+fK3L+4=;
        b=VUUxo+tiuOfkPV88XDppUazHkQSq05IveummpVSj4S708FdCZDqigJxXdno0fHN889
         GaGMwOpKjMrCdzecSiNIoB4P/UgKqa9AXCKiGbXkJk74B7coT1WrAQcT/FR/JifWdXVy
         je2rHWsAmsgSWUEHo0mwEDrBjF7xNK3V9Le7bQaO6LdLaNMlyIpC6dcWCXn+OrpAvrf8
         bMb9R9xHI1jnRJEwzuUyYkHaqnNtMhMXCJHUHVmZvISy4ZXKTZubV9GtRqoDjqDe2Ltg
         QgI/AHtJFsFp+zJasRfKkq+WK8cyfFmY4nwGU8UAZdYtRhaBX9BhQY5oswDjxiuOAiuK
         d77Q==
X-Gm-Message-State: APjAAAVJcNXeKx+qC3vy7HlvBF9n4n61IaDTQPR7VFDtyXjuZ9BubJTb
        8yDk+2OI4lkEwQgKMd9F52V938nXBpc=
X-Google-Smtp-Source: APXvYqyIgBK0B+xtQeNf3mMIfU0gF6R2JyZKN9NTk85Cf/YwJVaH8NRZ3+wP93BlfPeeIoeS4v32uQ==
X-Received: by 2002:a50:ce45:: with SMTP id k5mr39118647edj.202.1557315058195;
        Wed, 08 May 2019 04:30:58 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id b21sm732309ejq.54.2019.05.08.04.30.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 08 May 2019 04:30:57 -0700 (PDT)
Date:   Wed, 08 May 2019 04:30:57 -0700 (PDT)
X-Google-Original-Date: Wed, 08 May 2019 11:30:55 GMT
Message-Id: <pull.134.v2.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.134.git.gitgitgadget@gmail.com>
References: <pull.134.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v2 0/2] Enable Data Execution Protection and Address Space Layout Randomization on
 Windows
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

These two techniques make it harder to come up with exploits, by reducing
what is commonly called the "attack surface" in security circles: by making
the addresses less predictable, and by making it harder to inject data that
is then (mis-)interpreted as code, this hardens Git's executables on
Windows.

These patches have been carried in Git for Windows for over 3 years, and
should therefore be considered battle-tested.

Changes since v1:

 * When determining whether we build with optimization, -O0 and -Og are
   explicitly ignored.

İsmail Dönmez (2):
  mingw: do not let ld strip relocations
  mingw: enable DEP and ASLR

 config.mak.uname | 8 ++++++++
 1 file changed, 8 insertions(+)


base-commit: 83232e38648b51abbcbdb56c94632b6906cc85a6
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-134%2Fdscho%2Faslr-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-134/dscho/aslr-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/134

Range-diff vs v1:

 1:  e6acdba586 = 1:  828913e96c mingw: do not let ld strip relocations
 2:  e142c1396e ! 2:  9f1da73829 mingw: enable DEP and ASLR
     @@ -21,13 +21,13 @@
       --- a/config.mak.uname
       +++ b/config.mak.uname
      @@
     - 	ifeq ($(shell expr "$(uname_R)" : '2\.'),2)
     + 	ifneq ($(shell expr "$(uname_R)" : '1\.'),2)
       		# MSys2
       		prefix = /usr/
      +		# Enable DEP
      +		BASIC_LDFLAGS += -Wl,--nxcompat
      +		# Enable ASLR (unless debugging)
     -+		ifneq (,$(findstring -O,$(CFLAGS)))
     ++		ifneq (,$(findstring -O,$(filter-out -O0 -Og,$(CFLAGS))))
      +			BASIC_LDFLAGS += -Wl,--dynamicbase
      +		endif
       		ifeq (MINGW32,$(MSYSTEM))

-- 
gitgitgadget
