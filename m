Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.9 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 56FCD1FAAD
	for <e@80x24.org>; Mon, 30 Jan 2017 19:34:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754155AbdA3TeH (ORCPT <rfc822;e@80x24.org>);
        Mon, 30 Jan 2017 14:34:07 -0500
Received: from mout.kundenserver.de ([212.227.126.133]:58258 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754135AbdA3TeG (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 30 Jan 2017 14:34:06 -0500
Received: from linux-7ekr.localnet ([89.15.67.211]) by
 mrelayeu.kundenserver.de (mreue005 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 0M4Vnk-1cHhlp18eK-00yiZY; Mon, 30 Jan 2017 20:33:57 +0100
From:   Cornelius Schumacher <schumacher@kde.org>
To:     git <git@vger.kernel.org>
Cc:     Christian Couder <christian.couder@gmail.com>,
        Josh Triplett <josh@joshtriplett.org>
Subject: Re: [RFC] Proof of concept: Support multiple authors
Date:   Mon, 30 Jan 2017 20:33:56 +0100
Message-ID: <1895528.rno9AclvBq@linux-7ekr>
User-Agent: KMail/4.14.10 (Linux/4.1.36-44-default; KDE/4.14.18; x86_64; ; )
In-Reply-To: <CAP8UFD3=vaFupEDay-5vrMBwK_YJezysUUvySxnUUZxuW7m_WQ@mail.gmail.com>
References: <1485713194-11782-1-git-send-email-schumacher@kde.org> <CAP8UFD3=vaFupEDay-5vrMBwK_YJezysUUvySxnUUZxuW7m_WQ@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Provags-ID: V03:K0:kBdpQTpXZtTp9EqCVMriToomdyRY0JB+0N2mZ15lMuiENUzNlt9
 VOpVc4QemoUm/ykySTRdeEf6a0H0sC8B8Rmg2NbetUpoUgAvWchzRBKD5A2nkADcrM+y+/R
 CvEpq504u4jIQuLRgNeIVHvLHRdhLdYyNmy1IMAoKT9+YmJKIvbZZAmUj0hSNgYI2K8zo0S
 lBMiuDAdFBFNLM/+Lswmg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:Uq8VkZdMEJ0=:5H5wxjK//9PKb3WvL3DSal
 JVocA8zqpDa6eqyBg3DcguIV8VQ4Arm69/Eg6mz5ts2zlsuEO2gUDZJqNNy04Xy3cN7JYMHk9
 5EMDHSyS/kMd23+KApORajGq/Hr4zBbdAXNx1aeDiPpyWScvOLv2UbKtZHk4MsTLK993dJalV
 gqV/afDX5tTA0q6bLJaGcDM+pKk1fzykivF550DI1v4NAvuiCdCo2XQLaVSSJiLYXw6ii8w0m
 6ihP4Ph3w5mdi7/QJp24GV96qnCKsE50DWbUQgV2BhAPl/DqpbD8zee6KvlEZAXIHGgmgjfSU
 0Kadk6CKf+nfPzGm/P0D1JQqmff8vV87Czgxd3dC/mzrPTdZXG+jqxgQu3v9rISu1exGZBPgd
 3M/dq8RIY6iGWEiM7lXHyNOTPQF2mjhCl04KYgdH6epQsDDNoaDrB70c9gV5TUdVRVqMnU46c
 rkPotdK+tj3ZqaiBqcikKawMBDGn/UZNqEydtibAX2TAgcZpRcFIX/4SddmFCPkxU3uk46o54
 /yBw7YTxQGtQsPJgH8hj5aP8WZ6lHPNBXt0lVpXrrmDm4BbSh4h/Ts2IhG2u21M+LZblHFQxm
 XLTlfna8R93Xc7eHCDiA09N4Uu9ddFQyP1zse+VPYY8tgflEFr6gKvsvKlUN07QxXlGunMHSq
 ekokiD4PCtQ0ssyg20iZGULXY4Wqawbu4xI2QYcNoYhG9w6B9q0aC/37EeHevQtP+Nz9x1Nf2
 pQ826vQa/EJmoNoz
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Monday 30 January 2017 18:56:42 Christian Couder wrote:
> On Sun, Jan 29, 2017 at 7:06 PM, Cornelius Schumacher
> <schumacher@kde.org> wrote:
> > This patch is a proof of concept implementation of support for
> > multiple authors. It adds an optional `authors` header to commits
> > which is set when there are authors configured in the git config.
> 
> I am just wondering if you have read and taken into account the
> previous threads on this mailing list about the same subject, like for
> example this one:
> 
> https://public-inbox.org/git/CAOvwQ4i_HL7XGnxZrVu3oSnsbnTyxbg8Vh6vzi4c1isSrr
> exYQ@mail.gmail.com/

Thanks for the pointer. I have read what I could find about the topic and 
tried to take it into account. Conceptually I wouldn't want to alter the 
semantics of the existing author field, but add optional information to 
capture the nature of commits done by multiple people collaboratively, where 
attribution to a single author is not an adequate representation of how the 
commit was done.

Maybe it still would be too intrusive to add an additional header, and there 
would be more elegant solutions to this problem. I would be very much 
interested to hear about better ideas how to handle this. On the other hand it 
seems to be the most straight-forward solution to handle this on the same 
level as single author information. But maybe this is due to my still limited 
familiarity to the internals of git ;-)

What I know from the experience of pair programming is that it is an actual 
problem to not be able to represent this information in a native way. It would 
benefit quite a number of programmers to improve that. I'm trying to find a 
solution which does that and still is compatible with the design of git. Any 
comments leading to an acceptable solution I highly appreciate.

> > Adding support for multiple authors would make the life of developers
> > doing
> > pair programming easier. It would be useful in itself, but it would also
> > need support by other tools around git to use its full potential.
> 
> From what I recall from previous discussions, the most important
> question is: are you sure that it doesn't break any other tool?

I have tried with a few tools and didn't find breakage other than that the 
additional information would not be taken into account. That of course doesn't 
mean that we could be sure that there are no tools which would break. Does 
anybody have hints on what tools would be most sensitive to such a change?

I realize that it does take effort and time to implement such a feature in a 
way which doesn't create breakage. But I still would like to try how far we 
could come with that., because maybe it actually can be done.

-- 
Cornelius Schumacher <schumacher@kde.org>
