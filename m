From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [BUG] Highly inconsistent diff UI
Date: Wed, 24 Apr 2013 14:27:41 -0700
Message-ID: <7vobd3aab6.fsf@alter.siamese.dyndns.org>
References: <CALkWK0n2ZZTgYxi3Fk2UxY8TXFAt1Xt3+11G98GKxbYdoMOT+Q@mail.gmail.com>
	<7va9ong9oa.fsf@alter.siamese.dyndns.org>
	<CALkWK0mVDT5ESnVJAWQ83gQnmxmGDoM_Y0nE4FGybcjcenA_KA@mail.gmail.com>
	<7v38ufer2x.fsf@alter.siamese.dyndns.org>
	<CALkWK0m5Q_e3q6Yg94-K+jU_SS7ovR2wnz-_Nr3cMz_YM=SMDQ@mail.gmail.com>
	<CALkWK0=5tE0pXj-XTe4g9LdCO78yrPNwyom5fupF1WTToY2TZw@mail.gmail.com>
	<7vtxmvbukv.fsf@alter.siamese.dyndns.org>
	<CALkWK0nmJPMJEotQ=-sSA5jXWd85mRk_Y+tbYHj1sr6ddJZsHg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 24 23:27:50 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UV7EC-0001CE-Np
	for gcvg-git-2@plane.gmane.org; Wed, 24 Apr 2013 23:27:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758113Ab3DXV1o (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Apr 2013 17:27:44 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:64805 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758030Ab3DXV1o (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Apr 2013 17:27:44 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6F28619380;
	Wed, 24 Apr 2013 21:27:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 s=sasl; bh=NdyKuUmpRxXUCH1Vngx1348OAg0=; b=B4TinXfzVKIOeIUd1OTH
	sQJhmG/xlm6i1+MHAAjbYPUurYW0R75eF9e9Ze0T6vk+CwuZb9e50Js5t88XYwub
	nImfeaN+xWHkr9fFnzbkWKThy8sShe1vis3oadB258Hwx+mFb2KvsyFKF2INAXxd
	No0r0Kl6+xszEm7meplmhZM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 q=dns; s=sasl; b=MCuV2T+EzPaJk9erYpp18qwP25RgLQbxt6Y+WbI09Cosbv
	k6sPvbey/p0nSLIJVqhr6Gf+ABUhoSD9FUPvwqfaW15XLyZCy91KSAfxfWj3i8Ci
	xEt8Fu6kpcPUjvLrl2hJglyzy1UB4wxz4xNb7hsQg7bB0Bms5XEAbnXwAZLPg=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 640BD1937F;
	Wed, 24 Apr 2013 21:27:43 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id DFE0B1937E;
	Wed, 24 Apr 2013 21:27:42 +0000 (UTC)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: CC67FA2E-AD25-11E2-8A86-BCFF4146488D-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222327>

Ramkumar Ramachandra <artagnon@gmail.com> writes:

> Junio C Hamano wrote:
>> You will stay in my killlist for the coming few days ;-).
>
> Now, now.  What is your objection, objectively?

I do not think any further explanation is necessary.

My Git time is more useful to the Git development community than
educating somebody with demonstrated lack of design taste by calling
the "log ~" that has an irregular default "beautiful".
