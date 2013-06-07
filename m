From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [Administrivia] On ruby and contrib/
Date: Fri, 07 Jun 2013 08:20:41 -0700
Message-ID: <7vd2ryueuu.fsf@alter.siamese.dyndns.org>
References: <7vtxld30f2.fsf@alter.siamese.dyndns.org>
	<7va9n52zjc.fsf@alter.siamese.dyndns.org>
	<rmivc5rp9w2.fsf@fnord.ir.bbn.com>
	<CAMP44s07p0vpS_2cjAjB=QWoZjjPSuAm09xwk4BjAAD+hsJrSw@mail.gmail.com>
	<alpine.DEB.2.02.1306060904100.13204@nftneq.ynat.uz>
	<CALkWK0mwxfGJdZi6kSaAPr66o550RiT_p8_r_4mDvcd_VAFYQw@mail.gmail.com>
	<alpine.DEB.2.02.1306061308100.29361@nftneq.ynat.uz>
	<CALkWK0k8m16oy7u+a8bHK93pRxfomOZDne3k0voVHLGULO+uiw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: David Lang <david@lang.hm>,
	Felipe Contreras <felipe.contreras@gmail.com>,
	Greg Troxel <gdt@ir.bbn.com>, git@vger.kernel.org,
	Jeff King <peff@peff.net>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Thomas Rast <trast@inf.ethz.ch>,
	=?utf-8?Q?Ren?= =?utf-8?Q?=C3=A9?= Scharfe 
	<rene.scharfe@lsrfire.ath.cx>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	=?utf-8?B?Tmd1ecKtbiBUaMOhaSBOZ8O3Yw==?= <pclouds@gmail.com>,
	Ramsay Jones <ramsay@ramsay1.demon.co.uk>,
	Erik Faye-Lund <kusmabite@gmail.com>,
	Johannes Sixt <j6t@kdbg.org>,
	Johannes Schindelin <johannes.schindelin@gmx.de>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jun 07 17:20:49 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UkyTA-0008HM-MT
	for gcvg-git-2@plane.gmane.org; Fri, 07 Jun 2013 17:20:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755917Ab3FGPUp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 Jun 2013 11:20:45 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:43079 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754584Ab3FGPUo (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Jun 2013 11:20:44 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6EA532591C;
	Fri,  7 Jun 2013 15:20:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=3JRfjHJW7flOcRx/oB9K3bnZets=; b=u+zQxT
	6SPHmPmhcwPA7NDlJMeJUHK8gcHK15X+ErO/loVazDf0mVC+9aMHfShc4PimEUvo
	lvPwXsRlk/PK2eKYZ4/6ZY/Na573WlThozQwn8FMm7de3PnvQP2wy32vjr5YSEcZ
	roJH+B/oj04OrLlZ9s4rLo8PAf5n5T3Hpe/ko=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=IivmbPxzFBq4li+4a3Gwk87mONWH8RJ2
	NKmkfcpKzsrhzdkA1TJCRg9jR3SgZ4ItDixYvdZXi8zhBy+4po7E1APJQCyImaqG
	nO4s+duwTzUyX1W902vyUrACuVQdHN9h4qqrJvg+nOXFn07a0+MzG0z00i0iOdoe
	zpMPcJp1nvU=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6377525919;
	Fri,  7 Jun 2013 15:20:43 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id CA43125917;
	Fri,  7 Jun 2013 15:20:42 +0000 (UTC)
In-Reply-To: <CALkWK0k8m16oy7u+a8bHK93pRxfomOZDne3k0voVHLGULO+uiw@mail.gmail.com>
	(Ramkumar Ramachandra's message of "Fri, 7 Jun 2013 19:54:28 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: D1A1A21A-CF85-11E2-BFF0-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226637>

Ramkumar Ramachandra <artagnon@gmail.com> writes:

> I think Felipe is using the argument that perl is declining to answer
> the question "why didn't you write git-related in perl instead?";
> that's it.

A question which nobody asked, I presume?

I think we heard enough from packaging folks that a new dependency
is unwelcome.  Also we heard from no regular/high-value reviewers
that they feel comfortable reviewing additions in Ruby.

So at least for now, the conclusion is to take approach #1, i.e.
somebody who finds "related" a good addition rewrites it in Perl to
promote it out of contrib/ once the design issues settle (of course
it is still a possibility that no such volunteer appears).
