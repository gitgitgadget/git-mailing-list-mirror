Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F03F61F6A9
	for <e@80x24.org>; Fri,  4 Jan 2019 03:39:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727201AbfADDjb (ORCPT <rfc822;e@80x24.org>);
        Thu, 3 Jan 2019 22:39:31 -0500
Received: from mail-io1-f45.google.com ([209.85.166.45]:37177 "EHLO
        mail-io1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727192AbfADDjb (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Jan 2019 22:39:31 -0500
Received: by mail-io1-f45.google.com with SMTP id g8so17296596iok.4
        for <git@vger.kernel.org>; Thu, 03 Jan 2019 19:39:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=corthon-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=D6V6CF3AzE4Ms6eIlmIU6YDDE2N+bzHWGj+CKNw5+kU=;
        b=vfaOhdAra1MNdlckdHULxLjGzwDhcxALVuKRaJhY03MNNVBBRLtvHG6oHECdZ7mO3i
         1E5NZdiI10z0xSW7Log//Y1SyMi+Npmp18zP0mysxsiBRMBM+ZR7ZvHn63raKxR1fDjH
         jqvZIKpK+k+b/Q50kZsxJsXhm4Y2d1RhCTDW/XDfJr+m+08cZf/GMnVqaE0gsTGIKgwr
         LoY6dHoNMeQSqTJgYBT08oS1LDJwNi9lPXS2lrHDQdl8fX57aSD/ODiAGkplZweM5v4T
         LVlf8Km5BRwX6/badA0O4YUXDrQIwYhggwyfhD+ggb7cLXH9tRvHncEDCboQGop9EbiN
         Qy9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=D6V6CF3AzE4Ms6eIlmIU6YDDE2N+bzHWGj+CKNw5+kU=;
        b=fYNRoN3mktW1ZrvL1r6JdxV0FbZK5rj9Z1JOh1RkWKKumwBpFRWJJKd8kc/hpwldbJ
         V0v5mnRUW+HY2/ACHy/Xa3zJUEeBKg4qX/mppkrkaXO9IrAwF8+MJK95uXMvpCMfT+9u
         Pk5jqVhKw5if17EtBURZDP5obpdfD6drV8ssBJNqXBm6BQiTDzE4P0SZAmWoEoqVEx8J
         uisrUm6PMI00kcX2uWnAWwGHsZ65pxQLUdmJ5lv3rQcpAJmbDVH4zRHQzoLnqoMbNR57
         Z3PF5PBwxeT2iE/2/5PVNZX7v9aTJbW4cTk+u3iqUn+hl8DByndt//nWWqtfo/5lIyc+
         GJpA==
X-Gm-Message-State: AJcUukdAvAhz1je6SwDvxASJk/znJtxMugJeppxvDGmhyw1TM9yBPrgY
        9Dm24GKZar8o1QRCTO/g1CnZ92fcQr06GFSWqta+qw==
X-Google-Smtp-Source: ALg8bN7LA4ESjf2Bv6dBV6YrFgR2G0M+anrGM5Y3ClO196feTDMk91nksd4fG47HK/qwevrmEGFUqVS2ZTNIV6tg9e4=
X-Received: by 2002:a6b:e316:: with SMTP id u22mr34793256ioc.33.1546573170129;
 Thu, 03 Jan 2019 19:39:30 -0800 (PST)
MIME-Version: 1.0
References: <CAGTkKag2sFy+Of=6uQeiGOQm0-NBrh9ixgzDoQXKR73+Ct3raQ@mail.gmail.com>
 <CAGyf7-HcncFOfmm5McEkOvCTkHNdePDSEQDZwEAK=z1bmC=QKw@mail.gmail.com>
In-Reply-To: <CAGyf7-HcncFOfmm5McEkOvCTkHNdePDSEQDZwEAK=z1bmC=QKw@mail.gmail.com>
From:   Bret Barkelew <bret@corthon.com>
Date:   Thu, 3 Jan 2019 19:38:04 -0800
Message-ID: <CAGTkKag-fTy3iZAKJxEnWD6_b_3pfuYvQQKBkLaeSL8wKM2sfg@mail.gmail.com>
Subject: Re: git version 2.20.1.windows.1 throws file name too long in gitk
To:     Bryan Turner <bturner@atlassian.com>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

They are the exact same path (with a different drive letter).

Another thing I've been able to confirm is I uninstalled git 2.20.1
and installed 2.19.0 on the failing system, and the older version of
Git works.
I've also tried a suggested fix I saw elsewhere to enable long path
names in the Windows registry, which did not resolve the issue with
git 2.20.1.

Happy to collect any additional data.
- Bret

On Thu, Jan 3, 2019 at 7:10 PM Bryan Turner <bturner@atlassian.com> wrote:
>
> On Thu, Jan 3, 2019 at 6:21 PM Bret Barkelew <bret@corthon.com> wrote:
>>
>> When I open gitk in a particular repository under this version of Git
>> for Windows, I now get a dialog box that says "Error: couldn't execute
>> "git": file name too long". I've noticed that the most pronounced
>> effect is that I cannot see the file diffs (or sometimes the file name
>> list) for any of the commits. I don't know the exact repro, but I've
>> narrowed down the following things:
>>
>> - This does not happen with the same repo if I use a system that has
>> git 2.19.0.windows.1 on another machine.
>> - This does not happen on my current machine in a freshly cloned repo.
>
>
> How =E2=80=9Cdeep=E2=80=9D are the paths to the different clones on the d=
ifferent systems? Are all of the clones at exactly the same path on disk?
>
> Git on Windows is (by defaulted) limited by MAX_PATH, which is 260 charac=
ters. That length is calculated including the path to the repository itself=
 and then to the file inside the repository. That means, for example, a giv=
en repository cloned to C:\repo may not have issues, but the same repositor=
y cloned to C:\Users\Bryan\Documents\workspaces\repo may.
>
>>
>> However, as soon as the remote updates with any changes on a given
>> fetch/pull, the repo is put in a bad state permanently.
>>
>> I've pasted the output from gitk below...
>>
>> couldn't execute "git": file name too long
>> couldn't execute "git": file name too long
>>     while executing
>> "open $cmd r"
>>     (procedure "getallcommits" line 48)
>>     invoked from within
>> "getallcommits"
>>     (procedure "readcache" line 80)
>>     invoked from within
>> "readcache file827e200"
>>     ("eval" body line 1)
>>     invoked from within
>> "eval $script"
>>     (procedure "dorunq" line 11)
>>     invoked from within
>> "dorunq"
>>     ("after" script)
>>
>> Happy to gather whatever data needed.
>> Thanks!
>> - Bret Barkelew
