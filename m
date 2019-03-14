Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MALFORMED_FREEMAIL,RCVD_IN_DNSWL_HI shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8BA9020248
	for <e@80x24.org>; Thu, 14 Mar 2019 13:06:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727474AbfCNNG6 (ORCPT <rfc822;e@80x24.org>);
        Thu, 14 Mar 2019 09:06:58 -0400
Received: from mout.gmx.net ([212.227.17.20]:51881 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726752AbfCNNG6 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 Mar 2019 09:06:58 -0400
Received: from [192.168.0.129] ([37.201.195.16]) by mail.gmx.com (mrgmx102
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MMHaL-1h7zNS2YAv-0084Tt; Thu, 14
 Mar 2019 14:06:47 +0100
Date:   Thu, 14 Mar 2019 14:06:31 +0100 (STD)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Johannes Sixt <j6t@kdbg.org>
cc:     Jeff King <peff@peff.net>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>,
        Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/4] rebase -i: demonstrate obscure loose object cache
 bug
In-Reply-To: <0f7870b7-f92a-ad63-7854-300c202cb4a8@kdbg.org>
Message-ID: <nycvar.QRO.7.76.6.1903141403360.41@tvgsbejvaqbjf.bet>
References: <pull.161.git.gitgitgadget@gmail.com> <b3fcd377652103584b6f307c6ee209980b44529f.1552472189.git.gitgitgadget@gmail.com> <87k1h2bvpb.fsf@evledraar.gmail.com> <20190313163516.GA26045@sigill.intra.peff.net>
 <0f7870b7-f92a-ad63-7854-300c202cb4a8@kdbg.org>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1087189447-1552568807=:41"
X-Provags-ID: V03:K1:+tS6ixXYOof4c8T7as6IpvwAEbwNu3X8fdnoNQqRjCUoWFh8C2n
 /1MgAd/OMhibQdfs3usE3UlwbTsZlso9Hlb+E8rxHSCRxT9gS0TVd9X0Pp3PIxWm8f0Mq5m
 v8mVfSBZu5THxi94fVuplMh3Y1uQdJT1hfoV5iUDEH9X6pAHW/p7Cr9hkVlNZJUoAFnFQKt
 UDmdPW1IuCvtDHxo34w6A==
X-UI-Out-Filterresults: notjunk:1;V03:K0:5gwEVo7AR2o=:JnMXHBNmWlWIZ5NxBxq4BN
 0Wv7CSQ1ZaPV5Ru9kVHWOade9C0ixxWfGnVKT+lQQ6PJz5JU+joG69NPKz0nyun90F7Pi/FVW
 6qIDMJd5VuBXketiPNK1LlO1a4v3Uz9GIkkSpsI3dj8WIaIl+qUHI/1riYdqGu3MOIddXVs/Z
 GrrwMN6NTKw4KXqdA+WwpYr0Nh8LIzOQpQ1U11os+r6ikv/WBe7Z7Wq6P2uC5zv85SHbTwvRd
 rdiSKZtjkYq17F5+z5sELA25QcoMWuIgvOZqC5VhnHYk1S+H9ExBN3cunWAZ6SOrwmk3rX/zj
 p3+GiMhqSjFfQ4t7ls/9R6HVr5tqzko6ijjTV8ipfyMQurn6MFIZPq8hI/vE4hVlK8cOOBZjo
 99csNbzmw/xsQ2zdmBs8qu3MrejvSxZaoUD6XXMv72NadkvjRM0C5x/SOlg3UIzRPjd1+m+Ia
 NH89WEKI/Owomh/AqtHoxV4wNJEhnV7qJYV2uWUOL8LJt3gIW++t/m5zYQqO/uLmVHgRfsy8Z
 AFYj80IOxOFvDOXbgsK7oX+bh0GNCKYIyX0e4VxOX6VjzXRDEAi0x0ah+QN04Vm9xcqnLJff7
 CfXqJe4Du6Q7JwvXovgzI3A7nuljIOq5URFQvhMkmV1niujAe3xP/Nsezrp3hEDiAXbOK9grM
 anc6QfNXmPWhKT1n+hkP0VDFzYAMrMWjQ7qnbaHVrVDsDOOsxiS2y9Iq27YLXKw1m1+qFYu3j
 i0JRaw1+Rmpg81kwnHeiBBITrF5V6rks6VCnPyQEVGtLRhpzHs0cL1H4qtPDWsx7JV7mBfCVd
 T7va9YZTBFDHYKAo7QKvk3Ud1R46ui9tDcjwWstjgEpCxRknDpi2Q2vRytQZSKeb8epcL6fIW
 GFDvMeZFibvE7q1pKoBBFmJTrABBbM4F0mOhYScNPYBIvjEbKWDt2SWcr5Xnnzutc0ckjPSk1
 +0MKxR1IyTA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1087189447-1552568807=:41
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT

Hi Hannes,

On Thu, 14 Mar 2019, Johannes Sixt wrote:

> Am 13.03.19 um 17:35 schrieb Jeff King:
> > On Wed, Mar 13, 2019 at 05:11:44PM +0100, Ævar Arnfjörð Bjarmason wrote:
> >> As a further improvement, is there a good reason for why we wouldn't
> >> pass something down to the oid machinery to say "we're only interested
> >> in commits". I have a WIP series somewhere to generalize that more, but
> >> e.g.  here locally:
> > 
> > We have get_oid_commit() and get_oid_committish() already. Should rebase
> > just be using those? (I think we probably want "commit()", because we do
> > not expect a "pick" line to have a tag, for example.
> 
> 'pick' needs all the power of revision expressions. Not all too
> infrequently I do insert a pick line with a rev expression argument.
> Assuming that the resolved object is a commit is too strict.

No need to worry. `get_oid_committish()` can resolve all kinds of crazy
expressions. In a way, it is surprising that it will even resolve
"HEAD:Makefile". The only thing (that I know of) that
`get_oid_committish()` does that `get_oid()` does not is when you pass a
short hash which is unambiguous *only* when you exclude blobs and trees
from the disambiguation.

So I think `get_oid_committish()` will serve us really well, as we really
want to parse the given hash name into the `struct todo_item`'s `commit`
field.

Ciao,
Dscho
--8323328-1087189447-1552568807=:41--
