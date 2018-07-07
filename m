Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B48681F62D
	for <e@80x24.org>; Sat,  7 Jul 2018 11:39:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754107AbeGGLjB (ORCPT <rfc822;e@80x24.org>);
        Sat, 7 Jul 2018 07:39:01 -0400
Received: from mout.gmx.net ([212.227.17.22]:36273 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753612AbeGGLi7 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 7 Jul 2018 07:38:59 -0400
Received: from [192.168.0.129] ([37.201.195.74]) by mail.gmx.com (mrgmx102
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0LzpWx-1g7IoH1aYl-0153EI; Sat, 07
 Jul 2018 13:38:54 +0200
Date:   Sat, 7 Jul 2018 13:38:38 +0200 (DST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH v3 18/20] completion: support `git range-diff`
In-Reply-To: <xmqqpo00geys.fsf@gitster-ct.c.googlers.com>
Message-ID: <nycvar.QRO.7.76.6.1807071334480.75@tvgsbejvaqbjf.bet>
References: <cover.1525448066.git.johannes.schindelin@gmx.de> <pull.1.v3.git.gitgitgadget@gmail.com> <d05b54c603dc68acf198bb8826e3af4f2f11021f.1530617166.git.gitgitgadget@gmail.com> <xmqqpo00geys.fsf@gitster-ct.c.googlers.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:NKoS+qdpD8lxxogf0ApNVJ0HNzD50yC6OoZYOtzm/PWg+XSgQGb
 WyOnmRG5kdfNLhAd8j8rTqq+kuQELbuIvbPsjkwr73cW9Dk09m8KGrzYZqN+gorQpMXW1P2
 AtHBMWLiFrJ0P1wDCU+l30/doGPXvQSQfddNaZai7LAtpAvbX0wxEwrPlPlY/0LTlLGDeVu
 uswnG0lnjaLfvMl7ZShLw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:stDJvKVKYe4=:RN3IXHVCM3xuKukC6h+XBS
 AJqNtauSUmK4lh6kh/2uc8GLVcEJJYZGsygUrdIhunPaTIkTsBimdQe92kryhxmrAcZLzCTIU
 vuPQCUc6bL0B/dbNqznPmyFSKP5KyQ8pGp7X3a7mA3ZxJlEoolA2AhKmZ6Vt1l1BNvNPQDng3
 33O/OXsoIWbdst9DJnPy0+mdS4Tyu87wNw0szxGKoTv3F445ItbjxEaUva4CcIQPCUscSO5Xf
 19qE75SEHwpr3faigIyHrIntBQhWJdUu/7L+LxlXl+6jzK+XZ1bUO2ecDMZToMfWkHN8njs2W
 WqaDxZFgZtvGumB7JD4tPIV04CTAC6ttRD15fFHlX0M7ZS1cuvWESccQUkpjQo7OPj2a0RVoJ
 IgN9hCEI8KjDxSrkekfXWQVfP0rZpxYvA/FiFHe57bdxG88z1VSkaO9XFZ+SpEXJmJw0lIXme
 CdAb3yqkWqT3LBUrbz7z9TnRd+pZMnA1YqW2W6AYJvPfUf1fzZCfW4CIjCui3aXXmoAtfMVw5
 FQEOc73a7SLW/4ev3YM2fxgwxxfgJYZMPh1X7mRzsJWz/xBe0oBCbnxAjsQPJO2vYeJc4EIL+
 h1UG9h3NZE4GU+3oE6J6b/ik+d+dzhVt0tPZqzGoND7AfXoLKEQKDyt2MfST0awRwSuPAft2t
 qWaYWshdO2ugu6ddxLpFYY0UkuAmwonCYIsHN8etDMa+YCxdGNJQkQOjIUVjP6sRM8y/M89v5
 3dAFgKkmPpTf5kmgWzdwFMuBsBfVkK5s2jrOA8kNv9qF1U2LOTadXsw5qs2vyGfLlhCF4TW7q
 FjZRgBq
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Fri, 6 Jul 2018, Junio C Hamano wrote:

> "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
> writes:
> 
> > From: Johannes Schindelin <johannes.schindelin@gmx.de>
> >
> > Tab completion of `git range-diff` is very convenient, especially
> > given that the revision arguments to specify the commit ranges to
> > compare are typically more complex than, say, your grandfather's `git
> > log` arguments.
> >
> > Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> 
> Have three-dash lines here, or perhaps have some validation hook in
> the garden-shears tool to notice these leftoer bits we see below?

This is just a simple case of me overlooking the `squash!` while rebasing.
The shears were not involved, as it is not a branch thicket, it is a
simple, linear branch.

I guess I could install some sort of post-rewrite hook, but then, I'd
rather have this as a more generally useful feature, directly in `rebase
-i`: if running in autosquash mode, when offering to edit squashed commit
messages, `git rebase -i` should refuse by default to accept a commit
message that contains a line that starts with `squash! `.

Would make for a nice micro-project, methinks.

> > squash! WIP completion: support `git range-diff`
> >
> > Revert "WIP completion: support `git range-diff`"
> >
> > This reverts commit 2e7af652af9e53a19fd947f8ebe37a78043afa49.
> > ---

I will fix this in my branch, of course, and force-push, but will wait
with sending out a new revision of the patch series in case more reviews
roll in.

Ciao,
Dscho
