Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80F65C433EF
	for <git@archiver.kernel.org>; Fri, 31 Dec 2021 11:16:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229674AbhLaLQJ convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Fri, 31 Dec 2021 06:16:09 -0500
Received: from mail-io1-f51.google.com ([209.85.166.51]:45725 "EHLO
        mail-io1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229614AbhLaLQJ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 31 Dec 2021 06:16:09 -0500
Received: by mail-io1-f51.google.com with SMTP id i14so31627258ioj.12
        for <git@vger.kernel.org>; Fri, 31 Dec 2021 03:16:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Hy57Zg33w2kDKLwIdHpvQjMBHXdDGYBS1EeIQaZ2b00=;
        b=q2JmDx7PnkWSfSyrEYhSarYmMWzAX9OfKsQ3L/J+HPxxLyldX8khNIRRP3DguxFeJe
         Rmf7v9D1jqHH8eCl1OV/KGrkZQeA9+9+zuPeGBtlvse3JES+5aC9yhABgQp+60kg6c9/
         pvMwz8Kp3ELKDyYmCo/D1nXHzVHDywiRPQKVzBcnYLh3/Dbqgc4pY/OGUQeo/GEvN1PD
         ZNSpyIEjBOh+JCLUOtXexalWfhGHC+IhXCZwgvfCUt75tFTFP6MLzfp61FBiCJElpDFS
         CQGqSoHdzcx4zGBlT5dvd8NSPVZGA7Dukox7VvH7L2T5Z2/AHlX/V4NH07OzZNAUKpCe
         LT0w==
X-Gm-Message-State: AOAM53084yaJv/8OBtq4cW2Vuns05gZXqDCPV8vvriSquoCMFHt3JT/E
        mbEgrZ7sEBNLjUmPDg0qfE2ywWIJO4Gg8PHT1VKyrGdNKs0=
X-Google-Smtp-Source: ABdhPJw0Poxr9bPnvxibObwT4MmEVBPAVBLglCp5kwJOiGwCq6nWOnA55KxHTVC52DAb0Xhejw0o+M7wSruTO5IWppg=
X-Received: by 2002:a02:83c3:: with SMTP id j3mr7741891jah.50.1640949369008;
 Fri, 31 Dec 2021 03:16:09 -0800 (PST)
MIME-Version: 1.0
References: <52591f5d-d4b5-90ea-e84e-32b99803a3e6@gmail.com> <00dd01d7fd78$7e69e150$7b3da3f0$@nexbridge.com>
In-Reply-To: <00dd01d7fd78$7e69e150$7b3da3f0$@nexbridge.com>
From:   Erik Cervin Edin <erik@cervined.in>
Date:   Fri, 31 Dec 2021 12:15:32 +0100
Message-ID: <CA+JQ7M_tQG4yzSeHjZxPWuWEOM=iSLrWxojQGcpL9E7FcoXLRg@mail.gmail.com>
Subject: Re: Git Diff feature request
To:     rsbecker@nexbridge.com
Cc:     nickgearls@gmail.com, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Dec 31, 2021 at 11:23 AM <rsbecker@nexbridge.com> wrote:
> One interesting technique I have seen used is to set up a pre-commit hook and/or clean filter to format code according to corporate/team standards. Reprocessing code prior to the commit would allow a normalization of coding standards and removing of EOL or space/tab concerns.
> ...
> We use a similar technique (enforced only by policy right now, not a hook), which is to require code to run through standard IDE source formatting. Improperly formatted code hitting pull requests gets a decline until the code is properly formatted.

I agree with Randall, the easiest solution is to adhere to a formatting standard
