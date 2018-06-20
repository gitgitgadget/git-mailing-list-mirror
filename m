Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_WEB shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 797E91F403
	for <e@80x24.org>; Wed, 20 Jun 2018 11:05:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753475AbeFTLE6 (ORCPT <rfc822;e@80x24.org>);
        Wed, 20 Jun 2018 07:04:58 -0400
Received: from mout.gmx.net ([212.227.17.20]:57213 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750827AbeFTLE5 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 Jun 2018 07:04:57 -0400
Received: from [192.168.0.129] ([37.201.195.106]) by mail.gmx.com (mrgmx103
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MGzwE-1fQayg3AXa-00DqMp; Wed, 20
 Jun 2018 13:04:48 +0200
Date:   Wed, 20 Jun 2018 13:04:58 +0200 (DST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     Todd Zullinger <tmz@pobox.com>,
        Phillip Wood <phillip.wood@talktalk.net>, git@vger.kernel.org
Subject: Re: [PATCH] t3404: check root commit in 'rebase -i --root reword
 root commit'
In-Reply-To: <xmqqa7rqwxuz.fsf@gitster-ct.c.googlers.com>
Message-ID: <nycvar.QRO.7.76.6.1806201303560.11870@tvgsbejvaqbjf.bet>
References: <pull.3.git.gitgitgadget@gmail.com> <d59805a43ddaf4bbd4528a2b7afa9809eca9b86b.1529177176.git.gitgitgadget@gmail.com> <484fe825-0726-a027-1187-de00df6406d5@talktalk.net> <20180618164958.GO11827@zaya.teonanacatl.net> <nycvar.QRO.7.76.6.1806182343421.77@tvgsbejvaqbjf.bet>
 <20180618221942.GQ11827@zaya.teonanacatl.net> <xmqqa7rqwxuz.fsf@gitster-ct.c.googlers.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:vdJvNx9rf7eC+fwJ40OPCO9NopmyIw7qj1srzAHWEscziJD3wz0
 BUBLkOiozui2RXO/+pkHJEoczNcs0IzBl7y18hMHm3uWttVEHWJRIbJrfpqdb1lPJ6QAdDB
 W3JBNDcg5+Ky2y2FODJSzrFiwnXo9UNquqVkfTbqDFQ1TKJUcsKwzfbH2xVNH52sCbOEAi8
 cww+nwPhC106WJvbvOE3g==
X-UI-Out-Filterresults: notjunk:1;V01:K0:NxzefdAYmRE=:neMwyuBhBUmX0jmarKKnan
 opWZU/Zgyxfgvyoq7D8Xxqh3bwONylKzTzhSM13zr1nh6qmWLcjX3+JgVZALAqNLDQxd/ePsg
 RjBkJrpjYmH5rMmGgVlhVKMPBjJW5ZfbtkkKjzjLEmuZ3SjjQJ9cpQn5a/LvjG1y520QVsULY
 w6+Ru1d64qjHuBn0Rwyh8olgkqXw1KibSA2aDdsAItE0A/sAuoIwdmwwAlh59ekSB4QdOmZMM
 dcKSbMniMt8ovDSL3TODKlNm/hB18KeFf/Wa7y8IyeVlhYAvT36c1dJ76Z0mjrWnvSPLJp6jB
 5gzmi1BxiROKXRSI45WY4cemcAT2K8js8IwNi31D14QXKnCyFZivQn2X0KcuWO8tn24YRSx2y
 2s0hE4HE2nBF3ukhuFydnknDsc4/RT5/btE1tXfVocuMWOGpW/re6t75mWEYMdtXBytrERLF6
 9UL3LKRZ1hjjeqLt9QOpL7RO/wPvYrzjhm1pOJ7qqk/s1VkNe2iqD30WN4HoqTOTYj6/VQQRf
 2tB2rN53Fl0sMoRPLoDtAaW3bvee6h7Bx6BJ0K30aetf0OuCAvEki4iMFHBg07MoR2mt6L4Sj
 O476skSlJjxVJTOqUjt3p9Q/DLmr3JFEhC5T/ibrTHcCeQ+zWwFZvGrPuzZC7Omlj3wC4A1t2
 gQML/cjlqpBmN7YN0B/8pQnOsrAJobDS8tHVNhRPidxJk8K6gqoICpT7e6f8lNER6gKEW9IQU
 fLtP5xjm7MbPKOKN6P0Yc4gHsRdkdpyRqnOt8s6yooEjv/5CmFjJKBZGO3c23A0NScDy1Z3iY
 4/VQRiZ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Tue, 19 Jun 2018, Junio C Hamano wrote:

> Todd Zullinger <tmz@pobox.com> writes:
> 
> > index e500d7c320..352a52e59d 100755
> > --- a/t/t3404-rebase-interactive.sh
> > +++ b/t/t3404-rebase-interactive.sh
> > @@ -977,7 +977,8 @@ test_expect_success 'rebase -i --root reword root commit' '
> >  	set_fake_editor &&
> >  	FAKE_LINES="reword 1 2" FAKE_COMMIT_MESSAGE="A changed" \
> >  	git rebase -i --root &&
> > -	git show HEAD^ | grep "A changed"
> > +	git show HEAD^ | grep "A changed" &&
> > +	test -z "$(git show -s --format=%p HEAD^)"
> >  '
> 
> The additional test probably will pass when HEAD is a root commit by
> failing to refer to HEAD^, resulting an empty output from show.  The
> previous step would also give an error and won't emit anything that
> would match "A changed", so it probably is OK, though.

That matches my thinking. Otherwise, we would have had to do the

	git show -s --format=%p HEAD^ >out &&
	test_must_be_empty out

dance.

Ciao,
Dscho
