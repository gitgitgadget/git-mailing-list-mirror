Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0F81720357
	for <e@80x24.org>; Fri, 14 Jul 2017 14:02:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754066AbdGNOCr (ORCPT <rfc822;e@80x24.org>);
        Fri, 14 Jul 2017 10:02:47 -0400
Received: from mail-qt0-f182.google.com ([209.85.216.182]:36212 "EHLO
        mail-qt0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753830AbdGNOCp (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Jul 2017 10:02:45 -0400
Received: by mail-qt0-f182.google.com with SMTP id i2so62771138qta.3
        for <git@vger.kernel.org>; Fri, 14 Jul 2017 07:02:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nyu-edu.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=cswRmVVsw803fOEVf3XF88lHL10feE2Ey6bFZEgnfm0=;
        b=S+kRwfybpKTMJkrB2mnJwX3qEhumb4eSLtlYV4MEJC6LCNKXvryVo/pgR+JGSqmIjP
         LhT00AmI/46/qw55pvtdn9i1+8nwFtcL0Pe8z/JFFQXisPD/ysimhJnMzSzkpMGwhXf5
         uOt30sORNO5Qc1mUiv73pkLSHVJWVykTw8AHdt0BsOjT8G7eSJYfnZ+JX88SAhjyl/Y+
         e5bvnW28TbD2Yjx4VcosuCKyeqWZ4ROmPmJz+FtVem+0Caz1a6vjcG8UNOEu5rsJh6+a
         U2tUW7hf6Zek6a+oezhcGngwRhjEUy9E+X2De/hqkKOlPDwQ9gRcKYFSVENtUk07Gnhz
         9N9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=cswRmVVsw803fOEVf3XF88lHL10feE2Ey6bFZEgnfm0=;
        b=mVQHCqbI4FdD2I5/j6zr8U6fe/CBcnP39H7nkmwIDAUUp77htYSJxkOtqY8Abs3wvY
         RophXbHZg/46dZj2LfsgIer53gFZF+uZIv5K4km3dmiq2lbLJ4MVuuB6OQsZC3N2cGO+
         at8l6DHGdW7coCJBcFy5VBMWrdTJn3zkpX2u8EJ9wPjZv7u127hp2Vg3Fd8nH68EJTCM
         VFQB9I7LBs0SEvJ7U/58qRdR+ejZgBuIH/UhOoPDOA/NvBLYulLBn1oWceHnBrIdUfLJ
         VUSNUB3Y7/EWl0/D6o77u/J9If6DtAi1I4FCbaOBiJBwSIGlzOWFF5OGz1fncghhdjkE
         c+Kw==
X-Gm-Message-State: AIVw113xGDcIIkRK+ON3Tgk0qsg5gKYnjp3MlaTMRDeur9mOaj6YyJMh
        X2asjhce2j1Z5BfYEJg=
X-Received: by 10.200.53.243 with SMTP id l48mr11993223qtb.7.1500040964477;
        Fri, 14 Jul 2017 07:02:44 -0700 (PDT)
Received: from LykOS.localdomain (ENG-KCG295-01.ENGINEERING.NYU.EDU. [216.165.113.136])
        by smtp.gmail.com with ESMTPSA id y66sm6189455qkb.35.2017.07.14.07.02.43
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 14 Jul 2017 07:02:43 -0700 (PDT)
Date:   Fri, 14 Jul 2017 10:02:42 -0400
From:   Santiago Torres <santiago@nyu.edu>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: What's cooking in git.git (Jul 2017, #04; Thu, 13)
Message-ID: <20170714140241.mqg5256ml3grmrn6@LykOS.localdomain>
References: <xmqqo9snsy0k.fsf@gitster.mtv.corp.google.com>
 <20170714002754.jyck5qmykbmuado7@LykOS.localdomain>
 <xmqqfudzsq7u.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="gw67x2rvoilctciv"
Content-Disposition: inline
In-Reply-To: <xmqqfudzsq7u.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--gw67x2rvoilctciv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi, Junio. Thanks for replying.

> I postponed it when I saw it the first time to see if anybody
> comments on it, and then it turns out nobody was interested, and it
> remained uninteresting to the list to this day. =20
>=20

True, that's what I was afraid of, but I wanted to give it some closure.

> Now, after looking at the message again, from the patch description,
> I would believe you that you experienced _some_ trouble when the
> gpg-agent that is auto-spawned by gpg gets left behind (as I do not
> see any hits from "git grep gpg-agent t/", we are not deliberately
> using the agent).=20

True, this is what I could gather from asking people over at #gnupg. The
agent spawns a socket for a GNUPGHOME and leaves it open outside of the
home folder (and it caches the inode for the olddir or so).

> However, I could not convince myself that the
> solution is credible. =20

I think you're right on this. I'd rather have more people reproduce the
issue (some of my colleagues were able to do so, but we all were running
the latest GPG, vanilla conf) and find the root of the issue too.

> but the current directory of this part is the $TRASH_DIRECTORY,
> which is always created anew from the beginning in a test.  What
> agent process could possibly be running there immedately after
> creating ./gpghome (which happens with "mkdir gpghome &&" without
> "-p" just before the context of this hunk---if the agent was running
> already, the directory would have been there, and mkdir would have
> failed, which would have caused "test_set_prereq GPG" at the end of
> the "&&" cascade to be skipped.  In other words, it is unclear to
> me, and your log message does not sufficiently explain, why this is
> the right solution (or what the exact cause of the symptom is, for
> that matter).

I see. What is causing this (as far as my current understanding goes)
is:

1) First iteration of the tests is run, the .gpghome is created and a
    unix socket is created too. The keychain is imported etc. Tests run
    normally.

2) The test ends, and the trash directory (along with the .gpghome) are
    flushed, but the agent is not aware of this. The socket is still
    open.

3) The second iteration of the tests is run, the new .gpghome is
    created, but when the keychain fails to import and the agent errors
    out with ENOENT. The and-chain fails and test_set_preqreq GPG is
    skipped (as you pointed out).

This last bit is apparently a result of the agent trying to be clever
with the paths.=20

>=20
> Or perhaps the gpg-agent socket is created somewhere outside the
> GNUPGHOME and stays behind even after a previous run of the same
> test finishes and $TRASH_DIRECTORY gets cleared (I am guessing the
> "what the exact cause is" part, as the log message did not explain
> it)?  If that is the case, it makes me wonder if either of the two
> alternative may be a more robust solution: (1) running gpg tests
> telling gpg never to use agent, or (2) telling gpg and gpg-agent to
> use a socket inside GNUPGHOME.

I agree. In hindsight this solution seems rather naive. I'll dig into
the root cause, as well as to try to isolate the issue from a
gpg-version and gpg-config viewpoint.

> After all, "kill"ing agent blindly like the above patch would mean
> you do not know what other party is relying on the proper operation
> of the thing you are killing.  That sounds more like a workaround
> that a solution (unless it is explained with a solid reason why that
> is the right way to run more than one instances of GPG).

I agree. It is probably better to seek the solutions that you suggested
above.

>=20
> Perhaps everybody else is running these gpg tests without having to
> worry about gpg-agent already because their environment is more
> vanilla, but you have some configuration or environment that cause
> gpg to use agent, and that is the reason why nobody is interested
> (because they have never seen the symptom)?  It is possible that the
> part of t/test-lib.sh that tries to cleanse environment variables
> and other "external influence" to give us a predictable and
> repeatable test is unaware of such a knob that only some developers
> (including you) have and the rest of us were merely lucky.  Perhaps
> we need to throw GPG_AGENT_INFO SSH_AUTH_SOCK etc. into the list of
> envirionment variables to nuke there?
>=20
> Combined with the unknown-ness of the root cause of the issue, I can
> only say that the patch may be raising an issue worth addressing,
> but it is too sketchy to tell if it is a right solution or what the
> exact problem being solved is.

I'll dig into this. This sounds a way more reasonable approach.

Thanks for the feedback!
-Santiago.

--gw67x2rvoilctciv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEkDurc2QOttZVM+/zRo8SLOgWIpUFAllozv8ACgkQRo8SLOgW
IpWfRBAAoyTo90GeuTgrDklK3aL2rtrZWPcj+uUYVk2lMqU8FXJYEsI0ytmvmG4K
8+s/ge5BiTI8aKtxkCPEHzmolnb9p2ahKDv+64fy+8b3IozqtVO5naw/Y8CTtzgD
3YkkzuXk01lHU5Q64l8v2q6zndY03NoCrHRFzLj2O6uCW7BjXRJEKMmvokILGgOQ
3Xr0VRF5TiXkzVFU0Fz40tww1sK+OzWRbp+ydAivLtKtVGk0B1DIjgeWuwgTXAii
KLVIwrZZQktON/mj0keul5wDHKZAfwNvQnNaBXZG85BVBy/+tQ3HeJyj7WRT57mB
3psOvAZOk1q8dk5whUQlbX7OZ8RdWDyEr9KjiyAfKInICWijLcBC9MIiT6R6rT94
5Vgsmnr0njLSNW/16BUagGUEskxrntv/14HNohaTdlj1Qn+KIdaA9azWItvwj11x
GwZInMqybBgVecvVPqTLEKFMAOm77g+DcA0snmCdlSjnaSDMNTnQ+15vfhPx9MYV
DnPpZonZF3texyoQOcmScZLJ3XCus/k1W6BffLEHPQv1lGoYhUV11R4HxzMRGXTK
1bVwiYIb0GKBtsso0QR/Ykvh6ysr6voslJIBvoq4WL6lB2lelUlFYljuuWq9epk5
1qjg1sGrAZod7PFQetZwTwOaY9bOQZFXNcVUzvw7eFRZgQKzrzE=
=L/Q/
-----END PGP SIGNATURE-----

--gw67x2rvoilctciv--
