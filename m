Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1A20C7618E
	for <git@archiver.kernel.org>; Fri, 21 Apr 2023 18:26:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232717AbjDUS0M (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 21 Apr 2023 14:26:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229578AbjDUS0K (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Apr 2023 14:26:10 -0400
Received: from mout.web.de (mout.web.de [217.72.192.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CB9E19A
        for <git@vger.kernel.org>; Fri, 21 Apr 2023 11:26:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
        t=1682101558; i=tboegi@web.de;
        bh=q4gSvvVcKY+MDFMk+VM7O8VK2mvJHBWgS/aJsuytEqU=;
        h=X-UI-Sender-Class:Date:From:To:Cc:Subject:References:In-Reply-To;
        b=JMInn/w0skRfoN2y/Sx5lDC+X/p2NvFMwevFYgoGy3IFfZQXNj9XJAi5FvYYsLqLx
         qxixouF1ZRcBN7QPgrSrL30dJ8HPAvOLoOdoLvaOCaUiGeGZ7hUjZRp7IL9/N1EiZu
         /H/FUKdkSgUb1diutSwREuhh3Psc9eNME6viHD9/Z4kkACaVvA+AlUR1kF+83UKYJz
         /8rKGlY7J4egBdRq//yigaYuUPDA+yU7EFCEaKmxptc0JJS5rzYNJYwcm7BYOUQQN9
         crlgISEhmwGqFJdocd31J2U8COM3UXoXvP+or1c9kOhtCbURtQhIXryaA+ftBv2me8
         q1RtFIStV191A==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from localhost ([62.20.115.19]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MKMA1-1pbHx3035D-00LwH1; Fri, 21
 Apr 2023 20:25:58 +0200
Date:   Fri, 21 Apr 2023 20:25:57 +0200
From:   Torsten =?iso-8859-1?Q?B=F6gershausen?= <tboegi@web.de>
To:     Alex Henrie <alexhenrie24@gmail.com>
Cc:     git@vger.kernel.org, eyvind.bernhardsen@gmail.com,
        gitster@pobox.com
Subject: Re: [PATCH] docs: clarify how the text and text=auto attributes are
 different
Message-ID: <20230421182556.xxd4vrcksr6634ao@tb-raspi4>
References: <20230421055641.550199-1-alexhenrie24@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230421055641.550199-1-alexhenrie24@gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
X-Provags-ID: V03:K1:2OkzJU24lWJ2IJL31eFOz0b4U1t7zhaYhk6BLIy9t7YmtYPX1JP
 tcA/Aew+CMmTPYSI09cjwhTkF5KHHyWvYs+KTdiGi3Kc8Lfs/oVQ297DjqouRjF9Cg8+d/n
 D+9QTqwyv7Ptr7e8lFVbJzihi2rme6+G4CzGIpwryI6HQWJi38/Rj4PoTjEXKcnVg+qp/tu
 gphW1YWDpkeSRuQk1S7NQ==
UI-OutboundReport: notjunk:1;M01:P0:NEfKq32tMts=;3btk4xJl+TnDGDjyELpDf4wkBlb
 Qf1a9S2oxdq+8r3ct7pgWAKtak6hufPanwqMA3p8Xh0dxA8BkgJUoQJKGRL8zCKKMqCCJXFZZ
 mKeJebzxWdG07NrgYfp9/yaIyVY8xJ1qdbcyTmKVGlmV1wlwM9O9Q0IHmaKIy3pbku2nyyZHe
 ggHpXrMJLhrFEdy07n2e7Mi2zGNupsqFdAGhz1tR7Ra0E8pBibqLBfIbK412Z8BAFSqXat8qW
 zB8kNCe+/LWZdRVfBnlZJMySZ8h8pKfbDPiDpbtyD97yWuzwSTAZ55Pl1m5QEhVkslV81jKxt
 gIkMxp9MTiHJnuUjExKOrxbXthNA8vwTVni9IpcEPt52/YK1Rdmk1oGVHMXjW0GpVxn0qopX1
 1aCE60zZJOnEV3Bf7CtUZC7ZExaluu0jP1BXkEDoS2C68qWTQsJGipnIX4xBd0qDb33lUqFyK
 S1ARjusalbu5BbcUZXFUv5ublSZx5xoM3AMHMF20hzT2DnoYdxi1Oj2dja9hV+tsWo+IDS9xF
 8jdfwYgFcZTSMazQj9MTUhF5GgBIlr6ckbC9fB5wdIVwpBSjYyGJGgODkdSSzBk8kxDt6vpce
 OssYGPvWz8gVfnnom08rQP2+PqA0Y6tga7EcHiWqCEiDPnXl3HLKVr0Jd/SUwNRJdqNisgLiD
 UuVJniIqZH58IfG/eqq764wq3d/TBwYaUKB2Y0xaSiZGwjXtYe+fNqYeIq2774dXzhmXNAUWU
 ksW4XxgFSg41XYff93Mi+LF8MpyQ44ayHZwPj7My5KMIjJ4SrNJ2vo11EIz17va3MtA9+BPHp
 CAJ03OyMwLVPGV1jm+ZJJrMliEZ1RyOiHgVj4NLsSzD2DdpHhZ48ceU7kwi7vsH8HBRCN1bWL
 od2qv3nmfgZiDk/Xk9uIT12QXHIUewjeCOubv7kaSldcSV4OXcdmUsU93KJKH3smVQ0oimvzn
 PkhEiOYuzj9VY4V4hBwNWNzInRs=
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Apr 20, 2023 at 11:56:41PM -0600, Alex Henrie wrote:

Thanks for that, fully agree with comments from Junio.

>  Set::
>
> -	Setting the `text` attribute on a path enables end-of-line
> -	normalization and marks the path as a text file.  End-of-line
> -	conversion takes place without guessing the content type.
> +	Setting the `text` attribute on a path marks the path as a text
> +	file, which enables end-of-line normalization: When a matching file
> +	is added to the index, even if it has CRLF line endings in the
> +	working directory, the file is stored in Git with LF line endings.

Hm, I stumbled a little bit over the word "even" here.
But it makes things very clear, so this is good.


> +	However, if the file was already in Git with CRLF endings, no
> +	conversion is done.

But I think that this is wrong, unless I missed something.

Using
*.txt text
in .gitattributes
will convert CRLF into LF in the repo at the next git commit/git add

When you create a file with CRLF (no atttibutes), commit it into the repo,
and later add the attribute "text", the file may be reported as modified.
Not always. A `touch file.txt` typically asks Git to re-investigate things=
,
and it may show up as modified.
After a `git clone` it may be shown as modified or not.
End of side-note.

Setting




>
>  Unset::
>
> @@ -142,10 +145,9 @@ Unset::
>
>  Set to string value "auto"::
>
> -	When `text` is set to "auto", the path is marked for automatic
> -	end-of-line conversion.  If Git decides that the content is
> -	text, its line endings are converted to LF on checkin.
> -	When the file has been committed with CRLF, no conversion is done.
> +	When text is set to "auto", Git decides by itself whether the file
> +	is text or binary.  If it is text, line endings are converted as
> +	described above.  If it is binary, they are not.

Here we need to have the lines from above:

When text is set to "auto", Git decides by itself whether the file
is text or binary.  If it is text, line endings are converted as
described above.  If it is binary, they are not.
However, if the file was already in Git with CRLF endings, no
conversion is done.

I hope that I didn't messed up while reading this patch ?
Thanks again for bringing this up
