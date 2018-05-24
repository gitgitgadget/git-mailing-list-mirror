Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B2F541F42D
	for <e@80x24.org>; Thu, 24 May 2018 15:10:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S970832AbeEXPKh (ORCPT <rfc822;e@80x24.org>);
        Thu, 24 May 2018 11:10:37 -0400
Received: from mail-pf0-f172.google.com ([209.85.192.172]:34542 "EHLO
        mail-pf0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S970814AbeEXPKe (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 May 2018 11:10:34 -0400
Received: by mail-pf0-f172.google.com with SMTP id a14-v6so1044068pfi.1
        for <git@vger.kernel.org>; Thu, 24 May 2018 08:10:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:subject:from:to:cc:references:in-reply-to:date
         :mime-version;
        bh=llDD+qDy5mX+UlFrXIa5DPXcSKNFUJOe+fN9JOM1oLY=;
        b=Xw1rfxThuMXSdysEXRwipss+Ul98PWS5fJwXcfLK0S3KibF7HOQHXvvvuHpct0zFrN
         XZG3f10HtquI2N2i1PEnXFoRkI3p0eJT+ma530FKx3GxO/01nNQnF/nz6nHIFxPSplm9
         EVLnrAiaPSH5dcXpS5C1Q0ENeNzsjTtQVxE6ZnSZULRyp93jh9Tcgg5VU3XqIDVZeZog
         QvvOq3UTOJyuN9WSr+fdjqSDYi9iOjIAuu+Bea6/st6WZe0ql5mYUwMgpMGpJ3Zj9JqP
         1uREBP464ogEyrAsK3n7D8zQW3fVBhpBBvKURXcAsE9Do96ppLPJkBxZlRxR/9KKhiNf
         aGdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:references
         :in-reply-to:date:mime-version;
        bh=llDD+qDy5mX+UlFrXIa5DPXcSKNFUJOe+fN9JOM1oLY=;
        b=b3FAnhM5MposHnPfrrZ3yLN/NNMiBxkGSSGkLuywfjm3AfjIaPp4Ez1St02pUI0INx
         z7d9lFP2J36C+Zeh/OZnD1zeyjLZZ4Z2BJYQpXKmw4YDrzOuNzYwl6cBGPBWlC12zlFX
         RcZHX3sGyDRSbaUdjnc8irXYb5mu7dBvyANDeWt/9XzxaelLXlDYxa6L8MU6cXWP5CoZ
         t7+aHE+cuIdUl5VQOT0ysHJz+Un2I1I9bWdohc/E1O1fH3/fmbfj/5UWSawEXw1YEPgS
         iYxBnDI3ksYozTo5jhVI+BCwTJYXbblEG1z8c33pid6IISrs/mxYPyNntYvfqMx/wFws
         5gSg==
X-Gm-Message-State: ALKqPweo1iMn39+df9G3x3j/IWaizPQsWjIZgouH9MuvFFZUVfXbMbNF
        VOjOg54CwgN1+Wk+tnHAnmU=
X-Google-Smtp-Source: AB8JxZpyLljswa/IQX78/y7ThgMbzzvlejcG2iv5VY14pQy11C12RjA3rgebt9xjWNkkd6vqpKqCYA==
X-Received: by 2002:a65:4282:: with SMTP id j2-v6mr6220171pgp.189.1527174633553;
        Thu, 24 May 2018 08:10:33 -0700 (PDT)
Received: from unique-pc ([117.209.146.54])
        by smtp.gmail.com with ESMTPSA id g64-v6sm41622457pfd.50.2018.05.24.08.10.28
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 24 May 2018 08:10:32 -0700 (PDT)
Message-ID: <1527174618.10589.4.camel@gmail.com>
Subject: jk/branch-l-0-deprecation (was Re: What's cooking in git.git (May
 2018, #02; Thu, 17))
From:   Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
To:     Jeff King <peff@peff.net>,
        =?ISO-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
References: <xmqqvabm6csb.fsf@gitster-ct.c.googlers.com>
         <e440f6e0-6d7d-0e72-b875-de290cea6b94@gmail.com>
         <87fu2qbojy.fsf@evledraar.gmail.com>
         <20180517133601.GC17548@sigill.intra.peff.net>
In-Reply-To: <20180517133601.GC17548@sigill.intra.peff.net>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-M6G50yUPwu9s3rLD1m7U"
Date:   Thu, 24 May 2018 20:40:18 +0530
Mime-Version: 1.0
X-Mailer: Evolution 3.22.6-1+deb9u1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--=-M6G50yUPwu9s3rLD1m7U
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable

On Thursday 17 May 2018 07:06 PM, Jeff King wrote:
> But because git-branch does not kick in the pager until later
> (because it only wants to do it for list-mode), that happens _after_
> we've emitted the message.
>=20

I observe exactly the consequence of this behaviour. First, the error
is emitted and then the pager kicks in to list the branches.


> On the other hand, I'm not sure this is that big a deal. The point of
> the deprecation warning is to catch people who are actually trying to
> use "-l" as "--create-reflog", and that case does not page. The people
> doing "git branch -l" are actually getting what they want eventually,
> which is to turn it into "--list". In the interim step where it becomes
> an unknown option, they'll get a hard error.=20

I just thought we wouldn't want to surprise/confuse users who try to
use "git branch -l" with the warning message about "create reflog"
along-side the list of branches. That would just add to the confusion.
So, I thought we should error out when users do "git branch -l"
instead.=A0Something like the following should help us prevent "git
branch -l" from listing branch names and might also prevent the
confusion.


diff --git a/builtin/branch.c b/builtin/branch.c
index 452742fec..f3c5181bb 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -672,7 +672,7 @@ int cmd_branch(int argc, const char **argv, const char =
*prefix)
        argc =3D parse_options(argc, argv, prefix, options, builtin_branch_=
usage,
                             0);
=20
-       if (!delete && !rename && !copy && !edit_description && !new_upstre=
am && !unset_upstream && argc =3D=3D 0)
+       if (!delete && !rename && !copy && !edit_description && !new_upstre=
am && !unset_upstream && !reflog && argc =3D=3D 0)
                list =3D 1;
=20
        if (filter.with_commit || filter.merge !=3D REF_FILTER_MERGED_NONE =
|| filter.points_at.nr ||


--=20
Kaartic
--=-M6G50yUPwu9s3rLD1m7U
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQJPBAABCAA5FiEEmrp5T6QugsbUnN0Nveda2sPWGWkFAlsG1dobHGthYXJ0aWMu
c2l2YXJhYW1AZ21haWwuY29tAAoJEL3nWtrD1hlp0FsP/3lMvJ8zAj2apoSZ9NRi
j+CPwknjzqYFhl2/ac6ggryAKc6ipEY9htYzpCDJS0LV8+BnKGp/WLERiw8/8kcx
Xv1QulB/JhPnombdwC/9JVN1MVLasgcr81myHzbmkva2ioCG40c2e89Eq1TFC+zV
5TxyvPDRA9xryq+XFaGN6cU9HVAjTh7MlyqY1961d6Cra/xEAjdJ2q8A9M8Oedow
f/6/LUHtCSaIfy+OYGbnkSpRID/5PSgDX+MroD9bIgiEbnYwaj8tQeGF+cDa1hvJ
aaURucHS31G1Inz6re45zjim1IT+bpAAdXW6Wed26TUdNeu3ucjJIXC+Ll3JUkcB
Uf1l0fhH96lgaLnHj8haX2qKEBaqN6A34rfQpmnSvg/eYBh6wHW/AdQN31Ftkduj
GA2jZwZk9qKhPRSvFfBscbp/EZ98iMKXqeYo0p2A28Yee9700d5sKYgGKo9nTlug
hc5yx3pBYc65HWMsvCHIbNeTYWNVXZYEj/xmVWXUxHz2uUOq3ci8MHcIGsz87Y7L
X4g25gec2c/fqKKwrkHtu9S8XjHGHpm5Wibb7Js/zgoDUdLeLbTTiWCDNtlbAnoP
En/rgPvyTySyFV3nX9UKjKd1fb/IZamRJgybs3Yf48v9agSjvtF3Oga53s2dHVhP
MbTo2ogbNQ9n3ZAHbHYX6av/
=TJSv
-----END PGP SIGNATURE-----

--=-M6G50yUPwu9s3rLD1m7U--

