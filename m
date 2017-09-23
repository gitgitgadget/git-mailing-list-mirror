Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A8AC12047F
	for <e@80x24.org>; Sat, 23 Sep 2017 09:49:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750839AbdIWJtS (ORCPT <rfc822;e@80x24.org>);
        Sat, 23 Sep 2017 05:49:18 -0400
Received: from mail-pf0-f177.google.com ([209.85.192.177]:44718 "EHLO
        mail-pf0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750766AbdIWJtR (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 23 Sep 2017 05:49:17 -0400
Received: by mail-pf0-f177.google.com with SMTP id e1so1651959pfk.1
        for <git@vger.kernel.org>; Sat, 23 Sep 2017 02:49:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=wvTxvl818i+SZ3sLx+9IJhb2E/w/8RC3SdP2v7/YTRs=;
        b=VrL0ib4LJJCSCFNEu1RrJvqfxvpi8XkDWM7XVCUmcCWEsX8Zh1z/QPuH673UXROVvH
         eO4D8L+4Ss+/TEL5qdi8BC1HmiDQnBMB1ugYzsiNBiOO1u1T1JAAxkaNQOiX14IsWT/X
         dbBX/3/UzcZIZqZLeiJgwue1kT7pDIYA8Qu9TQP1Q/9twNeC4hX2ZPGPH6MvQhIUik1t
         tL4lKIFPMLpVX+2V/R009/b0PlzuwgGxCbkMGCr5QHOlQhcp1EKx3isEbaS7i+qo/Siy
         vtaDRaVQgcP2QsRQUrtwQsCTEoam6XZe1fpFOoZ/UyO/7DY2XcLzvdFK2KuImJUwP+WZ
         3IuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=wvTxvl818i+SZ3sLx+9IJhb2E/w/8RC3SdP2v7/YTRs=;
        b=LKovFtkxPHxOz2inAgGyHkSlPxhY+S6wB7RmH79M4KxT5ud1SZLsAHGyhy69eS/dYi
         FwhZoUfadJEUrZmqZxoabaT2mvxTVsZXBAj00V53gKfC1+zpk7AsOMJc08VY5S/tG9O3
         aD6OlBHsrNrclI6eFjrKEbPScCHvJ6l/fRG6KdVRrDv4SQiIlOLk3CyV1jZt3iMZiQJ8
         pBPcOFJ+XJyDA86lJyQ9F22bS0xDjRujHeIR8XiGZ5pZouiXX7+X62tFAD9SIApY7Dpl
         pLWv7ZUaSLOUieSR3UI/kNX83ZqllNaHeqEgKnmy4FotMjGP26srJW9xzkYQjWbKNp/k
         vUTw==
X-Gm-Message-State: AHPjjUgoHW3PVzrSaxKDhPiRqJHHBDmLiiN5+/880vv8Ngto6ifc5Vo1
        Z6NxJ606Sna9awZ1QKrj6txF4612RRPdZLyyiOGOwPjA
X-Google-Smtp-Source: AOwi7QCVJCSAEc5VLzIrdnNXEG3XOt2wq5PZymeRkEXY/chqaCDOjMf1QFiITJH44nS0G+0+FiMD+OBf6nMJmLxWEfs=
X-Received: by 10.99.126.84 with SMTP id o20mr1723251pgn.201.1506160156764;
 Sat, 23 Sep 2017 02:49:16 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.100.142.137 with HTTP; Sat, 23 Sep 2017 02:49:16 -0700 (PDT)
In-Reply-To: <20170923042757.ozl4qnmrsnd64mfc@sigill.intra.peff.net>
References: <20170920200229.bc4yniz6otng2zyz@sigill.intra.peff.net>
 <cover.1506120291.git.martin.agren@gmail.com> <80eaae517f73f57137db6adfcaef2e8ce16576c1.1506120292.git.martin.agren@gmail.com>
 <20170923042757.ozl4qnmrsnd64mfc@sigill.intra.peff.net>
From:   =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Date:   Sat, 23 Sep 2017 11:49:16 +0200
Message-ID: <CAN0heSpMqRHuQ98AC3Qne=0ygSHxFXQ4buLp0Lvtf19uUo8adQ@mail.gmail.com>
Subject: Re: [PATCH v2 5/6] object_array: add and use `object_array_pop()`
To:     Jeff King <peff@peff.net>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 23 September 2017 at 06:27, Jeff King <peff@peff.net> wrote:
> On Sat, Sep 23, 2017 at 01:34:53AM +0200, Martin =C3=85gren wrote:
>
>> Introduce and use `object_array_pop()` instead. Release memory in the
>> new function. Document that popping an object leaves the associated
>> elements in limbo.
>
> The interface looks appropriate for all of the current cases. Though I
> do suspect there's a bit of catch-22 here. If a caller _did_ care about
> the "name" and "path" fields, then this pop function would be
> inappropriate, because it returns only the object field.
>
> So in the most general form, you'd want:
>
>   while (foo.nr) {
>           struct object_array_entry *e =3D object_array_pop(&foo);
>
>           ... do stuff with e->name, etc ...
>
>           object_array_release_entry(e);
>   }
>
> But that is certainly more cumbersome for these callers. I think we can
> punt on that until it becomes necessary (which likely is never).

I considered something like this. I felt that making the function
`object_array_release_entr()` available to the general public would also
carry some risk. Right now, it's only object.c that needs to get things
right (never release twice, never release without removing, never be
clever, ..)

>> The name of `object_array_pop()` does not quite align with
>> `add_object_array()`. That is unfortunate. On the other hand, it matches
>> `object_array_clear()`. Arguably it's `add_...` that is the odd one out,
>> since it reads like it's used to "add" an "object array". For that
>> reason, side with `object_array_clear()`.
>
> Yes, we're dreadfully inconsistent here. I tend to prefer noun_verb()
> when "noun" is a struct we're operating on. But we have quite a bit of
> verb_noun(). I find that noun_verb() is a bit more discoverable (e.g.,
> tab completion does something sensible), but I'm not sure if it's worth
> trying to do a mass-conversion.
>
> Perhaps it's something that should be mentioned in CodingGuidelines, if
> it isn't already.

When writing the above paragaph (so yes, after I had already chosen the
name), I tried to find something, but couldn't. Admittedly, I just had a
cursory look.

> The patch itself looks good, with one tiny nit:
>
>> diff --git a/object.h b/object.h
>> index 0a419ba8d..b7629fe92 100644
>> --- a/object.h
>> +++ b/object.h
>> @@ -115,6 +115,13 @@ int object_list_contains(struct object_list *list, =
struct object *obj);
>>  /* Object array handling .. */
>>  void add_object_array(struct object *obj, const char *name, struct obje=
ct_array *array);
>>  void add_object_array_with_path(struct object *obj, const char *name, s=
truct object_array *array, unsigned mode, const char *path);
>> +/*
>> + * Returns NULL if the array is empty. Otherwise, returns the last obje=
ct
>> + * after removing its entry from the array. Other resources associated
>> + * with that object are left in an unspecified state and should not be
>> + * examined.
>> + */
>> +struct object *object_array_pop(struct object_array *array);
>
> I'm very happy to see a comment over the declaration here. But I think
> it's a bit more readable if we put a blank line between the prior
> function and the start of that comment.

Yes, that looks strange. :( I could re-roll and/or ask Junio to fiddle
with it. On closer look, this file is pretty close to documenting all
functions and there are some other comment-formatting issues. So here's
a promise that I'll get back to clean this up more generally in the not
too distant future. Would that be an acceptable punt? :-?

Martin
