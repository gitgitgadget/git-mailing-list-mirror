From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v4 1/2] merge-file: let conflict markers match end-of-line
 style of the context
Date: Wed, 27 Jan 2016 08:58:59 +0100 (CET)
Message-ID: <alpine.DEB.2.20.1601270856150.2964@virtualbox>
References: <cover.1453709205.git.johannes.schindelin@gmx.de> <cover.1453819314.git.johannes.schindelin@gmx.de> <13379804ad901b53d78d741156677664924fc50d.1453819314.git.johannes.schindelin@gmx.de> <xmqqoac8ci8o.fsf@gitster.mtv.corp.google.com>
 <xmqqsi1kavr2.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: git@vger.kernel.org, Beat Bolli <dev+git@drbeat.li>,
	Jeff King <peff@peff.org>,
	Eric Sunshine <sunshine@sunshineco.com>,
	=?ISO-8859-15?Q?Torsten_B=F6gershausen?= <tboegi@web.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jan 27 08:59:27 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aOL0b-0007qk-F9
	for gcvg-git-2@plane.gmane.org; Wed, 27 Jan 2016 08:59:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753941AbcA0H7O (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Jan 2016 02:59:14 -0500
Received: from mout.gmx.net ([212.227.15.15]:61080 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753580AbcA0H7K (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Jan 2016 02:59:10 -0500
Received: from virtualbox ([37.24.143.74]) by mail.gmx.com (mrgmx002) with
 ESMTPSA (Nemesis) id 0M6AbC-1a9X7H1vKc-00yARV; Wed, 27 Jan 2016 08:59:01
 +0100
X-X-Sender: virtualbox@virtualbox
In-Reply-To: <xmqqsi1kavr2.fsf@gitster.mtv.corp.google.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
X-Provags-ID: V03:K0:Iq8m5KkARzHf7sGyTdbwhQf3s4IpGTYYUfBxL/J+on6xq6XNq0s
 V7ckyQaSlZdfhu/l70+axo+vaKOfbE947Y0KV5jJisyuscx5I+IcwXn9oyYH3yZyaegoTpm
 M/CmCOnMadMaLiZQmF8g72TFnZiurbo5+vgrqg/uCGvpnEn3F0EsbuDxEoOuYKoyFtyQsXw
 Jp3HuwNa/I6q0Q/lGveXg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:bwaID5RDPCw=:+ht9p7fnL52KXwnsn5AZwy
 n/LgvyQMf/1Uq+3GqfF+r+qAdC8F6dCIA+oYM0RZ8zJHJ0TtFV2OyOBtbL6e5ndKPRGR15LNL
 RaQzl/bSHYY+l0qySBp1wgAlX8GWKjXDTL1ax6Bu+52PcKLhGGwbNVNfX/S5i3W+OwaaUsNa8
 iH7mTiOAFo1xOJ5W/997sqxzsYdhCme5EIZ+rmydsEgdxJsVycuaCJ29SGxp9/mGxgutfr51w
 5DZwTcmXWs+Ed2+wOlIVilkXA1IMkyc8SXbHy5Mj5Y9CfXVLiuog+K/VOmJFV766ynQd26nbr
 xP6uNUid1MlcasQlx2MrNBLl83xzn5SGtZYIV3se92zRAM+vHfgtUqceJBw58+rc+GNxR69uq
 lyuUtlTSFxSV2uP8WFDuonHH3P4KF40ZRg7GbJnylqSV6d8W5603PYj/PfcrHmfEQwLh2R6sW
 pyvumzU+CziMLESALLLn/Gdtp6UTa0374vQrj+oj5OOkQPZgtuDkBRuiEqvdpMyR+C2OeJYpv
 JSty9ER8rlSrGTKkVGobd6GLxYBkCDsT5Asc734a0s8Iz0fN4renn4bEeG48eaFBKoyaxPhjC
 9+hYGWV37lhEMPzxLAaIUqOAhfoZqB7G67u0F3VhaGhPko1py4vtbkW9Z+MZvPZRbIpO3t2Fl
 G1cM+YBsQZESi+x3rAtc3T3bwOpt7MsQyeG7BDLYOEDkhP/91u3+mM221rnw0nn4TNiQOvEMC
 ob1OluKGeivdleFN+0eI1U7drEsGVj3A6SQhuJrWIVWSYzgFqBrUtUHgjZl1Q4mhwmRM+zW/ 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284892>

Hi Junio,

On Tue, 26 Jan 2016, Junio C Hamano wrote:

> Junio C Hamano <gitster@pobox.com> writes:
> 
> > Johannes Schindelin <johannes.schindelin@gmx.de> writes:
> >
> >> +static int is_cr_needed(xdfenv_t *xe1, xdfenv_t *xe2, xdmerge_t *m)
> >> +{
> >> +	int needs_cr;
> >> +
> >> +	/* Match post-images' preceding, or first, lines' end-of-line style */
> >> +	needs_cr = is_eol_crlf(&xe1->xdf2, m->i1 ? m->i1 - 1 : 0);
> >> +	if (needs_cr)
> >> +		needs_cr = is_eol_crlf(&xe2->xdf2, m->i2 ? m->i2 - 1 : 0);
> >> +	/* Look at pre-image's first line, unless we already settled on LF */
> >> +	if (needs_cr)
> >> +		needs_cr = is_eol_crlf(&xe1->xdf1, 0);
> >> +	/* If still undecided, use LF-only */
> >> +	return needs_cr < 0 ? 0 : needs_cr;
> >> +}
> >
> > Retrying with other images when needs_cr is either -1 (unknown) or 1
> > (known to be true) was tricky; I had to read it twice and think
> > about it for 30 seconds before convincing myself that the code does
> > what the log message specifies it should.
> >
> > That is probably because I was thinking in terms of "do we know that
> > we need to add a CR?"; if I read "needs_cr" in my head as "we might
> > want to add a CR", everything becomes much more clear, but perhaps
> > it is just me.
> >
> > The return value of this function is definitely "do we need and want
> > to add a CR", and it is appropriately named.
> >
> > Thanks.
> 
> Just in case it was unclear, none of the comment above means I want
> any part of the patch redone--I am happy with this patch as-is.

Thanks for saying that... I was about to try to make things clearer, but I
could not think of a better term than "needs_cr". The existing code
already has "add_nl" (which means: add a newline *iff* the block to be
copied does not yet have a newline), which I also found confusing.

Oh wait, maybe "eol_is_crlf" instead of "needs_cr"?

Ciao,
Dscho
