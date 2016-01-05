From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] commit: ensure correct permissions of the commit
 message
Date: Tue, 5 Jan 2016 13:52:06 +0100 (CET)
Message-ID: <alpine.DEB.2.20.1601051342050.14434@virtualbox>
References: <4aa11f02f4de113bf38152b8815658da42690f43.1450549280.git.johannes.schindelin@gmx.de> <20151220074559.GF30662@sigill.intra.peff.net> <xmqq7fk8io3f.fsf@gitster.mtv.corp.google.com> <20151221065944.GA3550@sigill.intra.peff.net>
 <xmqqio3rhg2f.fsf@gitster.mtv.corp.google.com> <alpine.DEB.2.20.1512301535550.14434@virtualbox> <xmqqfuyjczpv.fsf@gitster.mtv.corp.google.com> <alpine.DEB.2.20.1601011604070.14434@virtualbox> <xmqq60z9p51f.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org,
	Yaroslav Halchenko <yoh@onerussian.com>,
	=?ISO-8859-15?Q?SZEDER_G=E1bor?= <szeder@ira.uka.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jan 05 13:52:43 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aGR6P-0007bA-4E
	for gcvg-git-2@plane.gmane.org; Tue, 05 Jan 2016 13:52:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751862AbcAEMwi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 5 Jan 2016 07:52:38 -0500
Received: from mout.gmx.net ([212.227.17.22]:59061 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751472AbcAEMwg (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Jan 2016 07:52:36 -0500
Received: from virtualbox ([37.24.143.74]) by mail.gmx.com (mrgmx103) with
 ESMTPSA (Nemesis) id 0Md31i-1aXYVP0hZS-00IEYo; Tue, 05 Jan 2016 13:52:09
 +0100
X-X-Sender: virtualbox@virtualbox
In-Reply-To: <xmqq60z9p51f.fsf@gitster.mtv.corp.google.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
X-Provags-ID: V03:K0:UxmcwtVlILvxwR9zmVI60l+5SvCWtchm3+sDx3M3OROf/4F5TlA
 ieBxvIuqWKDGFu44H9M5uTWWNc3qjs1Ia3My4zwkn+OSG0kiRPbwjcG5kTL+7aq+SoAwY59
 43SXWMNG7Dp0afsLFxpbzxAyRp/kojs3E//Nxj/ZmhiFZwZVqUxnFjheu2+6zAD67+Dcy7Z
 rv+4FoVBFLNybLnXBSGZQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:Ys+j1K4mGFM=:Jfn93/G0wU3HXe1euCyUkD
 nCSFdeAytcZVyU6q6J61SB+ZUAXp0mpbVItaq8HGWBA7O1Mdo+1FTh23QchD3wFtQc7LOXoec
 jNPn+k/DOZ8weRCwFnWaigcK1PBiwdUeSYlHXOlR9K+P9pQ+IZY1KUsd7r04ylG2YDXxuO4Kw
 pqbJ7znUmjCwROFEdzxEODbZuLHoBtngVYMCoO13kNF2uP/QTCZydG+1X11Yr0lvJDzsc6i4x
 eoOoUnluF3eZMei6Dydyovqjg+27Yl/8k7jJRN6cWD7tmdyrz44qMIdRpjFiBsLlwREQnhx1R
 Dw/nPViPHqRvCSNjYdAMj8XG2mA/aJvJWhA6FIFo+GLIq3sXMm1hN5mKr69+3YjJx1nSRTnOg
 Z+gO7bG/RqpqpWhtoeDRqLUo5hk1TBsa6SpMWEzyQGwhBXuRKo4yXVnF6DVV6GRdfswPxfgkM
 yZnMqp7+oiCHc1unXUSNK62E8y0Q1hi+XzltheG5IgTVNIsVfCvpOGXAbzY36AxsjxJcgyVef
 tMQUHChm0QIxoR8A400S46HOzVJaSistGYSddNsfOgnBbTGXCtRFrL6jK5sntJQSb9i2/a+Gq
 ts84wP05Nub25kFeungG1nEvuZ44Xap1pFKBXFlnC2uP3+Xg/0a69bKmRU7fbHm4w2SOMsNLb
 yqryNUczTem4xsnDrrjiLzt+4Uom4DVebxscDvXjWuAQN/MkrRpIxMXYl2JMeKSWfIzzCEPgB
 jqQHd8AUWrawGYJcqydKmG1HCxcg4AT/4HNopKNJf7hLdTskrwoKDbqey9Lqasys7WD/KCLG 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283374>

Hi Junio,

On Mon, 4 Jan 2016, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> >> I do not know fcreate_or_truncate() is a good name, though.
> >
> > So what would be a good name?
> 
> Have been thinking about it, but I did not come up with anything.  I
> just know fcreate_or_truncate() is not a good name for multiple
> reasons I already explained X-<.  sane_fopen_for_writing() perhaps?

That implies that fopen() is insane, though ;-) Let's just drop the sane_
prefix?

Ciao,
Dscho
