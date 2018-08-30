Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 650A21F404
	for <e@80x24.org>; Thu, 30 Aug 2018 11:03:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728269AbeH3PFV (ORCPT <rfc822;e@80x24.org>);
        Thu, 30 Aug 2018 11:05:21 -0400
Received: from mout.gmx.net ([212.227.15.15]:34917 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727451AbeH3PFV (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Aug 2018 11:05:21 -0400
Received: from [192.168.0.129] ([37.201.193.173]) by mail.gmx.com (mrgmx001
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0Llm5o-1fLzzC0Q8e-00ZRvF; Thu, 30
 Aug 2018 13:03:42 +0200
Date:   Thu, 30 Aug 2018 13:03:41 +0200 (DST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH v2 1/1] builtin rebase: prepare for builtin rebase -i
In-Reply-To: <xmqq5zzs94qb.fsf@gitster-ct.c.googlers.com>
Message-ID: <nycvar.QRO.7.76.6.1808301259420.71@tvgsbejvaqbjf.bet>
References: <pull.23.git.gitgitgadget@gmail.com> <pull.23.v2.git.gitgitgadget@gmail.com> <5403014be738425e942a9bc1ca2029dd8d2137bb.1535553074.git.gitgitgadget@gmail.com> <xmqq5zzs94qb.fsf@gitster-ct.c.googlers.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:LTpwyucW240CCkN1yyveqXSspSdoyGviolA3NfutopaUlpGuNna
 fg4EEymtHS2cDXBvzcxePrknwrgCYgkScHyP1ZgtAzfzCgrJndaPvCQSIW/TS6X9f2fEMQs
 kPmhWet7Mmgzv8bY0twkk3MBhnUp9qj1yJfikGtSzyd7opZ17CjeSJqISjS4St7YnoKYH0Z
 YX6DZbGs5snuc+Bab2LfA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:l4K1NmfhwDg=:JmP+uy//ObmSQ9Pi/DAZea
 F8wOiixVUzY2+R8jdAWOMJax1dVeBs97cNPnpL4vrCHHqTDJSiHFXhQw/zLfNpI9ffE2vYqAY
 oaNpzXNnJuUbIigf9KTgv6ElzFV7OzcDxb6ADcgyYUdz6UyhSwnJl5NtLRyemPatl/6LyUPiN
 dI4frw9vaLGodJQoMYffjWZRGGFzrCzUdNZl4dwAOs/Urt15cLVi8fg4x32hiuGfJ6rmCHA9A
 CRiC76ok9HenPcYKbPlfuuMznqthNnURWq8bSB2pQLihvjRH1WoIs/BstPQMCREM/jwMoHv7w
 by3eaTlgD4rQqbLAb1NQ7/3vSqgPMcUTbESOWYrZ9ucqpQEaIRmu+VkJNwggY1vseyfJUTfwW
 EebqTBEQtUG9eworkmRq8qvEwimLKg0+qNWvvVHbphFWJ/dvA6STfDCAjKDLdCPJOqOe/NJxX
 QyP5dxKsKIgMwqOfmcTniZM/OCXdJoMHKMcMwbam3Y9x57ZP4/x2QoGCgPljwqFTetvVrVH/v
 v1nhG/i2OhV9pZTFaXyOadZiuB5QwgOmhL1YgKJGL7NOi3la1MqWI8aqC8m7ygisOTwN46sk9
 mFk3bOYynTvlp8XLwfrBhVy0psuTFehtT6/AgXFKlDrTYxgQOTUMHy0nBgLFIK7CcbZcyFUeA
 97Gt0+Naun7n2ZkJQGo3Cup6FvOMBZT6WO++TGLoC+2tSj5DGpBj4FqguGGxmBNr8Y66RFSw1
 2j4LVBLtXJTJ3iZ6gMFV30uJOcp6w9LlbkBF+9tzbXxpuqUDdQFGNAW99JOe3exzXottM36Sx
 voDUIXT
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Wed, 29 Aug 2018, Junio C Hamano wrote:

> "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
> writes:
> 
> > From: Johannes Schindelin <johannes.schindelin@gmx.de>
> >
> > The builtin rebase and the builtin interactive rebase have been
> > developed independently, on purpose: Google Summer of Code rules
> > specifically state that students have to work on independent projects,
> > they cannot collaborate on the same project.
> 
> A much better description, especially without the less relevant "the
> reason probably is..." omitted from here.  The author's personal
> guess, while adding it does not help understanding what is already
> in the above paragraph an iota, is still a fine reading material in
> the cover letter 0/1, though.

I addressed Jonathan's concern, though.

> > One fallout is that the rebase-in-c and rebase-i-in-c patches cause no
> > merge conflicts but a royal number of tests in the test suite to fail.
> >
> > It is easy to explain why: rebase-in-c was developed under the
> > assumption that all rebase backends are implemented in Unix shell script
> > and can be sourced via `. git-rebase--<backend>`, which is no longer
> > true with rebase-i-in-c, where git-rebase--interactive is a hard-linked
> > builtin.
> >
> > This patch fixes that.
> >
> > Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> > ---
> >  builtin/rebase.c | 81 ++++++++++++++++++++++++++++++++++++++++++++++++
> >  1 file changed, 81 insertions(+)
> 
> 
> Will replace by doing:
> 
>     $ git checkout js/rebase-in-c-5.5-work-with-rebase-i-in-c
>     $ git checkout HEAD^
>     $ git am -s mbox
>     $ git range-diff @{-1}...
>     $ git checkout -B @{-1}
> 
>     $ git checkout pk/rebase-i-in-c-6-final
>     $ git rebase --onto js/rebase-in-c-5.5-work-with-rebase-i-in-c \
>           js/rebase-in-c-5.5-work-with-rebase-i-in-c@{1} HEAD^0
>     $ git range-diff @{-1}...
>     $ git checkout -B @{-1}
> 
> to update the two topics and then rebuilding the integration
> branches the usual way.  I also need to replace the "other" topic
> used in this topic, so the actual procedure would be a bit more
> involved than the above, though.

Is there any reason why you avoid using `git rebase -ir` here? This should
be so much easier via

	git checkout pk/rebase-i-in-c-6-final
	git rebase -ir js/rebase-in-c-5.5-work-with-rebase-i-in-c^

and then inserting this at the appropriate position, followed by the `git
range-diff @{-1}...`:

	git am -s mbox
	git update-ref js/rebase-in-c-5.5-work-with-rebase-i-in-c HEAD

Ciao,
Dscho

