Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BF4B4201B0
	for <e@80x24.org>; Sat, 25 Feb 2017 12:38:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751319AbdBYMiG (ORCPT <rfc822;e@80x24.org>);
        Sat, 25 Feb 2017 07:38:06 -0500
Received: from mout.gmx.net ([212.227.15.15]:52697 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751231AbdBYMiF (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 25 Feb 2017 07:38:05 -0500
Received: from virtualbox ([37.201.192.48]) by mail.gmx.com (mrgmx002
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0LgIWi-1bwOnw3p48-00nejD; Sat, 25
 Feb 2017 13:37:01 +0100
Date:   Sat, 25 Feb 2017 13:36:58 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Jeff King <peff@peff.net>
cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        Christophe Macabiau <christophemacabiau@gmail.com>
Subject: Re: fatal error when diffing changed symlinks
In-Reply-To: <20170224203523.mdoh4ivhwflmpr6j@sigill.intra.peff.net>
Message-ID: <alpine.DEB.2.20.1702251336420.3767@virtualbox>
References: <CAC0icTZ87yeYndPFyjD4nkJBcw5SC-bgUJYbEzYqH7YhSFZvuQ@mail.gmail.com> <xmqqshn34gsh.fsf@gitster.mtv.corp.google.com> <xmqqtw7j1i6d.fsf@gitster.mtv.corp.google.com> <20170224203523.mdoh4ivhwflmpr6j@sigill.intra.peff.net>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:7kA78NTviMpQvzZMDl2z+Y8u6k8S/kqUn7pyoTD6MVXlW1mdV2X
 S4gxpAC1wI24aG9lE9vjbb06zoY/OUPdfnXdwSRZHlVHlzl5aH+kA+bHn44uaU+vhYKOdf1
 STEc5sRAadpUL5giFtApfM3RZYzszGA2SfIyB6kSX7PnOQ8tg9vdox4yg/dMezUz8ZJxqkp
 qKFR+JWWajL+xOw8Nz2Uw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:dO+eiwFB7TI=:NcmpQmVArYvJPmtg+OrUxh
 vuZsDReHQOSC3T/53PE03QZuRJIcpaGLzmRZUY1eLL/7gWl5iQbg1QMYNqmxNfBJFLbCQq4oR
 fbQUoViELjoBwwvPxeHTfLGn4jRc9fuc2feBl/JNZbrcV7brGfn51m7M9vZS3BIp0b9QCQ27x
 ZHJygGvBRcEF2NHGa0Pgt/XghLTB06nUEk4M0YIxslenVMHmRsF6UR5oAIcT45bw8LrA2Lg3K
 2msP+5TLcdllTgCKQvEJiH295gZOxFtKfJ+Mymqhvsh/ZYXNvs2twvklX7LTcTQzKGgInQoX7
 1owugCEbATSq6EJ6YYHQAqJQuTYrMOhVfszN0iUdnNoQSyCEQ9XuWs1UIQ1KoW2e/ddYl06sY
 RH6uY0SUDcF/MR2R1cT6CdQLh8IpF78xPQfgYC9V0R83zY7t+KNQi+8qsV+k7WOJ+alu0cqWX
 GkoXBuaMK9voO80Ohi7htzH3arSDczCz2lkLBQsZ1yvF0pDSR5i3vmE6R3pkZ4baKe7OaMlYC
 5zTyl1g9QDBgwJxCS9iqDxbMOpx6Zz47Hoz6tMfc/c7lyJzfIFW/8fv0toVsb825b3QnGrPCm
 Y7eMboSSmxfw1f5DmLgBgjDT2yoOi00VoPer4JJR2yfmr/iwGtspQlT1KvgGxHpQ7uiU2csI6
 jUQMrqJ8ck/kQMa/oY4qsxu3DnF2Q0W5jh1WXAP2JmBxRQVVi9P+wPKE9pg1nDWtEstNgYgDL
 zpKhaJfmOtH6pla+Sm2+zWLucuzn2oIooYMLXXZivy03Gkzzdh9uQoBhnVjRg6/csXSMCefxR
 ONMP5aA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Peff & Junio,

On Fri, 24 Feb 2017, Jeff King wrote:

> On Fri, Feb 24, 2017 at 11:51:22AM -0800, Junio C Hamano wrote:
> 
> > > A slightly worse is that the upcoming Git will ship with a rewritten
> > > "difftool" that makes the above sequence segfault.
> > 
> > The culprit seems to be these lines in run_dir_diff():
> > 
> > 		if (S_ISLNK(lmode)) {
> > 			char *content = read_sha1_file(loid.hash, &type, &size);
> > 			add_left_or_right(&symlinks2, src_path, content, 0);
> > 			free(content);
> > 		}
> > 
> > 		if (S_ISLNK(rmode)) {
> > 			char *content = read_sha1_file(roid.hash, &type, &size);
> > 			add_left_or_right(&symlinks2, dst_path, content, 1);
> > 			free(content);
> > 		}
> > 
> > When viewing a working tree file, oid.hash could be 0{40} and
> > read_sha1_file() is not the right function to use to obtain the
> > contents.
> > 
> > Both of these two need to pay attention to 0{40}, I think, as the
> > user may be running "difftool -R --dir-diff" in which case the
> > working tree would appear in the left hand side instead.
> 
> As a side note, I think even outside of 0{40}, this should be checking
> the return value of read_sha1_file(). A corrupted repo should die(), not
> segfault.

I agree. I am on it.

Ciao,
Dscho
