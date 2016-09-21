Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.3 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4526E1F935
	for <e@80x24.org>; Wed, 21 Sep 2016 18:22:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934161AbcIUSWm (ORCPT <rfc822;e@80x24.org>);
        Wed, 21 Sep 2016 14:22:42 -0400
Received: from mout.gmx.net ([212.227.15.19]:61398 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933024AbcIUSWl (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Sep 2016 14:22:41 -0400
Received: from virtualbox ([108.198.118.51]) by mail.gmx.com (mrgmx002) with
 ESMTPSA (Nemesis) id 0MD9NE-1bliMQ3GP6-00GXX2; Wed, 21 Sep 2016 20:22:35
 +0200
Date:   Wed, 21 Sep 2016 20:22:32 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Junio C Hamano <gitster@pobox.com>
cc:     git@vger.kernel.org
Subject: Re: What's cooking in git.git (Sep 2016, #05; Mon, 19)
In-Reply-To: <xmqq8tulclcu.fsf@gitster.mtv.corp.google.com>
Message-ID: <alpine.DEB.2.20.1609211937360.129229@virtualbox>
References: <xmqqd1jzcvs5.fsf@gitster.mtv.corp.google.com>        <alpine.DEB.2.20.1609202349260.129229@virtualbox> <xmqq8tulclcu.fsf@gitster.mtv.corp.google.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:6JE5MpE31S+Ubm08jmJWdvy5gwiO1wceoIRgwT9dUEFjVLPZ9S/
 Js6yF1c0B3pXXKmtObX+U0NoZ0re1QSrnNty51qFQYZmXfdRth4VyY/0KwlxTNXJL5AuZHN
 VJsBUAd4Ky2myB5O617VHoCuDEnv7j+SyspU+ZGes04pQbPftSumNqBePK4dtY/ErxHObV0
 4FQ0yHCbyd4N8VuFBsuXA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:+mHQhZrbh0w=:TCDomIpbMjvqhTq11YRysf
 szSkXSW5zanQghplAg5gVHkqqixDNs1Tzt20R/GUh6gQqpRR3N0lp55ecU36OTe9kxGvJT1xI
 wAPscN5/OpwDBpzLvQjjcqilfaTjPOjSEM7vosU79UWsvQHDMbOibIxchr4ExGv0Uv9LNp9Tb
 pJ/oQflxGrBwv9sYOnRQaugCYIgg87eCYQpEiErovW2cm/VnVTsXos3DgON8JEM2iOR2IHWhP
 MRwWnJHu/ONsWLX3xaBP0D9xyqXFGkCRc8nXkDs4lY0F9wbcKrmRObXluugEtJz/NHNO0tzrZ
 comAgdhkxh8aiylsYZaacmDhfP/aReBCDgbS9zJuL4tdFkG90F+j2UzH55wo4ypoKetTPzIrg
 EzEDC13eE2kUnhmNZK2+u1PKBxqIk2vJ/06JZL9nyyCg0HoOTfQ+TeM2+TwtMMmecpcOF/Y2i
 DfXqpN1lM6TswLDRGm246Vd4y6ixOubymXo1RS4LESoZqu+YDkQKTZHA4/ccqTO25cGOboIVD
 335XcN5/OMscwKRpKFunWhhwFTWIiR2hJrH3a4OJMoEKh665k69yi8tFXtZFxEsTI4l13bNVn
 5FGPWV969BHwa883Tr3bJP2ucHj+ukcBkqKJW5oWygNZiXsxkDveTQdXf2qvUd6euhtBGIZTA
 E9SlT22Hd5EmEgVWVCiXnqOro6xBYetV4qkIRZbU5oPdi3oP9JML/j9xZoAEjWaImKLF8H5w3
 e9U8u17y0A53lDJVeSNo3qhNHnizfZke9L6wTfD7IIrDMGAKFqvI99miCA0Vu+lI0c4yyvY/n
 xJONjSy
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Wed, 21 Sep 2016, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> >> * jk/rebase-i-drop-ident-check (2016-07-29) 1 commit
> >>   (merged to 'next' on 2016-08-14 at 6891bcd)
> >>  + rebase-interactive: drop early check for valid ident
> >> 
> >>  Even when "git pull --rebase=preserve" (and the underlying "git
> >>  rebase --preserve") can complete without creating any new commit
> >>  (i.e. fast-forwards), it still insisted on having a usable ident
> >>  information (read: user.email is set correctly), which was less
> >>  than nice.  As the underlying commands used inside "git rebase"
> >>  would fail with a more meaningful error message and advice text
> >>  when the bogus ident matters, this extra check was removed.
> >> 
> >>  Will hold to see if people scream.
> >>  cf. <20160729224944.GA23242@sigill.intra.peff.net>
> >
> > Let's do this.
> 
> We have already been doing it (i.e. "hold to see if people scream")
> for some time.

I meant: let's merge this to `master`.

> Does it conflict with your effort to reimplement "rebase -i" in C

I do not think so.

> to keep this in 'next'?  Do you want it to move to 'master'?  I was
> under the impression that it would not make a difference to have or not
> have this patch once your reimplementation gets merged (meaning: the
> removal of the three lines will be done by wholesale removal of
> git-rebase--interactive.sh done the endgame of your series), so...

Oh, I failed to make clear that my patch series do *not* remove
git-rebase--interactive.sh. I just barely started to work to that end.
While the speed improvements are quite noticable, the rebase--helper
command still only implements the performance-critical code paths in C.

There is quite a bit of work left to do before git-rebase--interactive.sh
can be retired:

- --root is not handled via the sequencer yet,

- --preserve-merges is not handled either [*1*],

- the shell script still sets up the state directory,

- option parsing is still all-shell,

- probably more tasks I forgot.

The good news is that these parts can be converted independently from each
other, and even by independent developers (hint, hint ;-)).

Ciao,
Dscho

Footnote *1*: I am not sure that I want to port -p to C: in my view, this
is a failed experiment, to be replaced with a design based on my Git
garden shears. I tend to think that that part should be moved to a new
shell script ("git-rebase--preserve-merges.sh"?) unless some developer
other than me feels strongly enough to put their money where their mouth
is and teach the sequencer about it.
