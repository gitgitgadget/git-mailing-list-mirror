Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 038A42036D
	for <e@80x24.org>; Tue, 21 Nov 2017 16:18:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751330AbdKUQSa (ORCPT <rfc822;e@80x24.org>);
        Tue, 21 Nov 2017 11:18:30 -0500
Received: from mout.web.de ([212.227.15.4]:57610 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751269AbdKUQS1 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Nov 2017 11:18:27 -0500
Received: from localhost ([195.198.252.176]) by smtp.web.de (mrweb002
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0Lp7Lg-1el0Dt01Ei-00erbz; Tue, 21
 Nov 2017 17:18:25 +0100
Date:   Tue, 21 Nov 2017 17:18:24 +0100
From:   Torsten =?iso-8859-1?Q?B=F6gershausen?= <tboegi@web.de>
To:     Vladimir Nikishkin <lockywolf@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: core.safecrlf warning is confusing[improvement suggestion?]
Message-ID: <20171121161824.GA13548@tor.lan>
References: <CA+A2iZaLZCMvyb3nbcn=ofVGAPeW2_wRhjOeRRu5q01LuV++Gw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+A2iZaLZCMvyb3nbcn=ofVGAPeW2_wRhjOeRRu5q01LuV++Gw@mail.gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Provags-ID: V03:K0:Gs+OQhHKEurzkubRs5RXsgNDLmIpSVDn/ewtxDZCjT4uuUh1DST
 xKpMgEK6l2vgXBBLNa2w0WQbHQifSJgoezdmnUpqkqva2aCKEe1xp+JpjnFqrB9p8uLScXr
 cBeFxGBVkzqov1Li0SHbxfd+AusceWqMeifweY0z0+zaV5tauwDFVs3ZR74csZiPh38oVnT
 vsyYsGaP9Q0+upCqehsPg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:UdeZz4iBUnw=:7X5sb7moEtW1IhejcVE7hZ
 c8uaX0z16gc0D/4oP7W1hmaSelHSaNn6qP18Prl3avfv210djl7HeDG3Q+UdA1B+2qqrIK1Hr
 qbgiEo1XzTux3Yi6uFe2tms3P0jVivr01K673cLdDmyhpA4dLZqdk1SY94hwfMB/uJiG6gCPV
 m4jR9ny5z1+euYbaixcfa23T2OZoRyy3ZM5LaIbtLPrnqipMkz1LC36Qv9woLm0uDcZ5GiobT
 M42fx3Hxf5CDPxLKniIyjbFMRNJDI5owznvvgLPcVmNTUpmvv8Xm9epfLbr4k6OAONAJFhx3D
 IY95XIP+AlkCQhChRlX3fu6kGxOfE951dALc4T47eu6lQi86h5moaUR8rfxwa8ZG4wraXhmqj
 O5F/9UKBhVunoc2VrHcoWc9W3cDnKY0AOLNtJQ8E4hIce1bJ3EmGY75bS0xZnJG9HckUomDht
 PFRNZCr1ifvMthgok8duKL4UdsTcTunSRK4ellyOPL+b4JowrCnJC+IX2VHTArDDobdq4CQsX
 7pk8edJnlOOFvVKDvY/Jba3ZOdImud9w74kKmmfcbwjT9WNgBmlz7Bqu2f35nXV3Eg7bz3ApN
 4z0gnQFbMWgoF5Skmx5Ao9oRkUGy/n1xeMQTIRhmnQNPkxjrGFk1SgDY9PqqRaMK4NwkZ/KA7
 PMsLWuL+nScxodMGfkFrot3vtdSYkCSasuuqjRK7HtnCJFvHIOurpK5SeA0vtcOHo6BJz/3ig
 9+Ev8EGQJLF/IzP5N8mJijWYNpZZNzONOIFnZSatTAM8iHTU6QdcFrf/8/1hputDd9x3OfJDr
 u8Y4WBmbNAdJOzZ14ems8BIB1gbqA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Nov 21, 2017 at 01:18:30PM +0800, Vladimir Nikishkin wrote:
> Hello, everyone.
> 
> I have the following question.
> 
> So I have a fresh git repository after git init, on Windows.
> 
> core.autocrlf is true explicitly, and core.safecrlf is true implicitly.
> 
> I want to have LF line endings in the repository and CRLF endings in
> the working copy. (Because I use windows-exclusive tools to develop.)

Side note: If you ever want to push your repository somewhere,
it would be good practice to have a .gitattributes file:

echo "* text=auto" >>.gitattributes
git add .gitattributes
git commit -m "add .gitattributes"

This can be useful if the repo is pulled to a person who has
core.autocrlf=false, if case [s]he is creating files with CRLF in the
worktree.

> 
> But for start I have my code with LF endings, because I got it from a
> fellow developer, who develops on UNIX, with LF line endings.
> 
> What I expect git to do:
> Commit files as is (LF), keep my files in the working directory with
> LF, but after issuing 'git checkout master' have them converted to
> CRLF (since this is a checkout procedure).
> 
> So I put the source in the working directory and tell git to make
> 
> git diff --stat

As Junio pointed out, it is probably not git diff saying this ?

Typically "git add" gives the warning.

>
> and I see the (ambiguous) warnings:
> 
> 'warning: LF will be replaced by CRLF in filename.m.
> The file will have its original line endings in you working directory.'
> 
> How I read them: "even though you have core.autocrlf=true, LF will be
> replaced by CRLF and the repository will store CRLF files. However,
> after you checkout them again, the CRLFs will be converted back to
> LF(because the files will have original line endings in the working
> directory.)"
> 
>  I feel like it's the opposite of what is actually happening.
> 
> So, would it make sense to change the warning message to? :
> 
> 'warning: When you next checkout this commit, your code will have CRLF
> line endings. However, right now your files will not be altered.'

I could agree.
Do you want to send a patch for this ?
(The code to be changd is in convert.c, plus some test cases)

> 
> -- 
> Yours sincerely, Vladimir Nikishkin
