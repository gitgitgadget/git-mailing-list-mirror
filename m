From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v4 0/4] Ensure that we can build without libgen.h
Date: Tue, 12 Jan 2016 18:56:25 -0800
Message-ID: <xmqq7fjeqjae.fsf@gitster.mtv.corp.google.com>
References: <cover.1452536924.git.johannes.schindelin@gmx.de>
	<cover.1452585382.git.johannes.schindelin@gmx.de>
	<56959DFA.9000704@ramsayjones.plus.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>,
	git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>
To: Ramsay Jones <ramsay@ramsayjones.plus.com>
X-From: git-owner@vger.kernel.org Wed Jan 13 03:56:33 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aJBbs-0001er-BM
	for gcvg-git-2@plane.gmane.org; Wed, 13 Jan 2016 03:56:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753443AbcAMC43 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Jan 2016 21:56:29 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:57083 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752740AbcAMC42 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Jan 2016 21:56:28 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 86BB53BA0E;
	Tue, 12 Jan 2016 21:56:27 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=zv3naUgxAnPZRp6Wq6eSgzTUvTU=; b=eEaEM+
	PQPlmJQ8BE8fjTOQQcj3eAY278JOclYc5XFR6m1lIPqo4aKj0KZnCShAqDyI+NzN
	PIB01ex7iuGkCP9gFk9nO4GqHRZ2ecqDNwG9XNk29Uz2++owHZ6l9ZQScUCJyRix
	FB3kcl272fGDDUJ5WM9VoehIx07zfNEzIhWqQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Wt8Ci5rb7ZffnfHRBYGtb8eZBCWre3Fb
	MeTuJfdpkFPLLecirZTgOs8at8yNLhkun7aMtxsUyVV6ObSO913wwwbBoS8CTOEc
	kIwOSU/8IabNC21kRv05+31IR7+83J8uXDNnSGiCRmvvqpvMHaMHSGSnDWk7NzfY
	KzEjWf46yxY=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 7CC083BA0D;
	Tue, 12 Jan 2016 21:56:27 -0500 (EST)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id F27013BA0C;
	Tue, 12 Jan 2016 21:56:26 -0500 (EST)
In-Reply-To: <56959DFA.9000704@ramsayjones.plus.com> (Ramsay Jones's message
	of "Wed, 13 Jan 2016 00:44:42 +0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 3D116B04-B9A1-11E5-989B-6BD26AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283871>

Ramsay Jones <ramsay@ramsayjones.plus.com> writes:

> Hi Johannes,
> ...
> I was somewhat disappointed that you ignored the implementation of
> gitbasename() and gitdirname() that was included in the test-libgen.c
> file that I sent you. I had hoped they would be (at worst) a good starting
> point if you found them to be lacking for your use case (ie. for the
> 64-bit versions of MSVC/MinGW).

Sorry to hear that, but the 'next' branch has just been rewound and
rebuilt with this series, so it is too late to replace them with
another round of reroll.  It however is never too late to improve
with incremental updates, though, so please work together and send
in a follow-up patch series as/if needed.

Thanks.
