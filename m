Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8B088203E1
	for <e@80x24.org>; Wed, 27 Jul 2016 18:02:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932214AbcG0SCu (ORCPT <rfc822;e@80x24.org>);
	Wed, 27 Jul 2016 14:02:50 -0400
Received: from mail-io0-f181.google.com ([209.85.223.181]:33665 "EHLO
	mail-io0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932195AbcG0SCt (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Jul 2016 14:02:49 -0400
Received: by mail-io0-f181.google.com with SMTP id 38so77623972iol.0
        for <git@vger.kernel.org>; Wed, 27 Jul 2016 11:02:49 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=JZSJkVdU7MUPzKo0M3mIvyAhFqFo8H7pkg+h1EM5xFw=;
        b=CNKfAFrV1RsPwydwlKkpk+nibt1/MVU97eTf/IIbSAw6smXAdon9SkRS3ZXxTJMlTg
         CurisGHza/cJXIF2mm/FA1rnGkAndIvpIIS4BsJjQ6GZcfFoh+bXGNvjrE2wjgolzsRv
         I73c6KkJZ67CEOu0/5BdR7rb+z/px1hYzg9Vs9DnNhXwFqUqZW584+YJX+tOa46U6emH
         Y9NFvFq5Lb8MNRFVLs3F1C2tD5oKChEzjYt7H2QxZ8kSmpGX7pqZ0G2+9TRwwtmjaHXG
         jsUhxj0l784KizWIdAKVfH4Ln6jXY7DED5dCxQauxwcwhm8Z1sEooy2t8gUyz5GrrUeH
         5SvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=JZSJkVdU7MUPzKo0M3mIvyAhFqFo8H7pkg+h1EM5xFw=;
        b=flOonHu6YBzftxR9aLtY08QYaZ8QhJ7npjyGp5XMRf/r3IiBsFZiqSmPgkb2n6s8lZ
         CI34CcKDGLBC3gwDWD0c5IagLmbe5oALTZbD2s0Zd/DT+IAMZRhy0zUOoBROAcol/k4g
         1sJKMkbJ9Uf8asNfloY/oq8JjrALus8bSEkdfMISHqSo6pimdhH6I8KPg9sMTZkPZw4Y
         NldFT+Z5hudS6sKEPU8O+1XzOAeN5qkNq82lx2yT52VT0v6EvoXmTt9980d9i7FXPDmz
         WP69bzk3fKoMN/7A/8RDBBoNTCiVhFu933QpMtosPuyJV4OOC+x6oQe8w5NDIQwEjgSf
         LDEQ==
X-Gm-Message-State: AEkoouvEr9fH6uAdCWeijvB1dmPvMrwoMjMs4f6xTC6k/Z/QtI4OqHZKXcmObPw8/pGrV/D8X5sZ/cRwEGNIRkVI
X-Received: by 10.107.178.129 with SMTP id b123mr33472188iof.83.1469642568925;
 Wed, 27 Jul 2016 11:02:48 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.128.66 with HTTP; Wed, 27 Jul 2016 11:02:48 -0700 (PDT)
In-Reply-To: <CAGZ79kY5UrjSj8xbjB+MvTE2xUyt+te1RKN6Bf0WiEA23iZ7wg@mail.gmail.com>
References: <CACsJy8CMnywB8AdmLxB8LnsznHrMTieoezhaQS=2r1pnM8ONZA@mail.gmail.com>
 <CAGZ79kY5UrjSj8xbjB+MvTE2xUyt+te1RKN6Bf0WiEA23iZ7wg@mail.gmail.com>
From:	Stefan Beller <sbeller@google.com>
Date:	Wed, 27 Jul 2016 11:02:48 -0700
Message-ID: <CAGZ79kYNFoAUu+5Y0oh221UeyAB3zan_36RgrhZnSi19Oe2vcA@mail.gmail.com>
Subject: Re: Find a topic branch containing a commit
To:	Duy Nguyen <pclouds@gmail.com>
Cc:	Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Wed, Jul 27, 2016 at 10:50 AM, Stefan Beller <sbeller@google.com> wrote:
>>
>> PS. Sometimes I wish we could optionally save cover letter in the
>> merge commit. Sometimes the "big plan" is hard to see by reading
>> individual commit messages.
>> --

I had this wish, too. That makes a lot of sense for merge commits,
although it doesn't work well with our current workflow I would presume,
because the merge commit happens at a different time than when Junio
picks up a patch series. And in the mean time, where would we
store the cover letter information to not get lost?

Note there are some external recordings instead of adding
it to the history itself, e.g. https://github.com/trast/git/tree/notes/gmane
annotated each commit with pointers to the mailing list archive.
