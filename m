Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.5 required=3.0 tests=AWL,BAYES_00,BODY_8BITS,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7F3AF1F85A
	for <e@80x24.org>; Tue, 10 Jul 2018 09:47:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932756AbeGJJrk (ORCPT <rfc822;e@80x24.org>);
        Tue, 10 Jul 2018 05:47:40 -0400
Received: from mout.gmx.net ([212.227.15.18]:35341 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751194AbeGJJrk (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Jul 2018 05:47:40 -0400
Received: from [192.168.0.129] ([37.201.195.87]) by mail.gmx.com (mrgmx001
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0M7Gj8-1fyEEx1pfa-00x52p; Tue, 10
 Jul 2018 11:47:29 +0200
Date:   Tue, 10 Jul 2018 11:47:29 +0200 (DST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     =?UTF-8?B?0J7Qu9GPINCi0LXQu9C10LbQvdCw0Y8=?= 
        <olyatelezhnaya@gmail.com>
cc:     git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        Christian Couder <christian.couder@gmail.com>
Subject: Re: [PATCH 0/4] Use oid_object_info() instead of
 read_object_file()
In-Reply-To: <CAL21BmkBohTOVdCO_ENVfzL28aRjoh1MCCF6750AQEYsc7L54w@mail.gmail.com>
Message-ID: <nycvar.QRO.7.76.6.1807101133060.75@tvgsbejvaqbjf.bet>
References: <CAL21BmkBohTOVdCO_ENVfzL28aRjoh1MCCF6750AQEYsc7L54w@mail.gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-989113513-1531216051=:75"
X-Provags-ID: V03:K1:MBQp4R3a4DhEoL3uyfAn5EsgcmwQLJ9D2KIsy7OaG7ZqehMRkrC
 bxcVp2pqMR182PmKDJbXfJmO8folTFNtm2l49dnrH5ZEdQl8d/sLGIVUM9anbXcu7lPuU74
 HnWoqqYxS/l/9vklnmVwG+imS57mm6Df8YC8nP9V6fjyHGDKL3Vdtl6K2ex3Iw2pEVIb256
 VjtO4nxBkBnHd7YazhA6A==
X-UI-Out-Filterresults: notjunk:1;V01:K0:6xsd24exxHw=:So5Wbzz/po8hn8JIV3DXZO
 27Cvx4srZDpbxybQthQ1J0dpRk9m+hDiZOr4D/iYIRj2ByVFeLy8Gwbq5/zny3mLvmQr8keCR
 FG82bwXzUksCsBUAooAkZAumFCyp28GEdgkeGVni0Gm7SA//dOOnlkIcXI5RRLBcwzRRLS3Mw
 g8ZVdcJA8G1BHo4dTh9+PiQGrKjSd+Ovs5lKL1LZVoSrEDjyW1T1t45qOtfJYdMJMgf/yVWKk
 XpK6DnAwYiEOwlXHQX9nqykG75xIIzupK0CH6vkkajcGTSmFN+47s8k3+V8BpZWuvJHaDj43g
 JKpgUHM7q0/QPCeQfxnEx2y98BZQcmVdugazLeO2CbTAJFopMm4y9Is5XwwEg3uJdpTIuuT7r
 K2wHoOCAwvmnsAmqYy5ymTZxq/B9b7o/fvcc+EwgfxpMlu4z4DUxOdIkNwQHJYsHeweZReuaJ
 CyEAKdwqOolb7x3xhyIEvtGxqqgIZ+kk5H44C2uFKCHRg3+rbvRZLrYgpioIEKJfxb4q49lyS
 Vp/+ROolb+YIBuOJmdAyU/YU47Tcd84Gd3efjD/aAhA9lxdkB304I8jevTflJw+OML41XMYFp
 wC+2kuyWj7jXCEC6yM5nsORSVHsG4dSH99Cs8A5ziCBFXDZvf4+TzYTP2CfoIcjjKzuYvVG4i
 Sto50XgZrZdsb8QAVWWaTZhuPJsHUyWIYIuuHhZC7d8IY8lRaHNFrCwrlF2VlGSveR7i9PFts
 qyoksarExHtL7+28Ca5TlcVmaBlAbEgsGo85vG3Z8pJUrQSDKF+2NkqJsJhKnVfJZrIFwL69J
 knReG4l
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-989113513-1531216051=:75
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

Hi Olga,

On Mon, 9 Jul 2018, =D0=9E=D0=BB=D1=8F =D0=A2=D0=B5=D0=BB=D0=B5=D0=B6=D0=BD=
=D0=B0=D1=8F wrote:

> [2] https://public-inbox.org/git/010201637254c969-a346030e-0b75-41ad-8ef3=
-2ac7e04ba4fb-000000@eu-west-1.amazonses.com/

This type of Message-Id makes me think that you used SubmitGit to send
this patch series.

The main problem I see here is that the patches are not sent as replies to
this cover letter, and therefore they are seemingly disconnected on the
mailing list.

It was also my impression that SubmitGit started supporting sending cover
letters, in which case you would not have to jump through hoops to thread
the mails properly. But for that to work, the PR has to have a description
which is then used as cover letter. I do not see any description in
https://github.com/git/git/pull/520, though. Maybe provide one?

Ciao,
Johannes

P.S.: You might have noticed that I am working (slowly, but steadily) on a
contender for SubmitGit that I call GitGitGadget. Originally, I really
wanted to enhance SubmitGit instead because I am a big believer of *not*
reinventing the wheel (so much energy gets wasted that way).

However, in this case the limitations of the chosen language (I do not
want to learn Scala, I have absolutely zero need to know Scala in any of
my other endeavors, and my time to learn new things is limited, so I spend
it wisely) and the limitations of the design (the UI is completely
separate from GitHub, you have to allow Amazon to send mails in your name,
and SubmitGit's design makes it impossible to work bi-directionally, it is
only GitHub -> mailing list, while I also want the option to add replies
on the mailing list as comments to the GitHub PR in the future) made me
reconsider.

If you want to kick the tires, so to say, I welcome you to give
GitGitGadget a try. It would require only a couple of things from you:

- You would have to settle for a branch name, and then not open new PRs
  for every iteration you want to send, but force-push the branch instead.

- You would have to open a PR at https://github.com/gitgitgadget/git.

- You would have to provide the cover letter via the PR's description (and
  update that description before sending newer iterations).

- I would have to add you to the list of users allowed to send patches via
  GitGitGadget (GitGitGadget has some really light-weight access control
  to prevent spamming).

- You would then send a new iteration by simply adding a comment to your
  PR that contains this command: /submit

- To integrate well with previous patch series iterations (i.e. to connect
  the threads), I would have to come up with a little bit of tooling to
  add some metadata that I have to reconstruct manually from your
  previously-sent iterations.
--8323328-989113513-1531216051=:75--
