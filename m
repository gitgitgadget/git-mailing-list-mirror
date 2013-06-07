From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [Administrivia] On ruby and contrib/
Date: Fri, 07 Jun 2013 12:55:47 -0700
Message-ID: <7vsj0tsnjw.fsf@alter.siamese.dyndns.org>
References: <7vtxld30f2.fsf@alter.siamese.dyndns.org>
	<7va9n52zjc.fsf@alter.siamese.dyndns.org>
	<rmivc5rp9w2.fsf@fnord.ir.bbn.com>
	<CAMP44s07p0vpS_2cjAjB=QWoZjjPSuAm09xwk4BjAAD+hsJrSw@mail.gmail.com>
	<alpine.DEB.2.02.1306060904100.13204@nftneq.ynat.uz>
	<CALkWK0mwxfGJdZi6kSaAPr66o550RiT_p8_r_4mDvcd_VAFYQw@mail.gmail.com>
	<alpine.DEB.2.02.1306061308100.29361@nftneq.ynat.uz>
	<CALkWK0k8m16oy7u+a8bHK93pRxfomOZDne3k0voVHLGULO+uiw@mail.gmail.com>
	<7vd2ryueuu.fsf@alter.siamese.dyndns.org>
	<CAMP44s2f2RBGd0VwJaSB1FkHBXRGhrTs_sA80kcinmpzJX8UDg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ramkumar Ramachandra <artagnon@gmail.com>,
	David Lang <david@lang.hm>, Greg Troxel <gdt@ir.bbn.com>,
	git@vger.kernel.org, Jeff King <peff@peff.net>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Thomas Rast <trast@inf.ethz.ch>,
	=?utf-8?Q?Ren=C3=A9?= Scharfe <rene.scharfe@lsrfire.ath.cx>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	=?utf-8?B?Tmd1ecKtbiBUaMOh?= =?utf-8?B?aSBOZ8O3Yw==?= 
	<pclouds@gmail.com>, Ramsay Jones <ramsay@ramsay1.demon.co.uk>,
	Erik Faye-Lund <kusmabite@gmail.com>,
	Johannes Sixt <j6t@kdbg.org>,
	Johannes Schindelin <johannes.schindelin@gmx.de>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jun 07 21:55:55 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ul2lO-0005a0-Cc
	for gcvg-git-2@plane.gmane.org; Fri, 07 Jun 2013 21:55:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755760Ab3FGTzu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 Jun 2013 15:55:50 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:53444 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753956Ab3FGTzt (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Jun 2013 15:55:49 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5A975266DD;
	Fri,  7 Jun 2013 19:55:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=MY76wmLKsCPVGwVtmp1ivLbXKyw=; b=IPDdXB
	AvZqDahrZBt7NuuwFQWJFub8GWjDL7I4npB/7OjNoKj/30o5ZtTX32rn1APzpdrv
	ansWUFvU7pX/GP6PCTf2LjTgLXPXUC1LszNYC19ikEtgjkaUkOMQSSswhCYFfjur
	qfizx0BZUl7LcHD58w++m4ruCn0ssAr1m2wH4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=rQfO5IyYykXvquIwZ4CXPKuS5EB0cXkd
	0ptmPqXsZhZLp17U+CA0abVBajd5Ffc8Lzh1Xt9fkA/Z4BU+YfUBTI3OWeR1unl0
	4Uc0TNKC0QNBC9ZAUFDSwoPnKngtn03UCuaARFzLaOoydHP8XQ7nfNwxg6aOEiJT
	BfqVT7uMFIc=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4CB7E266DB;
	Fri,  7 Jun 2013 19:55:49 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id BA375266DA;
	Fri,  7 Jun 2013 19:55:48 +0000 (UTC)
In-Reply-To: <CAMP44s2f2RBGd0VwJaSB1FkHBXRGhrTs_sA80kcinmpzJX8UDg@mail.gmail.com>
	(Felipe Contreras's message of "Fri, 7 Jun 2013 14:04:11 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 3FF0060A-CFAC-11E2-A3B5-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226691>

Felipe Contreras <felipe.contreras@gmail.com> writes:

>> I think we heard enough from packaging folks that a new dependency
>> is unwelcome.
>
> What are you talking about? Which are these "packaging folks" we heard from?

Dscho is one of the primary people behind msysgit effort, and I
consulted with others from the circle with an draft before I sent
the message to the list for sanity checking (fearing that I may be
worrying about adding new dependencies needlessly).  Jonathan
packages git for Debian and he is negative on adding new dependency
needlessly. It was unexpected that we hear from a pkgsrc person but
the response was also negative.

>> Also we heard from no regular/high-value reviewers
>> that they feel comfortable reviewing additions in Ruby.
>
> Correction; *current* regular/high-value reviewers.

That is exactly what I meant.

The code review is not only about following best practices in the
implementation language.  If somebody who is an expert in a language
we do not currently depend on, but who does not know how the parts
of Git are supposed to fit together enough to judge the soundness of
the design of new code written in that new language, or does not
know how the tests, documentation and log messages are supposed to
written around here, that person cannot be the only reviewer for
changes written in that language to ensure quality standard.

The reviewer pool for code written in a new language _must_ be
seeded by some from the current set of reviewers whose judgement
I/we can trust.
