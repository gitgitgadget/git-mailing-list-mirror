Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32FF6C433EF
	for <git@archiver.kernel.org>; Fri, 18 Feb 2022 19:07:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236316AbiBRTIK (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 18 Feb 2022 14:08:10 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:37130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232545AbiBRTIJ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Feb 2022 14:08:09 -0500
Received: from mail-qk1-x72f.google.com (mail-qk1-x72f.google.com [IPv6:2607:f8b0:4864:20::72f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D99F521B1
        for <git@vger.kernel.org>; Fri, 18 Feb 2022 11:07:52 -0800 (PST)
Received: by mail-qk1-x72f.google.com with SMTP id b22so8907298qkk.12
        for <git@vger.kernel.org>; Fri, 18 Feb 2022 11:07:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :content-transfer-encoding;
        bh=QBmA7yf6u8TK8NGn0HAqp9UIQdPYbFq5uWWHFs2AVfo=;
        b=FogxdZ52PS9I7FaUU4VvC1RkEe67Mnw6kE9Z/BWopqJd2IFwQax0S2DQZu3KF9SOF6
         Ug2Y35bp4kDIVWX8Ml1MXpTH1nc+BOWWavWglK1awWlUH9XZ5pGcteWeMpFtbx2rK6Pn
         pN9TEyVmewXvqgBGncfx4JGEuu3iX9GvKy3BlOcY7e86+MgTLTnDoub/UrwASSEbNt8E
         Fsf/dISAUQ3QDWFN3V2lykSihUa5WYLOfK8d7HTRf/6ze41v/GSVFOzUM7KD/JoVSQ52
         exCoo6Fi6/yCl4RuM+BN2F4wNWJo+0PaT/6iP9I5gnHntt3nrxG/d151crz7p4xCsqKH
         GpGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:content-transfer-encoding;
        bh=QBmA7yf6u8TK8NGn0HAqp9UIQdPYbFq5uWWHFs2AVfo=;
        b=JobtgwPvMwTT+31mi88zPJDNZH9tt/JD8WCaiJu4zHUKigTHH4XxdFADbtWSKjh58c
         Ge737wl6RKCnUVzOtfZ0Uzppc8pDGvGKnANK2n3bLah+IGJMKCvJSq2ozXX//IvFHJR7
         5x9jGyiQBhD/XjGOSi6kbzICACXqnF8B6n2+jJ4hg2K3qR/Rc9pN/lvcX+HWhkqhB6p5
         j46GZW9wxEIqf6U3rJmAmYDZqpaef+pIN9zR3t6BZQExuZzqToaa+CfNbqdJdmguSE1x
         TacaQwrogDLdoRqsM4mXocbH64ll4E8htBoch49y1xxKu5hJz7Sjqupi1pcu8y+VTCWh
         xfQw==
X-Gm-Message-State: AOAM5336DPz430SLomXkRE1e4+Gzbgj0hMGm0zbUo5M9SQIw0sBJcoqr
        JKx2tj3KNMFYis8pYR5mpC5cMfFJwXGLuA==
X-Google-Smtp-Source: ABdhPJzy68VHVf/flNqjj3zDhHsDYK+DmAlKWQiH8dbfPcexnM7Pc0bFfpVv2KrhQu8hKa2NysCroQ==
X-Received: by 2002:a05:620a:4151:b0:508:7199:562c with SMTP id k17-20020a05620a415100b005087199562cmr5504195qko.525.1645211271789;
        Fri, 18 Feb 2022 11:07:51 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id f20sm26886774qte.14.2022.02.18.11.07.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Feb 2022 11:07:51 -0800 (PST)
Date:   Fri, 18 Feb 2022 14:07:50 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     avarab@gmail.com, christian.couder@gmail.com, gitster@pobox.com,
        peff@peff.net
Subject: [PATCH] CODE_OF_CONDUCT.md: update PLC members list
Message-ID: <f5daef58bc0bededd46bc9686c586ba5ae9a453c.1645211253.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

As part of our code of conduct, we maintain a list of active members on
the Project Leadership Committee, which serves a couple of purposes. The
details are in 3f9ef874a7 (CODE_OF_CONDUCT: mention individual
project-leader emails, 2019-09-26), but the gist is as follows:

  - It makes it clear that people with a CoC complaint may contact
    members individually as opposed to the general PLC list (in case the
    subject of their complaint has to do with one of the committee
    members).

  - It also serves as the de-facto list of people on the PLC, which
    isn't committed anywhere else in the tree.

As of [1], Peff is no longer a member of Git's Project Leadership
Committee. Let's update the list of active members accordingly [2].

This also gives us a convenient opportunity to thank Peff for his many
years of service on the PLC, during which he helped the Git community in
more ways than we can easily list here.

[1]: https://lore.kernel.org/git/YboaAe4LWySOoAe7@coredump.intra.peff.net/
[2]: https://lore.kernel.org/git/CAP8UFD2XxP9r3PJ4GQjxUbV=E1ASDq1NDgB-h+S=v-bZQ7DYwQ@mail.gmail.com/

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 CODE_OF_CONDUCT.md | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/CODE_OF_CONDUCT.md b/CODE_OF_CONDUCT.md
index 65651beada..0215b1fd4c 100644
--- a/CODE_OF_CONDUCT.md
+++ b/CODE_OF_CONDUCT.md
@@ -70,8 +70,8 @@ git@sfconservancy.org, or individually:
 
   - Ævar Arnfjörð Bjarmason <avarab@gmail.com>
   - Christian Couder <christian.couder@gmail.com>
-  - Jeff King <peff@peff.net>
   - Junio C Hamano <gitster@pobox.com>
+  - Taylor Blau <me@ttaylorr.com>
 
 All complaints will be reviewed and investigated promptly and fairly.
 
-- 
2.35.1.73.gccc5557600
