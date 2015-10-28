From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] format-patch: introduce format.outputDirectory configuration
Date: Wed, 28 Oct 2015 10:59:43 -0700
Message-ID: <xmqqziz2kh68.fsf@gitster.mtv.corp.google.com>
References: <1434738519-28093-1-git-send-email-kuleshovmail@gmail.com>
	<CAPig+cTOG7QP25TyJbbm70NBXN6Z0nZPJyjxFp1y147WQmKEDg@mail.gmail.com>
	<xmqqk2rj8kf5.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Git List <git@vger.kernel.org>
To: Alexander Kuleshov <kuleshovmail@gmail.com>
X-From: git-owner@vger.kernel.org Wed Oct 28 18:59:57 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZrV0r-0003Vz-70
	for gcvg-git-2@plane.gmane.org; Wed, 28 Oct 2015 18:59:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756011AbbJ1R7r (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Oct 2015 13:59:47 -0400
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:53155 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755963AbbJ1R7q (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Oct 2015 13:59:46 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 273CF2380D;
	Wed, 28 Oct 2015 13:59:45 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=+Lfy28fR7M3bBEZu/dZlGUPWuOo=; b=OUHHHD
	jMhTbJ0R5NuOGEuGXczc9/u5h4UwqA0ag2mI8o59ixuTybKI7k5lXAU2I+QCRS5F
	1Dw1ArHFUseeAyQYGUBcX2v+7S0mOIIXbu1NhPpwWXo9jKsOvaXITd3nRjOfXguq
	EjbGLmKsgVJyfT88pPPOQtr+7S1npLQDKJ2dE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Pn/N5qAg/mdYC4/7x2Rx7hrf8dqcLlf1
	uVsAxaPWHY5POGJtFjMRIgJYaBp0QLs/7ohcgJ+dhuBHrCf4Msgoni1iwiitzCH5
	/3fAMFjFFaGUsAy6d5M/dkIvN5f71mcPoTdL1zCkvziFRkg0X+/Nb8vQ7vzfP1s9
	DtZsHWvC8JY=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 1E8C32380B;
	Wed, 28 Oct 2015 13:59:45 -0400 (EDT)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 9398C2380A;
	Wed, 28 Oct 2015 13:59:44 -0400 (EDT)
In-Reply-To: <xmqqk2rj8kf5.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
	message of "Mon, 21 Sep 2015 15:41:34 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: AB8D5EE8-7D9D-11E5-AD82-6BD26AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280387>

Junio C Hamano <gitster@pobox.com> writes:

> Looks like there were mostly editorial niggles and no fundamental
> flaws in the design of the patch; it is somewhat a shame to make all
> the efforts go to waste.  Will we be seeing an update soon?

Second ping as I am going through the what's cooking reports and
trying to decide which topics listed in [Stalled] state need to be
discarded from my tree.

Not that my dropping a topic from 'pu' means very much (a dropped
topic can still be submitted and requeued after all), even if you
are no longer interested on the topic, hearing from you would help
others who may be interested in helping the topic to completion.

Thanks.
