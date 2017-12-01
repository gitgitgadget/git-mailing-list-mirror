Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A37CC20954
	for <e@80x24.org>; Fri,  1 Dec 2017 13:33:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752640AbdLANdw (ORCPT <rfc822;e@80x24.org>);
        Fri, 1 Dec 2017 08:33:52 -0500
Received: from mout.gmx.net ([212.227.17.21]:50492 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752480AbdLANdv (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 1 Dec 2017 08:33:51 -0500
Received: from virtualbox ([37.201.193.73]) by mail.gmx.com (mrgmx103
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MhQju-1ehE0h41A2-00MZar; Fri, 01
 Dec 2017 14:33:46 +0100
Date:   Fri, 1 Dec 2017 14:33:30 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Junio C Hamano <gitster@pobox.com>
cc:     git@vger.kernel.org
Subject: Re: What's cooking in git.git (Nov 2017, #08; Tue, 28)
In-Reply-To: <xmqq1skh6fyz.fsf@gitster.mtv.corp.google.com>
Message-ID: <alpine.DEB.2.21.1.1712011431520.98586@virtualbox>
References: <xmqq1skh6fyz.fsf@gitster.mtv.corp.google.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:CFfbXVutPkvHfIEpg4Z97v3U7nIUS5B8jbxp7imgIriSIvgmkie
 EIbMfdPEltv0EiECO7OnFbzImLpNA/kD2QhAdx7gBVErg6NP51aHd0FBhkcT8rhw8pDDveK
 8cffyRI6jICWuiG5Si7C/7EGujazovtUt32CbelYk31pkWhoaYaxpXas+0q4/SLMdp+DMbE
 gwKws336RwH1pNJuNidGw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:9bWEKGk3xRY=:Pbb454TUA+J2xkn7WHSuQY
 RX/j34/8ehdiAQ+X3RuC6legGEsuPv6IY5HLUci4NYtGz9k8rgyF67TS7ohGDrw3wjPGBfomh
 Wyg8g/sBidpqMDKDInzNHTbboSAqrAjiI2iDYFOJMde5Bp72HdZ5c8qzcSCIaEbpaOhHAVPIr
 VFcZANOVRcWzI0igbyU71/EEGjDkkV2c6y8XMc4VL9Z9OtBbROfKOLFlJ55OqkVJsgwD2dqyp
 g343s8OVFzQNuzUH1oaFa0bed5D+0JggaD5erqfx/aAwTG2rEcBvg/zC9QzNGQQqlJUB56Iqp
 j6bwaqHdpdQN8CODrmkVzi7Q2NAUBrMVRLzs66RVjcCJsWDNdNDf/4b1Lgo+Y1IHfMEMX4Nwu
 H73/DlCSyNRIkNzFXt2ul+WSXWzGdcCWzxyWDYbqQt559XOgAZkdhVWgydSTKzCT4vUpqvJcj
 95TqAAn1VXOzCePra1Un+SZhleVKd/yeVECyUZNGjNFqhx7YUWrt/fUnwAfqJcP+7SnwaoY58
 FWMk/jjVtXjLl6duX2WojLajHIZ6I99CTvyTrIMtLgEqe0zeU3BGqar+Ba2y7sK7Ew8USyO9L
 jkMvUc+sSV3ZN7I09pQIPunZEIxnFolVpRoN3NPwsoqmo56e6r+6xM4P9OzT7NR4W0m42XEEa
 7tSfQl5tO914dbKhAECPIb8gOfMj7zDPMuOuTlNOhGd5hgqS3o8jZgiyJ/aYfbq4PBzBmnoy9
 y2z6DwPDne6V4fgaIe6HKBm+HAcLboFMDfOvFXbUXH9tPm6AawDKVi8cecR+Q8/bwRD8eoTtu
 XYeJV36Mz6sbR4/RbBJThbGVeNUj4p7Bd0AwmXVigoMmoWURPY=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Wed, 29 Nov 2017, Junio C Hamano wrote:

> * tz/complete-branch-copy (2017-11-17) 1 commit
>   (merged to 'next' on 2017-11-20 at 6d22384fcd)
>  + completion: add '--copy' option to 'git branch'
> 
>  Command line completion (in contrib/) has been taught about the
>  "--copy" option of "git branch".
> 
> 
> * tz/notes-error-to-stderr (2017-11-15) 1 commit
>   (merged to 'next' on 2017-11-20 at a45d441ee2)
>  + notes: send "Automatic notes merge failed" messages to stderr
> 
>  "git notes" sent its error message to its standard output stream,
>  which was corrected.
> 
> 
> * tz/redirect-fix (2017-11-14) 2 commits
>   (merged to 'next' on 2017-11-20 at 5b13f7026e)
>  + rebase: fix stderr redirect in apply_autostash()
>  + t/lib-gpg: fix gpgconf stderr redirect to /dev/null
> 
>  A few scripts (both in production and tests) incorrectly redirected
>  their error output.  These have been corrected.

I guess I am the only one, but I have to say: I get confused *constantly*
when you mention Todd's patches in the "What's cooking" mails, always
expecting something timezone-related to be going on.

Ciao,
Dscho

P.S.: You mentioned that you'd go offline today, should I hold off with
more of Git for Windows' upstreaming? If so, how long?
