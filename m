Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.6 required=3.0 tests=AWL,BAYES_00,BODY_8BITS,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6BB941FCA9
	for <e@80x24.org>; Fri, 16 Sep 2016 06:51:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753857AbcIPGve (ORCPT <rfc822;e@80x24.org>);
        Fri, 16 Sep 2016 02:51:34 -0400
Received: from mail-lf0-f45.google.com ([209.85.215.45]:35643 "EHLO
        mail-lf0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752097AbcIPGvc (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 16 Sep 2016 02:51:32 -0400
Received: by mail-lf0-f45.google.com with SMTP id l131so54626074lfl.2
        for <git@vger.kernel.org>; Thu, 15 Sep 2016 23:51:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=74JG1DSZiACO7VeKIuD3RbQx/wPVyVREfiFbqmPE07c=;
        b=GBI3FIZYEpZOEW6p7mmuUSQd+MP4x7k805i6/55vmA5HDoK2ROjAVbv5Tkbzlf+/OS
         1hsTyQOpDOb32lT9XTESt77yool86MxKqtzu5K+GkjS2nGfC5WHR+rxjHM6U3I3pbWi2
         brHFhkD8eomk9xbgf2hf5XduJwvrY61Oeqnmc0ZX3DWA6S8LKIDz/xPyFEh+2XVAdpcM
         SBvZARf6AJXGRCPPmeC4b/N8YyqRlYfNuGGZfUnLNcLEetxJnlqJE2lsxDDsKkHMtVlM
         Q0r4Z/zLwowy4Gdjmtf0UV9tDlDDVSATcCnG5JLCxMmYe1Ywz/9yVXq09NsMb2uCZHaW
         sScQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=74JG1DSZiACO7VeKIuD3RbQx/wPVyVREfiFbqmPE07c=;
        b=OiEK0hGnhyuJzHm9YpUta0gDXfP5ayKMmxosEG+B43tJJQ+g1PL8TM6eGONEzMdU9v
         2v652PDmp8tprU8KdPddoZbSK4K7KdvNGCeiaCCh2t/mVPBRCPK9gmPjSKeam6fq0cg4
         hv1FcuAqXIucz63w1rIZduEt7B16B+ladN+JXt+ExJef9XlUHenI2IARZHJ10UQB2ySe
         z0NEzYYBaui7vH8dSo5LhA+bC0N2tbvUctYoV1kj0yjWyaEbNSfT28vscCJ/S+XzLhSh
         ovPkkeV7pac5HivmeCyaVnveavKtC9Iq/KD17aqbWkgqYVYonpGNWEh6dLSvO2OI2K9a
         5xEg==
X-Gm-Message-State: AE9vXwOnEI+v48tZFaaFTJX9C07/LwtdzNy1rCnUIBaC2joVmmTvQAeWocVODSsy3/3e9+YItD59NOaceDOf/g==
X-Received: by 10.25.126.208 with SMTP id z199mr5413712lfc.7.1474008690479;
 Thu, 15 Sep 2016 23:51:30 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.25.165.194 with HTTP; Thu, 15 Sep 2016 23:51:30 -0700 (PDT)
In-Reply-To: <7c14756e-29f9-b475-f5f5-597acb8cea98@web.de>
References: <CANYoZJng0GNZWU=eUEnXgVQ_NKQQOKM+mhJ9bsXMEJxxEhwQMw@mail.gmail.com>
 <8df2883f-ec3c-3446-2e06-207c93452332@web.de> <7c14756e-29f9-b475-f5f5-597acb8cea98@web.de>
From:   =?UTF-8?B?0JLQuNGC0LDQu9C40Lkg0JjRidC10L3QutC+?= <betalb@gmail.com>
Date:   Fri, 16 Sep 2016 09:51:30 +0300
Message-ID: <CANYoZJnB81rEGNAjGj6jOscmdSW_niSy6jRP6acw2xB4ssX8xA@mail.gmail.com>
Subject: Re: Gitattributes file is not respected when switching between branches
To:     =?UTF-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Sorry for delay.

".gitattributes" indeed is not present in "master", but this is intentional=
ly
It is placed only in following 2 branches:
feature-branch
unix-feature-branch

This is how flow looks on windows
$ git --version
git version 2.9.3.windows.1

vitalii.ishchenko@DESKTOP-9TC9UPB MINGW64 /c/work/repos/gitattributes (mast=
er)
$ git ls-files --eol
i/lf    w/crlf  attr/                   testfile-crlf.txt

vitalii.ishchenko@DESKTOP-9TC9UPB MINGW64 /c/work/repos/gitattributes (mast=
er)
$ git checkout feature-branch
Switched to branch 'feature-branch'
Your branch is up-to-date with 'origin/feature-branch'.

vitalii.ishchenko@DESKTOP-9TC9UPB MINGW64 /c/work/repos/gitattributes
(feature-branch)
$ git ls-files --eol
i/lf    w/lf    attr/text eol=3Dlf        .gitattributes
i/lf    w/crlf  attr/text eol=3Dlf        testfile-crlf.txt



On Mon, Sep 12, 2016 at 10:42 PM, Torsten B=C3=B6gershausen <tboegi@web.de>=
 wrote:
> On 12.09.16 21:35, Torsten B=C3=B6gershausen wrote:
>> On 12.09.16 14:55, =D0=92=D0=B8=D1=82=D0=B0=D0=BB=D0=B8=D0=B9 =D0=98=D1=
=89=D0=B5=D0=BD=D0=BA=D0=BE wrote:
>>> Good day
>>>
>>> I faced following issue with gitattributes file (at least eol setting)
>>> when was trying to force `lf` mode on windows.
>>>
>>> We have 2 branches: master & dev. With master set as HEAD in repository
>>>
>>> I've added `.gitattributes` with following content to `dev` branch
>>>
>>> ```
>>> * text eol=3Dlf
>>> ```
>>>
>>> Now when you clone this repo on other machine and checkout dev branch,
>>> eol setting is not respected.
>>> As a workaround you can rm all files except .git folder and do hard res=
et.
>>>
>>> Issue is reproducible on windows & unix versions. Test repo can be
>>> found on github
>>> https://github.com/betalb/gitattributes-issue
>>>
>>> master branch - one file without gitattributes
>>> feature-branch - .gitattributes added with eol=3Dlf
>>> unix-feature-branch - .gitattributes added with eol=3Dcrlf
>>>
>>> Thanks,
>>> Vitalii
>> Some more information may be needed, to help to debug.
>>
>> Which version of Git are you using ?
>> What does
>>
>> git ls-files --eol
>>
>> say ?
> Obs, All information was in the email.
>
> tb@xxx:/tmp/gitattributes-issue> git ls-files --eol
> i/lf    w/lf    attr/                   testfile-crlf.txt
> tb@xxx:/tmp/gitattributes-issue> ls -al
> total 8
> drwxr-xr-x   4 tb    wheel  136 Sep 12 21:38 .
> drwxrwxrwt  19 root  wheel  646 Sep 12 21:38 ..
> drwxr-xr-x  13 tb    wheel  442 Sep 12 21:38 .git
> -rw-r--r--   1 tb    wheel   60 Sep 12 21:38 testfile-crlf.txt
> tb@xxx:/tmp/gitattributes-issue>
>
> Could it be that you didn't commit the file ".gitattributes" ?
> This could help:
> git add .gitattributes && git commit -m "Add .gitattributes"
>
>
>
>
>
>
>
