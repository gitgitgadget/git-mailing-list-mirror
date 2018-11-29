Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 48827211B3
	for <e@80x24.org>; Thu, 29 Nov 2018 14:17:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730574AbeK3BX1 (ORCPT <rfc822;e@80x24.org>);
        Thu, 29 Nov 2018 20:23:27 -0500
Received: from mout.gmx.net ([212.227.15.15]:48561 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730527AbeK3BXY (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 29 Nov 2018 20:23:24 -0500
Received: from [192.168.0.129] ([37.201.193.149]) by mail.gmx.com (mrgmx002
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0LomJ1-1flbbK2n7r-00gnS4; Thu, 29
 Nov 2018 15:17:49 +0100
Date:   Thu, 29 Nov 2018 15:17:50 +0100 (STD)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Jonathan Nieder <jrnieder@gmail.com>
cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>, git@vger.kernel.org,
        Ian Jackson <ijackson@chiark.greenend.org.uk>
Subject: Re: [PATCH] rebase: mark the C reimplementation as an experimental
 opt-in feature (was Re: [ANNOUNCE] Git v2.20.0-rc1)
In-Reply-To: <nycvar.QRO.7.76.6.1811281015360.41@tvgsbejvaqbjf.bet>
Message-ID: <nycvar.QRO.7.76.6.1811291516540.41@tvgsbejvaqbjf.bet>
References: <xmqqmuq25ufc.fsf@gitster-ct.c.googlers.com> <87y39w1wc2.fsf@evledraar.gmail.com> <877eh219ih.fsf@evledraar.gmail.com> <xmqq36rq2cp0.fsf@gitster-ct.c.googlers.com> <xmqq36roz7ve.fsf_-_@gitster-ct.c.googlers.com> <20181128043154.GA34163@google.com>
 <nycvar.QRO.7.76.6.1811281015360.41@tvgsbejvaqbjf.bet>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1556093298-1543501071=:41"
X-Provags-ID: V03:K1:dHhZFSLFryF204Mt91JY37iS61iqm5kSJYpVtR/IEtBHtw1Yls2
 NFa0lQzgTha7OTHyN0ZSPBJ9Bhysq6bXtpCsBuqlhOMipSsrU+uiOvWUQr8g1/FaoQNj8VH
 WNVEOhRBIzKrqkqRBZAcO9+qwW1W8VXwH73cF4+LxeaTUx8xjs4w+ls8cQ0L0nDPqjV8hYi
 T1no2jjXVaHCOyuLrr67A==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Alof9AvQIFs=:V5j1JvPYiqZd+Y7Zrse48z
 6/eyFHVBeTvJKuW4JuhSFyMVFAb1ZcgeV1GAXE5BWGzBBSKh3oE9JXewFLOtZdrOvymECgzR+
 XorCqi5pkT7sMs3oOvjDRVNz/nV+i7Q7zfUXEKKhYhHX/fnDkn5vsJyPOskds2GO5Rrf5hbNg
 r10tcKUeeYyEGI3X93dKWrmauaM9ZRoFDYHdFXZP8XErk+hLZjkHPEZaZKuVRcKn+xwW1hKlu
 e56cb/tbzUkm8aDspnCxxrN74R8SimL5Bf1xYNkTqhH0NQXlkxd1XR0wnBrNxFCJPWQaaHXq3
 NuNdO7mDP//6NyDSKeEKzwvS5dLnKrXhoiNyaBd5rZxQ8xX7HlzpMq4ZszOPBzkXTdYqvvehO
 3JJWZ7veieC/KOdPy7PSVMlpX3WwX26CME3xOACQ85BMfAcvuJdooyTsRsg5P7cSZ9ryMKcKm
 V0PuJ1MdE9g83CkbI0GXjii29mMeaz8EbBOtROKL1erYivCzombcPHaAk+aTdOOXiFV53cAvK
 +vJQZ7BSgDDrhFabbH5MpsYHKPgwrJryPASZqOFj6NdcbCD7qfDCp3VmWzrQMBs9nXQMD0bOL
 JVTMvUv6odISigo1GmuyMmy4fnV9XgK17x0MuBS3GfRqXmdn3+iLaD3I9mrO7XXaGEnePT2Of
 WLm0JNUUJ57FV6HBKq4VMnNzFRD3+PVUKicAUv26kFt2DTnopp2dOTW8SI2b6I3gHHeFy69g3
 rzpKvYSMQFpIA6e90EHixMLBSki2nwXPWgOdhFBS7HM9Yfs8bRsUduPf750pehZjXkyedRyI9
 cPDYE4MGoRpgIbnAyCygnVrrrmztLuvmyAJa7ZtwBQsImXzbqSR2ge7A/IEvyw/ZNqYRoiPyr
 pZlL0+MAqtku3LiTY6cKxAtOfri3emLj/oA13gdvldpCMm9Me7Yn2+2MzBz5UgiCI34haVKpS
 zSMD3i6sNOg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1556093298-1543501071=:41
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT

Hi Jonathan,

if you could pry more information (or better information) out of that bug
reporter, that would be nice. Apparently my email address is blacklisted
by his mail provider, so he is unlikely to have received my previous mail
(nor will he receive this one, I am sure).

Thanks,
Dscho

On Wed, 28 Nov 2018, Johannes Schindelin wrote:

> Hi Jonathan,
> 
> On Tue, 27 Nov 2018, Jonathan Nieder wrote:
> 
> > At https://bugs.debian.org/914695 is a report of a test regression in
> > an outside project that is very likely to have been triggered by the
> > new faster rebase code.
> 
> From looking through that log.gz (without having a clue where the test
> code lives, so I cannot say what it is supposed to do, and also: this is
> the first time I hear about dgit...), it would appear that this must be a
> regression in the reflog messages produced by `git rebase`.
> 
> > The issue has not been triaged, so I don't know yet whether it's a
> > problem in rebase-in-c or a manifestation of a bug in the test.
> 
> It ends thusly:
> 
> -- snip --
> [...]
> + git reflog
> + egrep 'debrebase new-upstream.*checkout'
> + test 1 = 0
> + t-report-failure
> + set +x
> TEST FAILED
> -- snap --
> 
> Which makes me think that the reflog we produce in *some* code path that
> originally called `git checkout` differs from the scripted rebase's
> generated reflog.
> 
> > That said, Google has been running with the new rebase since ~1 month
> > ago when it became the default, with no issues reported by users.  As a
> > result, I am confident that it can cope with what most users of "next"
> > throw at it, which means that if we are to find more issues to polish it
> > better, it will need all the exposure it can get.
> 
> Right. And there are a few weeks before the holidays, which should give me
> time to fix whatever bugs are discovered (I only half mind being the only
> one who fixes these bugs).
> 
> > In the Google deployment, we will keep using rebase-in-c even if it
> > gets disabled by default, in order to help with that.
> > 
> > From the Debian point of view, it's only a matter of time before
> > rebase-in-c becomes the default: even if it's not the default in 2.20,
> > it would presumably be so in 2.21 or 2.22.  That means the community's
> > attention when resolving security and reliability bugs would be on the
> > rebase-in-c implementation.  As a result, the Debian package will most
> > likely enable rebase-in-c by default even if upstream disables it, in
> > order to increase the package's shelf life (i.e. to ease the
> > maintenance burden of supporting whichever version of the package ends
> > up in the next Debian stable).
> > 
> > So with either hat on, it doesn't matter whether you apply this patch
> > upstream.
> > 
> > Having two pretty different deployments end up with the same
> > conclusion leads me to suspect that it's best for upstream not to
> > apply the revert patch, unless either
> > 
> >   (a) we have a concrete regression to address and then try again, or
> >   (b) we have a test or other plan to follow before trying again.
> 
> In this instance, I am more a fan of the "let's move fast and break
> things, then move even faster fixing them" approach.
> 
> Besides, the bug that Ævar discovered was a bug already in the scripted
> rebase, but hidden by yet another bug (the missing error checking).
> 
> I get the pretty firm impression that the common code paths are now pretty
> robust, and only lesser-exercised features may expose a bug (or
> regression, as in the case of the reflogs, where one could argue that the
> exact reflog message is not something we promise not to fiddle with).
> 
> Ciao,
> Dscho
--8323328-1556093298-1543501071=:41--
