Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5CB7820437
	for <e@80x24.org>; Tue, 31 Oct 2017 17:18:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932445AbdJaRSp (ORCPT <rfc822;e@80x24.org>);
        Tue, 31 Oct 2017 13:18:45 -0400
Received: from mout.gmx.net ([212.227.15.15]:53097 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932386AbdJaRSk (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 31 Oct 2017 13:18:40 -0400
Received: from virtualbox ([37.201.193.73]) by mail.gmx.com (mrgmx001
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0MRGTX-1dixXf1dOB-00UWpO; Tue, 31
 Oct 2017 18:18:36 +0100
Date:   Tue, 31 Oct 2017 18:18:35 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Junio C Hamano <gitster@pobox.com>
cc:     git@vger.kernel.org
Subject: Re: What's cooking in git.git (Oct 2017, #07; Mon, 30)
In-Reply-To: <xmqqy3ns2g9z.fsf@gitster.mtv.corp.google.com>
Message-ID: <alpine.DEB.2.21.1.1710311818010.6482@virtualbox>
References: <xmqqr2tl40pl.fsf@gitster.mtv.corp.google.com> <alpine.DEB.2.21.1.1710301827000.6482@virtualbox> <xmqqy3ns2g9z.fsf@gitster.mtv.corp.google.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:rgJB6pD2cPIm2BB9WBWhRoKP2kjJnjFCfms7ECdWZ9CBdlVR8jo
 mu+0smUEK0lH1iliEaEJqRThGLgouTRdS0aNOb5ngeAp6olXLrnLEKJarJdBPkcoZMTCq2I
 hXPIBWjwLnO9HcjWy/C3EDApYLxmRFEfaYcmbB85URCcb2SyfGDJaizlbiQ/Hs2AoD/OmGS
 QaXv9DCVDAoKCv7EdWCEQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:v0hBUCCIIKE=:+dgKa6XLJj24giO64/pcCk
 Sg9a54wxjBkhzx8LTFy/7GdcCDpJ9DDt6Gq3osU5m2dc9UUXXOC0yqD+g2WYLZAdFRcJv95AC
 13H2Pr+xA8gGmFMU20eSiEVUR3IwjV9O/J0DGjD+tOWg3MrmFMx2JcJ5SCtMWKGFeNxn5v/Co
 7KO/xOAlgHIpkZhGR/qN07wan5C5B1CeJ6uyIb8mAPUZmjhlS3yzdtvdC9rkUScQZjQ3uW04G
 zMgePiM3pmLnVqqt26C06eLLw/gnNC33xrPgejUiq4GxwmoUaYfVJu3zAWpOHk3dAvDR5o+eq
 GBW9zMOKo69aFMGi1JCqO6rnaATfh2cbr93StVoxCZyIQswM7izAdSEyI05YJT/av3Bwws74u
 KNZCzHtYlPDQ/kRZF2IR0q8Jdw5eTDLtlR57ZnFb77LLUR6ro97HmQjvaGdvrhcbf/OUNADHL
 jJJjs5oJ/jG+CUsaTgkQ40bRY10JWJfy91IfTj0UOcksG9oJqrD6DyWJYdL4JXgfkqanj62Kq
 j46JWLe4IOprgrvusAjCfD7M0zQVGAtL91ReQ1Q/cZCpGw/RotvrpOSDhj5R/k+1GX9TEJ4s4
 1bnl6vBlXBh1QnZScYXRTAPdy21adudtJ6zi4qgLEFGHFOid/ghZLBrkezytftXmyjy2g3nD3
 goVVnOQy1AAUUpPfpNTR//WnTs/wfQFi3mID8d0l7jjxjZVQXRcmZ2yMvFEOhjMtcaxxnX8U/
 pDroFfitrCy8zWjDbngnEZ4bwgur0/7WtGLKtCZNrpwfXkfTkLqTkfsVN6/vCIbp1eBOqi3Bl
 I2RgFXfK0qZDlKyS5+1XYz1I+w0VfrGxmB5q4rlc/ibuAQ5ickgAhmIVUGguqBIYGTt+wMC
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Tue, 31 Oct 2017, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> > On Mon, 30 Oct 2017, Junio C Hamano wrote:
> >
> >> * jc/branch-name-sanity (2017-10-14) 3 commits
> >>   (merged to 'next' on 2017-10-16 at 174646d1c3)
> >>  + branch: forbid refs/heads/HEAD
> >>  + branch: split validate_new_branchname() into two
> >>  + branch: streamline "attr_only" handling in validate_new_branchname()
> >> 
> >>  "git branch" and "git checkout -b" are now forbidden from creating
> >>  a branch whose name is "HEAD".
> >
> > Question: should we respect core.ignoreCase and if it is true, compare
> > case-insensitively? Or should we just keep the comparison
> > case-sensitively, in preparation for a (hopefully near) refs backend that
> > does not inherit filesystems' case-insensitivity?
> 
> While I do think it would be good if the system as a whole somewhere
> we had a safety to say "We do not allow hEaD as branch name as you
> are using the files-backend as your reference storage on a case
> insensitive filesystem", I do not think it is a good idea to do so
> in the layer the above patches touch.  Once a more capable ref
> backend comes (Shawn's reftable, anybody???), platforms with case
> insensitive filesystems can allow refs/heads/hEaD as a branch whose
> name is hEaD that is different from another branch whose name is
> hEAD just fine; having the "we are on icase system, so reject" check
> at the layer would mean we need to remember we have such a check at
> a wrong layer and revert it when such an improvement happens.

I am glad you covered that concern, thanks!
Dscho
