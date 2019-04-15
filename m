Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MALFORMED_FREEMAIL,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 22F0520248
	for <e@80x24.org>; Mon, 15 Apr 2019 13:08:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727386AbfDONIL (ORCPT <rfc822;e@80x24.org>);
        Mon, 15 Apr 2019 09:08:11 -0400
Received: from mout.gmx.net ([212.227.17.20]:37611 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727177AbfDONIK (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 Apr 2019 09:08:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1555333684;
        bh=pr6InYg4b8zg8fQbDXqVYZ7ShwxEqqvvfRNlfGG1qXc=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=ls1q23MRTBErvjPZuQOvw5T2zMn3UxnjpriT0v8h6GSM67Vli2lONy9/jgzH8uXof
         qyFv1mQ2TpjXiZ8nUs4slsalMRcC3MO+DGQQHMLsJhjsrKV2cDe2k5zXGtRQYbAB9/
         JtClOs+ygeg+1I3djWtW2//aF3/OkVHsO1CD6IQM=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.129] ([37.201.192.14]) by mail.gmx.com (mrgmx103
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0Lrw2c-1grFW93mww-013bYX; Mon, 15
 Apr 2019 15:08:04 +0200
Date:   Mon, 15 Apr 2019 15:08:05 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Denton Liu <liu.denton@gmail.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>
Subject: Re: [PATCH v2 8/8] tests: disallow the use of abbreviated options
 (by default)
In-Reply-To: <xmqqv9zhwbxt.fsf@gitster-ct.c.googlers.com>
Message-ID: <nycvar.QRO.7.76.6.1904151503390.44@tvgsbejvaqbjf.bet>
References: <pull.167.git.gitgitgadget@gmail.com> <pull.167.v2.git.gitgitgadget@gmail.com> <a27d316855a833aa1726fc20c905dc40e41adf2f.1555061837.git.gitgitgadget@gmail.com> <xmqqv9zhwbxt.fsf@gitster-ct.c.googlers.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-756376850-1555333686=:44"
X-Provags-ID: V03:K1:pHhvmdfBYuZnbqauVGPNG4Fh/bDbRjBsQsVeAGQ2bLc2oFbsgI7
 vR1huMd0ewG7n5DRT3av006pyxAOK0+hWDzSrgSvchu2en67z9IQC7M1JXA1ewUbU7/raAx
 rAEjNlm9vghxVcGMcVk3htUm0LC9QmM/VStoAgx/te0eBT50INfqScT6vpj1YMxu6iZKkU5
 a0G02YQy6+1yKtkte9e6g==
X-UI-Out-Filterresults: notjunk:1;V03:K0:z/mKKRs7rQE=:0xrH8QrQx5n8P3gR7CsQ5y
 mbGkLJ5cpp0dqUQZVcb4JIJU4+qzN9WhoaXhEzWnePWrJ3PEv6x70s58oJzruRh8OtU82D+SX
 wY2RARsaa0jiyVy+igZlTGbuHlUGfiZSObhD7eDqSfR5rEMJKCx6K30agLj+QmXkbk/JuTEQR
 Z0OdaHM5LNNPiA2jqgnV4mx4Mnf4BP8cVM4RvGXT0SMv/Z/tCI22iOegT2lmOBc+FRcXPyqyv
 jtb+OdV62IP4iEf4TP9birqsdGTDoJ7Pgy9ZY7O7lqKkYmOT5GoJcnWHhbLO3jPeQvDgZ3JlL
 5WGXxBffHiRmK71bRx+lDTrslVnci7Ic9xX4F9YUrG7fRTaZFlRqB4sxg2NQf0CLGi5jsSymo
 tzV8wkxJ6N+EvvlliylH6hqPRzX0h+bYY5IgA2qwzF3lxCAarlG6wkAwP9j3u9Q62MwyFdezO
 R6v7xpT6tQ/bhCPVp0Ng2lHZLe7mMxhj41CBfVvnvXNfDyggq7rxZobAwLZSIu7w1MBdkgmvm
 UzrPOdeGnSouPfMF/VaTXX2fPAMJY8JeYTMEXZ61UnJzdg/9iDI3NxqU2A1t4YLkd8gG+IK2E
 u9cIFdusA4fTDhRsqAt07mA6H7zZFP2rfMda3vna9wyDMUDBST0wx+jQO7i+AXeosYql0JUWO
 3htb8Kam9jNflIrKaSAvURMKT0UYXJfJMbczbivGQwUg/jLchg1PEh+IhmnBEHJO0tD8HrlW0
 PtliZnvijRMkfupwTTiH8ZGKtZ156kuiE/gvPtrpK9+LqnG+Z8egMQLPtme/u8MQdzwTda0BC
 /g0RIwCvh1NJN7nkjqaeScMPzJXBnPMWlew7X7iM7DY4wQecCmne817xEDp9gcbQ+7VBYloE/
 qTJUTJDjuzNrBNzFSN2Dyh1walcbB7M4PVBDxAuOEAhx6Kya1YpLweoHYuDuNHfaM3sNd76GT
 pH/rwV4WcXA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-756376850-1555333686=:44
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi Junio,

On Sun, 14 Apr 2019, Junio C Hamano wrote:

> "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
> writes:
>
> > diff --git a/t/test-lib.sh b/t/test-lib.sh
> > index 562c57e685..f1a0fea4e1 100644
> > --- a/t/test-lib.sh
> > +++ b/t/test-lib.sh
> > @@ -57,6 +57,13 @@ fi
> >  . "$GIT_BUILD_DIR"/GIT-BUILD-OPTIONS
> >  export PERL_PATH SHELL_PATH
> >
> > +# Disallow the use of abbreviated options in the test suite by defaul=
t
> > +if test -n "${GIT_TEST_DISALLOW_ABBREVIATED_OPTIONS:+isset}"
> > +then
> > +	GIT_TEST_DISALLOW_ABBREVIATED_OPTIONS=3Dtrue
> > +	export GIT_TEST_DISALLOW_ABBREVIATED_OPTIONS
> > +fi
>
> If the original environment has it as flase, as it is set, the
> substitution will yield "isset" which is not an empty string, so we
> assign true.
>
> If the original environment is not set, or set to an empty, however,
> the substitution will yield an empty string, so we won't touch the
> variable.
>
> I am not sure in what situation the above behaviour becomes useful.
>
> Do you mean more like
>
> 	if test -z "$GIT_TEST_DISALLOW_ABBREVIATED_OPTIONS"
> 	then
> 		... assignment ...
> 	fi

=C3=86var rightfully pointed out that I introduced a new paradigm, so I
switched to imitating the exact way `test-lib.sh` handles similar cases.
Which is the `isset` method.

Sure, I could do something differently, like `test -z`. But why? I think
it is better to stay consistent with the existing checks.

> IOW, we'll take an explicit GIT_TEST_DISALLOW_ABBREVIATED_OPTIONS=3Dfals=
e
> as a sign that the developer for whatever readon wants the disambiguatio=
n
> code in parse-options to kick in for all uses and allow a shortened opti=
on
> names?

Yes.

Let's assume that there is a developer, or even a team (think e.g. VFS for
Git), working on some long-running features that should be eventually
contributed to Git, but that are still in flux, and through a merge with
the current Git version, they get this change, and it breaks 50 of their
test scripts.

This is the scenario I wanted to help, however unlikely that is ;-)

Of course, eventually they'd want to fix their test scripts. But maybe
right now is not such a great time, so let's let them override the
new behavior.

> If on the other hand you are protecting our tests against those
> who casually have the environment set to false, because they know
> some of the scripts they use are sloppy *and* for whatever reason
> they anticipate that someday we will start to disallow abbrevated
> options by default?  If so, an unconditional assignment of true
> would be more appropriate.
>
> I think I can agree with either of the two positions (i.e. we let
> those who explicitly want to decline do so, or we unconditionally
> make sure we catch issues in our tests), and I do not think of a
> third position that are different from these two and that would make
> sense.  Between the two, I'd probably vote for the latter if I was
> pressed, but even then that is not a very strong preference.
>
> Thanks.  I very much like the premise of this series, and the above
> hunk stood out in the range-diff in 0/8.

Thank you!
Dscho

--8323328-756376850-1555333686=:44--
