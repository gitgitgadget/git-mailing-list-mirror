Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 98E142022D
	for <e@80x24.org>; Fri,  4 Nov 2016 19:20:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751500AbcKDTUR (ORCPT <rfc822;e@80x24.org>);
        Fri, 4 Nov 2016 15:20:17 -0400
Received: from mail-yw0-f173.google.com ([209.85.161.173]:34749 "EHLO
        mail-yw0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750879AbcKDTUQ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 Nov 2016 15:20:16 -0400
Received: by mail-yw0-f173.google.com with SMTP id t125so100374483ywc.1
        for <git@vger.kernel.org>; Fri, 04 Nov 2016 12:20:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=V3M8yZohnzORr69LlD6RQw++/QDRwLjCXFHRmzBCv5M=;
        b=nAHPE2jBzjhIGuOmN/hw2XALbEr5Rb80nr9znL29smbvDYg5a0AHIdq6u+yS7hQXZ+
         o92xr9kSsZU6frDG8zsNmhu53yLT5ft3vM1yo8TFBSJc1pWKgcqVnaXkztUKvIlUQ9r1
         VUqKCWf+imZoIO5kbR/FTq28+D3yMNKOS+CyPOyuWAGROe0xB2k/BPJV3LH3Gkzg1nbF
         d5Me6yDATplFl3/VXlAqIOdNF0b22OrlfnjXY3LyZ57gJuvJoX+d+d5h24ZU0QahYz3r
         96/vEUyXlpuIjTvYk8/Wg18sTBptfJ3U/IJ/+w9Vj/PzrdcLSo6TdDnOSlfVINiGZxcq
         f7tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=V3M8yZohnzORr69LlD6RQw++/QDRwLjCXFHRmzBCv5M=;
        b=mvymCtENYTsiAPVGY3hfVHp2MVEA6Z4Ms0x8J1/whSCHFPVmo9nnC+MhUO+QVHVD3F
         VNF0nDpeDOkl8xj0Uhuxo0R0LKqdwaf/kMNxw4SJCoPN8bhst13N+kubz0X0xvxRNoFa
         hAbtsRUeSRiDXOsgetbLkNwqdyrPBwGpvSW91FLrxgi7yah8r7AITO84iddVEfFYC59+
         DDunFgQS4gjdcD1sTNz4rIh+34fZtewavdXHN9GyIzoyDRIZhLOvT83IilpsD1AeI9H6
         D+5PidEIOLJAdfWPn2kl01f+8bPy1MhnfRpzwxShmxaCyArT0N76FRUA0djS4c50Ant9
         bXKQ==
X-Gm-Message-State: ABUngveoEnky1Nxf8rgs84Sp5XnV+BgphqBeXTkVaw3vCNXz/SgMkm8pNjBE1GkFONWkQnyY2bRfBkKYlOeutg==
X-Received: by 10.13.231.131 with SMTP id q125mr4758383ywe.122.1478287215997;
 Fri, 04 Nov 2016 12:20:15 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.37.33.132 with HTTP; Fri, 4 Nov 2016 12:19:55 -0700 (PDT)
In-Reply-To: <xmqqa8dfdt6y.fsf@gitster.mtv.corp.google.com>
References: <xmqqa8dfdt6y.fsf@gitster.mtv.corp.google.com>
From:   Jacob Keller <jacob.keller@gmail.com>
Date:   Fri, 4 Nov 2016 12:19:55 -0700
Message-ID: <CA+P7+xq0LLFBJRNNvCMQ4QR7XBg9H7NSsifiqOYqr+PUBqYRGQ@mail.gmail.com>
Subject: Re: Regarding "git log" on "git series" metadata
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Josh Triplett <josh@joshtriplett.org>,
        Git mailing list <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Nov 4, 2016 at 10:57 AM, Junio C Hamano <gitster@pobox.com> wrote:
> I think this is backwards.  The root cause of the issue you have
> with "gitk" is because you added something that is *NOT* a parent to
> your commit.  We shouldn't have to add a mechanism to filter
> something that shouldn't have been added there in the first place.
>
> I am wondering if an alternative approach would work better.
>
> Imagine we invent a new tree entry type, "gitref", that is similar
> to "gitlink" in that it can record a commit object name in a tree,
> but unlike "gitlink" it does imply reachability.  And you do not add
> phony parents to your commit object.  A tree that has "gitref"s in
> it is about annotating the commits in the same repository (e.g. the
> tree references two commits, "base" and "tip", to point into a slice
> of the main history).  And it is perfectly sensible for such a
> pointer to imply reachability---after all it serves different
> purposes from "gitlink".
>

I agree with your assessment here. The main difficulty in implementing
gitrefs is to ensure that they actually do get picked up by
reachability checks to prevent dropping commits. I'm not sure how easy
this is, but I would much rather we go this route rather than
continuing along with the hack. This seems like the ideal solution,
since it solves the entire problem and doesn't need more hacks bolted
on.

It would of course mean some work for people who previously used git
series as you would want to re-write the commits to drop the parent
links and become gitrefs instead of gitlinks. However, this can
(probably?) be solved by some sort of use of the filter-branch code.

I don't think you've hit upon any trivially obvious unworkable things.
It is probably somewhat complex to make the reachability checks detect
in-tree gitrefs but I don't think it would be impossible.

Thanks,
Jake
