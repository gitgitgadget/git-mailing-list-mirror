Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.7 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 958661FBB0
	for <e@80x24.org>; Sun,  4 Sep 2016 07:37:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752355AbcIDHhH (ORCPT <rfc822;e@80x24.org>);
        Sun, 4 Sep 2016 03:37:07 -0400
Received: from mout.gmx.net ([212.227.17.22]:55279 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752022AbcIDHhG (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 4 Sep 2016 03:37:06 -0400
Received: from virtualbox ([37.24.141.250]) by mail.gmx.com (mrgmx101) with
 ESMTPSA (Nemesis) id 0Lpfas-1bC4m60mec-00fSMd; Sun, 04 Sep 2016 09:36:48
 +0200
Date:   Sun, 4 Sep 2016 09:36:46 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Junio C Hamano <gitster@pobox.com>
cc:     Philip Oakley <philipoakley@iee.org>,
        Robert Dailey <rcdailey.lists@gmail.com>,
        Git <git@vger.kernel.org>
Subject: Re: Fixup of a fixup not working right
In-Reply-To: <xmqq60qdsoxj.fsf@gitster.mtv.corp.google.com>
Message-ID: <alpine.DEB.2.20.1609040923390.129229@virtualbox>
References: <CAHd499AQFDRps6POF2xuUjbYv5DJYxt3DA8aFFArXF=qQEz_CA@mail.gmail.com>        <55512A8927384A0790DDC7F526B09053@PhilipOakley> <xmqq60qdsoxj.fsf@gitster.mtv.corp.google.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:43ROxyI53TZPLmAcZkOCnWGlP/k9OCxFsqH7PZ4X/VbCN65M5Mr
 YlXLIEuF9szfUSa4KNlUDG/a9qTbD4DX/znKWK4S7yND1Rfo80psPD3ELRFKEcOWW8fKe/3
 iYr1+Qw0zt6Fa3ZIKagtKJc2haYc59ssjyjiaLqM6lT2TwNy/FkwhJvgjT3ZXrPOGGM9ntC
 VUlIXVbPwu91AUbDRVXpA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:BHlcxn7CRQ0=:/OqdcTviBYW9IqAaxoeved
 zP89Hcx0tO/IGBB7K7mrA5Yth25qToegRLZyjj0hW8eGpUCKJPhSVS3E6VwnCQYQjnfI6xB/F
 zn9wtcnKii/aO8RJp9zk9yOJOaQcZFJxmy01zjAi35/c/Y4hV7Ste3cIdE/z0N26ad9/0UM4u
 HY/pCgcdhklZQQTLyKTezns0BhLXprMUubigTtiu3x/HrrcvuNfOS34cKm/uFic1cPrrdxfI7
 0JGO4doCMFLbkoA9ZOKv8i+hRjMeozyyq5YVgzx/WjBgcIkwKjRQiC8eexXMnSZ/J9dCU+kK6
 Vhr2XvOeWgWLAevMEZaYskdawqVfrXJHpwziMm/INwFDvHeE1dzVi3eCHxK7aXhAEAWSxhVF6
 zHrBIguR/lv1TCFq7X0kKRwYsw+q4vCUYARY3ryagFx+wm8NecBUlco8TjA79QUNmL3EzivQC
 ZI8L7oAIFMjN9WY8BhdpCUC2ej0Mns2cZEEhWQJha7smFzpa/jmlceOMh7mEEU0vxXuPYssxO
 v4Z4KXsLcDNlOY3Mye/Cm2/oWgLrl9ST3lc0ECZ000SZPoPrfui2E/khsJmx6SeLL3WiLDl0H
 dxXT39da29RwBc4Ho8ZeiuT1oMuVPyU/pyPdTqLD67jdZqNFx+usfJXLOJuSxVmDm99Mynlwl
 GHuCnKl+Txtd6ifIqGml4YtzyUrnO1dqiUpGOdTdMN0QeWNI1g+g3xszVQtoFrEX4HCE0DtGh
 NyAxYuijscIBWl32vpeIJZhGRBHiAN5DFhU87y+8ggpToR34hkT2Nzm4YqHjgarkM78lEiJmU
 a8gu4cY
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio & Philip,

On Fri, 2 Sep 2016, Junio C Hamano wrote:

> "Philip Oakley" <philipoakley@iee.org> writes:
> 
> > As I understand this it's implied by design. The issue is that the
> > rebase is looking for that named commit within its current rebase
> > range, and can't find it, so ignores it.
> >
> > There is a separate issue that all the fixup! fixup! messages are
> > essentially treated as being concatenations of the original fixup!, no
> > matter how many time the fiup is present.
> 
> They can be handled separately, but they come from the same "design"
> that could be improved.  When the "original" is not in the range to
> be rebased for whatever reason (including the most likely one, i.e.
> it has already graduated to become part of the public history), the
> best thing the user could do at that point may be, as you suggested
> to Robert in your message, to turn the "fixup! original" that did
> not make in time before "original" hit the public record into a
> standalone "fix original" follow-up change, and then to squash
> subsequent "fixup! fixup! original" (and other "fixup! original",
> too) into that commit.  And a good direction forward may be to see
> if "rebase -i" can be taught to be more helpful for the user who
> wants to do that.
> 
> Perhaps a change like this to "rebase -i":
> 
>  - The search for "original" when handling "pick fixup! original",
>    when it does not find "original", could turn it into "reword
>    fixup! original" without changing its position in the instruction
>    sequence.
> 
>  - The search for "original" when handling "pick fixup! fixup!
>    original", could be (probably unconditionally) changed to look
>    for "fixup! original" to amend, instead of looking for "original"
>    as the current code (this is your "separate issue").  The same
>    "if the commit to be amended is not found, turn it into reword"
>    rule from the above applies to this one, too.
> 
> may be an improvement?

I would be *very* careful with such a change.

The point is that fixup! messages are really special, and are always
intended to be squashed into the referenced commit *before* the latter
hits `master`.

The entire design of the fixup! feature (using the commit subject as
identifier, which is only "unique enough" in a topic branch that is still
being developed) points to that.

I am fairly certain that we would run into tons of problems if we diluted
the concept of fixup! commits by changing the design so that fixup!
commits all of a sudden become their own, "real" commits that can be fixed
up themselves, as much of the current code simply does not expect that.

In short, I am opposed to this change.

And even if I am overruled, I would strongly suggest to implement this on
top of my rebase-i-extra branch (i.e. in the rebase--helper instead of the
shell script) to avoid double churn.

Ciao,
Johannes
