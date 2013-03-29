From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Git and GSoC 2013
Date: Thu, 28 Mar 2013 21:57:28 -0700
Message-ID: <7vd2uirefb.fsf@alter.siamese.dyndns.org>
References: <20130327183410.GA26066@sigill.intra.peff.net>
 <20130327185248.GE28148@google.com>
 <CAP8UFD1CjfJ8wM-htX8SOOveAt8zQ+qBRk_P016Y57jWnt6sCw@mail.gmail.com>
 <7vtxnvv5gx.fsf@alter.siamese.dyndns.org>
 <CAP8UFD2jPSpAQQJC1sUtd5ztnMB=kou36HZUaoPOG4ht-Sj8wg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jonathan Nieder <jrnieder@gmail.com>, Jeff King <peff@peff.net>,
	git@vger.kernel.org
To: Christian Couder <christian.couder@gmail.com>
X-From: git-owner@vger.kernel.org Fri Mar 29 05:58:13 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ULROD-0006lH-3r
	for gcvg-git-2@plane.gmane.org; Fri, 29 Mar 2013 05:58:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751886Ab3C2E5k (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 Mar 2013 00:57:40 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:38020 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751542Ab3C2E5k (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Mar 2013 00:57:40 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4C64AECC1;
	Fri, 29 Mar 2013 04:57:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=fkztZF5SdiZ7/a9Hq5Hm0Wb50Xk=; b=ZWXHtE
	sIoZXsTQF2kh+8UYhL3kdobKbfMmxj66V+IL0/hr55vama5EeG4W93xyYRUh2snP
	+T6YapB2p+qN1TT0CVYVIQKEQ/A0eqie8R9AjOnotaBJOOFPERxDQy3kmDXexxlE
	oq7/t3IxN357LSdnNKj0eTd0YouxngTrOxJyc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=WZrWPBLvMqa0NIqNTCVbKZ7n2wbRmB54
	DiqMgE9vWW6uhE7pC5l+Xpr/pbFjBo2brDJqkdgQv2lGSRxDWIutmf9oAjsSqdVJ
	pMbkVQLWzuD7Aom2a26sn4njVTvqYM/ygwwwtlIijuALdxiAf09CVNybXHS+n42x
	IK/iKtdp/xI=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 444C7ECC0;
	Fri, 29 Mar 2013 04:57:39 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id BAACCECBD; Fri, 29 Mar 2013
 04:57:38 +0000 (UTC)
In-Reply-To: <CAP8UFD2jPSpAQQJC1sUtd5ztnMB=kou36HZUaoPOG4ht-Sj8wg@mail.gmail.com>
 (Christian Couder's message of "Thu, 28 Mar 2013 21:39:23 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 2E078FD2-982D-11E2-8057-8341C8FBB9E7-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219482>

Christian Couder <christian.couder@gmail.com> writes:

> On Thu, Mar 28, 2013 at 5:45 PM, Junio C Hamano <gitster@pobox.com> wrote:
>
>> What I gathered from the discussion so far is that everybody agrees
>> that our mentoring has been suboptimal in various ways (not enough
>> encouragement to engage with the community early, working in the
>> cave for too long, biting too much to chew etc.).  What makes you
>> think we would do better this year?
>
> The fact that we will be more conscious that we need smaller projects
> and that we need to push even more for students to send their patch
> soon on the mailing list.
>
> If it doesn't work at all we will be set and we will know that there
> is not much we can do to make it work.

That sounds like doing the same thing over and over again to me.

I just looked at the "ideas" page Thomas sent the link to upthread
this morning, but I didn't see any evidence that it has been been
curated with "we need smaller projects" in mind.

We will be more conscious?  I cannot take that promise at face value
after seeing that the page stayed the same since Thomas resurrected
it from last year's ideas page ever since it was created.

> If we don't even try we will not know soon, so not be able to improve
> or decide to stop.
>
> It's like software or science. If you don't test soon your hypothesis
> you don't progress fast.

The impression I am getting is that the concensus is that we do not
even have hypothesis worth testing with a grant money from GSoC and
students' time at this point, if I may borrow your science analogy.
