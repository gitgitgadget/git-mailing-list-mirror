Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 788091F404
	for <e@80x24.org>; Fri, 23 Mar 2018 17:12:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752112AbeCWRMQ (ORCPT <rfc822;e@80x24.org>);
        Fri, 23 Mar 2018 13:12:16 -0400
Received: from mout.gmx.net ([212.227.17.22]:48533 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751884AbeCWRMP (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Mar 2018 13:12:15 -0400
Received: from [192.168.0.129] ([37.201.195.115]) by mail.gmx.com (mrgmx103
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MMkgl-1ewNxz2LSJ-008Zhk; Fri, 23
 Mar 2018 18:12:12 +0100
Date:   Fri, 23 Mar 2018 18:12:10 +0100 (STD)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@MININT-6BKU6QN.europe.corp.microsoft.com
To:     Wink Saville <wink@saville.com>
cc:     git@vger.kernel.org, sunshine@sunshineco.com
Subject: Re: [RFC PATCH v4] rebase: Update invocation of rebase dot-sourced
 scripts
In-Reply-To: <ed4cfdc9f31b920eae5055c3b080e2ca5b2f6e42.1521779249.git.wink@saville.com>
Message-ID: <nycvar.QRO.7.76.6.1803231811530.77@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
References: <cover.1521779249.git.wink@saville.com> <ed4cfdc9f31b920eae5055c3b080e2ca5b2f6e42.1521779249.git.wink@saville.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:e/an2Syq3sYv8hjKPCcN2tCTXcMHYrm1u1HzmBj9KsHhchXOZWp
 d2mjix84NyD3yhStRMPP6SqaFCfwP3BRmDFEwD+u0qgjmS3+BCQhhmWgsN/tXkkz6MsQV01
 9riT2C+UIxBVE5Giriu0ocrBxf9nWI9NX4UyuBNSwtCdI0PZOPsZynPFHWMr/4uAqnv5Hub
 Vx2PMrl0EcMmamf6sMapw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:0d6X2J2a318=:hqpdyTXoEhZbob+dSHEC7T
 LyoNeM+O/SnVzg+uejMvKmLXUH2lpVALY9L5Qyx7J/5ddd2m5eCBrV3ngrc2p5QRvHNSGBIKD
 yjBNtO/uEmqGJygD6AG4frSHCkrTSzJpLrRzX9XIdPUsj+su+qpg4cZ5C5swhz9qyOaJHY7mx
 Fr5y+c43+H9FcpZH51yFVAQoyyH+63mhkQbuAv5G3f07sgyfGVkZP4tbdJUeYCW/MEO317hOE
 2bBjSecegecWI64wmcPCZWyreBb1sw76+qbg5WebD+prUjc7iNfP0TfKBfHxC84hLMxRbcCyf
 7XiC0/x21vwwcPIAr+tt7u4OFWfx0BxDPR/WRBcsJBJ4ZQAHXDlDMnC72EnnynUNdikBQH5iw
 ekT8YCgahxKUCXMgAg2+gKa3OsKvT6PkDBZdolhq2sC90tSvnqhEomV0IJ4ZEgrexOjd71psF
 zUr9o67pnGJKGjRcIcvUHYk0m/TwqDuzrTwu2rnZ+J265ph5TWBeKq0LqqNGKvPj14G9/fUkj
 TwdBGaqC3EBncY4aWkbS0OJXQK0FlwwJZwCq+5urLXYs1U6cysYFDKZasTvfR+uYU4bORDPFr
 Dmg6nzhDqwzKjLPhyUsyX4xtgrA6zPaTzdsGvXTc7E6S1jEN82iXUMygCUbhpoeyAFiTPSR+F
 Lqfk3r9R2GnwQCmHuyj5s0cMJtJytH3j8czMkZW5MHKbxuJXcjVhw2lEgUDXa/BqYDYHLczCW
 j8NrpUMFe8j0ZR2dXmNLE5G9aME5MX5Yy4KMoZBM5exFAQE4wGyRl82zNh/l6uHnplW7/WlFG
 KxHnqucqjRY8i43eU2sIFUaUrjwcfM9dbYS/vkWXVYAM9DSx3s=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Wink,

On Thu, 22 Mar 2018, Wink Saville wrote:

> The backend scriptlets for "git rebase" were structured in a
> bit unusual way for historical reasons.  Originally, it was
> designed in such a way that dot-sourcing them from "git
> rebase" would be sufficient to invoke the specific backend.
> 
> When it was discovered that some shell implementations
> (e.g. FreeBSD 9.x) misbehaved when exiting with a "return"
> is executed at the top level of a dot-sourced script (the
> original was expecting that the control returns to the next
> command in "git rebase" after dot-sourcing the scriptlet).
> 
> To fix this issue the whole body of git-rebase--$backend.sh
> was made into a shell function git_rebase__$backend and then
> the last statement of the scriptlet would invoke the function.
> 
> Here the call is moved to "git rebase" side, instead of at the
> end of each scriptlet.  This give us a more normal arrangement
> where the scriptlet function library and allows multiple functions
> to be implemented in a scriptlet.
> 
> Signed-off-by: Wink Saville <wink@saville.com>
> Reviewed-by: Junio C Hamano <gitster@pobox.com>
> Reviewed-by: Eric Sunsine <sunsine@sunshineco.com>
> ---
>  git-rebase--am.sh          | 11 -----------
>  git-rebase--interactive.sh | 11 -----------
>  git-rebase--merge.sh       | 11 -----------
>  git-rebase.sh              |  2 ++

The patch makes sense to me.

Thanks,
Johannes
