Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-9.3 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C159E1FE4E
	for <e@80x24.org>; Wed, 29 Jun 2016 11:43:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752050AbcF2Lng (ORCPT <rfc822;e@80x24.org>);
	Wed, 29 Jun 2016 07:43:36 -0400
Received: from mout.gmx.net ([212.227.17.21]:53146 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751962AbcF2Lnf (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Jun 2016 07:43:35 -0400
Received: from virtualbox ([37.24.143.100]) by mail.gmx.com (mrgmx101) with
 ESMTPSA (Nemesis) id 0LeiJ8-1bgn0x13Rm-00qT1N; Wed, 29 Jun 2016 13:43:29
 +0200
Date:	Wed, 29 Jun 2016 13:43:26 +0200 (CEST)
From:	Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:	Ioannis Kappas <ioannis.kappas@rbs.com>
cc:	git@vger.kernel.org
Subject: Re: git svn clone segmentation faul issue
In-Reply-To: <loom.20160629T104814-936@post.gmane.org>
Message-ID: <alpine.DEB.2.20.1606291341530.12947@virtualbox>
References: <0BCA1E695085C645B9CD4A27DD59F6FA39AAD5CF@GBWGCEUHUBD0101.rbsres07.net> <alpine.DEB.2.20.1606281334450.12947@virtualbox> <alpine.DEB.2.20.1606281530420.12947@virtualbox> <loom.20160628T175016-898@post.gmane.org> <alpine.DEB.2.20.1606281825190.12947@virtualbox>
 <alpine.DEB.2.20.1606290911040.12947@virtualbox> <loom.20160629T104814-936@post.gmane.org>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:bK1KcHQFffa4KqEQByoH2Ip2oHUk2sbMfTUAMgbGOze8CdmHoO5
 a/Bx/fVYARe/jPnFtF4eYYKmZBWuaFNI9PLxZVjkPqJwZpwz4Y/1tyei6RBTTEbwZnqibPd
 Mm6Q30CX6zHHiTQJUVlfXaNz5MW/yOt9dj31UYSmlSSdkD8DcvKzzUHt+z7MiRrN4S0brI5
 aL5zUoPnXfGb2L0Pac0aw==
X-UI-Out-Filterresults:	notjunk:1;V01:K0:j+1UranM7x4=:Mj1JS5nGY1WjqKoRpVXWJh
 sZ9LhrHRG0UZEA3ddZEqCa9hIoy+zT3c1DnZDsKmWmn/rJhfrDTsv/+LqivJrqCbdoVP8AW7L
 I8sz2jrGZ059+qevkmuttca9WVw5mX2OwZ/emUgIHT4lUmR6hyAQhLo4gLLthQJIqPwGZAKLO
 WczNdeLyiOhkAcR2D2AislXiMmrETyo2nZUAqBRdm7aBh3Kdt9343CDXvfuQgYyI5vIfNazqE
 RSqo6p3usBN4NtOCj9NMtATBO17IetSeflZBIkWOqO3UTws+MsnYgQZxattPpghiJGjTxyxgD
 Y0nvAe/Sll3bqg0rkUH7g0K9xtNq92xFPLnIvfa+QXx7uan+nuTnD5U4rKTwKvtADEfuuRsyA
 oAilKaVtxcVna86r9IShvui/kAToqwnErViFayWGoexTj0acs8oS1Q9PmycyGcVc6Kd6bqw/T
 n5zUSiIj/iuj+/ppTfHi7cdGge2h8FFEDEDVTHPF3nU0H6re3bA5UcQaAkNUaojKgEDx2C6y+
 0OTulRxQr3pfPZDOf0+xdlDMLL8ec+LL3APO8VK88TvI9MpclRI+cAys/U5sc/RwRO0SFam5d
 Mpe0lPORUEXBDweOjGwSqnp3HT8i8HlufQwGSvD4x86G0WzOi3EX8pntokpv/XzFrjTnUeK0M
 b6M066hfm5v6ldgq4lSoFI8R5CjnhdRibs0Yu3Wd2x+K1V2N9bbmp4yRxRq9tF5+NPyiJXUeM
 q8BbpyhM6mZvqDsdpdhdqgvwyyNct+Hd7xtUtBXrSXsgjWgRM5hDe3dFye2NFTj3lOhAdCjrc
 Hza9S2z
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Hi Yannis,

On Wed, 29 Jun 2016, Ioannis Kappas wrote:

> Johannes Schindelin <Johannes.Schindelin <at> gmx.de> writes:
> 
> > I just re-uploaded new packages, after rebuilding them and making sure
> > that the patch was actually applied.
> > 
> > May I ask you to re-test, just to make extra sure that the bug in
> > question is fixed?
> 
> I confirm the latest version, built from the 'source files (zip)'
> package, has resolved the issue.

Thank you so much!

> Thanks for the prompt response! Next task is to get the patch through to
> the next subversion official release.

My more immediate concern is MSYS2 (the POSIX-emulating basis of Git for
Windows), and I opened a Pull Request there:

	https://github.com/Alexpux/MSYS2-packages/pull/647

If this Pull Request is not picked up in time for the next Git for Windows
version, I plan to use the packages that you tested.

Thanks,
Dscho
