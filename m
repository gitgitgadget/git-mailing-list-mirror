Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 182C31F45A
	for <e@80x24.org>; Mon, 12 Aug 2019 16:50:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726796AbfHLQub (ORCPT <rfc822;e@80x24.org>);
        Mon, 12 Aug 2019 12:50:31 -0400
Received: from sonic306-2.consmr.mail.bf2.yahoo.com ([74.6.132.41]:35061 "EHLO
        sonic306-2.consmr.mail.bf2.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726457AbfHLQub (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 12 Aug 2019 12:50:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aim.com; s=a2048; t=1565628627; bh=hK8Fu3GWFKf2LV9XX59QoAOMHqUcKhCh7DiOxU3XrFQ=; h=Date:From:To:Cc:In-Reply-To:References:Subject:From:Subject; b=S9Z+JQtSSEEbIxd1/xsCt4ns+pfOBP1ICCG8CO9cYjxgqn2ltD17U4IqJMWG0Jd2V8lz5jT8EsMdh423LqBSazqrZYS1o1kRfO9/Qg+GVOgvYjMXtFsJ9cGgHmPAQ4SKyZjqPxlwGXPei7HzkPfp3vWksD8f+r9JcbANXko/fBAaFlc6JsD91LdAuNaBMBOpkoFlSgEsTwtUX9UyqXxbrY2DRpzC3bZGyana8kBXjcxkx+/KGGT/9Vfxb4eaA+tFpaD43PbpkIJ09P8CKGC29gXmlcUautwgvo/0TH67YdKxZYBgn4+F1XcnMsrzpwWQXgUGwcz43pTvA/zUjhh1Rw==
X-YMail-OSG: sSTvc8QVM1nWQXdadBAQFNijX_Iv3BWFoJHEIh6cB3v3zRBk_8lEauXuEM2nf0e
 Fc2Iz5m9is4tcnigOIMPvD0kxPfom43sA7nDrl17OlGHEPHhkifMKpWuuOgHUPwcIxAjjW2Kq0gw
 R2oxe8mdiq6d4oOTqzp_ZBo0TjQXewKYPY4BumWg968z8rV.dG.YuWsbqDcGDFq04AQJAqR8hNRO
 bPRxAeMKzXJuFFw6.20f0uav73MTu09zupECs9bO26Fuya3Fc.qk5hCgkf_IkcVWzwx75woxIz8c
 5RxNZHzLwIemEIO._u8trVSxRvhmtYlzQWYsOSE3N2o09X86KoUpVS74Fe4Bp.jgfKxzL2cSZk2d
 4R5BHFjq3hf9nw5sbshsZZz9xiG2GwAVseWsPskBm84w3k6h.TqXFTFs4NhbGyqNH7WXfU_W8L8H
 0AWMHFpiCd9s3SU.R64Q8CFHs4gHPrMvyWxI7B2N_zZKKEhrkepgwsQNKLQR8Jc_oj23FN08UkaL
 L2c76m6w.U0QO.sXfGLS.at.sc5TZiVXAhqEi6gi9h5Tpeei4wBGWWAG5AgFdDjWjMvjvbS4rwvC
 YLDOEjZ2UeEoLCs2gxOegPlwzvNdggGFFy4Up2pE3aZyXPRdUBODLYjVByQdrQWey.exT9w9gx0e
 6LaWfyUS9stJ2tD6h7RbxoN80JGS9OmGcrNapFe9_W0XbS9_x5Aihb2OeusnI_tFbxoWpQBO6qh1
 Mj.bmSEWiikoKo4PtNdf_fakfnamx6rsBivzavS78s_cFQDzKdemTQjuUqk9UMyDtBUNFkZ2EAjJ
 65jpjv9QrsIf0w.pPXT0qKSur46Jmve1Bxz1MWzTfb8BAU573xAPjVvRIshInJslBAeq7KoeHfWT
 tkiVsKeJdqOxwfvGdv7OyrMLauxRreX1x0ySxDcbhdR3rKgcCEJikMQ6rmmDcL5G1wHHY18xZTlt
 rrbRJ2f3ySliifuVzD2wKE7n0QeqTcE4DOD.O3..iISiYGH7q.AvNcVtjNl07orv6hnFkxd.8r0h
 fZtJoEkcgaCeGwTesQVgYSA5lX8xZQUUrLcYUQrYlqokw8OYipOorOjau9hEKMGztWD3gLuRDajZ
 dMuC.BaXmxjTIhr.t6qnxLJYEuhZxvA5PJaDrm5b1b75XVG9XaldSkfBdQPg.tRAVSZPWdOgsahi
 0hXkqdc6vF05WhnAaPaOzeGDznDECiyDmC7uKRQkYGsZVA4cWjSV3TtnGG3WfOrhSmw--
Received: from sonic.gate.mail.ne1.yahoo.com by sonic306.consmr.mail.bf2.yahoo.com with HTTP; Mon, 12 Aug 2019 16:50:27 +0000
Date:   Mon, 12 Aug 2019 16:50:12 +0000 (UTC)
From:   geoffsimons@aim.com
To:     peff@peff.net
Cc:     git@vger.kernel.org
Message-ID: <1329290481.3118350.1565628612179@mail.yahoo.com>
In-Reply-To: <20190812163517.GA26231@sigill.intra.peff.net>
References: <1229468090.3098018.1565627099656.ref@mail.yahoo.com> <1229468090.3098018.1565627099656@mail.yahoo.com> <20190812163517.GA26231@sigill.intra.peff.net>
Subject: Re: Git add claims path is ignored, but git check-ignore returns no
 results
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Mailer: WebService/1.1.14097 aolwebmail Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/76.0.3809.100 Safari/537.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


Hi Peff,

Thanks, I didn't think that would make any difference either, but changing =
the case resolved it! I'm now able to find the relevant line in the .gitign=
ore file.

Regards,

Geoff

-----Original Message-----
From: Jeff King <peff@peff.net>
To: geoffsimons <geoffsimons@aim.com>
CC: git <git@vger.kernel.org>
Sent: Mon, 12 Aug 2019 17:35
Subject: Re: Git add claims path is ignored, but git check-ignore returns n=
o results

On Mon, Aug 12, 2019 at 04:24:59PM +0000, geoffsimons@aim.com wrote:


> I can=E2=80=99t find anything relevant in .git/info/exclude either, or an=
y of
> the .gitignore files I could find.
>=20
> git check-ignore .\Source\UI\Website\LiveFeeds\Releases\IO\ReleasesSerial=
izer.cs
> git add .\Source\ui\Website\LiveFeeds\Releases\io\ReleasesSerializer.cs
> The following paths are ignored by one of your .gitignore files:
> Source/ui/Website/LiveFeeds/Releases/io/ReleasesSerializer.cs
> Use -f if you really want to add them.
>=20
> I get a similar result for adding files in that directory, or the
> parent directory (releases), but the grandparent directory (livefeeds)
> works fine.=C2=A0 Any ideas what might be causing this?


I notice that your "add" and "check-ignore" commands differ in the case
of "UI". I think both commands should work correctly when on a
case-insensitive filesystem (and a few checks I did after setting
core.ignorecase manually seem to confirm this).

But maybe try it with "ui" in the check-ignore command and see if that
changes anything?

Another thing I notice is that you're using Windows-style back-slashes
for the path separators (whereas internally in Git, everything is
front-slashes). AFAIK that's supposed to work everywhere on Windows, but
I wouldn't be surprised if there are corner cases where it doesn't. Does
switching to:

=C2=A0 git check-ignore ./Source/ui/Website/LiveFeeds/Releases/IO/ReleasesS=
erializer.cs

help?

-Peff


