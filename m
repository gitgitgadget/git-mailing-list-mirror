Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MALFORMED_FREEMAIL,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A912C43381
	for <git@archiver.kernel.org>; Thu,  7 Jan 2021 14:20:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1086522DBF
	for <git@archiver.kernel.org>; Thu,  7 Jan 2021 14:20:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729435AbhAGOUF (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 7 Jan 2021 09:20:05 -0500
Received: from mout.gmx.net ([212.227.15.15]:56161 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729427AbhAGOUD (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Jan 2021 09:20:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1610029108;
        bh=KGoaSIETL3B4fxWYuKy9AFqOoTCXMF6fkthd9Hq3bmU=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=CfnqlT9WTsp5ZM6h5yhgdptjNyFl5bXV8UGmKUZdEZKJGedKRw5ODijReB/aLa8MB
         p92vG5GiP3pCarjiP2+68nkGp2JU7uUoEKSxnXMTA5D60uIgQKITS7OPoImHHAXYnU
         5/KJPO4fL7BxZ09v0i2VVhiQd7HKWLvhqxxiXSaM=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.251.4] ([213.196.212.28]) by mail.gmx.com (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MvK0R-1k6eaD1NlB-00rKZa; Thu, 07
 Jan 2021 15:18:28 +0100
Date:   Thu, 7 Jan 2021 15:18:28 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     Nika Layzell via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Nika Layzell <nika@thelayzells.com>
Subject: Cc'ing the Git maintainer on GitGitGadget contributions, was Re:
 [PATCH 0/1] add--interactive: skip index refresh in reset patch mode
In-Reply-To: <xmqqpnhfwibn.fsf@gitster-ct.c.googlers.com>
Message-ID: <nycvar.QRO.7.76.6.2101071517260.2213@tvgsbejvaqbjf.bet>
References: <pull.475.git.1574539001.gitgitgadget@gmail.com> <xmqqwobpzubw.fsf@gitster-ct.c.googlers.com> <nycvar.QRO.7.76.6.1911251523530.31080@tvgsbejvaqbjf.bet> <nycvar.QRO.7.76.6.1911251543430.31080@tvgsbejvaqbjf.bet>
 <xmqqpnhfwibn.fsf@gitster-ct.c.googlers.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:tVhTocg39Kb8/ijlHFPRZ4epzoyiD6vweQsEeQkEej/ieuxoJPl
 Dd73ntkZSH5AKAMWI5nrYwUqT158gxOgwi7trhmtWGJOwgLLZU13t61bdMPq62cMcolTSNJ
 LaPo7uSKU1CUOtz5DaH3sATMfjIOjj6Lklqgdtu9WbT0Lk4a0E5xW0RBrmLpUnHJGuGUtfg
 zkrpwO0DZCDq+/J7i/wJw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:ENfcurKEAFs=:spwYXk3PtOJxrwdxkEDIq2
 mLYFTc/IqcqrdDNohgxkEc7/H/RtsHEGxgFq9zP2eOCecjrATIFc+r53yplZoOhZPIXsH7QgD
 VqWHzjEUFPYG1HyctXyLuoblJttPKJ0fZ9xPI5FnZ1e81eDc8jwNpuPeHJsktrqezsobwMCcF
 l3rnENhiYsnq7Am8pd9haJHSqT2Pw0IikHAkMapgvcn7Q7pnLrRIXFlKWRZm72AZmc6U6sX+k
 7W5900dN/WMVCShA7UK/pGJP1L8ySVUlUVF5NA0/LVn8pN6JpM8Ft6gaw2MF9omUJfZ7Dbkvz
 dyTjkUHVb9eibJcc2SjGKy++LSqGJSwBgQlEAP3QtcFvXQ2RfTZwb+VF3+USUQAnd716H8Y97
 aPrnNu64zWo065DLzbO4Iu8gBuD9CUDGwbg6Qt0PLE7mlAZagEzEFF3qWssEydNbSS7N1j3S+
 HmIlmKMYwQXdR1yi7MZ5wz0a2ocdZi/5pPxbGvn1DB94RoeQowgNSxb5dmUIT1d25f54kNRni
 TubeUDoGVSd6ExnEFT7lJsHaWeriRuGSrJsQdvHZxRsKekz3akRH8nohhLG97ehQOeSISi3Yr
 1YffePbFvwRzntIzFXq2tbFKWkOmeslAfqSufVvE0mt6aHy/xfo3DjRenhs7+6yzmqrYkdUxS
 sq1S2yOZ+qbAk42Ir2p1kG7bXhWjWVbylHYyt+eRV1kz+M2YjX/ti8UDUM0auzGne23A5lrR0
 DIkMOiq3kYxYTJHR4fLPxqVJUDeKo+JegBWeGCKNZqTofwi8dmtBwbODNmSAukqObk3mITF7Z
 I69YzMJHUfzyzr6j6obzFgoJQ/pKRol/XlT4A8IZ1xQEVoV/mjRXP+wLThyhtFKR6tC6pbjrz
 BJwaLbxV5oVHhFuGKTIPvYy8e0DJP3HJAOtZDiwzc=
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Tue, 26 Nov 2019, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
>
> >> > Hmph, I wonder why this was sent my way.  How does GGG determine
> >> > whom to send patches to?  I, like other reviewers, prefer not to se=
e
> >> > earlier rounds of patches sent directly to me unless they are about
> >> > areas that I am mostly responsible for (other patches I'll see them
> >> > and review them on the copies sent to the mailing list anyway).
> >
> > Oops, I forgot to address this. The reason why this is sent your way i=
s
> > that you are the Git maintainer, and as such, GitGitGadget sends _all_=
 Git
> > patches your way (except the Git GUI ones).
> >
> > The reason for this is that this is the suggested way, as per
> > https://git-scm.com/docs/SubmittingPatches#patch-flow:
> >
> >> 5. The list forms consensus that the last round of your patch is good=
. Send
> >>    it to the maintainer and cc the list.
>
> Yeah, but as far as I can tell, this is the _first_ round the list
> sees this topic, which by definition would not have any consensus
> ;-)

I thought about it for over a year and still have no clue how we could
teach GitGitGadget to Cc: you when it is appropriate, not without putting
the burden on any human being.

Ciao,
Dscho
