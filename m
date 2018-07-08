Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 81D191F62D
	for <e@80x24.org>; Sun,  8 Jul 2018 22:17:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933135AbeGHWR3 (ORCPT <rfc822;e@80x24.org>);
        Sun, 8 Jul 2018 18:17:29 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:54232 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S933087AbeGHWR0 (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 8 Jul 2018 18:17:26 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:5996:38d5:9b31:ef84])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 1D14360748;
        Sun,  8 Jul 2018 22:17:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1531088245;
        bh=SlQPmd2kea7pNxBthdOwFAC85D8HBWFMuD/+F6GUoiM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=jorSPV6gCmeIESnDls5+OaiTNfmQ1mx6QG6GBTfy7t13yOWgKVjRh4YBsv0XQsZp8
         TrjCzp8OZs9HQDwktZvw3O0CgNcyRVE0vCYeWH+s+YWTA4RKkYC0JmBNlqTdhkQhQ9
         UYZW6tJanxc3+m0Lrn9K1oHTvEZy+yb8GcGJ2Gvwn8iQYGJhxxWo0qw67iZT5N7kxv
         ieThFm7H6KOWGdtiYqPRiwfTmaQMLJ8S1P7y5MXMF58ejsdPaDpv/XZ98ujE3x26sG
         ITdxvYqNgo07MkfEjhkup8+kjrucXOboB62NUaVO5nDpkgyREAeywgji8gYfl2ou1l
         KgsHfMn/pYn9dqQxJTmkrkaEspmynLZ5ydomsrhbUxvw2w5+lrg9FDCASSwTN05/yD
         7K0hbrO+UWNl4SI+XAHfUS6lSC2wL/fNP8ClEkrA2gBbtcG6wOUrvvYi26iMSTHVLX
         CK28DymiHTTiAEltrUj9hvtFxE09wzSt4zDhdFBZN+pcX/6v5ZR
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>,
        Junio C Hamano <gitster@pobox.com>,
        Drew DeVault <sir@cmpwn.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v2 4/4] docs: correct RFC specifying email line length
Date:   Sun,  8 Jul 2018 22:17:13 +0000
Message-Id: <20180708221713.518276-5-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.18.0.399.gad0ab374a1
In-Reply-To: <20180708221713.518276-1-sandals@crustytoothpaste.net>
References: <20180706022357.739657-1-sandals@crustytoothpaste.net>
 <20180708221713.518276-1-sandals@crustytoothpaste.net>
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The git send-email documentation specifies RFC 2821 (the SMTP RFC) as
providing line length limits, but the specification that restricts line
length to 998 octets is RFC 2822 (the email message format RFC).  Since
RFC 2822 has been obsoleted by RFC 5322, update the text to refer to RFC
5322 instead of RFC 2821.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 Documentation/git-send-email.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/git-send-email.txt b/Documentation/git-send-email.txt
index 2f32dbf16d..465a4ecbed 100644
--- a/Documentation/git-send-email.txt
+++ b/Documentation/git-send-email.txt
@@ -404,7 +404,7 @@ have been specified, in which case default to 'compose'.
 			998 characters unless a suitable transfer encoding
 			('auto', 'base64', or 'quoted-printable') is used;
 			this is due to SMTP limits as described by
-			http://www.ietf.org/rfc/rfc2821.txt.
+			http://www.ietf.org/rfc/rfc5322.txt.
 --
 +
 Default is the value of `sendemail.validate`; if this is not set,
