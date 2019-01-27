Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A5F761F453
	for <e@80x24.org>; Sun, 27 Jan 2019 18:40:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726895AbfA0Skk (ORCPT <rfc822;e@80x24.org>);
        Sun, 27 Jan 2019 13:40:40 -0500
Received: from mout.gmx.net ([212.227.17.22]:47019 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726630AbfA0Skk (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 27 Jan 2019 13:40:40 -0500
Received: from [192.168.0.171] ([37.201.193.149]) by mail.gmx.com (mrgmx103
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MLelb-1go6Cn393z-000pk1; Sun, 27
 Jan 2019 19:40:34 +0100
Date:   Sun, 27 Jan 2019 19:40:34 +0100 (STD)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: dscho@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH v4 17/21] tests: add t/helper/ to the PATH with
 --with-dashes
In-Reply-To: <xmqq1s5354gu.fsf@gitster-ct.c.googlers.com>
Message-ID: <nycvar.QRO.7.76.6.1901271938440.45@tvgsbejvaqbjf.bet>
References: <pull.31.v3.git.gitgitgadget@gmail.com> <pull.31.v4.git.gitgitgadget@gmail.com> <966c412f03013902826ffd188ee9af973be60833.1548254412.git.gitgitgadget@gmail.com> <xmqq1s5354gu.fsf@gitster-ct.c.googlers.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:pzV0WqN95/R4cvl/3kVUvOa8ih+4+7zGkJXtrof9anJTei24lc4
 iA1gvZNne5MCqQlhudSpV1cSUbgTYF3kW7EykmNwXRp9P+BgaGIzdnRbx8N8oKwAQ31mTk8
 Yqsr+u9xk7xF0IWOrHnNLWL+IW7Eyhr2N9CsqETcRNmTHi22vkIX3Ar0X5eSIy8ajIHTF2D
 SnBC/Ju354hPIKSx8wgcQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:h0aQNzu2fvw=:dwzWUbcEeVAzLzogLyn8oj
 222yZe++pub1+qMzMK+CXJjyePAyUu0GJiOXBphRLj0WVfV8IGGE1saleU2+JbWnwI6ptA1dR
 ZXxl0YrV/O+4lln4cJslCVnCRj0EFoqBneyUuXbN2tCBUC4xOX/QyX7ilp/9LkubZnCvsqgdm
 hp5J/Kn3BlLCOiKI3s2FYjwNvuAnk7iUKE22o4TQb22TDIlgn2x2TT3X7V4/+j/2i+sFbS4OL
 XB+u+/oAkyJbEHEro/P7ElRn5qS5wbk0L5NmdPOeVVYYWTjCT16o+9Q9TwcbRIaEzkPOXnk0J
 JKpuIFJhi+3mDWa48vqTr1ec6fDpjqjBnupY82NL2/bUFP31JrN9ZH/X7riRvqpR04HS7GeZb
 aacH47amXww17oXCI6HQKcdBypfs/kU2QNdFUHow59aZjbNNnccqsjlgzY2K6oD0PB/Vg7MH+
 p40lYz6UtIW19h5xJBLnhSKZhtwnzAV62NoBbkTTsfVtX1x9fIdFx0PbONaC/q0suanRMj8K5
 dni/Tt02jMGx37j1OgX13juYJkprFwywBcyDLstjo9NsWWEEdsAHxct5k1lxvYXH705YaME7z
 VwDAR32DaqxiiWRF0DhSvte10G+0RvMeAmWIL7dnNYrj5olAwgK13eQeR0am4jnFFJNzcoZxa
 cLcGLAYFJm+D++RqW8IzIu8SIGGYiUqMcYIKqO2FkIgykFlIamJ4DaB2T1+B4dE+pOhD0yrqt
 DU2sm669VX24FRM52yUq94vYvXOO62QsP0lpF7aAs7KD+O3td6ai4HPXLAi5mxpj0BqJbt7kl
 gpOcq+gH2EIACQMTCx2cEHhou0LiqM8z4gFKKRF6pIMX4IeYFi4DedMH+hf0eQdzm1ikGRxOP
 y/UAk+2jINL9k50pKhFRpTkD5LFR3TiDHN81HvX/ZIRl3K+Jx15Pr7UoMwuC0r+h4t9eG4SgQ
 zvfBGKkSnrg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Wed, 23 Jan 2019, Junio C Hamano wrote:

> "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
> writes:
> 
> > From: Johannes Schindelin <johannes.schindelin@gmx.de>
> >
> > We really need to be able to find the test helpers... Really. This
> > change was forgotten when we moved the test helpers into t/helper/
> >
> > Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> > ---
> >  t/test-lib.sh | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> It is unfortunate that --with-dashes is needed for valgrind and
> GIT_TEST_INSTALLED.  Otherwise I do not see why we care about
> keeping the option working.
> 
> Does any or your test matrix entry actually use --with-dashes and
> rely on it working, or is it just the stuff that implicitly depend
> on it?

This here test matrix does not rely on it. But I do hope to get the
BusyBox support (where we ship a subset of Git for Windows that is
intended to be used by 3rd-party applications only, called "MinGit", with
BusyBox instead of the MSYS2 Bash and all of those shell utilities
required by Git's scripts) closer to production. And to test *that*, I
*need* GIT_TEST_INSTALLED to work properly.

Ciao,
Dscho

> Thanks.
> 
> >
> > diff --git a/t/test-lib.sh b/t/test-lib.sh
> > index 9c0ca5effb..c790e98fd2 100644
> > --- a/t/test-lib.sh
> > +++ b/t/test-lib.sh
> > @@ -1227,7 +1227,7 @@ else # normal case, use ../bin-wrappers only unless $with_dashes:
> >  	GIT_EXEC_PATH=$GIT_BUILD_DIR
> >  	if test -n "$with_dashes"
> >  	then
> > -		PATH="$GIT_BUILD_DIR:$PATH"
> > +		PATH="$GIT_BUILD_DIR:$GIT_BUILD_DIR/t/helper:$PATH"
> >  	fi
> >  fi
> >  GIT_TEMPLATE_DIR="$GIT_BUILD_DIR"/templates/blt
> 
