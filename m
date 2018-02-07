Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 579B11F576
	for <e@80x24.org>; Wed,  7 Feb 2018 06:32:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753376AbeBGGcH (ORCPT <rfc822;e@80x24.org>);
        Wed, 7 Feb 2018 01:32:07 -0500
Received: from mout.web.de ([217.72.192.78]:54000 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751022AbeBGGcG (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Feb 2018 01:32:06 -0500
Received: from localhost ([195.198.252.176]) by smtp.web.de (mrweb103
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0Ljamy-1fGA7J1YGe-00bZEv; Wed, 07
 Feb 2018 07:31:49 +0100
Date:   Wed, 7 Feb 2018 07:31:47 +0100
From:   Torsten =?iso-8859-1?Q?B=F6gershausen?= <tboegi@web.de>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Lars Schneider <larsxschneider@gmail.com>,
        Git List <git@vger.kernel.org>, Johannes Sixt <j6t@kdbg.org>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Jeff King <peff@peff.net>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Johannes.Schindelin@gmx.de
Subject: Re: [PATCH/RFC v5 7/7] Careful with CRLF when using e.g. UTF-16 for
 working-tree-encoding
Message-ID: <20180207063147.GA22714@tor.lan>
References: <xmqqshawfgaa.fsf@gitster.mtv.corp.google.com>
 <20180129201911.9484-1-tboegi@web.de>
 <55B6C3D5-4131-4636-AD0E-20759EDBE8CD@gmail.com>
 <20180130144002.GA30211@tor.lan>
 <10091BA4-1069-4A65-9057-CAAD87F9B55F@gmail.com>
 <20180131172837.GA32723@tor.lan>
 <xmqqtvuzcibz.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <xmqqtvuzcibz.fsf@gitster-ct.c.googlers.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Provags-ID: V03:K0:gjCu2jDrRlgdxLqzG3WDQoj47KIh56rdTzLwXVy0wc2YSIyJ94O
 XsTo8tOmFBvfrEhfhI+BR2LBRJv1VCpP3llx6aZzIExsub3aNnD6xuFjzEGC/RBzDfZtHk4
 hKr63Hkb38MseuxgxD1oGri8CGpbXuVIDnCNk56rm1+EqNJP8bblr26EYuKXpPuO9CoUdK3
 OcFJofcTTsOvtRHsD42Yw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:IfxnZ5AqrvQ=:0y4LpxyQj2Sn6haHmLG/xc
 naksxjGeq4QnvGlekLgHZFfhGwznSqp8oupmgSZW73HyymeCueU9bmi6SZZZ56W/nk7miwxhJ
 3/8gFFwc8iq8C+Ltol+uLZrOc24XjSwOZ5BjK+C4+ZL+mG1RseGdIKem6IQ12w4nPatlRKbqU
 YDKIy66YeJDFD2rIQfVIeIrBZoho7c4NEkvxjSm/4CGEme99E2HlgOBILxCumG5dA+S6WQhzd
 EPOf3i/mSUztH6SnDRU2NvrEzRPv43skSU+8B59kZaRwnsNrCln8+dayf59wljJYFBughpVQ2
 gutAr6bdW9NFaNQgRAGEsaG3EEdD7dAPAzWBXAOfHqESe0tLVEx+VSTxGwBe4T8zFOM1/moRo
 0ZeRtXSQMo0GDeo8iXmwFoScd0kVmnvhjtDdUhq9EzSe0+1QlEnvdOQh9MsgZOJuYNmmqKEsO
 wkygg2sp18UTukH5/bzw46EXG5Hpge46n5emwVo+3kYRdK+M+U+mPuUspCruhI7+qJuGUgPWo
 OOdUc2oNrPGxJsdC1pqV6IDn2gfvGqtnCrBPHxbq6Xm4LXaudgSI6BcL17595zZKKV2bjxN8w
 fd3XgKwoK7DBbRrg1VU8jXxmiegMkPRuoCFFRKg7k3csB5tiRDsugd4gMcaNCZKYR5XQoR75c
 LhJL8d8EwXq6i3FvdTApCdv6YlOcbknAQl+YF06bzn8B1mI6wyJodYG8U+N+TKJOcrOim+iPx
 723Pz8NPS0Tctgbe+zRS7Hb6+zdGO6iBJMUlVp6KKzWkH+rR2aGLQNyrb+tFOg8wA3BXMUk7s
 bRloBNX+NszFrLll4jvvTP1MnQtWA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Feb 02, 2018 at 11:17:04AM -0800, Junio C Hamano wrote:
> Torsten Bögershausen <tboegi@web.de> writes:
> 
> > There are 2 opposite opionions/user expectations here:
> >
> > a) They are binary in the working tree, so git should leave the line endings
> >    as is. (Unless specified otherwise in the .attributes file)
> > ...
> > b) They are text files in the index. Git will convert line endings
> >    if core.autocrlf is true (or the .gitattributes file specifies "-text")
> 
> I sense that you seem to be focusing on the distinction between "in
> the working tree" vs "in the index" while contrasting.  The "binary
> vs text" in your "binary in wt, text in index" is based on the
> default heuristics without any input from end-users or the project
> that uses Git that happens to contain such files.  If the users and
> the project that uses Git want to treat contents in a path as text,
> it is text even when it is (re-)encoded to UTF-16, no?
> 
> Such files may be (mis)classified as binary with the default
> heuristics when there is no help from what is written in the
> .gitattributes file, but here we are talking about the case where
> the user explicitly tells us it is in UTF-16, right?  Is there such a
> thing as UTF-16 binary?

I don't think so, by definiton UTF-16 is ment to be text.
(this means that git ls-files --eol needs some update, I can have a look)

Do we agree that UTF-16 is text ?
If yes, could Git assume that the "text" attribute is set when
working-tree-encoding is set ?

I would even go a step further and demand that the user -must- make a decision
about the line endings for working-tree-encoded files:
working-tree-encoding=UTF-16                 # illegal, die()
working-tree-encoding=UTF-16 text=auto       # illegal, die()
working-tree-encoding=UTF-16 -text           # no eol conversion
working-tree-encoding=UTF-16 text            # eol according to core.eol
working-tree-encoding=UTF-16 text eol=lf     # LF
working-tree-encoding=UTF-16 text eol=crlf   # CRLF

What do you think ?



