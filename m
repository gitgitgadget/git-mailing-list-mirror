Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E2A581F461
	for <e@80x24.org>; Thu, 11 Jul 2019 15:59:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728546AbfGKP7r (ORCPT <rfc822;e@80x24.org>);
        Thu, 11 Jul 2019 11:59:47 -0400
Received: from mail-vk1-f179.google.com ([209.85.221.179]:45213 "EHLO
        mail-vk1-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728409AbfGKP7r (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 Jul 2019 11:59:47 -0400
Received: by mail-vk1-f179.google.com with SMTP id e83so1444163vke.12
        for <git@vger.kernel.org>; Thu, 11 Jul 2019 08:59:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=n28X9c3umLCE/iiJnNiZcRe3HmiawLx3qD0Gno1Yshk=;
        b=gwPaXygUx2/ZieaRhy7v8+L4eN1kiofW8ay2WOU4MLTaLDCu3o90diW6VP7AULjA47
         6YDCRQcXZZsDIPBXyOcPkCxUWKq+PQVyvw4/8T4xCfbJbVUQc+G4GPH+TaNcvd+6v5u2
         ie62w490mdWrd+i4DR9mCfG+EX/cLNHNkszTFXPCTByMwg1TUdvtbSUlGsT/NQNSQgcJ
         +iikbywGgog4xb7xeUd0ZhhI1U4aekyjLgf4bItm2sKYrEFse7FtRJXtrxW/IDv8Fci5
         K5qJF1hk9WwKAVkOEzrPuzeYF84Hwz0YL8xw3wA/dMnQinuWtwdeP9ZuLkDQHJ2TMJxr
         vR6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=n28X9c3umLCE/iiJnNiZcRe3HmiawLx3qD0Gno1Yshk=;
        b=lz5BU694Al5UrxjlqkTQKHMZAsFhg+SiYSgSPsMN0JR2O3JLYHUNk/RO2rdtvVuQYX
         ePa0sSYp2IcgYNUX2z8Nogc1Y3ueEozo7pEQYzxuLGdHMVlXYsAFSrCB8KeXTtLBbPje
         ++d9y8Nidp0c0VEZ/lwS3Cbz6KB7AmX1wPA32N3Csqm9gbcDycN4/39idivXhPM7k5u+
         CZHp6giLJ5sRvUQE1MIMvPeJ71R7pfC0+Xu+zRd2Us3xlLX7umsKe/RVd9/mVKhWuE6Z
         1So3256IetSOCuwHTDEq9gY67vI2BGcnuH87sWUULUqRhqEbAXsdqR3ksAV54Tvppfmi
         8ezQ==
X-Gm-Message-State: APjAAAU8YlojWi28AIusqx3ktPKA8kNrBERHe4pzhsSizooj1q7gKWAk
        ACKKpyhJhCPY05Aa8xU0CVtkLbUEFsaLmlXVN14=
X-Google-Smtp-Source: APXvYqy/o1QzPZbScNO/kHwZSpZEAU9gvkEwLJ6Fga+F72B9lqAU2zVm9pvFiyLGDDdFvQ/yx9aoJd8qciSBnCf1pxQ=
X-Received: by 2002:a1f:8513:: with SMTP id h19mr3844340vkd.92.1562860786171;
 Thu, 11 Jul 2019 08:59:46 -0700 (PDT)
MIME-Version: 1.0
References: <CY4PR2201MB1559C26C1D75B4F649AD38049AF30@CY4PR2201MB1559.namprd22.prod.outlook.com>
In-Reply-To: <CY4PR2201MB1559C26C1D75B4F649AD38049AF30@CY4PR2201MB1559.namprd22.prod.outlook.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Thu, 11 Jul 2019 08:59:35 -0700
Message-ID: <CABPp-BFr5TLNnjFxj_YRmt=z17U=ehxz1WjhqxDCA0aNf6v6JQ@mail.gmail.com>
Subject: Re: List of Known Issues for a particular release
To:     "Mark T. Ortell" <mtortell@ra.rockwell.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jul 11, 2019 at 8:50 AM Mark T. Ortell <mtortell@ra.rockwell.com> w=
rote:
>
> Hello,
>
> I am doing a software tool assessment for functional safety and I am revi=
ewing the use of Git as the SCM. One thing that I need to do is review the =
list of "known issues" with the Git release being used. I have gone through=
 the release notes and found that it only contains the fixes and enhancemen=
ts in a particular release of Git, it does not contain a list of known issu=
es/errata in a particular release. The github project also does not include=
 the bug tracking list, so I am not able to figure out a way to review the =
known issues for a particular release. I considered reviewing the fixes in =
releases beyond the release used, but that has 2 problems. One, it doesn't =
contain any issues that are yet to be fixed. Two, only the fixes in the "ne=
xt" release are truly relevant because fixes after that could have been int=
roduced in a release after the release being used. An additional note is th=
at the Git for Windows project does provide a list of known issues in the i=
nstall
>
> Could someone in this mailing list assist me in finding the known issues =
for a particular version?
>
> Best Regards,
> Mark Ortell

Probably not in the format you want, and likely including noise that
isn't relevant, but in a clone of git.git you could run:

git grep ^test_expect_failure t/
