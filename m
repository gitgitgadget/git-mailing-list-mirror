Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 36A6B2018F
	for <e@80x24.org>; Wed, 13 Jul 2016 17:43:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752242AbcGMRlS (ORCPT <rfc822;e@80x24.org>);
	Wed, 13 Jul 2016 13:41:18 -0400
Received: from mail-it0-f43.google.com ([209.85.214.43]:37790 "EHLO
	mail-it0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750912AbcGMRlQ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Jul 2016 13:41:16 -0400
Received: by mail-it0-f43.google.com with SMTP id f6so49725451ith.0
        for <git@vger.kernel.org>; Wed, 13 Jul 2016 10:41:15 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=ustx4e4V47Jjit3u52ousSqb5jjL0+sKqR0hKz0Vcgw=;
        b=hlJIcQg1svJ/HHzbPAkuHEBmEgjQpHc0kqGLcikugUKk3mLYaIbYtX+1wOIdvfDo2x
         SKLC6qLx57xeD0a81Y+vjmiE5xZ2SEiABt73yB5RuzlpN/kzisC+BSNS+rI/+YK+Q7AY
         3D0S9qJD2+BoC1qniX4tGPWLKFw4YQeMBUqn/i46EODZOwUhF5x6UUyJXSPPsc4Tvx/5
         xYNgh06YUd4JGk8emsLRVSvY0ILcgSXNY9IwvdQMNJMa5DNOQgiUg8AlCnFx6iBqx2Ld
         P/y71e7aOYyZWn7iPF1w0d4hyLnk5++bMmnbDa3XpoT1JHjo4W74KXTuppmk8ilZo1dy
         NfEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=ustx4e4V47Jjit3u52ousSqb5jjL0+sKqR0hKz0Vcgw=;
        b=bKaz4uuWgArunCSf43aHF431D7QLT39RtLJb7M7mhrHpR3JDFR6liCi/4AMZWjTVDi
         PX0dRiKPPUsUj72315QBJz9s1tVzIc4VVy9MPAKsY8PB+OeS1Pk+O0/3+dQKY43f5CBr
         1S5JFZ7J+5i9AmHxc3/0VhHHFQSYjb4zvq0RkNsNDRP18lqoKiUdRDmb6GT4bsQsnyi3
         /OwHOZaWBXrJdIu1bhgEejujj1CywD+FTzMB+BTwDndFIqDC4+3gOaT8mh2lQS51OpLt
         jph4oPxZGtcrqUNwMDLX+IvM2biWoGedRB8on/edERzZmcyGt990jaHavpnWMCN+RpyD
         f6hw==
X-Gm-Message-State: ALyK8tIUyXXXt2O4NzTwsXc262qEZRtkbU5CYLRPCfF8NPiNulN1GQ+4DPdWUKRvU0VjSSyjcE6oyrdk4nBnRg==
X-Received: by 10.36.33.197 with SMTP id e188mr6114397ita.42.1468431669924;
 Wed, 13 Jul 2016 10:41:09 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.64.225.235 with HTTP; Wed, 13 Jul 2016 10:40:40 -0700 (PDT)
In-Reply-To: <xmqqy4551nph.fsf@gitster.mtv.corp.google.com>
References: <xmqqy4551nph.fsf@gitster.mtv.corp.google.com>
From:	Duy Nguyen <pclouds@gmail.com>
Date:	Wed, 13 Jul 2016 19:40:40 +0200
Message-ID: <CACsJy8CVJr6-9CnyrOU4UoPPGu6Ovn_=-2YKeqC8Lp_rVnh5fg@mail.gmail.com>
Subject: Re: What's cooking in git.git (Jul 2016, #05; Wed, 13)
To:	Junio C Hamano <gitster@pobox.com>
Cc:	Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Wed, Jul 13, 2016 at 6:56 PM, Junio C Hamano <gitster@pobox.com> wrote:
> * nd/pack-ofs-4gb-limit (2016-07-13) 7 commits
>  - fsck: use streaming interface for large blobs in pack
>  - pack-objects: do not truncate result in-pack object size on 32-bit systems
>  - index-pack: correct "offset" type in unpack_entry_data()
>  - index-pack: report correct bad object offsets even if they are large
>  - index-pack: correct "len" type in unpack_data()
>  - sha1_file.c: use type off_t* for object_info->disk_sizep
>  - pack-objects: pass length to check_pack_crc() without truncation
>
>  "git pack-objects" and "git index-pack" mostly operate with off_t
>  when talking about the offset of objects in a packfile, but there
>  were a handful of places that used "unsigned long" to hold that
>  value, leading to an unintended truncation.

On the subject of truncation, there is something else I should note.
The field sd_size in struct stat_data is 32 bits, so large files will
overflow it too, regardless of platforms. I did not do anything
because I checked and double checked and was pretty sure we did not
use it for anything meaningful (as a file size). To us, it's just
another random number, like st_ino, that we check to detect if a file
has changed.

It's probably just an oversight (it comes from the very first "the
information manager from hell" commit). But it's not worth changing
index format now to extend it to 64 bits, I think. So it's ok, no
worry about it, but we should probably make clear that this is not
true file size, and don't anybody ever use it as such. Maybe rename it
to "size_hash" or something.
-- 
Duy
