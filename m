Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 283511F4B6
	for <e@80x24.org>; Sun, 30 Jun 2019 18:35:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726672AbfF3Sfl (ORCPT <rfc822;e@80x24.org>);
        Sun, 30 Jun 2019 14:35:41 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:40642 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726572AbfF3Sfl (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 30 Jun 2019 14:35:41 -0400
Received: by mail-io1-f68.google.com with SMTP id n5so23605116ioc.7
        for <git@vger.kernel.org>; Sun, 30 Jun 2019 11:35:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Kn3oFMLaJnceX9fDm48H6tKnzbb5amLwfakBC06fa48=;
        b=bImI0C+uiEFWXyi8QUgefKWt7tXereXNJndDjxYKX+bodKeSplMbcE6VssW35DrWGv
         K7IuvLxcScjxYi0oGBOjzSvAX5m4WZFUaE2I7WcBluGfqXAIoEtNQJLa7bDK17nSW3JV
         IckOLrgFiK1/G41FT77gKjxoLeohgTPbwXaEEEyMkABePhjktzjwkZITX9KOk6cQeLVo
         G6yQ5KAg1Eh1XGf4jkBW5w2VJVizkWAIHqIdMMyxhzBR1JBi3CHe0KE+TcoaTUEcH5hQ
         /tgW06FJLcphB2uu2qfZMvJAozanYmJLe7MzMfbrsWFYYGqCcGCTZ6yypQZAYatRz2p8
         zFKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Kn3oFMLaJnceX9fDm48H6tKnzbb5amLwfakBC06fa48=;
        b=ARo0kRY7NW2ThNutc+i8iA8F243dGGsSHTZfTrSyP6w0AuGC4b9LZY1KpVvPsX2e81
         iYPV6z+2PvG+BYWXDRLWAt523yRlI14Sjz98wB+69J0GwczCUGBxx9kyaBRUZ6KWJcZG
         TP3+l7MbfvqzPwSvN85EP1VyX6TqikVj+hUuc0Fm7xLgBthhGoBrn7ND4qrqj3w2lj8J
         AeGtKGkHCa+sn3WuGBJdk1yEpExAKy+lus7Vi2jjwTeKeVi2Zv5M+BZRi01nejbu5U9N
         2fqZn16Fm2QOLarmzF8stks3FdsnVJLraQ/kMRLGe86mTsWUMJJpVJDQrK6+DZebubHe
         u1Lg==
X-Gm-Message-State: APjAAAURxQDXcF/Zq8JNIHF9yubkEmDRd85GHSA9YlBeuJB8JkAuSlSW
        WDHzrOPBVw6KUjb32O2RVBJ/TIO3HAeAou6ZFpU=
X-Google-Smtp-Source: APXvYqzb+azlJdsykoFFuPRCN3yCJBB5SF5/lAiqjm/IIAKu7tq+PLxAiwa9hL872/4WDp3k4jjMdw+Mh+lDBFXASXQ=
X-Received: by 2002:a5e:cb43:: with SMTP id h3mr20291712iok.252.1561919739908;
 Sun, 30 Jun 2019 11:35:39 -0700 (PDT)
MIME-Version: 1.0
References: <pull.254.git.gitgitgadget@gmail.com> <pull.254.v2.git.gitgitgadget@gmail.com>
 <bdaee3ea9df0533c268d6bebbd252c00cfbaccd6.1560957119.git.gitgitgadget@gmail.com>
 <xmqq8stl8k09.fsf@gitster-ct.c.googlers.com> <e684ad41-ca93-bad5-cf39-9dcf578a04ae@gmail.com>
In-Reply-To: <e684ad41-ca93-bad5-cf39-9dcf578a04ae@gmail.com>
From:   Carlo Arenas <carenas@gmail.com>
Date:   Sun, 30 Jun 2019 11:35:29 -0700
Message-ID: <CAPUEspg8neAfmKUV3U2DWPnDHOawcbGMNNm_n1MCD7KtLNymLQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] repo-settings: create core.featureAdoptionRate setting
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Johannes.Schindelin@gmx.de, peff@peff.net,
        Derrick Stolee <dstolee@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jun 28, 2019 at 6:44 PM Derrick Stolee <stolee@gmail.com> wrote:
>
> On 6/28/2019 5:42 PM, Junio C Hamano wrote:
> > "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:
> >
> > Use of "signed char" would be OK, but this is a singleton instance
> > per repository, so I am not sure how much it matters to save a few
> > words here by not using the most natural "int" type.
>
> I'll use 'int' in v2.

FWIW, this broke the build in (at least) Linux AArch64, unless the followin=
g
is applied on top of ds/early-access

Carlo
-- >8 --
Subject: [PATCH] repo-settings: explicitly make flags using char as signed

used as a three state boolean and therefore could also be set/compared
with -1, which will break in architectures that use unsigned char by
default (ex: ARM)

Signed-off-by: Carlo Marcelo Arenas Bel=C3=B3n <carenas@gmail.com>
---
 repo-settings.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/repo-settings.h b/repo-settings.h
index b50228f992..544873fff4 100644
--- a/repo-settings.h
+++ b/repo-settings.h
@@ -2,9 +2,9 @@
 #define REPO_SETTINGS_H

 struct repo_settings {
-       char core_commit_graph;
-       char gc_write_commit_graph;
-       char pack_use_sparse;
+       signed char core_commit_graph;
+       signed char gc_write_commit_graph;
+       signed char pack_use_sparse;
        int index_version;
 };

--=20
2.22.0
