Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A147E1F4B5
	for <e@80x24.org>; Thu, 14 Nov 2019 02:55:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726521AbfKNCz3 (ORCPT <rfc822;e@80x24.org>);
        Wed, 13 Nov 2019 21:55:29 -0500
Received: from mail-vs1-f65.google.com ([209.85.217.65]:45735 "EHLO
        mail-vs1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726491AbfKNCz3 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Nov 2019 21:55:29 -0500
Received: by mail-vs1-f65.google.com with SMTP id n9so2849908vsa.12
        for <git@vger.kernel.org>; Wed, 13 Nov 2019 18:55:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=illinois-edu.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Uth/1ASna8JT+bd7yIBJIxCT1T7v2zhspdkcy1Gcm9s=;
        b=G2ZjvFCrA99So3n6Xnu5zhBg/gIukZpqWfJWLEdRO8I2pKjvOlDem6uQ3V6A9a5wfU
         o/L1qM84O5QsbxkulgzWpSdk256TPecSBRZZ5eI5k/EGsETvC8yvgr863Wn7xNChikXH
         S3f1zDAPVjRqKhCTHORzQBLNZA3MpF0Ez5r6BfHi1FuJzEzTt2bZD1FwbvOqqw9LFcOI
         6VIhdH8omw7rCrLS8WIUcbSfgIBovf2TMw4iOtiW0FGNg2jY6nhoqHLa+rk1TJIcsnZ3
         nl4yQgvB1UE03rOAAB5oGgBFYB4jbFFrCJqWxTzRE/A4AnesvCLtb7QxAzzg/r7MOG5R
         e3uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Uth/1ASna8JT+bd7yIBJIxCT1T7v2zhspdkcy1Gcm9s=;
        b=MOD2z5kHNJw/K/s2DfJwv4T79AhyTgMpEMlBo8Ude5a9lfru4O4bUGyqsYZ9xXvBEt
         Eq7P9CAHwYq/5fA255IoikwwspxV/hFgNLK1zZiGmnMH6LMCvres/AzG2m2WPK4iixKz
         Qt/B3eJHTcHbXD9+UhUEOL7MBiN2GbQAbRWprrUUaA+fXZqjBF9KY6jNQKEVrFayoFds
         rA5oHGvq4Ck8550yoyXdEmG4RjPAGHGgwNkXxWzGi96Q8ePufGQ9PcLb0aPpRDqsq8Ld
         6mfyjRHngWB/dTCwykqxFLOIZyAVBScyUBE5g2Bz3WuOgVESBI7NYEBPMN46724UpdEB
         OtVg==
X-Gm-Message-State: APjAAAUBmGy/GcuOY+oyFZuNj7VSvHWDRExm98dMxc0odVfukYTXH5wY
        0DyWqdBlBqRW7q+i4mDlWFyTJOlmSgZuV2zbTfpYjA==
X-Google-Smtp-Source: APXvYqwabLu+fDjVNaUlfa0Yv+ZS+JNP9uoH0AuxPOTNkbPRv/3GoPkBCKFyu+ZxXM/eDLLmEzOpkuT+ynofzAW+ioI=
X-Received: by 2002:a67:fc98:: with SMTP id x24mr4174818vsp.232.1573700127961;
 Wed, 13 Nov 2019 18:55:27 -0800 (PST)
MIME-Version: 1.0
References: <pull.458.git.1573196960.gitgitgadget@gmail.com>
 <xmqqh83bjig6.fsf@gitster-ct.c.googlers.com> <xmqqa793jhne.fsf@gitster-ct.c.googlers.com>
 <BN6PR21MB07869E8D1DCAF189C4E472A891740@BN6PR21MB0786.namprd21.prod.outlook.com>
 <xmqqzhh0d0ma.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqqzhh0d0ma.fsf@gitster-ct.c.googlers.com>
From:   Utsav Shah <ukshah2@illinois.edu>
Date:   Wed, 13 Nov 2019 18:55:16 -0800
Message-ID: <CABhpXbfn6zOMaVkg_a8xhqT5JFRXxxWkdi1SjHq38z_NbMqdaQ@mail.gmail.com>
Subject: Re: [PATCH 0/1] fsmonitor: skip sanity check if the index is split
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Kevin Willford <Kevin.Willford@microsoft.com>,
        Utsav Shah via GitGitGadget <gitgitgadget@gmail.com>,
        William Baker <William.Baker@microsoft.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This looks good to me.

On Tue, Nov 12, 2019 at 5:30 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> Kevin Willford <Kevin.Willford@microsoft.com> writes:
>
> > I agree.  The only 2 places that excluding the split-index make sense are in
> > read_fsmonitor_extension and write_fsmonitor_extension because the
> > index_state that is being passing into those methods could be the delta index
> > in which case the number of entries for the fsmonitor bitmap would almost
> > always be more and cause the BUG to be hit which it should not be.
>
> Thanks.  Here is what I came up with to tie the loose ends of this
> thread.
>
> -- >8 --
> From: Junio C Hamano <gitster@pobox.com>
> Subject: [PATCH] fsmonitor: do not compare bitmap size with size of split index
>
> 3444ec2e ("fsmonitor: don't fill bitmap with entries to be removed",
> 2019-10-11) added a handful of sanity checks that make sure that a
> bit position in fsmonitor bitmap does not go beyond the end of the
> index.  As each bit in the bitmap corresponds to a path in the
> index, this is the right check most of the time.
>
> Except for the case when we are in the split-index mode and looking
> at a delta index that is to be overlayed on the base index but
> before the base index has actually been merged in, namely in read_
> and write_fsmonitor_extension().  In these codepaths, the entries in
> the split/delta index is typically a small subset of the entire set
> of paths (otherwise why would we be using split-index?), so the
> bitmap used by the fsmonitor is almost always larger than the number
> of entries in the partial index, and the incorrect comparison would
> trigger the BUG().
>
> Reported-by: Utsav Shah <ukshah2@illinois.edu>
> Helped-by: Kevin Willford <Kevin.Willford@microsoft.com>
> Helped-by: William Baker <William.Baker@microsoft.com>
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
>  fsmonitor.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/fsmonitor.c b/fsmonitor.c
> index 1f4aa1b150..0477500b39 100644
> --- a/fsmonitor.c
> +++ b/fsmonitor.c
> @@ -55,7 +55,8 @@ int read_fsmonitor_extension(struct index_state *istate, const void *data,
>         }
>         istate->fsmonitor_dirty = fsmonitor_dirty;
>
> -       if (istate->fsmonitor_dirty->bit_size > istate->cache_nr)
> +       if (!istate->split_index &&
> +           istate->fsmonitor_dirty->bit_size > istate->cache_nr)
>                 BUG("fsmonitor_dirty has more entries than the index (%"PRIuMAX" > %u)",
>                     (uintmax_t)istate->fsmonitor_dirty->bit_size, istate->cache_nr);
>
> @@ -83,7 +84,8 @@ void write_fsmonitor_extension(struct strbuf *sb, struct index_state *istate)
>         uint32_t ewah_size = 0;
>         int fixup = 0;
>
> -       if (istate->fsmonitor_dirty->bit_size > istate->cache_nr)
> +       if (!istate->split_index &&
> +           istate->fsmonitor_dirty->bit_size > istate->cache_nr)
>                 BUG("fsmonitor_dirty has more entries than the index (%"PRIuMAX" > %u)",
>                     (uintmax_t)istate->fsmonitor_dirty->bit_size, istate->cache_nr);
>
> --
> 2.24.0-346-gee0de6d492
>
