Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8E4AA1F6DC
	for <e@80x24.org>; Thu, 26 Jan 2017 00:42:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752162AbdAZAmA (ORCPT <rfc822;e@80x24.org>);
        Wed, 25 Jan 2017 19:42:00 -0500
Received: from mail-lf0-f50.google.com ([209.85.215.50]:35569 "EHLO
        mail-lf0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751556AbdAZAl7 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 Jan 2017 19:41:59 -0500
Received: by mail-lf0-f50.google.com with SMTP id n124so137637747lfd.2
        for <git@vger.kernel.org>; Wed, 25 Jan 2017 16:41:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=Rgk+Jkia/8Bxvu/KTTJwAazfS18WzmdWLY5c7V7hEqk=;
        b=Nq0yZQNCh+CjwtGnwbxDnrU7B69p/WNpP+a1W8T/ZcRxr0KSqJxpVwdop5kZeL8R45
         p+JELH31prSjsC3LObsd2R7I77U1euogng5TU98Fiaqf9Ry/0W2lmYs2+s02gm5Buz0k
         Pp1R0EvtMm4kvGeqNyXCg4pxi4BlSY1jrxq504HerJCTdesGkVWxD0uubM8NOMOHnoaC
         DB9xu5l3B9xdWL8Bv1r+UDgvfCF6TJXHvcPvnSlQPDHm8uKaA16MRT2C+7S1ribfq9fd
         /OIr9mCIVV6hrKT/6B8XGfyR3qWD2mAxCA+ZxwiJYqfbAjV2Ne+degpy61v1YT8lYkmR
         5J+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=Rgk+Jkia/8Bxvu/KTTJwAazfS18WzmdWLY5c7V7hEqk=;
        b=kfMWwmLo8FPBrXs3h3AVkHkv7B6kKAkCaGSLmt2vFPnXYru1/eqfCzAIWDaIvqEswn
         +pkAjbS75VocBqkqRbvYGdOM4WlhOdTCP0pO9gvuis3WbhfRIQoUw+YJBlhx31h6p2Wy
         aCMFiNGhNyUFl6SBFkcOEXu2U68DpAQE++ia4i45/pDE+AKx9tbb02FT6Pqafn3wbukP
         minJ2Fsacpi7qxm6TSQPXw87QxLM012mUjcY8anHN+s4F8ZtwyjohN5hqGYAe8ETqiQk
         PDxEa8L65YmytFzM8MoMgi3xiLc/UzgQqxrJblL42dQxOUMerDBDjGzM6yNy/bX8633q
         hOxQ==
X-Gm-Message-State: AIkVDXLqn9b/NfMxZi1INGVgkifvcAjv+aGxgicOAgVw+oA8ULXiajpEi9BrlRfWdfKYkzwqVyoDSkd2A5v+Yg==
X-Received: by 10.25.74.72 with SMTP id x69mr50203lfa.66.1485391317885; Wed,
 25 Jan 2017 16:41:57 -0800 (PST)
MIME-Version: 1.0
Received: by 10.25.145.14 with HTTP; Wed, 25 Jan 2017 16:41:37 -0800 (PST)
In-Reply-To: <5889436A.8000707@comcast.net>
References: <58798686.5050401@comcast.net> <CA+P7+xoF8E55-XDnQT-GN1=hEwwq4pOsz7--P-SCy29C7ST3Hg@mail.gmail.com>
 <5880BB23.8030702@comcast.net> <xmqq37gezpz8.fsf@gitster.mtv.corp.google.com>
 <38ca43cb-2fc7-0448-352f-7d9413f815c5@gmail.com> <5889436A.8000707@comcast.net>
From:   Jacob Keller <jacob.keller@gmail.com>
Date:   Wed, 25 Jan 2017 16:41:37 -0800
Message-ID: <CA+P7+xrU-ZO981fKCogm3s1gkz6X-8+fcTS4TG0B=_gqAEwNxQ@mail.gmail.com>
Subject: Re: merge maintaining history
To:     "David J. Bakeman" <nakuru@comcast.net>
Cc:     =?UTF-8?Q?Jakub_Nar=C4=99bski?= <jnareb@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Git mailing list <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jan 25, 2017 at 4:31 PM, David J. Bakeman <nakuru@comcast.net> wrote:
> OK so what I've done so far is to clone the original then I added
> another remote connected to new repo.  Then I did git merge newrepo.  It
> did a bunch of stuff that flashed by really fast and then reported a
> conflict.  Now if I do a git st there are a bunch of files that seem to
> be already added to a commit and all the files with conflicts which it's
> says need to be fixed and added.
> I'm still learning git even after using it for several years.  I've
> never really seen this before.  So the already added files are the ones
> that git was able to merge mechanically?  If so can I diff those changes
> some way?  Would I have to un add (reset HEAD) all those files to see
> the diffs?  Would it have assumed that my changes are to be preferred?
>
> Thanks again for all the great help!

Try "git diff --cached" to show all the current differences saved in the index.

Thanks,
Jake
