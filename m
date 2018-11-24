Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.7 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 91D021F97E
	for <e@80x24.org>; Sat, 24 Nov 2018 09:30:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725880AbeKXUSl (ORCPT <rfc822;e@80x24.org>);
        Sat, 24 Nov 2018 15:18:41 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:41333 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725798AbeKXUSl (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 24 Nov 2018 15:18:41 -0500
Received: by mail-wr1-f67.google.com with SMTP id x10so14300570wrs.8
        for <git@vger.kernel.org>; Sat, 24 Nov 2018 01:30:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=hurrell-net.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2g3NcCbK61hSN1dzjKWikP+Ruofz9dnU6N8QLhgnC10=;
        b=jpvJBAk/y+NXAeo1pcnfh2jxELBjd6fUHzrQaXzwKdAUrjzC2AulHemYb+pm5ldDvG
         6K+PnCRTJHlxDL3MOE+pPtrLPkh+VnAExq06EMvIPBhSQpCy0c3ZHbEehHuJytKRMq4f
         7EYma1dqcQOreXEAWRYphdca9K6EQfsA/irlkvNBuitOSyl6LY/vg8AZGPe4KwUqpODj
         JZhbZ8wgnsaTxmEk+o168jHst1ZR2k79w0LgPpwufOgIj1I+H7UJ8Kk5LD39zYjh23SP
         JdQ9So4OU6kz/1KSDaI0DpAgxyxKeWZFC/GFxPFQFsLfc9DxLzHQ+wP1uzmSwVDZTPnd
         G14w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2g3NcCbK61hSN1dzjKWikP+Ruofz9dnU6N8QLhgnC10=;
        b=lkVp64pREi6OyzGGNJS/XuZIjXAujYWh8i1gjYkQpM5KoA6fAUK5vGMwwNNfjVvvib
         PNe2cdp5NS0xz6YVLPSUbufVDt1OxrFtMZbN/ocOMeENg6IeuQN8zbDV1cNNzhvqVZ1p
         yfMwrwyz4lJ4LiypqhpkFsn9o/x1ga5E9GFMnNgb2HK83IurEe1EWYa8Pc8N8KMCGO5i
         CNhn9U5crVasNTvPPq26QTe0EXbnRzzzHMY2HCug1FtWV7DIjpw2loRZ0HliGkZzJ1oG
         GqVmO1flQtlWlKCCO9fmwvcqad8zOKQSTGK11eV7hEvVwkIZzQck9JR83LirZ8LyeZhO
         fqkg==
X-Gm-Message-State: AA+aEWZHU6B2TnsUuBJa3belYcIet+o+PSCa3cUmPqS0AcQnLKS2KInV
        GDtyj6wOWTRM28+2tXnwq6WXSA==
X-Google-Smtp-Source: AFSGD/VSqKIxLg36Um7bOZgqXf+iM5j2EeKbN5ScHh7M3O9fq+lhquXJA4VX5Jh4GSneP7sjUvYOcA==
X-Received: by 2002:a5d:4a0c:: with SMTP id m12mr13694251wrq.38.1543051840416;
        Sat, 24 Nov 2018 01:30:40 -0800 (PST)
Received: from localhost.localdomain (244.red-83-33-128.dynamicip.rima-tde.net. [83.33.128.244])
        by smtp.gmail.com with ESMTPSA id c13sm23736654wrb.38.2018.11.24.01.30.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 24 Nov 2018 01:30:39 -0800 (PST)
From:   Greg Hurrell <greg@hurrell.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Philip Oakley <philipoakley@iee.org>,
        Ann T Ropea <bedhanger@gmx.de>,
        Greg Hurrell <greg@hurrell.net>
Subject: [PATCH] doc: update diff-format.txt for removed ellipses in --raw
Date:   Sat, 24 Nov 2018 10:29:58 +0100
Message-Id: <20181124092958.3549-1-greg@hurrell.net>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <xmqqwop32npr.fsf@gitster-ct.c.googlers.com>
References: <xmqqwop32npr.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Since 7cb6ac1e4b ("diff: diff_aligned_abbrev: remove ellipsis after
abbreviated SHA-1 value", 2017-12-03), the "--raw" format of diff
does not add ellipses in an attempt to align the output, but the
documentation was not updated to reflect this.

Signed-off-by: Greg Hurrell <greg@hurrell.net>
---

The GIT_PRINT_SHA1_ELLIPSIS environment variable can be used, for now,
to bring back the old output format, but that is already documented in
git.txt, so I am not mentioning it here.

 Documentation/diff-format.txt | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/Documentation/diff-format.txt b/Documentation/diff-format.txt
index 706916c94c..cdcc17f0ad 100644
--- a/Documentation/diff-format.txt
+++ b/Documentation/diff-format.txt
@@ -26,12 +26,12 @@ line per changed file.
 An output line is formatted this way:
 
 ------------------------------------------------
-in-place edit  :100644 100644 bcd1234... 0123456... M file0
-copy-edit      :100644 100644 abcd123... 1234567... C68 file1 file2
-rename-edit    :100644 100644 abcd123... 1234567... R86 file1 file3
-create         :000000 100644 0000000... 1234567... A file4
-delete         :100644 000000 1234567... 0000000... D file5
-unmerged       :000000 000000 0000000... 0000000... U file6
+in-place edit  :100644 100644 bcd1234 0123456 M file0
+copy-edit      :100644 100644 abcd123 1234567 C68 file1 file2
+rename-edit    :100644 100644 abcd123 1234567 R86 file1 file3
+create         :000000 100644 0000000 1234567 A file4
+delete         :100644 000000 1234567 0000000 D file5
+unmerged       :000000 000000 0000000 0000000 U file6
 ------------------------------------------------
 
 That is, from the left to the right:
@@ -75,7 +75,7 @@ and it is out of sync with the index.
 Example:
 
 ------------------------------------------------
-:100644 100644 5be4a4...... 000000...... M file.c
+:100644 100644 5be4a4a 0000000 M file.c
 ------------------------------------------------
 
 Without the `-z` option, pathnames with "unusual" characters are
@@ -100,7 +100,7 @@ from the format described above in the following way:
 Example:
 
 ------------------------------------------------
-::100644 100644 100644 fabadb8... cc95eb0... 4866510... MM	describe.c
+::100644 100644 100644 fabadb8 cc95eb0 4866510 MM	describe.c
 ------------------------------------------------
 
 Note that 'combined diff' lists only files which were modified from
-- 
2.19.0

