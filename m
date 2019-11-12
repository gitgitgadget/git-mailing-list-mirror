Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MALFORMED_FREEMAIL,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2F9A11F4B5
	for <e@80x24.org>; Tue, 12 Nov 2019 19:11:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727148AbfKLTLa (ORCPT <rfc822;e@80x24.org>);
        Tue, 12 Nov 2019 14:11:30 -0500
Received: from mout.gmx.net ([212.227.15.15]:33711 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727100AbfKLTLa (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Nov 2019 14:11:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1573585880;
        bh=R4VnVI3rrNVb1gMtqRdvuvcl722Td9t+bwkMBjnf5+w=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=QivLv4NTLINN2GW5xJ7TZGkU1fKcYjCqXzd2rortyVa00c1VbfnjJqUVMYOswqpV5
         7bZhT2qYtr9p/3n5ZbVAhXrIAGh+pNEGohPBN4s1COf0vR4jJ1W8wMrzENq8gn0SCy
         f6JeLqGjfsRLOHCGZ9WoZptmamIdOcSJXI/wk41Y=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.213] ([37.201.195.120]) by mail.gmx.com (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1N5G9n-1hnfy92UlR-011Al7; Tue, 12
 Nov 2019 20:11:20 +0100
Date:   Tue, 12 Nov 2019 20:11:06 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Emily Shaffer <emilyshaffer@google.com>
cc:     git@vger.kernel.org, peff@peff.net
Subject: Re: Should we auto-close PRs on git/git?
In-Reply-To: <20191109020037.GB60198@google.com>
Message-ID: <nycvar.QRO.7.76.6.1911121946480.46@tvgsbejvaqbjf.bet>
References: <20191109020037.GB60198@google.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:SRQOhdzUdIZ15HjRdE4G7VFh6qhr+tA1PzT49GRDVJFhZvD1Nud
 c+S+vuyXRII/8q8MOohLrs4pbnWTHHX1Pa13l37VeGBbdpKWl+N+vPZQ2sIMFWWce2KChM0
 ayMKBclhJrksEQukg1IBRXVL2qqnmnloPK4PJMzu1Rbwgg9FtOaltpknndUTJ0KUtcbYMZT
 xn0oGqYw+L/Dh7JZq2HuQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:u86/Fe4aJss=:tDkJhT5Fd2zE7NEDoc6DAY
 LHPPoE3DsS0q94Qtuow6jdKtv/OwrtGyq7oEGj1FK8ktxZK7Yu9gzyc1IeG3d99coG42XJ+/1
 NWoDkyry7UtHvVHxFc9wohomLL8Rn/fTu7uqdK/nS6odDHChhgFawtoIYaCaoQcYptfGJxWVC
 j2h3bEVQlFR+Z/NDM4qI2pS2jzMzvrzsVeyOqO5gFuokJLUZkDQjy+N4zsIJ42TzqyVRZR3AT
 wZRldgw8JMfO8LSdv+RMZxcGBR9IITBHpgUVOu9uRHVIqz7x3XqG/nOsMrH2eX9HJ6VgwFMBu
 +4sNjVPCKuto53Yz86mni2vbbF6Etmy0EgFWWGAfsGGLKOrTsKvpve7v7TWfBgOK2tsqPJFDZ
 EKcEu5CGwbrlxFMvyxvvvCiGWmT9Q4uwOILhOI1Ojdm/IrW/NWNtY+m2qNVdOLPEQ9Ybj0H1r
 u66zN17sMu5ksBjYYnUz1GmHGdleNRPEB3Ri3j+TGG8/khkkR40IMaZixvZsjz5lNCADGh+dX
 tQiQqV63JFJ/Kvruvb0MFyTXgz/EczDDAbqj49R/68cTyS5+DLUcqyaB0ptRKcqdcBZJ/YDm4
 +bmFCJZykY+yMVj2nkxS/2WTZDZP/MCUDmy12PWzuz4Rt+wM8uq2hCc5ndUXHPI52VXO/TFfb
 BtIG7thd9p1YWokMJfpB9lfieBy7wNj2Z2yRJxwShvKmlh6WJRrV5cBW30Mgrm2YT0mT+MXhr
 Qm88gwG3kiVFa98FK+9q7omMBzZbtaEJaXJTMThqDPiMmX/zlEQ8TP6ZLf0Fv3B5FNPAippt/
 QJePKxFzrw9ZcHLskFJ6ku3GB1j5uIUB7MLMEckowtpEcJ61Yz8vvDkwRuSC1KYp/2uchteVB
 RQUrJmwhjWIUzeRPRPbxRJIv0V147jM3CKJkRJMcJwEnYwFjp3M9kV/WTxB2BTduXWiw8+IuX
 A3CU4dO3glZwxxtIr0I94IpE7Zz7H/M4RxLoTB9vjLatFWa/gD2HSydFmb24QPa8Al1G/bo4q
 Qiiy70GZ6PsNPN7tjvX8+8MFS0z49t/elA0yj+WYsyhp3IMLRKTlALwdCN9iftQhrSH5qFg++
 0p682iN4+OFDYs2OmQD87rB2OCjayoVCevmoOrZJO6APRfY+o7DvP6Q06EwoN+FzYim/svOqT
 OFXJ6S2bmwkKYwoPSPYr7ruUleRcGPrmKP9DrfWTjW6aujd5ZQbnnU8H5jDJceI3jzF6zVS98
 O+ZRdwY5wYQ5cZB03nzKfAsfCEhdqzO2ESWVzjhqEmiOSBbf5KViCBudvaRI=
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Emily,

On Fri, 8 Nov 2019, Emily Shaffer wrote:

> It seems to me that the friendly template text we prefill when someone
> opens a pull request in github.com/git/git isn't being fully appreciated
> by many interested contributors.

That is probably due to our confusing use of the template as a stop sign
;-)

> For some time now, Johannes has been slogging through the list to try
> to narrow it down to folks who are still interested in contributing,
> and yesterday on #git-devel said he was pretty happy with the progress
> so far.

I don't mind it, and quite honestly, it does not take a lot of time,
most of the time.

> But to me, this seems like a sort of Sisyphean task - more folks will
> want to make contributions and not read the template text, and we will
> have more PRs being ignored forever, especially if Johannes decides he
> doesn't want to shepherd those changes anymore (I would have decided
> that long ago, in his shoes).

The PRs are not bad. What is bad is all those comments on commits coming
in as of recent, some developers thinking that they do not need to
research the best way to reach the Git contributor community and instead
just assuming that adding comments via GitHub's UI is a valid way.

I should probably refrain from trying to help those developers because
it makes me very cranky, but I just don't want Git to be an unfriendly
project.

> To that end, I wonder if we should add an Action to automatically
> close PRs on that repo. It looks like
> https://github.com/dessant/repo-lockdown would do the trick. We could
> close incoming PRs automatically with a kind, maybe more succinct or
> prescriptive version of the prefill text encouraging folks to open the
> exact same PR against gitgitgadget/git instead.

I am rather certain that that would not be a good thing to do.

There are some people who open git/git PRs solely for the PR builds,
others to facilitate code review, and yet others just because it is the
intuitively obvious way to contribute to Git.

Even some long-running PRs are worth keeping open, e.g. the Plan 9
support (which will just take time), the GET_OID_GENTLY one or the one
clarifying the documentation of `git submodule update` (which both need
to wait for a time when the respective contributor is less busy), and
the likes.

> Here's the prefilled template now:
>
>   Thanks for taking the time to contribute to Git! Please be advised
>   that the Git community does not use github.com for their
>   contributions. Instead, we use a mailing list (git@vger.kernel.org)
>   for code submissions, code reviews, and bug reports. Nevertheless, you
>   can use GitGitGadget (https://gitgitgadget.github.io/) to conveniently
>   send your Pull Requests commits to our mailing list.
>
>   Please read the "guidelines for contributing" linked above!
>
> Maybe we can close PRs with something like this:
>
>   Thank you for taking the time to submit a patch!
>
>   However, Git does not accept submissions via GitHub pull requests.
>
>   You can open an identical pull request to this one against
>   https://github.com/gitgitgadget/git and follow the instructions there
>   to submit it to the Git mailing list, where reviews are performed.
>
>   If you don't want to subscribe to the mailing list, you can keep an
>   eye on your patch at https://public-inbox.org/git, or by watching
>   comments on your GitGitGadget pull request.
>
>   More info on GitGitGadget: https://gitgitgadget.github.io
>
> I was aiming for "same message, but firmer", and "write down something
> so we have a place to start". I look forward to the discussion.
>
>  - Emily
>
> PS: Today we have 17 PRs open against git/git, and I think all of them
> have been nudged by dscho in comments to open against GGG instead. Many
> are in a state where dscho is sending a ping every few weeks to see if
> the committer is interested in following through.
>
> https://github.com/git/git/pulls

They all have been nudged, sometimes to clean up the patch first, or to
suggest that maybe the goal of the PR might not be all that desirable.

Some of the PRs probably can be closed, but as I said, I would like to
think of Git as a friendly project, a helpful one, so I want to err in
favor of talking to the contributors rather than shutting the door in
their face, so to say.

Ciao,
Dscho
