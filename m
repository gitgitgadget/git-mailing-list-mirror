Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8BD3720193
	for <e@80x24.org>; Tue,  1 Nov 2016 09:07:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1168191AbcKAJHj (ORCPT <rfc822;e@80x24.org>);
        Tue, 1 Nov 2016 05:07:39 -0400
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:45111 "EHLO
        out2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1168171AbcKAJHb (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 1 Nov 2016 05:07:31 -0400
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id D44E2206F3;
        Tue,  1 Nov 2016 05:07:29 -0400 (EDT)
Received: from frontend2 ([10.202.2.161])
  by compute5.internal (MEProxy); Tue, 01 Nov 2016 05:07:29 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-sender
        :x-me-sender:x-sasl-enc:x-sasl-enc; s=smtpout; bh=G2MA8pY0MAVAWL
        2L4I30dTvO07k=; b=g4dF0gSZnrsVyNlsEgQNnWEnfj/UN7/1FTzaKbkHfsd8NI
        CEo7962rGA/eJJiJBWVlPWIwBFIKLNdSF8X2VFxDLnTeD6qDlyXqSQvfvpIktrNG
        aQqC7EbjGwF37CQNzjT+7LZUBH+6LRaYlIZd3wI+oq56SWYWdR2GZ9kuqF1rA=
X-ME-Sender: <xms:UVsYWH7NGzUFhA9jhwADxrmy9O6iRHmkl35y-bbAF_IzsXCDXULhNQ>
X-Sasl-enc: WbXjdfT+cigvLBRV0i0tpLVtRzWJk9ulzsaNmGNXvleq 1477991248
Received: from localhost (x55b3a9f6.dyn.telefonica.de [85.179.169.246])
        by mail.messagingengine.com (Postfix) with ESMTPA id 2A67FCC02C;
        Tue,  1 Nov 2016 05:07:28 -0400 (EDT)
Date:   Tue, 1 Nov 2016 10:07:26 +0100
From:   Patrick Steinhardt <ps@pks.im>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [ANNOUNCE] Git v2.11.0-rc0
Message-ID: <20161101090726.GA478@pks-pc>
References: <xmqq1sywrxxl.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="1yeeQ81UyVL57Vl7"
Content-Disposition: inline
In-Reply-To: <xmqq1sywrxxl.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--1yeeQ81UyVL57Vl7
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Junio,

On Mon, Oct 31, 2016 at 02:49:42PM -0700, Junio C Hamano wrote:
[snip]
>  * In some projects, it is common to use "[RFC PATCH]" as the subject
>    prefix for a patch meant for discussion rather than application.  A
>    new option "--rfc" was a short-hand for "--subject-prefix=3DRFC PATCH"
                        ~~~
>    to help the participants of such projects.

This should probably be 'A new option "--rfc" was introduced as a
short-hand for=E2=80=A6' or similar.

>  * When given an abbreviated object name that is not (or more
>    realistically, "no longer") unique, we gave a fatal error
>    "ambiguous argument".  This error is now accompanied by hints that
>    lists the objects that begins with the given prefix.  During the
>    course of development of this new feature, numerous minor bugs were
>    uncovered and corrected, the most notable one of which is that we
>    gave "short SHA1 xxxx is ambiguous." twice without good reason.

I think "This error is now accompanied by a hint that lists the
objects beginning with the given prefix." would be grammatically
more correct.

>  * "git diff -W" output needs to extend the context backward to
>    include the header line of the current function and also forward to
>    include the body of the entire current function up to the header
>    line of the next one.  This process may have to merge to adjacent
                                                           ~~
>    hunks, but the code forgot to do so in some cases.

This should probably be "_two_ adjacent hunks".

>  * In a worktree connected to a repository elsewhere, created via "git
>    worktree", "git checkout" attempts to protect users from confusion
>    by refusing to check out a branch that is already checked out in
>    another worktree.  However, this also prevented checking out a
>    branch, which is designated as the primary branch of a bare
>    reopsitory, in a worktree that is connected to the bare
     ~~~~~~~~~~
>    repository.  The check has been corrected to allow it.

There's a typo here in "reopsitory".


Regards
Patrick Steinhardt

--1yeeQ81UyVL57Vl7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAABCAAGBQJYGFtOAAoJEBF8Z7aeq/EsORUP/RrEwaZSy9zhsqS4gDvflfgN
qhmrxdDbR7lIQ/oNzGMbM5WnrrBisKUmlaxXqNI3u3oBgjTU7MgeduPZmCWR26dC
JSo2zc+yMCuRF5dASlHAKsxkEjw642Bl1j9jPFDH+1mzefSGyc/7vv0UfUzSxElP
2R9NiXHtvbiHyr2cojyl1WfPGEmebanrBmwk7MjkCoXPfaGGi1D2QKrV5FAqIgj4
1Y7rfdKRvBaYZUITTlRvAMQx9rB00Cwoo9kqRbAmKpBMPrZnbAwS6yK2TIJmeoUk
vteVoeY7vTzp9UebXyh7KZzdt/sXy/KWcxSUa1HDLjWmNMSoO6Fa0YeY85DYfRH4
szURdY/lHwmDnAqyTpmpUH4jcuW+LrBHklPu3zG4k7FUnq+pxwZcfb6MP+yOrMyc
XPH+okZL7aQoj2fqTEpIM1sH2CJFgxAwop/vSxJwYYH0xFmyvNMJBrLRZj4sX7Uv
3hmbRyRdoX/gCp3QGpTBPDi1HIWcRzZd+7stOcCaH1cp5RduDJGfVAUkEpDarW/D
9UUsGdw2Wz6AZXGkx419dLjUWSnZ24gFSc2by6WZ1YMy8MJ8NrVLG/j8vtKpCoeI
Fi3Yc7y24UacA3f4W7MaDDKDGoPsuoNQBkCzy5+LgXQmgTEHaY4ixgr07Mj2VHUR
ATl3Oj+6uMPrp5/B4T1t
=YH2s
-----END PGP SIGNATURE-----

--1yeeQ81UyVL57Vl7--
