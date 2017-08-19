Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2CA941F667
	for <e@80x24.org>; Sat, 19 Aug 2017 13:00:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751102AbdHSNAP (ORCPT <rfc822;e@80x24.org>);
        Sat, 19 Aug 2017 09:00:15 -0400
Received: from mail-pf0-f181.google.com ([209.85.192.181]:36048 "EHLO
        mail-pf0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751038AbdHSNAO (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 19 Aug 2017 09:00:14 -0400
Received: by mail-pf0-f181.google.com with SMTP id c28so12798474pfe.3
        for <git@vger.kernel.org>; Sat, 19 Aug 2017 06:00:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=therightstuff.de; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=rRgXgCywiaIFj8hM6Y1khtIQLTs5bEIl5hb+powi3jM=;
        b=h83Pgb36vYKUUZZWWdslXc2PhYIT6XyyG4xYxGf/mr//XqMTFPkYC4/XV0ZjBrekHO
         6Da7CDzv7bmBwRftS/2ukkKOLkwOHRp3OhCUbO2UeSg6VSIlLaMmYBoWOQZjXIU+zYLb
         YysaGnjQKzIqjM1GGApjqHlO9fwinJsNsnLc8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:content-transfer-encoding;
        bh=rRgXgCywiaIFj8hM6Y1khtIQLTs5bEIl5hb+powi3jM=;
        b=K0727CaFffPfvMKPGeRUjPuKVqzo4xJ0+1oUVTQTvrdWzFapikuq1imoXahIxNVBd9
         PLuDW1bFeS5RpEsZK1dln1/+Y2LE098aR0i+JIsDoir6vEHBjIYIBi+Nvqckkk4Z+2Mn
         e84Y46bv22Wlj3NHJGZNdlbyLqJPf+WVh1MPffnwuxCdEwlJWf7c8gorNCafLQCj2jAk
         lW6+OiQJspenE2PUejMpfJOuJs8aH4RMUhCVeDv0Q6W2UkaSAw8vA09Z59XLaoAk1+s2
         VnOGLYGBu7+gdGwMN9XfJb3h8991h5mCxupql1HtkFE1zpRteR7xuMIK3aFzi8inGGat
         DWZg==
X-Gm-Message-State: AHYfb5hBRMEQ3+fxA48OHQsNZsWn0GlHALzOEk24LPuGI/fx1f1MAzEz
        RHw7RI91NWp7LXbL3xdFa5KRkuPD39ht
X-Received: by 10.84.236.6 with SMTP id q6mr12867967plk.341.1503147613871;
 Sat, 19 Aug 2017 06:00:13 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.100.149.7 with HTTP; Sat, 19 Aug 2017 05:59:53 -0700 (PDT)
X-Originating-IP: [84.165.122.243]
In-Reply-To: <165f5000-df53-0b62-6b06-d628a09d3076@gmail.com>
References: <CACcHa=NYgir8HDeR1ES9mKsqTQYk=90Z38csTgK-vfD=fQmHLg@mail.gmail.com>
 <165f5000-df53-0b62-6b06-d628a09d3076@gmail.com>
From:   =?UTF-8?Q?Alexander_Gro=C3=9F?= <agross@therightstuff.de>
Date:   Sat, 19 Aug 2017 14:59:53 +0200
Message-ID: <CACcHa=M_9xaP83=gha3Z4KNd12MfC+C1hE3hOMv-qjQBtMt0Ww@mail.gmail.com>
Subject: Re: git svn show-externals output format
To:     Andreas Heiduk <asheiduk@gmail.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> My practical solution was to skip the man in the middle and ask the SVN
> server directly for the property values

Thanks, that helped a lot!

Alex
Beste Gr=C3=BC=C3=9Fe,

Alex
--=20
Alexander Gro=C3=9F
http://therightstuff.de/


On Sat, Aug 19, 2017 at 12:14 PM, Andreas Heiduk <asheiduk@gmail.com> wrote=
:
> Am 19.08.2017 um 10:24 schrieb Alexander Gro=C3=9F:
>
>> $ git svn show-externals
>>
>> # /trunk/
>> /trunk/https://svn.code.sf.net/p/gc-webdav/svn webdav
>> /trunk/https://svn.code.sf.net/p/gc-webdav/svn@1 webdav-at-revision
>
> This is the (bugged) output of `git svn show-externals` for "new
> style" svn:externals.
>
>>
>> # /trunk/sub directory/
>> /trunk/sub directory/https://svn.code.sf.net/p/gc-webdav/svn 'webdav in =
subdir'
>>
>> An earlier version contains just one external:
>>
>> $ git svn show-externals --revision 8
>>
>> # /trunk/
>> /trunk/webdav https://svn.code.sf.net/p/gc-webdav/svn/
>
> And that the proper output for "old style" svn:externals.
>
>> It seems like the output is inconsistent. [...]
>
> SVN changed/extended the svn:externals format in version 1.5.
> (See [1] for details). One thing is - they switched the
> order of the arguments. `git svn` dit not pick up these changes
> and hence interprets the new format incorrectly. See [2] for
> a similar discussion - it is from 2012!
>
>> This makes consuming the output of git svn show-externals in HEAD
>> difficult because the parts are not clearly separated by space and
>> sometimes the path is the first element, sometimes it's a combination
>> of first and last elements.
>
> My practical solution was to skip the man in the middle and ask the SVN
> server directly for the property values with something like that:
>
>     svn propget svn:externals -r 42 http://my-repo-url/path/to/ext/dir
>
> I used the output to hardcode the values during the conversion.
>
>
>
> [1] http://svnbook.red-bean.com/en/1.8/svn.advanced.externals.html
> [2] https://public-inbox.org/git/E59CCE45-6F92-4748-9B6E-2A562647904B@nik=
olaus-demmel.de/
