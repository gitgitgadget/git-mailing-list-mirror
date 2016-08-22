Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5A2891F859
	for <e@80x24.org>; Mon, 22 Aug 2016 14:05:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751902AbcHVOFn (ORCPT <rfc822;e@80x24.org>);
        Mon, 22 Aug 2016 10:05:43 -0400
Received: from mail-it0-f47.google.com ([209.85.214.47]:37328 "EHLO
        mail-it0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755529AbcHVOFl (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 Aug 2016 10:05:41 -0400
Received: by mail-it0-f47.google.com with SMTP id f6so83096612ith.0
        for <git@vger.kernel.org>; Mon, 22 Aug 2016 07:05:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=WfwKaoHJuA8i6KlD51zqyhCRpfPd4Qai2+W07Za2Uc4=;
        b=XA+bivN8FA/67/1rQBjtxRI0C14MQL17YpxzNrfL/s52VDYqxup4Bmac9DYADyG78b
         QavfXLH6TbC8PI5eOMbfKqyt3Z/d9cOUscwiA/IeWZDYeVNr+rRRnBanoY1ZRLT2hojZ
         iDBb9VX4Ws9ur1OBULNk1hs3duaqbdDU4q45JRA8166o4zB98ecNBNdJIHCAh40KbWxT
         07vKb2Miz7fKmZlo6HLw6wui3I4Ks3sH1Hk+6W4CKsHt/A8jHhOU75E3tPBykAEpY1VZ
         h7+dJeOhlTNII7qE0RRF1W015Wn5Ca3bRa3MaqJljpMfgl0qMSwYIKdtf1/tqw+lzWx+
         9FHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=WfwKaoHJuA8i6KlD51zqyhCRpfPd4Qai2+W07Za2Uc4=;
        b=SnmtXDnP4jNiTd8Za8g7d5IA7CHOfL4mIRvqRehHNZ6eR6R9Tt1BgSNMDzuUinEuod
         +z8uGSX7UtNdcoNIX/FTJ7MoCZoft9xOI5n6Rh+CN4Zld/wKkrjCTsSDZ4zc/9ppcDgM
         so0fgvNofm4PIm7ozNTc1QWzY+dCe90Xv/XCnpeH3sOeRjHkdiwACd0OzZYPq0YSnN5v
         8VO3Bk7TPorgWsvKQoh+dkN01MtVwo5cqBjYbVj1u5DaviNgD9e2hfdxWcwpXWpiEXqq
         k7ZzhMs5OiZMo2fNMFCunOSIaWvI6QxJpmbKYMxtcHjOoSt7S3+8SBw7xooy3lXXPfgH
         sfnA==
X-Gm-Message-State: AEkooutbDdKzJjG6BSUJZrJjZKtkTJl8lopeEpYITIXMR7j3e7IMA4B+ttVVbV9YxD8BoUynySXszLFBjNx40A==
X-Received: by 10.36.112.11 with SMTP id f11mr21530023itc.57.1471874724023;
 Mon, 22 Aug 2016 07:05:24 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.64.125.199 with HTTP; Mon, 22 Aug 2016 07:04:53 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.20.1608181022250.4924@virtualbox>
References: <alpine.DEB.2.20.1608131214070.4924@virtualbox>
 <xmqqshu8u0px.fsf@gitster.mtv.corp.google.com> <alpine.DEB.2.20.1608171507530.4924@virtualbox>
 <xmqqeg5nbehc.fsf@gitster.mtv.corp.google.com> <alpine.DEB.2.20.1608181022250.4924@virtualbox>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Mon, 22 Aug 2016 21:04:53 +0700
Message-ID: <CACsJy8A3tkMY-iLPCDj9sqB4HpAK_cxsUu5Z7fsGcCQEORyxUg@mail.gmail.com>
Subject: Re: [git-for-windows] Re: [ANNOUNCE] Git for Windows 2.9.3
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Junio C Hamano <gitster@pobox.com>,
        git-for-windows <git-for-windows@googlegroups.com>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Aug 18, 2016 at 3:37 PM, Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
> Hi Junio,
>
> On Wed, 17 Aug 2016, Junio C Hamano wrote:
>
>> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
>>
>> >> And then your "git cat-file" patch can be upstreamed with the option
>> >> renamed to (or with an additional synonym) "--filters", which would make
>> >> things consistent.
>> >
>> > Right. I would like to ask for a `--smudge` synonym nevertheless, just
>> > because I already use this. On the other hand, it is early enough to tell
>> > everybody who knows about this feature to change their invocation (anybody
>> > who would know about `--smudge` would be in that 1% of users that have
>> > read the release notes, so most likely would read the next release notes,
>> > too).
>>
>> It is OK if it were your private edition, but you end up hurting
>> your users if you need to redo the feature differently.
>
> Unfortunately, this is the situation of Git for Windows from its
> beginning: there has not been a single time that Git for Windows could
> live with unpatched upstream Git's source code.
>
> Business as usual, though.

Bug fixes is one thing, features is completely different. Should we
just acknowledge git-for-windows as a long-living fork and rename it
to something else? Because if somebody comes here with a "git" problem
on Windows, I would look at git.git source code, not gfw. I'd rather
recognize it a special fork (by name) right away and ignore. You could
have the same policy distros have: all bugs go to distros (i.e. gfw),
some bugs may be forwarded upstream (git.git).
-- 
Duy
