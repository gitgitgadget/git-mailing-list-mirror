Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AB86F20248
	for <e@80x24.org>; Mon, 11 Mar 2019 19:34:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727891AbfCKTeP (ORCPT <rfc822;e@80x24.org>);
        Mon, 11 Mar 2019 15:34:15 -0400
Received: from mail-oi1-f193.google.com ([209.85.167.193]:39238 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727773AbfCKTeP (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 11 Mar 2019 15:34:15 -0400
Received: by mail-oi1-f193.google.com with SMTP id b4so76284oif.6
        for <git@vger.kernel.org>; Mon, 11 Mar 2019 12:34:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=C+lPRr1ki8M/KI3++mu0PopHNgApRc5VwDXyIKTPxek=;
        b=qI5CcikuXndng1xqLYmIC8k7E3mbQxijfS+b24oGNzBKdXN1/lpFselcFN0Wmluc4K
         9wmXNmHbDsjFuYIRN3kqUI4DAq3pY4qwD2QAyDPpRoIG7Muw8aEL8gKeNbJwnQEwwyid
         4Pwc3R8oWeRbl0yCnrmDqp5RK3dobMLHRohVMDarhKVMhHsHcpp4Q+sN/fD2JIj6vbuY
         M2TfR/RtvcLNbLGDGGHho+Q7F0bh0rdNAW1hI0Fn1TD2FWPWp/Z7EGVvQUPZcn5HDINq
         jXPHitEA6waGqwtQhzdZtfCzOwnVcaf6JSsF2c+lQiyoy1pIHPOvKJvpI0ACXAHeAscc
         wWRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=C+lPRr1ki8M/KI3++mu0PopHNgApRc5VwDXyIKTPxek=;
        b=DaGgjTAkSdsslngsLlaH9kM1h5hA3nTLNGaLWjVZ+orXhatPzgAg+yp5wUJe1DF03r
         AkTWu+/NvFDMXBGG3vuFgrl7RbvuLPY/I+CPTBI34llPzNYnXUGUkIylLmZJG6J42AZ1
         B/AlfaQOyohs1ezFSfpH2bfXmAQFJZlqIQFcyJa9Lft/PhagdHKeeahON5tkErXrneOn
         9W1WzHB49ej2iNNnnRFXES4OJOj6BTqNUQL+9uEhCU62xG+WgQg6iQgMMs3Y/cRGebR9
         HdYyiTH4HN7zrOXmTRENRjnQpfRxK57aJMB/ec3zoZclajyks2AUixmNBr02cCZURbLO
         j5cw==
X-Gm-Message-State: APjAAAXOFyGMWwsGIqNFgt9uGSBv7zFps4UgXogp3TDgkp+coaPSdfnK
        yN3aek4LFWgQkghRY0nnilWyx4e6m58pwnc+H3ff1RJM
X-Google-Smtp-Source: APXvYqy6wq/uPU1sHKxlZnpyotk9XgQTpjkIoFVXw0rbOI+mykkOH3eV1M/VYNOn7vFx4jpd76TzAc2B9Q7ZnncTQmo=
X-Received: by 2002:aca:cf93:: with SMTP id f141mr294657oig.130.1552332854177;
 Mon, 11 Mar 2019 12:34:14 -0700 (PDT)
MIME-Version: 1.0
References: <CA+dzEBkkbQj0rCjvPfcET2Uvt6fP_v+wQE52ZkAND2Mps08SNQ@mail.gmail.com>
 <10972e0e-7fe1-437f-efe6-cff82a1205e0@kdbg.org> <20190311175519.6lbppv5u44w2u4sj@tb-raspi4>
 <CA+dzEBm7fdrncnd_7tDu-q047qxt3CsHVQna3GRMagJetisQeA@mail.gmail.com>
In-Reply-To: <CA+dzEBm7fdrncnd_7tDu-q047qxt3CsHVQna3GRMagJetisQeA@mail.gmail.com>
From:   Jack Adrian Zappa <adrianh.bsc@gmail.com>
Date:   Mon, 11 Mar 2019 15:34:03 -0400
Message-ID: <CAKepmajVk27nHAzbuHitowyo11HvqSNfwfcg3kOp9DXDLe8FOA@mail.gmail.com>
Subject: Re: `git add <<windows 8.3 path to file inside repo>>` results in
 "fatal: ... is outside repository"
To:     Anthony Sottile <asottile@umich.edu>
Cc:     =?UTF-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>,
        Johannes Sixt <j6t@kdbg.org>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hey Anthony,

Are you sure that you have 8.3 active on the partition you are using?
IIRC, It is not on by default anymore.  To see, go to a cmd line and
type "dir /x".  If there are any files that exceed the 8.3 format, it
will show those files with two names, the 8.3 name and the long name.

If it is off and you want to turn it on, see
https://support.microsoft.com/en-ca/help/121007/how-to-disable-8-3-file-nam=
e-creation-on-ntfs-partitions.
and https://docs.microsoft.com/en-us/previous-versions/windows/it-pro/windo=
ws-server-2012-R2-and-2012/ff621566(v=3Dws.11)
for more information.


A

On Mon, Mar 11, 2019 at 2:18 PM Anthony Sottile <asottile@umich.edu> wrote:
>
> On Mon, Mar 11, 2019 at 10:55 AM Torsten B=C3=B6gershausen <tboegi@web.de=
> wrote:
> >
> > On Mon, Mar 11, 2019 at 06:48:11PM +0100, Johannes Sixt wrote:
> > > Am 10.03.19 um 23:41 schrieb Anthony Sottile:
> > > > git init longname-repo
> > > > cd longname-repo
> > > > touch f
> > > > git add ..\longna~1\f
> > > >
> > > ...
> > > >
> > > > C:\Users\Anthony\AppData\Local\Temp\t\pre-commit-hooks\longname-rep=
o>git
> > > > add ..\longna~1\f
> > > > fatal: ..\longna~1\f: '..\longna~1\f' is outside repository
> > >
> > > This has nothing to do with long vs. short path names. It would repor=
t
> > > the same error when you say
> > >
> > >   git add ..\longname-repo\f
> > >
> > > -- Hannes
> >
> > You can probably do another test:
> >
> >  mkdir longname-rexxx
> >  git init longname-repo
> >  cd longname-repo
> >  touch f
> >  git add ..\longna~1\f
> >
> > And now nobody knows for shure if "longna~1"
> > is longname-rexxx or longname-repo
> >
> > It may happen that it is longname-rep at this point in time,
> > at your machine.
> > It may happen that it is a complete different directory on another mach=
ine,
> > or even on your machine.
> > For that reason, to avoid that someone tampers data outside a repo,
> > "../" (or ..\ under windows) is not accepted by Git.
>
> the same can be said for `git add /full/path/to/repo/file` as any of
> those components could be symlinks.
>
> However that is currently allowed
>
> Note also I've updated my report, it isn't about relative paths any
> more but about full paths with 8.3 paths
>
> Note that 8.3 filanames do canonically disambiguate themselves, the
> number after the tilde is used to refer to filenames alphabetically
>
> This report is very similar to the change that happened to
> disambiguate drive letters in
> https://github.com/git/git/commit/d8727b3687c1d249e84be71a581cc1fb0581336=
a
>
>
> > Oops, I misreported while trying to minimize my reproduction
> >
> > Here's an accurate bug report
> >
> > git properly handles this:
> >
> >     git add C:\full\path\to\longname-repo\file
> >
> > When the root of the repo root is `C:\full\path\to\longname-repo`
> >
> > But it does not handle the equivalent 8.3 path:
> >
> >     git add C:\full\path\to\longna~1\file
