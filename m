Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7ED8B1F744
	for <e@80x24.org>; Sat,  9 Jul 2016 02:22:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932835AbcGICW2 (ORCPT <rfc822;e@80x24.org>);
	Fri, 8 Jul 2016 22:22:28 -0400
Received: from mail-io0-f170.google.com ([209.85.223.170]:33211 "EHLO
	mail-io0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932635AbcGICW1 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Jul 2016 22:22:27 -0400
Received: by mail-io0-f170.google.com with SMTP id t74so58645755ioi.0
        for <git@vger.kernel.org>; Fri, 08 Jul 2016 19:22:26 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=VCvMbSLZo4WfY5VTtIYM+0ETBqYtf22BM92g65LknAc=;
        b=MzzIn1LTTNCk8W2qzf7odM1stMVTSa0oa/M9vMZ0rlSR3l5KIw9t4s6dWZh48Hxxrr
         e7NYqgxmyQmR2pWG6CPSS57w82NKVgjg+M6f/gzvYhPf/44qEkX3SVMlZWqx14L0+Gy4
         4H+QHXfwXf8zWO8LizTLiXVP3K3nTEAEjUoazGk4sBcDKGmwzqKh7kTNcm2ufC/FdKqn
         EGuOoTtEiskUoQa0BpFSnOXDo5THkwSf+D2sQ5IWh3vWL1lXEdkVSHduFpkuQVUQuOn7
         UX4E4iOqaJ/jhEaKIFRZSVBD4Fy7KvlpLG9GlzpOvdnfy0kJpx5CNOOwjFeKPtR41+DR
         arCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=VCvMbSLZo4WfY5VTtIYM+0ETBqYtf22BM92g65LknAc=;
        b=CFyY8e1j8w/quxjWGEP34Lp0IZjdo+wGTt6fOYKdX9KT27Aizfod5ODTSzRMwPr2d7
         ZAjoS2sPmCle2HwR+LmectQulj94LcHCcfnOAhRuGnnY2hGADXiJKPBmKPWr3x/Yrown
         nK45syOMrSYMKFh2tXpp4uxI+G5zohMOyydNhlFGK7vlLalzamnIEOjEGqzU33951Yhq
         1OC1j/nbutMcxN7tCm8vE2IK7b2/FTWk0W+zZtJzmoJOM1b5ScbuftcSjfvD+lEjrV5c
         aQARl3g9WqsjqzID6XlxA0RRe4QnKByMKtnd0OUMbrwi9Isir4cSg2gluxDgYavkDrQj
         BM9w==
X-Gm-Message-State: ALyK8tJBEYtaFmXYKrVC1Tb8DjCLFh3BiYNvQ50oTIsnKyREAK7tm4+J1UyGyfO8tjzkbA==
X-Received: by 10.107.169.138 with SMTP id f10mr11078312ioj.192.1468030946070;
        Fri, 08 Jul 2016 19:22:26 -0700 (PDT)
Received: from gmail.com (c-73-51-186-156.hsd1.il.comcast.net. [73.51.186.156])
        by smtp.gmail.com with ESMTPSA id r6sm772903iod.31.2016.07.08.19.22.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 08 Jul 2016 19:22:25 -0700 (PDT)
Date:	Fri, 8 Jul 2016 21:22:23 -0500
From:	Erik Johnson <palehose@gmail.com>
To:	Jacob Keller <jacob.keller@gmail.com>
Cc:	Git mailing list <git@vger.kernel.org>
Subject: Re: git branch doesn't allow me to forcibly delete branch which was
 checked out in a now-deleted worktree dir
Message-ID: <20160709022223.GC1916@gmail.com>
References: <20160707184408.GA1916@gmail.com>
 <CA+P7+xoM=-=sokA_+WDuY7KYUwSa=Qu8Y9U1aPHOgSH3n-VZnA@mail.gmail.com>
 <20160708003646.GB1916@gmail.com>
 <CA+P7+xr_dYbno+JsTmaG+WWrgwsAXXGTyA6HL4A4A34ahHMD=Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="LwW0XdcUbUexiWVK"
Content-Disposition: inline
In-Reply-To: <CA+P7+xr_dYbno+JsTmaG+WWrgwsAXXGTyA6HL4A4A34ahHMD=Q@mail.gmail.com>
User-Agent: Mutt/1.6.1 (2016-04-27)
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org


--LwW0XdcUbUexiWVK
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline

On Fri, Jul 08, 2016 at 05:41:17PM -0700, Jacob Keller wrote:
>On Thu, Jul 7, 2016 at 5:36 PM, Erik Johnson <palehose@gmail.com> wrote:
>> I'm not expecting _any_ git branch command to prune worktrees, but a
>> branch _deletion_ shouldn't fail because git thinks the branch is
>> checked out in a worktree that doesn't exist anymore. Even in the
>> scenario where the worktree corresponding to that branch is on removable
>> media, does it really matter? You're trying to delete the branch.
>
>I disagree. git branch -d (should) fail to delete a branch when it is
>checked out in a worktree. If the worktree is a persistent (ie: not
>there due to removable media etc)  directory then it *definitely*
>shouldn't allow you to delete.
>
>It is possible we should update "git branch -d" should perform a
>worktree prune first, since that would enable it to determine that you
>deleted the directory, and any worktree which is removable should be
>marked as persistent.
>
>Given that there is a known workaround (git worktree prune) and that
>it is expected behavior for a branch checked out to prevent deletion,
>I think the best coarse of action would be to patch git branch -d to
>do a prune before attempting to delete.
>
>Thanks,
>Jake

Well, I never mentioned -d (I was using -D), but I think we're both in
agreement.

--

-Erik

"For me, it is far better to grasp the universe as it really is than to
persist in delusion, however satisfying and reassuring."  --Carl Sagan


--LwW0XdcUbUexiWVK
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iEYEARECAAYFAleAX98ACgkQXlWDxDeAjz9tLgCfXTDlPFYwvCk4yjtzZhmYOxbM
6U4AoIRbaGIojjaI26NaM8sbFbeqI7TD
=EiXj
-----END PGP SIGNATURE-----

--LwW0XdcUbUexiWVK--
