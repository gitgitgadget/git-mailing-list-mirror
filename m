Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D50C7C47094
	for <git@archiver.kernel.org>; Thu, 10 Jun 2021 08:18:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BDBF1613E7
	for <git@archiver.kernel.org>; Thu, 10 Jun 2021 08:18:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230026AbhFJIUY (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 10 Jun 2021 04:20:24 -0400
Received: from mout.gmx.net ([212.227.15.15]:37249 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229715AbhFJIUX (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Jun 2021 04:20:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1623313093;
        bh=e+YE8ZfM6xG6pcC+IRD5yE/RtCyYGQ5gNT6WJA6CBeg=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=VkdtHpz1wNXBnATXW+9NhIuVoAhKvJC06yvAel1QAZkchlOYXYcFWxsFjuKOQ74QD
         0arefvUcbjTwD6DFrlZf2mqE5sz6CiRg9dQoH67EU0qEUuE034JE5zCvGPVI+OEfq6
         taSXua91nFMeK7gI57sm+ZlvG1AGWE1fVWZn8w68=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.24.14.142] ([89.1.213.18]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MGz1V-1m4mQg2Irb-00E88R; Thu, 10
 Jun 2021 10:18:13 +0200
Date:   Thu, 10 Jun 2021 10:18:11 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Emily Shaffer <emilyshaffer@google.com>
cc:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, gitster@pobox.com,
        sandals@crustytoothpaste.net, stolee@gmail.com, jrnieder@gmail.com,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH 1/4] Documentation: use singular they when appropriate
In-Reply-To: <YL+p+MlgJ754YoqB@google.com>
Message-ID: <nycvar.QRO.7.76.6.2106100947170.57@tvgsbejvaqbjf.bet>
References: <pull.975.git.1623085069.gitgitgadget@gmail.com> <afc51c5e6edec7935a6d0d0a05d396e11311ca6c.1623085069.git.gitgitgadget@gmail.com> <YL+p+MlgJ754YoqB@google.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:XY8TbnM1/HdsvmCJb2M8Cg/vliiLbQ5L4rdueRqTN8FiNufVBTB
 veSV7oCtDSLmeDYiJb59EERaKqsUIe4ZMN0N04/O9xHgfKDSJyjnQNa0TEdNoucRCjPNodq
 n9TxQ3jScB/cv7N/kB7qc1DKG4lsLJfEdfv+jRD1sqVt0iO0E0jDodCNldgvkADFF8JcGmR
 lunn0zglSZbMvOHGqAteg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:jf7nPsc1vwU=:NTJ3nFu1do1g5LENytJUcc
 vZWSENuD6ilbqQgVLmopbDZp2P8VYePhjwROV8APyFihuzSIBz6eXrhmww4f/DnIgBLzM0JaO
 cDt85T4ASgNvkIC60bEvfJ5HiSlFHWOgNWYx3kdUsL2K0eUoR9iju3hfs9Me78+fL/Y9x2s6x
 2VLJ8uUmnAB5BJqhBBiC04Ab5LQjlCftFP3+9icOqOrC+LEInrc52QKrz6PwLq4AxnaKNfXRf
 gMjtaiy8u9DM1cQcyVmjfVcq2TwuJbo1V8hzMABalPXJLTFriVbCIXOVC7LmxApVDRqRwFqIk
 X7zXG8LazPNQsF2o4MZTdsMq/nS02w01JW1/wMi+/fNgfdFlnDt4HW3GKfWASaeoyOvNanja3
 aXEtkVr7IhBWQJWc/5F3ilqnQXnB8S1g3rvAMsKRFYqx44npBZ3tzFAAICN6WWLJ61/7x/ji0
 FmcDv0xJDLeEMUbuiLXVd2RN1a6Zy69hx2q6Mx0+EtHjH2rFquYiwyLbasOCJ+P5gU1Wf3Jqo
 WYj7Ep5r+7ei9JGnfH++pdpQLMwE5RHYq6TRoM91DzUxv3XbqWXVmlbpO6j8H+Znz/hqdvW9R
 gy7pasm594vtwkjp6aj65aGgdQuiERYP2UHU6QFLan894GoVNmiV1nBBs/nIAW9a/vUAOJI9d
 gvQQ74ovV53SaJjOwli1TrT4BYyTKEY0XjH6loqOlRXCfnMrYB6szY1MJEPtlp5m0z7gEsr3A
 9s6su6k3QPRgf2iWxL1tuOciSrIuJXXReH3t55TvvqE5ZtNUdRVQGpc7wH8uYXwjPa7LtBzYi
 g1+iKpGx+xCU7iefQIZssYknju/BYd1q+Ek0uYYY92W2rR5NRX26ih+cwysgJK6sbeaekxfGZ
 T1a9PE+FKoc5YCTeMkEgMmO+rYJ6R8OoFAIU//XyyUdd4Uu5lnlqXDlS67g6JeluKjL4snUNK
 PcsKD73WLi0pSPKJvuE+D/o0ik0tpxo8hFxU07/81QqrTqUkKgTq+ap+GEbg/LbPCR6Gnj3PI
 J6B9HZNx4zPCPmmp8VAQGnqd8ZzqWu9GWFoR0Z/MU3TiYzgbCfQKFbF8BX6hB3lFTfqiRLsn5
 m7mfuyAp/0Fe43OL8LapBwrqHoe3bpjYgoJnD/0lPuQ+VteTB/lo5gpBQ==
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Emily,

On Tue, 8 Jun 2021, Emily Shaffer wrote:

> There is value in intentionally defaulting to "she/her", especially in
> settings where women are underrepresented. It can be a nice way to shake
> the foundations of unconscious bias in the reader's head. See
> https://www.askamanager.org/2011/07/why-i-refer-to-everyone-as-she.html
> as an example.

I am glad you brought this up.

It is all too easy for male readers such as myself to not even notice how
effortless it is to read text that includes you, whether by the pronoun
"he" or by avoiding any gendered pronoun altogether.

All the more surprising that the same male readers (again, I will include
myself as it still happens to me, despite all the work I embarked on to
become more conscious of my own biases) will stumble over sentences where
a female pronoun "excludes" them.

And the first reaction, funnily enough, is rarely "Oh, _that_ is how I
make half of the population feel all the time!". Instead it is more like
"How dare they exclude me"?

Funny side note: this is precisely what happened recently in Germany,
where a law was proposed, and in contrast to common practices (which
dictates to use the "generic male form", i.e. "he/him", as the German
language does not have a singular "they"), it used the "generic female"
instead. I bet you can imagine the indignant backlash from male
politicians...

Let me be the first to admit that working on this kind of bias isn't easy,
and I imagine that other male readers' struggles will be similar (or even
more pronounced, if they are less interested in biases and fairness than I
am).

Seeing how threatening these efforts to adjust our language are sometimes
perceived, I often find it pretty difficult to tread carefully. For
example, I recently suggested that stumbling over a "singular they" might
give male readers an opportunity to develop empathy with the
underrepresented, to experience a glimpse of what it means to feel
excluded (even if they weren't excluded at all), and consequently to pay
more attention. This suggestion did not quite have the intended effect, I
must say: it seems that this invitation was misunderstood as an attack
instead.

In light of this experience, even if I generally agree with your point abo=
ut
using "she/he" by default, I believe that Stolee's direction is more
diplomatic.

> On Mon, Jun 07, 2021 at 04:57:45PM +0000, Derrick Stolee via GitGitGadge=
t wrote:
>
> > Replace these uses with "they/them" to ensure that these documentation
> > examples apply to all potential users without exception.
>
> However, in this case, I think "they/them" is appropriate as a default.
> As you say, this documentation is intended as a guide to potential users
> and contributors, and should apply to them. Thanks for writing the
> change.

For what it's worth, I agree. Thank you, Stolee!

Ciao,
Dscho
