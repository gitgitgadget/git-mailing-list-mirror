Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3F30E20248
	for <e@80x24.org>; Mon,  4 Mar 2019 15:50:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726615AbfCDPuA (ORCPT <rfc822;e@80x24.org>);
        Mon, 4 Mar 2019 10:50:00 -0500
Received: from mail-qt1-f193.google.com ([209.85.160.193]:42338 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726098AbfCDPt7 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 4 Mar 2019 10:49:59 -0500
Received: by mail-qt1-f193.google.com with SMTP id u7so5593242qtg.9
        for <git@vger.kernel.org>; Mon, 04 Mar 2019 07:49:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=b0w5B6FBn2rAVXkcdgS31Nfsj3OAGuv7xQnjndE37v4=;
        b=RBta4NvXeeBHW9YPiYJfErV7IP6qib7PDxuLCwd9t9Ocb1WtKAMGbCwkGloRq0RnO/
         tdEgxkdyZBtREy52nDIIaWXUwefO8P1MVlopd8IaLTRY2ZbXb+0VV04OzDdRuroZrcOk
         cWdNyR3292cve9I3LQnsy04zJ8jEIUJWWKIaCTpEVSDjKI/t1tOOFLEbd2KlbvmeOTsS
         IiPoTPTEgV7rsn6XI7XXV01uQ/ts7ET9971lUdTvAgfQkF4LXRlYRvrEbRFyYdEh20+m
         nN5XMZAj5c9/GX1Vn7jaqx24wAn/MkkqRjxrG11z8cteh3OiLFDn7ZV3LysjH7hvyRCl
         lOeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=b0w5B6FBn2rAVXkcdgS31Nfsj3OAGuv7xQnjndE37v4=;
        b=DS7iPDOCLmLP1RXUdD7myjKe2ZEyda0ryQPQeWdsqhD5DRriJhdJdAL4x690wR93N/
         f8+Mva2LGXo07Wnm9d0WUnlt8Omngtf5G5iIyQYsI+qbPjJKhSAKpLCW8Wz9akvHLl3J
         +rGm04OgR7BFBnmRi1wi5kMnZ7nW2UpfE4csOrlzRP8m1OTlO1+pse2aDfOVQi1cwA6w
         WM2SkB/WWIxw43M3zsWkm4GTBBbci4wOa2tkBFE/l3yQtuLz/+xjxKnBpy8kLggs8WS+
         G+wOH/LjhZ3zU8NcsqC87zbaZaVXSMPQc8dTfQJcBflqt8vYSSXRSWOGtuHn7FAr+Q5S
         o57g==
X-Gm-Message-State: APjAAAW+d6enZD53oyuG+eL4Sq7ovMdZvZ9OSMpzzdeUzPHkPq8egDi+
        V4rYgcv9vgiOXhQhXFtKRkm/Dx+9Yeo=
X-Google-Smtp-Source: APXvYqxARMqWIS7ZcV08fAPsbGItAWfitwqG47wBfBMDV8T3pkqmI+Eo2YDIc3F+H5iDXBk842pCYA==
X-Received: by 2002:a0c:91d7:: with SMTP id r23mr14577039qvr.36.1551714598563;
        Mon, 04 Mar 2019 07:49:58 -0800 (PST)
Received: from [10.124.100.9] ([66.210.32.226])
        by smtp.gmail.com with ESMTPSA id r47sm4560494qtc.48.2019.03.04.07.49.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 04 Mar 2019 07:49:57 -0800 (PST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.0 \(3445.100.39\))
Subject: Re: [RFC PATCH 2/4] Add alias option to git branch
From:   Kenneth Cochran <kenneth.cochran101@gmail.com>
In-Reply-To: <7D21A788-5E38-466F-B3CC-F6A5CBEB2E2E@gmail.com>
Date:   Mon, 4 Mar 2019 09:48:25 -0600
Cc:     git@vger.kernel.org, Sahil Dua <sahildua2305@gmail.com>,
        Duy Nguyen <pclouds@gmail.com>, Jeff King <peff@peff.net>
Content-Transfer-Encoding: quoted-printable
Message-Id: <D9CFD250-26D4-4D1F-B0CD-01E24E8606D9@gmail.com>
References: <47CA9077-E8C1-4093-8B36-2D5D3DE2D886@gmail.com>
 <7D21A788-5E38-466F-B3CC-F6A5CBEB2E2E@gmail.com>
To:     Kenneth Cochran <kenneth.cochran101@gmail.com>
X-Mailer: Apple Mail (2.3445.100.39)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=46rom 5aa6f037642df3b358ab659d17b5fb5bc7936f0f Mon Sep 17 00:00:00 2001
From: Kenneth Cochran <kenneth.cochran101@gmail.com>
Date: Sun, 3 Mar 2019 15:05:11 -0600
Subject: [RFC PATCH 2/4] refs: add function to iteratively dereference =
symref
 chain
Cc: Sahil Dua <sahildua2305@gmail.com>,
    Duy Nguyen <pclouds@gmail.com>,
    Jeff King <peff@peff.net>

As far as I can tell, currently, there's not really any way
to run something once per symref in a symref chain. This adds that
ability.

This will be useful for instance to improve how `git branch -d`
handles a checked out symref.

Signed-off-by: Kenneth Cochran <kenneth.cochran101@gmail.com>
---
 refs.c | 28 ++++++++++++++++++++++++++++
 refs.h | 13 +++++++++++++
 2 files changed, 41 insertions(+)

diff --git a/refs.c b/refs.c
index 142888a40a..18a222d76a 100644
--- a/refs.c
+++ b/refs.c
@@ -1466,6 +1466,34 @@ static int do_for_each_ref(struct ref_store =
*refs, const char *prefix,
 					do_for_each_ref_helper, &hp);
 }
=20
+int refs_for_each_ref_in_chain(struct ref_store *refs, each_ref_fn fn,
+			       void *cb_data, const char *starting_ref)
+{
+	int symref_count;
+	struct object_id oid;
+	int flags;
+	const char *ref_name =3D xstrdup(starting_ref);
+	int res;
+
+	for (symref_count =3D 0; symref_count < SYMREF_MAXDEPTH; =
symref_count++) {
+		res =3D fn(ref_name, &oid, flags, cb_data);
+		ref_name =3D refs_resolve_ref_unsafe(refs, ref_name, =
RESOLVE_REF_NO_RECURSE,
+						   &oid, &flags);
+
+		if (res)
+			return res;
+		if (!(flags & REF_ISSYMREF))
+			break;
+	}
+	return 0;
+}
+
+int for_each_ref_in_chain(each_ref_fn fn, void *cb_data, const char =
*starting_ref)
+{
+	return =
refs_for_each_ref_in_chain(get_main_ref_store(the_repository), fn,
+					  cb_data, starting_ref);
+}
+
 int refs_for_each_ref(struct ref_store *refs, each_ref_fn fn, void =
*cb_data)
 {
 	return do_for_each_ref(refs, "", fn, 0, 0, cb_data);
diff --git a/refs.h b/refs.h
index 308fa1f03b..66ccb85e8d 100644
--- a/refs.h
+++ b/refs.h
@@ -327,6 +327,19 @@ int for_each_glob_ref_in(each_ref_fn fn, const char =
*pattern,
 int head_ref_namespaced(each_ref_fn fn, void *cb_data);
 int for_each_namespaced_ref(each_ref_fn fn, void *cb_data);
=20
+/*
+ * Iteratively calls fn with each reference in a symref chain.
+ * Iteration will continue until one of the following occurs:
+ * - SYMREF_MAXDEPTH is reached
+ * - A non-symbolic ref is reached (fn will be called with this before =
returning)
+ * - fn returns a non 0 value
+ *
+ * Will always return 0 unless fn returns a non-zero value.
+ */
+int refs_for_each_ref_in_chain(struct ref_store *refs, each_ref_fn fn,
+			       void *cb_data, const char *starting_ref);
+int for_each_ref_in_chain(each_ref_fn fn, void *cb_data, const char =
*starting_ref);
+
 /* can be used to learn about broken ref and symref */
 int refs_for_each_rawref(struct ref_store *refs, each_ref_fn fn, void =
*cb_data);
 int for_each_rawref(each_ref_fn fn, void *cb_data);
--=20
2.17.1


