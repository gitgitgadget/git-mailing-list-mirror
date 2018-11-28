Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 48CC81F87F
	for <e@80x24.org>; Wed, 28 Nov 2018 09:23:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727668AbeK1UYy (ORCPT <rfc822;e@80x24.org>);
        Wed, 28 Nov 2018 15:24:54 -0500
Received: from mout.gmx.net ([212.227.17.22]:44791 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727585AbeK1UYy (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Nov 2018 15:24:54 -0500
Received: from [192.168.0.129] ([37.201.193.149]) by mail.gmx.com (mrgmx103
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MNIO5-1gLaQ835wH-006sXt; Wed, 28
 Nov 2018 10:23:49 +0100
Date:   Wed, 28 Nov 2018 10:23:50 +0100 (STD)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Jonathan Nieder <jrnieder@gmail.com>
cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>, git@vger.kernel.org,
        Ian Jackson <ijackson@chiark.greenend.org.uk>
Subject: Re: [PATCH] rebase: mark the C reimplementation as an experimental
 opt-in feature (was Re: [ANNOUNCE] Git v2.20.0-rc1)
In-Reply-To: <20181128043154.GA34163@google.com>
Message-ID: <nycvar.QRO.7.76.6.1811281015360.41@tvgsbejvaqbjf.bet>
References: <xmqqmuq25ufc.fsf@gitster-ct.c.googlers.com> <87y39w1wc2.fsf@evledraar.gmail.com> <877eh219ih.fsf@evledraar.gmail.com> <xmqq36rq2cp0.fsf@gitster-ct.c.googlers.com> <xmqq36roz7ve.fsf_-_@gitster-ct.c.googlers.com>
 <20181128043154.GA34163@google.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-201860786-1543397031=:41"
X-Provags-ID: V03:K1:yPNN6GJQBoEu9muJgZusfP7BEbD/st/SUkEh4EDXrwtyAbzmPbf
 D6LnDFSHD4wQ8yyNZQi8SpLveIhCQqKxKevvJ460jWwIi6RzOVRow1gMlnLo5idWU8tKuVc
 2ilFWxi2TMJauQjpaLK8pWCQ3geTUDBEMhmdh01V12KLwo8bBshJeu4mgIhSzRmVKOqhTCZ
 4XUM4uWmru1cdZnT00n+g==
X-UI-Out-Filterresults: notjunk:1;V03:K0:FwhxunA+i1M=:qvzorNS2tXVj1ej+SlP7Yv
 9TugEymZxNEjzeWmc4q7teJEAV3+UgR8NxKueP5r8sh5V1XSNxpa+XibqAvGkGg5BATogbVOH
 98FqRS1RLqAizhzew+VLTyZmQugRU2fykONRg/VYEvwaRudeSkPSB9rb0Dk5MtHoYBNSKp4Fg
 yHXjmUgvfyltoJAIp7PymAUqXnxbpbHHQuC2xZDHJxGcac/TWQIQfpWhBsG7t3oNI0ZgOsWg2
 rdsqav0/1IXkmRu5M+V+toXobZVHWfVVmcLmzkj5ycP75bQtW/p8RdM+u2VSKy56T4BPMagbr
 VWHlHWWRyiGuM8NMLUmDz0OaMN80liQE420SHW0sDC+agP3z6NvX8uRtT2ztKiEsi1yPnmx0Y
 6fPsTRW40K6Rz2f/+ARf0ko4GkUDqFk9FGex+El702VQ4UmEx/tiXfKeTjE03jDG/6UeS9m++
 3kiw/6wIe4+fqruHdptBAKM8NCnObhaL2Rny51eVn+J19Vky6zOFmceSc/4zCSULNFy4ufnCH
 VE+nxGjcJ45iYrDSu5AKvgr1IudLwvSu1nuSusSOQRII+apLWRPPXD2kEOPAMpc9m5MDopdL1
 +f64i7MLSvks8sOyvNC7jPUJw+SCSGM2n6vlXY5Q/Fgsl1PvIivD/kWesgWDES0rceSeECERR
 f2s6T+mp6PSp71QljMlsThZvM5mOAIQVsnETcRd5aXTiSVwofwPf4E6CxsOXo7VJScDs+ZxZU
 xKPkyVfX8xNflXSYt4UoDNcweuagYekfvVlVi5SldlGfd0j7yv3FmxeMzc9XAi1h1ubdkBcSy
 FaosGRzTt30mPbFHi4cHxhMXvj6fNpOtnr9EwDGJLIMIIHmrBeqm+3L5XueiemAYFKPIH+1dx
 ofC7Pmh3yKVXyTHMyt2O8baMJ8yvRRFD+d5ha55b1nxPB3uFYInK+xNymtLxe4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-201860786-1543397031=:41
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT

Hi Jonathan,

On Tue, 27 Nov 2018, Jonathan Nieder wrote:

> At https://bugs.debian.org/914695 is a report of a test regression in
> an outside project that is very likely to have been triggered by the
> new faster rebase code.

From looking through that log.gz (without having a clue where the test
code lives, so I cannot say what it is supposed to do, and also: this is
the first time I hear about dgit...), it would appear that this must be a
regression in the reflog messages produced by `git rebase`.

> The issue has not been triaged, so I don't know yet whether it's a
> problem in rebase-in-c or a manifestation of a bug in the test.

It ends thusly:

-- snip --
[...]
+ git reflog
+ egrep 'debrebase new-upstream.*checkout'
+ test 1 = 0
+ t-report-failure
+ set +x
TEST FAILED
-- snap --

Which makes me think that the reflog we produce in *some* code path that
originally called `git checkout` differs from the scripted rebase's
generated reflog.

> That said, Google has been running with the new rebase since ~1 month
> ago when it became the default, with no issues reported by users.  As a
> result, I am confident that it can cope with what most users of "next"
> throw at it, which means that if we are to find more issues to polish it
> better, it will need all the exposure it can get.

Right. And there are a few weeks before the holidays, which should give me
time to fix whatever bugs are discovered (I only half mind being the only
one who fixes these bugs).

> In the Google deployment, we will keep using rebase-in-c even if it
> gets disabled by default, in order to help with that.
> 
> From the Debian point of view, it's only a matter of time before
> rebase-in-c becomes the default: even if it's not the default in 2.20,
> it would presumably be so in 2.21 or 2.22.  That means the community's
> attention when resolving security and reliability bugs would be on the
> rebase-in-c implementation.  As a result, the Debian package will most
> likely enable rebase-in-c by default even if upstream disables it, in
> order to increase the package's shelf life (i.e. to ease the
> maintenance burden of supporting whichever version of the package ends
> up in the next Debian stable).
> 
> So with either hat on, it doesn't matter whether you apply this patch
> upstream.
> 
> Having two pretty different deployments end up with the same
> conclusion leads me to suspect that it's best for upstream not to
> apply the revert patch, unless either
> 
>   (a) we have a concrete regression to address and then try again, or
>   (b) we have a test or other plan to follow before trying again.

In this instance, I am more a fan of the "let's move fast and break
things, then move even faster fixing them" approach.

Besides, the bug that Ævar discovered was a bug already in the scripted
rebase, but hidden by yet another bug (the missing error checking).

I get the pretty firm impression that the common code paths are now pretty
robust, and only lesser-exercised features may expose a bug (or
regression, as in the case of the reflogs, where one could argue that the
exact reflog message is not something we promise not to fiddle with).

Ciao,
Dscho
--8323328-201860786-1543397031=:41--
