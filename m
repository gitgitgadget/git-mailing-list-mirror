Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MALFORMED_FREEMAIL,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 311F4C433EF
	for <git@archiver.kernel.org>; Tue, 14 Sep 2021 14:25:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 193566108B
	for <git@archiver.kernel.org>; Tue, 14 Sep 2021 14:25:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233723AbhINO0W (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 14 Sep 2021 10:26:22 -0400
Received: from mout.gmx.net ([212.227.15.15]:38345 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233713AbhINO0V (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Sep 2021 10:26:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1631629495;
        bh=nHAw+Hu1u/DxkyQlvCXTBaCn624BKDOix7cS0mEgsfo=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=hjyd9AjTJpydxj8/AUURQa94Yk2uYjLVF6iGaCO2stRrnTKBQ+/Zzwm0+pqztFzfz
         L8orEsYmgoRgJFVyBDSnNRmoTyFZq6l++PrftTaec+9BvT+2PchlXiqLBWgwahHhlw
         ya7ZGfjXb/n6E5++ncHdx6UVcHblyRx5EQKGQZdU=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.31.53.103] ([89.1.214.165]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MxUnz-1moXyI12SH-00xosT; Tue, 14
 Sep 2021 16:24:55 +0200
Date:   Tue, 14 Sep 2021 16:24:53 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>
cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Derrick Stolee <stolee@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Elijah Newren <newren@gmail.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>
Subject: Train station analogy, was Re: [PATCH v3 00/15] [RFC] Upstreaming
 the Scalar command
In-Reply-To: <87mtofnzv1.fsf@evledraar.gmail.com>
Message-ID: <nycvar.QRO.7.76.6.2109141432520.59@tvgsbejvaqbjf.bet>
References: <pull.1005.v2.git.1630691688.gitgitgadget@gmail.com> <pull.1005.v3.git.1631129086.gitgitgadget@gmail.com> <87r1dydp4m.fsf@evledraar.gmail.com> <87ilz44kdk.fsf@evledraar.gmail.com> <nycvar.QRO.7.76.6.2109131914080.55@tvgsbejvaqbjf.bet>
 <87mtofnzv1.fsf@evledraar.gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323328-1388769937-1631628150=:59"
Content-ID: <nycvar.QRO.7.76.6.2109141619290.59@tvgsbejvaqbjf.bet>
X-Provags-ID: V03:K1:pMTyaqvlwAnJoLacaHEEQU96g16wMnqDP8lji34We6pO+/wXpRy
 Jc0eu6Sj6IwCdqcirpTM3xYhvMDPLOYm/zJsol+w9xPaBui7+F26cQ97iMa1Xg4Q7OzHdTR
 +IV1t2zI/M5QenoNj10zto3UNSxIpJSdV0aq/6qmhYZpwxa4p4rpGoXRMsWSw7oQDmVKoHv
 hz1+vnia6Nc/cKtpWF44Q==
X-UI-Out-Filterresults: notjunk:1;V03:K0:WMDlXdnOXdo=:oc34l0rcyp6hns3IDDN6zb
 dWJqYKI6/3evKavkK/UviNi10Feje6pnadb7WkBusvp6yWts3nt75IwXtUXErJrhS/UiptHXA
 Swg1lUIAAEUTkbcvL1QOeotKQOARC7folywCYKW1c93zF4weZSaHJTCWi7sFlOfPeClmbE13M
 Hvvde+8HJdhaeN7laztSra5XbGlbCPY1b/j0jb5IRF0zPpDEhmLNv/jMY1lU0hUVwb4SqXM6h
 ejy5j89zwpcKEc6aiSKHYUSUlO+VufRiNGtvW/L8Pn5b+z+lw2oM0zLxR65KG+FocqfLbdTDC
 +7P7Qj6EuoZLBWrpD5YtZuckv0zGQuu8+MQ9E6r9u0FGh5JIkrwITRwPPtco0PBf6Tn9WeROV
 jYepmWxVvU082GO1Sg064kzN8sfFzL5BTXBwPTIXNuw1EcGyS5cgTG83/RA9G9u18wIbOljWF
 6ingl4EvDcMfEEvAcW7c0oAPkdQ6OxyI7ZwDCe69VBULgW7lakfvdANZISAw6hCtTPnCMD+RG
 unrmjci+STgWQ5RZaD/TzI7Vt+JeJV/Z/AvMW+yvnZ21VECi6Pv5h1rKAyMxktPtTJBWzno5x
 Ik2rJiimwSHWrXo7K/VcWvH8GFJU6xvLJYBeGb8oTOcng9l15uPJhRj9Ni3d5kPUMn/1rnMgo
 TZmrqEAw3kRFtKJ8HmgJAWv4B8/506+Mrjvhq8YonUbdrHsZQAgLeYZflIIiTq/Fu/7/hFft6
 5/f50kTmdDnUhSPv6DT6O2vKWAWgCghWRPfnjiDYDqVpsEqAgvVX9p6MK3WNvWaEktAEjFNQA
 QdLmVXsI8RXI7X81b/5DuYAoY5ABcxMlpLoCSyPBt9NVCvI0UVaWWbe2+T3sBX5wgm2CEI2aq
 nC6z25gMi8lVTP8z7hs8An9AI/bNbZm8iWZN/rzc0YVeBNpac+lAItDMkDdf/lFykUBb/O9cj
 Qf/UNJ54jJcdNylJGO0kLtD3zxbNiBVBU6fvIDYS8zSU5vWvSX9hH7w8v67LjHSt8EX2p+5nI
 FOm8s6QBi+HR5ZvVP+D6EGNmB1VsInobl9W7ktko+L9S3N6wCVzYlf00+I4ctLa8J8ZW7XgyT
 9qmMDumki6lnXo=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1388769937-1631628150=:59
Content-Type: text/plain; CHARSET=UTF-8
Content-Transfer-Encoding: quoted-printable
Content-ID: <nycvar.QRO.7.76.6.2109141619291.59@tvgsbejvaqbjf.bet>

Hi =C3=86var,

On Tue, 14 Sep 2021, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:

> On Mon, Sep 13 2021, Johannes Schindelin wrote:
>
> > On Mon, 13 Sep 2021, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
> >
> >> On Thu, Sep 09 2021, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
> >>
> >> > In the summary I had on v1->v2 points 1-3 are for v2->v3,
> >> > respectively, outstanding, addressed, outstanding:
> >> >
> >> >     https://lore.kernel.org/git/877dfupl7o.fsf@evledraar.gmail.com/
> >> >
> >> > In addition the discussion ending here:
> >> > https://lore.kernel.org/git/nycvar.QRO.7.76.6.2109082112270.55@tvgs=
bejvaqbjf.bet/
> >> >
> >> > For that point: I think it's fair enough not to properly handle the
> >> > cleanup case in "scalar clone", but perhaps add a note in the
> >> > commit message that unlike "git clone" this is known not to clean
> >> > after itself properly on ctrl+c?
> >>
> >> Seeing [1] about the planned re-roll I have the above a shot a few
> >> days ago, see the original discussion at [2] (indirectly linked
> >> above).
> >
> > There is a good reason why I did not engage in that tangent about
> > deviating from the established `contrib/*/Makefile` paradigm: I find
> > it particularly unrelated to what this here patch series is trying to
> > accomplish, and I cannot bring myself to be interested in the proposed
> > build system changes, either, because I do not see any benefit in the
> > changes, only downsides.
> >
> > I find the distraction unnecessary.
>
> Perhaps I'm reading too much between the lines here, so forgive any
> undue knee-jerk reaction.

Okay, let's try an analogy.

Imagine that a person is asking for directions to the train station. And
the other person is replying by asking "did you know that this train
station was built in 1878? It is actually quite interesting a story...
[and then goes on to describe the history and what excites them about
it]". Now, the first person tries again to ask for directions, again does
not get an answer to that question, and is slowly starting to look at
their watch. The second person, being completely oblivious to all of this,
goes on with their wonderful story about the train station and its
cultural heritage. So the first person walks a bit further to ask a third
person, but the second person is not done yet and says "but you haven't
heard me out! That's disrespectful!".

Just imagine for a minute how you would feel if you were the first person.

And that is how I feel asking for reviews about the Scalar patch series
and then being forcefully dragged into that tangent about the build
process.

I find the well-established paradigm to keep contrib/'s build procedures
as confined to their own directory as possible the most reasonable way to
handle the build by virtue of _not_ polluting the top-level Makefile
unnecessarily. All of your objections strike me simply as personal
viewpoints, not as technical arguments, and they fail to address this
"pollution of the top-level Makefile" problem. I therefore strongly
disagree with your suggestion that the build system should be changed, I
would even argue that your suggestion should been dismissed on purely
technical grounds, and I wish you hadn't forced me to say this as
forcefully.

And even if I looked more favorably on your suggestion to change the build
procedure, I find this distraction about the build as little constructive
as the explanations about the train station's history above. Those
suggestions do succeed in derailing the conversation about how Git could
scale better, how Scalar _does_ teach Git how to scale better, and about
how to teach Git itself more and more of Scalar's tricks.

If you have ideas how to teach, say, `git clone` to perform a couple of
Scalar's tricks, by all means, let's hear them, or even better, let's see
those patches. If you want to change the build system, still, I cannot
stop you from sending patches to that end to the Git mailing list, but
please expect me to be uninterested in them in any way, and to prefer to
spend my efforts to improve Git elsewhere. If you have other ideas how to
improve on Scalar in a user-perceptible way, however, I am all ears again.

I hope this clarifies it, without the need to read between the lines,
Johannes

--8323328-1388769937-1631628150=:59--
