Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 780431F4BD
	for <e@80x24.org>; Wed,  9 Oct 2019 21:00:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732525AbfJIVAS (ORCPT <rfc822;e@80x24.org>);
        Wed, 9 Oct 2019 17:00:18 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:40643 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732413AbfJIVAP (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Oct 2019 17:00:15 -0400
Received: by mail-wr1-f67.google.com with SMTP id h4so4762717wrv.7
        for <git@vger.kernel.org>; Wed, 09 Oct 2019 14:00:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=XtZab/eSvNAGT/nHFzYO8j0MgTZMU0VeiIWAFzVwyfY=;
        b=PsXx4I2LnJFqtMTq07P8WP+Zy310MKx+jN6gO/TCLmGjw9cEGyKYQ/zZDVQ+0RoiNB
         sbkPGhtzVtOrPJUVCBOLqtWcxwg3Yp8pUtjht2qyKgOXoThR8RbTKgQBDLgdMM6a5oDc
         IIFvVF1gffzKg0eGRCQ9mQwxsIbaRwVtMs4cxmzsfNX3qdN+SR6dyQDPg1iSoOnJ2Ut+
         uVUeHkAC7410Mc9yk9BrAFDBCcjDCOXv7nnJa68QKkk8LzAlIXR+ywCiKzH61tEgRm2q
         lYRIrjx7XZI67ijUGsX/WkqGn8CrmoZ0Wu/E4tQ86OhMm4jMpx6O6H0s/tMfKduC/l5E
         11NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=XtZab/eSvNAGT/nHFzYO8j0MgTZMU0VeiIWAFzVwyfY=;
        b=H/LYo1SLZ1RFIWj+0EUuwY/hqfSeShEQwjnwCQKqbOqB/MvZePQ11+dv8i2m0ImZo6
         vnfY17XBD5Qb19ikyCssxlL12m9exF6JbZ18zI9bH3Ra7Vhf1JT67ajaFvFmuhoAjDhV
         ruDqL4anXLf4wUtFNkgj+vzjs4UKc2VGj87rn9uczoXSZfN24kRZxPJ3krwcbJYPlNWu
         0rA7PbtHlCe+NMaGH6T7FS+1nPicwp9VVJXtx0n7P5XO95v05qxYY/cY/UCZgpt4A3z6
         XZ9IJIazYm6KwljDPSV+S+wlUu26Wx7atQTiQ+ZLG5id9JK2QqjbscfYFQjEOodAePxD
         ZBBA==
X-Gm-Message-State: APjAAAXSjirkwrrly5hXaO2KamKIYJGp1dUQuJpeJQ8FukY1dWemx5FG
        TmYAGjbxOxyDqy/AVhek9kwqMyCY
X-Google-Smtp-Source: APXvYqzBEpi3XiNYpj9KEXwxMZRCLOxPm3b+WPMWOb9kwMEHlzId6Lv/JhksiIanl2KjGmrLnZAq6g==
X-Received: by 2002:adf:d848:: with SMTP id k8mr5043920wrl.189.1570654811857;
        Wed, 09 Oct 2019 14:00:11 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id p85sm4737499wme.23.2019.10.09.14.00.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 09 Oct 2019 14:00:11 -0700 (PDT)
Date:   Wed, 09 Oct 2019 14:00:11 -0700 (PDT)
X-Google-Original-Date: Wed, 09 Oct 2019 21:00:09 GMT
Message-Id: <pull.372.v2.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.372.git.gitgitgadget@gmail.com>
References: <pull.372.git.gitgitgadget@gmail.com>
From:   "William Baker via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v2 0/1] fsmonitor: don't fill bitmap with entries to be removed
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     williamtbakeremail@gmail.com, stolee@gmail.com,
        Johannes.Schindelin@gmx.de, jeffhost@microsoft.com,
        Junio C Hamano <gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is the second iteration of changes to fix the segfault that I
encountered while testing fsmonitor. This iteration includes the following
updates for feedback I received on v1:

 * Use %u instead of %"PRIuMAX" for unsigned ints in BUG format strings
 * Updated the new test's comment to be more descriptive

Thanks,

William

William Baker (1):
  fsmonitor: don't fill bitmap with entries to be removed

 fsmonitor.c                 | 29 ++++++++++++++++++++++++-----
 t/t7519-status-fsmonitor.sh | 13 +++++++++++++
 t/t7519/fsmonitor-env       | 24 ++++++++++++++++++++++++
 3 files changed, 61 insertions(+), 5 deletions(-)
 create mode 100755 t/t7519/fsmonitor-env


base-commit: 5fa0f5238b0cd46cfe7f6fa76c3f526ea98148d9
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-372%2Fwilbaker%2Ffix_git_fsmonitor_crash-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-372/wilbaker/fix_git_fsmonitor_crash-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/372

Range-diff vs v1:

 1:  ce9bf4237e ! 1:  08741d986c fsmonitor: don't fill bitmap with entries to be removed
     @@ -44,8 +44,8 @@
      +	struct cache_entry *ce;
      +	
      +	if (pos >= istate->cache_nr)
     -+		BUG("fsmonitor_dirty has more entries than the index (%"PRIuMAX" >= %"PRIuMAX")",
     -+		    (uintmax_t)pos, (uintmax_t)istate->cache_nr);
     ++		BUG("fsmonitor_dirty has more entries than the index (%"PRIuMAX" >= %u)",
     ++		    (uintmax_t)pos, istate->cache_nr);
       
      +	ce = istate->cache[pos];
       	ce->ce_flags &= ~CE_FSMONITOR_VALID;
     @@ -56,8 +56,8 @@
       	istate->fsmonitor_dirty = fsmonitor_dirty;
       
      +	if (istate->fsmonitor_dirty->bit_size > istate->cache_nr)
     -+		BUG("fsmonitor_dirty has more entries than the index (%"PRIuMAX" > %"PRIuMAX")",
     -+		    (uintmax_t)istate->fsmonitor_dirty->bit_size, (uintmax_t)istate->cache_nr);
     ++		BUG("fsmonitor_dirty has more entries than the index (%"PRIuMAX" > %u)",
     ++		    (uintmax_t)istate->fsmonitor_dirty->bit_size, istate->cache_nr);
      +
       	trace_printf_key(&trace_fsmonitor, "read fsmonitor extension successful");
       	return 0;
     @@ -85,8 +85,8 @@
       	int fixup = 0;
       
      +	if (istate->fsmonitor_dirty->bit_size > istate->cache_nr)
     -+		BUG("fsmonitor_dirty has more entries than the index (%"PRIuMAX" > %"PRIuMAX")",
     -+		    (uintmax_t)istate->fsmonitor_dirty->bit_size, (uintmax_t)istate->cache_nr);
     ++		BUG("fsmonitor_dirty has more entries than the index (%"PRIuMAX" > %u)",
     ++		    (uintmax_t)istate->fsmonitor_dirty->bit_size, istate->cache_nr);
      +
       	put_be32(&hdr_version, INDEX_EXTENSION_VERSION);
       	strbuf_add(sb, &hdr_version, sizeof(uint32_t));
     @@ -96,8 +96,8 @@
       
       			/* Mark all previously saved entries as dirty */
      +			if (istate->fsmonitor_dirty->bit_size > istate->cache_nr)
     -+				BUG("fsmonitor_dirty has more entries than the index (%"PRIuMAX" > %"PRIuMAX")",
     -+				    (uintmax_t)istate->fsmonitor_dirty->bit_size, (uintmax_t)istate->cache_nr);
     ++				BUG("fsmonitor_dirty has more entries than the index (%"PRIuMAX" > %u)",
     ++				    (uintmax_t)istate->fsmonitor_dirty->bit_size, istate->cache_nr);
       			ewah_each_bit(istate->fsmonitor_dirty, fsmonitor_ewah_callback, istate);
       
       			/* Now mark the untracked cache for fsmonitor usage */
     @@ -109,8 +109,9 @@
       	test_cmp expect actual
       '
       
     -+# Use test files that start with 'z' so that the entries being added
     -+# and removed appear at the end of the index.
     ++# This test covers staging/unstaging files that appear at the end of the index.
     ++# Test files with names beginning with 'z' are used under the assumption that
     ++# earlier tests do not add/leave index entries that sort below them. 
      +test_expect_success 'status succeeds after staging/unstaging ' '
      +	test_commit initial &&
      +	removed=$(test_seq 1 100 | sed "s/^/z/") &&

-- 
gitgitgadget
