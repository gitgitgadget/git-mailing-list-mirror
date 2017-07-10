Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2E7A22035B
	for <e@80x24.org>; Mon, 10 Jul 2017 19:08:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752261AbdGJTIm (ORCPT <rfc822;e@80x24.org>);
        Mon, 10 Jul 2017 15:08:42 -0400
Received: from dmz-mailsec-scanner-4.mit.edu ([18.9.25.15]:64828 "EHLO
        dmz-mailsec-scanner-4.mit.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752072AbdGJTIm (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 10 Jul 2017 15:08:42 -0400
X-Greylist: delayed 301 seconds by postgrey-1.27 at vger.kernel.org; Mon, 10 Jul 2017 15:08:41 EDT
X-AuditID: 1209190f-895ff7000000063b-b2-5963cf8bad4f
Received: from mailhub-auth-2.mit.edu ( [18.7.62.36])
        (using TLS with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        by dmz-mailsec-scanner-4.mit.edu (Symantec Messaging Gateway) with SMTP id E3.62.01595.B8FC3695; Mon, 10 Jul 2017 15:03:39 -0400 (EDT)
Received: from outgoing.mit.edu (OUTGOING-AUTH-1.MIT.EDU [18.9.28.11])
        by mailhub-auth-2.mit.edu (8.13.8/8.9.2) with ESMTP id v6AJ3cwJ007295;
        Mon, 10 Jul 2017 15:03:39 -0400
Received: from darkmatter.mit.edu (DARKMATTER.MIT.EDU [18.248.2.175])
        (authenticated bits=0)
        (User authenticated as smtp/darkmatter.mit.edu@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.13.8/8.12.4) with ESMTP id v6AJ3bdZ029978
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
        Mon, 10 Jul 2017 15:03:38 -0400
Received: by darkmatter.mit.edu (Postfix, from userid 32861)
        id 2CD1534C3A7; Mon, 10 Jul 2017 15:03:37 -0400 (EDT)
From:   =?UTF-8?q?Alejandro=20R=2E=20Sede=C3=B1o?= <asedeno@mit.edu>
To:     git@vger.kernel.org
Cc:     Karthik Nayak <karthik.188@gmail.com>,
        =?UTF-8?q?Alejandro=20R=2E=20Sede=C3=B1o?= <asedeno@mit.edu>
Subject: [PATCH] ref-filter.c: drop return from void function
Date:   Mon, 10 Jul 2017 15:03:03 -0400
Message-Id: <1499713383-15752-1-git-send-email-asedeno@mit.edu>
X-Mailer: git-send-email 2.1.4
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrMIsWRmVeSWpSXmKPExsUixG6nott9PjnSYMsSa4srizYwWXRd6Way
        mL1lA5sDs8fOWXfZPT5vkgtgiuKySUnNySxLLdK3S+DKOPLzPWPBC9aKi/dnMDYwvmLpYuTk
        kBAwkZj8YSVbFyMXh5DAYiaJntk9UM5GRomOXX2MEM4lJokV67cyg7QICZRI3L3dBpTg4GAT
        cJI4eEkJJCwiIC7x9vhMdhCbWaBA4sH7/WC2sICtxNW/B8FaWQRUJY7dPMkK0sorYC9x/5g0
        xBFyEueP/wQr4RUQlDg58wkLSAmzgLrE+nlCEBPlJZq3zmaewMg/C0nVLISqWUiqFjAyr2KU
        Tcmt0s1NzMwpTk3WLU5OzMtLLdI10cvNLNFLTSndxAgKSU5J/h2Mcxq8DzEKcDAq8fAK9CZH
        CrEmlhVX5h5ilORgUhLl/bofKMSXlJ9SmZFYnBFfVJqTWnyIUYKDWUmEt2wnUI43JbGyKrUo
        HyYlzcGiJM4rrtEYISSQnliSmp2aWpBaBJOV4eBQkuDNOwfUKFiUmp5akZaZU4KQZuLgBBnO
        AzT8Edjw4oLE3OLMdIj8KUZjjqYPW74wcbya8P8bkxBLXn5eqpQ4b9RZoFIBkNKM0jy4aeC0
        8oNp/StGcaDnhHkvgCzlAaYkuHmvgFYxAa1iq0sAWVWSiJCSamBUnfNuBrNKtXL0Jsa49++y
        RauUg4LOR76tmfua8//+md5fMp+vrxM6Ne/R2amXznLmrr/lwNSyS/q+z785Pc7PXWK+zzd4
        eYT1zu3s3Kt1XlO5ll7OMJl8Y+Jsz6af96vacmaUR6ytuvJ74TxX76l35r9cfVBz4Z9fGY/1
        VbN/OkvLvTrIy2EgqsRSnJFoqMVcVJwIAA1hlTQGAwAA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Sun's C compiler errors out on this pattern:

void foo() { ... }
void bar() { return foo(); }

Signed-off-by: Alejandro R. Sedeño <asedeno@mit.edu>
---
 ref-filter.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/ref-filter.c b/ref-filter.c
index 2cc7b01..467c027 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -221,7 +221,7 @@ static void objectname_atom_parser(struct used_atom *atom, const char *arg)
 
 static void refname_atom_parser(struct used_atom *atom, const char *arg)
 {
-	return refname_atom_parser_internal(&atom->u.refname, arg, atom->name);
+	refname_atom_parser_internal(&atom->u.refname, arg, atom->name);
 }
 
 static align_type parse_align_position(const char *s)
-- 
2.1.4

