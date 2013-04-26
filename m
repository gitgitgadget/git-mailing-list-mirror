From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/9] remote-bzr: trivial cleanups
Date: Fri, 26 Apr 2013 15:10:15 -0700
Message-ID: <7v1u9xvt88.fsf@alter.siamese.dyndns.org>
References: <1366888849-19607-1-git-send-email-felipe.contreras@gmail.com>
	<1366888849-19607-2-git-send-email-felipe.contreras@gmail.com>
	<CALkWK0meg1FgU=-4MFoFGjpDq_oa9XR_+qeiseR0J85mS71dNg@mail.gmail.com>
	<CAMP44s2nRHRFY_BRO7+x=CVKgrob78xZCpiV4Hk9sjWB_Q=vng@mail.gmail.com>
	<7vip3a2vq0.fsf@alter.siamese.dyndns.org>
	<CAMP44s1RdZ19y8v+_=gwBzq1Tg5v8+TWAYCAVR-ZzNwZ0_m_Ng@mail.gmail.com>
	<7vsj2e1d83.fsf@alter.siamese.dyndns.org>
	<CAMP44s1CTzO6J+QTDw_tmbkf-jfVxBzpfqY08_6RXrMuPr+CFw@mail.gmail.com>
	<CALkWK0ndinJPeufokYUiPeC_Hs=9WA71Xpd=K6vimJseXJsAOA@mail.gmail.com>
	<CAMP44s1MHUc_jw5EQviSYWc9phWCYD-FK_gRA-0QYNcLix098w@mail.gmail.com>
	<CALkWK0mHCNdr7+QxmmB3jTnWTe8q0_ipXD0=1bKQdpLK07gnAg@mail.gmail.com>
	<CAMP44s0r52L0_r-tQWCkLjOvV7jBghHLqMi6rh_UyChXvx6J1g@mail.gmail.com>
	<CALkWK0nkt-uytJYpyZ94YCqV8L=m7v39TxKBaKfMJivh2COEng@mail.gmail.com>
	<CAMP44s0P4K8MSsuPLCSCVzNJnioCpTJ0puD-gduuDbmRcGZGOg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ramkumar Ramachandra <artagnon@gmail.com>, git@vger.kernel.org,
	Christophe Simonis <christophe@kn.gl>,
	Simon Ruderich <simon@ruderich.org>, Max Horn <max@quendi.de>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Sat Apr 27 00:10:27 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UVqqW-0003gP-9f
	for gcvg-git-2@plane.gmane.org; Sat, 27 Apr 2013 00:10:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755874Ab3DZWKU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Apr 2013 18:10:20 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:55426 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753330Ab3DZWKT (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Apr 2013 18:10:19 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1EFED19A9E;
	Fri, 26 Apr 2013 22:10:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=aclsCotcvmUoolIl/2u4afRioe4=; b=R5Wyur
	1mi/Z5wBdMF38Zq60sCy87ZSWECC28WCedPZllXifeRO4H0JnUf6Bwz0mrZwC4Vm
	GuolYnVSKy3Jt4ACvgtuf3fOGlYPYzicl9vEv5f3RpOfydUATCQgl7opJdie4HiQ
	t0D0/eORwWvRAUH+Z6udOh3B/zDeT5+KMp7E8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=MU6RrHj25LFqgA4LaWCzLFGfvacY8KIY
	hYTWKpVXR6/A9pdor9Lo+URVKHdzjl9z1/d5S0yZ82jx+Gsl3YRUFdMvg78VQ904
	eHBTWFwNGyZzLLiGcM/n4zWH+dZtHSO4gCHYLPYfm6BwZWKiVzO9PWRyNlUjJItr
	rZKJ1KoaCDA=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 136A319A9C;
	Fri, 26 Apr 2013 22:10:18 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 6532619A97;
	Fri, 26 Apr 2013 22:10:17 +0000 (UTC)
In-Reply-To: <CAMP44s0P4K8MSsuPLCSCVzNJnioCpTJ0puD-gduuDbmRcGZGOg@mail.gmail.com>
	(Felipe Contreras's message of "Fri, 26 Apr 2013 15:23:03 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 13D4DAD2-AEBE-11E2-8304-BCFF4146488D-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222595>

Felipe Contreras <felipe.contreras@gmail.com> writes:

> Good, so I'll keep sending the patches, because our users benefit from
> the review.

Just for the record, a patch sent to the list which nobody bothered
to read does not really count as reviewed.

You can either

 (1) pace yourself when people are otherwise busy; or

 (2) send them anyway but not claim "this was sent to the list two
     weeks ago, nobody complained, so it must be perfect" when it is
     not picked up after a few weeks.

Often (1) is a better strategy, as people who wanted to review but
otherwise were busy tend to declare patch bankruptcy after their
busy period ends.

Also, a reason that a patch goes uncommented is when it is difficult
to judge.  A patch with code change without sufficient explanation
behind the motivation to justify the change, a reviewer finds it
much harder to convince himself that the patch is a good change, and
it also is much harder to find which part of the change is wrong and
offer improvements, compared to a patch with the same change that is
justified properly.
