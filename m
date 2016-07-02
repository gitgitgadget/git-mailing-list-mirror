Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.3 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id ED46020FD2
	for <e@80x24.org>; Sat,  2 Jul 2016 07:32:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751326AbcGBHcf (ORCPT <rfc822;e@80x24.org>);
	Sat, 2 Jul 2016 03:32:35 -0400
Received: from mout.gmx.net ([212.227.15.18]:56936 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750846AbcGBHce (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 2 Jul 2016 03:32:34 -0400
Received: from virtualbox ([37.24.141.253]) by mail.gmx.com (mrgmx003) with
 ESMTPSA (Nemesis) id 0MYg42-1anoPG2362-00VSR9; Sat, 02 Jul 2016 09:32:28
 +0200
Date:	Sat, 2 Jul 2016 09:32:28 +0200 (CEST)
From:	Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:	Junio C Hamano <gitster@pobox.com>
cc:	git@vger.kernel.org
Subject: Re: preview: What's cooking in git.git (Jun 2016, #10; Tue, 28)
In-Reply-To: <xmqq4m8c53wk.fsf@gitster.mtv.corp.google.com>
Message-ID: <alpine.DEB.2.20.1607020926120.12947@virtualbox>
References: <xmqq4m8c7uo6.fsf@gitster.mtv.corp.google.com> <alpine.DEB.2.20.1606291345440.12947@virtualbox> <xmqq4m8c53wk.fsf@gitster.mtv.corp.google.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:dm2JRbroQnhILxJAGjDba1vEdahuh0LRHiYFCjawXXYy14MhugA
 1Du6Uy+wpyi82a5VKH/XyiCej4oL48KbaXyrQbqMGH5TTEweRJIhVd390MA/CH7R0tHTUdH
 WltWn2Q25I0cjMsRv4lCpFp8xjzmpxi0FZcUO8V4GXJeLuvpM1OooU19BAYaF+xE7isUVq+
 +dPCSXWTUFROrA+iiLOFg==
X-UI-Out-Filterresults:	notjunk:1;V01:K0:f+X3BHO/bdM=:nojA+918PJgKuGuemPf/4X
 fXRgAWqspt+53wEahPf+h6yOJyUJbkArEpZ4VEkmZ3anIf2c8DvBbyIY8tmc2pEMxzfOKKCZm
 rE5gyLNlobpKcgJ6Zuco0n4bTi4etVYW+4NNIb0cuNLPlDARKSYL8ssC/XM4A+Dpt2jdTmjz1
 0rSTXB+69gwuc3GQbCc0nEfGokmI8jhCTRAqG4CxdHECSmhgkjM8waNCAKE4hGqpvBPpONaV4
 /avi0YKZEA582uK/nKUpDsoOtZtqBB92VFlkT7VfAJgFHJbGExXByRyBrgfQB4Rf07u4DlGDH
 R9ol5fWO6oadbMLH2BPjelnA/AFJ92RshTKG73hrl40kOjAjxg9KMYLhtKUD9Rkegmn475Jp4
 ti+ODMUf2LNLHwK0rGN+8UVcvCpBOchKFlSG/oHCMGDoA16CHKwn8zEQ3k9PPTcT9GJqrxhWH
 9pb9FidBKSTrbzhaR/ufeN+AqW39aOSyuvNppwKyb5m2CzYUTnfICFOghZRIJGjPVzskts6za
 AP4HEaDfARor6OSCeNKQmuUTds7XrIxYNiVY17y3gTR5qkFntZA9nVSurQbYKCt1Whv+TlbsC
 MkiZw3T0rnvAG2h74Qggg66cvX4d1UnQovBEDbjYuS9LCM+4JdO3qAI6Kyr8NzM5Ie45GjqDB
 0EueAFIUwHgNWXp8FuG2pkrudE+W9/KZ1EVMBQQv4QxNY3j/gHk5dqng5t8/cyVs91x360OjW
 xgijOgWqUor+SgvYUKuTFAggHvo9g7seNQvIwZ7O3ZGqh9DkyxZnajDHyjVAyI37/FUd8lPA2
 AcDy/jg
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Hi Junio,

On Wed, 29 Jun 2016, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> > On Tue, 28 Jun 2016, Junio C Hamano wrote:
> >
> >> * jk/ansi-color (2016-06-23) 7 commits
> >>   (merged to 'next' on 2016-06-28 at 354989c)
> >>  + color: support strike-through attribute
> >>  + color: support "italic" attribute
> >>  + color: allow "no-" for negating attributes
> >>  + color: refactor parse_attr
> >>  + add skip_prefix_mem helper
> >>  + doc: refactor description of color format
> >>  + color: fix max-size comment
> >> 
> >>  The output coloring scheme learned two new attributes, italic and
> >>  strike, in addition to existing bold, reverse, etc.
> >> 
> >>  Will merge to 'master'.
> >
> > Please note that those "colors" do not work on Windows, at least as far as
> > I know, I only skimmed the code in set_attr():
> >
> > 	https://github.com/git/git/blob/v2.9.0/compat/winansi.c#L175-L314
> >
> > ... and it looks as if italic is plainly unsupported, and strike-through
> > is not handled.
> 
> This hopefully is a low-hanging-fruit for aspiring new developers in
> the Windows land, perhaps?

I think that winansi.c would already implement it if it were possible.
Probably there are no character attributes to change the font to italic in
the Win32 Console.

*me-goes-and-looks* Yep, that's the case:
https://msdn.microsoft.com/en-us/library/windows/desktop/ms682013.aspx

> We do not use italic/strike as a built-in default style for
> anything, so we do not have to wait for Windows support of these two
> attributes to appear to include this topic in the next release.
> 
> After all, users on "screen", or anything that translates these ANSI
> colors via termcap/terminfo, do not get them, either.  A user may
> try using these once, notices that her terminal lacks support, and
> would move on.

Yes, this was what I was getting at: I would appreciate it, along with
many Windows users, if we did not use any italic nor strike-through styles
by default, even in future versions.

It is fine, of course, to offer them for users to configure. After all, in
the default Git for Windows installation, the Win32 Console is not used,
but MinTTY, which is a full ANSI terminal emulator (so I'd wager a guess
that italic and strike-through are supported).

Not sure whether a comment in the documentation is warranted, though.

Ciao,
Dscho
