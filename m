Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BAD881F40E
	for <e@80x24.org>; Wed,  3 Aug 2016 18:02:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753305AbcHCSCY (ORCPT <rfc822;e@80x24.org>);
	Wed, 3 Aug 2016 14:02:24 -0400
Received: from mail-it0-f42.google.com ([209.85.214.42]:34567 "EHLO
	mail-it0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751923AbcHCSCX (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Aug 2016 14:02:23 -0400
Received: by mail-it0-f42.google.com with SMTP id j8so47425182itb.1
        for <git@vger.kernel.org>; Wed, 03 Aug 2016 11:01:29 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=7415EnPK025MHWWSqghW6D3XtJ/wkYEPYDdNKwUImFY=;
        b=niQZBhBTzpI021P30cHdC9SLWWHeq0wt/1hcf+wdyJswUTD4ZBXRKGxU4WpPL7Gr1y
         MdFy3/04EMMdwqEWVPZh5QFjLkiN4VvPNhpE8/Stnuf8Dspk2Yu09jxT/bIi/dCZ+eHA
         vTfgvdgZroAza1quxGjsd6z+g2lsJ3Va17IZn/qATzNcgH60KbgDjhG5+f3OKy/cnY++
         EXlCPfLIYII7SNm5IKhmHrpa3cjxjXJKa3y6UU1W0ZiFH7nMpVHDjQ/J/PRyKszAl8el
         yAurajRWDfJioDxpCA7ttUQvqcsuWqGWTd/zIEuj5NPl1mzeXpCgVqj2c5l6rc/KYRD/
         rLBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=7415EnPK025MHWWSqghW6D3XtJ/wkYEPYDdNKwUImFY=;
        b=iMHhlPTPSk3/5Vcx4G0TUx12dw67WwVymYOGz1nneT//VKpBG69NgDoP2FSqA/JhEi
         BmW1+EpX18gh+JgLhVI2FfSwxQQ5JzF8pth0DwWXOvV8y3ns/lQ1aUdPNHvRjlSrtFD8
         lMse0Q8ejf4WJbdsfGEnFRXf5moH4k1ms0QXYTh81wjez1Lb0HFNdKYOl5Vbb1eEMgrV
         sLFOp4zozbxbKTv4/J7fOt8abEAnr5U1fEH4M4iR/UCS9DNe1fiJeZUyoRsYXqmY+LzY
         LtMYVbutcPY8GUeTGjYI9MpStNsg6DomLGuK1jjW6X63Yn+dRx0wUIoukCzuuMZoHpFz
         LdyA==
X-Gm-Message-State: AEkoouuS29w6KNPGLc/0gNr5OigZM6jQwcVddAp0+68CB1VnpJ4evEE8bCTyz4FqLirrCaqNsl23RY/nsEKhLGqO
X-Received: by 10.36.127.7 with SMTP id r7mr69858875itc.49.1470245739619; Wed,
 03 Aug 2016 10:35:39 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.128.66 with HTTP; Wed, 3 Aug 2016 10:35:39 -0700 (PDT)
In-Reply-To: <20160803172242.5jrd4saq7sga6iql@LykOS.localdomain>
References: <20160801224043.4qmf56pmv27riq4i@LykOS.localdomain>
 <20160803145830.uwssj4uhqfemhr4o@LykOS.localdomain> <alpine.DEB.2.20.1608031721430.107993@virtualbox>
 <20160803152510.pgcd2edareqdxnmh@LykOS.localdomain> <CAGZ79kZPPvi2jpFgu1MZ97gZm=QqBBiZ-XcXUJphm3UzNRP-FQ@mail.gmail.com>
 <20160803172242.5jrd4saq7sga6iql@LykOS.localdomain>
From:	Stefan Beller <sbeller@google.com>
Date:	Wed, 3 Aug 2016 10:35:39 -0700
Message-ID: <CAGZ79kY8knsXEVqfbdoHGdEzOfygVoaZi43jy_yERnx=enuRcA@mail.gmail.com>
Subject: Re: [OT] USENIX paper on Git
To:	Santiago Torres <santiago@nyu.edu>
Cc:	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Git <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Wed, Aug 3, 2016 at 10:22 AM, Santiago Torres <santiago@nyu.edu> wrote:
> On Wed, Aug 03, 2016 at 10:14:21AM -0700, Stefan Beller wrote:
>> On Wed, Aug 3, 2016 at 8:25 AM, Santiago Torres <santiago@nyu.edu> wrote:
>> >  > share things before they are published. Thankfully, this is OK in
>> >> > USENIX's book. Here's the link:
>> >> > http://i2.cdn.turner.com/cnnnext/dam/assets/160730192650-14new-week-in-politics-super-169.jpg
>> >>
>> >> While I had a good laugh, I am wondering whether this is the correct link?
>> >
>> > Oh my god, sorry, I meant to p, not to ctrl + v. My head is all over the
>> > place as of late.
>> >
>> > Here's the correct link:
>> >
>> > http://isis.poly.edu/~jcappos/papers/torres_toto_usenixsec-2016.pdf
>>
>> In 4.1 you write:
>> > Finally, Git submodules are also vulnerable, as they automatically track
>> > a tag (or branch). If a build dependency is included in a project as a part
>> > of the submodule, a package might be vulnerable via an underlying library.
>>
>> Submodules actually track commits, not tags or branches.
>>
>> This is confusing for some users, e.g. the user intended to track
>> a library at version 1.1, but it tracks 1234abcd instead (which is what
>> 1.1 points at).
>
> I'm assuming that git submodule update does update where the ref points
> to, does it not?
>
> let me dig into this and try to take the necessary measures to correct
> this
>

"git submodule update" updates to the recorded sha1, which I assume is used
by downstream users. If you are a maintainer and  you want to update the
library used, you'd be interested in have "git submodule update
--remote" to update
the sha1 to the tracking branch, which then exposes the attacks presented.

Thanks,
Stefan
