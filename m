Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 82E6B1F87F
	for <e@80x24.org>; Tue, 13 Nov 2018 12:47:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732816AbeKMWpk (ORCPT <rfc822;e@80x24.org>);
        Tue, 13 Nov 2018 17:45:40 -0500
Received: from mout.gmx.net ([212.227.15.15]:58231 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732743AbeKMWpk (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Nov 2018 17:45:40 -0500
Received: from [192.168.0.129] ([37.201.193.149]) by mail.gmx.com (mrgmx002
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0MVui8-1fyLFP1dWa-00X55v; Tue, 13
 Nov 2018 13:47:35 +0100
Date:   Tue, 13 Nov 2018 13:47:34 +0100 (STD)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH 1/5] rebase -r: demonstrate bug with conflicting merges
In-Reply-To: <xmqqtvkluqpb.fsf@gitster-ct.c.googlers.com>
Message-ID: <nycvar.QRO.7.76.6.1811131345080.39@tvgsbejvaqbjf.bet>
References: <pull.75.git.gitgitgadget@gmail.com> <efdd3736a96f90a4ab52acaf2e5efbe3435bcb89.1542065154.git.gitgitgadget@gmail.com> <xmqqh8glyajx.fsf@gitster-ct.c.googlers.com> <nycvar.QRO.7.76.6.1811131109360.39@tvgsbejvaqbjf.bet>
 <xmqqtvkluqpb.fsf@gitster-ct.c.googlers.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:LTfRwxL6EHCAa2Ktqtbh4fjtlFklAdGUBNPRX61OqT7C2bORb3q
 CLBAF69d/IpX/bNUiybtdQugLIWpkwUf/GI+4OpJgBggtzO/5wc0C6y11QpmadLOzb//jAr
 Yofw22+kAZTsHlZ8KMpGT/OKbtlxUuOUwaeGrx32KhyYjrg3dbI2SEvqpzI/blkNjcal1VA
 sHzHC6o7EiCrqn0o3Q77A==
X-UI-Out-Filterresults: notjunk:1;V01:K0:F7py+A6bmTc=:N12Xb9VMTizCes09EaKJSM
 4LX5VLXbjbbUXli+Qq1iHQf2z6bZljJhrxaYE9zkuxmJSP2yixruradYMD+5gV6T7vpz+SWZ4
 Q+/NX+4ULxUP+mbxy7LcPQqaAbX57fXM2hpqFKEuxukhOjs/ye2y0fEJ6Y9BpraoldA57ufFx
 wscZ68AOVpXzAkXddHke3o2dRotlC8f5aTMteH7oKUkvPzGEm+kB5vDy/07nTX2HzDuTPAGAu
 3SAI9RlQQ1P16aKjR7OyiVYm/MW/4zUbISbK7N5DCdhXeBsyx8SmarJ0nbij3Ncnw2ifuqnSq
 aMMDJKhv1wfoI9Wb6qYm2x6PKX0lC82LgammNHfu9aYOLM8iNvUXXo9qNL4TSEjTZLZTjIhAO
 ZKbDP1eXPj6m/C8lTS6h4sfYVHkn0zBC/4b853L/CcSE75FxFEIq7kB1WTz1Q8ZRugoRRQvLV
 6LE13V3UqfpYP8eIlfkjKWrHc8D3qJ4+fgGbQsutuc9UCottDNFzrlyLzuQ1oSUD6aKMz4SYg
 IAdHFGt/fl59IIOrhzc/dd5D0CShhe/tX4cxdokgwOUUbfKUgpehKynVn0giuib3J0LRSgXfW
 UQsuPXQCpftIc6gp2UG4XUfuM5aUInTel0mg/8PV5c9bHxtFqQQym1XRO/Ohv8/4uS0vWI24x
 1wTyPUmJPDy7rFvgkLSB1NJUxsOnZn+RQc7RePijsjx3ZJItOYsExaLc5cgFkRntlA0ljdpTM
 7VWuI+2xIfTtbM+pdyFa3Rm122AsEgGvLwPHyuD5f9/PbQJ+cyiiAZlPYlD1OzcAWRbuTziPB
 X9TWU5TqSqDyRoTI3n3RWNKnUMFi9GdknPR0E/WBw1U/Q93L+QovPBx2VemLNNous77l2Luy3
 CylZifhjnMOt4At0zuENEeo+pDw2RpkTyZupPKgi/6NhQbHhMY6lkG1QPzRenm8bGCUV82dkH
 cqHTZhOYG+g==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Tue, 13 Nov 2018, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> >> For a trivially small change/fix like this, it is OK and even
> >> preferrable to make 1+2 a single step, as applying t/ part only to
> >> try to see the breakage (or "am"ing everything and then "diff |
> >> apply -R" the part outside t/ for the same purpose) is easy enough.
> >
> > I disagree. It helps both development and porting to different branches to
> > be able to cherry-pick the regression test individually. Please do not ask
> > me to violate this hard-learned principle.
> 
> A trivially small change/fix like this, by definition (of "trivial"
> and "small" ness), it is trivial to develop and port to different
> branches a single patch, and test with just one half (either the
> test part or the code-change part) of the change reversed, to ensure
> that the codebase is broken without the code-change and to
> demonstrate that the code-change does fix the problem revealed by
> the test change.  And "porting" by cherry-picking a single patch is
> always easier than two patch series.
> 
> So you may disagree all you want in your project, but do not make
> reviewer's lives unnecessarily harder in this project.

You misunderstand. In this case it is crucial to read the regression test
first. The fix does not make much sense before one understands the
condition under which the order of the code statements matters.

By trying to force me to smoosh them together, you are trying to force me
to combine them in one patch where you would read the (now seemingly
non-sensical) fix first, and only then the test.

That's just really unhelpful. If I were a reviewer, I would want it
presented in the way it *was* presented. I firmly believe most reviewers
would.

Ciao,
Dscho
