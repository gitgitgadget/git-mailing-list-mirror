Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 05E941F4F8
	for <e@80x24.org>; Tue,  4 Oct 2016 11:27:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752585AbcJDL1C (ORCPT <rfc822;e@80x24.org>);
        Tue, 4 Oct 2016 07:27:02 -0400
Received: from mail-io0-f172.google.com ([209.85.223.172]:34735 "EHLO
        mail-io0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751977AbcJDL1C (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Oct 2016 07:27:02 -0400
Received: by mail-io0-f172.google.com with SMTP id r30so24500796ioi.1
        for <git@vger.kernel.org>; Tue, 04 Oct 2016 04:27:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=TdPVi1aOHD6Qxp7TSplP/aU+7ROiofKT0OnnXnx7sg8=;
        b=HCb5pSKE3tcoXYZVrr99Yq2ls7tXYyf0+hmfxkQg8+dfxgSnkK+J5rH0zSprnCsY6F
         huIqsX17sWZI189Tbr+KEh+7AwIpVLYeQLwTnRpKBt7uqywucwZ0BW3+b4Gfefp9gkmO
         joZaYrHPGh25/5+kMA3aEtm16L5tT7CtKWwRoWlH5bJpZBOouYltdPH5RvuubOzGN7wR
         7NbgVAK5TLjpwCFmM+ATM7gqUJUj/hj76dqnGRaKkQzl420ev6zuJxiZZ3nYCjk/SMBG
         W1SDTQGO+LbUPh5QXAuKCtf7dDdskGrsR3GsC7gbU/KdohiX0/jvBEqiexqYgB5xq1vj
         2mSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=TdPVi1aOHD6Qxp7TSplP/aU+7ROiofKT0OnnXnx7sg8=;
        b=cccW1RzLKiSkNRprnz/glvBTmmypClUVDZk9QAc4OEtarMm1Qj7elXlgtcZKRetZZl
         loExn4W39STs2SRyZE7dPB/x0R2q//xGJPz9mJy/GX4T7E9FiLU2Daq6B6kvuR+SEz/u
         y76X9XpJdIGhDOkE93I52xYHS8HpQL0dFmm1dZw0etlcDIsMivw1PNPc5q3xgrZEAlT9
         iTQrtDVxQcXC6OS9Eh06vAvcxmD+bNeTYjpGAGQRWK86NG7FjMcK5quYDC7f2mmp3NSQ
         BVj54K789tetzDc1Mhprp9TJU5ZZSJTOpXNCjE8An0bmWfqLRrPai33rI1uRF9n7/XEX
         R/wQ==
X-Gm-Message-State: AA6/9RkaSa0+78doslXiIUtoBvlJ0qH15LpplpbnHWaJha4CuDRxTIOkVA/dXI9kYY3i+G6I6xOvSbs4Jup5jQ==
X-Received: by 10.107.57.139 with SMTP id g133mr4262167ioa.176.1475580421229;
 Tue, 04 Oct 2016 04:27:01 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.64.21.6 with HTTP; Tue, 4 Oct 2016 04:26:30 -0700 (PDT)
In-Reply-To: <248A6E81-8D5C-4183-9756-51A0D5193E3E@gmail.com>
References: <248A6E81-8D5C-4183-9756-51A0D5193E3E@gmail.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Tue, 4 Oct 2016 18:26:30 +0700
Message-ID: <CACsJy8CSHepObhcSYHOYgY0oev6wEeNgpy+x1_c_QhLtLA8Xzg@mail.gmail.com>
Subject: Re: Merge conflicts in .gitattributes can cause trouble
To:     Lars Schneider <larsxschneider@gmail.com>
Cc:     git <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        me@ttaylorr.com
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Oct 4, 2016 at 5:19 PM, Lars Schneider <larsxschneider@gmail.com> wrote:
> Hi,
>
>
> If there is a conflict in the .gitattributes during a merge then it looks
> like as if the attributes are not applied (which kind of makes sense as Git
> would not know what to do). As a result Git can treat e.g. binary files
> as text and they can end up with changed line endings in the working tree.
> After resolving the conflict in .gitattributes all files would be marked
> as binary, again, and the user can easily commit the wrongly changed line
> endings.
>
> Consider this script on Windows:
>
> $ git init .
> $ touch first.commit
> $ git add .
> $ git commit -m "first commit"
>
> $ git checkout -b branch
> $ printf "*.bin binary\n" >> .gitattributes
> $ git add .
> $ git commit -m "tracking *.bin files"
>
> $ git checkout master
> $ printf "binary\ndata\n" > file.dat # <-- Unix line ending!
> $ printf "*.dat binary\n" >> .gitattributes # <-- Tell Git to keep Unix line ending!
> $ git add .
> $ git commit -m "tracking *.dat files"
> $ git cat-file -p :file.dat | od -c
> 0000000   b   i   n   a   r   y  \n   d   a   t   a  \n
>                                 ^^^^                ^^^^  <-- Correct!
> $ git checkout branch
> $ git merge master # <-- Causes merge conflict!
> $ printf "*.bin binary\n*.dat binary\n" > .gitattributes # <-- Fix merge conflict!
> $ git add .
> $ git commit -m "merged"
> $ git cat-file -p :file.dat | od -c
> 0000000   b   i   n   a   r   y  \r  \n   d   a   t   a  \r  \n
>                                 ^^^^^^^^                ^^^^^^^^  <-- Wrong!
>
> Possible solutions:
>
> 1. We could print an appropriate warning if we detect a merge conflict
>    in .gitattributes

This is good regardless, to encourage people to resolve conflicts in
.gitattributes first. A good place for this warning may be "git
status"?

> 2. We could disable all line ending conversions in case of a merge conflict
>    (I am not exactly sure about all the implications, though)
>
> 3. We could salvage what we could of the .gitattributes file,
>    perhaps by using the version from HEAD (or more likely, the ours stage of
>    the index) -- suggested by Peff on the related GitHub issue mentioned below

We already have code to fall back to index version in some cases,
adding "fall back on merge conflicts" (and probably updating the index
lookup code too because it looks for stage 0 now) sounds reasonable
(especially with the warning in #1).

BTW whoever fixes this probably should do the same for .gitignore files.
-- 
Duy
