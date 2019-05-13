Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-1.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MALFORMED_FREEMAIL,
	RCVD_IN_DNSWL_HI,RCVD_IN_SBL_CSS shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EE3121F461
	for <e@80x24.org>; Mon, 13 May 2019 14:06:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730430AbfEMOGb (ORCPT <rfc822;e@80x24.org>);
        Mon, 13 May 2019 10:06:31 -0400
Received: from mout.gmx.net ([212.227.15.15]:38709 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728217AbfEMOGb (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 May 2019 10:06:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1557756384;
        bh=3FK1iHNjyixv9Nm+m7MytTbWJUY2fuzCXDrCrcWkn9g=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=Ia4UQof6ceCa4YZbZ/V0m1pHAIerqCenUIEA0LvCLADDLtqr+/VkiVNutg+VDDyEs
         HP0LLVQoLz2PWB4XU6+8zma9sa8aB9XLclKlTlYORee7ZC7wRmPtGFntvvnNKo+ceF
         d0w3T46iGQPElB+WO95POCLTkt4ZKdozy5xAnxJU=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.129] ([37.201.192.51]) by mail.gmx.com (mrgmx003
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0MGBB1-1hVukx0Rqp-00FEQq; Mon, 13
 May 2019 16:06:24 +0200
Date:   Mon, 13 May 2019 16:06:08 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Duy Nguyen <pclouds@gmail.com>
cc:     Junio C Hamano <gitster@pobox.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: nd/merge-quit, was Re: What's cooking in git.git (May 2019, #01;
 Thu, 9)
In-Reply-To: <nycvar.QRO.7.76.6.1905131531000.44@tvgsbejvaqbjf.bet>
Message-ID: <nycvar.QRO.7.76.6.1905131605280.44@tvgsbejvaqbjf.bet>
References: <xmqqlfzgg8s3.fsf@gitster-ct.c.googlers.com> <nycvar.QRO.7.76.6.1905092251200.44@tvgsbejvaqbjf.bet> <CACsJy8DTErpeoNHUkCieDafnjc3iwg6QKAp2VP-8tUNYh33tJA@mail.gmail.com> <nycvar.QRO.7.76.6.1905131531000.44@tvgsbejvaqbjf.bet>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:CI5fjXG18gEKWM+ij7jgTdu/fE9s0RCphThSfXXjclkBcYFTzoh
 ZiXpUpdedGlrDbWh1r7JtJShMRoe0+qJX0Bi/1bApDLFq4Or9XKDhhXecdK3/6TsqDUahQs
 4PD0KYcJ9TYYFwVlhQY7v/Pg79SB6+ftioPEN/8n+sKcs5PbKCr6UsB6CyWkrCt+PBey9tP
 CLwjd6p/SenJxsfLjMgvA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:WqFubUx6Ebk=:Epl+pdYQyXW9wt5cTM4oTW
 +Q6iE2MfDiZkAeofkqX5lZgAOzVnG78FpFkfreoaRE+AwA/QM+C5ZjqD9kaI8hc02Ekjgnl8R
 lZc8HHhpksLd18Pu47xekpyAuGUZ2yi3o5PMLFBK+Bg/TT7V5lwIcja3vLC0bdpGtBc2DbYBt
 HT21wOd5SH9+7ZLScp/9dgBamwlBli1dK9ws5DHgPT5xhpCYJHAahvJIDXRgg4JZFMmdIgnnj
 NBYkyadwoktoYgpGmYVPpzoieg4Z4l1nz2K9D0htD165y7k7cecY0njPhZ+1LUsbIH2vToRAI
 dcPHMOoBnKrNk4/u7aEHQYGsd3VrW5SF6sPzW8aP99ka6nhI/0wGOg3U0eEDLVdMmG1Ob0SQ6
 x2NAVaLc6YsINAEl/MZKgFDK9FO7c9O59VpMy7i2vVQwMzmUqoX0lF9uupxL6j4RQbdqw0NWb
 L8+3NFS9N9RyKBcIlcTVasrjdEJF04/AMReWfBo3x1JhVbmAlZGNMR2/R87hy7Ges2jcnoOEu
 56xSA6nY24YU+OHRWuEQciiq2oCgNjKHymbZGWe9jXpq+svosvgEWKhdnW76g8OWeXzU9glJw
 2lqai5PY6R4eYAuW81wbapoxN0JjUlEt97Nb46SNhD3Eb9qzCuazDSB9/FwxCVLVGMQgfG4wH
 2nR+yT1Uvq4GQrWRyiNjAjJkSz+bAiIKV2026HXrxvauBcXafQYUS2yk3t+ly7Hcr8alO6K18
 24gSVQzBssBxIislAu2hATcMQ7AEPiS49ONxVQSmwo739Lbwq/iqMolb8iGuUQAbj2oqJ/KTB
 4vg6fjHrTgHw98Yu8NAwoKyywAkE5VaKMwZHJJoI/RrAr3DKu4isaTstsJ9GB3eSCchh9s59i
 aQ06PxiIW4LP5MHCaG4UC1eaRH4Dbm7qpcPe6EntU9nMqByEpjSiot3PZwAS2+68DQTFGGrIu
 ibKgyr60SDw==
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

On Mon, 13 May 2019, Johannes Schindelin wrote:

> On Fri, 10 May 2019, Duy Nguyen wrote:
>
> > On Fri, May 10, 2019 at 3:54 AM Johannes Schindelin
> > <Johannes.Schindelin@gmx.de> wrote:
> > >
> > > Hi Junio & Duy,
> > >
> > > On Thu, 9 May 2019, Junio C Hamano wrote:
> > >
> > > > * nd/merge-quit (2019-05-07) 2 commits
> > > >  - merge: add --quit
> > > >  - merge: remove drop_save() in favor of remove_merge_branch_state=
()
> > > >
> > > >  "git merge" learned "--quit" option that cleans up the in-progres=
s
> > > >  merge while leaving the working tree and the index still in a mes=
s.
> > > >
> > > >  Hmph, why is this a good idea?
> > >
> > > It also seems to work *only* on Linux. At least the tests break on m=
acOS
> > > and on Windows:
> > >
> > > https://dev.azure.com/gitgitgadget/git/_build/results?buildId=3D8313=
&view=3Dms.vss-test-web.build-test-results-tab
> >
> > Sorry I have no idea what the problem is. That's basically the same as
> > the 'merge detects mod-256 conflicts (recursive)' test earlier but
> > with rerere enabled. It does not even look like some leftover rerere
> > records accidentally fix the conflict.
> >
> > I tried with a case-insensitive filesytem (on linux) and with
> > --valgrind, no problem found. Travis on pu seemed ok with t7600 on
> > mac.
> >
> > One difference I notice is the the failed test looks like it found the
> > wrong merge base
> >
> > found 1 common ancestor:
> > c4c4222 commit 1
> >
> > while my tests have "commit 0" as the base. "git log --graph
> > --oneline" indicates "commit 1" is the wrong base.
> >
> > Something is wrong with the merge code (this has not even reached the
> > new --quit code). I could change the setup steps to be more stable,
> > using a simpler commit history, but this looks like something we
> > should find and fix.
>
> Yeah... someone should look at this... Someone. But who?
>
> :-)
>
> Well, since you seemed quite reluctant to figure out why your patches fa=
il
> the test suite, and since we're about to enter the -rc0 phase (where we
> all spend all of our time to hammer out the next version, right? Right?)=
,
> I figured out I better look into it before nobody does.
>
> Turns out that the culprit is not even hard to figure out. All I had to =
do
> is to compare, carefully, the logs from the Azure Pipelines and from a
> local run in a local Ubuntu.
>
> It has nothing to do with our merge code. There might be bugs, but this
> breakage is safely in this here patch series: the test case you introduc=
ed
> relies on side effects.
>
> Namely, when test cases 51 and 52 are skipped because of a missing GPG
> prerequisite [*1*], and those two are obviously required to run for the
> `git merge to fail in your test case, as you can very easily verify by
> downloading the artifact containing the `trash directory.t7600-merge`
> directory and re-running the last steps on Linux (where the `git -c
> rerere.enabled=3Dtrue merge master` *succeeds*).

I should have posted the link, as it may not be totally obvious where you
can download artifacts:

https://dev.azure.com/mseng/AzureDevOps/_build/results?buildId=3D9464474&v=
iew=3Dartifacts

Ciao,
Johannes

> In fact, you can very, very easily emulate the whole situation on your b=
ox
> by running:
>
> 	sh t7600-merge.sh -i -v -x --run=3D1-50,53-59
>
> And then you can fix your test case so that it does not need to rely on
> test cases that may, or may not, have run previously.
>
> Ciao,
> Johannes
>
> Footnote *1*: GNU Privacy Guard is not actually missing from Git for
> Windows' SDK, quite to the contrary. But it fails to start a gpg-agent d=
ue
> to the fact that we pass a `--homedir` that contains a colon, something
> that is totally expected on Windows, and at the same something that GNU
> Privacy Guard totally cannot handle.
>
>
