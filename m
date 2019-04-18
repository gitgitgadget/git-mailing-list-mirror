Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,PI_EMPTY_SUBJ,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9BFC920248
	for <e@80x24.org>; Thu, 18 Apr 2019 20:33:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390024AbfDRUd0 (ORCPT <rfc822;e@80x24.org>);
        Thu, 18 Apr 2019 16:33:26 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:35454 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729198AbfDRUd0 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 Apr 2019 16:33:26 -0400
Received: by mail-lj1-f194.google.com with SMTP id t4so3007178ljc.2
        for <git@vger.kernel.org>; Thu, 18 Apr 2019 13:33:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=HQhg7N9k8ukOdLZPgOibt51xSrErHiKLpMDxddlguXY=;
        b=dVA0ZFVCseNeaoy+04z0AsdJpf7QYsSZ/HhGQD2IZM22ahWQ+da1Xb7YsyccIZPGxX
         KoNHzkk1uiOAOrFKkWnqnwisoL3B+IZNTtuElWGCPMEc+y7uBnGRdLg8mbFm237Ss9l0
         wQ9awfa4kb93lH+4btGORh3DNhrknP7AR2LByK+us7AfjiwluxapNVrK3ARiuJsWxhW1
         jbEdGrmx1Pjo/XRvQeafw9gQAmfx/DRHnEnndahY30p9ht72MC9N9SVRvmU+S8/X7CJt
         V6ixI/dnOAomTrgaSJOU1m/t6lHaNYJFq2bSIN/6JxdcEzMIlRvDj2FTd3NefYd61PVD
         ctrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=HQhg7N9k8ukOdLZPgOibt51xSrErHiKLpMDxddlguXY=;
        b=BN4IBnGH/gziny0CcMWCfZDob4JBe0VCIxyDPVE1zMc49GHGIyHlSGvLFbt5kTsRu5
         z+pBW5w8NwRKrfD5SDmvLrSD9oE/kV04RfHDvOcdziRWDdZgJ1XHkmXiQdJoDngWGhCz
         lmQge3w5aLuM+PSZHCAjaZNzqFGbv2hMq1lOGnBkLeIhx+m/0ErtlDsVtUM86JG/Awv1
         OHeNvsYVaYl1J6zpQeFNtbKkvCNWZgx3/Pv/E7sef575kvEPerVAMmOMOD0fVGQ+tI6n
         i7x4o48gDKmf2bepxudLc0y0+GfZndhIx6FBfHq5+1M13kjDaokJM2xMW1B710sEO3s8
         5Hqg==
X-Gm-Message-State: APjAAAWapslnIPBpbSqn8csXUrNf+p/dSH3vIJIzq+opoFDq70gEXG7U
        L9CkDgmpR8yvdZ804TYhtqZjxo00vI4zSZkKG76RJXGp
X-Google-Smtp-Source: APXvYqylBf9c/IvdVbmVgv00BpY9itwwq/+zkfGC1uOEr5JBb1N4jHaqcrhGPck5fk8LJVsVMmqBVGdoQFJLKUfzWME=
X-Received: by 2002:a2e:8703:: with SMTP id m3mr100202lji.107.1555619603815;
 Thu, 18 Apr 2019 13:33:23 -0700 (PDT)
MIME-Version: 1.0
From:   Phil Hord <phil.hord@gmail.com>
Date:   Thu, 18 Apr 2019 13:33:12 -0700
Message-ID: <CABURp0rCwEvykRV2MGBoohx8dwD6epeWpHq3qvowTHsfD7==HQ@mail.gmail.com>
Subject: 
To:     Git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The current url leads to a 404 error. The corrected url was determined
empirically.

Signed-off-by: Phil Hord <phil.hord@gmail.com>
---
 MaintNotes | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MaintNotes b/MaintNotes
index b7fa21f5cc..168f0b0969 100644
--- a/MaintNotes
+++ b/MaintNotes
@@ -63,7 +63,7 @@ available at:
         http://colabti.org/irclogger/irclogger_log/git-devel

 There is a volunteer-run newsletter to serve our community ("Git Rev
-News" http://git.github.io/rev_news/rev_news.html).
+News" http://git.github.io/rev_news/).

 Git is a member project of software freedom conservancy, a non-profit
 organization (https://sfconservancy.org/).  To reach a committee of
-- 
2.21.0.769.g5ae5d24923
