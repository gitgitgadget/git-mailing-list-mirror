Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5488D1FD09
	for <e@80x24.org>; Mon, 29 May 2017 00:54:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751030AbdE2Ayu (ORCPT <rfc822;e@80x24.org>);
        Sun, 28 May 2017 20:54:50 -0400
Received: from mail-pf0-f193.google.com ([209.85.192.193]:36270 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750989AbdE2Ayo (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 28 May 2017 20:54:44 -0400
Received: by mail-pf0-f193.google.com with SMTP id n23so10446630pfb.3
        for <git@vger.kernel.org>; Sun, 28 May 2017 17:54:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=zis4ARYQSOIShNYzHqTNlXthhW4Zc7URW1Z5GWtyUvU=;
        b=cDkifyTlNdP7BHijaKpbifk5RJt7zuALAev3mnTCW2xm/MThZVz1Vrph/fnI0V/ho1
         TTk81pWvRb+XNRCXIt2mPY+3Uxgki1eYSY/SUjJUwG/Myli56AxID+Lf0GJNdPJcJ9Dz
         7fg+vvh618vJxXyUI4ZcXcS2lo5OYYrvxePjc25gIUUp2lv/mCgG2eHi7ZH3dqfIhVoP
         djH4FEWr4ohgbVojPqb3f17FcJCv9DRscUdrsb1gTi8qzXsj4OI3z6TDJTUy9CYaBQud
         FSRCfcB3aGWPrUI9bv4/L3WjZwICDr+5apJGQvsqj9H0EZ677EQBvt+13ZIUMdCMtL4l
         gFRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=zis4ARYQSOIShNYzHqTNlXthhW4Zc7URW1Z5GWtyUvU=;
        b=Oa+00xQRhMvAfN/IJ3zuJWCnMauCsVrO5DcWxc9TNx68b6AlR45+bXYMo5f2mLhu7G
         Q+09nfgVW5XLi9lmpdrKdxxYH5O3RSbl4KBiG4F/Ta4OoJDTPiDkhyxapXejY9rFWsVb
         vvKMFKHTkv4K/4NvaGeD2aiFpVnU2Xy73/d1kYQD+x2JeG1dtpcYRJyCtAJ/2TDj10sx
         eOKChpc12e7g/ygxNJtEf8Lp702fAOKpKSnuJCQg0w/US/dw3v37D9o1mwGRwZ/IjwYW
         YqDE+mpThzwo6jK3SQh3mXPsx8m8eCf9/tSbGVRtiNxefRYyLQinB4HQbiSkBjPcJ3FG
         YP6g==
X-Gm-Message-State: AODbwcC9TvWTOmjIbCVkwz7YldwHsDzL+Z0utQHtcZ/sBgFsLFehAWXJ
        gEGzwuYQN8keEA==
X-Received: by 10.98.62.86 with SMTP id l83mr15060485pfa.114.1496019279144;
        Sun, 28 May 2017 17:54:39 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:393e:d787:9be9:17cc])
        by smtp.gmail.com with ESMTPSA id 3sm13048724pfp.11.2017.05.28.17.54.38
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Sun, 28 May 2017 17:54:38 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Subject: Re: [PATCH] wildmatch test: remove redundant duplicate test
References: <20170526205657.15006-1-avarab@gmail.com>
Date:   Mon, 29 May 2017 09:54:37 +0900
In-Reply-To: <20170526205657.15006-1-avarab@gmail.com> (=?utf-8?B?IsOGdmFy?=
 =?utf-8?B?IEFybmZqw7Zyw7A=?=
        Bjarmason"'s message of "Fri, 26 May 2017 20:56:57 +0000")
Message-ID: <xmqqd1asa3ea.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thanks.  Did you run "sort | uniq -c" on it or something ;-)?

Will apply.
