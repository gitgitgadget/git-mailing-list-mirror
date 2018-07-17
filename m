Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D843B1F597
	for <e@80x24.org>; Tue, 17 Jul 2018 07:44:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728422AbeGQIPw (ORCPT <rfc822;e@80x24.org>);
        Tue, 17 Jul 2018 04:15:52 -0400
Received: from mail-wr1-f43.google.com ([209.85.221.43]:39827 "EHLO
        mail-wr1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727600AbeGQIPw (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Jul 2018 04:15:52 -0400
Received: by mail-wr1-f43.google.com with SMTP id h10-v6so188786wre.6
        for <git@vger.kernel.org>; Tue, 17 Jul 2018 00:44:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=AYsv400C+edYLHYV9xtezMro3d4ZOo7ZbUppe98jVnA=;
        b=CHyp9JuddcAasQgG+D+SG7im/aeZFR4XA3znsUDsmyfYp56RXk5ExQ0Inh+C2Z640s
         9kiOD3Ob/ETlz1/7WMXtQVRkHsVfs/UPhhk61qvYzDDisf0JKYJB5rHkS+lzHuAMeiiR
         y7cqT/Ww3aTbpMxJUVtQLsvTcVr05h2e9R0KsUvKNNf3UkHXDekoUKID3l17AWoSzSUS
         8az2Z7t7cn94Kuq5NDB6D3/0lLiMv5+vgBY+gZAz5R6RkLQgvgQyK8SCDBACg6ALy8no
         iEs6hyvtAp7NbFRQ36T43aBScOXyjIfcBg5M2YS90rEw5HltzeO/SkjsC3HbqHCbvswz
         C9EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=AYsv400C+edYLHYV9xtezMro3d4ZOo7ZbUppe98jVnA=;
        b=HeRA2+eXFSzrXTpale9cyA0bn5BgGTUGJIhC4pM/8FoINlgJIxVEm8nDcTVPnoC9MO
         EJxSb7AmSPqP6lfi0+V3SK2IOf8tHNdB6GJzrTzovuIPs032HEybnmRuvQFCNLGTUffB
         cV9/bZYZs2+JN1gHfFApi4xg1TsE6fuKWM0EzE4qdZNp/jioDsYHGWv6hkbwia/e8wVc
         WSraAjXhSdGh/AbNqniILyZax5UWHctnPxIGwOjuNeDMdf3B6f4rDlbsOZ0v+IWpy7rV
         G7WcdO8YQ9fOgkdGHga90dU2Q7oGlgrHt4zcxwgqDFapp5NhcabovDypcsIUbM/6tJ8k
         H7nQ==
X-Gm-Message-State: AOUpUlFfotuELYBA316f3X0o7euYMadHx1rzQMmwluOQ4gmouoeXpR4q
        jMHZszig7g0d+JKU7pqijjeBUW58gxHC29tcFpA=
X-Google-Smtp-Source: AAOMgpd9Frk5iOMr+fYIRzTMQbREtsZo7WzCIC/X3sCvdJ0mb8uMPrBRyZIzHSA90yBNZkqKSBRr1XP3ux2BHFRZg3Y=
X-Received: by 2002:adf:cd0e:: with SMTP id w14-v6mr443049wrm.226.1531813474259;
 Tue, 17 Jul 2018 00:44:34 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:adf:e9c6:0:0:0:0:0 with HTTP; Tue, 17 Jul 2018 00:44:33
 -0700 (PDT)
In-Reply-To: <xmqqr2k2sy02.fsf@gitster-ct.c.googlers.com>
References: <0102016493ab5347-c0429041-6e66-4550-894c-2d500cb2ed8e-000000@eu-west-1.amazonses.com>
 <0102016493ab542d-ea2a3e8c-d6a0-44ca-8fc6-f940fe7e84cd-000000@eu-west-1.amazonses.com>
 <xmqqr2k2sy02.fsf@gitster-ct.c.googlers.com>
From:   =?UTF-8?B?0J7Qu9GPINCi0LXQu9C10LbQvdCw0Y8=?= 
        <olyatelezhnaya@gmail.com>
Date:   Tue, 17 Jul 2018 10:44:33 +0300
Message-ID: <CAL21BmnDqv9yib5Vqh4q7zj1hd_bmhO+xnDVJBi-zM0Cqtsevw@mail.gmail.com>
Subject: Re: [PATCH v2 4/4] ref-filter: use oid_object_info() to get object
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

2018-07-16 23:53 GMT+03:00 Junio C Hamano <gitster@pobox.com>:
> Olga Telezhnaya <olyatelezhnaya@gmail.com> writes:
>
>> -static int get_object(struct ref_array_item *ref, const struct object_id *oid,
>> -                   int deref, struct object **obj, struct strbuf *err)
>> +static int get_object(struct ref_array_item *ref, int deref, struct object **obj,
>> +                   struct expand_data *oi, struct strbuf *err)
>>  {
>> -     int eaten;
>> -     int ret = 0;
>> -     unsigned long size;
>> -     enum object_type type;
>> -     void *buf = read_object_file(oid, &type, &size);
>> -     if (!buf)
>> -             ret = strbuf_addf_ret(err, -1, _("missing object %s for %s"),
>> -                                   oid_to_hex(oid), ref->refname);
>> -     else {
>> -             *obj = parse_object_buffer(oid, type, size, buf, &eaten);
>> -             if (!*obj)
>> -                     ret = strbuf_addf_ret(err, -1, _("parse_object_buffer failed on %s for %s"),
>> -                                           oid_to_hex(oid), ref->refname);
>> -             else
>> -                     grab_values(ref->value, deref, *obj, buf, size);
>> +     /* parse_object_buffer() will set eaten to 0 if free() will be needed */
>> +     int eaten = 1;
>
> Hmph, doesn't this belong to the previous step?  In other words,
> isn't the result of applying 1-3/4 has a bug that can leave eaten
> uninitialized (and base decision to free(buf) later on it), and
> isn't this change a fix for it?

Oh. I was thinking that it was new bug created by me. Now I see that
previously we had the same problem. I guess it's better to make
separate commit to fix it. Hope I can do it in this patch (I don't
want to create separate patch because of so minor update).
Thank you! I will fix it soon.

>
>> +     if (oi->info.contentp) {
>> +             /* We need to know that to use parse_object_buffer properly */
>> +             oi->info.sizep = &oi->size;
>> +             oi->info.typep = &oi->type;
>>       }
>> +     if (oid_object_info_extended(the_repository, &oi->oid, &oi->info,
>> +                                  OBJECT_INFO_LOOKUP_REPLACE))
>> +             return strbuf_addf_ret(err, -1, _("missing object %s for %s"),
>> +                                    oid_to_hex(&oi->oid), ref->refname);
>> +
>> +     if (oi->info.contentp) {
>> +             *obj = parse_object_buffer(&oi->oid, oi->type, oi->size, oi->content, &eaten);
>> +             if (!obj) {
>> +                     if (!eaten)
>> +                             free(oi->content);
>> +                     return strbuf_addf_ret(err, -1, _("parse_object_buffer failed on %s for %s"),
>> +                                            oid_to_hex(&oi->oid), ref->refname);
>> +             }
>> +             grab_values(ref->value, deref, *obj, oi->content, oi->size);
>> +     }
>> +
>> +     grab_common_values(ref->value, deref, oi);
>>       if (!eaten)
>> -             free(buf);
>> -     return ret;
>> +             free(oi->content);
>> +     return 0;
>>  }
>
