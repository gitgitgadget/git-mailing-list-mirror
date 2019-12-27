Return-Path: <SRS0=DNff=2R=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1294C2D0C3
	for <git@archiver.kernel.org>; Fri, 27 Dec 2019 21:15:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B3B6F20838
	for <git@archiver.kernel.org>; Fri, 27 Dec 2019 21:15:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726923AbfL0VDv (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 27 Dec 2019 16:03:51 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:40067 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726527AbfL0VDv (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 27 Dec 2019 16:03:51 -0500
Received: by mail-wr1-f67.google.com with SMTP id c14so27199870wrn.7
        for <git@vger.kernel.org>; Fri, 27 Dec 2019 13:03:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Va8QADCMU6nBI6LCa8aCNgkh8ZQpUEp8K4Swybc+n94=;
        b=pSx9v0k9El1yQhJje09tT6jtWhRLawPgvO6TYD1ukOqfPDH6oB2b8cFAPl9WnqhM1O
         EO5snMnR5cpgL5k4ePQrsHmE5iMc4kE6O+qo998ZTI43VcNZLFhC9D+jveTmTi+7f+Ih
         E493lMZ6A9irONEtVHJ5vwT+NS9jWGFIxNjhsYzDpT4Si6FUIO3HjslHIg84hMH0rVWv
         hfA4cX/whkiH8BKFjgguhAug2GleNmTGn/+Mzl5iIyADWaVPx6jDJb+WN32wpItkrJjt
         akJnCmn0DN7GmGVCcf4EI79BqUHnpMA0QIVrPdrWn2s5yI6gd7KUyIC1/79xf6yMYwrh
         h84Q==
X-Gm-Message-State: APjAAAUpEVR8Ou1EbOLN2Sj75vP5nIwQ70N24JzcEmCoYrdnE6woIejM
        upd4bx6QkyCI+7Qd8HsV3fR6wKVZRg+QPABLgSw=
X-Google-Smtp-Source: APXvYqzmYz1PrE2jLfVyi7CQWZdo5yO03/o2u1Ga0h+YnUI4gtUANbMjpreDhgB5BM7wZAT3D5kTra0QR50Ct5q4Yqc=
X-Received: by 2002:adf:b193:: with SMTP id q19mr52334327wra.78.1577480629458;
 Fri, 27 Dec 2019 13:03:49 -0800 (PST)
MIME-Version: 1.0
References: <cover.1577454401.git.liu.denton@gmail.com> <9558d2491fa8dc68603426c1528154b4fe352650.1577454401.git.liu.denton@gmail.com>
In-Reply-To: <9558d2491fa8dc68603426c1528154b4fe352650.1577454401.git.liu.denton@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Fri, 27 Dec 2019 16:03:38 -0500
Message-ID: <CAPig+cQRi34Avm7un=qvMJAZhiGa+Zy2s3NG1dcpZz=+rHG0LQ@mail.gmail.com>
Subject: Re: [PATCH 02/16] t2018: add space between function name and ()
To:     Denton Liu <liu.denton@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Dec 27, 2019 at 8:47 AM Denton Liu <liu.denton@gmail.com> wrote:
> t2018: add space between function name and ()

Patch 1/16, which removed an entirely unnecessary space from the end
of the description text, made sense without any additional
explanation. However, this patch's change could be puzzling to readers
who are not thoroughly familiar with the finer details of test coding
guidelines. At a minimum, it would be nice to add a sentence to the
commit message stating that this change brings the style in line with
the coding guidelines.

> Signed-off-by: Denton Liu <liu.denton@gmail.com>
