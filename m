Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1A46D1F461
	for <e@80x24.org>; Mon,  1 Jul 2019 15:22:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728040AbfGAPWS (ORCPT <rfc822;e@80x24.org>);
        Mon, 1 Jul 2019 11:22:18 -0400
Received: from mail-yw1-f43.google.com ([209.85.161.43]:39772 "EHLO
        mail-yw1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726869AbfGAPWS (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 Jul 2019 11:22:18 -0400
Received: by mail-yw1-f43.google.com with SMTP id u134so100210ywf.6
        for <git@vger.kernel.org>; Mon, 01 Jul 2019 08:22:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=NrPKgPQ9JBJ4Mifu7nkj6rL+CqhnBxHK/EgOkFRd61U=;
        b=2OW9M4VZx87SuZLr34swnNaBDiJzZg5Sn/cjEFfOV6CU53+ysustmkwjs8maIVSdNV
         DvxJHbBLHmS5+7eIJo2EHqoZXtpVCMTOmh++hReyjwdg6yySSm4ZNzWDwGe0aLOcWPRy
         VuKYQ+ODEzktw/TtxOv+yJkpInWeDAsdFgJYZ8zFfmVBazX/JDZUtaDAhSr+cj2Qc7D9
         gjpd+2+9pCVUjmkkfu0CPwZwrvvdBPZ+WQzCNBAkd0HEyUrYluueHrp2VwfyMQuEZ3T+
         76I9vSAhDOVsccxngwXTMdv2U+uuSyqLlG4dHn5DAr26gKUqcYKLJASe9IB4qgE2mWVt
         Gf2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=NrPKgPQ9JBJ4Mifu7nkj6rL+CqhnBxHK/EgOkFRd61U=;
        b=qgFOhl+fvjgQWO2bUtm5bhNrAmora5jkbFR6PSp4Xs0zFpv5vSqZ6YaVjT5mtBfHcM
         FIBnz8OPAP53ct1750n2/9APwQ6vBMG28HVH+n7HQ9tRQan5l231wt1ln253cxDafmhJ
         WCembRJlnlcvFjc80G6yvALU4zzf7W+Ev3K7qZXiVCoQAAodrW+W0bf0tqM6QXLcPdJ1
         m0EskNoxnw78wR/r9O7yk/NrQPNo1Gost2ROlHEtIKxB9n/yQovho55BACWjS3P8U3GL
         DgTj/kH7oVClnH5sO72yLsBjF5IK3dpm7SLZnXk6R6wNU421zDN3fIrs9JaWxeT1n1oH
         Yj3w==
X-Gm-Message-State: APjAAAWrmPoyapTCnrfllqKL9VlhBfg6Z+enY6Jc0zqXb6OB9sak9RYj
        xW6OGGbUd6UUvcAPIXyWQ64XV4vRu7sO2w==
X-Google-Smtp-Source: APXvYqxNAA4ri4mCbx4nMHsRHvasUkWFlXLhulbbvlxLpXapnsyb/ASJT6KTQV5w2YGvY3nOnY8HSA==
X-Received: by 2002:a0d:d805:: with SMTP id a5mr14918052ywe.418.1561994537281;
        Mon, 01 Jul 2019 08:22:17 -0700 (PDT)
Received: from localhost ([2600:1700:6e90:7930:6841:343f:64f7:7ef1])
        by smtp.gmail.com with ESMTPSA id d9sm2612720ywa.69.2019.07.01.08.22.16
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 01 Jul 2019 08:22:16 -0700 (PDT)
Date:   Mon, 1 Jul 2019 10:22:15 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: What's cooking in git.git (Jun 2019, #07; Fri, 28)
Message-ID: <20190701152215.GA43911@TaylorsMBP5815.attlocal.net>
References: <xmqqzhm173sp.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqzhm173sp.fsf@gitster-ct.c.googlers.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Fri, Jun 28, 2019 at 03:17:42PM -0700, Junio C Hamano wrote:
> * tb/ref-filter-multiple-patterns (2019-06-27) 1 commit
>  - ref-filter.c: find disjoint pattern prefixes
>
>  "git for-each-ref" with multiple patterns have been optimized.
>
>  Will merge to 'next'.

Thanks for queueing this patch. For what it's worth, we have had this
patch in GitHub's fork for the past month (?) or so, and it has been
running without issue.

Thanks,
Taylor
