Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4CFD11FCC7
	for <e@80x24.org>; Wed,  8 Feb 2017 10:53:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752848AbdBHKxG (ORCPT <rfc822;e@80x24.org>);
        Wed, 8 Feb 2017 05:53:06 -0500
Received: from mail-it0-f45.google.com ([209.85.214.45]:37073 "EHLO
        mail-it0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754288AbdBHKvy (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Feb 2017 05:51:54 -0500
Received: by mail-it0-f45.google.com with SMTP id r185so100299477ita.0
        for <git@vger.kernel.org>; Wed, 08 Feb 2017 02:50:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Nvpi+kDFQdOqX9jWQx8+bQ/Ja8HFp8D7Ry6Nb9kkqzg=;
        b=lHZ6yc9YEAvPsN+W/xWO7C5Na3CXzg11AQDvDL7DFfj9hVsqvsnEpYcBFHTU4ahshn
         VYwZ6EWXNdrZ/udqMAwFTHBDg67gzCv9MOfmNq6hQ919qnNqhwoCrrHMWSrrAXFO+ui4
         l0+eBkelFXv9cRMACYiBbhb5RIMUuL+GoOEQFiWA0OlNN1vA/jd234PuXxA2FwIPJL1x
         GycatSTtoGEVIHyh+ieCaYFxwwHDlrH8m+djxV0BD60kzNGYTH0z4D9LS1+UCFoPgi2g
         1rG9EkOE+fnvLM7pKSZmiALT7QoRbAE06EsIXkVpGiSRZNrote842XnIvfmJOjI1+saC
         torw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Nvpi+kDFQdOqX9jWQx8+bQ/Ja8HFp8D7Ry6Nb9kkqzg=;
        b=hYbnht3LJo2Inal9b5+dwwO+Md/QHD61bT860zrcPXweeG8Rxdk7rlGt789goroHXP
         GC71Lf0JhlQOR4LlOxY0xluxfi8BAhy8o80p85qdStnuhBkNhjFcVx6UBeS+GplGWydo
         KZfJrsbYcHIad34pD5Ae/tpnQgGhOkK93HXktOVuytTbDcJs6J2vdczwCG+FGt0NitL6
         zISq2holO7TcZ+/X4bt00qvGunuTSi/RH389LmfkAQdByz90EjnoXRk6uv0dx2idR15o
         USbP0+Bly0kVmZMdCtM1NsSVkFJ8M6HB+BQoCYPHELZxqsID+GgOnDX5reNJjygaf1PX
         cfPg==
X-Gm-Message-State: AIkVDXIQhaaa9Jx+I1yMe4eIVeKCwiUeGIriRFAgi97QEcD/hfaCA96IqB8hKRKdf3PNLblYWlrKWmllcwRbeA==
X-Received: by 10.36.3.73 with SMTP id e70mr14412462ite.14.1486550540238; Wed,
 08 Feb 2017 02:42:20 -0800 (PST)
MIME-Version: 1.0
Received: by 10.107.12.223 with HTTP; Wed, 8 Feb 2017 02:42:19 -0800 (PST)
In-Reply-To: <20170207184437.c6uuuxcmhi434vbc@gmail.com>
References: <CAEXhnECi3LvSA92dSjL5PZ1Lx9p1PWELS04nmfJW=8K9o4T-0Q@mail.gmail.com>
 <CAJZjrdU3toam4tDwXBu1Q3UAZm-kML3CzMrsMoJ_2jsGJ3vWrQ@mail.gmail.com> <20170207184437.c6uuuxcmhi434vbc@gmail.com>
From:   Stavros Liaskos <st.liaskos@gmail.com>
Date:   Wed, 8 Feb 2017 11:42:19 +0100
Message-ID: <CAEXhnEBaH39qavUZRNcOp0BDgqADrtOmamE_DH-Ch5tcH=hADA@mail.gmail.com>
Subject: Re: subtree merging fails
To:     David Aguilar <davvid@gmail.com>
Cc:     Samuel Lijin <sxlijin@gmail.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

@Samuel Lijin
I tried now and I get:
"merge: branch_name=E2=80=A8- not something we can merge".
Maybe that is something easy to fix but currently I am using a
workaround script so I am not putting any more effort at this at the
moment.

@David Aguilar
That's true but the trailing slash is already there. This commands
looks promising. An update would be GREAT!

FYI that's the script I am using to address this problem:

#!/bin/bash

function initial {
  if git remote | grep -q lisa_remote
  then
    echo "Subtree delete & update"
    git checkout lisa_branch
    git pull
    git checkout master
    git merge --squash -s subtree --no-commit lisa_branch
    git merge --squash --allow-unrelated-histories -s subtree
--no-commit lisa_branch
  else
    echo "Add subtree"
    git remote add lisa_remote git@xxxxxxxx:lisa/lisa.git
    git fetch lisa_remote
    git checkout -b lisa_branch lisa_remote/master
    git checkout master
    git read-tree --prefix=3DlisaSubTree/ -u lisa_branch
    gitrm
    git rm --cached -r lisaSubTree/.gitignore
    git rm --cached -r lisaSubTree/*
  fi
}
initial



On Tue, Feb 7, 2017 at 7:44 PM, David Aguilar <davvid@gmail.com> wrote:
> On Tue, Feb 07, 2017 at 08:59:06AM -0600, Samuel Lijin wrote:
>> Have you tried using (without -s subtree) -X subtree=3Dpath/to/add/subtr=
ee/at?
>>
>> From the man page:
>>
>>           subtree[=3D<path>]
>>                This option is a more advanced form of subtree
>> strategy, where the strategy
>>                makes a guess on how two trees must be shifted to match
>> with each other when
>>                merging. Instead, the specified path is prefixed (or
>> stripped from the
>>                beginning) to make the shape of two trees to match.
>
> I'm not 100% certain, but it's highly likely that the subtree=3D<prefix>
> argument needs to include a trailing slash "/" in the prefix,
> otherwise files will be named e.g. "fooREADME" instead of
> "foo/README" when prefix=3Dfoo.
>
> These days I would steer users towards the "git-subtree" command in
> contrib/ so that users don't need to deal with these details.  It
> handles all of this stuff for you.
>
> https://github.com/git/git/blob/master/contrib/subtree/git-subtree.txt
>
> https://github.com/git/git/tree/master/contrib/subtree
>
> Updating the progit book to also mention git-subtree, in addition to the
> low-level methods, would probably be a good user-centric change.
> --
> David
