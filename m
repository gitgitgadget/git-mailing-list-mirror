Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MALFORMED_FREEMAIL,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2062220248
	for <e@80x24.org>; Fri, 12 Apr 2019 08:51:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727233AbfDLIvM (ORCPT <rfc822;e@80x24.org>);
        Fri, 12 Apr 2019 04:51:12 -0400
Received: from mout.gmx.net ([212.227.15.18]:38771 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726616AbfDLIvM (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 12 Apr 2019 04:51:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1555059068;
        bh=vxTQkiIAWkrIKAn2NoK1xFVbeFEn184BAAMpq0UE/9M=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=ID6Y8bgRKnFvfs8uIXCEuT9s+QZ3It3rJs1a7HTTDQ4z6p9IkuH5hMhExwyBUDHx4
         mzBD0H1UFOLyXVw4yji6B6U1NiMaVZqfF2crOlwdMeTZIod8Htbdb8fD9D5Y/ciyTC
         bBLcyX9eNok1rolzWxPSn0RIHVOHH/9gsiMYo/E0=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.129] ([37.201.192.14]) by mail.gmx.com (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MI5UD-1h3cHT07fj-00F7vk; Fri, 12
 Apr 2019 10:51:08 +0200
Date:   Fri, 12 Apr 2019 10:50:51 +0200 (DST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Denton Liu <liu.denton@gmail.com>
cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 8/8] tests: disallow the use of abbreviated options (by
 default)
In-Reply-To: <20190325183505.GA28920@dev-l>
Message-ID: <nycvar.QRO.7.76.6.1904121050140.41@tvgsbejvaqbjf.bet>
References: <pull.167.git.gitgitgadget@gmail.com> <04c36b1de9f22d7e0c64bb118eb424c1f64bd223.1553537656.git.gitgitgadget@gmail.com> <20190325183505.GA28920@dev-l>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:tcjK+OPiDGtvPCdUHrQ/72KG2JIdR9lpLTiGcdUdML0agjkOqW4
 gFBc7B+X4ypUtYv8dlzJ0VO6vE1ABgw/Q0HnEDoJxBnQUklVhyEc//QPNbplDJfMhgjV6D6
 kknDFhnlWt2G4dMeDptFbYoVQycgfa+IBogEg6Jjn1DuSp/CzDhA13gYiUYKgbh3IpNmYju
 3HeH5PLU7/4Y6MvjPruFA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:VlaQHii5E9I=:oaDJVTMVisBs/cwSXBcWxD
 l5aXud0ry0z67wbB7OfcunlndfcK3wIKnhtH8lHxHEbWtIxhGjo33givVmVVjFIJQG+kZna7R
 fnd+gPBaKrDF1iTgU04gjFq5pKk9n+AqaBE4Be1vK8Ze9b6dhYQlRDYbDjl/wAeCbfgbc2QK4
 WnC5SegBjTcsh2D8DDO5FIZGO1KNkJD2FoYWpQr812f5Gm8pRrWO2eKpl23ADKS+NBUyOsm6P
 71GoFhPp/sdC5FRbACIInIltE78U+C3lu9JC/M4GLApxylflDPOzHw9OHTgTNa/zHAeM+Y1OE
 nwUWJAZGGKdzwGFux/Izme0ycA85kYlc8FRY6VyYJll1Od3BxjZ09r+XjMIDGjKWjgyjC16Pm
 dwcbR8HJvEiw1bmcRN6dYZtBWc5lLVadRXsO46fUOPrFqO7vJWIiSCGk3rUtfV3AZmXquO6It
 MQiG+jG4SpePvFtjkVOAW2lJhCwdumKY+N47nRrICtofkph79YMDNMp9md+7r778v26Clp/t+
 o1ZuN39NwoHJiMypRXIgdE3QAZk14yXb298uxX2CCY1vM71OsxRppJLuzyRrDnGGDx8EuJaC/
 ccde38cvxpSi18wiVvm7issfdhgzhOcHFIXx59rXmJ4aaiUWLsVfUa0TKOs0OMP3dbPtBFA6S
 io1bKKKlyDpRDKpSIMKzD7eF4jMelCwkhWOBI6sB0xwPUKfeQe+BgGAoD+hSfY1VxNcK6QqQx
 +PvpiQnijcNUd3ADnA7X6blyci26GfrMXN/wuZvosOFeOyhx9BEp0AVxSPD7NfbC4iqE8Ks32
 pEEXd6xNU8eaFRC9Q8cmsrvkiz1mX7YGpFeBHCNqpS9fjkwHMKne6kARTikpR5kGwLQ3Mr+J0
 C3e7DYG1quQwGN15tNGhjtxZ7E3UWpeCh1ks8OQ0TwpWZQ1w2zp4jG3pGEUAJgxT01c8YZUY4
 frLA7uv11AQ==
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Denton,

On Mon, 25 Mar 2019, Denton Liu wrote:

> Thanks for catching this. Perhaps I should've been more diligent and ran
> the entire test suite before submitting but I was running low on
> batteries only ran the rebase-related tests.

No worries.

> On Mon, Mar 25, 2019 at 11:14:23AM -0700, Johannes Schindelin via GitGit=
Gadget wrote:
> > From: Johannes Schindelin <johannes.schindelin@gmx.de>
> >
> > Git's command-line parsers support uniquely abbreviated options, e.g.
> > `git init --ba` would automatically expand `--ba` to `--bare`.
> >
> > This is a very convenient feature in every day life for Git users, in
> > particular when tab completion is not available.
> >
> > However, it is not a good idea to rely on that in Git's test suite, as
> > something that is a unique abbreviation of a command line option today
> > might no longer be a unique abbreviation tomorrow.
> >
> > For example, if a future contribution added a new mode
> > `git init --babyproofing` and a previously-introduced test case used t=
he
> > fact that `git init --ba` expaneded to `git init --bare`, that future
>
> s/expaneded/expanded/

Thanks, fixed.

> > @@ -325,6 +329,7 @@ file: (not set)
> >  EOF
> >
> >  test_expect_success 'negation of OPT_NONEG flags is not ambiguous' '
> > +	GIT_TEST_DISALLOW_ABBREVIATED_OPTIONS=3Dfalse \
> >  	test-tool parse-options --no-ambig >output 2>output.err &&
> >  	test_must_be_empty output.err &&
> >  	test_cmp expect output
>
> Would it make sense to include a test case to ensure that
> GIT_TEST_DISALLOW_ABBREVIATED_OPTIONS is working properly?

Yep, absolutely.

Thank you,
Dscho
