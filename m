Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BB82C433E3
	for <git@archiver.kernel.org>; Tue, 23 Mar 2021 16:38:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F0872619C6
	for <git@archiver.kernel.org>; Tue, 23 Mar 2021 16:38:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231225AbhCWQhh (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 23 Mar 2021 12:37:37 -0400
Received: from mout.web.de ([212.227.17.11]:51133 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233435AbhCWQh1 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Mar 2021 12:37:27 -0400
X-Greylist: delayed 304 seconds by postgrey-1.27 at vger.kernel.org; Tue, 23 Mar 2021 12:37:26 EDT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1616517444;
        bh=jdfApWxQwHxn1t9j5OvoeFqop3XEeUSCBZJ4UAtncbk=;
        h=X-UI-Sender-Class:Date:From:To:Cc:Subject:References:In-Reply-To;
        b=VX1oPmLrrZXchvifXabXkRg6pj942vSJgv1kqfgUcsC2sG9YId5jJ4pmzEltdRYVT
         zbPBUkMW9BlYcPzovhrJFJpSWpTMtUT82dZUPu/6RANjEoRjmuq6Kixk3yy9VQF1/V
         /wYuf5yafDkL3X4Fx+h47YoAdBGn3XyWPNWuTjD8=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from localhost ([62.20.115.19]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MFJnX-1lRDzs47DN-00FRwj; Tue, 23
 Mar 2021 17:32:18 +0100
Date:   Tue, 23 Mar 2021 17:32:17 +0100
From:   Torsten =?iso-8859-1?Q?B=F6gershausen?= <tboegi@web.de>
To:     =?utf-8?B?5byg5Y2a5bmz?= <boping2010@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [MacOS 10.11]uninstall git client
Message-ID: <20210323163217.2gbqphbw7dopvcxb@tb-raspi4>
References: <CA+cd+tU8AMDoAdDNMP4cwgRFN+YP_PfGzDwHHzS3DOhQvUhpkg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <CA+cd+tU8AMDoAdDNMP4cwgRFN+YP_PfGzDwHHzS3DOhQvUhpkg@mail.gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
X-Provags-ID: V03:K1:494eoB93iUYNro1AMxSeKGbrYJL1xH9CHrskT8Sr0Lvdjzrms43
 Fh+pGpTk5IlFAtJ2MbYiiJBc+H6A4KtYDjGO+8JJALqf/E6ZdJbnKqY6SavA1jIgN4qUB0c
 JlhyiG4LkUE//caBN4XHpVMjSZ9WftDVTMIncDB/IX8/kBDgdZajMRvxrbNq4ux6bUjdpVM
 aWQS5wHgpJXkdGb4/KrMg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:kerqmKv11zY=:qXXhtN/Chwi/VwoGhiiuDI
 EGplfPZoCQVUurO3xBl9WFA1RNhw6LdQ3eXkfNAj3GJVT3dQuBA8oVwPRtTQeyoIseGolLtOr
 oDwhoUL8JWTKBqa3lUKJqtBQsIAB0z+MObRArBmXtn/dsp8rQbk22XdXvk2ypyjuaObgmCoud
 bLxKh5fuhAyEATUdGMOzMUaIf/gvJeZeuMdJpMW6qHBk/8+TfA4T4D2t9XU+iWQYx6XYMA0+s
 sdgY/Tv/wNXxR8k5oucONz1xdR8Mu+zcgkAWo1E0VHXD9RnTFazSd3SEMoHdZ/PptYWlxd3Fq
 QsA4jMHV72LXGMQ9dKCXupgJTsNZcWRlicpmgemAcjav355VlLOzOc2wDXeFqcLafIuwqhsFk
 0JMLxbSuGeNZGAHurUbSW+o1g3nRC/imaSbO2UYjNyppc8pmA8wEcOJUbd174GrJF78Z0gdri
 hdMJ3rSkqLWsYxKdzsrWUagHBWfNHpnLP+MmMR7uSoidULU4y+7MWslnF6C3uY+l629+7w6y3
 Urt4rWBBPavMvfnYVVNSi0eJrz2b37FXtzxKgKUZtfXWVbnpUFzI1SxYfVJa3gXw2Xq5Ywl/+
 DcQDsoMyQ6LyK1OQc0ebfqSFKgiCqx4tCHQhbf8i49x6GqdcjZICEU8WO5/ZAc1lj+hJvW2W+
 XTPSWLieLAFK9nA6ygCsvs14mFUI7yXSCvUCq9llA5MYTx/+z7YlDfSEo7uTHAfty2bqvLHrp
 ONu7aOVSDTkpS1DkdUXxC97/eqyEnT4z968sfmhSI5WjDSGfeF3L4Y9rSupI+YrFGfDkE8O8c
 YE5UhMYZdCdYRxdeSaPmbfckcwi3n8b/4X+AUBVCQqX8fNG2Mm0p3T2Osl2T+OnTDFkZiY0Fy
 NvQcbubaaS8KiB2vjytgGQDsvUxPLwoH+5hwY2AvDNSn5tTumnUDVGtOI0wwoojzw6ALxK+R+
 USXhHXS8CJ+lc8PFurPkzQow37A4dhIlDzJPo6S4BjRPKTJPSj1MpgzGHhr+kt/ftAwih3125
 8u0Ggeybxpmu8q+5FUXPk1HQHXxFqEU9fPQj1VRrb1B5XYclr+9G/xKSq+9Z9X6H0VBELAaEQ
 UvrpVZPPP5jhfqJdy/xWZkJPpKxitpJ6Zn6DKvouaGCfyK4tOzSAK1cRhkqaTrYt8qdeejx7Q
 +BPLidXPESVYR9wZ1J6AvXDk8uS43b4Rub7PxV7XZ8jLV6a6Ee+JOff+2Ftm7GNdj8ato=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Mar 23, 2021 at 02:20:25PM +0800, =E5=BC=A0=E5=8D=9A=E5=B9=B3 wrot=
e:
> How to uninstall git client in MacOS 10.11?
>
> I installed git client to /usr/bin/git, but I can't uninstall it.
>
> run 'sudo rm /usr/bin/git', NOPE.
>
> disabled 'csrutil' and remove again, NOPE.
>
> Do you have any shell script or some tools to uninstall it?

What does
/usr/bin/git --version
say ?

On an oldish MacBook it says:
git version 2.10.1 (Apple Git-78)

So typically /usr/bin/git "belongs" to Apple
- and that may be outside the scope of this list.

Out of curiosity:
Why do you want to uninstall Git ?
