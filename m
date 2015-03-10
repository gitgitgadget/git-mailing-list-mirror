From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Clarification required for microproject "Add configuration options for some commonly used command-line options"
Date: Tue, 10 Mar 2015 16:43:55 -0700
Message-ID: <xmqq7fuoxvt0.fsf@gitster.dls.corp.google.com>
References: <54FF7E63.3030902@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git <git@vger.kernel.org>
To: Koosha Khajehmoogahi <koosha.khajeh@gmail.com>
X-From: git-owner@vger.kernel.org Wed Mar 11 00:44:04 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YVToi-0000SD-0V
	for gcvg-git-2@plane.gmane.org; Wed, 11 Mar 2015 00:44:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751878AbbCJXn6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Mar 2015 19:43:58 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:56920 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750855AbbCJXn5 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Mar 2015 19:43:57 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 0FCA43F809;
	Tue, 10 Mar 2015 19:43:57 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=FswfoBkmPga0KbVG3enbFyPUBY8=; b=UBD2c+
	pXSKQ/7d/J97rgp/Ac/68xffhmsLvM2CZ7BalFmVmm5v1rQBCpE+xfewmcx8DBPO
	LKRczMEBqjD3GpJZZb+XIZZ508t+zIFMFHT790qGkj+A2wKnGomzKY1gS90c4FWo
	lwD5BLkjLpax3343NtSzf0W+Dd7VzoqC+IJpg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=WRkHM+wX/q+xlfro1kdX67iLWGzQshZH
	ImzkH3hzyi+gjyCNbQ/oJ/Y7L616AUNr+HU7LqSMStRK3iCMyuZByRBeKxR0i70V
	mIbI5Xf12PaQSZyokM4J5uA2egGIIT2dTCmGGFllX360xzd0sDeGVix4JExT0d8G
	ZXRzTIbr8Pc=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 079BC3F807;
	Tue, 10 Mar 2015 19:43:57 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 7A2993F806;
	Tue, 10 Mar 2015 19:43:56 -0400 (EDT)
In-Reply-To: <54FF7E63.3030902@gmail.com> (Koosha Khajehmoogahi's message of
	"Wed, 11 Mar 2015 00:29:39 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 513467EA-C77F-11E4-B981-29999F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265285>

Koosha Khajehmoogahi <koosha.khajeh@gmail.com> writes:

> Does this microproject require the feature to be a generic one for every
> possible command or should it be limited to some particular commands?

The Micro is written lazily so that by writing that entry once, it
can tell many students to work on many different Git subcommands and
their options in parallel ;-)

"generic for every possible" is very hard to do it well and make it
useful, and is unsuitably big undertaking for a microproject, I
would think.
