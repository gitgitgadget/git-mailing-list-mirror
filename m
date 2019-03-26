Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A325920248
	for <e@80x24.org>; Tue, 26 Mar 2019 22:06:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732079AbfCZWGt (ORCPT <rfc822;e@80x24.org>);
        Tue, 26 Mar 2019 18:06:49 -0400
Received: from mail-vk1-f175.google.com ([209.85.221.175]:43879 "EHLO
        mail-vk1-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731491AbfCZWGt (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 26 Mar 2019 18:06:49 -0400
Received: by mail-vk1-f175.google.com with SMTP id e131so3189854vkf.10
        for <git@vger.kernel.org>; Tue, 26 Mar 2019 15:06:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=74TASdII467UzMAB+9AS6K54fHriju+ivTWyUvWtnk4=;
        b=QgS3stvGuXo4QNaVa+npCVbrOrNZbuPd7WUn/VUytnxiTDS7thEW+sK0U/OXFufirO
         BLDvM/b2mo1kiBWa+uukp5+nVVsxfTfUjn5o/MfUCqPe59Pku6xGjLq/9JzFgIcwolK9
         7Ptxmgvx8/+eYDNQgF9uCXRzUNxPBiGQhKo6bXpRWKiMVRVBn90aOS4jS1pJregRauxT
         Uyg5Y0ZPYvlavrvJeXNz19iIi8xzjsHZzuLvPmAeL2YSv4V4sN64ftie5CMI5WBSDy7l
         aiDaBqmWqA2S+bzNiie8gYA1wEOdvk+wYx1Ksp0YB0gOE8WGCPPwBiALhufHqjLAQiQO
         uDxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=74TASdII467UzMAB+9AS6K54fHriju+ivTWyUvWtnk4=;
        b=OkLS3r46e2I5s1m0CC0ypChtPC/reEyUCgTLQOA2FY8PRe9/IEs/wbBn0igNuEtb/x
         QbwP+H2a4JAbOVepnnF4dxHRXycORI4hMnWBTk6nMbc3Oh3SgG2bP4IN4SQ1UycQ66K6
         dAE19BVfMHrxjRhMLQpbc/HED4RE+b6IAsnTzaLxtmMqx/XE3zJZ4zC9iqRst6kHSafX
         +MnaoIc1E56K299h7A6T/iccRIRel2lQWym871o2A6nBDTL3bufAHjsQEPlG2otWq9At
         oMO7Ip9LwbbFXjFS0VWDmSWoRL1olrbThyjf5hRVi0k8bKlomrvZO6sIy3/CKMCAYYoZ
         Rt1A==
X-Gm-Message-State: APjAAAX8awwQiN8aFB+uCRzZwM5rI3aCoUwMedtEL0mP2zBaFW8BP3+S
        dBlpP2hZu1A+/MIzFJOeMpgU2141++buGOHbXCxiXA==
X-Google-Smtp-Source: APXvYqxY8Q61U0JVF3bNxE6m798DWSKAxgZdI5fzeyZbvv1m9plJSLcdjcOKUbOhNveDS3ob6KI5TwCBEGiWLUSyt70=
X-Received: by 2002:a1f:32c7:: with SMTP id y190mr15038161vky.15.1553638007790;
 Tue, 26 Mar 2019 15:06:47 -0700 (PDT)
MIME-Version: 1.0
References: <38B8E527-2338-485E-8840-29121F259687@m-mooga.com>
In-Reply-To: <38B8E527-2338-485E-8840-29121F259687@m-mooga.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Tue, 26 Mar 2019 15:06:36 -0700
Message-ID: <CABPp-BHwUoqk79Kf=ynna5x+mCJyOLz66v6pDieyEeM7YCRS+g@mail.gmail.com>
Subject: Re: [GSoC] microporject test_path_is_*
To:     Mooga <contact@m-mooga.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

On Tue, Mar 26, 2019 at 2:10 PM Mooga <contact@m-mooga.com> wrote:
>
> Hi,
> I am still a bit confused about the task itself
>
> it=E2=80=99s just text replacing for example:
> t1400-update-ref.sh , line 194 -> `test_path_is_missing`  has to be =E2=
=80=98test_path_is_file=E2=80=99
>
> Thanks

There are several places in the code that use test with -e or -f or -d
(or -h or...) in order to check for the presence of a
file/directory/symlink/etc.  For example,
   test -f path1/file1
This could be made more clear and produce nicer error messages if it
were instead
   test_path_is_file path1/file1

There are likewise several that use one of
   ! test -e path/to/filename
or
   ! test -f path/to/filename
or
  test ! -f path/to/filename
which could be replaced by
  test_path_is_missing path/to/filename

This GSoC microproject is just about picking one testfile that has
some of these constructs, and fixing the cases found within that
testfile.
