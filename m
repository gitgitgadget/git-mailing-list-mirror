Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1B9691F85E
	for <e@80x24.org>; Thu, 12 Jul 2018 15:23:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732373AbeGLPds (ORCPT <rfc822;e@80x24.org>);
        Thu, 12 Jul 2018 11:33:48 -0400
Received: from mout.gmx.net ([212.227.17.22]:50553 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727366AbeGLPds (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Jul 2018 11:33:48 -0400
Received: from [192.168.0.129] ([37.201.195.126]) by mail.gmx.com (mrgmx102
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0M7UUd-1fxlQB3t0J-00xIl6; Thu, 12
 Jul 2018 17:23:41 +0200
Date:   Thu, 12 Jul 2018 17:23:24 +0200 (DST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Subject: Re: refs/notes/amlog problems, was Re: [PATCH v3 01/20] linear-assignment:
 a function to solve least-cost assignment problems
In-Reply-To: <xmqqefg94uq1.fsf@gitster-ct.c.googlers.com>
Message-ID: <nycvar.QRO.7.76.6.1807121720340.75@tvgsbejvaqbjf.bet>
References: <cover.1525448066.git.johannes.schindelin@gmx.de> <pull.1.v3.git.gitgitgadget@gmail.com> <39272eefcfe66de3ca1aa2ee43d6626ce558caae.1530617166.git.gitgitgadget@gmail.com> <xmqqtvpcgf40.fsf@gitster-ct.c.googlers.com> <nycvar.QRO.7.76.6.1807071320110.75@tvgsbejvaqbjf.bet>
 <xmqq7em7gg3j.fsf@gitster-ct.c.googlers.com> <nycvar.QRO.7.76.6.1807072116570.75@tvgsbejvaqbjf.bet> <nycvar.QRO.7.76.6.1807080017160.75@tvgsbejvaqbjf.bet> <nycvar.QRO.7.76.6.1807092342490.75@tvgsbejvaqbjf.bet> <xmqqefg94uq1.fsf@gitster-ct.c.googlers.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:/LIf0mallSgH8D+vFrahHMrcB7SW12ld8oOIOfFrCUswGcNTeQU
 ugY+PETOURhriVcgLGiabd/wndhGGF51kjOZAT/Zp8FxJK9mTAKSKusy+eXP+GU2D0hPvlD
 Vo/8gePejfACIaOhsnZNZbak66jcVB0/bzlgWCkhipZuOQr3makeHD+Ecz94yPNnV/hGfwD
 NumLj7YCpmS+mgIOBou0A==
X-UI-Out-Filterresults: notjunk:1;V01:K0:XrYEi2mpQ/Q=:Kxm8sVXhLDV/CJj5+q5nx4
 A9OF1RoqwjNXGgZhDa0jK6aaL6rLCVnHyHmAI6QjtZ8eHsAnl5Y803yX3Y4iKD3ylPCC7528S
 M+Rv5o0QKAGzIv1ZGMfemlamMdlAysNdu4aHPHlci4hEBD6vgeLP46aUnCL+zb4i1PKwoJmBh
 zU2KYmcDbzGYQY9bFS7liVC1lGUARmLiBh8ce0ypvqCgg2Ss7RepsqfDiBX7s7JCcSX6duBiU
 tsJLnRPlkT1ZXJerUWcAKmCI6VDDRXPZ87qEaKGOmtdhTMQL34FbND4vXufLMP2TezxZbBy7S
 v1iAuGLxkypPtgThfRzBNQmBlbveSZAesBRjatubrGTQ9r1nc2Nq5VZo0qwvihHwdWSc+H/fm
 slfSKq2WC/YQeqZVFTa2mI1GJg9YSiKAPuQAAKpid1T18CXQdinlqOw1AXlao3vC7J0fJTqxb
 DoOoG3pzJfVXPtsxJXRrGoltED5KIHK2EDcy3A40e+CJHbCN8Hh4nZVKdZyrDCZS77yaKYCuI
 xuVoQpEErT4cPtlJnRCic5+rbBqAyAAI1pgImLZjGwceBnW5wSzC8z5VDp7XbmKdHEm8m7eEh
 Z4gxv7MkEzHnAO48f+x+uSa+AG17JQP7vLUIq8M8CKQdKWhUScBmCDkIp+8BiQXxeW+t9RhUQ
 DlLZCMdT0rXJ8to0gCW8JLKhFRtL6Cmyy17YomdELcpoUjbGQhXbT6n6KvfB3iLcjmKztGrP1
 dYDO3KlkaT1B91vdA3f0WJ7Z2SrGSIGAJPM1N+HyBUxsk7+t0iPB1AyCHyHHnS6rShQsfxP5o
 haSTOc2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Wed, 11 Jul 2018, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> > To summarize, there are two commits recorded for that Message-Id, the
> > later one not mapped back, and neither is the correct commit that made it
> > into `master`.
> >
> > It would be nice to figure out what went wrong there, and how to fix it
> > for the future (and also to fix up the existing mis-mappings in `amlog`).
> 
> I think what happened is that I used to have post-rewrite, but
> because it did not solve the real issue of multiple commits existing
> for the same message ID (either because of amending, or because of
> running "am" multiple times while looking for the best base to
> contruct a topic branch for the series that contains it) *and* the
> one that will eventually used in the final history may not be the
> last one (e.g. I may "am" twice to see if an older base I use in my
> second attempt is a better one than the base I originally used, and
> the patches may even apply cleanly to the older history, but may
> turn out to need semantic adjustment, at which point I would discard
> that second attempt and use the old commit from the first attempt
> that built on a newer base), I stopped using it.
> 
> The mid-to-commit, for it to be relialble, needs to keep mapping for
> all the commits created from a single message, instead of being the
> last-one-survives mapping.  I just didn't have that much interest
> back when I decided it was not worth and dropped the post-rewrite, I
> think.

I would like to ask you to reinstate the post-rewrite hook, as it still
improves the situation over the current one.

Of course, it would be nice to get the automation into a shape where
the mappings in `refs/notes/amlog` of commits that hit `next` are fixed,
if necessary, to stop referring to commits that did not make it into
`next`.

Because the *concept* of `amlog` is quite useful, to put back at least
*some* of the information we lost by transiting Git commits via mails
without any connection to their original commits. It is still the most
annoying thing when I contribute patches myself.

Ciao,
Dscho
