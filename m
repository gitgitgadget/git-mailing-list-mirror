Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 245331FD99
	for <e@80x24.org>; Tue, 23 Aug 2016 16:43:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754619AbcHWQnr (ORCPT <rfc822;e@80x24.org>);
        Tue, 23 Aug 2016 12:43:47 -0400
Received: from mout.web.de ([212.227.15.3]:51219 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754605AbcHWQnq (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Aug 2016 12:43:46 -0400
Received: from localhost ([195.252.60.88]) by smtp.web.de (mrweb001) with
 ESMTPSA (Nemesis) id 0MarZy-1bs6z70rhC-00KPS6; Tue, 23 Aug 2016 18:43:27
 +0200
Date:   Tue, 23 Aug 2016 16:43:26 +0000
From:   Torsten =?iso-8859-1?Q?B=F6gershausen?= <tboegi@web.de>
To:     Lucian Smith <lucianoelsmitho@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: git-svn bridge and line endings
Message-ID: <20160823164326.GA22168@tb-raspi>
References: <CAHLmBr2CRzt58RB+_YmnXcyost-R5=Ff51tALf1xh0kGk+frDw@mail.gmail.com>
 <CAHLmBr1JHjjp66Er-2e6Yu+3zjrhT82Da-O8fj6_OoPtEPz8eg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHLmBr1JHjjp66Er-2e6Yu+3zjrhT82Da-O8fj6_OoPtEPz8eg@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Provags-ID: V03:K0:O73dw1hs1uKeFAh8mX/V60Y6ffa6IJm9eEG+5OC9Yl/iV+v9IgD
 w/dQGHG15I9KGLOEYrGFajpy19QzbAHuZbLB6Hu/sntIdwj4gKE8KS4XfYdtR7ZyfghvOzY
 vgk0haBjfzMqyqlDgO4OD9tkBNtDa5G1048a2Do3Y0wpVcE6yy/BOWfOJUbPOTWgfDp2VZb
 99rn7bvr0kQHxZ93jm7EQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:uQhb7eLSbhY=:TN95Fpp5P5GIFCn21i8k5t
 PGoAaSxpXqVhpmSPwf25PanNryr1XD5/NqsbpH1nfhIqZUMdoyp3F0xhbnnUMloc6FpJhZto5
 und5VnQId04ku17hdCx4qTNtnhltinaM2ADV4yKM2S6yZrGM642LkvBwfU92X6/QhPxkmWnty
 lvobIj5nzs3E1deGlQH8jSS+G0dqmMJrVzzf9d9HhXYB7EZOy2Sg3kI/iKhCNgC+S9n1VNWn3
 5l0o58wKFxOvtYz/Kco9KMRBNFytAnoCk53UOL+8nF0PkdyYyBmeCEW2xbmUO8+it9dudRR89
 6xl3P51Q6fT/KFzP4Zb5+vFqGon68ZlpZm6tqohQygFwS/ull42HzjJ+KBt0eVae+oo3VjOPj
 rwUCNYoVkhm23OtytjLudPrduR842g15yrJNUQ8raFlXXh8Uhdl5BENo3ju7j46fWnjLbsyNN
 whV4vmqIH/orv/QyPfg3pfM8CD6C3oPzY5rUPwE56WSMaeyPuytzEZ+/w4GtFZAHcnwUwANsj
 QPVK5Tl1V7ZlYL5Nf00LDhRNmY5m59vC0oj8qUJ1gwdK+Ux4hPVXBx2G8+KR1PtZfcuNY6HD2
 GoPN8catZ11R5OeE6cAvR4NutpzwTbziszhv1paYIUHBpFCek6jmT4Nr9axwXx8cfMcH1fRCd
 rbVIwvWtYqBxfYFiV12cIF+vXfuz6AQB04X2OyGuRJWiSt7DVlTza/xZ7/4XxtTNVn/Y2qHGO
 qziAImIwK5F1kbpWl6bdfOjHaNlIQPvpOwFLAQnkGEh1JsLDZpGOZ3k5s7Q=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Aug 22, 2016 at 05:04:47PM -0700, Lucian Smith wrote:
> I'm attempting to use the git-svn bridge, and am having problems with
> line endings on Windows.
> 
> The setup is that we have a git repository on github, and I've checked
> out a branch on my Windows machine using Tortoise svn.  I make
> changes, commit them, and the branch is updated.  In general, this
> works fine.

Just to make sure:
The repo is in git format.
Is it a public repo ?
Or could you make a piblic demo repo ?
Do I understand it right: Tortoise SVN talks directly to the Git server ?
Isn't Tortoise SVN a client to talk to SVN server?
What goes over the wire to the remote Git server, git or SVN ?

To my understanding, "git svn" can use Git locally, and talk to an SVN server.
What do I miss ?

> 
> If this was just SVN, I could set the 'eol-style' for files to
> 'native' to let it know to expect Windows/linux/mac line endings for
> particular files.  This seems to be handled in git by using the
> '.gitattributes' file instead.  Unfortunately, the git/svn bridge
> doesn't seem to be translate the information in the .gitattributes
> file to appropriate eol-style settings in SVN.  Checking out a file
> using SVN on Windows leaves me with a file without CRLF's, and if I
> check in a CRLF file, that's the way it goes into the repository.
> Differences in CRLF alone show up as 'real' differences that can be
> checked in, and, if this happens, this causes problems with other
> people's repositories.
> 
> Am I doing something wrong; is there another way to handle this; or
> can I file this as a bug report/feature request?

