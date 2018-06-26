Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D3F871F516
	for <e@80x24.org>; Tue, 26 Jun 2018 21:52:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754128AbeFZVw2 (ORCPT <rfc822;e@80x24.org>);
        Tue, 26 Jun 2018 17:52:28 -0400
Received: from mout.gmx.net ([212.227.17.22]:57935 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752113AbeFZVw1 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 26 Jun 2018 17:52:27 -0400
Received: from [192.168.0.129] ([37.201.195.74]) by mail.gmx.com (mrgmx102
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MFAaV-1fMcHo27bv-00GEcw; Tue, 26
 Jun 2018 23:52:19 +0200
Date:   Tue, 26 Jun 2018 23:52:18 +0200 (DST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     Alban Gruin <alban.gruin@gmail.com>, git@vger.kernel.org,
        Stefan Beller <sbeller@google.com>,
        Christian Couder <christian.couder@gmail.com>,
        Pratik Karki <predatoramigo@gmail.com>,
        phillip.wood@dunelm.org.uk
Subject: Re: [GSoC][PATCH 1/1] sequencer: print an error message if
 append_todo_help() fails
In-Reply-To: <xmqqk1qljpe0.fsf@gitster-ct.c.googlers.com>
Message-ID: <nycvar.QRO.7.76.6.1806262348340.21419@tvgsbejvaqbjf.bet>
References: <20180626100429.10169-1-alban.gruin@gmail.com> <20180626100429.10169-2-alban.gruin@gmail.com> <nycvar.QRO.7.76.6.1806261455510.21419@tvgsbejvaqbjf.bet> <xmqqk1qljpe0.fsf@gitster-ct.c.googlers.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:d4eJiJm+t8MF4+KiRIx4jhEvE1wUVDzbADr3M0pxiH3qkyY898M
 ieFWuw1HwrFrk9v+Hra3J4+LHBdF0DQnak4KSftJ6PfgALp+0AHJEIfqvr0gxeIbEy7Hdsb
 rnfv3e/W2+q1bp47s4YAFpqQQJHS3o8ktJ6uz/cI5voShjF1XwMtG8Rj+TtA5jZzI9R/1z8
 lguTLW0f1+iVkTAZ6XlYg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:pyqBrEcYWkE=:aIBS6xZCS/aJwV6yDI1H6G
 DQe4WglOsVVroNGv3VCDrOvFA0Zhaezktbcl1loDiRVN3sBn89WyM2n9ff0bQJ0I5prjEqvSs
 RA9DqqlMFUaiyGoMvfKcNfwS/9sRh9m/xrW+B7R7+f8WCv/T5ecrzgfUQFxhhOQnakPaZCoBj
 ZB98gASSpPp858ql1pbgV9IekfJ9bOuL9XOwiCif10Nuf7ifWn7NRMHCUlnbfxcucSdFWQcaw
 S5VwHzhLR/1ULBkUIJCuCONFtvWRJG3NKoNpLqbRTgdGmtgDnPgIhrE1XjU0spUiQWmOViDal
 V6/OXMdG2IrxwiNRomxy10BidYY0FN8iBGFO/pdsDBZ9iJoQJWpPxMxn9CkmKhQFeLWMTqkqe
 eg2nHwKjpcX4ukWVLsPYKSR9vtoKr/yUdtZbAi/BoByPbY5rB0/+XG9hwZktjDjJmQThrHoUz
 yYvSrRBptiElcrdVP/BX95A5Prucm/AOxzKsj8DQud1eqBwzoK/xhMA+PL9PreuGTfRTVJZ/n
 wr+9OVGZ9hAHgXznt81Qws00xl+U/hFZwwslZX8KpfOCLgVf6q+rxxXWxcqWc4z1U9x1UVRtL
 tgw/uxlOz6dKUs0nOpVXDhfFQ+ZUntc/Zde3ku1yqQeLrmj/RGS7o82t8kzxyzAsArwWNY8Hg
 5PMAAu8/he9s6h1hdwbOBxcf8GJjXn2RMXyATpZKb0BzUPu2x6RjJF9tpVHSNPSh2VCyFVxje
 T3u9aDlE/pkUSG0rApPf7aowOWU0nL1g3Kk1kdAnGNfgljUKmLHjnlB5gONya/HsVAPVBNPQa
 O4oFn06
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Tue, 26 Jun 2018, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> > On Tue, 26 Jun 2018, Alban Gruin wrote:
> >
> >> This adds an error when append_todo_help() fails to write its message to
> >> the todo file.
> >> 
> >> Signed-off-by: Alban Gruin <alban.gruin@gmail.com>
> >
> > ACK.
> >
> > We *may* want to fold that into the commit that adds `append_todo_help()`.
> 
> Absolutely.  This looks more like an "oops, I made a mess and here
> is a fix on top", and even worse, it does not make an effort to help
> readers where the mess was made (iow, which commit it goes on to
> of); it is better to be squashed in.
> 
> I do not know offhand who Alban's mentors are, but one thing I think
> is a good thing for them to teach is how to better organize the
> changes with readers in mind.  The author of a patch series knows
> his or her patches and how they relate to each other a lot better
> than the readers of patches, who are reading not just his or her
> patches but the ones from a lot wider set of contributors.  Even
> though append-todo-help and edit-todo may have been developed as
> separate steps in author's mind, it is criminal to send them as if
> they are completely separate topics that can independently applied,
> especially when one depends on the other.  It is a lot more helpful
> to the readers if they were sent as a larger single series, because
> doing so _will_ tell the readers which order the dependency goes.

Chris & Stefan are Alban's mentors, and I spend quite a bit of my time on
IRC, ready to help Alban when he has questions. Chris & Stephan mainly act
as first-line reviewers.

> > And, as I mentioned previously, I would love for that function to be
> > used as an excuse to introduce the long-overdue `interactive-rebase.c`
> 
> I am not sure if I like this direction.

Blame me, not Alban. I am pretty familiar with sequencer.c, and I know
that it is way too large.

> As newbies are often very bad at coming up with APIs and naming global
> functions, keeping everything as "static" inside a single sequencer.c
> tends to avoid contaminating the global namespace.

Then I just need to make sure to suggest good names that are safe for the
global namespace, don't I?

Seeing as sequencer.c is so long already, it is own little mega namespace
anyway, so we already have to be very careful *within* sequencer.c.

Ciao,
Dscho
