From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/5] Documentation/git-diff.txt improvements
Date: Mon, 29 Apr 2013 11:46:27 -0700
Message-ID: <7vip35i398.fsf@alter.siamese.dyndns.org>
References: <1366821216-20868-1-git-send-email-artagnon@gmail.com>
	<CALkWK0nVZHwSMS_gtisiAguNhAMnDpdWmAtz_OgzP93YZtYfHQ@mail.gmail.com>
	<7v38u9l2jk.fsf@alter.siamese.dyndns.org>
	<CALkWK0=aF2H4b9L32zvFQweYrzsJ-ZoBZ59TcECEasyy5TyvmQ@mail.gmail.com>
	<7va9ohjkv7.fsf@alter.siamese.dyndns.org>
	<CALkWK0n2V3LE6Vt2YQd5AKFkv5h0os=7MZA2GqwcrPQ1vEvE+Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Mon Apr 29 20:47:00 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UWt61-0000ds-EA
	for gcvg-git-2@plane.gmane.org; Mon, 29 Apr 2013 20:46:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758778Ab3D2Sqf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Apr 2013 14:46:35 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:57966 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758773Ab3D2Sqd (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Apr 2013 14:46:33 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3DE9B15B42;
	Mon, 29 Apr 2013 18:46:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=rGP3s0b5BgoO9c/UHW3Fb5Cgj4o=; b=FVKvbR
	AQ+ZO5Vc77wNmVHjXmmN/quNZmMsYpF+f61cqu6lI9cIz5uDoo4do+6WN6TI6DF3
	AmQ8eYKlbtOJ6tvCg1SrdXzA7wSEnVBT/+QW2BwsSxcSn0ghAEQewP9rGWoPXShA
	oLjO27kdXpZtA9NXXSU21CjKBg1J2HtMyxTUc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=pt/hFrXRExMNjpg/8YvlQqGZ0lGFRdYk
	uW2/JOj0vxZIUjKSugChJiC9/+ZWyhMnN1zUMx1SLsofrafIelekcyRSK9dS58sx
	BUdByd6DEQmvkMSAgT0mSLyNOqbsixMyriIE1MqMXZU9fABuz2H7beQYO6uDhkOa
	hETeNkEM1Q4=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 342CD15B41;
	Mon, 29 Apr 2013 18:46:33 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id AA31515B37;
	Mon, 29 Apr 2013 18:46:32 +0000 (UTC)
In-Reply-To: <CALkWK0n2V3LE6Vt2YQd5AKFkv5h0os=7MZA2GqwcrPQ1vEvE+Q@mail.gmail.com>
	(Ramkumar Ramachandra's message of "Mon, 29 Apr 2013 23:58:41 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 1C916104-B0FD-11E2-886D-8D009ADAE8A5-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222845>

Ramkumar Ramachandra <artagnon@gmail.com> writes:

> Junio C Hamano wrote:
>> As far as I am concerned, there is no A~B issue.
>
> You don't have to remind me about how hostile you are towards new
> proposals.  I already know.

That's not "hostile" or "new".  I only express strong doubt against
"ideas" (or non-"ideas") that do not make sense to me.

They may be valid and merely are not well explained, or they may be
total nonsense.  The latter does not deserve time from people on
this list, but the former needs to be better explained.
