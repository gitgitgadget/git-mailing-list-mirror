Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 232D9201B0
	for <e@80x24.org>; Sat, 25 Feb 2017 23:22:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751926AbdBYXWm (ORCPT <rfc822;e@80x24.org>);
        Sat, 25 Feb 2017 18:22:42 -0500
Received: from mail-qk0-f181.google.com ([209.85.220.181]:35178 "EHLO
        mail-qk0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751885AbdBYXWm (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 25 Feb 2017 18:22:42 -0500
Received: by mail-qk0-f181.google.com with SMTP id u188so52774845qkc.2
        for <git@vger.kernel.org>; Sat, 25 Feb 2017 15:22:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=dYRKLiQMOH/UBsFgeHoY6EpUcMqGxeOJ2xXhLnI3C74=;
        b=WcZFQn364KZUShz6Atimndzt1TPXODr88aLw8LNFD0OTcClN6e9PwNnDVQ1tNmUvtW
         4/hUbxPy5xPtrimHk1CjbbdjeW9hZ2I2cJQGKLypsvkPpA1NDt6WCIDkZxNnrfS6lxZ4
         1H/6XIDatQ98x3WQsvp8EUsvLFjKOMnHWQDeVSi4SCA/KDAG7+NmC95OWchkoEmSRuav
         +RxBG+4sQ96wEVY73WW+T8x4Fg98Zm1HTLMLneU7HD9Q3UqHsFRQ5PcM9AZnqJHpdKQa
         WXvOxoB1c50+hIpMeZbC4MagumQlCdVG7/0sc/DpSVpSrdWuu7HllBUTe3N31Hm1XLnr
         Xiug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=dYRKLiQMOH/UBsFgeHoY6EpUcMqGxeOJ2xXhLnI3C74=;
        b=Tw5glkz34jlA0naWrgykXNtZh4pl7xh+InKUtZcghbDLq53L0d0NzN3wyBUp7lUE/N
         C1X4YqenSrIHI65V0SdMM2drYEHjl3vl2GHHFJ/APmpPZxHu6bP+8hlns5/ifB2GfSOL
         jLxn3z45ZCXd3d0CcrgfgjLocXCxxpCFbo9gia/cq/64Mq6s5UQlg9+q9VGsMdRE0o6m
         1B39DhF2g6yipNYO2ugaDM0tBqtIIiLiNyKflOaIiyqLlzE7xp6jP036+fZt9lmOLJsV
         dApzFw547kv7qiWQfwheDF5eoH4ajDKoPE00bYquPhP4Wbd4Mgpdn/sjRSD2AUlTaz2Q
         +2bg==
X-Gm-Message-State: AMke39n2b4Hoou0RAPCm98FjAunGtkDOfGxkJNNRc2W0SWbvVsTNcAwcZVMnTxy2e+8WWzUS9Bfamh7VkIT5gw==
X-Received: by 10.55.146.4 with SMTP id u4mr8983705qkd.37.1488064961021; Sat,
 25 Feb 2017 15:22:41 -0800 (PST)
MIME-Version: 1.0
Received: by 10.12.134.218 with HTTP; Sat, 25 Feb 2017 15:22:10 -0800 (PST)
In-Reply-To: <20170224172335.GG11350@io.lakedaemon.net>
References: <20170223164306.spg2avxzukkggrpb@kitenet.net> <22704.19873.860148.22472@chiark.greenend.org.uk>
 <20170224172335.GG11350@io.lakedaemon.net>
From:   ankostis <ankostis@gmail.com>
Date:   Sun, 26 Feb 2017 00:22:10 +0100
Message-ID: <CA+dhYEUTZMLKfBXSHU61qx5i9P6a0muUcyAvnNKzc=_E5-z7wA@mail.gmail.com>
Subject: Re: SHA1 collisions found
To:     Jason Cooper <git@lakedaemon.net>
Cc:     Ian Jackson <ijackson@chiark.greenend.org.uk>,
        Joey Hess <id@joeyh.name>, git@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 24 February 2017 at 18:23, Jason Cooper <git@lakedaemon.net> wrote:
> Hi Ian,
>
> On Fri, Feb 24, 2017 at 03:13:37PM +0000, Ian Jackson wrote:
>> Joey Hess writes ("SHA1 collisions found"):
>> > https://shattered.io/static/shattered.pdf
>> > https://freedom-to-tinker.com/2017/02/23/rip-sha-1/
>> >
>> > IIRC someone has been working on parameterizing git's SHA1 assumptions
>> > so a repository could eventually use a more secure hash. How far has
>> > that gotten? There are still many "40" constants in git.git HEAD.
>>
>> I have been thinking about how to do a transition from SHA1 to another
>> hash function.
>>
>> I have concluded that:
>>
>>  * We can should avoid expecting everyone to rewrite all their
>>    history.
>
> Agreed.
>
>>  * Unfortunately, because the data formats (particularly, the commit
>>    header) are not in practice extensible (because of the way existing
>>    code parses them), it is not useful to try generate new data (new
>>    commits etc.) containing both new hashes and old hashes: old
>>    clients will mishandle the new data.
>
> My thought here is:
>
>  a) re-hash blobs with sha256, hardlink to sha1 objects
>  b) create new tree objects which are mirrors of each sha1 tree object,
>     but purely sha256
>  c) mirror commits, but they are also purely sha256
>  d) future PGP signed tags would sign both hashes (or include both?)


IMHO that is a great idea that needs more attention.
You get to keep 2 or more hash-functions for extra security in a PQ world.

And to keep sketches for the future so far,
SHA-3 must be always one of the new hashes.
Actually, you can get rid of SHA-1 completely, and land on Linus's
current sketches for the way ahead.

Thanks,
  Kostis
>
> Which would end up something like:
>
>   .git/
>     \... #usual files
>     \objects
>       \ef
>         \3c39f7522dc55a24f64da9febcfac71e984366
>     \objects-sha2_256
>       \72
>         \604fd2de5f25c89d692b01081af93bcf00d2af34549d8d1bdeb68bc048932
>     \info
>       \...
>     \info-sha2_256
>       \refs #uses sha256 commit identifiers
>
> Basically, keep the sha256 stuff out of the way for legacy clients, and
> new clients will still be able to use it.
>
> There shouldn't be a need to re-sign old signed tags if the underlying
> objects are counter-hashed.  There might need to be some transition
> info, though.
>
> Say a new client does 'git tag -v tags/v3.16' in the kernel tree.  I would
> expect it to check the sha1 hashes, verify the PGP signed tag, and then
> also check the sha256 counter-hashes of the relevant objects.
>
> thx,
>
> Jason.
