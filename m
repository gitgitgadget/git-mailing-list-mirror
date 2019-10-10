Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MALFORMED_FREEMAIL,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 70F5E1F4BD
	for <e@80x24.org>; Thu, 10 Oct 2019 09:03:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387661AbfJJJDh (ORCPT <rfc822;e@80x24.org>);
        Thu, 10 Oct 2019 05:03:37 -0400
Received: from mout.gmx.net ([212.227.17.22]:53483 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387554AbfJJJDg (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Oct 2019 05:03:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1570698205;
        bh=zcrBZH09IUUglVOW0ri4xmFLWDAgByo5qz5Ze1YUIUU=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=a60kH7w713hMa4yWpI23RqgysUyhMXCLQcA6IktbnTPYm65ZWvPINIXTIyYytVhv5
         TmGQPiYNdLN0L8dl0XYISsb1opFNNYeBr+lfxT7BeJxFOnvG0YUDyYO+HcoZN0bh9l
         kIZVudmqmvWcOlAmIE13YLI2zE9EF15D3ISkgMLI=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.213] ([37.201.195.166]) by mail.gmx.com (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MxUnp-1huLem0SID-00xtl3; Thu, 10
 Oct 2019 11:03:25 +0200
Date:   Thu, 10 Oct 2019 11:03:08 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Philip Oakley <philipoakley@iee.email>
cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Denton Liu <liu.denton@gmail.com>
Subject: Re: [PATCH v3 00/13] ci: include a Visual Studio build & test in
 our Azure Pipeline
In-Reply-To: <9ccbdb9a-845f-a534-29b6-52cfe9eb3229@iee.email>
Message-ID: <nycvar.QRO.7.76.6.1910101102280.46@tvgsbejvaqbjf.bet>
References: <pull.288.v2.git.gitgitgadget@gmail.com> <pull.288.v3.git.gitgitgadget@gmail.com> <xmqqimp26808.fsf@gitster-ct.c.googlers.com> <nycvar.QRO.7.76.6.1910061157320.46@tvgsbejvaqbjf.bet> <nycvar.QRO.7.76.6.1910062237440.46@tvgsbejvaqbjf.bet>
 <xmqq1rvp5pc0.fsf@gitster-ct.c.googlers.com> <nycvar.QRO.7.76.6.1910072350300.46@tvgsbejvaqbjf.bet> <xmqqzhicnfmr.fsf@gitster-ct.c.googlers.com> <nycvar.QRO.7.76.6.1910081423250.46@tvgsbejvaqbjf.bet> <9ccbdb9a-845f-a534-29b6-52cfe9eb3229@iee.email>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:WnBomfM5TfwHvxBt381Xfd/0oFADldT8VV+WE0bMZcYCoaFNims
 EP3ppiR6iUYB8NsjxtLfMmgIT8oJ0PHjkGV2ZoGa5TlcQE1pCHy66RPaH5ikl1hr/fDxoNj
 2nVrDMRf24D6pgyszTB+NKCtEMilHkf77VqoNR+d7ruWR4wUPKgXmQDLfXH2554pFTHB68T
 Zd9eiSd5NMOcMrNAl+IDw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:1C06rlLvFj4=:cuvD5WNFX9nIhwlxW+ULAP
 mcQry5EwlEK7gHjTth+B8FMHZI5ceUv3J9X2Ab80SsEwt/PuzpZ1gXqw6wmqaRYqvf10QTLP5
 vbTriChTveEgEDtAuPpXJ0wpVSipFQI8AIIhtljH8nEECW891THYDe/QSvpukbONeoaYJagFY
 Kk9DM8y7Cc6LIPil5vgzHpB5vZvBvPPETbiCRdFu9fb3KmnWXLmYQjXDep4yyyuvsLLPB/c2T
 a99B5MK2oth4Ol9KryObTvX5gRXps9yc0McaxAhAGVw71tmd7uRE/qZoC2++UysLlz0NRRJ0f
 N7fh0pwsGoKZVs+Jb6DtXQhkm2DDjqCaM175SAFsFYdoEartbLkiIPuOYUJas01wf4/pdKpQg
 9ZiASCEM7NBX5DfnoWvVP6IWAUUDcbwBxitxtEQIgoSy567se/gBWe6JkhYm8tdBihVugznAp
 OPjFOtbeSu7wjPvrS3lp4lf8g1zfBM9/3pLdWN6pfsIEyhpgoOiWcV8kpbWszh1IK78c7+D1p
 1oF/4A/aglh/hLeBCK78XTFID5w7/77CcB/KvCvT8sVAGpg5yNupbuWsUu/KQ5nLsApcwZL4s
 v1zkm2KN/ThsmykQgqxkKsMRERE6ZGgsW/JYDfIEl57kbZMbkGkjFPOlZLYh3IyNXRu1vx9ZO
 c8Ulbs0GAwviwWpV7ZOVYZP1ooeQTynXJ5wQZ13y9yvNccIAreWbL2sOxT8TBKx17fGHj2fgO
 ujbLWk9+IyQjLKf6EQ0US3QvOKlMPp7RF+YtUAlJpkTnd9BagNm6rv3puRjLaSW8at6ASClYB
 mt45rb/SbwfatSALtqI5pQB2N7yEge/Oo9B1TIOnZHhZmhYY2i0WV2lVQ4xIrkYBFyHdF74bO
 t9rN9cDj5ww1UMU15jJtQXgvNdlTMunYOHwL5B8gi/Mo6lGqZH34ofRjataYtNmRNZfLPUkOK
 lfZKKBHudtbXEZSALuPtpgqoz3F7OcYaWFmF/+OZhrvaYspUpAMK/VbMjbycqs1vlfVi4vdTm
 CtGC03foSHKonDldybCCQ4p6fm3U6UHkkuyvuH/JYrEL1a8QVqnkBOOY0NqWlHzn8PreJyxGf
 DPBWVDynYZq9xqhIitr4J1h3u/vRSvl8gOtqn9+AdGM2KPnr8TRsXrm+44YUd+2/D+fUfjbaM
 BTgvyzXjtHA8SqVaiDdvwybBgewvhbOdOaE8CEOlCUyTrQMgoxyiggeFp9IKiifPvaSI0Acgx
 Ppb+6iGCw+vLiX9XOMnF4h+CQh8KSAT9zZBFZkapSgzYX0ubzM+5MaVnT4n8=
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Philip,

On Wed, 9 Oct 2019, Philip Oakley wrote:

> On 08/10/2019 13:46, Johannes Schindelin wrote:
> > Hi Junio,
> >
> > On Tue, 8 Oct 2019, Junio C Hamano wrote:
> >
> > > Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> > >
> > > > > I didn't quite understand this part, though.
> > > > >
> > > > >      The default creation factor is 60 (roughly speaking, it wan=
ts 60%
> > > > >      of
> > > > >      the lines to match between two patches, otherwise it consid=
ers
> > > > >      the
> > > > >      patches to be unrelated).
> > > > >
> > > > > Would the updated creation factor used which is 95 (roughly
> > > > > speaking) want 95% of the lines to match between two patches?
> > > > >
> > > > > That would make the matching logic even pickier and reject more
> > > > > paring, so I must be reading the statement wrong X-<.
> > > > No, I must have written the opposite of what I tried to say, is al=
l.
> > > So, cfactor of 60 means at most 60% is allowed to differ and the
> > > two patches are still considered to be related, while 95 means only
> > > 5% needs to be common?  That would make more sense to me.
> > Okay, I not only wrote the opposite of what I wanted to say, I also
> > misremembered.
> >
> > When `range-diff` tries to determine matching pairs of patches, it
> > builds an `(m+n)x(m+n)` cost matrix, where `m` is the number of patche=
s
> > in the first commit range and `n` is the number of patches in the seco=
nd
> > one.
> >
> > Why not `m x n`? Well, that's the obvious matrix, and that's what it
> > starts with, essentially assigning the number of lines of the diff
> > between the diffs as "cost".
> >
> > But then `git range-diff` extends the cost matrix to allow for _all_ o=
f
> > the `m` patches to be considered deleted, and _all_ of the `n` patches
> > to be added. As cost, it cannot use a "diff of diffs" because there is
> > no second diff. So it uses the number of lines of the one diff it has,
> > multiplied by the creation factor interpreted as a percentage.
> >
> > The naive creation factor would be 100%, which is (almost) as if we
> > assumed an empty diff for the missing diff. But that would make the
> > range-diff too eager to dismiss rewrites, as experience obviously show=
ed
> > (not my experience, but Thomas Rast's, who came up with `tbdiff` after
> > all): the diff of diffs includes a diff header, for example.
> >
> > The interpretation I offered (although I inverted what I wanted to say=
)
> > is similar in spirit to that metric (which is not actually a metric, I
> > believe, because I expect it to violate the triangle inequality) is
> > obviously inaccurate: the number of lines of the diff of diffs does no=
t
> > say anything about the number of matching lines, quite to the contrary=
,
> > it correlates somewhat to the number of non-matching lines.
> >
> > So a better interpretation would have been:
> >
> >  The default creation factor is 60 (roughly speaking, it wants at
> >  most 60% of the diffs' lines to differ, otherwise it considers
> >  them not to be a match.
> >
> > This is still inaccurate, but at least it gets the idea of the
> > range-diff across.
> >
> > Of course, I will never be able to amend the commit message in
> > GitGitGadget anyway, as I have merged that PR already.
> >
> > Ciao,
> > Dscho
> Medium term, is this something that could go in the algorithms section o=
f the
> range-diff man page, especially if the upstream commit message is alread=
y in
> place.
>
> #leftoverdocs ?

Sure. How about giving it a try while our memory is still fresh? You
would help me immensely if you could take that task off of my plate...

Thanks,
Dscho
