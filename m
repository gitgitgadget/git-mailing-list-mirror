From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v13 4/8] bisect: introduce support for --no-checkout
 option.
Date: Tue, 02 Aug 2011 15:05:37 -0700
Message-ID: <7vsjpjcvv2.fsf@alter.siamese.dyndns.org>
References: <1312284545-2426-1-git-send-email-jon.seymour@gmail.com>
 <1312284545-2426-5-git-send-email-jon.seymour@gmail.com>
 <7vr553elsd.fsf@alter.siamese.dyndns.org>
 <CAH3Anrrf5aZMEH8KmKtvdaRf=D9fb6OVRJN+VjGM8Cd2wV6rnA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, chriscool@tuxfamily.org, j6t@kdbg.org,
	jnareb@gmail.com
To: Jon Seymour <jon.seymour@gmail.com>
X-From: git-owner@vger.kernel.org Wed Aug 03 00:05:48 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QoN5t-0007Z7-UQ
	for gcvg-git-2@lo.gmane.org; Wed, 03 Aug 2011 00:05:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755385Ab1HBWFl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Aug 2011 18:05:41 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:46796 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755390Ab1HBWFk (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Aug 2011 18:05:40 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C304C4F57;
	Tue,  2 Aug 2011 18:05:39 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=PJcqOfggjAbmeHVM3qJ0o1ycnos=; b=VKp4JU
	sl5FmjaUO7gUgh/bGQm036+B7M+WnLNO+TvEcDCQaTDelUlEeOf5zYXqkzwWYuAz
	nYC0oQsHWQavO/h+wj7r55X+cxg4EJ9kma6mdaaFN3rcgj1GtMl1aW9KU6ndxkbQ
	4Iat/+5FmVP7XeeeEvRb8D+Kji6EOn+x/YjCY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=RDU7wui3EccCGc+DP1Uglc8kAN7Fm7Px
	+m0DpHwLj82PgaQ0+Ae+7DR1zeaTq/1/agF12b4B0EtMIj1z8TZmtUhNkiCbIb9h
	awG96oEHrHkekkmmekOMzZsICKN632pJOkMptcxnGg77Rt2epswK/jcuPM4GLL7z
	QW//MnvEgLY=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id BA5C74F56;
	Tue,  2 Aug 2011 18:05:39 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 4F73E4F55; Tue,  2 Aug 2011
 18:05:39 -0400 (EDT)
In-Reply-To: <CAH3Anrrf5aZMEH8KmKtvdaRf=D9fb6OVRJN+VjGM8Cd2wV6rnA@mail.gmail.com> (Jon
 Seymour's message of "Wed, 3 Aug 2011 07:24:27 +1000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 8E97F5B4-BD53-11E0-B507-1DC62E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178517>

Jon Seymour <jon.seymour@gmail.com> writes:

>> I think this is a regression from naming perspective from the previous
>> round. You would be either the normal (checkout) mode or no-checkout mode,
>> and honestly, --no-checkout would be understood by anybody while update-ref
>> would be understood only by Gitz.
>>
>
> Is it relevant here that --bisect-mode here is on bisect--helper which
> is really part of the plumbing and unlikely to be used by anything
> other than git's own porcelain?

Ah, Ok, that is what I missed. I also was scratching my head after seeing
that there was not much change in the proposed log messages from the
earlier round.
