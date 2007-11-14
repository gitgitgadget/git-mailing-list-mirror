From: Sergei Organov <osv@javad.com>
Subject: Re: Cloning empty repositories, was Re: What is the idea for bare repositories?
Date: Wed, 14 Nov 2007 15:09:18 +0300
Message-ID: <87myth58r5.fsf@osv.gnss.ru>
References: <86k5on8v6p.fsf@lola.quinscape.zz>
	<20071112131927.GA1701@c3sl.ufpr.br>
	<Pine.LNX.4.64.0711121355380.4362@racer.site>
	<200711121719.54146.wielemak@science.uva.nl>
	<Pine.LNX.4.64.0711121624330.4362@racer.site>
	<vpq3avbv2ju.fsf@bauges.imag.fr>
	<Pine.LNX.4.64.0711121715090.4362@racer.site>
	<18232.35893.243300.179076@lisa.zopyra.com>
	<Pine.LNX.4.64.0711121727130.4362@racer.site>
	<vpq7iknqrtp.fsf@bauges.imag.fr>
	<Pine.LNX.4.64.0711121755460.4362@racer.site>
	<vpqy7d3pck0.fsf@bauges.imag.fr>
	<Pine.LNX.4.64.0711121804400.4362@racer.site>
	<vpqoddzpc88.fsf@bauges.imag.fr>
	<7v4pfr2kmh.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Matthieu Moy <Matthieu.Moy@imag.fr>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Bill Lear <rael@zopyra.com>,
	Jan Wielemaker <wielemak@science.uva.nl>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Nov 14 13:10:44 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IsH4p-0006ko-Rr
	for gcvg-git-2@gmane.org; Wed, 14 Nov 2007 13:10:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756102AbXKNMKZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Nov 2007 07:10:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756040AbXKNMKY
	(ORCPT <rfc822;git-outgoing>); Wed, 14 Nov 2007 07:10:24 -0500
Received: from javad.com ([216.122.176.236]:1500 "EHLO javad.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754912AbXKNMKW (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Nov 2007 07:10:22 -0500
Received: from osv ([87.236.81.130])
	by javad.com (8.11.6/8.11.0) with ESMTP id lAEC9O064928;
	Wed, 14 Nov 2007 12:09:25 GMT
	(envelope-from s.organov@javad.com)
Received: from osv by osv with local (Exim 4.63)
	(envelope-from <s.organov@javad.com>)
	id 1IsH3W-0006u9-N4; Wed, 14 Nov 2007 15:09:18 +0300
In-Reply-To: <7v4pfr2kmh.fsf@gitster.siamese.dyndns.org> (Junio C. Hamano's message of "Mon\, 12 Nov 2007 13\:56\:38 -0800")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64982>

Junio C Hamano <gitster@pobox.com> writes:
> Matthieu Moy <Matthieu.Moy@imag.fr> writes:
>
>> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
>>
>>>> > On Mon, 12 Nov 2007, Matthieu Moy wrote:
>>>> >
>>>> >> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
>>>> >> 
>>>> >> > So you need to populate the repository before starting _anyway_.
>>>> >> 
>>>> >> Last time I checked, the thread was talking about bare repository.
>>>
>>> Look at the subject.  "Cloning empty repositories."
>>
>> Look at the content. "cloning a empty bare repository".
>
> But both of Johannes's points apply equally well to an empty
> bare repository and to an empty non bare repository.  IOW,
> bareness does not matter to the suggestion Johannes gave.
>
> But you are acting as if the bareness of the target repository
> makes his point irrelevant.  I am a bit confused.
>
> About his point 1, I'd just stop at saying that "it is not so
> hard" does not mean "we do not have to make it even easier".
>
> His second point is also a real issue.  If you allowed cloning
> an empty repo (either bare or non-bare), then you and Bill can
> both clone from it, come up with an initial commit each.  Bill
> pushes his initial commit first.  Your later attempt to push
> will hopefully fail with "non fast forward", if you know better
> than forcing such a push, but then what?  You need to fetch, and
> merge (or rebase) your change on top of Bill's initial commit,
> and at that point the history you are trying to merge does not
> have any common ancestor with his history.

Just a wild idea. Doesn't it make sense to introduce perfect ultimate
common ancestor of the universe, probably calling it "the NULL commit"?
At first glance it seems that it can help to avoid corner cases
automagically.

-- 
Sergei.
