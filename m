Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B398A1F453
	for <e@80x24.org>; Fri, 18 Jan 2019 20:31:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729437AbfARUb3 (ORCPT <rfc822;e@80x24.org>);
        Fri, 18 Jan 2019 15:31:29 -0500
Received: from mout.gmx.net ([212.227.17.21]:60449 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729403AbfARUb2 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Jan 2019 15:31:28 -0500
Received: from [192.168.0.129] ([37.201.193.149]) by mail.gmx.com (mrgmx102
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MOCSm-1gq4RJ2kcu-005c1O; Fri, 18
 Jan 2019 21:31:21 +0100
Date:   Fri, 18 Jan 2019 21:31:05 +0100 (STD)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH v2 0/4] Let the builtin rebase call the git am command
 directly
In-Reply-To: <xmqqef99lu2c.fsf@gitster-ct.c.googlers.com>
Message-ID: <nycvar.QRO.7.76.6.1901182128040.41@tvgsbejvaqbjf.bet>
References: <pull.24.git.gitgitgadget@gmail.com>        <pull.24.v2.git.gitgitgadget@gmail.com> <xmqqef99lu2c.fsf@gitster-ct.c.googlers.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:3qeHH5jLWQE8bENL70Sakd4OQGiNXPDR1sEVWO+L8aYjThcLOC9
 anJuDD30uf7fbp4UP5KsCZj4iDJG7ysVWohPcRx3xIJXosVBSKpL86DGfBaJvsgFPVsBaC2
 LX5igVVnD5E9fNup99cAdLpbi+824MGUrHfw8e2Atu6JIluzKduSYFNeouDwRYHCOXAYpyF
 cosdjHNjWnh6ts+4Eh04w==
X-UI-Out-Filterresults: notjunk:1;V03:K0:pJUW6Nuq4D4=:MS74cSZDGC6nDDmDU6aHEN
 VX1Dg7LG4CnnlGAuzVck0Sem+JZvgiu9yr6aSpHJCB3rBedES0M7Nqyso4kKlp43bfxbW0ce3
 KcgRuAcgnPtr9DkUcaeI5U+K1yojgsW9DXBRKbPlDK876zTb3+TzzvxkwbEsZjMZTZkF3YF3w
 DiVogTYnuTxgQboHouCal4hfJtGOUZgP095R+cqM+0F5zySJ9T8ZJyCOmEtwfDuRWt96MoPB0
 eTcvrj70vHspqjR+LsKED0wlGzVH70P7I98bopXWse6pujniSF+aiCyokgxLyD9L3TThPCrgX
 7xqZao/PztOIzL7ZCN66XNnmH2ELKHIZc6F7by5zegA/MkSI55pOOdWwv6EiEHupF0jNOIuLo
 qQCdMhA/uUA+q/r5G8uFTIJ4cU5RDm/+ZetGO9BGd7is+QL0o6fmBkoSqX+HYlaLyRSfhRDSl
 2GmFwBvOglP4IOBNcxRFtQDfcPQ+rMFlrWaZ1C4RRN9fDEjezGY00rHy7ShHFR/io1rMO7v6h
 K3aK4FkzN70QrcI85ap6dqJypRt0catyJ7YLKiI529MvZlifKmjP4Zbq0+d7HlvnkuVaQZuNa
 W5DYMoX6l9EFd5gNXfRz0C70sSiO+ISq+G5wUlS9KR+8JiR8jiVnQRPlDLLcJxwrl15Bir5ii
 EGURoEKIvkozbOzfSddYwPt5ZodvlohpG3tjgMviYzmb+v2TVp+sldpBEj5qdEX+6Dey8aPnA
 jtgsxiAIHJ1LLVtmTx3OsU86slCq7nVpjoRndcyH9cisveqfIt7EUzi188yytgq6HXst3zmCR
 XlcfHYZWyRv4qank6G8LTgaqjsV78VZ8+yZc5qC+FPD75Spi+3mYVnanquAbX+qAwLQ3GWnWV
 1SO1qByUAzAx7IHyTAoZSumr5GiO9ZhlRailtUW5aA3d2I52AyDfpiNPJm5BQkjnFlyW+JqzW
 XbWqt+T1NXg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Fri, 18 Jan 2019, Junio C Hamano wrote:

> "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
> writes:
> 
> > Especially on Windows, where Unix shell scripting is a foreign endeavor, and
> > an expensive one at that, we really want to avoid running through the Bash.
> >
> > This not only makes everything faster, but also more robust, as the Bash we
> > use on Windows relies on a derivative of the Cygwin runtime, which in turn
> > has to jump through a couple of hoops that are sometimes a little too tricky
> > to make things work. Read: the less we rely on Unix shell scripting, the
> > more likely Windows users will be able to enjoy our software.
> >
> > Changes since v1:
> >
> >  * Rebased on top of master to avoid merge conflicts.
> 
> I do not appreciate this very much.  
> 
> We already have a good resolution prepared when merging this to
> either 'next' or 'master', which also resolves conflict with the
> other topic that requires this topic to add "--topo-order" in its
> call.  Rebasing series means invalidating the previous work recorded
> in rerere.

You misunderstand. The PR had merge conflicts with `master`. As such, the
Azure Pipeline that tests it on Windows, macOS and Linux could not give me
enough confidence. So I *had* to rebase.

Besides, I think it is a terrible idea to leave the resolution of merge
conflicts to you. You are not in the best position to judge how to resolve
them, and as a consequence you spend more time and effort on this than
necessary. Of course, it's your call if you want to do it, as a
contributor I'd rather be certain that *I* resolved the conflicts.

Ciao,
Dscho

> 	side note. The rerere database entry can be recovered from
> 	master..pu with contrib/rerere-train.sh).
> 
> >  * Adjusted the commit message talking about double entries, to clarify that
> >    it talks about HEAD's reflog.
> 
> Good.
> 
> >  * Replaced a misleading action parameter "checkout" for the reset_head() 
> >    function by the empty string: we do not check out here, we just update
> >    the refs, and certainly do not want any checkout functionality (such as
> >    hooks) to be involved.
> 
> OK.
> 
> >  * Reused a just-prepared refs_only variable instead of repeating the value
> >    assigned to it.
> 
> OK.
> 
> >  * Fixed a stale comment about the shell variable "$upstream" (which should
> >    have been negated to begin with).
> >  * Fixed error messages when files could not be opened.
> 
> Good.
> 
> Will take a look.  Thanks.
> 
> 
