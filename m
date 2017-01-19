Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 316EB20756
	for <e@80x24.org>; Thu, 19 Jan 2017 08:33:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750765AbdASIdJ (ORCPT <rfc822;e@80x24.org>);
        Thu, 19 Jan 2017 03:33:09 -0500
Received: from mail-qt0-f171.google.com ([209.85.216.171]:35409 "EHLO
        mail-qt0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750888AbdASIdI (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 Jan 2017 03:33:08 -0500
Received: by mail-qt0-f171.google.com with SMTP id x49so55697242qtc.2
        for <git@vger.kernel.org>; Thu, 19 Jan 2017 00:32:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to;
        bh=MvfqOuuVR7GbKVF4mQJkMlZuWk1Y2dhL5WJ405NSGY4=;
        b=EYPAXawLibRU4m08lmQ3tNEqHPGud0vM/VGXMDwr1cozqUo6dPM+2wM+6Z81i/3q3d
         oycwaZrxI5Lq11BYS2lkz3jd3P6e4g9mMWUV7/ITLWgMpkOpwu5dl7DVUPeYr5Aq5mvA
         b3Pqz/O2rFuy2UjOdrypM3aZCvtwkABQbzk8ux8Pm5MZlr0Q5aeSafYPVBOpjMkOufyW
         6Zhue3R5a8eF5iE2bMs0G7PiR8E4eTWU/aGM7Bhc0O0MpUKc4l3G5VQKr9zPc9vQg0fL
         YJNG3OyVNorouFqVHYNv7/MaVvg2rf1kmY/4gAdPF5LR6fmMGSIbUQNi74KYPXI7N2xy
         zVGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to;
        bh=MvfqOuuVR7GbKVF4mQJkMlZuWk1Y2dhL5WJ405NSGY4=;
        b=cx7qZ7KhAqgO9aEkn0E8FvbCkupnP9w63cuqo5GMWiHtvK/Rj7KFXuJ2KOsJ/b77g1
         BxggtFvMvkaBkiMNZlnT2WHbcyJEXhwSHyjXZHYewzTVBIqF+ZHy91TOikso7VKkTUwd
         ZM5GCJGUTCN+lirD1W5g9fZ5SaxEgU9kghXGN+3DBGLkLmUoRKhOnykXloRIE1sdiVAR
         Eozhk9OszkE9vfAIrKIgx3d2ZpH5fmAmmqtxPsVCtJ5VQIY8RJz7Qmw1DkG7r/V45Ecc
         RFV4p9z/zOiO7dt9/D8XOvjUi9CYUohtt9jXwZbe+dv1OfMZHPjiqpdr+bpKQsHwOd+q
         kpyQ==
X-Gm-Message-State: AIkVDXL3ah7WAOMWYXjEGbL4n4k2TdspwyqdfzxoPmzDuTWtMVweMRcgJNeBvSUTAcgl2KWieKixAMdNbTr3lQ==
X-Received: by 10.200.1.11 with SMTP id e11mr6319684qtg.85.1484814751515; Thu,
 19 Jan 2017 00:32:31 -0800 (PST)
MIME-Version: 1.0
Received: by 10.12.142.66 with HTTP; Thu, 19 Jan 2017 00:32:11 -0800 (PST)
In-Reply-To: <CAKcFC3aqjLNUNKPDZ08rO_SBkY84uvHBerCxnSchAe8rH0dnMg@mail.gmail.com>
References: <CAKcFC3aqjLNUNKPDZ08rO_SBkY84uvHBerCxnSchAe8rH0dnMg@mail.gmail.com>
From:   jean-christophe manciot <actionmystique@gmail.com>
Date:   Thu, 19 Jan 2017 09:32:11 +0100
Message-ID: <CAKcFC3ZN+=o_2t4AawCE0c4Tw+t_XJKTHtEq9d7bv-ht5euPbw@mail.gmail.com>
Subject: Re: fatal: bad revision 'git rm -r --ignore-unmatch -- folder'
To:     git@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In case you were wondering whether these files were tracked or not:

git-Games# git ls-files Ubuntu/16.04
Ubuntu/16.04/residualvm_0.3.0~git-1_amd64.deb
Ubuntu/16.04/scummvm-data_1.8.0_all.deb
Ubuntu/16.04/scummvm-data_1.9.0_all.deb
Ubuntu/16.04/scummvm-dbgsym_1.8.2~git20160821.bad86050_amd64.deb
Ubuntu/16.04/scummvm-dbgsym_1.9.0_amd64.deb
Ubuntu/16.04/scummvm_1.8.0_amd64.deb
Ubuntu/16.04/scummvm_1.9.0_amd64.deb

On Tue, Jan 17, 2017 at 4:30 PM, jean-christophe manciot
<actionmystique@gmail.com> wrote:
> Hi there,
>
> I'm trying to purge a complete folder and its files from the
> repository history with:
>
> git-Games# git filter-branch 'git rm -r --ignore-unmatch --
> Ubuntu/16.04/' --tag-name-filter cat -- --all HEAD
> fatal: bad revision 'git rm -r --ignore-unmatch -- Ubuntu/16.04/'
>
> git does not find the folder although it's there:
>
> git-Games# ll Ubuntu/16.04/
> total 150316
> drwxr-x--- 2 actionmystique actionmystique     4096 Nov 19 13:40 ./
> drwxr-x--- 4 actionmystique actionmystique     4096 Oct 30 14:02 ../
> -rwxr-x--- 1 actionmystique actionmystique  2190394 May  9  2016
> residualvm_0.3.0~git-1_amd64.deb*
> ...
> -rw-r--r-- 1 actionmystique actionmystique 67382492 Oct 13 09:15
> scummvm-dbgsym_1.9.0_amd64.deb
>
> What is going on?
>
> --
> Jean-Christophe



-- 
Jean-Christophe
