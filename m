Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A8E1A208E3
	for <e@80x24.org>; Tue,  5 Sep 2017 13:40:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751417AbdIENko (ORCPT <rfc822;e@80x24.org>);
        Tue, 5 Sep 2017 09:40:44 -0400
Received: from mout.kundenserver.de ([212.227.126.133]:51767 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751031AbdIENkn (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Sep 2017 09:40:43 -0400
Received: from skimbleshanks.math.uni-hannover.de ([130.75.46.4]) by
 mrelayeu.kundenserver.de (mreue002 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 0MIDV8-1dlNH41r9K-003ycm; Tue, 05 Sep 2017 15:40:40 +0200
Subject: Re: signing commits using gpg2
To:     shawn wilson <ag4ve.us@gmail.com>, Git List <git@vger.kernel.org>
References: <CAH_OBieqSY8To9okRTL-z5dnjW=_NLzA+n5-7=eou=Lx33hBdQ@mail.gmail.com>
From:   Michael J Gruber <git@grubix.eu>
Message-ID: <0e626914-05b1-651c-9c61-b1ef0b6c190a@grubix.eu>
Date:   Tue, 5 Sep 2017 15:40:39 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <CAH_OBieqSY8To9okRTL-z5dnjW=_NLzA+n5-7=eou=Lx33hBdQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: de-DE
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K0:sVOvKCQEt2ysyWFGphOwyf4Iv+De2yoFnUJSM8gif/zdzRjLGXU
 aLT5Gj/x43gEmGsOtGOBSZpbeVyL5sTBpgBjWNXvvr6FqiTPiVXmNpRlxrlB0UPVa+QfnwQ
 XtGASthL2SGWkmLEeZH6o7TaucJUgGHMc4tw4vf/bO1pqS2VW5gn/qzX9pVxRM3Ts0w0DdK
 zHFLdkndZZFmiOvw8HEHw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:4ulShjkONn4=:qEqc/r+eTOp+1Wi6te+uIb
 Ml0mYdaA6s1ywMOeVAFboskXYutLbrBETO1b1HREifOwrbvZdirNaR1PUf9volNpVg7tEW7Pe
 Ef8AQ33yfcwAs/HDTOWJMpmc2htRA5hjcj82G0bymH0osLW3teQ2mfFiamw+n/14c8mhGGCbG
 gc3BL8uXd04MjMuZDWQiOctRH/IJGuYoPjKzUdnd5l87tKvAsVk5ALcCQK/73Z65R6ppF1+jn
 f/bxuaZYJKOD7zfJDqBTQo0u31m0nGB3n32HYO4gNePrj/il2x1skK4hTqwBJKirCyXp5oAKp
 CeA9pUId2uoYZicLsavn2Gv4AlIff9UudxqXwbJsqUExDHaN180nHNijobw8q9+/zJXiTFAI1
 do95WjwpTLiIIpmiiJezEgvwaOh7vKwVbAc6VzX4REsRrESxVFjd6WSDziXDrjJrcb9RVTUMO
 46pjM/DmbBaL95q1h2CEoauSKbz4pRCr7fRIeE0AYght/nbebZ55xc6cPixdT/51Y94I48+rD
 MdmzMrhyyAzuxINtoQB80VOnX7qVE4/TlDSiSb9HdHug3S4SS21FO1KDNd74s390rKRj4XmHS
 4KlXdolTsvRUXbssTA2dKsIh0gbYpDCxq01qUiIyBCGxBbygd3R9zPZtownc9YK7CkMB6DzXq
 aK1nWsDuTcAflJEVa1pYarqMIaYeQXtkRXr6k0Ne+Kh0+WUSIg4oyo5fTx4tNQryj34YS1hlQ
 oVCbb+ucdnZR6ZDnMq5Vb43PCOwMkz2O0G0wDTGlaziGLmx4rfz16y+uggk=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

shawn wilson venit, vidit, dixit 02.09.2017 23:11:
> tl;dr - how do I get git to use gpg2 to sign things?
> 
> I'm using gpg2 (so no agent options are configured but an agent is
> running) which is configured w/ a Nitrokey (Pro if it matters):
> 
>  % git commit -m "Initial."
> 
>                                  gits/bash-libs (master ⚡) localhost
> gpg: detected reader `Nitrokey Nitrokey Pro (000034670000000000000000) 00 00'
> gpg: pcsc_connect failed: sharing violation (0x8010000b)
> gpg: apdu_send_simple(0) failed: locking failed
> Please insert the card and hit return or enter 'c' to cancel:
> gpg: pcsc_connect failed: sharing violation (0x8010000b)
> gpg: pcsc_connect failed: sharing violation (0x8010000b)
> gpg: apdu_send_simple(0) failed: locking failed
> Please insert the card and hit return or enter 'c' to cancel: c
> gpg: selecting openpgp failed: general error
> gpg: signing failed: general error
> gpg: signing failed: general error
> error: gpg failed to sign the data
> fatal: failed to write commit object
> 
> This works with gpg and ssh:

Not really...

>  % touch foo
> 
>                                                          ~ localhost
>  % gpg2 --sign foo

... because you're using gpg2, not gpg.

> 
>                                                          ~ localhost
> gpg: using "846FF490" as default secret key for signing
>  % cat foo*
> 
>                                                          ~ localhost
> -----BEGIN PGP MESSAGE-----
> Version: GnuPG v2
> 
> owEBuQFG/pANAwAKAYwdY7SEb/SQAcsJYgNmb29ZqxfviQGcBAABCgAGBQJZqxfv
> AAoJEIwdY7SEb/SQAcEL/jonw+HymnlmfebtEwlvfx2Gl1Sbuw0xWWPpQ2Dtjljz
> HtpD+LWczjpOSMTHFNK9xPR2kcs1WNY+mO8M45QI7iDgFkKRzaxEqeNUJkoyF/+I
> 81VMmXDQMXFs4+8jy00b+UxTdvwdXaHMsOtu+6YCtmCR5Bzohg07ADsnXnGGn3Sd
> WTjVMzV6Dlh8LRF+coGJ8JuErBsRAI6vdNgJRVHYBULGNXci4uF/4a+58uiTL4/U
> PvC4ruXCNxCKi89nMERhwlnOvglseX3TDR5ldrc4Hzb+pLsj/l6N4sBW0Zmb8UcE
> 9BG3WjOs4eZvnLmk5XHrwisD2CXuHvyWMl0yH7LTrg+m4Itj0PJ4Px4H9E5t/zfs
> C1vcB/okcigeIyXnO06um02a5oZAYOKadB+6NRnBjULz5GvP2yxj/AO1VPmZprpt
> budMuHZcA0zNE3uBmcnQY5+1tdkyTrlTxsL58lQrn/U3wvgah3AXMEvjRGqbYWHj
> jDikQVJ7ESoevNqlfLPj8Q==
> =hV6v
> -----END PGP MESSAGE-----
> 
> However, if I try this w/ the old gpg:
> 
>  % gpg -ae -o foo.gpg foo
> 
>                                                          ~ localhost
>  % gpg -d foo.gpg
> 
>                                                          ~ localhost
> gpg: detected reader `Nitrokey Nitrokey Pro (000034670000000000000000) 00 00'
> gpg: pcsc_connect failed: sharing violation (0x8010000b)
> gpg: apdu_send_simple(0) failed: locking failed
> Please insert the card and hit return or enter 'c' to cancel: c
> gpg: selecting openpgp failed: general error
> gpg: encrypted with 3072-bit RSA key, ID 41826CFB, created 2017-03-13
>       "Shawn Wilson <ag4ve.us@gmail.com>"
> gpg: public key decryption failed: general error
> gpg: decryption failed: secret key not available
>  % gpg2 -d foo.gpg
> 
>                                                          ~ localhost
> gpg: encrypted with 3072-bit RSA key, ID E27FA0B841826CFB, created 2017-03-13
>       "Shawn Wilson <ag4ve.us@gmail.com>"
> foo
> 
> (yeah I added data to the file)
> 
> And just to prove basic competency checking:
> 
>  % git config --global -l | grep sign
> 
>                                                          ~ localhost
> user.signingkey=846FF490
> filter.gitconfig-rmuser.clean=sed -e "s/^\( *email =\).*/\1 <email
> address>/" -e "s/^\( *name =\).*/\1 <real name>/" -e "s/^\(
> *signingkey =\).*/\1 <gpg key>/"
> filter.gitconfig-rmuser.smudge=egrep "^ *(email|name|signingkey) = "
> commit.gpgsign=true
> 

So, gpg2 works and gpg does not. This is typical for the way in which
the gpg upgrade path is broken, and your distro installs gpg because it
still relies on it.

git sees two executables gpg and gpg2 and uses the first, so as to not
migrate your secrete key store inadvertently.

Short answer: Use

git config --global gpg.program gpg2

to make git use gpg2 which apparantly is your working gnupg setup.

Michael
