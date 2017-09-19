Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CE09D2047F
	for <e@80x24.org>; Tue, 19 Sep 2017 15:43:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751391AbdISPnI (ORCPT <rfc822;e@80x24.org>);
        Tue, 19 Sep 2017 11:43:08 -0400
Received: from mout.gmx.net ([212.227.17.21]:52199 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751097AbdISPnH (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Sep 2017 11:43:07 -0400
Received: from virtualbox ([37.201.193.73]) by mail.gmx.com (mrgmx101
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MUUWN-1dlq7A0Yeh-00RG00; Tue, 19
 Sep 2017 17:43:03 +0200
Date:   Tue, 19 Sep 2017 17:43:02 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Junio C Hamano <gitster@pobox.com>
cc:     Lars Schneider <larsxschneider@gmail.com>, git@vger.kernel.org
Subject: Re: What's cooking in git.git (Aug 2017, #05; Tue, 22)
In-Reply-To: <xmqqbmm7s9ja.fsf@gitster.mtv.corp.google.com>
Message-ID: <alpine.DEB.2.21.1.1709191733450.219280@virtualbox>
References: <xmqq4lsz2x6r.fsf@gitster.mtv.corp.google.com> <7D99B245-4D22-4C9C-9C43-C8B8656F8E6D@gmail.com> <xmqq1so0wyjd.fsf@gitster.mtv.corp.google.com> <alpine.DEB.2.21.1.1709151816390.219280@virtualbox> <xmqqo9qbx14b.fsf@gitster.mtv.corp.google.com>
 <alpine.DEB.2.21.1.1709152214100.219280@virtualbox> <xmqq377nwtbe.fsf@gitster.mtv.corp.google.com> <alpine.DEB.2.21.1.1709181637420.219280@virtualbox> <xmqqbmm7s9ja.fsf@gitster.mtv.corp.google.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:d65PpfPGw2XERbLjUc60AiPcXu2x538wBNK3RtDZKiXPSUevnc4
 IBS7K8ideCCPIhoXz80tWflyQ+zicZDPi/78l9uDW/BrQTL4SGgiVkYgM3xQE3ac6e2ddfK
 wj98HecrT/YePcA+Ehdhom4hh4vsg5MH+DVPuOzU8bazsnhG0mamjyna/mNE3VLIg2YcOxo
 0psFJLkchp9vgQdSJFZUg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:vnQDV9rY7Tw=:7ITwi6h31XSZgjmHQH03g0
 JAsd9w+sy2oQHOua5rTdXZ6VDAFj1n04UYNtt8XMfoItIHRAucuBeeaQyv8I+3suhfqgTNMSK
 LQsF9SpyMecAUeHJ80QWdSchn0a1YRCAMocXk95K7tVQL2bMSKBZMbBvnW40uyvnwfrkCJbJI
 gGrwSzBt+RBaMFHlcZ20TJxZfiDWeW3V7Ld/p+6nC50xam+6j5PDKhqqfiZTbLrm1Dg6BsBHA
 fg5o8elmxjlGQwBeOFU3CuGV/QJVGk2IGH3nLk753CaNwC0ikBhuJVoAWEsZxyZVQg4438jWR
 zEWWeUdLhZ6AnxwXkx2wUy9LXSvwr4gl+hfFzKweHjTsRmfwpDoMTdjSQGvF5I1NdnzoE4y1g
 Yj3JVGCub24izvzSML/H+0ppRB+NzUpA7TS6ZuxckbBYbtiXfohc/PO7z0WmhY7n7PJ6D3j0w
 8ZtBM8/V5YX8bs0VB2pOAFlRtrvL1+MWrzOmkYoNEBdk0J5wo1nUsMPa4jWivSlXINg/CEWRi
 B3oiNTrBwptaZAxM2TY2IgOEcjAez9Imumy/iv0m6ygLvMQOiR7EmPRi4gFKy5bNnrjshFb/0
 ewd/qlHJIhmDdh4en/npbqHar06KsAtrvvBsPhv77/4hYmEXyGlsjc4Rf8eP7ZgrWM47v7UDW
 Ruwvr+5/R3ptNkSL6wLq/eFFRhjfK6fH3Cyy/nU6g32uOXRHi/5jplfWOHmaHpzWYkzlSyKYP
 DeHT5WRREVEa/XBKC+6cFOGxye53g6o8joWpcKfrIOngr26wTRLUeSxZU/1WKlGfVjHuc3JBO
 zy9Dn49HyIgtD4l6CPcYQ12QCMxl8drUbm68159zWzdxKX5TUM=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Tue, 19 Sep 2017, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> >> Do you have a concrete suggestion to make these individual entries
> >> more helpful for people who may want go back to the original thread
> >> in doing so?  In-reply-to: or References: fields of the "What's
> >> cooking" report would not help.  I often have the message IDs that
> >> made/helped me make these individual comments in the description;
> >> they alone would not react to mouse clicks, though.
> >
> > Oh gawd, not even more stuff piled onto the mail format. Please stop.
> > ...
> > It probably tries to serve too many purposes at the same time, and
> > thereby none.
> 
> Well, this was started as my attempt to give a public service that shows
> a summary of what is happening in the entire integration tree, as there
> was nothing like that before (and going to github.com and looking at
> 'pu' branch would not give you an easy overview).  As many people
> contribute many topics to the project, complaining that it talks about
> too many topics would not get you anywhere.
> 
> If you find "What's cooking" report not serving your needs, and if no
> one finds it not serving his or her needs, then I can stop sending these
> out, of course, but I am not getting the impression that we are at that
> point, at least not yet.

C'mon, don't *try* to misunderstand me.

Of course there need to be updates as to the state of patch series.

It's just that mails only go *so* far when you need to connect and
aggregate information. You need the connection between the original patch
series, the latest unaddressed reviews, links to the branches, history of
the patch series' iterations, and ideally links to the repositories of the
contributors with *their* branch names. And then, of course, your verdict
as to the state of the patch series and your expectation what happens
next.

To relate that, you are using a plain text format that is not well defined
and not structured, and certainly not machine-readable, for information
that is crucial for project management.

What you need is a tool to aggregate this information, to help working
with it, to manage the project, and to be updated automatically. And to
publish this information continuously, without costing you extra effort.

I understand that you started before GitHub existed, and before GitHub was
an option, the script-generated What's cooking mail was the best you could
do.

Ciao,
Dscho
