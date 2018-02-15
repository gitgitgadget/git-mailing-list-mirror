Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B24E51F404
	for <e@80x24.org>; Thu, 15 Feb 2018 13:06:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1031533AbeBONGc (ORCPT <rfc822;e@80x24.org>);
        Thu, 15 Feb 2018 08:06:32 -0500
Received: from mout.gmx.net ([212.227.17.22]:34277 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1030843AbeBONGb (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Feb 2018 08:06:31 -0500
Received: from MININT-TB4PCE7.southpacific.corp.microsoft.com
 ([37.201.195.115]) by mail.gmx.com (mrgmx102 [212.227.17.168]) with ESMTPSA
 (Nemesis) id 0MaV3V-1f5uQf2KKn-00KCRQ; Thu, 15 Feb 2018 14:06:28 +0100
Date:   Thu, 15 Feb 2018 14:06:27 +0100 (STD)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@MININT-6BKU6QN.europe.corp.microsoft.com
To:     Jacob Keller <jacob.keller@gmail.com>
cc:     Psidium Guajava <psiidium@gmail.com>,
        Stefan Beller <sbeller@google.com>,
        Paul Tan <pyokagan@gmail.com>, git <git@vger.kernel.org>
Subject: Re: git-rebase --undo-skip proposal
In-Reply-To: <CA+P7+xpBW7Sq89f5RK6cCcLYGR0Rh0aWdWrhqjerKUi5xUUKtQ@mail.gmail.com>
Message-ID: <nycvar.QRO.7.76.6.1802151403360.35@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
References: <CAEWZXo7KiRWK7ddyZgQKs=F+sHY7TtFsXTMXyE-57=FRr6kf6w@mail.gmail.com> <CAGZ79kZf1UKsBEJXuwAH+EWr+ZKj-FE8DuBvcM2nJeNhLEA4CQ@mail.gmail.com> <CAEWZXo6ws5q-73AP6+Ru39a+drO88fRO49_QGJbQXfOYRpqKwg@mail.gmail.com>
 <nycvar.QRO.7.76.6.1802150148040.35@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz> <CAEWZXo74Z0PRkVPzkrMDdKNhLzyKL03vUYiN=SEnt5MBdXT81A@mail.gmail.com> <CA+P7+xpBW7Sq89f5RK6cCcLYGR0Rh0aWdWrhqjerKUi5xUUKtQ@mail.gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:H/jPzNTdd0N/1s0slx8PoPnTU/jRTO9pYD+iaGTOOyQXyd3fobH
 ZNuWOWBr1eIieOwAQWwmwa5IjrafVfFw9Xg9BCd1tEWig4dynIF8gMAoa6BcVhYAWLl9Nz/
 BDwe2NoqQQHivghVFOT2+AXCWG0cImVyxtDL7d7mQm4YSqiv4oVd/TfQ3HZy8Icu6pbelDa
 OH10QQuncXoQq6Fwgsq8A==
X-UI-Out-Filterresults: notjunk:1;V01:K0:AmCCmVRnwcA=:zY7xubNL+P9W3F7i7rDibA
 NW31l8C6728ePq4X3Go/asWxygsiFdY/FOgwuad7dKYrHUNkbliwtI5CGyEeM83I+sQhUAXn7
 /UEgemVPvhbFl8GDy3xRzaQ3y7DA7XyrPqoYdoO3aKNybAlkTP0peAtxvr6loLzbE1tJW87gt
 MzV7Ufxcq3Ioc8JR/SHBDnQBQk+8H112DpGQ8B3HjP6j9o6/N92OYP/C4erLnXmPv9fE2EpTx
 30RZ93zhY3mPbPXtn0vVRjznTScSkdCNgDVuVmd8g6ODUGdanDsy378q7QC25JHLpsjWlH+vN
 tcR8EyYplpd/R7ggzlz0i1MYRm0rgKUI9MCPChYt5KiDN47xyWuR67yxtNj4Hhxo4qiSv6kP3
 Ttu+1U94+37UgWPe6qCErBua/PO58saMxX6rxRpPx6VeAQqUHGGPEAnUgI1R6Imbcv2UOZIFk
 tD58phSw1aEynLJxAWQpXhUppIqv0Pn7Sjo0G8KkMTlrRg5kpEZ61tuAQafu+Z0zQqwAX85eA
 30oP2GrnViZ1p8PXYn73Rz5iGTpdBB/hIz23Gqg4OqXRx5ydnvgNuQmBhqfKpTAYCjqwyyP6F
 OEn2mZGdLhcV62J2/QlUyAwPoUheQBHYv/e9ePQjcLIoXQOOI1+EZZIyU8/f3VWEn1bIHCQAg
 ajh1PhKOnX/9ePhwrZHoD05PmMY8bOVZ1yg+3TeSIP9m7eRPJjj7UxQ+dlZGB8cYhterbX0wZ
 eGdnOuPuvjcYdjz18apeefxSEv36DD6Y09TMFZ8A9Z0EDz1i79LZJwTzC9AM0eEeh5z8GowdL
 tZ3+SocKig+QTbPGdxWoDmKmER8pCvl3M3hVTWGDj+W7tcP/MI=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Jake,

On Wed, 14 Feb 2018, Jacob Keller wrote:

> On Wed, Feb 14, 2018 at 5:50 PM, Psidium Guajava <psiidium@gmail.com> wrote:
> > 2018-02-14 22:53 GMT-02:00 Johannes Schindelin <Johannes.Schindelin@gmx.de>:
> >> Now, when is the next possible time you can call `git rebase --undo-skip`?
> >
> > What if the scope were reduced from `--undo-skip` to `--undo-last-skip`?
> > Also, further reduce the scope to only allow `--undo-last-skip` during
> > a ongoing rebase, not caring about a finished one?
> >
> > But, this could be so niche that I have doubts if this would ever be used;
> 
> I think this is too niche to actually be useful in practice,
> especially since figuring out exactly what to replay might be tricky..
> I suppose it could keep track of where in the rebase the last skip was
> used, and then just go back to rebase and stop there again? That
> sounds like just redoing the rebase is easier.. (ie: use the reflog to
> go back to before the rebase started, and then re-run it again and
> don't skip this time).

Yes, and having a record of what commits were skipped would probably be
very helpful not only in this instance.

Maybe also a record of what commits caused merge conflicts, which a
mapping between original and new commit (which does get a bit tricky with
fixup!/squash! commits, though).

Ciao,
Dscho
