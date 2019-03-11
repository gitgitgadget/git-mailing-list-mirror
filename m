Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C1F4C20248
	for <e@80x24.org>; Mon, 11 Mar 2019 20:13:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728228AbfCKUN2 (ORCPT <rfc822;e@80x24.org>);
        Mon, 11 Mar 2019 16:13:28 -0400
Received: from mail-wr1-f45.google.com ([209.85.221.45]:46855 "EHLO
        mail-wr1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728130AbfCKUN1 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 11 Mar 2019 16:13:27 -0400
Received: by mail-wr1-f45.google.com with SMTP id i16so226434wrs.13
        for <git@vger.kernel.org>; Mon, 11 Mar 2019 13:13:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umich.edu; s=google-2016-06-03;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fN3nuecnutH0GfTyCWYZq+bRwYIroRl23FMtNADEViU=;
        b=bTDUaeF+qk8eiSz25DEtcv6Xk+K+PEjipB7VlKFVcM+ZUtTmoI1JQFZ+4FpFiUPsnz
         05SCbSdt/L6IQ8xCjlztxg65FAbFm56/QIVd3fLEVAAeU7FvuHjKmeG70QzML1g8zMm8
         B0zZGsMJtsYDDuUoozdfTsPG8hW9qsuD2ExIPrTOPVR6Ff3dDNCcOCmFgv8iyPLsx/0i
         PIq1mPyIpzdI1RC1bOq9RMZAeQzt95n1en29QirfFfL2JJLfaMtU2PelY03OozeMAcSU
         2rRA7SrdRDDAQnEIKaiQBt/BxuGHg+5Dmdb1/FHv6UqAosvsuo6yp94GZMwze9jjAHNF
         MR2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fN3nuecnutH0GfTyCWYZq+bRwYIroRl23FMtNADEViU=;
        b=UXR7jPO5R4TgcxCCh3RRAcNE0skx5JCDcRckdKhaSvI1LZoIbKUL78yu9S9u3S4l+j
         t0IaHqyaZc+kKSSCyJmovTT4RhxpT458a3x8iqWB0zL/2J1nLL8xEVFmyTn0Rx+RgJDd
         2nCGIwokeUDvSiCz5wKs2iUuSJMIgwKhTztJNGNlP5sCbU3VYpF1Jb/GQ8GOVBRq/Wft
         Vow8H9aWhI6KO7Q5xlPRlmkVt8aOZWWfEKsZkEmMWDA4KvtOiqo1cIoxZwl2KPsiGAe7
         GTkZLjbHBzxyh79GmDWmTIeUHIw28HAwNc3QGP5x6LFzzEwByTaD351uF801+k6UsAeY
         1tmA==
X-Gm-Message-State: APjAAAVWsE90nfmZxeEan9bO2LJIKO6MLLQ2kLMUFA0kokmJKoCEvVbA
        9DlhNF47aLaLZThSBaCo6tUJb9ZHtdT0G3JrPHBSgw==
X-Google-Smtp-Source: APXvYqx29JNLR0mkuQYsLwY3ouzn+odyq4DzGlat7XRElKjEQBrBB4+nWiRO1hdicKyxnbFa3nQGGpPeMJxY4TVOwNE=
X-Received: by 2002:adf:ffc3:: with SMTP id x3mr12430670wrs.111.1552335205674;
 Mon, 11 Mar 2019 13:13:25 -0700 (PDT)
MIME-Version: 1.0
References: <CA+dzEBkkbQj0rCjvPfcET2Uvt6fP_v+wQE52ZkAND2Mps08SNQ@mail.gmail.com>
 <10972e0e-7fe1-437f-efe6-cff82a1205e0@kdbg.org> <20190311175519.6lbppv5u44w2u4sj@tb-raspi4>
 <CA+dzEBm7fdrncnd_7tDu-q047qxt3CsHVQna3GRMagJetisQeA@mail.gmail.com> <CAKepmajVk27nHAzbuHitowyo11HvqSNfwfcg3kOp9DXDLe8FOA@mail.gmail.com>
In-Reply-To: <CAKepmajVk27nHAzbuHitowyo11HvqSNfwfcg3kOp9DXDLe8FOA@mail.gmail.com>
From:   Anthony Sottile <asottile@umich.edu>
Date:   Mon, 11 Mar 2019 13:13:14 -0700
Message-ID: <CA+dzEB=oKhd5O7bhWLNvvYM9eyht7SO1LkY5Sy=tEFhCCZzfDQ@mail.gmail.com>
Subject: Re: `git add <<windows 8.3 path to file inside repo>>` results in
 "fatal: ... is outside repository"
To:     Jack Adrian Zappa <adrianh.bsc@gmail.com>
Cc:     =?UTF-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>,
        Johannes Sixt <j6t@kdbg.org>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Mar 11, 2019 at 12:34 PM Jack Adrian Zappa
<adrianh.bsc@gmail.com> wrote:
>
> Hey Anthony,
>
> Are you sure that you have 8.3 active on the partition you are using?
> IIRC, It is not on by default anymore.  To see, go to a cmd line and
> type "dir /x".  If there are any files that exceed the 8.3 format, it
> will show those files with two names, the 8.3 name and the long name.
>
> If it is off and you want to turn it on, see
> https://support.microsoft.com/en-ca/help/121007/how-to-disable-8-3-file-name-creation-on-ntfs-partitions.
> and https://docs.microsoft.com/en-us/previous-versions/windows/it-pro/windows-server-2012-R2-and-2012/ff621566(v=ws.11)
> for more information.
>
>
> A
>

Yes, it appears they are enabled -- see below


C:\Users\IEUser\AppData\Local\Temp\t\longname-repo>git add
C:\Users\IEUser\AppData\Local\Temp\t\longna~1\f
fatal: C:\Users\IEUser\AppData\Local\Temp\t\longna~1\f:
'C:\Users\IEUser\AppData\Local\Temp\t\longna~1\f' is outside
repository

C:\Users\IEUser\AppData\Local\Temp\t\longname-repo>git add
C:\Users\IEUser\AppData\Local\Temp\t\longname-repo\f

C:\Users\IEUser\AppData\Local\Temp\t\longname-repo>dir /x ..
 Volume in drive C has no label.
 Volume Serial Number is 3A97-874F

 Directory of C:\Users\IEUser\AppData\Local\Temp\t

03/11/2019  01:11 PM    <DIR>                       .
03/11/2019  01:11 PM    <DIR>                       ..
03/11/2019  01:11 PM    <DIR>          LONGNA~1     longname-repo
               0 File(s)              0 bytes
               3 Dir(s)  20,063,666,176 bytes free
