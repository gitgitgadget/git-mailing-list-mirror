Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E01C51F404
	for <e@80x24.org>; Sun, 11 Mar 2018 12:11:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932132AbeCKMIH (ORCPT <rfc822;e@80x24.org>);
        Sun, 11 Mar 2018 08:08:07 -0400
Received: from mout.gmx.net ([212.227.17.22]:43165 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932125AbeCKMIH (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 11 Mar 2018 08:08:07 -0400
Received: from [192.168.0.129] ([37.201.195.115]) by mail.gmx.com (mrgmx102
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0Lp8h6-1ePDKG0RLI-00eraa; Sun, 11
 Mar 2018 13:08:00 +0100
Date:   Sun, 11 Mar 2018 13:08:03 +0100 (STD)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@MININT-6BKU6QN.europe.corp.microsoft.com
To:     Igor Djordjevic <igor.d.djordjevic@gmail.com>
cc:     phillip.wood@dunelm.org.uk, Jacob Keller <jacob.keller@gmail.com>,
        Sergey Organov <sorganov@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Johannes Sixt <j6t@kdbg.org>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC] Rebasing merges: a jorney to the ultimate
 solution(RoadClear)
In-Reply-To: <f3872fb9-01bc-b2f1-aee9-cfc0e4db77d6@gmail.com>
Message-ID: <nycvar.QRO.7.76.6.1803111301340.20700@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
References: <87y3jtqdyg.fsf@javad.com> <4d7f3406-b206-cc22-87df-85700d6a03d9@gmail.com> <33da31e9-9101-475d-8901-4b6b3df2f29d@gmail.com> <940d959d-151d-68dd-0f13-320ebad0d75b@gmail.com> <87606hoflx.fsf@javad.com> <0ac3a3fd-4053-e32e-75ed-8829f22c2e1f@gmail.com>
 <87a7vss6ax.fsf@javad.com> <f1a960dc-cc5c-e7b0-10b6-39e5516655b3@gmail.com> <ed4d2b30-2dea-740b-6283-973c798f619d@philandanna.no-ip.org> <1298a701-a860-a675-83d7-72f29e14cd2b@talktalk.net> <CA+P7+xpgChuvh_vsPktBkOEhF=MjJh1n_3jD0-n4d67j9kYqzw@mail.gmail.com>
 <ee809701-a6d8-157d-09cd-cebbf2e949ec@gmail.com> <1580e48a-be44-38dd-79af-8a2a31c5712e@talktalk.net> <nycvar.QRO.7.76.6.1803061812090.20700@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz> <754e2735-1288-9a8d-c8bd-ab39cf733812@gmail.com>
 <nycvar.QRO.7.76.6.1803070810550.20700@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz> <c5a5c2cc-6a11-440f-5b9b-964ae1ca07dd@talktalk.net> <f3872fb9-01bc-b2f1-aee9-cfc0e4db77d6@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:W+iWXpcj5eadStGULSbf6rhgG4jBubiJkBJ7XaIXyLJJImmATAg
 rPnicqzFHgZlD/6Ib0Wi46omnBnO69uzhFsx4MmEklJKmrIsWw1MPDv9/5Xggo2PHYA9kwk
 PnY07heI/SvqYDCpM7QZ/0jdQ/Lx+lQ/J+EpXBUV4wcp5TIExSCvhlyWQUNeO9uATOtqM0W
 XPoCvxOar6XeYwQ6fwGzQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:Js40z4d2lIc=:u7KQXpUVYDRBfJ7S3ayrzE
 8mWCnEuOV+xDKCTkSwwKPsZoDHHCn+z2407HB7FokBMYaNMJaZRxLC9J+dzBfxXbFxX56wyq1
 FY5E/rD7N/hpjrQy/d40qhq58K6C61nAwQB32XoalJptoaK1CkB/RHKgO3kVLB7nUAKjAZNda
 C8Q0J9KLvThrnrahzLGUNVGmbwFPXupIdtvqg56M8Zk/LtvCpb4O4a3UUmCKszS9LV5EYhjEa
 YTX+HJwsQZYyCw23pyGeoM66VHem1jtuZBQl/PL8ayjTcpxk42AvUrNXkUzazjDMF9W8KurJM
 Hek6gsrdusfcv8QJ0SJvfwQBenGpsF3desPW11UHLkoTd0H0MfKzHgIYFOcP7pscrJgr7oKSk
 7VYUuGsNyGJmgKr8tYURdv9MgUeHtrJMZ2d8++/iK/qkgd2FRb5unkvA7XVKqDyHkpftF+Yl7
 1X1ErMgX7QLkXBAaoBi0UWj+YnfpTzt8YeF5DDfjdgh2mQwJCk2IYAYY3uRrz8I2dxJFVuF2D
 uPCWpJdJWw5Z0lqlNc9oPcqHZUMeywkfEv/OvMlH8Hc1zT8rt30+iCqwC9ug1iqNYWgMgU8s7
 mNtBoj2cNMkBB9A5Irevn6m883860ftyuwPmKbaUKDUYH6fo4n5bZHXRtKiZOjq/s8yZKyk7u
 D6AXT7339NenmOuXQ3VX+JwzoL1xCn/6qbI4svZJsPeKwYUJavZWrqPpYnHc8jHedFr6oldRc
 EyDx3aCRRnkWzpLBf+jNPosnon4DsuUQXnWyHxSmA5C5/1TQ8HrKUh9S6e85NrCSxFtFPRPxW
 9V94V6eMlt2IKysBf5T7LgL6Xtu+L5TQS4CxliXi/tdppLy9e7vE4n069aBnWTCzxAyb6K7
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Buga,

On Thu, 8 Mar 2018, Igor Djordjevic wrote:

> On 08/03/2018 12:20, Phillip Wood wrote:
> > 
> > I did wonder about using 'pick <original-merge>' for rebasing merges
> > and keeping 'merge ...' for recreating them but I'm not sure if that
> > is a good idea. It has the advantage that the user cannot specify the
> > wrong parents for the merge to be rebased as 'git rebase' would work
> > out if the parents have been rebased, but maybe it's a bit magical to
> > use pick for merge commits. Also there isn't such a simple way for the
> > user to go from 'rabase this merge' to 'recreate this merge' as they'd
> > have to write the whole merge line themselves (though I guess
> > something like emacs' git-rebase.el would be able to help with that)
> 
> Hmm, funny enough, `pick <original merge>` was something I though about
> originally, too, feeling that it might make more sense in terms on
> what`s really going on, but I guess I wanted it incorporated into
> `--recreate-merges` too much that I tried really hard to fit it in,
> without changing it much :/

The `pick <original-merge>` syntax is too limited to allow reordering, let
alone changing the parents.

> And now that I said this in a previous reply:
> 
> > The thing is, in my opinion, as long as we are _rebasing_, you can`t 
> > pick any merge strategy, as it doesn`t really make much sense. If you 
> > do want a specific strategy, than that`s _recreating_ a merge, and it 
> > goes fine with what you already have for `--recreate-merges`.
> > 
> > On merge rebasing, the underline strategy we decide to use is just an 
> > implementation detail, picking the one that works best (or the only 
> > one that works, even), user should have nothing to do with it.
> 
> The difference between "rebase merge commit" and "recreate merge 
> commit" might starting to be more evident.

True.

> So... I might actually go for this one now. And (trying to stick with 
> explicit mappings, still :P), now that we`re not married to `merge` 
> expectations a user may already have, maybe a format like this:
> 
>   pick <original-merge> <original-parent1>:HEAD <original-parent2>:<new-parent2>

I do not really like it, as it makes things a ton less intuitive. If you
did not know about this here discussion, and you did not read the manual
(and let's face it: a UI that does not require users to read the manual is
vastly superior to a UI that does), and you encountered this command:

	merge deadbeef cafecafe:download-button

what would you think those parameters would mean?

Granted, encountering

	merge -R -C deadbeef download-button # Merge branch 'download-button'

is still not *quite* as intuitive as I would wish. Although, to be honest,
if I encountered this, I would think that I should probably leave the -R
and the -C deadbeef alone, and that I could change what is getting merged
by changing the `download-button` parameter.

> p.s. Are we moving towards `--rebase-merges` I mentioned in that 
> other topic[1], as an add-on series after `--recreate-merges` hits 
> the mainstream (as-is)...? :P

That's an interesting question. One that I do not want to answer alone,
but I would be in favor of `--rebase-merges` as it is IMHO a much better
name for what this option is all about.

Other opinions?

Ciao,
Dscho
