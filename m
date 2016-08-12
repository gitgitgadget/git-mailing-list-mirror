Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D449D1F859
	for <e@80x24.org>; Fri, 12 Aug 2016 16:16:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752586AbcHLQQK (ORCPT <rfc822;e@80x24.org>);
	Fri, 12 Aug 2016 12:16:10 -0400
Received: from mail-io0-f194.google.com ([209.85.223.194]:36178 "EHLO
	mail-io0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752301AbcHLQQK (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Aug 2016 12:16:10 -0400
Received: by mail-io0-f194.google.com with SMTP id y34so1906183ioi.3
        for <git@vger.kernel.org>; Fri, 12 Aug 2016 09:16:09 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=716KH5gZQ65B/hCDqXPVf/wA2QZpYyyMuptnRS0hEFo=;
        b=mRYh5cfdXkD2f5+dS5p8+/j6w/zKJ0TgKATEzxPWBoZdmtGQwX7fBRGBh0hKiy24GS
         tcjgK9ZpS5XvM5NTS358daTNjO9KW+yOaFvJ6fbL8to8Zlha3wSnumS4Hj/8uZCL/HHU
         5deNkvTQ9GtGjmf9I21Bq/Yf1UBhxmfsDgFdfOJtNYwwwdPn1DvPIH1fwQrzTdOMiIRv
         Aej+rTKDCjF5Psy29zPsD+IEPvBfx0xpehHGsCfpw9SilqvtdV1xcSFamX4YF82qPrdg
         lm8iOyphfrS0YNPBkwhOKzJcwCVaNQRuclQraQdjpTj7lD/iByjQADSquZZtREGMHbr3
         Umrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=716KH5gZQ65B/hCDqXPVf/wA2QZpYyyMuptnRS0hEFo=;
        b=hLnZnYi3j2OqBmhLjRfM8KPDJXp5O44Dm6AgKjJnEyi2D9wc1WbDsgGKmlbhoWouz9
         gM8p1A/Fnxc+u3dxVWzWQNgNz5Zzh8FyBwurM6lJ4QsmRRYFhRkY6EfejNkryw6C1fWX
         aJqQdUPx1GKaW37LvE8ZmZboL2o+ZTks1QSQIykPTPg6BIj+Lg2LJg68fucco3jZkEyu
         8e4dWzj2SNcQoi5TAda21XeMa84XqGlLHqSdRi5s0iypOVn0PRT4e++2VHuZ6f3u1wh5
         1FLfrMqZOLugPIHaxzd/N+jWNdhGX91Z37DAcUW7zeaTfzWJzJjycOvcc2Eo3g1mKEYh
         1Zzw==
X-Gm-Message-State: AEkoouvfoDmHnDpTDuf3oO2vk3f2nd+SPUgwB1ENJEbH/MdFdAgtOGG6dh4Kk0HEzPtdf45i8JsAGyIdyhiDzg==
X-Received: by 10.107.34.19 with SMTP id i19mr20366668ioi.52.1471018569353;
 Fri, 12 Aug 2016 09:16:09 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.36.213.66 with HTTP; Fri, 12 Aug 2016 09:15:38 -0700 (PDT)
In-Reply-To: <A7A176B0-08CE-4D92-9756-51A59DF3B9D7@gmail.com>
References: <CAKRjdd4WdVTgbT0gcR=a267+aEwD2Exztrc9gNau1nOXroC=ng@mail.gmail.com>
 <xmqqr39uxa33.fsf@gitster.mtv.corp.google.com> <A7A176B0-08CE-4D92-9756-51A59DF3B9D7@gmail.com>
From:	Joseph Musser <me@jnm2.com>
Date:	Fri, 12 Aug 2016 12:15:38 -0400
X-Google-Sender-Auth: IdRkoMDHWSu76X_rfgxe3GVCJgk
Message-ID: <CAKRjdd4V3OfDnzisxBofBUmtds7q7ejUtuV_-s96eUVf7fqwHA@mail.gmail.com>
Subject: Re: `git stash --help` tries to pull up nonexistent file gitstack.html
To:	Lars Schneider <larsxschneider@gmail.com>
Cc:	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Oh, I'm embarrassed. The typo was mine, I must have typed `git stack
--help`. I would have expected a syntax error message or "did you
mean" suggestions; it didn't even enter my mind that it would look up
whatever I typed before --help and assume it existed on disk.

I'm sorry!

On Fri, Aug 12, 2016 at 12:03 PM, Lars Schneider
<larsxschneider@gmail.com> wrote:
>
>> On 12 Aug 2016, at 17:48, Junio C Hamano <gitster@pobox.com> wrote:
>>
>> Joseph Musser <me@jnm2.com> writes:
>>
>>> Looks like a simple typo.
>>
>> Unfortunately this does not reproduce to me (built from source on
>> Ubuntu Linux).
>
> I tried it with the latest released version on Windows and OSX (2.9.2)
> and was not able to reproduce it, too.
>
> - Lars
