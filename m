From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: [PATCH] rev-list docs: clarify --topo-order description
Date: Tue, 14 Aug 2012 16:51:59 +0200
Message-ID: <87sjbpa5m8.fsf@thomas.inf.ethz.ch>
References: <7vsjbqbfhm.fsf@alter.siamese.dyndns.org>
	<877gt16ewe.fsf@thomas.inf.ethz.ch>
	<7vzk5x8s1q.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Cc: Thomas Rast <trast@student.ethz.ch>, <git@vger.kernel.org>,
	"Martin von Zweigbergk" <martin.von.zweigbergk@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Aug 14 16:52:16 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T1ITb-0006O6-CV
	for gcvg-git-2@plane.gmane.org; Tue, 14 Aug 2012 16:52:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756190Ab2HNOwE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 14 Aug 2012 10:52:04 -0400
Received: from edge10.ethz.ch ([82.130.75.186]:28047 "EHLO edge10.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756177Ab2HNOwD (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 Aug 2012 10:52:03 -0400
Received: from CAS10.d.ethz.ch (172.31.38.210) by edge10.ethz.ch
 (82.130.75.186) with Microsoft SMTP Server (TLS) id 14.2.298.4; Tue, 14 Aug
 2012 16:51:59 +0200
Received: from thomas.inf.ethz.ch.ethz.ch (129.132.153.233) by cas10.d.ethz.ch
 (172.31.38.210) with Microsoft SMTP Server (TLS) id 14.2.298.4; Tue, 14 Aug
 2012 16:51:59 +0200
In-Reply-To: <7vzk5x8s1q.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
	message of "Tue, 14 Aug 2012 07:30:25 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Originating-IP: [129.132.153.233]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/203401>

Junio C Hamano <gitster@pobox.com> writes:

> Thomas Rast <trast@student.ethz.ch> writes:
>
>> So the --topo-order switch *ensures* that we process commits in
>> topological order even in the face of skewed clocks.
>
> Yes, I *think* that I attempted to show with the illustration.

But then the new description is wrong.  It claims that children are
always before parents, which is not true in the face of clock skew.  Or
am I missing something?

>> I suspect that
>>
>>> +	their parents, but this tries to avoid showing commits on
>>> +	multiple lines of history intermixed.
>>
>> is just a fortunate side effect of the topological sort.
>
> I am not sure if it is "side effect"; I *think* it was the "primary
> objective" we added topo-order in the first place.

I won't judge that, since it's waaaay before my time :-)

-- 
Thomas Rast
trast@{inf,student}.ethz.ch
