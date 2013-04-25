From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/9] remote-bzr: trivial cleanups
Date: Thu, 25 Apr 2013 15:01:48 -0700
Message-ID: <7vsj2e1d83.fsf@alter.siamese.dyndns.org>
References: <1366888849-19607-1-git-send-email-felipe.contreras@gmail.com>
	<1366888849-19607-2-git-send-email-felipe.contreras@gmail.com>
	<CALkWK0meg1FgU=-4MFoFGjpDq_oa9XR_+qeiseR0J85mS71dNg@mail.gmail.com>
	<CAMP44s2nRHRFY_BRO7+x=CVKgrob78xZCpiV4Hk9sjWB_Q=vng@mail.gmail.com>
	<7vip3a2vq0.fsf@alter.siamese.dyndns.org>
	<CAMP44s1RdZ19y8v+_=gwBzq1Tg5v8+TWAYCAVR-ZzNwZ0_m_Ng@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ramkumar Ramachandra <artagnon@gmail.com>, git@vger.kernel.org,
	Christophe Simonis <christophe@kn.gl>,
	Simon Ruderich <simon@ruderich.org>, Max Horn <max@quendi.de>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Fri Apr 26 00:01:58 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UVUEn-0005mj-WE
	for gcvg-git-2@plane.gmane.org; Fri, 26 Apr 2013 00:01:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932621Ab3DYWBx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Apr 2013 18:01:53 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:48202 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932228Ab3DYWBw (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Apr 2013 18:01:52 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8CE55191DF;
	Thu, 25 Apr 2013 22:01:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=VP87PbN1jbeVQ8mveZ5jYJkaGu8=; b=SRf9K2
	/qmLrqvxObBKgeQOl2GjXpr0fsXAZKzsN/4AsqdTAmmI/w/GxUtzgeM+9V+QhQNj
	sCsmrXZ1Zmd+06+Hucca1140pzNzyGKtceZ9K/Qt9e7QIciSlOGdPdbqPNeZJKdg
	5V0qwhUM6OABn1UW02Sst2322Ch4i2SAAAY00=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=q2aWBx171LeAFsqCWjx0CB66udVUUzVn
	v1Rmxfw96aFq8Onz/RldbM/itk4hCFnCsFbKZhpS1/aEBEPjdOEfjh3rqjWmyUgL
	u2Y0848e/dzQGoa9VWkoLqiS6tWMnzHbKerLJ3mJKutoTSjXFpDYvRuZ/0VUYRN7
	Lq54M1WAJjc=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 7F819191DE;
	Thu, 25 Apr 2013 22:01:50 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id AAABA191DC;
	Thu, 25 Apr 2013 22:01:49 +0000 (UTC)
In-Reply-To: <CAMP44s1RdZ19y8v+_=gwBzq1Tg5v8+TWAYCAVR-ZzNwZ0_m_Ng@mail.gmail.com>
	(Felipe Contreras's message of "Thu, 25 Apr 2013 16:35:48 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: BACB7BC8-ADF3-11E2-BD13-BCFF4146488D-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222457>

Felipe Contreras <felipe.contreras@gmail.com> writes:

>> Three random points.
>>
>>  * For this particular patch [1/9], especially because this would
>>    land close to the corresponding remote-hg fixes (e.g. "has_key is
>>    deprecated"), I think it is sufficient to say "port fixes from
>>    corresponding remote-hg patches" (you said it in 0/9 and didn't
>>    say it in 1/9, though) without going into individual details.
>>    Anybody who wonders what these changes were about will have a
>>    clue to check contemporary patches to remote-hg that way.
>
> If there's any issues with that, just drop the patch,...
> ...
> 1) Drop this patch
> 2) Drop the whole series
> 3) I reroll without the change that was not described

Just in case you missed it, the first in the three-random-points was
"I personally think 1/9 that does not say anything about the minute
and irrelevant details Ram kibitzed about is fine".  So "Drop this
patch" is not something on the table in the first place.

 * After seeing that this change is a copy from recent remote-hg
   changes, a revier who did a little homework would easily find a
   change around has_key in recent patches.

 * A reviewer who did a little homework would know by reading a bit
   beyond the patch context to see that nobody uses "bmarks".

 * A reviewer who wondered how the two lines are different can stop
   staring at the screen, take a walk and come back with refreshed
   eyes to spot the difference between blog and blob very easily.

For these reasons, I personally do not think it is unreasonable to
throw comments like the ones on "has_key", "global bmarks", and
"blog vs blob" into "too obvious, not even deserve to be responded"
bin.

Having said that, I am more worried about wasting everybody's time
(and this includes your time) with the impedance mismatch between
you and the rest of us.

Our standard for explaining the change (either in the log or in the
comment) is to err on the descriptive side to be helpful even to
people new to the codebase.  We do not require or encourage to state
the obvious. The issue is the definition of "obviousness" varies
even among the rest of us and even for a single person depending on
how familiar that person is with the area of the code in question.
But the divide between you (alone) and the rest of us seems to be
far more vast than differences among the people other than you.

Especially the criteria I used in the above example for "bmarks"
need to be used carefully.  If a reviewer needs to follow a very
deep callchain to convince himself why a change does not break
things, it is no longer obvious and deserves to be explained.

So I dunno.  If you are not willing to change your ways and try to
be more descriptive to help others to understand what you are doing,
there is nothing I can do to help you.
