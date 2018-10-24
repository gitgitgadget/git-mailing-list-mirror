Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B65441F453
	for <e@80x24.org>; Wed, 24 Oct 2018 08:02:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727497AbeJXQ34 (ORCPT <rfc822;e@80x24.org>);
        Wed, 24 Oct 2018 12:29:56 -0400
Received: from mout.gmx.net ([212.227.17.21]:50559 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726964AbeJXQ34 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Oct 2018 12:29:56 -0400
Received: from [192.168.0.129] ([37.201.193.149]) by mail.gmx.com (mrgmx101
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0Lmvlg-1ff5Z43AIm-00h9Cs; Wed, 24
 Oct 2018 10:02:46 +0200
Received: from [192.168.0.129] ([37.201.193.149]) by mail.gmx.com (mrgmx101
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0Lmvlg-1ff5Z43AIm-00h9Cs; Wed, 24
 Oct 2018 10:02:46 +0200
Date:   Wed, 24 Oct 2018 10:02:50 +0200 (DST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Duy Nguyen <pclouds@gmail.com>,
        Jeff King <peff@peff.net>
Subject: Re: [PATCH v3 3/3] repack -ad: prune the list of shallow commits
In-Reply-To: <xmqqin1sov48.fsf@gitster-ct.c.googlers.com>
Message-ID: <nycvar.QRO.7.76.6.1810241001470.4546@tvgsbejvaqbjf.bet>
References: <pull.9.v2.git.gitgitgadget@gmail.com> <pull.9.v3.git.gitgitgadget@gmail.com> <1f9ff57d52a72e3795ac4a924e23a64b91b1f83e.1540245934.git.gitgitgadget@gmail.com> <xmqqin1sov48.fsf@gitster-ct.c.googlers.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:oGkzIk5iB1YMjftozHTi7ZRXj4gJ4WCdRwl15uiv11NeN3PuaWq
 UCbeqHjGSh+MdJBqhAY/iJBIiQQCz7DLRLPNeGT+vWiEj+vmsCUhru3xXzREQyou0EjECxc
 k6wnPK4ASKI/qdD+C/dtT3c4k82Ekc5Z6YYbJMnKZYyUG9pmyxsf98BpS0QArH708XjxQnp
 Fpr7M8Ky3HpD1eTyuZFEg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:5EbDvDHl1wI=:j+Kqvs6brPUJWHQWI+31FM
 bebfrLBJVTSJfu5ICKq/uHnHLvQr93qgYgOEeXvbEBLPELKJQ7g+f7KKs3iz86I8bRcZdidW6
 0FsPNqaKntmmy1Sw5oKvumFgrSzVrOylFt5160s7dgcVyIju/CPQkPf3wLnzN/xgVoA+DUg52
 Yp69nOV7NQklpybzAcgUP9JlHf8Ha5macM8jV0g2pkY+vm+C/11VtuK5YmtvytSWgS6/dbSUZ
 qrWqsLeTJN3r3kYmfDMbg81pmtW/+fwCS2NBDp/xchT9zHcVFn72uAcFldypikyih4RrE8h57
 Wx6HODj04YVA7i7Po6eSjuG++0sldt0tkhz/4MtVMwquDg7Rp8nLKveUMq49gTAJgBaC1CIWj
 yuZ1U7gqC40gxkubZYOhObERXqSfH/K3oPABxm8ZxEuImSWBnbYlU3W6MKsZwycgf1HOGwkCT
 n0t4QdGi7UtAZXIlkt0YrvwFOTEbw6PD5eSRiGxS3kTJW4bw7alyMk/l+/ndcikKjZYWQ+WTB
 djxNfBDptj5YREqsYOshpv/uEQOtWNhJC2XJvc3EYCttWxbbS+V3Q+1HTbRancRif7NdYb9Qj
 QgjPKdOGx05JpI2FwvtluP7a3u1qnn4ATg6CiJ7UWIwj/8Y8NBvxV/NAImM0xM6+QZv8W41R7
 8b1M41hiYwGYMMOSwiFxjGz19Em7a9QictF4zn4PJtO4sQuAj+1j/EnuYhP3skdGC6QC03pyE
 1bmeMBtm3eekQWsxfv1HtpxAd3CyPoPITuNc9dMhY8svSftaEEEZg+fmxwh5Qwv6RqhL53dGq
 Uf/D074nEVLdn3oouNOYdRGkC59R5IcKpFPlHnRy/f6NfweKJ8=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Wed, 24 Oct 2018, Junio C Hamano wrote:

> "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
> writes:
> 
> > diff --git a/builtin/repack.c b/builtin/repack.c
> > index c6a7943d5..9217fc832 100644
> > --- a/builtin/repack.c
> > +++ b/builtin/repack.c
> > @@ -549,6 +549,12 @@ int cmd_repack(int argc, const char **argv, const char *prefix)
> >  		if (!po_args.quiet && isatty(2))
> >  			opts |= PRUNE_PACKED_VERBOSE;
> >  		prune_packed_objects(opts);
> > +
> > +		if (!keep_unreachable &&
> > +		    (!(pack_everything & LOOSEN_UNREACHABLE) ||
> > +		     unpack_unreachable) &&
> > +		    is_repository_shallow(the_repository))
> > +			prune_shallow(0, 1);
> 
> The logic looks correct (and the reasoning behind it, which was
> explained in the log message, was sound).  prune_shallow(0, 1)
> however is not easily understandable.
> 
> There are only two callsites of this function after these three
> patches, and the areas of the code that have these calls are in
> relatively quiescent parts in the whole tree, so it shouldn't be too
> distracting to do an update to make the function take a flag word,
> so that we can make callsites more immediately obvious, i.e.
> 
> 	prune_shallow(PRUNE_SHALLOW_QUICK)
> 
> It of course can be left as a low-hanging fruit loose-end.

I almost did that, but then decided not to clutter the previous patch with
this change (and global constant).

Having said that, since you also had this idea, I will make that change.
It will read nicer, you are right.

Ciao,
Dscho

> 
> > diff --git a/t/t5537-fetch-shallow.sh b/t/t5537-fetch-shallow.sh
> > index 2d0031703..777c9d1dc 100755
> > --- a/t/t5537-fetch-shallow.sh
> > +++ b/t/t5537-fetch-shallow.sh
> > @@ -186,7 +186,7 @@ EOF
> >  	test_cmp expect actual
> >  '
> >  
> > -test_expect_failure '.git/shallow is edited by repack' '
> > +test_expect_success '.git/shallow is edited by repack' '
> >  	git init shallow-server &&
> >  	test_commit -C shallow-server A &&
> >  	test_commit -C shallow-server B &&
> 
