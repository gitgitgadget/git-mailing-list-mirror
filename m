Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 57E05207B3
	for <e@80x24.org>; Fri,  5 May 2017 20:30:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752047AbdEEUab (ORCPT <rfc822;e@80x24.org>);
        Fri, 5 May 2017 16:30:31 -0400
Received: from mout.gmx.net ([212.227.17.22]:51651 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751465AbdEEUab (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 5 May 2017 16:30:31 -0400
Received: from virtualbox ([37.201.193.73]) by mail.gmx.com (mrgmx103
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0M6B6s-1e06dM33OM-00y7hM; Fri, 05
 May 2017 22:30:18 +0200
Date:   Fri, 5 May 2017 22:30:15 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Stefan Beller <sbeller@google.com>
cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: Automating Coverity, was Re: [PATCH 00/26] Address a couple of
 issues identified by Coverity
In-Reply-To: <alpine.DEB.2.20.1704282205320.3480@virtualbox>
Message-ID: <alpine.DEB.2.21.1.1705052227120.146734@virtualbox>
References: <cover.1493237937.git.johannes.schindelin@gmx.de> <CAGZ79kbbHshh4=WC2ymG15=W5oq98b3KTV4zxiTx0LgCLeYwfQ@mail.gmail.com> <alpine.DEB.2.20.1704280010160.3480@virtualbox> <CAGZ79kYOp1deMgcEB3HHXeEcLOKNs4KPjdT_W2CD+4Amduv2Wg@mail.gmail.com>
 <alpine.DEB.2.20.1704282205320.3480@virtualbox>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:zGxecLsZiucoLKDGUuYV1UqlVY2didmGDWvUom6IMne4BYx/H0/
 6GXNi9SeIt73MIPeDXZBHPytPAhS5kD+NrabRMTvhUP6mQS4VJVWxXCpbnzaHamJ5cg+kOH
 VE4NM+Wh1K+7UK67c4SG4jEnf9g6VpIwyfYa0liTd2AWh6mSRssMddvw9tGcf1aCkkEL/HM
 Fz/p85NCeuWz5sWO5ubYw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:uPnXK3aCJDU=:kJPxHZaT2ssetbsphEibGb
 Ak0J4ZRuFVPC8aJsLYJV0mAjpp4smysj2Nr4KU5ClZvG4TWYhMe26k+uKCrbr/GQ/Drhx0VGj
 NfGhg1asdaM6H6hotukj9Kq8ChMXgnvnWW0WkVkxWRZDCLOio1zys7NkD2QHOVleF1Ek2h6o0
 taOMQGNmU48eJxqr6Z9u/RpWV4y6070vAIbuPY+QdfaTJioaO4vNqext1FjtjCISoBREAPKgW
 x+AmDmTqnNHa6g9WeYlCWUAQZzuLR9ow9G+hARA6O/JH10Sb8Y8sIxOF2Rr+IVPwCXMJ8J64K
 iPdDG6RjgDvQK0X1NMqxRQCK2v6ZcaW2tLt44eEYiSAbWo0OiHewiC7NJKtIRUAU1lybdSMkz
 jS+i0HHeijhQjoGpfKnrYe9yjSKoGX2W+J4l8iitMa88qfJqvexLKDaqIcODDeMaGidaG08fd
 76mymO1DQMKfO8j3UrKM2I+pmcWIUBdQl819AeaQUb5WY4RbriUrB7evFFXpytiA2yQrykYXM
 pyE86Y3jb6qkhfO136WzKbsmm22/fZ+21tYeP3elMClAPej7bS/6Orjbfjqqz6PttL5k17iwc
 QzfF3rr+rx14OQ8bOWLlVVyC56wRCp1GLoop5tmyweI5tWNYUfwLb+lQmfTCRrLJdt9tbUnA5
 78yvNsYr1JUvkix8zVbI7ICVZGZQ00X6pGlK9csSUHNBEqHRT2FWyOQhJvu7ry25y9gowa/8N
 rrvNNdajFgQyhXdHKLfLzkY/9WOr3vobuvy2khtQcnwZc7ROHgBrO4IcW9RSjDvw/jffqT0Kx
 xPAU7Go
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Stefan,


On Fri, 28 Apr 2017, Johannes Schindelin wrote:

> On Fri, 28 Apr 2017, Stefan Beller wrote:
> 
> > On Thu, Apr 27, 2017 at 3:50 PM, Johannes Schindelin
> > <Johannes.Schindelin@gmx.de> wrote:
> > 
> > > I still have to find the time to figure out one more detail: how to
> > > download and extract the Coverity tool (the .zip archive has a
> > > variable name for the top-level directory), and doing that only
> > > every once in a while, say, only when there is no previously
> > > unpacked tool, or it is already 4 weeks old.
> > 
> > That is an interesting problem, which I ignored as the older versions
> > of their tools still works once they release new versions. So I just
> > manually check every once in a while if they have new versions out
> > there.
> > 
> > So if you find a nice solution to that problem, let me know, please.
> 
> I think I have a working idea (jotting it down in the editor, untested):
> 
> [... totally untested snippet ...]

And now I edited it and tested it. The code is now part of the script I
use for pretty much all administrative (i.e. recurring and boring) tasks
in the Git for Windows project:

	https://github.com/git-for-windows/build-extra/commit/05b5342128

May it be useful to you, too, at least as a starting point,
Dscho
