Return-Path: <SRS0=ku3G=DQ=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MALFORMED_FREEMAIL,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3E9CC433E7
	for <git@archiver.kernel.org>; Fri,  9 Oct 2020 13:08:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 60E65223AB
	for <git@archiver.kernel.org>; Fri,  9 Oct 2020 13:08:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="RI3DarDr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388153AbgJINI4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 9 Oct 2020 09:08:56 -0400
Received: from mout.gmx.net ([212.227.17.21]:40317 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732547AbgJINI4 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Oct 2020 09:08:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1602248933;
        bh=8Xchu9aXFG3qz58nn0gJc8jAfG+xVwEhvRDCHdThsiM=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=RI3DarDrDONy5HDjxkTN9JyeXhZN/0FAaGyPoTQTSPxy7vgA9kYY60jxeim4mKtQd
         Lw0AXSYNm3eQJtYRqkV85IBQkVTTkbvXEvc0LHHODfHniwNjJGGgY1kRSQwxPdrOXb
         SKPpf4WDTxsKYyOJzbQH2C4xwCzAUgQS6y1C2CKY=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.20.73.169] ([89.1.213.205]) by mail.gmx.com (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MaJ81-1kwxqS32ZB-00WExl; Fri, 09
 Oct 2020 15:08:53 +0200
Date:   Fri, 9 Oct 2020 12:51:11 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Denton Liu <liu.denton@gmail.com>
cc:     Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH] Makefile: ASCII-sort += lists
In-Reply-To: <20201009014528.GA1314@generichostname>
Message-ID: <nycvar.QRO.7.76.6.2010091250200.50@tvgsbejvaqbjf.bet>
References: <f0f1ef1f677133eabd1bce00c6cdbbcc6477f00b.1602142738.git.liu.denton@gmail.com> <nycvar.QRO.7.76.6.2010081156350.50@tvgsbejvaqbjf.bet> <20201009014528.GA1314@generichostname>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:5CT6QmH0d3ZfZzpCLaCIo9RxJarv73cEWZsrf49SiHosdAqMXo1
 IXt3U4ZBAhH6Vm38Ma2CxFi2aOSzdAZzl28CEORda+GfXFFWXbWQa5mn5RT5uN6kPrU2SZU
 QMkmYS+NWo9PlPavi9TA0xLS8XibW7XOjkmj+8LhQNQG6kby+BS2d31ykKJzvUVaoxZ+Of0
 66DHBZj+vv5/TwEErJbHw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:MSUSn4jenTQ=:z/XpYolSA8n1RxsIB2fdd7
 jxWpOLArX5VrOj+eop5gXvl/zF20zPlusx2ol2ckstwf+Djebj7tq+5pmsdZF+CoSh9mxYyju
 zRTE8V3H107HVfFzJ/l28iCf2x27WLwq6MpnqE5Oje9n0NfVi6yT5SSskTnlVEDVIG1jt6X3E
 F9GrWt6ZxZigxcJgtFABqBRWr1U9H/BkKRFG6QHTcM+e4J+/oRcig6736RvXgCJG2XtQBAKwQ
 ac2glPhEE+TcrPfj8FiyLRNF6hyYYAfwxAIETUFoqKvoQSWJGR6VlQAw1IJmEJD7Bnpt1DXsp
 osKxRtJ1WlUIEL/pWQOeXZ52uKW1ekMoUkrWM0WkKOkCdDku0eZUT0lPy250eTBtGdfdvL5DI
 WQIJgVoFWvuxfW1g9I0OiZDSOTj0yBzrwL60E2vvXgLycZCWJNjuNDXE/jqzh/+crPDhtXjUY
 m457XeO7fo2LSkxrdKnSv0SlX8ZYw54U9WrWnCaEcrP30cm0WaF3n3txtyp0ZRooZhZwffeoD
 irvY1UtSocZtJjNoPSkujq4YK8CsfqjinH2krjEwZrG00DuFV7jnEVJfyQdAtIDiM3GMDeeqh
 JxqLFdxPAbYKix1UjWYcjr/NdvzQLpPe5mSZ8qiAxxNaIl4FX+utyXzOKh9YOSwZzCMGVns9y
 uUcu7XzOKxSMS+hZVifDW32i9NAE6k0/IiA62r5ygAM9zkjqqsZfU/4ayDZDMr9RHIbQAjnLW
 7g/rNZEIkUKAV74421TK5Ag8o5CkV7HQ9yqc8ZkUWloNPluw87RUXqYPaiMOhKrWJyMf/bwUt
 pAQ8P/Pews0S1H156PR27bp+lhExAc+JGm0Zp2HvqZU5qHzBgSWYmjB8uMEFKE+ilrgQ/BsQI
 W9bpITD0k3JYfbshO2O5zm92wsX+Iq9d16i64c8qcNFPsAnXHaD3cUBdYxwU2W0gJqvg9hk9j
 OP9wg5yntAXyMX1WbxIgMNvva4MTcPthb5aUGjhJD5AzYWttDGvukl9erg3XLdS+X1aHEGItc
 va3S9XPlswOvYbPU3hO0s7hKxzEqUOlwOXcXKHLTOiMLDWvgy4W6thXiqnqtbCzdwy029Tl/0
 rTXidYQWJ35muvBQ+oB6uRI5IEa6dp0Ocf6oLxqL3Oa8TkQts0Pa1MejX8+m+ittaysWVUXvY
 r4yp5thn3R3/c49EZYX+5GjWnJJwH4ixeW+lCOnCxMLiWkAzdqpmpV0+GW1WK2NtpGYRa+Kr2
 /eIbp7ewIa3GkKem7oabXhQCQXRQVb5EE/XUr+Q==
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Denton,

On Thu, 8 Oct 2020, Denton Liu wrote:

> On Thu, Oct 08, 2020 at 12:06:47PM +0200, Johannes Schindelin wrote:
> > Also, this strikes me as yet another task that is so automatable that =
we
> > should really avoid bothering humans with it.
>
> Yep, I found these changes via a similar-looking Python script. I like
> the Perl version, though, since it gives a path for inclusion so that we
> can automate this task.

Heh, when it comes to string processing, I always reach for Perl.

> > I gave it a quick whirl, and
> > this Perl script seems to do the job for me:
> >
> > 	$key =3D '';
> > 	@to_sort =3D ();
> >
> > 	sub flush_sorted {
> > 		if ($#to_sort >=3D 0) {
> > 			print join('', sort @to_sort);
> > 			@to_sort =3D ();
> > 		}
> > 	}
> >
> > 	while (<>) {
> > 		if (/^(\S+) \+=3D/) {
> > 			if ($key ne $1) {
> > 				flush_sorted;
> > 				$key =3D $1;
> > 			}
> > 			push @to_sort, $_;
> > 		} else {
> > 			flush_sorted;
> > 			print $_;
> > 		}
> > 	}
> > 	flush_sorted;
> >
> > It is not the most elegant Perl script I ever wrote, but it does the j=
ob
> > for me. And we could probably adapt and use it for other instances whe=
re
> > we want to keep things sorted (think `commands[]` in `git.c` and the
> > `cmd_*()` declarations in `builtin.h`, for example) and hook it up in
> > `ci/run-static-analysis.sh` for added benefit.
> >
> > My little script also finds this:
> >
> > -- snip --
> > @@ -1231,8 +1231,8 @@ space :=3D $(empty) $(empty)
> >
> >  ifdef SANITIZE
> >  SANITIZERS :=3D $(foreach flag,$(subst $(comma),$(space),$(SANITIZE))=
,$(flag))
> > -BASIC_CFLAGS +=3D -fsanitize=3D$(SANITIZE) -fno-sanitize-recover=3D$(=
SANITIZE)
> >  BASIC_CFLAGS +=3D -fno-omit-frame-pointer
> > +BASIC_CFLAGS +=3D -fsanitize=3D$(SANITIZE) -fno-sanitize-recover=3D$(=
SANITIZE)
> >  ifneq ($(filter undefined,$(SANITIZERS)),)
> >  BASIC_CFLAGS +=3D -DSHA1DC_FORCE_ALIGNED_ACCESS
> >  endif
> > -- snap --
>
> I opted to exclude this hunk because it didn't seem like a list that
> should be sorted. Perhaps if we include this in the static-analysis
> script, we could define a whitelist of lists that we want to keep
> sorted?

I agree, modulo s/whitelist/allow list/.

Thanks,
Dscho
