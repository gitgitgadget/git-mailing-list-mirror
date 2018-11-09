Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1938B1F453
	for <e@80x24.org>; Fri,  9 Nov 2018 12:02:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728085AbeKIVmo (ORCPT <rfc822;e@80x24.org>);
        Fri, 9 Nov 2018 16:42:44 -0500
Received: from mout.gmx.net ([212.227.15.19]:54495 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727662AbeKIVmo (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Nov 2018 16:42:44 -0500
Received: from [192.168.0.129] ([37.201.193.149]) by mail.gmx.com (mrgmx003
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0MU1MP-1fuJHH1sll-00QiDh; Fri, 09
 Nov 2018 13:02:18 +0100
Date:   Fri, 9 Nov 2018 13:02:17 +0100 (STD)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     phillip.wood@dunelm.org.uk
cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: What's cooking in git.git (Nov 2018, #03; Wed, 7)
In-Reply-To: <96d474cf-dc40-fa40-94ae-3883e63a3cb0@talktalk.net>
Message-ID: <nycvar.QRO.7.76.6.1811091300580.39@tvgsbejvaqbjf.bet>
References: <xmqqy3a5b4x2.fsf@gitster-ct.c.googlers.com> <96d474cf-dc40-fa40-94ae-3883e63a3cb0@talktalk.net>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:N+EaLnEAwMqB1l90hYaevjcwoKqHVXSKQ6JMXe50C4sO/EGUIxZ
 fr0UTEdCO5pxmOOgilUnrsn7QMQLkmSVcsAB5GgtNHtcfb8MD6VJWrVuRVqagmOk6ZcPZwi
 Ug4prkYmVwiQ5g2fizO/4RhjFZxA9KGuihjTJP7OZyC+X63PA/bycdGFie+Y4ucZKVaS4Gm
 tallfBFADmkqKQ1zqXD+Q==
X-UI-Out-Filterresults: notjunk:1;V01:K0:LYhfiJiuRzg=:9O7LFfGORBB5ULRzpTfzBw
 sKOr/gjtZxkFQ88zeu3wukc/3+v6ZSo2AFUklh/wEX2ikzrmd4CQtxeRABK1EN53h0bxMo1kJ
 Vm6IQDXbNUi85/jrcu7wGdL0XS7mF1L+0/KRTr70jiEr5uMujQS16hHyAXJJerm6meZwdRJWY
 yvqPesX4ZpMKjMco4UGcOqkIw2DB9cu5sV93foxlxGUfrlTZurA3OP1WlYtIwlfEP+O3Q0oF9
 GJD7dfM3V159W1GQxb4tKVFniJYtA5mYcm5mQH+y+hSVzYCLbxgGL8PdrXgpfoqLROSHJ0GXE
 X1XGEeNu9XoMEFAqIgdPG/oRVb4Jaqws5ZATsV/Fi3+YSypiQ/+x9/C0YMCyxRFEsBrSjw8+r
 fHpWIwRdI4K0miqVCoqfkDEzdSi5jZyT/r1CPjZS/bD2pjpxhRjknvYzGpbFKu04R93rP/PFO
 F00Vn+Zu14mDDY1OUu8Ptixrgf2MWNYu8TN6dNWyNC10tPiVkfQ7L0L6lAg1ZhQC4hjs1qL5V
 gdiFvVIVAkoEIBQhy7OU2BXqWXX7hxHksUZuedAygtcxXIgiuHb03aww96YusImnNWEJrmpmM
 ZBoqNm74GZbRd5+K1LuQ8JX9cD/V2/mRwn69a1ZxGiHbb0+C7th+PDDo8eClDKHGkLolE9Gg8
 japeH5dS76rf6llmWfHZcta1HdagunUzjAeC82OUCMqtwhPJWxXovYXaGoYJf/Upekk+NLTc0
 QMIB7FRExqav5rvjXnEqNC7rYqvB6nLZZjCQB5Ey+AcO9cJpYB33YHQpomfhm878fpLbkhuqZ
 SQ/dqJr/hkkVLA2Vqc+3/iaM/VuNzM1P3y0HnEG/UhYvHmPlltI8mZ2/p1TTLxK6B+xFwqAoL
 m/0oFJYpFDuNxo7GqZZXrYc9DmrI6KriEhkQ4SFFs2MzVWgHm/DifnoFtLEmVZB6ilGjt317J
 6NB6SJJPWcw==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Phillip,

On Thu, 8 Nov 2018, Phillip Wood wrote:

> On 07/11/2018 09:41, Junio C Hamano wrote:
> > Here are the topics that have been cooking.  Commits prefixed with
> > '-' are only in 'pu' (proposed updates) while commits prefixed with
> > '+' are in 'next'.  The ones marked with '.' do not appear in any of
> > the integration branches, but I am still holding onto them.
> > 
> > You can find the changes described here in the integration branches
> > of the repositories listed at
> > 
> >      http://git-blame.blogspot.com/p/git-public-repositories.html
> > 
> > --------------------------------------------------
> > 
> > * pw/add-p-select (2018-07-26) 4 commits
> >   - add -p: optimize line selection for short hunks
> >   - add -p: allow line selection to be inverted
> >   - add -p: select modified lines correctly
> >   - add -p: select individual hunk lines
> > 
> >   "git add -p" interactive interface learned to let users choose
> >   individual added/removed lines to be used in the operation, instead
> >   of accepting or rejecting a whole hunk.
> > 
> >   Will discard.
> >   No further feedbacks on the topic for quite some time.
> 
> Unfortunately I've not found time to work on this recently and don't see
> myself doing so before the new year so I think it makes sense to drop it.
> Hopefully I can come up with something next year, it would be nice for users
> to avoid having to edit patches where possible.

If I understand correctly, this patch series essentially imitates on the
console what you can do in Git GUI by selecting multiple lines in the diff
and then "Stage Selected Lines"?

If my understanding is correct, then yes, I would be very much in favor of
having this feature, too.

Thanks,
Dscho
