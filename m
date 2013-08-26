From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 0/3] fix interactive rebase short SHA-1 collision bug
Date: Mon, 26 Aug 2013 00:19:22 -0700
Message-ID: <xmqqbo4kkjgl.fsf@gitster.dls.corp.google.com>
References: <1377303042-50868-1-git-send-email-sunshine@sunshineco.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Mon Aug 26 09:19:30 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VDr5F-0000SU-CW
	for gcvg-git-2@plane.gmane.org; Mon, 26 Aug 2013 09:19:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756368Ab3HZHTZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 Aug 2013 03:19:25 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:40489 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756198Ab3HZHTY (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Aug 2013 03:19:24 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8556C38203;
	Mon, 26 Aug 2013 07:19:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=QbgzDdeFzEjmV2NpJ1bR+6raJXU=; b=XP16ft
	usharDsQSZPoZ49t/iU7T9gnHPf31i2uHJmhrbgl7ml5L4svspDlbOsuwJg20twX
	yPluOd5g+JbOmC3MUZP64q411siZ32R146nwBv9UGiG6ez9KiXOWJFXukY7ifTcT
	44gqjv/1Q15yhP8HJdIud6lxUDoZMb4QrKDKk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=BFxquifxbJc4RWho3vkYxZICl2YaN2jB
	NEh2jmuFaqXMBLZG/G3UhRW/QSaOmu3Z9/cDH86kPvlXVDWLjd0xJfWooxwEtNI2
	hkHBPQdasrZiPEIBLMc+NwxFi5bAJbSAI5rDDvFEP22k+FUQHSqhxX0rCP+HJoXD
	flPePvsxkTI=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 79E8138202;
	Mon, 26 Aug 2013 07:19:24 +0000 (UTC)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id DB28E38200;
	Mon, 26 Aug 2013 07:19:23 +0000 (UTC)
In-Reply-To: <1377303042-50868-1-git-send-email-sunshine@sunshineco.com> (Eric
	Sunshine's message of "Fri, 23 Aug 2013 20:10:39 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: D5726DB0-0E1F-11E3-8883-CA9B8506CD1E-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232981>

Eric Sunshine <sunshine@sunshineco.com> writes:

> ... when 'next' is ready to be rewound after 1.8.4
> is released, a replacement to the original series should be sent with
> all the incremental patches squashed in.

It was more like "could, if you want to help us keep clean history
going forward", rather than "should" ;-) Thanks for resending.

I've locally queued this series after seeing the end-result matches
what has been cooking.

Traditionally we waited for a few days after a release to see if we
do not receive regression reports that require us to issue brown
paper bag fixes before rewinding "next" and opening a new cycle. I
am hoping that it will happen in a few days.

My responses may be slower than usual today (i.e. Monday 26th), as I
would need to be sitting in dentist's for a few hours.
