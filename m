Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 029DA201B0
	for <e@80x24.org>; Tue, 28 Feb 2017 20:35:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751923AbdB1Uev (ORCPT <rfc822;e@80x24.org>);
        Tue, 28 Feb 2017 15:34:51 -0500
Received: from mail-io0-f179.google.com ([209.85.223.179]:33929 "EHLO
        mail-io0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751601AbdB1Ueh (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Feb 2017 15:34:37 -0500
Received: by mail-io0-f179.google.com with SMTP id 90so17516599ios.1
        for <git@vger.kernel.org>; Tue, 28 Feb 2017 12:34:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=69U2BQj4j0YleNYwOsMIimUiQ1XIZtnL2gsyin+unsQ=;
        b=hHYqTD5BG8hUT64gGwYBC78zRIUJheTWx6KV/NOnxsrrOXptRmfJPLy2aLF9ircGBj
         xOTp7Yu/cuSMzh3v2fwF5DkdJhIBS04DSx7ilzmiJoUY3x0vbVZNyd7QaSttvZ3pxPhj
         hf65vjgQAf34BK6ixCMAItn9LfJuPwo2BL7UEodS4RqNN5OQjer0EmPX6fuYnpcKc1Tt
         UUfc9CoN4V+sNE5yJfWn3S2ExHcD3toFWWk7hmgMHfFo3JJMaat7OST1/2qUpoz75NVh
         7jhPWmIySOKpY6t523mmsAECBGBSvIRn1/3MkQatEZ68XmHA275b7OQa9oOqlmcz/FA6
         Hzjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=69U2BQj4j0YleNYwOsMIimUiQ1XIZtnL2gsyin+unsQ=;
        b=OomrJFIpnZAKOiNkbDP/S+plDBYkzZn/c862U4o+EziwjS3JKyY2yDe6+2E3z5rhlh
         ZvN0xBV46/bkJ7ZEtE7nOHqijHnC25Mu2H9TS42KbI6gC10MyfvnFgAfc1wipMPTa4Ru
         hh8pc2oZW+60hSQnYoTy32PLjKhg2aAZJJac3r9DuqGXI4SINCBy89nk4wo6BrxDPzsK
         tj8XpFomIwWXIviKfz1/9xVf4iM9442Igw3DoNYALXGHMPgJ1D1BgO51SgBJJszjMNf2
         s1ferD6SuhqAqB47zY5p+SD2zVspkxhzotcbuVve/pjLbeoty8mtnWr3vKwcUCmrNuy+
         8r6Q==
X-Gm-Message-State: AMke39kCPa/ADljM6GPjWxkouKuFPSutGWwxQlVw8t5/3kIae5M75Adn6f8v+22Ylws0NmgR4DbBeajsF3jHrQ==
X-Received: by 10.107.136.93 with SMTP id k90mr4736249iod.224.1488313521432;
 Tue, 28 Feb 2017 12:25:21 -0800 (PST)
MIME-Version: 1.0
Received: by 10.107.146.131 with HTTP; Tue, 28 Feb 2017 12:25:20 -0800 (PST)
In-Reply-To: <xmqqvarujdmv.fsf@gitster.mtv.corp.google.com>
References: <CA+55aFxYs1zp2c-UPe8EfshNNOxRVxZ2H+ipsnG489NBsE+DLQ@mail.gmail.com>
 <xmqqvarujdmv.fsf@gitster.mtv.corp.google.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 28 Feb 2017 12:25:20 -0800
X-Google-Sender-Auth: SZLGKuMoITeZQyKTJeKDMiyfhOk
Message-ID: <CA+55aFzUhWinWqK30GBc1BKy-v6QtDdO2BLUODkiqg9XoKLrwA@mail.gmail.com>
Subject: Re: Typesafer git hash patch
To:     Junio C Hamano <gitster@pobox.com>
Cc:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Feb 28, 2017 at 11:53 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Linus Torvalds <torvalds@linux-foundation.org> writes:
>>
>> Having the hashes be more encapsulated does seem to make things better
>> in many ways. What I did was to also just unify the notion of "hash_t"
>> and "struct object_id", so the two are entirely interchangeable.
>
> Sorry, but at this point in your description, you completely lost
> me.  I thought "struct object_id" was what you call "hash_t" in the
> above.

So what happened was that I started out just encapsulating

   unsigned char sha1[20];

as a

   hash_t hash;

and that made sense in a lot of situations. I always thought that code that used

    struct object_id oid;

is just too ugly to live, so I'm not actually all that big of a fan of
the oid approach.

But the two approaches really are pretty much equivalent logically,
even if they don't look the same.

So I wanted to unify things: "One type to bring them all and in the
darkness bind them".

So I just basically made this:

    typedef struct object_id {
            unsigned char hash[GIT_HASH_SIZE];
    } hash_t;

to create one single data structure that doesn't make my eyes bleed.
That "struct object_id" still exists, but I don't generally have to
look at it when doing the conversion, and any current users "just
work".

>> turns into
>>
>> +               const hash_t *mb = &result->item->object.oid;
>> +               if (!hashcmp(mb, current_bad_oid)) {
>
> Hmph.  I somehow thought the longer term directio for the above code
> would be to turn it into
>
>                 if (!oidcmp(&result->item->object.oid, &current_bad_oid))

Well, you can actually do it with my patch, since I left "oidcmp()"
alone and it's just an alias for "hashcmp()" in my tree.

Except I think "oid" is an odious name, and really confusing and not
at all descriptive.

Using a three-letter acronym when we have a four-letter actual word to
say it feels stupid and wrong to me.

So what my conversion does is basically say that the name is *hash*.
So instead of using "oidcmp", you use "hashcmp":

        if (!hashcmp(&result->item->object.oid, &current_bad_oid))

and functions take a "hash_t *" argument rather than a "struct
object_id *" argument, and when there was any kind of confusion and
mixing of use, I converted to "hash_t".

Both oid and "unsigned char *" users got converted.

In other words, what I was aiming for was getting rid - entirely - of
the "two different types", and I disliked both "oid" and "unsigned
char []", so neither replaces the other.

> Having said all that, I do not offhand see a huge benefit of the
> current layout that has one layer between the hash (i.e. oid.hash)
> and the object name (i.e. oid) over "there is no need for oid.hash;
> oid is just a hash", which you seem to be doing.

Yes exactly.

>> And as part of the type safety, I do think I may have found a bug:
>>
>> show_one_mergetag():
>>
>>                 strbuf_addf(&verify_message, "tag %s names a non-parent %s\n",
>>                                     tag->tag, tag->tagged->oid.hash);
>>
>> note how it prints out the "non-parent %s", but that's a SHA1 hash
>> that hasn't been converted to hex. Hmm?
>
> Yup.  That needs fixing, obviously.

I suspect nobody has ever hit that case - I tried to google for "names
a non-parent" and "tag" and "git" and the only thing that I found was
hits to git source.

So I was actually fairly impressed that the only thing I found was one
totally insignificant bug in a printout.

I did find a lot of cases where we really do mix a buffer of memory
("unsigned char *") with the hash. Not unsurprisingly, most of them
were in pack-file handling and in the tree parsing.

And some thing do the reverse, and really walk a hash name byte by
byte. Things like "find_pack_entry_one()" really does walk the bytes
of the hash.

With the conversion in place, those painful things are a bit more
obvious. So there's a couple of places where I just did a hard
conversion from a "unsigned char *" to a hash_t, but they are now
obvious casts and there's only 17 of them:

  [torvalds@i7 git]$ git grep '(hash_t \*)'
  builtin/index-pack.c:           hashcpy(ref_hash, (hash_t *) fill(20));
  builtin/pack-redundant.c:               hash_t *h1 = (hash_t
*)(p1_base + p1_off);
  builtin/pack-redundant.c:               hash_t *h2 = (hash_t
*)(p2_base + p2_off);
  builtin/pack-redundant.c:               hash_t *h1 = (hash_t
*)(p1_base + p1_off);
  builtin/pack-redundant.c:               hash_t *h2 = (hash_t
*)(p2_base + p2_off);
  builtin/pack-redundant.c:               hash_t *h = (hash_t *)(base + off);
  dir.c:  hashcpy(&ud->exclude_sha1, (hash_t *)rd->data);
  fast-import.c:          hashcpy(&e->versions[0].hash, (hash_t *)c);
  fast-import.c:          hashcpy(&e->versions[1].hash, (hash_t *)c);
  match-trees.c:  hashcpy((hash_t *)rewrite_here, rewrite_with);
  sha1-lookup.c:                      lo, mi, hi, sha1_to_hex((hash_t *)key));
  sha1_file.c:    return (hash_t *)(base + idx * GIT_SHA1_RAWSZ);
  sha1_file.c:            return (hash_t *)base;
  sha1_file.c:            return (hash_t *) (index + 24 * n + 4);
  sha1_file.c:            return (hash_t *) (index + 20 * n);
  sha1_file.c:            int cmp = hashcmp((hash_t *)(index + mi *
stride), (hash_t *)sha1);
  split-index.c:  hashcpy(&si->base_sha1, (hash_t *)data);

and there are basically an equal number of cases where I do the
reverse (by doing hash->hash to get the byte array data of the hash).

So the patch doesn't *fix* anything, but it does, I think, make it
easier to see the problems.

And the *bulk* of the code doesn't look inside the hashes at all.

                     Linus
