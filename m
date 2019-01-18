Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DEF5D1F453
	for <e@80x24.org>; Fri, 18 Jan 2019 10:05:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726761AbfARKFi (ORCPT <rfc822;e@80x24.org>);
        Fri, 18 Jan 2019 05:05:38 -0500
Received: from mout.gmx.net ([212.227.15.19]:57161 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726062AbfARKFi (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Jan 2019 05:05:38 -0500
Received: from [10.49.182.9] ([95.208.59.217]) by mail.gmx.com (mrgmx002
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0LfSeH-1hYbwq0hw1-00p0pp; Fri, 18
 Jan 2019 11:05:33 +0100
Date:   Fri, 18 Jan 2019 11:05:17 +0100 (STD)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH v3 01/21] travis: fix skipping tagged releases
In-Reply-To: <xmqqsgxrm2c0.fsf@gitster-ct.c.googlers.com>
Message-ID: <nycvar.QRO.7.76.6.1901181104070.41@tvgsbejvaqbjf.bet>
References: <pull.31.v2.git.gitgitgadget@gmail.com>        <pull.31.v3.git.gitgitgadget@gmail.com>        <75ec97b3921f3ed346e9ab119ebff2546f03fade.1547645770.git.gitgitgadget@gmail.com> <xmqqsgxrm2c0.fsf@gitster-ct.c.googlers.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:YyICCcoxyn7Q+bsa5qum6hdnGz7tBKzan89DsrJbUnWvVMeXfu2
 jKrI4vaZPKx2jrJu96TcXyFKzGxl4YAwK7o92qGJdLIpWizmnKk0k5QlcnLVw+25Z2HKs0X
 0h8rurG3A82bGIgyL1gZkM8fEypDJiNQqHTdtzGcJ0qjSIWq3F/f1Dwy9v3guYx/MoNGEFx
 ov6zKyhHcYJFpBQRwUhwQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:52UaWocrNoo=:CnP2T3Y3tkQXl6orhYRJdK
 kHNwrxXgvQKbu2jxew47AW27DE+pQatxyoVbYHujYUvAqmtdsqhzHxAnP7QbhUVRVaZrbDf1h
 L0vQHZC4qCLhUx6AR/L+EkaBu6qubMMCwNm54468JTN3S11v3dYivG0aq7iaAxJ9Zg7jWdH7o
 YM6ldYqjY5NGPe+XY5F1aDt5SEBvkxWCTsoanRrs8w8LTXDGTKpo3DEiI8iEY+WBBgM0j2OEb
 EQIAZNNq6XuBpQrPdjMhFhINJM98HmXKlg57EgGaGAM/RWLjQKe/NyXc0quBAvZmqPJRchAgs
 jr167JfIFIktTorXKCiDka/IaO/SBCOCaOHzOLORhjl/GFXULOjHsX464yCor2nmktLXZlwSu
 S219I2DWsfrbbV7fQIYXu2qn10+TdB531ISoKRpREq5Fs9/vdthTOXZcm1EFAzXsopjpjtasR
 B638cBqKrIxWVd03LW7LIqh3W3oVyJqJ70IkcxrwqF9U5MpJgscypICSm7THEmGaIlioTL0kF
 +VEptB3V3yEyXq7J7k5f5ptfjtwwbcEL6lDCfBSYp4X6lp73xSaFJk1ApKgpg54RU9HD3EjPI
 6RYmaMi93vMJC0yXiU6R8x3EA8W+XoP+En5wfyy4jc+0wZUtfAXAVIgmBHka6G7ygEqKnx9PK
 DgV5XYu+hS1Fa6aJVt41axqrjWrl3ws4BEfaeqypgJkHYwqJUzraBrkeylyY7KgW+ByXXmWQ2
 5zGLrBXx48tkyIqRCywGExFM2TRmWdAReUh9v2IycEZWgS5bAHNj18kmYdXvfSYq9p00M3usb
 DkWMzOtSUZhZrDg2xGE5ru/qPOLAg7xtamME/uVc8K23fytu/ddJDsf8GnGrUErGm5TE74IKR
 4/6s9rSelUf1IjsxnZ+axjQsVSlnH039sBRdHPAAZx05f3Z7BRmny66AYvwR2EZ4H8sg8EQEq
 E9cnA8PKDPA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Thu, 17 Jan 2019, Junio C Hamano wrote:

> "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
> writes:
> 
> > Fix this by using TRAVIS_PULL_REQUEST_BRANCH (i.e. the *source branch*)
> > when available, falling back to TRAVIS_BRANCH (i.e. for CI builds, also
> > known as "push builds").
> >
> > Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> > ---
> >  ci/lib-travisci.sh | 4 ++++
> >  1 file changed, 4 insertions(+)
> >
> > diff --git a/ci/lib-travisci.sh b/ci/lib-travisci.sh
> > index 69dff4d1ec..d9d4f1a9d7 100755
> > --- a/ci/lib-travisci.sh
> > +++ b/ci/lib-travisci.sh
> > @@ -1,5 +1,9 @@
> >  # Library of functions shared by all CI scripts
> >  
> > +# When building a PR, TRAVIS_BRANCH refers to the *target* branch. Not what we
> > +# want here. We want the source branch instead.
> > +TRAVIS_BRANCH="${TRAVIS_PULL_REQUEST_BRANCH:-$TRAVIS_BRANCH}"
> 
> To those who are familiar with Travis [*1*], I suspect that
> TRAVIS_BRANCH has a specific meaning (e.g. with PR, it is target
> branch), and assigning a different value that is taken from another
> variable with different meanings to TravisCI would confuse them.
> 
> Perhaps introduce a new variable, like so...
> 
> 	BRANCH_TO_BUILD="${TRAVIS_PULL_REQUEST_BRANCH:-$TRAVIS_BRANCH}"
> 
> and then s/TRAVIS_BRANCH/BRANCH_TO_BUILD/g on the body of the
> skip_branch_tip_with_tag helper function.

I already introduce such a variable later in the same patch series:
`CI_BRANCH`. It is a good idea to introduce that already here, as it
declutters that later patch a bit, I would think.

Will change,
Dscho

> 
> Thanks.
> 
> 
> [Footnote]
> 
> *1* I obviously am not among them; otherwise we would have caught
> this while reviewing 09f5e974 ("travis-ci: skip a branch build if
> equal tag is present", 2017-09-10).
> 
> 
> 
> 
> >  skip_branch_tip_with_tag () {
> >  	# Sometimes, a branch is pushed at the same time the tag that points
> >  	# at the same commit as the tip of the branch is pushed, and building
> 
