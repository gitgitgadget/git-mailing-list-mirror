Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6BE911FE90
	for <e@80x24.org>; Tue, 18 Apr 2017 11:30:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755254AbdDRLax (ORCPT <rfc822;e@80x24.org>);
        Tue, 18 Apr 2017 07:30:53 -0400
Received: from mout.gmx.net ([212.227.15.18]:53612 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754819AbdDRLav (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 Apr 2017 07:30:51 -0400
Received: from virtualbox ([37.201.193.73]) by mail.gmx.com (mrgmx003
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0M6jIK-1c3vLG3JRM-00wXHs; Tue, 18
 Apr 2017 13:30:46 +0200
Date:   Tue, 18 Apr 2017 13:30:45 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Junio C Hamano <gitster@pobox.com>
cc:     git@vger.kernel.org
Subject: Re: [PATCH 0/7] PREVIEW: Introduce DC_AND_OPENSSL_SHA1 make flag
In-Reply-To: <xmqqr31f7gh8.fsf@gitster.mtv.corp.google.com>
Message-ID: <alpine.DEB.2.20.1704181320010.8522@virtualbox>
References: <cover.1490397869.git.johannes.schindelin@gmx.de> <xmqq7f3d6ev1.fsf@gitster.mtv.corp.google.com> <alpine.DEB.2.20.1703291509450.48202@virtualbox> <xmqqr31f7gh8.fsf@gitster.mtv.corp.google.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:R2NpZ38m02hoAt3lh34t+7jCkk53jea4K4mQ70f7np8cvy/dkK2
 ftqoLKs3yj5rk7DJQmiePgALlQTMzfaze5zEtz/5vPr0F1p8IvzZiXANfADS1sZDG5Tu591
 EMkHsa6edT3zvdYGUyIm9HMu3nqlDXp/Gvy2pwM5U22IeWDUrjZs4T9jbhKSv+MRuRKeLba
 pug8npRs+tHOeeNSpXomg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:hel7JP21/GE=:DoUXQfDwx03Iz7dHddOA8D
 L3P9kUBClCKFeVkmFZGM2v2YOI200ngEBNzlgIZo95Qf/7J7yFD0ZWUohPBz31aOz+i2UppEM
 h16T0ld4DgpaescJ7Y5CCul/N6iNjqPSol0b33RqyDUI4rNk1SCIuWR8ZpG/e+aO2Tqq6CrF/
 cNvGcgHQg9YXdhGwch9ea9lUCVj6WmFMRcjRv2qQkphz/d7yzSXluLK4n8dmB06ULA1ExhyMu
 oxwMp+SlAkR+zpxdy+/VTrPx5SYwg5yhmBlt6a7Z0oQ+p4jyGAaeqRwFMeVe656f5CDp6nlbP
 vzjXDjUvJ7QXljxL/ovuVW5UHAO1VaSr5EH0lUdFyhoXo7OOCculNaJXkTfcqzxZ3/C/cxhPt
 IMXSH3Fblf+7dMng3oh0hNe4w4Gy3AJAZJnwMOqkLYt2WMwJUP5Hi+E65Re7Td78K2J2cRTVR
 M7ThxgCgcQSCT2R8+XYglG6qmFsaTe1pQz7NlCIropYMypW3HWeUMCzo99BxpwkhSCnpKDcce
 zwkt5uDA7T1CJCzpTfjXkzOMexkZF/nnLKUsrzbbX5W7UKSszJ4ue4D5w+aqNDwVLO7DvXvCD
 mqc/PGKRagvjQyQSxAqyEhQ8m+A3yXIcv3vFMTEp5WKLXzUIqhndxsmiSk9vXAo5tkNZ1/qnU
 hBQ2mzdxWSsk60Sybm/0E3m0DtBrFXbnsw6mBue0b5zR02HlDoBvIqtAtpTGjwP8W07KR64nN
 TcLbyGfL+4feNbxZIdjqz05NlEHNhyMYOW4mmiURvSYjo8/tQlobMXXEuji8fF+sw/p6m2n5x
 se2eaqK
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Wed, 29 Mar 2017, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> > The approach I chose instead was to make the switch global, per
> > command.  Obviously, the next step is to identify the Git commands
> > which accept objects from external sources (`clone`, `fetch`,
> > `fast-import` and all the remote helpers come to mind) and let them
> > set a global flag before asking git_default_config() to parse the
> > core.enableSHA1DC setting, so that the special value `external` could
> > trigger the collision detecting code for those, and only those,
> > commands. That would still err on the safe side if these commands are
> > used to hash objects originating from the same machine, but that is a
> > price I would be willing to pay for the simplicity of this approach.
> >
> > Does my explanation manage to illustrate in a plausible way why I
> > chose the approach that I did?
> 
> I agree that there may be rooms to tweak the degree of paranoia per
> codepath (I said that already in the message you are responding to),
> but as Linus and Peff already said in the old discussion thread
> [*3*], I doubt that it needs to be runtime configurable.

My real world scenario here was intended to cast a spell on your doubts:
the very real slow down is very inacceptable.

Given your reluctance to accept that the performance impact is large
enough to be painful, and that there are situations where the trust in
your infrastructure and your colleagues makes that pain unnecessary, you
leave me no other option than to make this a Git for Windows-only feature.

I really tried to reconcile your concerns with the needs of Git for
Windows' users, to demonstrate that the compile-time switch is
unacceptable, but it is time to accept defeat and the newly acquired
maintenance burden.

Moving on,
Dscho

