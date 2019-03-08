Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MALFORMED_FREEMAIL,RCVD_IN_DNSWL_HI shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0546820248
	for <e@80x24.org>; Fri,  8 Mar 2019 16:12:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726485AbfCHQMY (ORCPT <rfc822;e@80x24.org>);
        Fri, 8 Mar 2019 11:12:24 -0500
Received: from mout.gmx.net ([212.227.17.22]:45287 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726443AbfCHQMX (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Mar 2019 11:12:23 -0500
Received: from [192.168.0.129] ([37.201.195.16]) by mail.gmx.com (mrgmx102
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MS0c2-1hUS8806UE-00TBxZ; Fri, 08
 Mar 2019 17:12:18 +0100
Date:   Fri, 8 Mar 2019 17:12:02 +0100 (STD)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH 0/2] stash: handle pathspec magic again
In-Reply-To: <xmqq5zsukuyj.fsf@gitster-ct.c.googlers.com>
Message-ID: <nycvar.QRO.7.76.6.1903081709220.41@tvgsbejvaqbjf.bet>
References: <pull.159.git.gitgitgadget@gmail.com> <xmqq5zsukuyj.fsf@gitster-ct.c.googlers.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:t2RDU71pWUgnLZWaYe+DcH8phK468fjYwO9Dc8ZddT8aAoYhs0F
 CRWbwg07Lh5FWIi2zSOD9FHe7PQHimVBuv/65DhxnSY9KAFH3CDDY71qH5FbiQiD/+iy4xW
 RThQJSt3N4LRPdhzNDyOYEQ/qH/kBIMixckbNHgL24c3NF1Id1xS6IjW7A8nzkOmLEsvRg9
 JUHpuK26+TaBgSAFKmHdA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:tnQCbkPmW6U=:qHZu487u9FfPjZNutAc3HI
 A27vb+vEcob97tDWjhEwThJ3WrCv7DVqGzBTsWNdAWajA6RA7eLfHHVJLMpJrJKU6tzdJQ8/h
 LmzINozk7CS3a4i70aDPjqMkiHJ1x3+q2jowlIIeAbADmfmGUYNn04naAXpeaDuc5Yo1q0kk1
 8sVW0ioWq1wQwhKcTFGOeLT0LLR1s5CuzmvDcTO6K1JiCcakE7t61L6/CC7Ol5HfubFqZnynz
 hv2dbiFpvl9BWBm5zvXnCPHO1j3Ry60EYlkcsg2alfzsoktRko78Xdt+4oowxgUf2EClNwWs2
 9IT+q4K5H1J7x01tcM+Upz3xzr0HFjWezNmRTT4dsabyGyRl/EXN7luRj0A7aysoFYbQg6sxO
 L//AwmXZtmmbxOW1Oiqhwisb0OxIKEJOFULM//nSlQ70l53FcBq4k+SjEpfX28dw/MXdhfq6Z
 86wvwjJI6C0rtOrNzuZuHNKJf9DuEmcC2KPkc5YG1M4JX+GYJqpUaVNIFffEA0rpZPBqZudHp
 9n8jLaj/rAUNlTtjNlLnvdLHCZ5Bq5qneifgdc7urORE6zLavSUycE3Bwjgu9E5iQhmfsVd/+
 f1dtV2xkLAfaBSPd8lBcvVoxq8GxBfyroCxgi2yo2tVp44ZAsSHR5dbOiKkAwoayOJaOATRlN
 w75HT7kvEGsu6ZP4kI4SlqDTY1JOmEXucAsiJ5e6Bgfg5QN4hpUm6nfvmzLQZ01qmi5e5h6NY
 5u94BYPVs0L49PYqulPr+XvwNGxyvoKahUwvCzOyF92e8mRvmUj0FFqymFBPdDD4wFp5HhgD7
 2XNedD6FyHiM00peGuzxnpvaleo5OqAuADdMjT8EPswiV0hUkSMaKzJDQa5Q2jGZlb+vez+2B
 3v+/NtQL1V/SgjmGbG/bjWKCCF0T0ljTnbRwDZfP3oSfSwViHv9C9N7Dscx7U6QPKOMe+pM6E
 OvnGZ1HRKmA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Fri, 8 Mar 2019, Junio C Hamano wrote:

> "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
> writes:
> 
> > It was reported in https://github.com/git-for-windows/git/issues/2037 that 
> > git stash -- ':(glob)**/*.testextension is broken. The problem is not even
> > the stash operation itself, it happens when the git add part of dropping the
> > local changes is spawned: we simply passed the parsed pathspec instead of
> > the unparsed one.
> >
> > While verifying the fix, I also realized that the escape hatch was seriously
> > broken by my "backport of the -q option": It introduced four bogus eval 
> > statements, which really need to be dropped.
> 
> Thanks.
> 
> We seem to be piling many "oops" on top, even after the topic hits
> 'next'.  But fixes are better late than never ;-).

Yes, we do. At least now I do not have the impression that I have to
impose on Paul to integrate whatever diffs I came up with, I can now just
submit small patch series that are easily reviewed.

If you care deeply about the commit history, I hereby offer to you to
clean up the built-in stash patches when you say you're ready to advance
them to `master`; I will then squash the fixes into the proper places to
make it a nicer read, with the promise that the tree will be the same in
the end as with the oops-upon-oops patch history that we're piling up in
`next`. I would do that for you.

> Will queue.

Thanks,
Dscho
