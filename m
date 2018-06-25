Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BA01C1F516
	for <e@80x24.org>; Mon, 25 Jun 2018 21:15:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752394AbeFYVPF (ORCPT <rfc822;e@80x24.org>);
        Mon, 25 Jun 2018 17:15:05 -0400
Received: from mout.gmx.net ([212.227.15.15]:50167 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752161AbeFYVPE (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Jun 2018 17:15:04 -0400
Received: from [192.168.0.129] ([37.201.195.74]) by mail.gmx.com (mrgmx001
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0M8eAd-1gKHUq3uKp-00wH77; Mon, 25
 Jun 2018 23:14:56 +0200
Date:   Mon, 25 Jun 2018 23:14:57 +0200 (DST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Alban Gruin <alban.gruin@gmail.com>
cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        Stefan Beller <sbeller@google.com>,
        Christian Couder <christian.couder@gmail.com>,
        Pratik Karki <predatoramigo@gmail.com>,
        phillip.wood@dunelm.org.uk, Elijah Newren <newren@gmail.com>
Subject: Re: [GSoC][PATCH v3 2/3] rebase -i: rewrite setup_reflog_action()
 in C
In-Reply-To: <4dfaa8d4-09d0-1156-43a4-687c3389e039@gmail.com>
Message-ID: <nycvar.QRO.7.76.6.1806252313140.11870@tvgsbejvaqbjf.bet>
References: <20180619154421.14999-1-alban.gruin@gmail.com> <20180621141732.19952-3-alban.gruin@gmail.com> <xmqq4lhurdl7.fsf@gitster-ct.c.googlers.com> <7094810.i0lmrLi0k7@andromeda> <xmqqr2kuq3qg.fsf@gitster-ct.c.googlers.com>
 <4dfaa8d4-09d0-1156-43a4-687c3389e039@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1290903297-1529961298=:11870"
X-Provags-ID: V03:K1:Lj8DkpfoZ7q2EPAkG5LQQ48L7DUOfbpljAjPYibgyi0WIlCsdFd
 /Rrzd/pd0M43Sf+g7jCtJoEDznn3oqtW8hJ8+iKRrBYILFmdFjKEq9g9tJ5UjdPyN8tgIYf
 5MFZjf2ddUR+Vd4AoQDNt6Hxj6Le46MV4QlZy23OIqDt7q78ndngIoGyaE6GHva4L3mrCxB
 3ldM+NTIMKkhU3RI4KrUg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:6gMmpZZYHkg=:1/itFqb2cujmn6wV10ooQd
 JA0JYiQj4S9Q72o+PfwOBA1j3ORryyYDLTcHkR+JOFs8RPaTF1E8apDr+bzz283yslS/XimFO
 fIftDEc2XKg8bCz53C7d9lIaFUGd1+LZHRJj8bK3FdofyTdyGsei840GzNp/jf+MyswEreC8f
 1Ux2JRrZFoKvE/NEvt8sPvwhd8CiEVnusL4es5dGLmLdKWEBXDZn8spHRhAPUU1y7ICVzPeQ7
 jVljUZGjivPktrasz/mNKFSzSQG6dSimNwNMpvXQH5vRHd8vrbsuKyjvJ0JW1395XY24mriTM
 vGjhKt+3Bv5bLjBCdaT6DBrM3Hvy9QV1NuvqQS4hRiNJR4p2ju2ybnxGq2AkoSEjnYztxvpnG
 2vQcZObXUpezKbmK96LQuSeGjzeon3+6tzRM/HE4E9ngZSbUAdyOU42uQGbHXkF485Y5IZfIR
 QOFgWhXR/U841RGfuqeiUUEy+Cu4WwpsNSsrHTjLtxpw+6dPNz9AGgxBoxGfOR/5Ztdb5aDrR
 H4ndRpJRtfhcSAjhr3MLw2/biwF4XW9gVuy6b1JtW+dOSfk/CSXP+VyU3T7g2hznfILoFZBIy
 cev478TYfaNC5Mm0o6MOmdzqFrQYWE1ElXjKQbVfYbbukL4pdtWNOCzeTRKfekDqGjnU75luk
 Tlq98syCCk8UHOdsuXmJye5tHepAZlSpg7h35wKJAL9j8stYbYIfwBNIS4BNmUJ74MHCJJsTm
 IQbcGX4+f0ccBvYDHNAAux9SQQzImPxIQTfjbx6hhrQCtb9p/Z/RakyDZp7LfQdrROxLb7rSW
 pLUdOsf
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1290903297-1529961298=:11870
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

Hi,

On Mon, 25 Jun 2018, Alban Gruin wrote:

> Le 25/06/2018 =C3=A0 17:34, Junio C Hamano a =C3=A9crit=C2=A0:
> > Alban Gruin <alban.gruin@gmail.com> writes:
> >=20
> >> Le 22/06/2018 =C3=A0 18:27, Junio C Hamano a =C3=A9crit :
> >>> Alban Gruin <alban.gruin@gmail.com> writes:
> >>>> This rewrites (the misnamed) setup_reflog_action() from shell to C. =
The
> >>>> new version is called checkout_base_commit().
> >>>
> >>> ;-) on the "misnamed" part.  Indeed, setting up the comment for the
> >>> reflog entry is secondary to what this function wants to do, which
> >>> is to check out the branch to be rebased.
> >>>
> >>> I do not think "base_commit" is a good name, either, though.  When I
> >>> hear 'base' in the context of 'rebase', I would imagine that the
> >>> speaker is talking about the bottom of the range of the commits to
> >>> be rebased (i.e. "rebase --onto ONTO BASE BRANCH", which replays
> >>> commits BASE..BRANCH on top of ONTO and then points BRANCH at the
> >>> result), not the top of the range or the branch these commits are
> >>> taken from.
> >>>
> >>
> >> Perhaps should I name this function checkout_onto(), and rename=20
> >> checkout_onto() to "detach_onto()"?  And I would reorder those two com=
mits in=20
> >> the series, as this would be very confusing.
> >=20
> > I may be misunderstanding what is happening in the function, but I
> > think it is checking out neither the onto or the base commit.  The
> > function instead is about checking out the branch to be rebased
> > before anything else happens when the optional <branch> argument is
> > given (and when the optional argument is not given, then we rebase
> > the current branch so there is no need to check it out upfront), no?
> >=20
> >=20
>=20
> Yes, you=E2=80=99re right.
>=20
> Now I really don=E2=80=99t know how to call this function.
> checkout_top_of_range(), perhaps?

Pratik refactored some code from sequencer.c into checkout.c/checkout.h
today to do exactly that. It is not polished yet, but probably will be
tomorrow. It provides a function `int detach_head_to(struct object_oid
*oid, const char *action, const char *reflog_message)`. Maybe use that
directly, once the commit is available?

Ciao,
Dscho
--8323328-1290903297-1529961298=:11870--
