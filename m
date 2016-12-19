Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 30C531FF40
	for <e@80x24.org>; Mon, 19 Dec 2016 17:07:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933256AbcLSRGu (ORCPT <rfc822;e@80x24.org>);
        Mon, 19 Dec 2016 12:06:50 -0500
Received: from mout.gmx.net ([212.227.17.22]:49421 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932909AbcLSRGs (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Dec 2016 12:06:48 -0500
Received: from virtualbox ([37.24.141.236]) by mail.gmx.com (mrgmx103
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MNqcR-1cDEd21tU3-007RCf; Mon, 19
 Dec 2016 18:06:39 +0100
Date:   Mon, 19 Dec 2016 18:06:37 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Junio C Hamano <gitster@pobox.com>
cc:     git@vger.kernel.org, Kevin Daudt <me@ikke.info>,
        Dennis Kaarsemaker <dennis@kaarsemaker.net>
Subject: Re: [PATCH v2 09/34] sequencer (rebase -i): write an author-script
 file
In-Reply-To: <xmqqd1gtuivc.fsf@gitster.mtv.corp.google.com>
Message-ID: <alpine.DEB.2.20.1612191800530.54750@virtualbox>
References: <cover.1472633606.git.johannes.schindelin@gmx.de> <cover.1481642927.git.johannes.schindelin@gmx.de> <09c2718e119f809093794410ae1a738c1cd122d1.1481642927.git.johannes.schindelin@gmx.de> <xmqqd1gtuivc.fsf@gitster.mtv.corp.google.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:0CTlM9+w7FoPuY5d+/aHlAn+Bhew84fjwd2ThAdkqaQ83MVl0IN
 e3unYiF9YBH5aFZ8TLGCtKQALbzkaHNiOP1b/QzaS6j4xTwgM1kEnKvDD1/1SnQGZvHVOLO
 QA7Z5WIJG4mNoXHSJaQYSCa0OLHMtsf4fNz+cnsS2bW1WONAldpABV6a+DdvTzshbyP9xQU
 WSi78VThp+zhcZ6Wxh88Q==
X-UI-Out-Filterresults: notjunk:1;V01:K0:uRoPRClXPLA=:DO/cioL65eqlaAD5aw6wBo
 zT8JudI7Q+nIqfiFv0+kLh+XlK7JPow1Tc1O/M7Viup9pw6D4pJr8o1/sj48dijPyiTsoHRAM
 a4GyqBTAXr8a+MDe15VjYZQGZLTSZ6k1rLw/6BD/mBBoJBidccbEAfadI8eVK2hzbXvTjZxor
 x9e8Eqazr2MSQ9j/ynI4FIhgF0Gy2Dox5vgJrwiz697zR+5i0Vqhpu1Ui/1v/ywaVvKtPkv0g
 XdXoAs6xi5tcbMVswRiBnQ7ssC033TVmKtGAgqKM7OMtzk5i7KzveZIFM6WgAJvpLDghKWsBk
 CvyyuA15l4Ce1crOuCnm6ZPDjb8N1e9HoV5t8FQ6cdXgMfOZZOYHCY6yami1x6lwqS2IdAYRt
 WF6ABPbEWOHveJJZWHX+Fckqu4ARbj1WLBh7rya0WMLUa2EKfaOvsth/Pa27Trdldf27nx7y4
 B0qKUXQWq1OVQneMdOQ3AtA0EjB2LbOR8yvMeWIvHPs1kFyjR86WuY74Ema0rj1OfAeqf+cMd
 fE+Ra/JCnx4PIDpHiJoPecT12b5/1UXWchxW2Cu92YDzZDTpgZ4xYgxVXOUlpr00huoLv5WM2
 ZU6ceoIvwK918alEfuK7UATrpa/Gp5jjaOQHZDNYYUbk8VQYhR96XNwVkHB0tIoXU64lIYJSW
 WSTDxbFcU7DrNEvCBTFK++3eIVAn4yKZCUIpoOla6DO+6q9hR532U0zQWNelbOHfY5e8yQv7c
 sOFA+cVonm7P9zxYiNCtwPG5uSllEVBhGbOtWeHSEURkGz21khg0vLyP6UFHSg2XGx/QL3LzC
 9Jj36oS
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Thu, 15 Dec 2016, Junio C Hamano wrote:

> Johannes Schindelin <johannes.schindelin@gmx.de> writes:
> 
> > +	strbuf_addstr(&buf, "GIT_AUTHOR_NAME='");
> > +	while (*message && *message != '\n' && *message != '\r')
> > +		if (skip_prefix(message, " <", &message))
> > +			break;
> > +		else if (*message != '\'')
> > +			strbuf_addch(&buf, *(message++));
> > +		else
> > +			strbuf_addf(&buf, "'\\\\%c'", *(message++));
> > +	strbuf_addstr(&buf, "'\nGIT_AUTHOR_EMAIL='");
> > +	while (*message && *message != '\n' && *message != '\r')
> > +		if (skip_prefix(message, "> ", &message))
> > +			break;
> > +		else if (*message != '\'')
> > +			strbuf_addch(&buf, *(message++));
> > +		else
> > +			strbuf_addf(&buf, "'\\\\%c'", *(message++));
> 
> Aren't these reading from an in-core commit object?  
> 
> If so, it should use split_ident_line() for consistency with other
> parts of the system to do this parsing.  We should also already have
> a helper for simple shell-quoting in quote.c and you would want to
> use that instead of open coding like this.

We keep coming back to the same argument. You want this quoting/dequoting
to be turned into a full-fledged parser. And I keep pointing out that the
code here does not *need* to parse but only construct an environment
block.

Hopefully the next iteration that integrates Peff's suggestions will find
more of your approval.

Ciao,
Dscho
