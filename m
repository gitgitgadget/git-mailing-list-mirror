Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6ABCB205C9
	for <e@80x24.org>; Mon,  2 Jan 2017 14:51:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751523AbdABOvU (ORCPT <rfc822;e@80x24.org>);
        Mon, 2 Jan 2017 09:51:20 -0500
Received: from mout.gmx.net ([212.227.17.22]:51869 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750875AbdABOvT (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 2 Jan 2017 09:51:19 -0500
Received: from virtualbox ([37.24.141.236]) by mail.gmx.com (mrgmx103
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0LtJ5T-1cUPpY10zj-012tPa; Mon, 02
 Jan 2017 15:51:07 +0100
Date:   Mon, 2 Jan 2017 15:51:04 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Junio C Hamano <gitster@pobox.com>
cc:     git@vger.kernel.org, Kevin Daudt <me@ikke.info>,
        Dennis Kaarsemaker <dennis@kaarsemaker.net>
Subject: Re: [PATCH v2 20/34] sequencer (rebase -i): copy commit notes at
 end
In-Reply-To: <xmqqvaujr7ed.fsf@gitster.mtv.corp.google.com>
Message-ID: <alpine.DEB.2.20.1701021545450.3469@virtualbox>
References: <cover.1472633606.git.johannes.schindelin@gmx.de> <cover.1481642927.git.johannes.schindelin@gmx.de> <a2ea8bd57461fe0969f3df09a0374005f12ac6c7.1481642927.git.johannes.schindelin@gmx.de> <xmqqvaujr7ed.fsf@gitster.mtv.corp.google.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:50OLj88Mdfm6j8cZsCYlGlw01P/R5GC/d+Uec9R9941iToP1x2b
 qH5docDM++pn2j/39FvUBbMISAPUuB4EPg5rS1W3WZ5tdvIdPYBeYWMEjLypbIMP0JYZidw
 IQHVZGJwlynqBazuWj43PeYwck6Q4EqP7+xHq01sQaELjAa4+7gbMtWrPDAonSVew6e8kQU
 nmcH4lD2GtmZzznV7J4+A==
X-UI-Out-Filterresults: notjunk:1;V01:K0:oyGlSTQy02s=:tGyX0Mmy72GqaiY61yi+RY
 OqPvSKxb9gfhI5PsMX6587KLWOnX+JuNmPEwFRagmQI2l60DsU6LHesf2D2q4cVRHy1myK+31
 OdIPHaQ6dQu+Db+axeNvDrAF55In8qC1qUCCBd5yawda/2LMSfAAvV+xL+UGLxCIE9FbqAvmv
 wKoo/sFUOdDk3H4tSCVDF65uWuqdK3TzOfgfUEl6qZ52zt/PfvdLR/M62WZdEJAxBYxNb7XfX
 5JFyHvWBYapblHfg2OHOe1im7lwHLTdIOAGFtyA1S0nWmCnSFNrnzceWQbgnwN1a7EQhc5yc2
 XQwZRMq2YAYa+NVonln/tAKHvtLlXRDiWJNZt+TNwC2Pu/gklE4FpGY7EpqFswU0Qn1Waolxh
 QrMAcxUC6rjb7PvOeT7d95w5n122UMq3t49Snrdz1tU/5qyQnGNPbTbB8LWXHHq25Dy/wAuDf
 2CL1oA5hghEXCVdFifnuDI7eDT+p3ls55fZn/ThffnlRUThc15adQIGJSg9x5vVMWxHfJuaOL
 K2oeYMtw3MQhYFsuro2roc+b5iRO9249s3tFjwrVtS10elsv/u5Vx0LdEJL7aETv3V8Nt73ty
 RE9bXFckDK7CmTo26pUE8inNE5Pe3YzPaO7iSSrcMKmJMPH961y7RBzWi9bpZ1yGLGWfwKxeb
 ifPXeYZADFDvlc+JcHbGufXVmt2xCgpurAjHBQswfpC4uXkVVVlYIiTzb2Nm09iy4kJ0GrUxJ
 e1GzwtSG1Sf8q7Y5qIbkwl63kgZzCPjl6pAXg741ouwQK98xfEx6pBdE6kH2Btx0Pl+/o9raW
 meSnCW3doDlLK1lYbB8GMCHRP29luxXPlP/eAkvKEPgPz2dqHITX4as1uZgc6akF09+D7jqH0
 G1cIXlnTGiyb5x+mSnlDBRkK4oMkwPWmiQzBSBUGf8a0Vlb4fOdBoerIODqA0UqHi3T7w9qL3
 oWD26bnLDAdAWYyBYhjgD9GTDaGUxomdcoh+D49QUTr0mGKUGEjZNAf7Jz65I0zUdNNot59/n
 Fxg5isTJg+OF+rU8ylUFse4=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Fri, 16 Dec 2016, Junio C Hamano wrote:

> Johannes Schindelin <johannes.schindelin@gmx.de> writes:
> 
> > @@ -1750,6 +1797,17 @@ static int is_final_fixup(struct todo_list *todo_list)
> >  	return 1;
> >  }
> >  
> > +static enum todo_command peek_command(struct todo_list *todo_list, int offset)
> > +{
> > +	int i;
> > +
> > +	for (i = todo_list->current + offset; i < todo_list->nr; i++)
> > +		if (todo_list->items[i].command != TODO_NOOP)
> > +			return todo_list->items[i].command;
> 
> Makes me wonder, after having commented on 07/34 regarding the fact
> that in the end you would end up having three variants of no-op
> (i.e. NOOP, DROP and COMMENT), what definition of a "command" this
> function uses to return its result, when asked to "peek".

Well, it uses the todo_command idea of a "command"... ;-)

The only thing we do with this for now is to look whether the next command
is a fixup/squash (so that the user gets to edit the commit message just
once, for example, and also to record rewritten commits properly).

> I suspect that this will be updated in a later patch to do "< TODO_NOOP"
> instead?

Actually, no. I introduced a new function is_noop() and that is used now.

Ciao,
Dscho
