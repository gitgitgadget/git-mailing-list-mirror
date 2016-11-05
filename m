Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 351E02022D
	for <e@80x24.org>; Sat,  5 Nov 2016 00:45:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751074AbcKEApH (ORCPT <rfc822;e@80x24.org>);
        Fri, 4 Nov 2016 20:45:07 -0400
Received: from mail-lf0-f53.google.com ([209.85.215.53]:35711 "EHLO
        mail-lf0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750723AbcKEApH (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 Nov 2016 20:45:07 -0400
Received: by mail-lf0-f53.google.com with SMTP id b14so75948626lfg.2
        for <git@vger.kernel.org>; Fri, 04 Nov 2016 17:45:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=uvuB5SFXNgt0N3sHkiSHnEBd0hcQHTIEctPvSvvt1WQ=;
        b=LY7HwAxgXcA0Wr2qo/UErQlHc6yiq0MJTsBMt+OE5AgOyVE6/pHq4QOmKEzOB3JDRS
         ClszZb9dVg+1uovAsJwEuVGICDOPc+tZHxwr1JOnTuQODEvP8k3Xv3OycWpi/95JuIvk
         7+OWzqWiwk3vzVZBWcJg6URN2Jc9cNMbv3dr+UYznwVtrDTzqG0j3LNr8wyn9Tyj1itN
         JB7NT1RdD9ktBUE0D3beFSZsUHAg+yULwWZel8jD/YTR459wddH+ruewgaUkR+GX0mJq
         IqIe+MRUXjID0685E4ypHrZKYu0vdD9Y0QXuPAL+hMp/Fzl26En+saWahewyAhe/NEkC
         7BqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=uvuB5SFXNgt0N3sHkiSHnEBd0hcQHTIEctPvSvvt1WQ=;
        b=OLBpQruiAzmDeE+6oOvzdyxCcjzxlMBvsiAh3MkFZoaN+ZPG9yhFayUbkYb7TbEXUV
         zpXNRy/A2xj6MhA7RWGU15F14KiFJdGBHdrskk3Ocn6292L91BR+6MT/LZSQvTSQ/1uk
         Ek1SZxxkNqyiWt0exmmoZHD6VwVHAPMQAUCJ8ECA6YcNVD01W0ACzLDl9/RnoSXUaNLZ
         hRCxzxbUs2fFpdy54U2pNJxqfjphczkyf1uC6s4WU5WYgS0bBSELRrIDmJUXOT9HGMpE
         dSO16VXBOWGoHKVoqVVwRVOrYRZGbkxn/FRuUdBOaaB6xGO4q1B87bXY6ga73Sdux6rC
         VxVw==
X-Gm-Message-State: ABUngvcUd+nE3+k5gXsSeuC/nyKwFgzWwzyshrQgPlpH6cWjn6JVljVjHjNyF47nHCGKUqbX2X3QlgOftE40PQ==
X-Received: by 10.25.159.141 with SMTP id i135mr10943847lfe.123.1478306705143;
 Fri, 04 Nov 2016 17:45:05 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.25.163.84 with HTTP; Fri, 4 Nov 2016 17:45:04 -0700 (PDT)
In-Reply-To: <xmqq8tt3ovnp.fsf@gitster.mtv.corp.google.com>
References: <20161023092648.12086-1-chriscool@tuxfamily.org>
 <20161023092648.12086-13-chriscool@tuxfamily.org> <xmqq8tt3ovnp.fsf@gitster.mtv.corp.google.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Sat, 5 Nov 2016 01:45:04 +0100
Message-ID: <CAP8UFD2H6rZNQqg1VGNkes65KAk-4P160rjQSjFY3NjgZydZmA@mail.gmail.com>
Subject: Re: [PATCH v1 12/19] Documentation/config: add splitIndex.maxPercentChange
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git <git@vger.kernel.org>,
        Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Nov 1, 2016 at 8:19 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Christian Couder <christian.couder@gmail.com> writes:
>
>> +splitIndex.maxPercentChange::
>> +     When the split index feature is used, this specifies the
>> +     percent of entries the split index can contain compared to the
>> +     whole number of entries in both the split index and the shared
>> +     index before a new shared index is written.
>> +     The value should be between 0 and 100. If the value is 0 then
>> +     a new shared index is always written, if it is 100 a new
>> +     shared index is never written.
>
> Hmph.  The early part of the description implies this will kick in
> only when some other conditions (i.e. the bit in the index or the
> other configuration) are met, but if this disables the split index
> when it is set to 0, would we even need the other configuration
> variable?  IOW, perhaps we can do without core.splitIndex?

I think it is easier for user to be able to just set core.splitIndex
to true to enable split-index.
If we ask them to instead set splitIndex.maxPercentChange to a
"reasonable value like 20" to enable it, they will start to wonder why
20 and not 50 or 100 and might be unnecessarily confused.

Also it might be good to make it possible to have other values than
"true" and "false" for core.splitIndex in the future.
For example if we decide to first enable split-index only on
$GIT_DIR/index, we might later want an "everywhere" or "always" value
for core.splitIndex if we find a way to enable it on other indexes.

We might also want an "auto" mode in the future when split-index will
work really well, so that it can be turned on automatically on all the
repos where it makes sense (like when the index contains more than
10000 entries for example).

>> +     By default the value is 20, so a new shared index is written
>> +     if the number of entries in the split index would be greater
>> +     than 20 percent of the total number of entries.
>> +     See linkgit:git-update-index[1].
