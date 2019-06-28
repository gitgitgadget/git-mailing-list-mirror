Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MALFORMED_FREEMAIL,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3D8A11F461
	for <e@80x24.org>; Fri, 28 Jun 2019 11:55:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726741AbfF1LzM (ORCPT <rfc822;e@80x24.org>);
        Fri, 28 Jun 2019 07:55:12 -0400
Received: from mout.gmx.net ([212.227.15.19]:60441 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726524AbfF1LzM (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 Jun 2019 07:55:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1561722906;
        bh=3njFPgdtG3o+4zLtqXGLzN6wYcKST5yjGUNhwPoALzs=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=eqdmGPpGLp7UYH5DaHHZCLdgWgqSQd2lFJoW9a19EorpNJNDPPhtIfmCG/WqtRN/t
         RI5pI0AYHkataXzO9OOWI7EdQFFsY7NCJxLQt/tckQIXufHiEeKiB4tfHnnO6qBahW
         TVHUFhUa6q0RC5E+MN/Wv4aoYs6KzuOjUczi9TnM=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.129] ([37.201.192.51]) by mail.gmx.com (mrgmx001
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0Lbdl5-1iQw411IxX-00lFvl; Fri, 28
 Jun 2019 13:55:06 +0200
Date:   Fri, 28 Jun 2019 13:55:29 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     Quentin Nerden via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Quentin Nerden <quentin.nerden@gmail.com>
Subject: Re: [PATCH 1/1] docs: update git-clone doc: refer to long options
In-Reply-To: <xmqqmui2aiwk.fsf@gitster-ct.c.googlers.com>
Message-ID: <nycvar.QRO.7.76.6.1906281352230.44@tvgsbejvaqbjf.bet>
References: <pull.277.git.gitgitgadget@gmail.com>        <0dd1b017698dd9d15f291f1133eb40dac8d85a68.1561663019.git.gitgitgadget@gmail.com> <xmqqmui2aiwk.fsf@gitster-ct.c.googlers.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:97OuyQ6HrZwJzsfjeaCJazfqliD+6g9G5eguzXs9maDDU/RjNZh
 6WCf49VkG4ixOYhEvn8U3/zIjy3w3hq/j60QLqW4yqlKDlfsm6Qn+HtGX/dcQKPl1/29fHJ
 SxMfl2Mi3gdu4eSxh64EI1o4lbH3zC5AMmZjaILHkdTENEjw53cfsbd8ysJ61DIXzXHcGfO
 iPE+C7WMcT4ToHOWak5WA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Daf8yRluBSg=:y2d5G4ouD05igHsM5VvNzh
 6TASGwY0WZens0T0Ra3LdME5atPymV9sN8UkghYLancz6hnab8zGNj162L2FoM9wBhLUNtv9q
 viaWWx3f2+jQDsQUYnO4s2eSsHjxG3XAKEPrs8Na9FeVBprXbtha8lxobjAzEXX1guvzaqHSP
 zWtc3zH45hKUARRwetpbisx9gUeUAj2yjhH8iYWo3xtNOP89y/FJ+RurgV0yr00DHZnYtQhbJ
 XreswmNqR4qdym+9lV2DDCwj0Knm05m+Z55CtXRG6jODvL2q8h/K8HAOw6p+EJbF29gVGVFD/
 4QOH6bUGRxgaHyQC9TZWKuBJ2KWo+qMfXtUxW5H0VZLfZWpw71BpcLl4ex10H5SVdKny6hUyg
 mTNicowcIUHKNxHfis9TMCs2ivy0xRnV9Z70y9+VhX1qLZVw5z05lqdTL44cOZGbLkp0fWqTD
 ijHlau0jJtqjJEvRX+urBWQMRZ+cZBS88b8AesQa1TzrW3/YUmBjlSLRpDabI8X+8IetGrXuy
 EMHXlQrzWfkcS6Ryfif04bb6WFofgbi8KoZSDa/u3dKQhcpp99Varq4d0VLOmNLarHqSJp8bM
 /f+ljOCFI6G47s++5iTtgY+2Y9e0qMMQU75S6QyUXOjl2BEy1BkkeBzKNtuCxRg5mzj0Z/J3L
 Wk4oam8Vy0qtypVX3RL1n3yL4Nv56mz01xeKjfKUPjBSxSk6zrFC4313qWH+y1TpvWx5+Jedm
 HJ+3FfGntT8gnVh0vIX9eDXVVeUiRLfBDMgyx75PrlDBXBr8dsSseQA/COsqSCbXHa014ylvH
 qTzzhf+63I3ugE7E/Mq1ljeF9xBl+GZF0Gn+UDhlU71G65x/j3a2FWEMq2psu+aNfDDwBhCIP
 vhywzPQZgQLb0kBaIun+qWyvxTDVNsJ9gZMUlw6rx7ZfnEA1U6SOVogu/8N9HTpFloOiWA3Us
 eoNBcLMxD1vYpYVraIopQJ9reMt4MdTiqB3VvYCWS0qcbsj7e3E/be9GmuY38kHzItxYMSSUJ
 ErhCZ4xyso6xlL6l7WdmnrgMOd15yaO/jSsKe75sATCx+zfrdLI+z+0VJonNGzWEtx1GXt/Sy
 jRMpR0WwyPF5/f36Wn5LAUhnCm31C/cy53v
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

On Thu, 27 Jun 2019, Junio C Hamano wrote:

> "Quentin Nerden via GitGitGadget" <gitgitgadget@gmail.com> writes:
>
> > From: Quentin Nerden <quentin.nerden@gmail.com>
> >
> > To make the doc of git-clone easier to read,
> > refer to the long version of the options
> > (it is easier to guess what --verbose is doing than -v).
> >
> > Also:
> > put the short options first, to match the doc of git-add, git-commit, =
git-clean, git-branch...
>
> This "also" makes the patch unnecessarily harder to review.
> Splitting it into two patches would make it reviewable.

Good idea.

The easiest way I can think of would be to split by first undoing the
commit via `git reset --hard HEAD^` (don't worry, the commit graph is
still accessible via the reflog), then staging the parts of the patch that
put the short options first: `git checkout -p HEAD@{1}`. After that is
done, commit with a new commit message, then get the remainder of the
changes via `git cherry-pick HEAD@{2}` (by now, the original commit is no
longer `HEAD@{1}` because a new commit has been appended to the reflog).

Then force-push and submit a new iteration ;-)

Ciao,
Johannes
