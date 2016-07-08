Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4583220705
	for <e@80x24.org>; Fri,  8 Jul 2016 00:36:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753776AbcGHAgw (ORCPT <rfc822;e@80x24.org>);
	Thu, 7 Jul 2016 20:36:52 -0400
Received: from mail-it0-f67.google.com ([209.85.214.67]:35489 "EHLO
	mail-it0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753132AbcGHAgu (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Jul 2016 20:36:50 -0400
Received: by mail-it0-f67.google.com with SMTP id g4so172786ith.2
        for <git@vger.kernel.org>; Thu, 07 Jul 2016 17:36:50 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=pwgh/aHH0xa2h40grGWP2gqFeLmo2C+NHd6fvxGkpTA=;
        b=wKhOXUcYz5wryw4hNbfdbVDbcCzkg2NIs/2X3WLjNS6YRg9etekrs9kvfp+/PhwwY3
         4YCkNuioHYL/Z9ThgA5Ez5v+f43IoKH+6Q8JAjrzkngsE9vphAmkYylNKNFKd+duWvT0
         5fAuFsX1BkA6OKhNjChzL09Jkkyfpd+Cx8pJ4NEbGskZMpHiF8uoV+KO/wTYKX2RfpHF
         SeQmnVReyodbvyk55CwPdH7QI3FOAmX+6Gb3sBfEHVZ/fTkE8b4AnfQN/r3zCEjTvqwS
         2mRKJVfJ1HucUruQ6uEBqd27qyvvEXkqH1C85iRzCpuTXBelilUfCWwetLSlk2KNUzuo
         MJOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=pwgh/aHH0xa2h40grGWP2gqFeLmo2C+NHd6fvxGkpTA=;
        b=msFhhfSnIoxaRpXlU+c/KdG3jUFOeTXK4inPWq67KKqvYOKMqzlOQhtgZgphlI5FRJ
         rI0WI14c97XvJRhyIrsUO0ajYwNXZf2OcTCKprfd4v0ktTWPcngfe2O9QdbcZf0pnkDl
         AW2F9jC8SmaQchk/NzSlfqwrnfSrkcVGCLi+fZZp/90o4Sr/J9tHSN1Estp4Yhd7rUWX
         k8Myliqv3NFVipAchjLSxFToiHDQ68addC360gOHs45ITpYaLoo/30GUXW877jLUiXpy
         0OG+MtS8KAYGvekoFiNkALBOHITW1yMH8407wf39xvGSjFzQWyCSg6RHwCgz3h8TaGaV
         +tDg==
X-Gm-Message-State: ALyK8tIXydfeiJcwV/VYQTs0odtCImk9GQfYWFYi9M9kKD2ts5XUACnndkoWQQ6IAVaTpA==
X-Received: by 10.36.64.3 with SMTP id n3mr491793ita.53.1467938209651;
        Thu, 07 Jul 2016 17:36:49 -0700 (PDT)
Received: from gmail.com (c-73-51-186-156.hsd1.il.comcast.net. [73.51.186.156])
        by smtp.gmail.com with ESMTPSA id e3sm390708ioe.41.2016.07.07.17.36.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 07 Jul 2016 17:36:49 -0700 (PDT)
Date:	Thu, 7 Jul 2016 19:36:46 -0500
From:	Erik Johnson <palehose@gmail.com>
To:	Jacob Keller <jacob.keller@gmail.com>
Cc:	Git mailing list <git@vger.kernel.org>
Subject: Re: git branch doesn't allow me to forcibly delete branch which was
 checked out in a now-deleted worktree dir
Message-ID: <20160708003646.GB1916@gmail.com>
References: <20160707184408.GA1916@gmail.com>
 <CA+P7+xoM=-=sokA_+WDuY7KYUwSa=Qu8Y9U1aPHOgSH3n-VZnA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="TRYliJ5NKNqkz5bu"
Content-Disposition: inline
In-Reply-To: <CA+P7+xoM=-=sokA_+WDuY7KYUwSa=Qu8Y9U1aPHOgSH3n-VZnA@mail.gmail.com>
User-Agent: Mutt/1.6.1 (2016-04-27)
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org


--TRYliJ5NKNqkz5bu
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline

On Thu, Jul 07, 2016 at 04:39:26PM -0700, Jacob Keller wrote:
>On Thu, Jul 7, 2016 at 11:44 AM, Erik Johnson <palehose@gmail.com> wrote:
>> % git branch -D archive-extracted-xz
>> error: Cannot delete branch 'archive-extracted-xz' checked out at
>> '/home/erik/git/salt/archive-extracted-xz'
>> % test -d /home/erik/git/salt/archive-extracted-xz || echo "directory
>> doesn't exist"
>> directory doesn't exist
>> % git --version
>> git version 2.9.0
>>
>> I know that I can just get rid of this error by pruning the worktrees,
>> but this still seems like incorrect behavior on the part of git branch.
>> It shouldn't be telling me that the branch is checked out in a directory
>> that does not exist, that is just factually incorrect.
>>
>
>Until the worktree status is updated git branch probably isn't
>checking itself. It might be worth triggering a worktree prune when
>doing branch work. Note that some worktrees may be on removable media
>or similar, and thus even if the directory doesn't exist right now,
>that does not mean it's no longer checked out. There is already
>support for setting a worktree as "persistent", but this means git
>branch definitely shouldn't just do its own check for non existent
>directory.
>
>Thanks,
>Jake
>

I'm not expecting _any_ git branch command to prune worktrees, but a
branch _deletion_ shouldn't fail because git thinks the branch is
checked out in a worktree that doesn't exist anymore. Even in the
scenario where the worktree corresponding to that branch is on removable
media, does it really matter? You're trying to delete the branch.

I feel like this is a recent change in behavior, too. I've been using
worktrees since they were first available in 2.5, and I don't remember
having to prune to be able to delete the branch until recently.


--

-Erik

"For me, it is far better to grasp the universe as it really is than to
persist in delusion, however satisfying and reassuring."  --Carl Sagan


--TRYliJ5NKNqkz5bu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iEYEARECAAYFAld+9Z4ACgkQXlWDxDeAjz/WXgCePoK2tWDm+bKkJoSf4yPvGFBe
LqEAmwZhKe63eEXjl4xfJzrea7XEdWSv
=WlHW
-----END PGP SIGNATURE-----

--TRYliJ5NKNqkz5bu--
