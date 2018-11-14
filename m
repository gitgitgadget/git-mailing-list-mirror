Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8444A1F87F
	for <e@80x24.org>; Wed, 14 Nov 2018 13:16:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732891AbeKNXT4 (ORCPT <rfc822;e@80x24.org>);
        Wed, 14 Nov 2018 18:19:56 -0500
Received: from mout.gmx.net ([212.227.17.20]:56187 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727837AbeKNXTz (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Nov 2018 18:19:55 -0500
Received: from [192.168.0.129] ([37.201.193.149]) by mail.gmx.com (mrgmx102
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MDW9x-1gFUV63uQf-00Gs8y; Wed, 14
 Nov 2018 14:16:38 +0100
Date:   Wed, 14 Nov 2018 14:16:37 +0100 (STD)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH 2/5] tests: respect GIT_TEST_INSTALLED when initializing
 repositories
In-Reply-To: <xmqqin10p8aq.fsf@gitster-ct.c.googlers.com>
Message-ID: <nycvar.QRO.7.76.6.1811141413170.39@tvgsbejvaqbjf.bet>
References: <pull.73.git.gitgitgadget@gmail.com>        <948b3dc146fe353fbab6057c1376fa0e787a444f.1542030510.git.gitgitgadget@gmail.com> <xmqqin10p8aq.fsf@gitster-ct.c.googlers.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:szYjriYFvuSz7G/Y46s7DhM3cBz/7Nv4nPY8AHE+f49XaVMs5kw
 Z55nMsNDDLewpY0816Uq+pOnU15/oOwXjS3xAjcWh3+TPCkPsSEVteIHXX07yGCUfmU9dSQ
 ASHFOrFNjwPhjL9CqRm7yMbwBl3as7zoHa2WYFSnWbGM5iWfWJ+IvnRspFMM7kC9F9XnJ3k
 2mI2ODc+AeYl9jawp3Djg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:EzK1AppvT18=:Wougs9INf6qo2YxPVhbGDe
 zJVsjz1XNi3jp3w3yK3d3kknG5EtCVjB50W6u9s3tWMLFg1wSUGPXg2BEoG9bLSLbwEQapMST
 9XJ7vVxgQripzvs8wcMu1miquERn9a+LAuCSzA0dLkUGIGwpoAkGbRXHexnYRHW6oQh4oSJ9q
 ZBinjRE/zDdEyJdXwPkt6iyJnVjAQh2bErH1ADsk2EWG9FMbjlWgyp8QWQcRT2ag+a/KnMENJ
 iGdUenKa6wt3Pk5jLdYuUzTyyClx0KgyeP2m4gD/8WUmpsjoGE8C64WR5jTp2/bV1d0sxn3Px
 T/Hw4RJNPbi8sinwABy/Z7GlL5tUEMN3Q6fTApa46ptWD4ACRN3z05DpiRd1njUAoFLPIBbTm
 dRn8GK/exAVnhWmi7s3LMlV7Oeo3DQp6Q8fJyh8RrmTjtwS8oUtkdgEgwLXytZEtcgdnRMGNu
 VXrZH/rrjuuJPyrXK6W3LicQx0ds1uAK9vahqfV7Ad9kpVmkVsnghTA+zrsOfeECiaecjXNBk
 XmQmhUsOacK3p+c/AelIvw8uFqJus03/wlzCjFk5IciUzOto5yqKEcd3ZeAudWoCBjYacjeaB
 V9COxfx+fA9YCGLpxGJzW4Jrc6MLEbZWiUjUlzyxLB4DhsWnUWzQ1beKs77J0V6Abkm0Oyw9+
 R6yaJ+8lhrRH8qVz5tUCyjxPnts77OCagPLjKYC6r1pNwHMxp9sTYKsN9D6+eQONEfZOe54AX
 48tT6RfszaUGWFEH5ClHY0wb6VkBPsjDKhFP94M4rOge9iZaPlJ3giDMwLv4vJgDsuR+4AfJa
 WUSsdzWwFWbr6CPUhsSsI4pQwt7AB0MGaGiCng3m/gaZZ5igihpq5Xnl646LLnZyKNiKtmljE
 +I+O7xDpbtb/5n4J05jaipdvSc2/wcJeMmQkL6AcuhAE9Kqso19/nwUVJflJY7nBriLop+Gig
 QGXpdR61VJQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Wed, 14 Nov 2018, Junio C Hamano wrote:

> "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
> writes:
> 
> > From: Johannes Schindelin <johannes.schindelin@gmx.de>
> >
> > It really makes very, very little sense to use a different git
> > executable than the one the caller indicated via setting the environment
> > variable GIT_TEST_INSTALLED.
> 
> Makes perfect sense.  Shouldn't we be asking where the template
> directory of the installed version is and using it instead of the
> freshly built one, no?

It would make sense, but we don't know how to get that information, do we?

$ git grep DEFAULT_GIT_TEMPLATE_DIR
Makefile:       -DDEFAULT_GIT_TEMPLATE_DIR='"$(template_dir_SQ)"'
builtin/init-db.c:#ifndef DEFAULT_GIT_TEMPLATE_DIR
builtin/init-db.c:#define DEFAULT_GIT_TEMPLATE_DIR "/usr/share/git-core/templates"
builtin/init-db.c:              template_dir = to_free = system_path(DEFAULT_GIT_TEMPLATE_DIR);
contrib/vscode/init.sh: '-DDEFAULT_GIT_TEMPLATE_DIR="$(template_dir_SQ)"' \

In other words, the Makefile defines the DEFAULT_GIT_TEMPLATE_DIR, and the
only user in the code is init-db.c which uses it in copy_templates().

And changing the code *now* to let us query Git where it thinks its
templates should be won't work, as this patch is about using the installed
Git (at whatever pre-compiled version that might be).

Ciao,
Dscho

> >
> > Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> > ---
> >  t/test-lib-functions.sh | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> >
> > diff --git a/t/test-lib-functions.sh b/t/test-lib-functions.sh
> > index 78d8c3783b..801cc9b2ef 100644
> > --- a/t/test-lib-functions.sh
> > +++ b/t/test-lib-functions.sh
> > @@ -900,7 +900,8 @@ test_create_repo () {
> >  	mkdir -p "$repo"
> >  	(
> >  		cd "$repo" || error "Cannot setup test environment"
> > -		"$GIT_EXEC_PATH/git-init" "--template=$GIT_BUILD_DIR/templates/blt/" >&3 2>&4 ||
> > +		"${GIT_TEST_INSTALLED:-$GIT_EXEC_PATH}/git" init \
> > +			"--template=$GIT_BUILD_DIR/templates/blt/" >&3 2>&4 ||
> >  		error "cannot run git init -- have you built things yet?"
> >  		mv .git/hooks .git/hooks-disabled
> >  	) || exit
> 
